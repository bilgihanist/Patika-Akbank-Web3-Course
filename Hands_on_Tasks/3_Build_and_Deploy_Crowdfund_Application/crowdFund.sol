// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract CrowdFund {
        //Events for each function = her fonksiyon için olaylar.
    event Launch(uint id, address indexed creator, uint goal, uint32 startAt, uint32 endAt );
    event Cancel(uint id);
    event Pledge(uint indexed id,address indexed caller, uint amount);
    event Unpledge(uint indexed id,address indexed caller, uint amount);
    event Claim(uint id);
    event Refund(uint indexed id, address indexed caller, uint amount);  //birden fazla geri ödeme olabilir.

        // the struct that it holds the campaign information = kampanya bilgilerini tuttuğu yapı
    struct Campaign { 
        address creator;    // creator of campaign
        uint goal;          // Amount of tokens to raise = Yükseltilecek jeton miktarı
        uint pledged;       // Total amount pledged = Rehin verilen toplam miktar.
        uint32 startAt;     // Timestamp of start of campaign = Kampanyanın başlangıç zaman damgası
        uint32 endAt;       // Timestamp of end of campaign // Kampanyanın bitiş zaman damgası
        bool claimed;       // True if goal was reached and creator has claimed the tokens. = hedefe uaşıldıysa ve içerik oluşturucu jetonları talep ettiyse doğrudur.

    }


    IERC20 public immutable token;  //jeton değişmeyeceğinden değişmez yapılır.
    uint public count;              //Total count of campaigns created. = Oluşturulan toplam kampanya sayısı   
    mapping(uint => Campaign) public campaigns;      // list of campaigns with indexes = indexli kampanyaların listesi
    mapping(uint => mapping(address => uint)) public pledgedAmount;     //Mapping from id to Campaign = Kimlikten Kampanyaya eşleme
        // Mapping from campaign id => pledger => amount pledged = Kampanya kimliğinden eşleme => rehin veren => taahhüt edilen miktar


    constructor(address _token){  //inject the token via constructor = belirteci yapıcı aracılığıyla enjekte et
        token =IERC20(_token);
    }

    function launch(uint _goal, uint32 _startAt, uint32 _endAt) external { //This function provides people can launch campaign via Campaign struct = Bu işlev, kişilerin Kampanya yapısı aracılığıyla kampanya başlatmasını sağlar.
            //Check the time space is available or not = zaman boşluğunun müsait olup olmadığını kontrol et.
        require(_startAt >= block.timestamp, "start at < Now" );
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");

            //Create new campaign and add to campaigns = yeni kampanya oluştur ve kampanyalara ekle
        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint _id) external { //function for canceling campaign = kampanya iptal etme işlevi
        Campaign memory campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "not creator");  // Check msg.sender creater or not => Only creator of the campaign can cancel it  = oluşturucuyu kontrol edin veya etmeyin  yalnızca kampanyayı oluşturan kişi iptal edebilir.
        require(block.timestamp < campaign.startAt, "started"); // Check the campaign started or not // kampanyanın başlatılıp başlatılmadığını kontrol edin.
        delete campaigns[_id]; // Delete the campaign info from campaigns = kampanya bilgilerini kampanyalardan silin.
        emit Cancel(_id);   // call Cancel event = cancel eventini çağır.
         
    }

         // _id => id of the campaign
         // _amount => amount of the pledge 
    function pledge(uint _id, uint _amount) external { //This function provides users can pledge tokens the campaign with the given parameters = Bu işlev, kullanıcıların verilen parametrelerle kampanya jetonlarını rehin verebilmelerini sağlar.
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");//zaman damgası kampanyaya eşit yada büyükse kampanyanın henüz sona ermemiş olmasınıda zorunlu tutuyoruz 
        require(block.timestamp <= campaign.endAt, "ended"); //block zaman damgasının <= olması kampanya başlatılmamış kullanıcı kampanya için taahhütte bulunuyor.
        campaign.pledged += _amount; /*mevcut olmayan bir kampanya varsa ozman kampanyanın yapısını , taahhüt edilen kampanya noktası + aktarılacak token miktarına eşittir.*/
        pledgedAmount[_id][msg.sender] += _amount; //kampanya başarısız ise kullanıcı jetonlarını geri çekebilmeli, bu nedenle kulancı tarafından bu kampanya içinm taahhüt edilen jeton miktarını kimlikde saklanmalıdır.        // Add the amount of the pledge of the campaign to pledgedAmount
        token.transferFrom(msg.sender, address(this), _amount); //Kampanyanın rehinli değişkenini rehin tutarını ekleyin ve transferFrom ile transfer yapın
        emit Pledge(_id, msg.sender, _amount); //Pledge eventini çağır.
        }

            //This function provides users can get back tokens from the campaign with the given parameters while the campaign is still going  = Bu işlev, kullanıcıların kampanya devam ederken verilen parametrelerle kampanyadan jetonları geri alabilmelerini sağlar.
    function unpledge(uint _id, uint _amount) external {//kimlik taahhütünde dizi kullanıldı çünkü birden fazla kullanıcı aynı kampanyaya girebilir.

        Campaign storage campaign = campaigns[_id]; // kampanyaya girenlerin verilerini saklamalı 
        require(block.timestamp <= campaign.endAt, "ended"); // kullanıcılar taahhüdü iptal edememeli, kampanya sona ermeli
        campaign.pledged -= _amount; // Decreasing the campaing pledge via amount & update pledgedAmount = Tutar yoluyla kampanya taahhüdünün azaltılması ve taahhüt edilen miktarın güncellenmesi
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount); //Send the tokens to user = kullanıcıya token gönder
        emit Unpledge(_id, msg.sender, _amount);// Unpledgeyi çağır.

    }
            //This function provides the creator of the campaign can claim all the tokens that were pledged  = Bu işlev, kampanyanın yaratıcısının taahhüt edilen tüm jetonları talep edebilmesini sağlar.
    function claim(uint _id) external { //kampanya başarılı olursa taahhüt edilen veya daha fazlasını verme
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "not creator"); // yaratıcı oldugun emın olmak zorundayız.
        require(block.timestamp > campaign.endAt, "not ended"); // kampanyanın bitip bimtediğini kontrol et
        require(campaign.pledged  >= campaign.goal, "pledged < goal"); //Pledged must be greator than goal for claiming by creator =Taahhüt, içerik oluşturucu tarafından talep edilmesi için hedeften büyük olmalıdır
        require(!campaign.claimed, "claimed"); // Check already claimed or not = hak talebinde olup olmadığını kontrol et.

        campaign.claimed = true;
        //kampanya yaratıcısı old. bildiğimiz için msg.sender yazarız. (msg.sender'a ulaşmak daha ucuzdur.) durum değişkeninne ulaşmaktan daha ucuz., campaign rehin verildi rehin toplam tutarı tutacak.
        token.transfer(msg.sender, campaign.pledged); //Send tokens to creator

        emit Claim(_id); //call Claim event

    }

    function refund(uint _id) external { //GERİ ÖDEME kampanya başarısız olur yani toplam tutar taahhüt edilen hedeften daha az olursa ozman kullanıcılar geri ödeme alabilecek. = This function created for users can get back their tokens from campaign if the campaign could not reach goal amount
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended"); // Campaign time must be ended for refund   = geri ödeme için kampanya sürsi sonlandırılmalıdır.
        require(campaign.pledged  < campaign.goal, "pledged < goal"); //Campaign pledged must be smaller than goal amount for refund = taahhüt edilen para hedeften az olmalıdır

        uint balance  = pledgedAmount[_id][msg.sender]; //Send tokens to users back
        // balance'yi alın ve resetleyin.(pledgedAmount=Taahhüt edilen miktar, kimlik için = _id, sahib için = msg.sender)
        pledgedAmount[_id][msg.sender]=0;
        //jetonu transfer edeceğiz.jetonu sıfırlamanın nedeni jetonu yeniden aktarmadan önce bakiye yeniden girlşini önlemek.
        token.transfer(msg.sender, balance);

        emit Refund(_id, msg.sender, balance); //call Refund event

    }
}
