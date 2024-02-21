from binascii import hexlify, unhexlify
from Crypto.Cipher import AES

KEY = "73757065725f6b65795f73747265616d"
TMP_IV = "00000000000000000000000000000000"
PT1 = "4163636f7264696e6720746f20616c6c"
PT2 = "206b6e6f776e206c617773206f662061"
CT2 = "817ed4df4521cc2d6e746c45a834aa2d"


def aesDecrypt(msg):
	""""Decrypts a given message"""
    # Create aes cipher in cbc mode
    # Need to use our own IV, otherwise a random one will be generated 
	aes = AES.new(unhexlify(KEY), AES.MODE_CBC, unhexlify(TMP_IV)) 

	ct= unhexlify(msg)
	pt = aes.decrypt(ct)
	return pt


def bxor(ba1, ba2):
    """XOR two byte strings"""
    return bytes([_a ^ _b for _a, _b in zip(ba1, ba2)])


if __name__ == '__main__':
    t1 = aesDecrypt(CT2)
    print(f"t1 = {t1}")
    
    ct1 = bxor(t1, unhexlify(PT2))
    print(f"ct1 = {ct1}")
    
    t2 = aesDecrypt(hexlify(ct1).decode())
    print(f"t2 = {t2}")
    
    iv = bxor(t2, unhexlify(PT1))
    print(f"iv = {iv}")    
