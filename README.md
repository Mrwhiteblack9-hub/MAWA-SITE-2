cd "$BASE"
zip -r "../$ZIPNAME" . > /dev/null
cd ..

echo "Done. Project created in '$BASE' and zipped as '$ZIPNAME'."
echo "Next steps:"
echo "  cd $BASE"
echo "  npm install"
echo "  npx next dev"
echo ""
echo "Replace public/banner.svg and public/logo.svg with your real images (banner.jpg, logo.jpg) if available."
