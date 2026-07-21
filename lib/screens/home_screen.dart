import 'dart:io';
import 'package:contact/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Contact> contacts = [];

class _HomeScreenState extends State<HomeScreen> {
  XFile? _pickedImage;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF29384D),
      appBar: AppBar(
        backgroundColor: Color(0xFF29384D),
        title: SizedBox(
          height: 39,
          width: 117,
          child: Image.asset("assets/images/route_logo.png"),
        ),
      ),

      body: ListView(
        children: [
          SizedBox(height: 20),
          contacts.isEmpty
              ? Column(
                  children: [
                    Lottie.asset('assets/animations/empty_list.json'),
                    Center(
                      child: Text(
                        "There is No Contacts Added Here",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFF1D4),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2 - 20 - 8) /
                          290,
                    ),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Container(
                        height: 290,
                        decoration: BoxDecoration(
                          color: Color(0xFF29384D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            // Stack: Image with username overlay
                            Stack(
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 177,
                                    child: contact.image != null
                                        ? Image.file(
                                            File(contact.image!.path),
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: Color(
                                              0xFFFFF1D4,
                                            ).withValues(alpha: 0.2),
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                  ),
                                ),
                                // Username at bottom left
                                Positioned(
                                  bottom: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFF1D4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      contact.username,
                                      style: TextStyle(
                                        color: Color(0xFF29384D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Email and Phone in one cream container
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFF1D4),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    // Email row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_rounded,
                                          size: 20,
                                          color: Color(0xFF29384D),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            contact.email,
                                            style: TextStyle(
                                              color: Color(0xFF29384D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // Phone row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_in_talk,
                                          size: 20,
                                          color: Color(0xFF29384D),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            contact.phone,
                                            style: TextStyle(
                                              color: Color(0xFF29384D),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            contacts.removeAt(index);
                                          });
                                        },
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                Color(0xFFF93E3E),
                                              ),

                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Delete",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),

      floatingActionButton: contacts.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setModalState) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 485,
                            decoration: BoxDecoration(
                              color: Color(0xFF29384D),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 143,
                                      height: 146,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final XFile? pickedFile =
                                              await _picker.pickImage(
                                                source: ImageSource.gallery,
                                              );
                                          setModalState(() {
                                            _pickedImage = pickedFile;
                                          });
                                        },
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                Color(0xFF29384D),
                                              ),
                                          side: WidgetStateProperty.all(
                                            BorderSide(
                                              color: Color(0xFFFFF1D4),
                                              width: 1,
                                            ),
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                            ),
                                          ),
                                        ),
                                        child: _pickedImage != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(28),
                                                child: SizedBox.expand(
                                                  child: Image.file(
                                                    File(_pickedImage!.path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 124,
                                                height: 124,
                                                child: Lottie.asset(
                                                  'assets/animations/image_picker.json',
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Name",
                                          style: TextStyle(
                                            color: Color(0xFFFFF1D4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Container(
                                          width: 192,
                                          height: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          "example@email.com",
                                          style: TextStyle(
                                            color: Color(0xFFFFF1D4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Container(
                                          width: 192,
                                          height: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          "+200000000000",
                                          style: TextStyle(
                                            color: Color(0xFFFFF1D4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                SizedBox(
                                  height: 60,
                                  child: TextField(
                                    controller: _nameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 18,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      hintText: 'Enter User Name',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                          0xFFE2F4F6,
                                        ).withValues(alpha: 0.5),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFE2F4F6),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 9),

                                SizedBox(
                                  height: 60,
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 18,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      hintText: 'Enter User Email',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                          0xFFE2F4F6,
                                        ).withValues(alpha: 0.5),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFE2F4F6),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 9),

                                SizedBox(
                                  height: 60,
                                  child: TextField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color(0xFFFFF1D4),
                                        ),
                                      ),
                                      hintText: 'Enter User Phone',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(
                                          0xFFE2F4F6,
                                        ).withValues(alpha: 0.5),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFE2F4F6),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validation: Check if fields are not empty
                                      if (_nameController.text.trim().isEmpty ||
                                          _emailController.text
                                              .trim()
                                              .isEmpty ||
                                          _phoneController.text
                                              .trim()
                                              .isEmpty) {
                                        // Show error message
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please fill in all fields',
                                            ),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        return; // Don't create contact
                                      }

                                      // Create new contact
                                      final newContact = Contact(
                                        _nameController.text,
                                        _emailController.text,
                                        _phoneController.text,
                                        _pickedImage,
                                      );

                                      // Add to contacts list
                                      setState(() {
                                        contacts.add(newContact);
                                      });

                                      // Clear form
                                      _nameController.clear();
                                      _emailController.clear();
                                      _phoneController.clear();
                                      _pickedImage = null;

                                      // Close bottom sheet
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.zero,
                                      ),
                                      backgroundColor: WidgetStateProperty.all(
                                        Color(0xFFFFF1D4),
                                      ),
                                      side: WidgetStateProperty.all(
                                        BorderSide(
                                          color: Color(0xFFFFF1D4),
                                          width: 1,
                                        ),
                                      ),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Enter user",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF29384D),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                            ),
                          ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              backgroundColor: Color(0xFFFFF1D4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ), // Adjust radius as needed
              ),
              child: Icon(Icons.add, size: 20, color: Color(0xFF29384D)),
            )
          : contacts.length < 6
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Delete button
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      contacts.removeLast();
                    });
                  },
                  backgroundColor: Color(0xFFF93E3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.delete, size: 24, color: Colors.white),
                ),
                SizedBox(height: 8),
                // Add button
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setModalState) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 485,
                                decoration: BoxDecoration(
                                  color: Color(0xFF29384D),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 143,
                                          height: 146,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final XFile? pickedFile =
                                                  await _picker.pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                              setModalState(() {
                                                _pickedImage = pickedFile;
                                              });
                                            },
                                            style: ButtonStyle(
                                              padding: WidgetStateProperty.all(
                                                EdgeInsets.zero,
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    Color(0xFF29384D),
                                                  ),
                                              side: WidgetStateProperty.all(
                                                BorderSide(
                                                  color: Color(0xFFFFF1D4),
                                                  width: 1,
                                                ),
                                              ),
                                              shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                            ),
                                            child: _pickedImage != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          28,
                                                        ),
                                                    child: SizedBox.expand(
                                                      child: Image.file(
                                                        File(
                                                          _pickedImage!.path,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 124,
                                                    height: 124,
                                                    child: Lottie.asset(
                                                      'assets/animations/image_picker.json',
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "User Name",
                                              style: TextStyle(
                                                color: Color(0xFFFFF1D4),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Container(
                                              width: 192,
                                              height: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "example@email.com",
                                              style: TextStyle(
                                                color: Color(0xFFFFF1D4),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Container(
                                              width: 192,
                                              height: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "+200000000000",
                                              style: TextStyle(
                                                color: Color(0xFFFFF1D4),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    SizedBox(
                                      height: 60,
                                      child: TextField(
                                        controller: _nameController,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 18,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          hintText: 'Enter User Name',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                              0xFFE2F4F6,
                                            ).withValues(alpha: 0.5),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFE2F4F6),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                    SizedBox(
                                      height: 60,
                                      child: TextField(
                                        controller: _emailController,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 18,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          hintText: 'Enter User Email',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                              0xFFE2F4F6,
                                            ).withValues(alpha: 0.5),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFE2F4F6),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                    SizedBox(
                                      height: 60,
                                      child: TextField(
                                        controller: _phoneController,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xFFFFF1D4),
                                            ),
                                          ),
                                          hintText: 'Enter User Phone',
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(
                                              0xFFE2F4F6,
                                            ).withValues(alpha: 0.5),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFE2F4F6),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_nameController.text
                                                  .trim()
                                                  .isEmpty ||
                                              _emailController.text
                                                  .trim()
                                                  .isEmpty ||
                                              _phoneController.text
                                                  .trim()
                                                  .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Please fill in all fields',
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                            return;
                                          }
                                          final newContact = Contact(
                                            _nameController.text,
                                            _emailController.text,
                                            _phoneController.text,
                                            _pickedImage,
                                          );
                                          setState(() {
                                            contacts.add(newContact);
                                          });
                                          _nameController.clear();
                                          _emailController.clear();
                                          _phoneController.clear();
                                          _pickedImage = null;
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                Color(0xFFFFF1D4),
                                              ),
                                          side: WidgetStateProperty.all(
                                            BorderSide(
                                              color: Color(0xFFFFF1D4),
                                              width: 1,
                                            ),
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Enter user",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF29384D),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                                ),
                              ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  backgroundColor: Color(0xFFFFF1D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.add, size: 20, color: Color(0xFF29384D)),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  contacts.removeLast();
                });
              },
              backgroundColor: Color(0xFFF93E3E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.delete, size: 24, color: Colors.white),
            ),
    );
  }
}
