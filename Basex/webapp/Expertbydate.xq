module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";


declare
%rest:path("/Expertbydate")
%rest:GET
%rest:form-param("expertiseName","{$expertiseName}", "(no expertiseName)")
%rest:form-param("date","{$date}", "(no date)")

function page:Expertbydate($expertiseName as xs:string,$date as xs:string){
  if(not(empty($expertiseName)) and not(empty($date)))then(
    let $expertise := db:open("NBCar")//reservations[./expertiseName/text() eq $expertiseName]
    let $bydate := $expertise[.//date/text() eq $date]
    return $bydate
    
  )
    
  
};
  