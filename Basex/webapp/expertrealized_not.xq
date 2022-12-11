module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";


declare function page:Expertbydate($expertiseName as xs:string,$date as xs:string){
  if(not(empty($expertiseName)) and not(empty($date)))then(
    let $expertise := db:open("NBCar")//expertises[./expertiseName/text() eq $expertiseName]
    let $bydate := $expertise[.//date/text() eq $date]
    return $bydate
    
  )
    
  
};

declare
%rest:path("/RealizedExpertises")
%rest:GET
%rest:form-param("type","{$type}", "(no type)")
%rest:form-param("expertiseName","{$expertiseName}", "(no expertiseName)")
%rest:form-param("date","{$date}", "(no date)")

function page:realizedExpertises($expertiseName as xs:string,$type as xs:string,$date as xs:string){
  if($expertiseName != "(no expertiseName)" and ($date != "(no date)") and ($type != "(no type)"))then(
    
    if($type = "not_realized")then(
      let $expertise := page:Expertbydate($expertiseName,$date)//expertise[.//status/text() != ""]
      return $expertise
    )else(
      if($type = "realized")then(
         let $not_realizedexpertise := page:Expertbydate($expertiseName,$date)//expertise[.//status/text() != ""]
         for $realizedexpertise in page:Expertbydate($expertiseName,$date)//expertise
         where $realizedexpertise[. != $not_realizedexpertise]
      return $realizedexpertise
      )else(
        let $mensagem_erro := "Type not recognized"
        return $mensagem_erro
      )
    )
    
    
    
)else(
  let $mensagem := "Algum campo sem dados."
  return $mensagem
)
};