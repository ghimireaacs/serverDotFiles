# Any alias here must be referenced in a single file for clarity.
# File ->  '../aliases/functioned.alias'



# Batcat / bat

if command -v bat >/dev/null 2>&1; then
  export BAT_BIN="bat"
elif command -v batcat >/dev/null 2>&1; then
  export BAT_BIN="batcat"
fi
