declare -a dpis=("50" "96" "150" "300")

ids=$(grep -oP 'id="(generic|xb|ps|switch|kb)_.+?"' icons.svg | cut -d '"' -f 2)

mkdir -p build
rm build/*

for dpi in "${dpis[@]}"
do
    while read id; do
        echo "Building $id @ $dpi dpi..."
        inkscape --export-id="$id" --export-id-only -d "$dpi" --export-type=png -o "build/${id}.${dpi}dpi.png" icons.svg 2> /dev/null
    done <<< "$ids"
done

cp LICENSE.dist.txt build/LICENSE.txt

echo "Compressing to flat-gamepad-icons.zip..."
zip -q -j -9 flat-gamepad-icons.zip build/*


echo "Done."
