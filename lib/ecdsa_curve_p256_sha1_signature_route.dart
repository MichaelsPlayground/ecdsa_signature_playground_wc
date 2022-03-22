import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webcrypto/webcrypto.dart';
import 'storage.dart';

class EcdsaCurveP256Sha1SignatureRoute extends StatefulWidget {
  const EcdsaCurveP256Sha1SignatureRoute({Key? key}) : super(key: key);

  final String title = 'ECDSA P-256 SHA-1 Signatur';
  final String subtitle = 'EC curve P256';

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<EcdsaCurveP256Sha1SignatureRoute> {
  @override
  void initState() {
    super.initState();
    descriptionController.text = txtDescription;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  // the following controller have a default value
  TextEditingController plaintextController = TextEditingController(
      text: 'The quick brown fox jumps over the lazy dog');
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  String txtDescription = 'ECDSA Signatur mit curve P-256 und SHA-1 hashing.'
      ' Der öffentliche Schlüssel ist im PEM PKCS#8 Format.';

  String _returnJson(String data) {
    var parts = data.split(':');
    var algorithm = parts[0];
    var plaintext = parts[1];
    var signature = parts[2];

    JsonAsymmetricSignature jsonAsymmetricSignature = JsonAsymmetricSignature(
        algorithm: algorithm, plaintext: plaintext, signature: signature);

    String encryptionResult = jsonEncode(jsonAsymmetricSignature);
    // make it pretty
    var object = json.decode(encryptionResult);
    var prettyEncryptionResult2 = JsonEncoder.withIndent('  ').convert(object);
    return prettyEncryptionResult2;
  }

  Future<bool> _fileExistsPrivateKey() async {
    bool ergebnis = false;
    await Storage().filePrivateKeyExists().then((bool value) {
      setState(() {
        if (value == true) {
          privateKeyController.text = 'Datei existiert ';
        } else {
          privateKeyController.text = 'Datei existiert NICHT';
        }
        ergebnis = value;
      });
    });
    return ergebnis;
  }

  Future<void> _readDataPrivateKey() async {
    Storage().readDataPrivateKey().then((String value) {
      setState(() {
        privateKeyController.text = value;
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
                //SizedBox(height: 20),
                // form description
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  enabled: false,
                  // false = disabled, true = enabled
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Beschreibung',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),
                // plaintext
                TextFormField(
                  controller: plaintextController,
                  maxLines: 3,
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Klartext',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte Daten eingeben';
                    }
                    return null;
                  },
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
                          plaintextController.text = '';
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
                          plaintextController.text = data!.text!;
                        },
                        child: Text('aus Zwischenablage einfügen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                // private key
                TextFormField(
                  controller: privateKeyController,
                  maxLines: 4,
                  maxLength: 2000,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  // enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Privater Schlüssel',
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
                          privateKeyController.text = data!.text!;
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          privateKeyController.text = '';
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
                          bool priKeyFileExists =
                              await _fileExistsPrivateKey() as bool;
                          if (priKeyFileExists) {
                            await _readDataPrivateKey();
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
                          // reset() setzt alle Felder wieder auf den Initalwert zurück.
                          //_formKey.currentState!.reset();
                          plaintextController.text = '';
                          privateKeyController.text = '';
                          outputController.text = '';
                        },
                        child: Text('Formulardaten löschen'),
                      ),
                    ),
                    SizedBox(width: 25),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            String plaintext = plaintextController.text;
                            String privateKeyPem = privateKeyController.text;

                            String signatureBase64 = '';
                            try {
                              final privateKeyBytes = getBytesFromPEMString(privateKeyPem);
                              EcdsaPrivateKey ecdsaPrivateKey =
                              await EcdsaPrivateKey.importPkcs8Key(privateKeyBytes, EllipticCurve.p256);
                              Uint8List dataToSignBytes = createUint8ListFromString(plaintext);
                              signatureBase64 =
                              await ecdsaSignToBase64Wc(ecdsaPrivateKey, dataToSignBytes);
                            } catch (error) {
                              outputController.text = 'Fehler beim Signieren';
                              return;
                            }
                            // build output string
                            String _formdata = 'ECDSA curve P-256 SHA-1' +
                                ':' +
                                base64Encoding(
                                    createUint8ListFromString(plaintext)) +
                                ':' +
                                signatureBase64;
                            String jsonOutput = _returnJson(_formdata);
                            outputController.text = jsonOutput;
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('signieren'),
                      ),
                  ],
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: outputController,
                  maxLines: 15,
                  maxLength: 700,
                  decoration: InputDecoration(
                    labelText: 'Ausgabe',
                    hintText: 'Ausgabe',
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
                              content: const Text(
                                  'Daten in die Zwischenablage kopiert'),
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

  Future<String> ecdsaSignToBase64Wc(
      EcdsaPrivateKey privateKey, Uint8List messageByte) async {
    try {
      var signature = await privateKey.signBytes(
          messageByte, Hash.sha1);
      return base64Encoding(signature);
    } on Error {
      return '';
    }
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = new Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
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

  String base64Encoding(Uint8List input) {
    return base64.encode(input);
  }

  Uint8List base64Decoding(String input) {
    return base64.decode(input);
  }
}

class JsonAsymmetricSignature {
  JsonAsymmetricSignature({
    required this.algorithm,
    required this.plaintext,
    required this.signature,
  });

  final String algorithm;
  final String plaintext;
  final String signature;

  Map toJson() => {
        'algorithm': algorithm,
        'plaintext': plaintext,
        'signature': signature,
      };
}
