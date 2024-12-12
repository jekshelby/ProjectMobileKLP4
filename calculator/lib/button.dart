import 'package:flutter/material.dart'; // Import library Flutter

class MyButton extends StatefulWidget {
  // Properti yang akan digunakan untuk tombol
  final Color color; // Warna latar tombol
  final Color textColor; // Warna teks tombol
  final String buttonText; // Teks yang ditampilkan pada tombol
  final VoidCallback?
      buttonTapped; // Fungsi yang akan dipanggil saat tombol ditekan

  // Konstruktor untuk inisialisasi properti tombol
  const MyButton({
    Key? key,
    this.color = Colors.blue, // Warna default tombol biru
    this.textColor = Colors.white, // Warna teks default putih
    this.buttonText = "Button", // Teks default tombol
    this.buttonTapped, // Fungsi callback untuk aksi tombol
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState(); // Membuat state dari tombol
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.buttonTapped, // Memanggil fungsi callback saat tombol ditekan
      child: Padding(
        padding:
            const EdgeInsets.all(8.0), // Memberikan padding di sekitar tombol
        child: Container(
          decoration: BoxDecoration(
            color: widget.color, // Mengatur warna latar tombol
            borderRadius:
                BorderRadius.circular(20), // Membuat sudut tombol melengkung
          ),
          child: Center(
            child: Text(
              widget.buttonText, // Menampilkan teks tombol
              style: TextStyle(
                  color: widget.textColor), // Mengatur warna teks tombol
            ),
          ),
        ),
      ),
    );
  }
}
