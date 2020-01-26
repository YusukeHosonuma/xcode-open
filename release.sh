# =====================================
# Release to GitHub and Homebrew (self-hosted)
#
# (Need GitHub Access Token via environment variable 'GITHUB_TOKEN')
# =====================================

# =====================================
# Note:
#
# Bellow commands are helpful when this release script is failed.
#
# Github:
# ```
# $ git tag -d {TAG}; git push origin :{TAG}
# ```
#
# Fomula:
# ```
# $ cd {YusukeHosonuma/homebrew-xcode-open}
# $ git pull
# $ git reset --hard HEAD^
# $ git push -f
# ```
# =====================================

lib_name="xcode-open"
filename="${lib_name}.tar.gz"

tag=$1
if [ -s $tag ]; then
    echo "Usage: ./release.sh {VERSION}"
fi

#
# Release buil and archive
#
make release-build

#
# Archive
#
zip -j $filename ".build/release/$lib_name"

#
# Release to GitHub.com
#
git tag $tag
git push origin $tag

# create release
github-release release \
    --user YusukeHosonuma \
    --repo XcodeOpen \
    --tag $tag

# upload binary
github-release upload \
    --user YusukeHosonuma \
    --repo XcodeOpen \
    --tag $tag \
    --name $filename \
    --file $filename
#
# calc sha256
#
sha256=$(shasum -a 256 $filename | cut -d ' ' -f 1)

#
# update formula
#
formula_path="$lib_name.rb"
formula_url="https://api.github.com/repos/YusukeHosonuma/homebrew-$lib_name/contents/$formula_path"
sha=`curl GET $formula_url | jq -r '.sha'`
content_encoded=`cat formula.rb.tmpl | sed -e "s/{{TAG}}/$tag/" | sed -e "s/{{SHA256}}/$sha256/" | openssl enc -e -base64 | tr -d '\n '`

commit_message="Update version to $tag"

curl -i -X PUT $formula_url \
   -H "Content-Type:application/json" \
   -H "Authorization:token $GITHUB_TOKEN" \
   -d \
"{
 \"path\":\"$formula_path\",
 \"sha\":\"$sha\",
 \"content\":\"$content_encoded\",
 \"message\":\"$commit_message\"
}"

#
# Test
#
# TODO: `brew upgrade xcode-open` are failed.
# ```
# Warning: xcode-open 1.2.0 already installed
# + rm xcode-open.tar.gz
# ```
#
# brew update
# brew upgrade $lib_name

#
# Clean
#
rm $filename
