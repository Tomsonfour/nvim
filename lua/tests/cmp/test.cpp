#include <iostream>

using namespace std;

int prime(int n, int m) {
	if (n <= 1) return 0;
	for (int i = 2; i * i <= n; i++) {
		if (n % i == 0) return 0;
	}
	return 1;
}


int main() {
	cout << "Hello, World!" << endl;
	prime()
	return 0;
}


