program marie_projeklab;
uses crt;
var 
    username, sandi : string; // login akun
    saldo : array[1..3] of longint;   // 1=makan, 2=kos, 3=tabungan
    nama  : array[1..3] of string;    // nama tiap pocket
    i     : integer;                    // penghitung loop
    totalPengeluaran, jumlahTransaksi : longint;
    totalPemasukan, sisaBudget, nominal : longint; // variabel untuk pemasukan dan alokasi
    menu, pilihPocket, percobaan : integer;        // pilihan menu, pilihan pocket & percobaan akun
    berhasil : boolean;                  // mendeteksi akun berhasil login atau tidak

procedure Login;
    begin
    berhasil := false;
    percobaan := 0;
    repeat
    write('Username : ');
    readln(username);
    write('Sandi    : ');
    readln(sandi);
    if (username = '') or (sandi = '') then
    begin
        writeln('Tidak boleh kosong');
        continue;
    end;
    if (username = 'admin') and (sandi = '1234') then
    begin
        berhasil := true;
        break;
    end;
    percobaan := percobaan + 1;
    writeln('Salah! Sisa kesempatan : ', 3 - percobaan);
    until percobaan = 3;
    end;

begin
    clrscr;
    // isi nama pocket
    nama[1] := 'Makan';
    nama[2] := 'Uang Kos';
    nama[3] := 'Tabungan';

    // set semua saldo jadi 0
    for i := 1 to 3 do
        saldo[i] := 0;
    totalPengeluaran := 0;
    jumlahTransaksi := 0;

    // siapkan login
    percobaan := 0;
    Login;              
    if berhasil then
    begin
    repeat
        clrscr;
        writeln('=== MENU SMART BUDGET ===');
        writeln('1. Input Pemasukan');
        writeln('0. Keluar');
        write('Pilihan Anda: ');
        readln(menu);
        
        case menu of
            1 : begin
                clrscr;
                writeln('=== INPUT PEMASUKAN HARI INI ===');
                write('Masukkan Total Pemasukan/Budget Hari Ini: ');
                readln(totalPemasukan);

                if totalPemasukan <= 0 then
                begin
                    writeln('Nominal budget harus lebih dari 0!');
                end
                else
                begin
                    sisaBudget := totalPemasukan;
                    writeln;
                    writeln('Silakan alokasikan budget Anda ke masing-masing kebutuhan:');
                    writeln('---------------------------------------------------------');

                    // Mengisi alokasi untuk setiap kebutuhan satu per satu
                    for i := 1 to 3 do
                    begin
                        repeat
                            writeln('Sisa budget yang belum dialokasikan: Rp ', sisaBudget);
                            write('Alokasi untuk ', nama[i], ': Rp ');
                            readln(nominal);

                            if nominal < 0 then
                                writeln('Nominal tidak boleh negatif!')
                            else if nominal > sisaBudget then
                                writeln('Nominal melebihi sisa budget yang ada! Masukkan ulang.')
                            else
                                break; // jika input valid, keluar dari loop repeat
                        until false;

                        // Tambahkan nominal ke saldo pocket terkait dan kurangi sisa budget
                        saldo[i] := saldo[i] + nominal;
                        sisaBudget := sisaBudget - nominal;
                        writeln;
                    end;

                    // Tampilkan Hasil Pengalokasian Hari Ini
                    clrscr;
                    writeln('==========================================');
                    writeln('     HASIL PENGALOKASIAN BUDGET HARI INI  ');
                    writeln('==========================================');
                    writeln('Total Pemasukan      : Rp ', totalPemasukan);
                    writeln('------------------------------------------');
                    writeln('1. Saldo Makan       : Rp ', saldo[1]);
                    writeln('2. Saldo Uang Kos    : Rp ', saldo[2]);
                    writeln('3. Saldo Tabungan    : Rp ', saldo[3]);
                    writeln('------------------------------------------');
                    writeln('Sisa Budget Bebas    : Rp ', sisaBudget);
                    writeln('==========================================');
                end;

                writeln;
                writeln('Tekan Enter untuk kembali ke menu...');
                readln;
                end;
            0 : writeln('Terima kasih sudah memakai Smart Budget');
            else
                begin
                    writeln('Pilihan tidak valid!');
                    writeln('Tekan Enter untuk melanjutkan...');
                    readln;
                end;
        end;
    until menu = 0;
    end
    else
    writeln('Akun Terkunci');
end.