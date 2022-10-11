final String tablepengeluaran = 'expenses';

class expensesFields {
  static final List<String> values = [
    /// Add all fields
    id, nama, harga, time
  ];

  static final String id = '_id';
  static final String nama = 'nama';
  static final String harga = 'harga';
  static final String time = 'time';
}

class pengeluaran {
  final int? id;
  final String nama;
  final int harga;
  final DateTime createdTime;

  const pengeluaran(
      {this.id,
      required this.nama,
      required this.harga,
      required this.createdTime});
  Map<String, Object?> toJson() => {
        expensesFields.id: id,
        expensesFields.nama: nama,
        expensesFields.harga: harga,
        expensesFields.time: createdTime.toIso8601String(),
      };
  pengeluaran copy(
          {int? id, String? nama, int? harga, DateTime? createdTime}) =>
      pengeluaran(
          id: id ?? this.id,
          nama: nama ?? this.nama,
          harga: harga ?? this.harga,
          createdTime: createdTime ?? this.createdTime);
  static pengeluaran fromJson(Map<String, Object?> json) => pengeluaran(
      id: json[expensesFields.id] as int?,
      nama: json[expensesFields.nama] as String,
      harga: json[expensesFields.harga] as int,
      createdTime: DateTime.parse(json[expensesFields.time] as String));
}
