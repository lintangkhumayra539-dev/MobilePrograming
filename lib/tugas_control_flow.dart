int calculate() => 42;

String getSeragamHari(String hari) {
  final namaHari = hari.trim();

  if (namaHari == 'Senin' ||
      namaHari == 'Selasa' ||
      namaHari == 'Rabu' ||
      namaHari == 'Kamis') {
    return 'Hari $namaHari: Pakai seragam merah putih';
  }

  if (namaHari == 'Jumat' ||
      namaHari == 'Sabtu' ||
      namaHari == 'Minggu') {
    return 'Hari $namaHari: Pakai seragam hitam putih';
  }

  return 'Nama hari tidak valid';
}

