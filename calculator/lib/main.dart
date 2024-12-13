import 'package:calculator/button.dart'; // Import file untuk widget tombol
import 'package:flutter/material.dart'; // Import library Flutter
import 'package:math_expressions/math_expressions.dart'; // Import library untuk evaluasi ekspresi matematika
import 'package:intl/intl.dart'; // Import untuk memformat angka dengan koma

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
  _HomePageState createState() => _HomePageState(); // Membuat state dari halaman
}

class _HomePageState extends State<HomePage> {
  var userQuestion = ''; // Menyimpan pertanyaan/input dari pengguna
  var userAnswer = ''; // Menyimpan jawaban dari perhitungan
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]); // Gaya teks default

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100], // Warna latar belakang
      body: Column(children: <Widget>[
        // Bagian layar untuk menampilkan input dan output
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Memberikan jarak yang rata
              children: <Widget>[
                SizedBox(height: 50), // Memberikan spasi kosong
                // Menampilkan input pengguna
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatNumber(userQuestion), // Format dengan koma
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // Menampilkan jawaban
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    formatNumber(userAnswer), // Format dengan koma
                    style: TextStyle(fontSize: 20),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), // Grid dengan 4 kolom
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
                    buttonText: buttons[index],
                    color: Colors.green, // Warna tombol hijau
                    textColor: Colors.white, // Warna teks putih
                  );
                } else if (index == buttons.length - 2) {
                  // Posisi tombol "Ans"
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += userAnswer; // Menambahkan jawaban terakhir ke input
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.blue, // Warna tombol "Ans" (sesuai preferensi)
                    textColor: Colors.white, // Warna teks putih
                  );
                }

                // Tombol Delete (DEL)
                else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(0, userQuestion.length - 1); // Menghapus karakter terakhir
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red, // Warna tombol merah
                    textColor: Colors.white, // Warna teks putih
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
                  );
                }
                // Tombol lainnya
                else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index]; // Menambahkan input ke pertanyaan
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.white, // Warna tombol operator dan angka
                    textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple, // Warna teks untuk operator dan angka
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
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // Fungsi untuk menghitung hasil
  void equalPressed() {
    String finalQuestion = userQuestion; // Menyalin input pengguna
    finalQuestion = finalQuestion.replaceAll('x', '*'); // Mengganti 'x' dengan '*' untuk evaluasi matematika

    Parser p = Parser(); // Parser dari library math_expressions
    Expression exp = p.parse(finalQuestion); // Parsing ekspresi
    ContextModel cm = ContextModel(); // Membuat konteks model
    double eval = exp.evaluate(EvaluationType.REAL, cm); // Evaluasi ekspresi

    userAnswer = eval.toString(); // Menyimpan hasil sebagai string
  }

// Fungsi untuk memformat angka dengan titik sebagai pemisah desimal
String formatNumber(String number) {
  if (number.isEmpty) {
    return '';
  }
  try {
    final formatter = NumberFormat('#,###.##', 'en_US'); // Menggunakan format dengan titik sebagai desimal
    return formatter.format(double.parse(number)).replaceAll(',', '.'); // Mengganti koma dengan titik
  } catch (e) {
    return number; // Jika format gagal, return string aslinya
  }
}
}
