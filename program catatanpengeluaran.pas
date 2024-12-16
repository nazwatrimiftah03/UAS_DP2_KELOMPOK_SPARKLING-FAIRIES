program catatanpengeluaran;


uses crt, sysutils; // Library tambahan untuk manipulasi layar dan format string



const
MAX = 100; // Konstanta untuk batas maksimum jumlah data pengeluaran

// Definisi tipe data record untuk menyimpan informasi pengeluaran
type

Pengeluaran = record
    Tanggal: string; // Menyimpan tanggal pengeluaran dalam format DD-MM-YYYY
    Kategori: string; // Menyimpan kategori pengeluaran
    Jumlah: real; // Menyimpan jumlah pengeluaran
    Deskripsi: string; // Menyimpan deskripsi pengeluaran
end;




PointerPengeluaran = ^Pengeluaran; // Definisi pointer untuk tipe data Pengeluaran

var
data: array[1..MAX] of PointerPengeluaran; // Array untuk menyimpan pointer ke record Pengeluaran
jumlahData: integer = 0; // Variabel untuk menghitung jumlah data yang dimasukkan
nama: string; // Nama pengguna
umur: integer; // Umur pengguna
nohp : integer;
alamat : string;
hobbi : string;
citacita : string;
status: string; // Status pengguna (pelajar, pekerja, dll)




// Fungsi untuk menambahkan data pengeluaran
function TambahPengeluaran: boolean;

var
    p: PointerPengeluaran; // Variabel pointer untuk data pengeluaran baru
begin
    if jumlahData >= MAX then // Cek apakah data sudah mencapai batas maksimum
    begin
        writeln('Data pengeluaran sudah mencapai batas maksimum.');
        TambahPengeluaran := false;
        exit;
    end;


    new(p); // Alokasi memori untuk data baru
    inc(jumlahData); // Tambahkan jumlah data

    // Input data pengeluaran baru
    write('Masukkan Tanggal (DD-MM-YYYY): ');
    readln(p^.Tanggal);

    write('Masukkan Kategori (Makanan, Transportasi, Hiburan, dll): ');
    readln(p^.Kategori);

    write('Masukkan Jumlah Pengeluaran: ');
    readln(p^.Jumlah);

    write('Masukkan Deskripsi (Opsional): ');
    readln(p^.Deskripsi);

    data[jumlahData] := p; // Simpan pointer ke array data
    writeln('Pengeluaran berhasil ditambahkan!');

    TambahPengeluaran := true;
end;




// Prosedur untuk menampilkan semua pengeluaran yang tercatat
procedure TampilkanPengeluaran;
var
    i: integer; // Variabel iterasi untuk looping

begin
    if jumlahData = 0 then // Cek apakah tidak ada data pengeluaran
    begin
        writeln('Tidak ada data pengeluaran.');
        exit;
    end;


    // Header tabel pengeluaran
    writeln('Daftar Pengeluaran Harian:');
    writeln('------------------------------------------------');
    writeln('No | Tanggal      | Kategori      | Jumlah    | Deskripsi');
    writeln('------------------------------------------------');

    for i := 1 to jumlahData do // Loop untuk mencetak data pengeluaran

begin
    with data[i]^ do
        begin
            writeln(i:2, ' | ', Tanggal:12, ' | ', Kategori:12, ' | Rp', FormatFloat('0.00', Jumlah):9, ' | ', Deskripsi);
        end;
    end;

    writeln('------------------------------------------------');
end;




// Fungsi untuk menghitung total pengeluaran
function HitungTotalPengeluaran: real;
var
    i: integer; // Variabel iterasi untuk looping
    total: real; // Variabel untuk menyimpan total pengeluaran


begin
    total := 0;

for i := 1 to jumlahData do // Loop untuk menjumlahkan semua data pengeluaran
        total := total + data[i]^.Jumlah;

    HitungTotalPengeluaran := total;
end;



// Prosedur untuk menghapus data pengeluaran berdasarkan nomor
procedure HapusPengeluaran(nomor: integer);
var
    i: integer; // Variabel iterasi untuk looping
begin
    if (nomor < 1) or (nomor > jumlahData) then // Validasi nomor yang dimasukkan


begin
    writeln('Nomor tidak valid.');
        exit;
    end;

dispose(data[nomor]); // Hapus memori dari data yang dipilih

for i := nomor to jumlahData - 1 do // Geser elemen-elemen berikutnya
        data[i] := data[i + 1];

    dec(jumlahData); // Kurangi jumlah data
    writeln('Pengeluaran berhasil dihapus.');
end;



// Prosedur untuk mencari pengeluaran berdasarkan kategori tertentu
procedure CariPengeluaranKategori(kategori: string);

var
    i: integer; // Variabel iterasi untuk looping
    ditemukan: boolean; // Menandai apakah data ditemukan atau tidak


begin
    ditemukan := false;
    writeln('Hasil Pencarian untuk kategori: ', kategori);
    writeln('------------------------------------------------');
    writeln('No | Tanggal      | Kategori      | Jumlah    | Deskripsi');
    writeln('------------------------------------------------');


for i := 1 to jumlahData do // Loop untuk mencari data yang sesuai
    begin
        if LowerCase(data[i]^.Kategori) = LowerCase(kategori) then
        begin
            ditemukan := true;
            with data[i]^ do
            begin
                writeln(i:2, ' | ', Tanggal:12, ' | ', Kategori:12, ' | Rp', FormatFloat('0.00', Jumlah):9, ' | ', Deskripsi);
            end;
        end;
    end;


if not ditemukan then // Jika tidak ada data yang ditemukan
        writeln('Tidak ada pengeluaran dengan kategori tersebut.');

    writeln('------------------------------------------------');
end;

// Prosedur untuk mengurutkan pengeluaran berdasarkan jumlah (terbesar ke terkecil)
procedure UrutkanPengeluaran;
var
    i, j: integer; // Variabel iterasi untuk looping
    temp: PointerPengeluaran; // Variabel sementara untuk swapping data
begin
    for i := 1 to jumlahData - 1 do
    begin
        for j := i + 1 to jumlahData do
        begin
            if data[i]^.Jumlah < data[j]^.Jumlah then // Urutkan secara descending
            begin
                temp := data[i];
                data[i] := data[j];
                data[j] := temp;
            end;
        end;
    end;
    writeln('Data pengeluaran berhasil diurutkan berdasarkan jumlah (terbesar ke terkecil).');
end;



// Prosedur untuk memberikan tips hemat kepada pengguna
procedure TipsHemat;
begin


writeln('Tips Hemat Pengeluaran:');
writeln('1. Buat anggaran bulanan dan patuhi rencana keuangan.');
writeln('2. Hindari membeli barang yang tidak diperlukan.');
writeln('3. Manfaatkan diskon dan promo dengan bijak.');
writeln('4. Kurangi pengeluaran untuk hal-hal yang kurang penting.');
writeln('5. Simpan sebagian pendapatan untuk tabungan atau investasi.');
writeln('6. Lakukan pencatatan pengeluaran secara rutin untuk evaluasi.');
writeln('7. Pilih jalan kaki atau bersepeda untuk jarak dekat.');
writeln('8. Masak sendiri daripada membeli makanan di luar.');
writeln('9. Simpan makanan dengan baik agar tidak cepat basi.');
writeln('10. Matikan lampu, AC, atau alat elektronik saat tidak digunakan.');
writeln('11. Cari hiburan yang gratis atau murah, seperti taman kota atau museum gratis.');
writeln('12. Kurangi kebiasaan nongkrong di kafe.');
writeln('13. Kurangi penggunaan layanan streaming berbayar jika tidak sering digunakan.');
writeln('14. Hindari makan berlebihan saat keluar untuk mengurangi pemborosan.');
writeln('15. Manfaatkan layanan carpooling untuk menghemat biaya bahan bakar.');
writeln('SELAMAT MENCOBA TIPS HEMAT DARI KELOMPOK KAMI Sparkling Fairies 🧚‍♀✨');


end;

// Prosedur untuk menampilkan grafik pengeluaran berdasarkan kategori
procedure GrafikPengeluaran;
var

    kategoriList: array[1..MAX] of string; // Array untuk menyimpan kategori unik
    jumlahList: array[1..MAX] of real; // Array untuk menyimpan total pengeluaran tiap kategori
    totalPengeluaran, persen: real; // Variabel untuk menyimpan total dan persentase
    i, j, kategoriCount: integer; // Variabel iterasi dan penghitung kategori
    found: boolean; // Menandai apakah kategori sudah ada
begin

    kategoriCount := 0;
    totalPengeluaran := 0;


    // Kumpulkan data kategori dan jumlah totalnya
    for i := 1 to jumlahData do
    begin
        found := false;
        for j := 1 to kategoriCount do
        begin
            if LowerCase(data[i]^.Kategori) = LowerCase(kategoriList[j]) then
            begin
                jumlahList[j] := jumlahList[j] + data[i]^.Jumlah;
                found := true;
                break;
            end;
        end;

        if not found then // Jika kategori belum ada, tambahkan
        begin
            inc(kategoriCount);
            kategoriList[kategoriCount] := data[i]^.Kategori;
            jumlahList[kategoriCount] := data[i]^.Jumlah;
        end;
    end;

    // Hitung total pengeluaran
    for i := 1 to kategoriCount do
        totalPengeluaran := totalPengeluaran + jumlahList[i];

    // Tampilkan grafik
    writeln('Grafik Pengeluaran Berdasarkan Kategori:');
    writeln('----------------------------------------------------------');
    writeln('| Kategori          | Total (Rp)    | Persentase | Grafik |');
    writeln('----------------------------------------------------------');

    for i := 1 to kategoriCount do

begin
        persen := (jumlahList[i] / totalPengeluaran) * 100;
        write('| ', kategoriList[i]:17, ' | Rp', FormatFloat('0.00', jumlahList[i]):10, ' | ', FormatFloat('0.00', persen):8, '% | ');
        for j := 1 to trunc(persen / 2) do
            write('#');
        writeln;

    end;
    writeln('----------------------------------------------------------');
    writeln('Total Pengeluaran: Rp', FormatFloat('0.00', totalPengeluaran));
end;


// Prosedur untuk menampilkan menu utama
procedure MenuUtama;
var
    pilihan: char; // Variabel untuk pilihan menu
    nomor: integer; // Variabel untuk nomor pengeluaran
    kategori: string; // Variabel untuk kategori pengeluaran
begin


    repeat
        clrscr; // Membersihkan layar


 // Tampilkan menu utama
        writeln('=== Sistem Pencatatan Pengeluaran Harian ===');
        writeln('=== Jangan biarkan uang mengendalikan hidup Anda,kendalikanlah uang untuk mencapai impian ===');
        writeln('=== Isi Pengeluaran Anda Untuk Mengetahui Hal-Hal yang Dibeli ===');
        writeln('Nama  : ', nama);
        writeln('Umur  : ', umur, ' tahun');
        writeln('nohp  : ', nohp);
        writeln('alamat  : ', alamat);
        writeln('hobbi : ', hobbi);
        writeln('citacita: ', citacita);
        writeln('Status: ', status);

        writeln('-------------------------------------------');
        writeln('1. Tambah Pengeluaran');
        writeln('2. Tampilkan Semua Pengeluaran');
        writeln('3. Hitung Total Pengeluaran');
        writeln('4. Hapus Pengeluaran');
        writeln('5. Cari Pengeluaran Berdasarkan Kategori');
        writeln('6. Urutkan Pengeluaran Berdasarkan Jumlah');
        writeln('7. Tips Hemat Pengeluaran');
        writeln('8. Tampilkan Grafik Pengeluaran Berdasarkan Kategori');
        writeln('9. Keluar');
        writeln('-------------------------------------------');

        write('Pilih menu (1-9): ');
        readln(pilihan);

        // Pilih menu berdasarkan input pengguna
        case pilihan of
            '1': TambahPengeluaran;
            '2': TampilkanPengeluaran;
            '3': writeln('Total Pengeluaran: Rp', FormatFloat('0.00', HitungTotalPengeluaran));
            '4': 

            begin
                write('Masukkan nomor pengeluaran yang ingin dihapus: ');
                readln(nomor);
                HapusPengeluaran(nomor);
            end;
            '5': 

            begin
                write('Masukkan kategori pengeluaran yang ingin dicari: ');
                readln(kategori);
                CariPengeluaranKategori(kategori);
            end;
            '6': UrutkanPengeluaran;
            '7': TipsHemat;
            '8': GrafikPengeluaran;
            '9': writeln('Terima kasih telah menggunakan sistem ini!');
        else
            writeln('Pilihan tidak valid. Silakan coba lagi.');

        end;

        if pilihan <> '9' then // Tunggu sebelum kembali ke menu utama

begin
        writeln;
        write('Tekan Enter untuk kembali ke menu utama...');
            readln;


end;
    until pilihan = '9'; // Ulangi sampai pengguna memilih keluar
end;



// Bagian utama program
begin
    clrscr;
    
    writeln('Selamat Datang di Sistem Pencatatan Pengeluaran Harian!');
    
    writeln('Program yang Kami Kembangkan Agar Dapat Berguna Untuk Semuanya !');

    // Input data pengguna
    write('Masukkan Nama Anda: ');
    readln(nama);

    write('Masukkan Umur Anda: ');
    readln(umur);

    write('Masukkan nohp Anda: ');
    readln(nohp);

    write('Masukkan alamat Anda: ');
    readln(alamat);

    write('Masukkan hobbi Anda: ');
    readln( hobbi );

    write('Masukkan citacita Anda: ');
    readln(citacita);

    write('Masukkan Status Anda (pelajar, pekerja, dll): ');
    readln(status);


 MenuUtama; // Panggil menu utama
end.

