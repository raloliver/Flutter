import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class GetImage extends BlocBase{
  
 File _image;

  //
  // Stream to handle the counter
  //
  StreamController<File> _imageController = BehaviorSubject<File>();
  StreamSink<File> get _imageAdd => _imageController.sink;
  Stream<File> get imageOut => _imageController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController;

  //
  // Constructor
  //
  GetImage(){
    _actionController.stream
                     .listen(_handleLogic);
  }

  void dispose(){
    _actionController.close();
    _imageController.close();
  }

  Future _handleLogic(data) async{
     try{
         _image = await ImagePicker.pickImage(source: ImageSource.gallery);
         _imageAdd.add(_image);
      } catch(e){
          print(e);
      }

   
  }




}

abstract class BaseBloc {
  dispose();
}

 