set foldmethod=expr
set foldexpr=getline(v\:lnum)=~'^snippet.*'.(matchend(getline(v\:lnum),'^endsnippet'))\:'='
