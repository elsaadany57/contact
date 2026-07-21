import 'package:image_picker/image_picker.dart';

class Contact {
  late String username;
  late String email;
  late String phone;
  late XFile? image;

  Contact(this.username, this.email, this.phone, this.image);
}
