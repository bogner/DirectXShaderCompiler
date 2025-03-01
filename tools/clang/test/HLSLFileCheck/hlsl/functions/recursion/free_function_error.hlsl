// RUN: %dxc -T vs_6_2 -E main %s | FileCheck %s

// Test for recursion detection. Note that this cannot be a syntax test
// because we detect from the entry point and syntax tests have none.

// CHECK: error: recursive functions are not allowed: entry function calls recursive function 'A'

void B();
void A() { B(); }
void B() { A(); }

void main()
{
  A();
} 