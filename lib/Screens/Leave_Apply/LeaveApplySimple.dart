import 'package:flutter/material.dart';
import 'package:tugas_akhir/Widgets/AppBar.dart';

/// Versi sederhana Apply Leave untuk testing
/// Jika versi ini berfungsi, berarti masalah ada di animation/complexity
class LeaveApplySimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Leave - Simple Test"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TEST PAGE - Jika ini muncul, berarti navigation berfungsi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),

            // Test Dropdown 1
            Text("Test Dropdown 1:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Pilih Tipe Izin",
                border: OutlineInputBorder(),
              ),
              items: ["Triwulan", "Semester", "Tahunan"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                print("Dropdown 1 selected: $v");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Dipilih: $v")),
                );
              },
            ),

            SizedBox(height: 30),

            // Test Dropdown 2
            Text("Alasan Izin:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Pilih Alasan",
                border: OutlineInputBorder(),
              ),
              items: ["Sakit", "Keluarga", "Acara", "Lainnya"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                print("Dropdown 2 selected: $v");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Dipilih: $v")),
                );
              },
            ),

            SizedBox(height: 30),

            // Test TextField
            Text("Keterangan:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Alasan",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            SizedBox(height: 30),

            // Test Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Button clicked!");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Izin berhasil diajukan!")),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("AJUKAN IZIN", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "✅ TESTING CHECKLIST:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text("1. Halaman ini muncul (tidak blank)"),
                  Text("2. Dropdown 1 bisa diklik dan pilih"),
                  Text("3. Dropdown 2 bisa diklik dan pilih"),
                  Text("4. TextField bisa diketik"),
                  Text("5. Button bisa diklik"),
                  SizedBox(height: 10),
                  Text(
                    "Jika semua OK, berarti navigation dan basic widgets berfungsi.",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

