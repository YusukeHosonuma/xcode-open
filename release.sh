lib_name="xcode-open"
tag=$1
token=$2
export GITHUB_TOKEN=$token

filename="${tag}.tar.gz"

# git tag
git tag $tag
git push origin $tag

# calc sha256
curl -LOk "https://github.com/YusukeHosonuma/XcodeOpen/archive/${filename}"
sha256=$(shasum -a 256 $filename | cut -d ' ' -f 1)
rm $filename

# update formula
formula_path="$lib_name.rb"
formula_url="https://api.github.com/repos/YusukeHosonuma/homebrew-$lib_name/contents/$formula_path"
sha=`curl GET $formula_url | jq -r '.sha'`
content_encoded=`cat formula.rb.tmpl | sed -e "s/{{TAG}}/$tag/" | sed -e "s/{{SHA256}}/$sha256/" | openssl enc -e -base64 | tr -d '\n '`

commit_message="Update version to $tag"

curl -i -X PUT $formula_url \
   -H "Content-Type:application/json" \
   -H "Authorization:token $token" \
   -d \
"{
 \"path\":\"$formula_path\",
 \"sha\":\"$sha\",
 \"content\":\"$content_encoded\",
 \"message\":\"$commit_message\"
}"

# brew upgrade
brew upgrade $lib_name
zip -j $lib_name.zip /usr/local/bin/$lib_name

# Github release
github-release release \
    --user YusukeHosonuma \
    --repo XcodeOpen \
    --tag $tag

# Github upload
github-release upload \
    --user YusukeHosonuma \
    --repo XcodeOpen \
    --tag $tag \
    --name $lib_name.zip \
    --file $lib_name.zip

rm $lib_name.zip
