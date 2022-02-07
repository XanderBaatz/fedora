#!/bin/sh

# wget link

# make template function
make_temp (){
  cat > ${HOME}/Templates/${1}.sh << EOF
  ${2}
  EOF
}

# bash script template
cat > ${HOME}/Templates/script.sh << EOF
#!/bin/bash

EOF
chmod u+x ${HOME}/Templates/script.sh

# 
