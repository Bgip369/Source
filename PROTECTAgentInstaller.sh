#!/bin/sh -e
# ESET PROTECT
# Copyright (c) 1992-2023 ESET, spol. s r.o. All Rights Reserved

cleanup_file="$(mktemp -q)"
finalize()
{
  set +e
  if test -f "$cleanup_file"
  then
    while read f
    do
      rm -f "$f"
    done < "$cleanup_file"
    rm -f "$cleanup_file"
  fi
}

trap 'finalize' HUP INT QUIT TERM EXIT

eraa_server_hostname="av.frt.vn"
eraa_server_port="2222"
eraa_server_company_name=""
eraa_peer_cert_b64="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"
eraa_peer_cert_pwd=""
eraa_ca_cert_b64="MIIEITCCAomgAwIBAgIQNp9wOeLi3KxNJTQO7RHLrDANBgkqhkiG9w0BAQsFADApMScwJQYDVQQDEx5TZXJ2ZXIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMjMxMTE5MTcwMDAwWhcNMzMxMTIwMTcwMDAwWjApMScwJQYDVQQDEx5TZXJ2ZXIgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQC/nrSZHxdyXTknmAwn7H7BFON3E/7JNkMxaUurtkKxjWNJ5CWMTiBP26vAPfWjD7yvAkhHfxrfTE5q8CVt4Jjbqb1YbNAprz81V90yMhZMRTh0+pBxXGl8i2heeWfPM5ccYDAh3DhBs8Ia0eoLS8vKlnJ1OO5v6fW6o9Qtm5J09K/hmjp9oQNCOGnIN6MBJI7sIZQ/vFBP1cwCg/5LomLtZ9fUp45hLgovnTzwa2faBFeerKmXHZLYaouZ4dHDuyc/sdTeWFG2EpQ8oVXUmPwCDZxuzuMz3h1iTO8hBtcps5t4ZWzLU6SInobFflbxbDp6wazaAUYoaSHwaLtoWq/2t97kBOd0zLkcsMu/0oyuLT5GTogFEFIxpyyWqVSw8zFyccxO946VT6cHHEfhDpF/kItYS+AkQ2UuEGc/OdrlZL7Kk7se4gVvXuNRL7kuBX5J63u4ytemAkoL1AAWyexvl21fMGoyrxYUqyXfqvucBJ19AmtCQzi4DheAc7QNAykCAwEAAaNFMEMwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFEgL/3cf+ixN8FlnCCfFqbhrgv08MA0GCSqGSIb3DQEBCwUAA4IBgQCw3iV7tFGgVg49LYcE5v4+HlUe5d6ItLd6VFmAfSHKNGMw/sM0PDYVb9CwWzfDrgM8LnxYgNPbI0Vrb+PlNNExsnuKScGmpXUswQ0d422kqJhko2tfDCjxSD4h/vewv688W1vealOMdTE/wfH6j9NEkWBqyGHtXJsXhPQsH1LPLEOO6MsrpjL5JLldMwdSI0IsfAV8okvLlQOvmNopoMngnmxUmrd1wpGulaWA2oXwI8KigOEr6IDeahB6Qhty537jDpbjSR/He4vFjE90JGvLer9iECSIOG9gYAS/66cpkPA5V1pNyuv7bmDbZxxhtGsI6GaEPRPymtN6iOs1O/4PniAEneJm74zydzivwmjyDgyGDjOCbmCud6/vGu/M60tfZCyayhXqug6hGjERraeq3lwrBEW76U6HlIUXb+Pd8tMlAME2Ca4pmXpC6uxNFBgBZcbLLOssDAH88l9B/LuRNFaIcZPOXjEEBgi1SqdJBBnWS76vD7CeVKLXjolZeFs="
eraa_product_uuid=""
eraa_initial_sg_token=""
eraa_policy_data=""

arch=$(uname -m)
eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v11/11.0.503.0/agent_linux_i386.sh"
eraa_installer_checksum="9102d3ef72ec543451390cd5b2636476691b18844cfad5579e14b70d131c8f29"

if $(echo "$arch" | grep -E "^(x86_64|amd64)$" 2>&1 > /dev/null)
then
    eraa_installer_url="http://repository.eset.com/v1/com/eset/apps/business/era/agent/v11/11.0.503.0/agent_linux_x86_64.sh"
    eraa_installer_checksum="3c532351f2bf5fade2e9383ae913f45d7a788069ae8390ae2cabbd4c7ab17249"
fi

echo "ESET Management Agent live installer script. Copyright © 1992-2023 ESET, spol. s r.o. - All rights reserved."

if test ! -z $eraa_server_company_name
then
  echo " * CompanyName: $eraa_server_company_name"
fi
echo " * Hostname: $eraa_server_hostname"
echo " * Port: $eraa_server_port"
echo " * Installer: $eraa_installer_url"
echo

if test -z $eraa_installer_url
then
  echo "No installer available for '$arch' arhitecture."
  exit 1
fi

local_cert_path="$(mktemp -q -u)"
echo $eraa_peer_cert_b64 | base64 -d > "$local_cert_path" && echo "$local_cert_path" >> "$cleanup_file"

if test -n "$eraa_ca_cert_b64"
then
  local_ca_path="$(mktemp -q -u)"
  echo $eraa_ca_cert_b64 | base64 -d > "$local_ca_path" && echo "$local_ca_path" >> "$cleanup_file"
fi


eraa_http_proxy_value="http://av.frt.vn:3128"

local_installer="$(dirname $0)"/"$(basename $eraa_installer_url)"

if $(echo "$eraa_installer_checksum  $local_installer" | sha256sum -c 2> /dev/null > /dev/null)
then
    echo "Verified local installer was found: '$local_installer'"
else
    local_installer="$(mktemp -q -u)"

    echo "Downloading ESET Management Agent installer..."

    if test -n "$eraa_http_proxy_value"
    then
      export use_proxy=yes
      export http_proxy="$eraa_http_proxy_value"
      (wget --connect-timeout 300 --no-check-certificate -O "$local_installer" "$eraa_installer_url" || wget --connect-timeout 300 --no-proxy --no-check-certificate -O "$local_installer" "$eraa_installer_url" || curl --fail --connect-timeout 300 -k "$eraa_installer_url" > "$local_installer") && echo "$local_installer" >> "$cleanup_file"
    else
      (wget --connect-timeout 300 --no-check-certificate -O "$local_installer" "$eraa_installer_url" || curl --fail --connect-timeout 300 -k "$eraa_installer_url" > "$local_installer") && echo "$local_installer" >> "$cleanup_file"
    fi

    if test ! -s "$local_installer"
    then
       echo "Failed to download installer file"
       exit 2
    fi

    echo -n "Checking integrity of installer script " && echo "$eraa_installer_checksum  $local_installer" | sha256sum -c
fi

chmod +x "$local_installer"

command -v sudo > /dev/null && usesudo="sudo -E" || usesudo=""

export _ERAAGENT_PEER_CERT_PASSWORD="$eraa_peer_cert_pwd"

echo
echo Running installer script $local_installer
echo

$usesudo /bin/sh "$local_installer"\
   --skip-license \
   --hostname "$eraa_server_hostname"\
   --port "$eraa_server_port"\
   --cert-path "$local_cert_path"\
   --cert-password "env:_ERAAGENT_PEER_CERT_PASSWORD"\
   --cert-password-is-base64\
   --initial-static-group "$eraa_initial_sg_token"\
   --proxy-hostname 'av.frt.vn' --proxy-port 3128 \
   --enable-imp-program\
   $(test -n "$local_ca_path" && echo --cert-auth-path "$local_ca_path")\
   $(test -n "$eraa_product_uuid" && echo --product-guid "$eraa_product_uuid")\
   $(test -n "$eraa_policy_data" && echo --custom-policy "$eraa_policy_data")
