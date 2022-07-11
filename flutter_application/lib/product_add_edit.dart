import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ProductAddEdit extends StatefulWidget {
  const ProductAddEdit({Key? key}) : super(key: key);

  @override
  State<ProductAddEdit> createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isAPICallPRocess = false;
  ProductModel? productModel;
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Node JS CRUD"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: productForm(),
          ),
          inAsyncCall: isAPICallPRocess,
          opacity: .3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = ProductModel();

    Future.delayed(const Duration(seconds: 0), () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        productModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
                context, "ProductName", "Product Name", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Product Name Can't be empty";
              }
              return null;
            }, (onSavedVal) {
              productModel!.productName = onSavedVal;
            },
                initialValue: productModel!.productName ?? "",
                prefixIcon: const Icon(Icons.ac_unit),
                borderColor: Colors.black,
                borderFocusColor: Colors.black,
                textColor: Colors.black,
                hintColor: Colors.black.withOpacity(.7),
                borderRadius: 10,
                showPrefixIcon: false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductPrice",
              "Product Price",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Product Price Can't be empty";
                }
                return null;
              },
              (onSavedVal) {
                productModel!.productPrice = int.parse(onSavedVal);
              },
              initialValue: productModel!.productPrice == null
                  ? ""
                  : productModel!.productPrice.toString(),
              prefixIcon: const Icon(Icons.ac_unit),
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.monetization_on),
            ),
          ),
          picPicker(isImageSelected, productModel!.productImage ?? "", (file) {
            setState(() {
              productModel!.productImage = file.path;
              isImageSelected = true;
            });
          }),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: FormHelper.submitButton("Save", () {
            if (validateAndSave()) {
              //api service
              // print("presses");
            }
          },
                  btnColor: HexColor('#283871'),
                  borderColor: Colors.white,
                  borderRadius: 10))
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      return true;
    }
    return false;
  }

  static Widget picPicker(
      bool isFileSelected, String fileName, Function onFilePicked) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isFileSelected
                ? Image.file(
                    File(fileName),
                    height: 200,
                    width: 200,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 35,
            width: 35,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.image,
                size: 35,
              ),
              onPressed: () {
                _imageFile = _picker.pickImage(source: ImageSource.gallery);
                _imageFile.then((file) async {
                  onFilePicked(file);
                });
              },
            ),
          ),
          SizedBox(
            height: 35,
            width: 35,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.camera,
                size: 35,
              ),
              onPressed: () {
                _imageFile = _picker.pickImage(source: ImageSource.camera);
                _imageFile.then((file) async {
                  onFilePicked(file);
                });
              },
            ),
          )
        ])
      ],
    );
  }
}
