declare -a dpis=("50" "96" "150" "300")

ids=$(grep -oP 'id="(generic|xb|ps|switch)_.+?"' icons.svg | cut -d '"' -f 2)

mkdir -p build

for dpi in "${dpis[@]}"
do
    while read id; do
        echo "Building $id @ $dpi dpi..."
        inkscape --export-id="$id" --export-id-only -d "$dpi" --export-type=png -o "build/${id}.${dpi}dpi.png" icons.svg 2> /dev/null
    done <<< "$ids"
done
