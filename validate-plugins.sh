#!/bin/bash

echo "Validating plugins..."

docker run --rm \
  -v $(pwd):/work \
  -w /work \
  jenkins/jenkins:lts-jdk17 \
  bash -c '
    rm -rf plugins && mkdir plugins
    jenkins-plugin-cli \
      --plugin-file plugins.txt \
      --latest \
      --plugin-download-directory plugins

    for f in plugins/*.jpi; do
      name=$(basename "$f" .jpi)
      version=$(unzip -p "$f" META-INF/MANIFEST.MF | grep Plugin-Version | awk "{print \$2}")
      echo "$name:$version"
    done
    rm -rf plugins
  ' > plugins-pinned.txt

echo "Validation successful ✅"