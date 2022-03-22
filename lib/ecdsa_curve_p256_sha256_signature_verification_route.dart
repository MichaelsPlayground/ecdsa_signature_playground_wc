import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webcrypto/webcrypto.dart';
import 'storage.dart';

class EcdsaCurveP256Sha256SignatureVerificationRoute extends StatefulWidget {
  const EcdsaCurveP256Sha256SignatureVerificationRoute({Key? key}) : super(key: key);

  final String title = 'ECDSA P-256 SHA-256 Verifikation';
  final String subtitle = 'EC curve P-256';

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<EcdsaCurveP256Sha256SignatureVerificationRoute> {
  @override
  void initState() {
    super.initState();
    descriptionController.text = txtDescription;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ciphertextController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  TextEditingController signatureVerificationController =
      TextEditingController();

  String txtDescription =
      'ECDSA Verifikation einer Unterschrift mit curve P-256 und SHA-256 hashing.'
      ' Der öffentliche Schlüssel ist im PEM PKCS#8 Format.';

  Future<bool> _fileExistsPublicKey() async {
    bool ergebnis = false;
    await Storage().filePublicKeyExists().then((bool value) {
      setState(() {
        if (value == true) {
          publicKeyController.text = 'Datei existiert ';
        } else {
          publicKeyController.text = 'Datei existiert NICHT';
        }
        ergebnis = value;
      });
    });
    return ergebnis;
  }

  Future<void> _readDataPublicKey() async {
    Storage().readDataPublicKey().then((String value) {
      setState(() {
        publicKeyController.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // form description
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  enabled: false,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Beschreibung',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),
                // signatur
                TextFormField(
                  controller: ciphertextController,
                  maxLines: 15,
                  maxLength: 700,
                  decoration: InputDecoration(
                    labelText: 'Signatur',
                    hintText: 'kopieren Sie den signierten Text in dieses Feld',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () {
                        ciphertextController.text = '';
                      },
                      child: Text('Feld löschen'),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          final data =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          ciphertextController.text = data!.text!;
                        },
                        child: Text('aus Zwischenablage einfügen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                // public key
                TextFormField(
                  controller: publicKeyController,
                  maxLines: 4,
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  //enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Öffentlicher Schlüssel',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte den Schlüssel laden oder erzeugen';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          final data =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          publicKeyController.text = data!.text!;
                        },
                        child: Text('Schlüssel aus Zwischenablage einfügen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          publicKeyController.text = '';
                        },
                        child: Text('Feld löschen'),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          bool pubKeyFileExists =
                              await _fileExistsPublicKey() as bool;
                          if (pubKeyFileExists) {
                            await _readDataPublicKey();
                          }
                        },
                        child: Text('lokal laden'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          //_formKey.currentState!.reset();
                          ciphertextController.text = '';
                          publicKeyController.text = '';
                        },
                        child: Text('Formulardaten löschen'),
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            String jsonAsymmetricSignature =
                                ciphertextController.text;
                            String publicKeyPem = publicKeyController.text;

                            String algorithm = '';
                            String plaintextBase64 = '';
                            String signatureBase64 = '';
                            try {
                              final parsedJson =
                                  json.decode(jsonAsymmetricSignature);
                              algorithm = parsedJson['algorithm'];
                              plaintextBase64 = parsedJson['plaintext'];
                              signatureBase64 = parsedJson['signature'];
                            } on FormatException catch (e) {
                              outputController.text =
                                  'Fehler: Die Eingabe sieht nicht nach einem Json-Datensatz aus.';
                              return;
                            } on NoSuchMethodError catch (e) {
                              outputController.text =
                                  'Fehler: Die Eingabe ist ungültig.';
                              return;
                            }
                            if (algorithm != 'ECDSA curve P-256 SHA-256') {
                              outputController.text =
                              'Fehler: es handelt sich nicht um einen Datensatz, der mit ECDSA curve P-256 SHA-256 signiert worden ist.';
                              return;
                            }

                            String verificationtext = '';
                            try {
                              final publicKeyBytes =
                                  getBytesFromPEMString(publicKeyPem);
                              EcdsaPublicKey ecdsaPublicKey =
                                  await EcdsaPublicKey.importSpkiKey(
                                      publicKeyBytes, EllipticCurve.p256);
                              //printC('used public key:\n' + publicKeyPem);
                              final plaintext = base64Decoding(plaintextBase64);
                              bool signatureVerified =
                                  await ecdsaVerifiySignatureFromBase64Wc(
                                      ecdsaPublicKey, plaintext, signatureBase64);
                              if (signatureVerified == true) {
                                verificationtext = 'Die Signatur ist RICHTIG';
                              } else {
                                verificationtext = 'Die Signatur ist FALSCH';
                              }
                            } catch (error) {
                              signatureVerificationController.text =
                                  'Die Signatur ist FALSCH';
                              return;
                            }
                            signatureVerificationController.text =
                                verificationtext;
                            // cleartext output
                            outputController.text = new String.fromCharCodes(
                                base64Decoding(plaintextBase64));
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Signatur prüfen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: signatureVerificationController,
                  maxLines: 1,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Gültigkeit der Signatur',
                    hintText: 'Gültigkeit der Signatur',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: outputController,
                  maxLines: 3,
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: 'Klartext',
                    hintText: 'hier steht der KLartext',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: TextStyle(color: Colors.white)),
                      onPressed: () {
                        outputController.text = '';
                      },
                      child: Text('Feld löschen'),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          final data =
                              ClipboardData(text: outputController.text);
                          await Clipboard.setData(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('in die Zwischenablage kopiert'),
                            ),
                          );
                        },
                        child: Text('in Zwischenablage kopieren'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Uint8List getBytesFromPEMString(String pem) {
    var lines = LineSplitter.split(pem)
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    if (lines.length < 2 ||
        !lines.first.startsWith('-----BEGIN') ||
        !lines.last.startsWith('-----END')) {
      throw ArgumentError('The given string does not have the correct '
          'begin/end markers expected in a PEM file.');
    }
    var base64 = lines.sublist(1, lines.length - 1).join('');
    return Uint8List.fromList(base64Decode(base64));
  }

  Future<bool> ecdsaVerifiySignatureFromBase64Wc(EcdsaPublicKey publicKey,
      Uint8List messageByte, String signatureBase64) async {
    try {
      var signature = base64Decoding(signatureBase64);
      var verificationResult = await publicKey.verifyBytes(
          signature, messageByte, Hash.sha256);
      return verificationResult;
    } on Error {
      return false;
    }
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = new Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  Uint8List base64Decoding(String input) {
    return base64.decode(input);
  }
}
