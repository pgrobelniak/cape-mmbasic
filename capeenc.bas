Input "File in:  ", fileIn$
Input "File out: ", fileOut$
Input "Key:      ", key$
Input "Salt:     ", salt
Input "IV:       ", iv

Open fileIn$ For input As #1
Open fileOut$ For output As #2

reducedKey=0
For i=1 To Len(key$)
  reducedKey=reducedKey Xor Asc(Mid$(key$,i,1)) << ((i - 1) Mod 8)
Next i
saltedKey=salt Xor reducedKey

lastIndex=Lof(#1)
keyIndex=((lastIndex Xor saltedKey) Mod Len(key$)) + 1
keyByte=Asc(Mid$(key$,keyIndex,1))
encIv=iv Xor lastIndex Xor keyByte
Print #2,Chr$(encIv Mod 256);

For i=1 To Lof(#1)
  j=i-1
  byteIn=Asc(Input$(1,#1))
  keyIndex=((j Xor saltedKey) Mod Len(key$)) + 1
  keyByte=Asc(Mid$(key$,keyIndex,1))
  byteOut=byteIn Xor iv Xor j Xor keyByte
  Print #2,Chr$(byteOut Mod 256);
Next i

Close #1
Close #2
