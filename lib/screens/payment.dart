import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController customerNoController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController initialMeterController = TextEditingController();
  TextEditingController finalMeterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const Text('Plat Nomor',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 32.0),
              Expanded(
                  child: TextField(
                      controller: customerNoController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('Atas Nama',
                  textAlign: TextAlign.left,
                  style: (TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ))),
              const SizedBox(width: 12.0),
              Expanded(
                  child: TextField(
                      controller: customerNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(
              height: 12.0,
            ),
            Row(children: [
              const Text('Jenis Motor',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 85.0),
              Expanded(
                  child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(
              height: 12.0,
            ),
            Row(children: [
              const Text('Warna Motor',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 95.0),
              Expanded(
                  child: TextField(
                      controller: monthController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(
              height: 12.0,
            ),
            Row(children: [
              const Text('Meter Awal',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 50.0),
              Expanded(
                  child: TextField(
                      controller: initialMeterController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(
              height: 12.0,
            ),
            Row(children: [
              const Text('Meter Akhir',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 45.0),
              Expanded(
                  child: TextField(
                      controller: finalMeterController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))))
            ]),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
                onPressed: () {
                  // Proses pembayaran atau tindakan lainnya
                  performPayment();
                },
                child: const Text('Bayar')),
          ],
        ),
      ),
    );
  }

  void performPayment() {
    // Ambil nilai dari controller dan lakukan proses pembayaran
    String customerNo = customerNoController.text;
    String customerName = customerNameController.text;
    String address = addressController.text;
    String month = monthController.text;
    double initialMeter = double.parse(initialMeterController.text);
    double finalMeter = double.parse(finalMeterController.text);

    // Proses pembayaran atau tindakan lainnya dapat dilakukan di sini

    // Contoh: Menghitung total pembayaran berdasarkan perbedaan meter
    //double totalPayment = (finalMeter - initialMeter) *
    //0.5; // Misalnya, tarif air per meter adalah 0.5

    if (initialMeterController.text.isEmpty ||
        finalMeterController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Mohon isi nilai untuk Meter Awal dan Meter Akhir'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      double initialMeter = double.parse(initialMeterController.text);
      double finalMeter = double.parse(finalMeterController.text);

      double usage = finalMeter - initialMeter;

      double tariff;
      if (usage <= 10) {
        tariff = 2500;
      } else if (usage <= 20) {
        tariff = 5000;
      } else if (usage <= 30) {
        tariff = 7000;
      } else {
        tariff = 10000;
      }

      double totalPayment = usage * tariff;
      // Tampilkan hasil pembayaran
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pembayaran Sukses'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nomor Pelanggan: $customerNo'),
                Text('Nama Pelanggan: $customerName'),
                Text('Alamat: $address'),
                Text('Bulan: $month'),
                Text('Meter Awal: $initialMeter'),
                Text('Meter Akhir: $finalMeter'),
                Text('Total Pembayaran: $totalPayment'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }
}
