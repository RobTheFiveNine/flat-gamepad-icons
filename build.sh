declare -a dpis=("50" "96" "150" "300")

ids=$(grep -oP 'id="(generic|xb|ps|switch|kb)_.+?"' icons.svg | cut -d '"' -f 2)

mkdir -p build
rm -rf build/*

for dpi in "${dpis[@]}"
do
    mkdir -p "build/${dpi}dpi"
    while read id; do
        echo "Building $id @ $dpi dpi..."
        inkscape --export-id="$id" --export-id-only -d "$dpi" --export-type=png -o "build/${dpi}dpi/${id}.png" icons.svg 2> /dev/null
    done <<< "$ids"
done

cp LICENSE.dist.txt build/LICENSE.txt

echo "Compressing to flat-gamepad-icons.zip..."
rm -f flat-gamepad-icons.zip
cd build
zip -q -r -9 ../flat-gamepad-icons.zip *
cd ..


echo "Done."
