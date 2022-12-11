module namespace page = 'http://basex.org/examples/web-page';

declare namespace random ="http://basex.org/modules/random" ;

declare %updating
  %rest:path("add")
  function page:add()
{
 update:output("TEST ADD")
};