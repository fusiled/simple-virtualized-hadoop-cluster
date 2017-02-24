#!/usr/bin/env python
# -*- coding: utf-8 -*-

try:
    from urllib.request import Request, urlopen
except ImportError:  # python 2
    from urllib2 import Request, urlopen
import re
import os
import subprocess
import time

from cryptography.hazmat.primitives import serialization as crypto_serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.backends import default_backend as crypto_default_backend


SLEEP_BEFORE_SCAN=60
keys_dir="keys"
pri_key_path=keys_dir+"/"+"id_rsa"
pub_key_path=pri_key_path+".pub"
files_dir="files"
jdk_name="jdk-8u121-linux-x64.rpm"
jdk_path=files_dir+"/"+jdk_name

def genKeyPair():
	print("generating ssh keys")
	key = rsa.generate_private_key( 
		backend=crypto_default_backend(),
    	public_exponent=65537,
    	key_size=2048
		)
	private_key = key.private_bytes(
	    crypto_serialization.Encoding.PEM,
	    crypto_serialization.PrivateFormat.PKCS8,
	    crypto_serialization.NoEncryption())
	pri_file=open(pri_key_path, "w")
	pri_file.write(private_key.decode('UTF-8') )
	pri_file.close()
	os.chmod(pri_key_path, 600)
	public_key = key.public_key().public_bytes(
	    crypto_serialization.Encoding.OpenSSH,
	    crypto_serialization.PublicFormat.OpenSSH
	)
	pub_file=open(pub_key_path, "w")
	pub_file.write(public_key.decode('UTF-8') )
	pub_file.close()

def download_binary(_file_name_, _req_):
	print("Downloading %s to %s " % (_req_.get_full_url(), _file_name_) )
	resp = urlopen(_req_)
	CHUNK = 16 * 1024
	with open(_file_name_, 'wb') as fp:
		while True:
			chunk = resp.read(CHUNK)
			if(not chunk):
				break
			fp.write(chunk)


def downloadJDK():
	print("Downloading jdk")
	# Add cookie to request and download the file to current directory
	req = Request("http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm")
	req.add_header('Cookie', 'gpw_e24=http://www.oracle.com/;oraclelicense=accept-securebackup-cookie')
	download_binary(jdk_path, req)


if(__name__ == "__main__"):
	if(not os.path.exists(keys_dir)):
		print("Generating a new key pair")
		os.mkdir(keys_dir)
		genKeyPair()
	else:
		print("Keys still exist. Skipping generation")
	if(not os.path.exists(jdk_path)):
		downloadJDK()
	else:
		print("JDK still exists... Skipping download")
	print("Starting vagrant")
	subprocess.call(["vagrant", "up"])
	time.sleep(SLEEP_BEFORE_SCAN)
	subprocess.call(["vagrant","ssh", "mas","-c", "./key_scan.sh"])
	print("Vagrant Installation finished. End the installation loggin into you mas machine")
