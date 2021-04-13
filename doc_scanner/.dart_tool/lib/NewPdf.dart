import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'ghar_jao.dart';
import '3.dart';
import 'package:intl/intl.dart';



class doc_scan extends StatefulWidget {
  @override
  _doc_scanState createState() => _doc_scanState();
}

class _doc_scanState extends State<doc_scan> {
  List<File> listofimage = new List();
  final imagePicker = ImagePicker();
  Future getImage(ImageSource source) async {
    final image = await imagePicker.getImage(source: source);
    final cropped_image = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
        lockAspectRatio: false,
      ),
    );
    setState(() {

      listofimage.add(File(cropped_image.path,));
    });
  }
  Future<void> createPDF() async {
    PdfDocument document = PdfDocument();
    for (var img in listofimage) {
      final Uint8List image = img.readAsBytesSync() as Uint8List;
      PdfPage page = document.pages.add();
      page.graphics.drawImage(
          PdfBitmap(image),
          Rect.fromLTWH(0, 100, 440, 550));
    }
    List<int> bytes= document.save();
    document.dispose();
    String now = "111me175"+DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())+".pdf";
    saveAndLaunchFile(bytes, now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NEW PDF"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  createPDF();
                })
          ],
        ),
        body: ImageListWidget(imageFiles: listofimage),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              getImage(ImageSource.camera);
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.photo_library),
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            heroTag: null,
          )
        ]));
  }

}
