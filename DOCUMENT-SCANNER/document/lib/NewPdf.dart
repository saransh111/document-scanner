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
import 'package:provider/provider.dart';
import 'User_model.dart';
import 'database.dart';



class doc_scan extends StatefulWidget {
  @override
  _doc_scanState createState() => _doc_scanState();
}
String naam;
String roll;
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
    String now = roll + DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())+".pdf";
    saveAndLaunchFile(bytes, now);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        naam=userData.name;
        roll=userData.rollno;
        return Scaffold(
            appBar: AppBar(
              title: Text("New Pdf",
                style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),),
              centerTitle: true,
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () {
                      createPDF();
                    })
              ],
            ),
            body : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/abc.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ImageListWidget(imageFiles: listofimage)),
            floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                //child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                focusColor: Colors.blue,
                foregroundColor: Colors.white,
                hoverColor: Colors.green,
                splashColor: Colors.tealAccent,
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
                //child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                focusColor: Colors.blue,
                foregroundColor: Colors.white,
                hoverColor: Colors.green,
                splashColor: Colors.tealAccent,
                heroTag: null,
              )
            ]));
      }
    );
  }

}
