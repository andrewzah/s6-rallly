rallly_version := '10e4aaedfb5e1d8c0974ac6dbe4e1324c83f987a'

build rv=rallly_version:
  #!/bin/sh
  short_ver=$(echo '{{rv}}' | cut -c1-7)

  docker build . \
    --build-arg "RALLLY_VERSION={{rv}}" \
    -t "andrewzah/rallly:${short_ver}-alpine3.15"
