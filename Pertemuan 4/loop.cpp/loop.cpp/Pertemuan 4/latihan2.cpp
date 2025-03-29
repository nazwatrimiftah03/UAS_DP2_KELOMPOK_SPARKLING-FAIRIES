#include <iostream>
using namespace std;

int main() {
    system ("CLS");
    string kalimat;
    
    cout << "Masukkan sebuah kalimat: ";
    getline(cin, kalimat);

    for (int i = 0; i < kalimat.length(); i++) {
        if (kalimat[i] == 'a' || kalimat[i] == 'e' || kalimat[i] == 'i' || 
            kalimat[i] == 'o' || kalimat[i] == 'u') {
            kalimat[i] = toupper(kalimat[i]);
        }
    }
    cout << "Kalimat hasil perubahan: " << kalimat << endl;
}