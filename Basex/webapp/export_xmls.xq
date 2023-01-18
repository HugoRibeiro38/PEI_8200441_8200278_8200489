module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";

declare
function page:refactor(){
  let $expertises := db:open("NBCar")//expertises
  
  for $expertise in $expertises//expertise
  return (
    <expertise>
    <appointmentId>{$expertise/code/text()}</appointmentId>
    <status>{if(not(string($expertise/status/*)))then 1 else 0} </status>
    <partner>{$expertises/partnerName/text()}</partner>
    <expertiseName>{$expertises/expertiseName/text()}</expertiseName>
   </expertise>
  )
  
};

declare
%rest:path("export_xml/expertises")
%rest:GET
function page:export_xml_expertises(){
db:open("NBCar")//expertises
    
};


declare
%rest:path("export_xml/reservations")
%rest:GET
function page:export_xml_reservations(){
     db:open("NBCar")/reservations
};

declare
%rest:path("export_xml/cars")
%rest:GET
function page:export_xml_cars(){
     db:open("NBCar")//vehicleInfo
};