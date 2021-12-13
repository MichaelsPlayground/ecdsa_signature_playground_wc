# rsa_signature_playground_wc

RSA signature and verification

For more information see here: http://fluttercrypto.bplaced.net/rsa-signature-playground-webcrypto/

```plaintext
https://pub.dev/packages/webcrypto
https://github.com/google/webcrypto.dart
webcrypto: ^0.5.2

https://pub.dev/packages/url_launcher
url_launcher: ^6.0.12

https://pub.dev/packages/path_provider
path_provider: ^2.0.5

in AndroidManifest.xml ergänzen:

    <queries>
        <!-- If your app opens https URLs -->
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>
```    

RSA Private key 2048:
```plaintext
-----BEGIN PRIVATE KEY-----
MIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQDFsfxA+EzVUAGl
yGvCZMRue4aVSE98PQbboifKkrG/CYUAqjlhi+5SOhP5sk/DXeiMDvF8HL+twuXx
ksD03TjPHltSdMi2/+VU46neXs0b4mlCPtXGP7Qeu543qQzjDfSCA+TsA+L0maeK
Gw0j9Hk9q5OB1HJw0UVsyLf6E09mgQFLJu7pKkLJAr4y5Gg88CWufPTYGV2n5STW
M/76nKOzX6qFSAYnfD3nnNdQ2CY1YQCwhWudlCo8sTj744LGgKaHBHrNB1Ezrkr3
U6+TcWWXamFFgHFebT9aaDpbct1z97gz0M16VIZDmLQdWZNiu65fQI4G56ed2pbT
bHVxKubRAgMBAAECgf9LMkgg7lFLUgNOa82RQ4L0A0hNwBN7zjqtkCBSjTnO0HAm
sJji4bbkz/KJJ6nvRekOXSC9dLH0Bg4wtQFwIjVZktJpqsIt2WgBwhb63lRmJtii
ugPWRKTei77CrSqZstUuHw0UOOY647c2cNOuuW7kZj7VQ1nET9V4a2CPXoj1E7Fx
/hkEWeWeP0Y81WhfEFQvPtzaefyXVEBdghBXAdy3YG3ItNqDOS6qCX36DnV6mb/V
G69taif/79tB5xiyfpIzRHBRJp+4MbWVD4Z36jehPsccpWx9l/OrcmsJvW6+NAOZ
TsgCzbpInCmPsg3OtLwh7D5PoQHzwGV0sabWMkECgYEA7DM9OcMURuUYshcdnelv
69J8qlOwwtvfqDy4FdmyAA3vhv+2udxmlL31JEeOKFlP7iGQGu+USwTc7yHBIhru
cnvUyNW7xQcNoYUGX+K4nDsSOQeXWbK7l5aSTiGqSjjpRWm1L6nQK7eie6dU9y+3
fOyJ5vYAnE9repz7EBGZgrECgYEA1kRyTZs2FkLWSJ2g8eE2vqD7PMiHQjf3cOpN
Gn5jXwhiSJAOeL0+ji6qPv6lMLQlgScoiMgG4b5SM6bYKdr7pOhysrrrvndgHBFO
A7OCEy8XqRxDCtLBQIqXlNm80l8tUh5gSS1Lh/8URH+X3EYM9Gtlzt9Jc5it8pbS
Yv4JbiECgYBmbYHrfpFYfRjMggGx7P1AArNVGZ3ZoofG6S3bK+Bo7aIlpNaUmuNR
NV8NMIqRLMngtmVLiQGB1sYIXVbnd05YDyMjRKx8sKZUmN8+zY7JEUTBvmz/1OZM
wlsHzsmODkf6dfDAjp9blfK8NMA/wU2MuvbCVYPGRRqSvWiSe09awQKBgEe5bdHQ
rRBSm0x/h4qwaxTw6mj0b2KZPXlM1TaTLEx5j/zeTBnar4AE2vRvZXiiNRPAue7f
ln4mqXmk1iNcrHQNY6e0rol5iHCc0lKm2ln1n6P6U+7hkdM7EXbAVFbPiWo9xNl6
EhiaKHytgXY49Mk00kWntPy/FStplU+R3jJBAoGAdl1MDEQMjh3ORQTUhHN3eayZ
piQvu/SgrynQ0vfT1CF9PO2dqyVaf9aHsV4QrLCQcK5DAYSC11i6npAHzvV8I3g4
XI2LVw0brqzeKUfI+2hn5k/AGB+/RRNY8TdWWzZZ//H1HFTZ5vXLS/n75xSKjCB8
f2e6jCSosmSIrNlwSrU=
-----END PRIVATE KEY-----
```

RSA Public key 2048:
```plaintext
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxbH8QPhM1VABpchrwmTE
bnuGlUhPfD0G26InypKxvwmFAKo5YYvuUjoT+bJPw13ojA7xfBy/rcLl8ZLA9N04
zx5bUnTItv/lVOOp3l7NG+JpQj7Vxj+0HrueN6kM4w30ggPk7APi9JmnihsNI/R5
PauTgdRycNFFbMi3+hNPZoEBSybu6SpCyQK+MuRoPPAlrnz02Bldp+Uk1jP++pyj
s1+qhUgGJ3w955zXUNgmNWEAsIVrnZQqPLE4++OCxoCmhwR6zQdRM65K91Ovk3Fl
l2phRYBxXm0/Wmg6W3Ldc/e4M9DNelSGQ5i0HVmTYruuX0COBuenndqW02x1cSrm
0QIDAQAB
-----END PUBLIC KEY-----
```

Klartext:
```plaintext
Mein wichtiges Geheimnis
```

Sample RSA PSS signature:
```plaintext
{
  "algorithm": "RSA-2048 PSS",
  "plaintext": "TWVpbiB3aWNodGlnZXMgR2VoZWltbmlz",
  "signature": "pEVpsn/QEdJ4C5Q/e1cfwN9p1sgLAviS1VOYAAFxukLSJn+THDwaBf+c7aSZ4ncVWZCgMgGS2mDoarCsAUpL9WikolwJklhm90YFoZWi1tvMdhI3pEtnQnBkTUNQVBu2YTzBG/z+juB69Jo2MnsUXkGTo18gOyYMtjGRI8BEMUCedXgmm5/YlScN7uKl7l98rPGq1y6v+rvBT/bCGE9PD5x5v3eJEtVNwEzW2UCmXO3VV4emdVnXckM35sNcDTyrw67yGFJ2Oq3GN2cPYmcJ+BhUMsY8PaHuetpdvmIL+9X6KnMe2QXSaKYA3lOwsI/xcreBmFODdELK4+HPdgiIGA=="
}
```

Sample PKCS 1.5 signature:
```plaintext
{
  "algorithm": "RSA-2048 PKCS 1.5",
  "plaintext": "TWVpbiB3aWNodGlnZXMgR2VoZWltbmlz",
  "signature": "qi/KB1S9lcTobMVwnNUZtLZ98MJJgSOkwn65FLDQ9AoVo4+hqPEUGVv6Qg4H6r+VeuOfDwAodY1SOVGIZvtxjEtX58pTWl1eI45cmi/3hKMqXGjyxj/jApWb7Jo3I00O7KiZGLolZRAnPB3QJvrkLniD9SC6ebu/0yxkpCn9goipVHwiMYEgypX6ZDiBtyl7VYVVodsD2yruVEAi6IAN1HCjUvFHeoD0AinKWimka4Y0m2gEn0JPnrLFj3+o+g79InqjpqGb7h/3O6p69pY9chjVV6rerMr1py8qHzblCk9xG8TFUHzyzV7P53I5zVJK4PwiwX0Ko4X5gqZLP4XyTA=="
}
```

development environment:
```plaintext
Android Studio Arctic Fox Version 2020.3.1 Patch 3
Build #AI-203.7717.56.2031.7784292
Runtime version: 11.0.10+0-b96-7249189 aarch64
VM: OpenJDK 64-Bit Server VM
Flutter 2.5.3 channel stable Framework Revision 18116933e7
Dart 2.14.4
```

tested on:
```plaintext
Android Simulator: 
  Android 11 (SDK 30) Emulator,
  Android 12 SV2 (SDK 31) Emulator, 
  Android 6 (SDK 23) Emulator,
  Android 5 (SDK 21) Emulator.
iOS Simulator:  
  iOS 15 Emulator
  iOS 11.4 Emulator 
```


```plaintext

```


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
