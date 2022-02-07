#!/bin/sh

# wget link

# make template function
make_temp (){
  cat > ${HOME}/Templates/${1} <<EOF
${2}
EOF
}

# bash script template
make_temp "script.sh" "#!/bin/bash
"
