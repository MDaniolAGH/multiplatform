/// Week 3 Lab Exercises -- Dart Fundamentals
///
/// Instructions:
/// - Implement each function where you see a // TODO marker.
/// - Run the file with: dart run exercises.dart
/// - The main() function at the bottom tests each exercise.
/// - Do NOT use AI tools. Write all code yourself.

// ============================================================================
// PART 1: Variables, Types & Basics
// ============================================================================

// Exercise 1: Patient Greeting
//
// Given a patient's name and age, return a greeting string using string
// interpolation. The format should be:
//   "Hello, <name>! You are <age> years old. Next year you will be <age+1>."
//
// Example: greetPatient('Alice', 30)
//   => "Hello, Alice! You are 30 years old. Next year you will be 31."
String greetPatient(String name, int age) {
  // TODO: implement using string interpolation
  return '';
}

// Exercise 2: Variable Declarations
//
// This function should demonstrate different variable types. Return a Map
// containing the following keys and values:
//   'name'       -> your name (String)
//   'age'        -> your age (int)
//   'height'     -> your height in meters (double)
//   'isStudent'  -> whether you are a student (bool)
//   'university' -> "AGH" (use a final variable)
//   'pi'         -> 3.14159 (use a const variable)
//
// All values must be non-null.
Map<String, dynamic> declareVariables() {
  // TODO: declare variables of different types and return them in a map
  return {};
}

// ============================================================================
// PART 2: Functions
// ============================================================================

// Exercise 3: BMI Calculator with Named Parameters
//
// Calculate BMI using the formula: weight / (height * height)
// Parameters:
//   - weightKg (required, named): weight in kilograms (double)
//   - heightM (required, named): height in meters (double)
// Return the BMI as a double, rounded to one decimal place.
//
// Hint: use double's toStringAsFixed(1) and then double.parse() to round,
//       or multiply/round/divide manually.
//
// Example: calculateBMI(weightKg: 70.0, heightM: 1.75) => 22.9
double calculateBMI({required double weightKg, required double heightM}) {
  // TODO: implement
  return 0.0;
}

// Exercise 4: Vital Signs Formatter
//
// Write a function that takes a heart rate (required, positional), a
// temperature in Celsius (optional positional, default 36.6), and returns
// a formatted string:
//   "HR: <heartRate> bpm, Temp: <temperature> C"
//
// Use arrow syntax (=>) for this function.
//
// Example: formatVitals(72)       => "HR: 72 bpm, Temp: 36.6 C"
// Example: formatVitals(80, 37.5) => "HR: 80 bpm, Temp: 37.5 C"
String formatVitals(int heartRate, [double temperature = 36.6]) {
  // TODO: implement using arrow syntax (replace the body with =>)
  return '';
}

// ============================================================================
// PART 3: Collections
// ============================================================================

// Exercise 5: Heart Rate Analysis
//
// Given a list of heart rate readings (integers), return a Map with:
//   'count'    -> total number of readings (int)
//   'average'  -> average heart rate rounded to 1 decimal (double)
//   'elevated' -> list of readings above 100 (List<int>)
//   'normal'   -> list of readings between 60 and 100 inclusive (List<int>)
//
// Use collection methods: .where(), .fold() or .reduce(), .length, .toList()
//
// Example: analyzeHeartRates([72, 85, 110, 65, 95, 130, 58])
//   => {'count': 7, 'average': 87.9, 'elevated': [110, 130],
//       'normal': [72, 85, 65, 95]}
Map<String, dynamic> analyzeHeartRates(List<int> readings) {
  // TODO: implement using collection methods
  return {};
}

// Exercise 6: Allergy Checker
//
// You are given two sets of drug names:
//   - patientAllergies: drugs the patient is allergic to
//   - prescribedDrugs: drugs the doctor wants to prescribe
//
// Return a Map with:
//   'safe'        -> drugs that can be safely prescribed (Set<String>)
//   'dangerous'   -> drugs that conflict with allergies (Set<String>)
//   'allKnown'    -> union of both sets (Set<String>)
//
// Example:
//   patientAllergies: {'penicillin', 'aspirin'}
//   prescribedDrugs:  {'aspirin', 'ibuprofen', 'amoxicillin'}
//   => { 'safe': {'ibuprofen', 'amoxicillin'},
//        'dangerous': {'aspirin'},
//        'allKnown': {'penicillin', 'aspirin', 'ibuprofen', 'amoxicillin'} }
Map<String, Set<String>> checkAllergies(
    Set<String> patientAllergies, Set<String> prescribedDrugs) {
  // TODO: implement using set operations (intersection, difference, union)
  return {};
}

// ============================================================================
// PART 4: Null Safety
// ============================================================================

// Exercise 7: Safe Patient Lookup
//
// Simulate looking up a patient by ID from a "database" (a Map).
// The function receives a Map<String, String> (id -> name) and a patient ID.
//
// If the patient is found, return "Patient found: <name>".
// If not found, return "Patient not found".
//
// You MUST use null-aware operators (?? or ?.) -- do NOT use an if/else.
//
// Example:
//   database: {'P001': 'Alice', 'P002': 'Bob'}
//   safePatientLookup(database, 'P001') => "Patient found: Alice"
//   safePatientLookup(database, 'P999') => "Patient not found"
String safePatientLookup(Map<String, String> database, String patientId) {
  // TODO: implement using null-aware operators
  return '';
}

// Exercise 8: Fix the Null Safety Errors
//
// The function below has intentional null safety problems.
// Your job: fix the function so it compiles AND handles nulls correctly.
//
// Rules:
//   - Do NOT change the function signature.
//   - The returned string should be:
//     "<name> (age <age>) - Diagnosis: <diagnosis or 'Not diagnosed'>"
//   - If name is null, use "Unknown".
//   - If age is null, use 0.
//
// Example:
//   fixNullSafety('Alice', 30, 'Flu')  => "Alice (age 30) - Diagnosis: Flu"
//   fixNullSafety(null, null, null)     => "Unknown (age 0) - Diagnosis: Not diagnosed"
String fixNullSafety(String? name, int? age, String? diagnosis) {
  // TODO: implement so that nulls are handled gracefully
  // Hint: use ?? operator for each nullable parameter
  return '';
}

// ============================================================================
// PART 5: OOP
// ============================================================================

// Exercise 9: Person / Patient / Doctor Class Hierarchy
//
// Create the following class hierarchy:
//
// 1. Class "Person" with:
//    - Fields: String name, int age
//    - Constructor that takes name and age
//    - Method: String introduce() => "I am <name>, age <age>."
//
// 2. Class "Patient" extends Person with:
//    - Additional field: String? diagnosis (nullable)
//    - Constructor: Patient(name, age, {this.diagnosis})
//    - Override introduce() to append " Diagnosis: <diagnosis or 'pending'>."
//
// 3. Class "Doctor" extends Person with:
//    - Additional field: String specialization
//    - Constructor: Doctor(name, age, this.specialization)
//    - Override introduce() to append " Specialization: <specialization>."
//
// Implement below (replace the placeholder classes):

// NOTE: The placeholder classes below will compile and run, but produce empty
// output. Replace them entirely with your implementation.

class Person {
  // TODO: add fields (name, age), constructor, and introduce() method
  String introduce() => '';
}

class Patient extends Person {
  // TODO: add diagnosis field, constructor calling super, override introduce()
  @override
  String introduce() => '';
}

class Doctor extends Person {
  // TODO: add specialization field, constructor calling super, override introduce()
  @override
  String introduce() => '';
}

// Exercise 10: Mixin -- Timestamped
//
// Create a mixin called "Timestamped" that:
//   - Has a field: DateTime createdAt (initialized to DateTime.now())
//   - Has a method: String timeStamp() that returns the createdAt as a string
//     formatted as "YYYY-MM-DD HH:MM" (use .toString() and substring, or
//     build it manually).
//
// Then create a class "MedicalRecord" that:
//   - Extends Object (default) and uses "with Timestamped"
//   - Has fields: String patientName, String description
//   - Constructor: MedicalRecord(this.patientName, this.description)
//   - Method: String summary() =>
//       "[$timeStamp] <patientName>: <description>"
//
// Implement below:

mixin Timestamped {
  // TODO: implement
  String timeStamp() => '';
}

class MedicalRecord with Timestamped {
  // TODO: implement
  String summary() => '';
}

// ============================================================================
// PART 6: Async Programming
// ============================================================================

// Exercise 11: Simulated API Call
//
// Write an async function that simulates fetching patient data from a server.
// It should:
//   1. Print "Fetching data for patient <id>..."
//   2. Wait for 1 second (use Future.delayed)
//   3. Return a Map with: {'id': id, 'name': 'Patient $id', 'heartRate': 72}
//
// The return type should be Future<Map<String, dynamic>>.
Future<Map<String, dynamic>> fetchPatientData(String id) async {
  // TODO: implement
  return {};
}

// Exercise 12: Multiple Async Calls
//
// Write an async function that:
//   1. Calls fetchPatientData for three patient IDs: 'P001', 'P002', 'P003'
//      -- all three calls should run IN PARALLEL (use Future.wait)
//   2. Returns a List of the three result Maps
//
// Hint: Future.wait([future1, future2, future3]) runs them concurrently
//       and returns a List of results.
Future<List<Map<String, dynamic>>> fetchMultiplePatients() async {
  // TODO: implement using Future.wait
  return [];
}

// ============================================================================
// MAIN -- Test your solutions
// ============================================================================

Future<void> main() async {
  print('=' * 60);
  print('EXERCISE 1: Patient Greeting');
  print(greetPatient('Alice', 30));
  print(greetPatient('Bob', 25));
  print('');

  print('=' * 60);
  print('EXERCISE 2: Variable Declarations');
  var vars = declareVariables();
  vars.forEach((key, value) => print('  $key: $value (${value.runtimeType})'));
  print('');

  print('=' * 60);
  print('EXERCISE 3: BMI Calculator');
  print('BMI(70kg, 1.75m): ${calculateBMI(weightKg: 70.0, heightM: 1.75)}');
  print('BMI(90kg, 1.80m): ${calculateBMI(weightKg: 90.0, heightM: 1.80)}');
  print('');

  print('=' * 60);
  print('EXERCISE 4: Vital Signs Formatter');
  print(formatVitals(72));
  print(formatVitals(80, 37.5));
  print('');

  print('=' * 60);
  print('EXERCISE 5: Heart Rate Analysis');
  var hrResult = analyzeHeartRates([72, 85, 110, 65, 95, 130, 58]);
  hrResult.forEach((key, value) => print('  $key: $value'));
  print('');

  print('=' * 60);
  print('EXERCISE 6: Allergy Checker');
  var allergyResult = checkAllergies(
    {'penicillin', 'aspirin'},
    {'aspirin', 'ibuprofen', 'amoxicillin'},
  );
  allergyResult.forEach((key, value) => print('  $key: $value'));
  print('');

  print('=' * 60);
  print('EXERCISE 7: Safe Patient Lookup');
  var db = {'P001': 'Alice', 'P002': 'Bob'};
  print(safePatientLookup(db, 'P001'));
  print(safePatientLookup(db, 'P999'));
  print('');

  print('=' * 60);
  print('EXERCISE 8: Fix Null Safety');
  print(fixNullSafety('Alice', 30, 'Flu'));
  print(fixNullSafety(null, null, null));
  print(fixNullSafety('Bob', 25, null));
  print('');

  print('=' * 60);
  print('EXERCISE 9: Class Hierarchy');
  // Uncomment the lines below once you have implemented the classes:
  // var patient = Patient('Alice', 30, diagnosis: 'Hypertension');
  // var doctor = Doctor('Dr. Smith', 45, 'Cardiology');
  // print(patient.introduce());
  // print(doctor.introduce());
  print('(Uncomment the test code in main() after implementing classes)');
  print('');

  print('=' * 60);
  print('EXERCISE 10: Mixin -- Timestamped');
  // Uncomment the lines below once you have implemented the mixin and class:
  // var record = MedicalRecord('Alice', 'Annual checkup - all clear');
  // print(record.summary());
  // print('Created at: ${record.timeStamp()}');
  print('(Uncomment the test code in main() after implementing mixin)');
  print('');

  print('=' * 60);
  print('EXERCISE 11: Simulated API Call');
  var patientData = await fetchPatientData('P001');
  print('Result: $patientData');
  print('');

  print('=' * 60);
  print('EXERCISE 12: Multiple Async Calls');
  var multiplePatients = await fetchMultiplePatients();
  for (var p in multiplePatients) {
    print('  $p');
  }
  print('');

  print('=' * 60);
  print('All exercises complete!');
}
