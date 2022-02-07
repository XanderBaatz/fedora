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
make_temp "script.sh" "#!/bin/bash
"
chmod u+x

# another template
