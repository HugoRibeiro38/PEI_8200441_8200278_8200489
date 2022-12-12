module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;
declare default element namespace "http://www.NCar.com/";
declare namespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace c ="http://www.NCar.com/commonTypes.xsd";

declare
%rest:path("/getDatafromExpertise")
%rest:GET
%rest:form-param("code","{$code}", "(no code)")

(:• Consultar os dados de uma peritagem.:)
function page:realizedExpertises($code){
  if($code != "(no code)")then(
    let $expertise := db:open("NBCar")//expertises//expertise[.//code/text() = $code]
    return $expertise
  )else(
    let $mensagem_erro := "Code vazio"
    return  $mensagem_erro
  )
};