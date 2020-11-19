import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/User.dart';
import 'package:pharmacare_app/screens/home/components/icon_btn_counter.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var user;
  File _image;
  TextEditingController nameCOntroller = TextEditingController();
  @override
  void initState() {
    User().getUserInfo().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  void showAlert(BuildContext context) {
    var alertDialog = ImageDialog(image: _image);

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

//Options list
  List<Map<String, dynamic>> item = [
    {'text': 'Orders', 'icon': Icons.receipt_long},
    {'text': 'Prescriptions', 'icon': Icons.receipt},
    {'text': 'About', 'icon': Icons.info},
    {'text': 'Upload Prescription', 'icon': Icons.add_a_photo}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent.shade100, kPrimaryColor])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 64),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: getProportationateScreenWidth(100.0),
                      height: getProportationateScreenHeight(100.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white60, width: 2.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://oshainesmith.netlify.app/img/profile_pic.0e137a53.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportationateScreenHeight(5.0)),
                Text(
                  user != null
                      ? '${user['first_name']} ${user['last_name']}'
                      : '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      color: Colors.white),
                ),
                Text(
                  user != null ? '${user['address']}' : '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white54),
                ),
                SizedBox(height: 12.0),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Log out.svg",
                  press: () {
                    User().logout(context);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(1.5, -1.1),
            child: Container(
              width: getProportationateScreenWidth(150.0),
              height: getProportationateScreenHeight(150.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white30,
              ),
              padding: EdgeInsets.all(8.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 350.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    print(index);
                    if (index == 3) {
                      // chooseImage();
                      showAlert(context);
                    }
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            item[index]['icon'],
                            size: 60,
                            color: kPrimaryColor,
                          ),
                          Text(
                            item[index]['text'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    Key key,
    @required File image,
  })  : _image = image,
        super(key: key);

  final File _image;

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  final picker = ImagePicker();
  File _image;
  bool isUploading = false;

  var user;
  @override
  void initState() {
    User().getUserInfo().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

//select image from gallery
  Future chooseImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

//upload image
  uploadImage() async {
    final String url = 'http://10.0.2.2:8000/api/prescriptions';
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = user['id'].toString();
    request.files.add(await http.MultipartFile.fromPath("image", _image.path,
        contentType: new MediaType('image', 'jpeg, png, jpg')));

    await request.send().then((response) {
      if (response.statusCode == 200) {
        print('Image Uploaded');
        setState(() {
          isUploading = true;
          _image = null;
          Navigator.pop(context);
        });
      } else {
        print('Image Not Uploaded');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          'Choose Your Prescription',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        height: _image == null
            ? getProportationateScreenHeight(100)
            : getProportationateScreenHeight(270),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                chooseImage();
              },
            ),
            Container(
              child: _image == null
                  ? Text('No File Selected')
                  : Image.file(_image, cacheHeight: 200),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 50.0, bottom: 20.0),
      actions: [
        DefaultButton(
          text: isUploading ? "Uploading..." : "Upload",
          press: () {
            uploadImage();
          },
        )
      ],
    );
  }
}
