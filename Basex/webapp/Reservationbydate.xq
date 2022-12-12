module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";

(:Apresentar as marcações associadas a um perito para o dia atual;:)
declare
%rest:path("/Reservationbydate")
%rest:GET
%rest:form-param("expertiseName","{$expertiseName}", "(no expertiseName)")
%rest:form-param("date","{$date}", "(no date)")

function page:Reservationbydate($expertiseName as xs:string,$date as xs:string){
  if(($expertiseName!= "(no expertiseName)") and ($date != "(no date)"))then(
    let $reservations := db:open("NBCar")//reservations[./expertiseName/text() = $expertiseName]
    let $reservations_bydate := $reservations[.//date/text() eq $date]
    return $reservations_bydate
    
  )
    
  
};
  