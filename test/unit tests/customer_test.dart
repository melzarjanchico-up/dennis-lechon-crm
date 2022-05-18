import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dennis_lechon_crm/models/customer.dart';
import 'package:mockito/mockito.dart';
import 'customer_test.mocks.dart';

@GenerateMocks([Customer])
void main() {
  var customer = MockCustomer();

  group("Customer Info Test: ", () {
    test("when customer fills out all information", () {
      when(customer.firstName).thenReturn("Dianne");
      when(customer.middleName).thenReturn("Mang");
      when(customer.lastName).thenReturn("Ford");
      when(customer.adrBarangay).thenReturn("Tunghaan");
      when(customer.adrCity).thenReturn("Minglanilla");
      when(customer.adrProvince).thenReturn("Cebu");
      when(customer.adrStreet).thenReturn("Purok Molave");
      when(customer.adrZipcode).thenReturn("6046");
      when(customer.celNum).thenReturn("09986413792");
      when(customer.note).thenReturn("Sample note of the Customer");

      expect(customer.firstName, "Dianne");
      expect(customer.lastName, "Ford");
      expect(customer.middleName, "Mang");
      expect(customer.adrBarangay, "Tunghaan");
      expect(customer.adrProvince, "Cebu");
      expect(customer.adrCity, "Minglanilla");
      expect(customer.adrStreet, "Purok Molave");
      expect(customer.celNum, "09986413792");
      expect(customer.adrZipcode, "6046");
      expect(customer.note, "Sample note of the Customer");

      // Write test that would reject if there are numbers
      // Write test that would reject if nothing enters
    });
  });
}
