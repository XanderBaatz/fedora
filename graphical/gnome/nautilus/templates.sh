#!/bin/sh

# wget link

# template location
template_dir="${HOME}/Templates"

# make template function
make_temp (){
  cat > ${template_dir}/${1} <<EOF
${2}
EOF
}

# bash script template
script_name="script.sh"
make_temp "${script_name}" '#!/bin/bash
'
chmod u+x ${template_dir}/${script_name}

# text file template
make_temp "document.txt"

# open document template
make_temp "open-document.odt"
