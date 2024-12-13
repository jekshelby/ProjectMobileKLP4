import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp()); // Fungsi utama untuk menjalankan aplikasi

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: HomePage(), // Menyeting HomePage sebagai halaman utama
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState(); // Membuat state dari halaman
}

class _HomePageState extends State<HomePage> {
  var userQuestion = ''; // Menyimpan pertanyaan/input dari pengguna
  var userAnswer = ''; // Menyimpan jawaban dari perhitungan
  final myTextStyle = TextStyle(
      fontSize: 40, color: Colors.deepPurple[900]); // Gaya teks default

  // Daftar tombol yang akan ditampilkan di kalkulator
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    ',',
    'Ans',
    '=',
  ];

  // Fungsi untuk memproses input tombol
  void buttonTapped(String value) {
    setState(() {
      if (isOperator(value)) {
        // Mencegah operator menjadi input pertama atau duplikat
        if (userQuestion.isEmpty ||
            isOperator(userQuestion[userQuestion.length - 1])) {
          return; // Abaikan jika invalid
        }
      }
      userQuestion += value; // Tambahkan input ke userQuestion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100], // Warna latar belakang
      body: Column(children: <Widget>[
        // Bagian layar untuk menampilkan input dan output
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Memberikan jarak yang rata
              children: <Widget>[
                SizedBox(height: 50), // Memberikan spasi kosong
                // Menampilkan input pengguna
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatNumber(userQuestion), // Format dengan koma
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                // Menampilkan jawaban
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatNumber(userAnswer), // Format dengan koma
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50), // Memberikan spasi kosong
              ],
            ),
          ),
        ),
        // Bagian tombol kalkulator
        Expanded(
          flex: 2,
          child: Container(
            child: GridView.builder(
              itemCount: buttons.length, // Jumlah tombol yang ditampilkan
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4), // Grid dengan 4 kolom
              itemBuilder: (BuildContext context, int index) {
                // Tombol Clear (C)
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = ''; // Menghapus semua input
                        userAnswer = ''; // Menghapus jawaban
                      });
                    },
                    buttonText:
                        buttons[index], // Menggunakan teks dari list `buttons`
                    color: Colors.green, // Warna tombol hijau
                    textColor: Colors.white, // Warna teks putih
                    fontSize: 30.0, // Menambahkan ukuran font
                  );
                } else if (index == buttons.length - 2) {
                  // Posisi tombol "Ans"
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            ''; // Menambahkan jawaban terakhir ke input
                        userQuestion +=
                            userAnswer; // Menambahkan jawaban terakhir ke input
                        userAnswer = ''; // Menghapus jawaban
                      });
                    },
                    buttonText: buttons[index],
                    color:
                        Colors.blue, // Warna tombol "Ans" (sesuai preferensi)
                    textColor: Colors.white, // Warna teks putih
                    fontSize: 30.0, // Menambahkan ukuran font
                  );
                }

                // Tombol Delete (DEL)
                else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(
                            0,
                            userQuestion.length -
                                1); // Menghapus karakter terakhir
                        userAnswer = ''; // Menghapus jawaban
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red, // Warna tombol merah
                    textColor: Colors.white, // Warna teks putih
                    fontSize: 30.0, // Menambahkan ukuran font
                  );
                }
                // Tombol Sama Dengan (=)
                else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed(); // Memanggil fungsi untuk menghitung hasil
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.deepPurple, // Warna tombol ungu
                    textColor: Colors.white, // Warna teks putih
                    fontSize: 40.0, // Menambahkan ukuran font
                  );
                }
                // Tombol lainnya
                else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion +=
                            buttons[index]; // Menambahkan input ke pertanyaan
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.white,
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                    fontSize: 40.0, // Menambahkan ukuran font
                  );
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  // Mengecek apakah tombol adalah operator
  bool isOperator(String x) {
    if (x == '%' ||
        x == ' / ' ||
        x == ' x ' ||
        x == ' - ' ||
        x == ' + ' ||
        x == '=') {
      return true;
    }
    return false;
  }

  // Fungsi untuk menghitung hasil
  void equalPressed() {
    // Salin input pengguna dan ganti koma dengan titik
    String finalQuestion = userQuestion.replaceAll(',', '.');
    finalQuestion = finalQuestion.replaceAll('x', '*'); // Ganti 'x' dengan '*'

    try {
      Parser p = Parser(); // Parser dari math_expressions
      Expression exp = p.parse(finalQuestion); // Parsing ekspresi
      ContextModel cm = ContextModel(); // Membuat konteks model
      double eval = exp.evaluate(EvaluationType.REAL, cm); // Evaluasi ekspresi

      // Format hasil dengan titik
      userAnswer =
          eval.toString().replaceAll('.', ','); // Ganti titik menjadi koma
    } catch (e) {
      userAnswer = 'Error'; // Tampilkan pesan error jika terjadi kesalahan
    }
  }

// Fungsi untuk memformat angka dengan titik sebagai pemisah desimal
  String formatNumber(String number) {
    if (number.isEmpty) {
      return '';
    }
    try {
      final formatter = NumberFormat('#,###.##',
          'en_US'); // Menggunakan format dengan titik sebagai desimal
      return formatter
          .format(double.parse(number))
          .replaceAll(',', '.'); // Mengganti koma dengan titik
    } catch (e) {
      return number; // Jika format gagal, return string aslinya
    }
  }
}
