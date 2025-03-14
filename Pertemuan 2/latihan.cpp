#include <iostream>
using namespace std;

const double PI = 3.141592653589793;

int main() {
    float luas, volume, r;

    cout << "Masukkan jari-jari bola: ";
    cin >> r;

    luas = 4 * PI * r * r;
    cout << "Luas permukaan bola = " << luas << endl;


    volume = (4.0 / 3.0) * PI * r * r * r;
    cout << "Volume bola = " << volume << endl;

    return 0;
}