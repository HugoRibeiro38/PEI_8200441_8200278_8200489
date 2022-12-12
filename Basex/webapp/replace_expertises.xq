module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";



declare function page:getCountExpertise($expertName as item()){
  for $expert_IDS in  db:open("Workers")/expert/ID/text()
  where ($expertName/text()[. = $expert_IDS])
  
    return count($expert_IDS)
};
declare function page:getCountPartnerName($partnerName as item()){
  for $partner_IDS in  db:open("Workers")/partner/ID/text()
  where ($partnerName/text()[. = $partner_IDS])
    return count($partner_IDS)
};

declare function page:CodeEquals($codeToCheck as item()){
 let $db := db:open("NBCar")//expertise/code
 return if(count($db)=0)then(
   0
 )else(
   for $code in $db
  where ($codeToCheck/text()[. = $code/text()])
    return (count($code))
 )
 
  
};

(:A substituição de um documento correspondente às peritagens de um determinado dia;:)
 declare %updating
  %rest:path("replace/Expertise")
  %rest:PUT("{$xml}")
  %rest:consumes('application/xml')
function page:ReplaceExpertise($xml as item()){
  
   let $xsd_expertise := "XSD_XML/expertises.xsd"
  let $expertiseNameCount := page:getCountExpertise($xml//expertiseName) 
  let $partnerNameCount := page:getCountPartnerName($xml//partnerName) 
  let $code := page:CodeEquals($xml//code)
  
(:Comparar atraves do expertiseName e data:)
    return if($expertiseNameCount =1 and 
$partnerNameCount=1)then(
   for $expertises in db:open("NBCar")//expertises
   where ($xml//expertiseName/text()[. = $expertises//expertiseName/text()]
 )
 let $expertises_byDate := $expertises[.//date/text() eq $xml//date/text()]
 return replace node $expertises_byDate with $xml,update:output("Alterado Com sucesso") 
)else(
  update:output("Nao foi possivel alterar o ficheiro")
)
  
 
};