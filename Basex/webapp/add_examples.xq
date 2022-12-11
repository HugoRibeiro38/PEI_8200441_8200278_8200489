(:Adds the files contained in this folder to the Database:)

db:add("Workers","webapp/XSD/Examples/") 

(:To delete all files, in case we want to replace:)
(: db:delete("Workers","")  :)

(: Get files in path
let $root := 'webapp/XSD/Examples/'
for $file in file:list($root, true(), '*.xml')
let $path := $root || $file
where file:size($path) > 1
return file:read-text($path)
:)