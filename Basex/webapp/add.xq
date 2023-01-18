module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";

declare function page:getCountExpertise($expertiseName as item()){
  for $expert_IDS in  db:open("Workers")/expert/ID/text()
  where ($expertiseName/text()[. = $expert_IDS])
  
    return count($expert_IDS)
};
declare function page:getCountPartnerName($partnerName as item()){
  for $partner_IDS in  db:open("Workers")/partner/ID/text()
  where ($partnerName/text()[. = $partner_IDS])
    return count($partner_IDS)
};

declare function page:CodeEqualsExpertise($codeToCheck as item()){
 let $db := db:open("NBCar")//expertise/code
 return if(count($db)=0)then(
   0
 )else(
   for $code in $db
  where ($codeToCheck/text()[. = $code/text()])
    return (count($code))
 )
 
  
};


declare function page:CodeEqualsReservation($codeToCheck as item()){
 let $db := db:open("NBCar")//reservation/code
 return if(count($db)=0)then(
   0
 )else(
   for $code in $db
  where ($codeToCheck/text()[. = $code/text()])
    return (count($code))
 )
 
  
};


(: A submissão de documentos correspondentes às peritagens realizadas num determinado dia. A 
API deverá validar o documento XML submetido e validar se o código, parceiro e 
perito existem;
:)
declare %updating
  %rest:path("add/Expertises")
  %rest:POST("{$xml}")
  %rest:consumes('application/xml')
function page:addExpertise($xml as item())
{
  let $xsd_expertise := "XSD_XML/expertises.xsd"
  let $expertiseNameCount := page:getCountExpertise($xml//expertiseName) 
  let $partnerNameCount := page:getCountPartnerName($xml//partnerName) 
  let $code := page:CodeEqualsExpertise($xml//code)
 

(:Codigo Marcacao não existe:)
 return if($expertiseNameCount =1 and 
$partnerNameCount=1 and $code =0)then(
  validate:xsd($xml,$xsd_expertise),db:add("NBCar",$xml,"expertise"),
 update:output("Adicionado Com Sucesso a DB NBCar")
)else( update:output("Erro ao adicionar")
)

  
};
 
(:A submissão de documentos correspondentes às peritagens realizadas num determinado dia. A 
API deverá validar o documento XML submetido e validar se o código, parceiro e 
perito existem;:)
 
 declare %updating
  %rest:path("add/Reservation")
  %rest:POST("{$xml}")
  %rest:consumes('application/xml')
function page:addReservation($xml as item())
{
  let $xsd_reservation := "XSD_XML/reservations.xsd"
   let $expertiseNameCount := page:getCountExpertise($xml//expertiseName) 
  let $partnerNameCount := page:getCountPartnerName($xml//partnerName) 
  let $code := page:CodeEqualsReservation($xml//code)
 

  (:Codigo Marcacao não existe:)
 return if((: $expertiseNameCount =1 and :)  
$partnerNameCount=1 and $code =0)then(
  validate:xsd($xml,$xsd_reservation),db:add("NBCar",$xml,"reservation"),
 update:output("Adicionado Com Sucesso a DB NBCar")
)else(
   update:output("Erro ao adicionar")
)
  
};
 