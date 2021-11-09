# rsa_signature_playground_wc

RSA signature and verification

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

```plaintext
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDiTjLl4huAMOCO
Car2ylLR1993FxaIhuXhG72W+txiD9fUQi7T+Ad8IMle4RfFhQymi20voX3F05HQ
OsHgYQwVHWHGGY5wxe/R/w5M0dLiPjOHaxKNPWh7DegSMUSB+V3XEqIdZRWxpWcn
zAKWHVKsT8VFdWDLcq6Sfgj7hQMgp3nMDhRsfIsjqUeUBJb3Hog8WP4DHdqnYvCt
DbDtm7Xt1xXPzd30GqSo/t5XqfY2goX430fLjKJ1G8CAtTiM2TkaaJLzb4xjzm3r
yWPioovhE/B8CfSXARTXgRtlvzUyuQhcBYSveHzi80hJAmiIQzNEhfSsX115ASOx
7cdRLCbnAgMBAAECggEAPRqvPIn+MfFAmKl8m5FKpnVa1b2KrId8B3mlieAnZGTx
ulK6cSp93uK9bJxrfj4sCcYIz70TiDhVnTtYQP0DNapOzZ3163ZOiE2Nb2mSPttb
r3tWMYO8s8kv+cWKwWtzDpDt6/Dw2BwYi9LWefDl8zfAxL3qSlSnVU+pnjwueYCs
y8H5+ZcYvM9WBmS+xDMkJPh5Dq7GgdYn5APIEXDs2ig1Du2hBni41piluKA7gBbb
ZL/qr2ZU8mtNrPLWHFTrf1kchGZT47TueJBgE85efdiJidTzpiOVKWZWz7OP6yWt
kLUBHjBipPi0IPgh8np3UsNHelGIBqxOgWNtPuYwXQKBgQD8xVjPZsIojatfb5cM
Tl4a/xVYrRcBJ4rEag/WKQJ8nw6wuNZeSuc4irb1pdnEPSPUqvb+MyByvB0mZHxf
kK/aemjSrHuG4nQ00kg8gr1vjjT90c2m44rvzqV7EPoQsJ2R5oSZuIH/qAHSM9BJ
eb9RpC5Hx8+WxMiTFgMUc8pf1QKBgQDlMkzhQ7fKcDP8log3ZTp+cFwdxWy6+s+p
vQSUm3RhJ+FawEkK1r1Ac9ElJ7+g8+OUPRl539EYfC3Xq7SEeyjJQ6emNvvjKQUR
ZwGW4hzgXpppkh6JvNF6OTiPF9oAkbzH2gxEHVCQFwnWLVKooOwIJgXcev8B81BT
A173uQcFywKBgEW2vA6/nY8Hu5sfsL4hIw05Cw8g9fZIjJotUl7Tgq8SQz/0SpNI
/0p1344ShuP7pNUzrdlgCnP6c+Ox1SeaRRXxqtVn4s3JyRkEYg3mVQ7eXrkeUyTT
Hu+Sw8sUXJOb0ml59VpcK+Zx1Ma/qZOKM3z11hnP/u3rKhJ/AKx0Xv1dAoGAChiw
KFA6XXGZ6Kuc7ovICt/aPvl+c7IuybRo6j763njKRZwo25BgH+G6Od/JYka8JMCY
SbUhWenGfzSyLA/c2Rjg3sKXUAdzkLOv7zygtwWT2ci1Da5CsBarNip/0Pyai1dA
qRN9hAtvxH6UoJcOLsG2CmNkrmpQhIemfFUrSQcCgYA14W1ttI60HgJMjRFvZcNP
5H2iQSCZlaILCBDx4aO23OJwQIZD5jdE/D6BQCd9RVMgNzoaUVg1xdmwwAGDNR/E
X2febmffZqv4XGqOgpDGCjEyzdvXMmgkzp0Praml9nrGSeF9rsB2neOL9QW80KPJ
L9L5ULrsFaKMPJViS4FR6g==
-----END PRIVATE KEY-----
```

```plaintext
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4k4y5eIbgDDgjgmq9spS
0dffdxcWiIbl4Ru9lvrcYg/X1EIu0/gHfCDJXuEXxYUMpottL6F9xdOR0DrB4GEM
FR1hxhmOcMXv0f8OTNHS4j4zh2sSjT1oew3oEjFEgfld1xKiHWUVsaVnJ8wClh1S
rE/FRXVgy3Kukn4I+4UDIKd5zA4UbHyLI6lHlASW9x6IPFj+Ax3ap2LwrQ2w7Zu1
7dcVz83d9BqkqP7eV6n2NoKF+N9Hy4yidRvAgLU4jNk5GmiS82+MY85t68lj4qKL
4RPwfAn0lwEU14EbZb81MrkIXAWEr3h84vNISQJoiEMzRIX0rF9deQEjse3HUSwm
5wIDAQAB
-----END PUBLIC KEY-----
```

Klartext:
```plaintext
The quick brown fox jumps over the lazy dog
```

Sample RSA PSS signature:
```plaintext
{
  "algorithm": "RSA-2048 PSS",
  "plaintext": "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==",
  "signature": "3oUlHXG8Yd9Ew1ByxVfi20Kez6JI/cZ4HjhiB3bBYihrPRpfmwy7pVmhz+4lM8KvEoO+7mnLiF/F2/7+z/UOdqoT35Axry6eHzo8IxHZAxWbO84UV0pbNtJ0PYfXT5fx4Pc47M5AogjBy452ct5MujsM8/Vq+Zc0fbVCsYDgQslmjl0HZK3I4XDuMKRn5Td4WZA9ojmHySJXs3yAibYt9O41jGp1np/PqMzkUPjm/F7O9YrP+xZ+xX0YdAUJ+KXRO+/fxTi9/U3WRsou7WJt7kQNRoMfhHH6UOKVLQu67g1X/tN3fy43rKg7ZfG1k0PBJh032NoHbpi7Nx8FirVqNg=="
}
```

Sample PKCS 1.5 signature:
```plaintext
{
  "algorithm": "RSA-2048 PKCS 1.5",
  "plaintext": "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==",
  "signature": "abTQ5OdbJlzEz59/sagMjYhXXNZbEX6QJk/Thw8BrFjbTIwvluM/nwiOAN3Kx10p0mlbhVd4iMmN8L+0EPmN0y35/cVTs7Mp7h2QqHWiGMhgf9o/7/oi1Os6/zLPn/UyhpxtGPRUzcj92HrhM804pvAkpq85LcZOkSWyyL8KWnlJL7a6HyAugez+bJFiTAu5woTs3nXTk8GpGGVRwDyB49pYCRBk3G9oym0k8Hur2NthavWjg1xEgN48EGWNKih0uIvFvHBAwyEUpqqrgMVBCjx51caeXma/ID8pvFEgxZXDro7h39xnxLKXHrmWV9Sd6WheolmjbizLvw0b0yp6gw=="
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
