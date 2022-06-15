## Professional Self-Assessment

WIP.

## Software Designing and Engineering: Encryption Project
![Encryption 1](https://user-images.githubusercontent.com/79820705/173484378-a50b7c79-9ab8-47dc-8a5b-8f79046e8d3e.png)
![Encryption 2](https://user-images.githubusercontent.com/79820705/173484388-e0ef4ce4-68e7-4c6f-89bd-145531a87f61.png)

The artifact I chose to enhance is an encryption program from a Secure Coding course I took, and it was created in April of 2021. It is written in C++. The original program takes an input text file (with some pre-generated text), loads it into a string, and then performs a XOR encryption on it. The program then saves the string into a file called encrypteddatafile.txt. It then does the same thing to decrypt the text, saving the decrypted text into decrypteddatafile.txt. '
	
I chose this artifact because it demonstrates several basic C++ competencies, such as reading from a file, using loops, use of ints and strings, saving data to a file, printing to the terminal, etc. It also demonstrates interest in and understanding of encryption and security, which is important for anyone who wants to get into cybersecurity in the future. I improved this artifact by implementing a menu that allows the user to choose whether to use the already-implemented XOR cipher algorithm, or the newly implemented Caesar Cipher algorithm. This expands the complexity of the artifact in an interesting way, and there is room to add even more encryption algorithms as the code was written in a modular fashion. With the added encryption algorithm and interactivity from the user, I have met the course objectives I planned to meet. The enhanced artifact uses algorithmic principles (in the encryption algorithms) to solve a given problem (namely encrypting strings that would otherwise be plaintext and easier to attack). The code also demonstrates the ability to use well-founded and innovating techniques to implementing computer solutions. The use of encryption algorithms demonstrates a security mindset that anticipates adversarial exploits in software architecture. Due to this, the enhanced artifact meets objectives CS-499-03, 04, and 05. 
	
When enhancing the artifact, one challenge for me was getting the Caesar Cipher to work. The famous Caesar Cipher is something that is easy to conceptualize and do on paper, but is much harder to do with C++. For example, using a key of four is easy to do in your head because we all know the alphabet by heart and can shift the letters easily. However, the algorithm to do that needs to be explicitly stated in the code, and there is no easy shortcut to perform that kind of shift due to the way letters are represented in the code. The solution I ended up using is a rather ugly (yet effective) series of if and else if statements in a for loop that iterates through the string and transforms the characters based on whether they are upper or lower case. Coming up with this solution required me to look on Github and other similar solutions, as well as looking at C++ documentation and learning how characters are represented in the code. I had to learn what it meant to “add” a number to a character to transform it into a different one. Overall, improving the artifact gave me a deeper understanding of the inner workings of the language.

### Original Code

~~~cpp
// Encryption.cpp : This file contains the 'main' function. 
// Program execution begins and ends there.

#include <cassert>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <ctime>

/// <summary>
/// encrypt or decrypt a source string using the provided key
/// </summary>
/// <param name="source">input string to process</param>
/// <param name="key">key to use in encryption / decryption</param>
/// <returns>transformed string</returns>
std::string encrypt_decrypt(const std::string& source, const std::string& key) 
{
  // get lengths now instead of calling the function every time.
  // this would have most likely been inlined by the compiler, but design for perfomance.
  const auto key_length = key.length();
  const auto source_length = source.length();

  // assert that our input data is good
  assert(key_length > 0);
  assert(source_length > 0);

  std::string output = source;

  // loop through the source string char by char
  for (size_t i = 0; i < source_length; ++i)
  { // TODO: student need to change the next line from output[i] = source[i]
    // transform each character based on an xor of the key modded constrained to key length using a mod
    output[i] = source[i] ^ key[i % key_length];
  }

  // our output length must equal our source length
  assert(output.length() == source_length);

  // return the transformed string
  return output;
}

std::string read_file(const std::string& filename)
{
  std::string file_text = "John Q. Smith\nThis is my test string";

  // TODO: implement loading the file into a string

  std::ifstream inputfile;

  inputfile.open(filename);

  file_text.assign((std::istreambuf_iterator<char>(inputfile)), 
  (std::istreambuf_iterator<char>()));


  inputfile.close();

  return file_text;
}

std::string get_student_name(const std::string& string_data)
{
  std::string student_name;

  // find the first newline
  size_t pos = string_data.find('\n');
  // did we find a newline
  if (pos != std::string::npos)
  { // we did, so copy that substring as the student name
    student_name = string_data.substr(0, pos);
  }

  return student_name;
}

void save_data_file(const std::string& filename, const std::string& student_name, const std::string& key, const std::string& data)
{
  //  TODO: implement file saving
  //  file format
  

    std::fstream file;
    file.open(filename);
    file << student_name << std::endl;
    file << "2021/04/02" << std::endl;
    file << key << std::endl;
    file << data << std::endl;

    file.close();
    

  //  Line 1: student name
  //  Line 2: timestamp (yyyy-mm-dd)
  //  Line 3: key used
  //  Line 4+: data


}

int main()
{
  std::cout << "Encyption Decryption Test!" << std::endl;

  // input file format
  // Line 1: <students name>
  // Line 2: <Lorem Ipsum Generator website used> https://pirateipsum.me/ (could be https://www.lipsum.com/ or one of https://www.shopify.com/partners/blog/79940998-15-funny-lorem-ipsum-generators-to-shake-up-your-design-mockups)
  // Lines 3+: <lorem ipsum generated with 3 paragraphs> 
  //  Fire in the hole bowsprit Jack Tar gally holystone sloop grog heave to grapple Sea Legs. Gally hearties case shot crimp spirits pillage galleon chase guns skysail yo-ho-ho. Jury mast coxswain measured fer yer chains man-of-war Privateer yardarm aft handsomely Jolly Roger mutiny.
  //  Hulk coffer doubloon Shiver me timbers long clothes skysail Nelsons folly reef sails Jack Tar Davy Jones' Locker. Splice the main brace ye fathom me bilge water walk the plank bowsprit gun Blimey wench. Parrel Gold Road clap of thunder Shiver me timbers hempen halter yardarm grapple wench bilged on her anchor American Main.
  //  Brigantine coxswain interloper jolly boat heave down cutlass crow's nest wherry dance the hempen jig spirits. Interloper Sea Legs plunder shrouds knave sloop run a shot across the bow Jack Ketch mutiny barkadeer. Heave to gun matey Arr draft jolly boat marooned Cat o'nine tails topsail Blimey.

  const std::string file_name = "inputdatafile.txt";
  const std::string encrypted_file_name = "encrypteddatafile.txt";
  const std::string decrypted_file_name = "decrytpteddatafile.txt";
  const std::string source_string = read_file(file_name);
  const std::string key = "password";

  // get the student name from the data file
  const std::string student_name = get_student_name(source_string);

  // encrypt sourceString with key
  const std::string encrypted_string = encrypt_decrypt(source_string, key);

  // save encrypted_string to file
  save_data_file(encrypted_file_name, student_name, key, encrypted_string);

  // decrypt encryptedString with key
  const std::string decrypted_string = encrypt_decrypt(encrypted_string, key);

  // save decrypted_string to file
  save_data_file(decrypted_file_name, student_name, key, decrypted_string);

  std::cout << "Read File: " << file_name << " - Encrypted To: " << encrypted_file_name << " - Decrypted To: " << decrypted_file_name << std::endl;

  // students submit input file, encrypted file, decrypted file, source code file, and key used
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

~~~

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Enhanced Code

```cpp
  // ========================================================
  //This program reads a string of text from a file and encrypts it
  //using various encryption algorithms.
  //by Jeremiah Norcross
  // ========================================================

  #include <cassert>
  #include <fstream>
  #include <iomanip>
  #include <iostream>
  #include <sstream>
  #include <ctime>

  /// encrypt or decrypt a source string using the provided key and a XOR cipher
  std::string xor_encrypt_decrypt(const std::string& source, const std::string& key)
  {
    // get lengths now instead of calling the function every time.
    // this would have most likely been inlined by the compiler, but design for perfomance.
    const auto key_length = key.length();
    const auto source_length = source.length();

    // assert that our input data is good
    assert(key_length > 0);
    assert(source_length > 0);

    std::string output = source;

    // loop through the source string char by char
    for (size_t i = 0; i < source_length; ++i)
    { 
      // transform each character based on an xor of the key modded constrained to key length using a mod
      output[i] = source[i] ^ key[i % key_length];
    }

    // our output length must equal our source length
    assert(output.length() == source_length);

    // return the transformed string
    return output;
  }

  /// Encrypt source string using Caeser Cipher
  std::string caesar_encrypt(const std::string& source, int key)
  {

      const auto source_length = source.length();

      //as above, assert data is good
      assert(source_length > 0);

      int k = key;

      std::string output = source;

      //iterate through text
      for (size_t i = 0; i < source_length; ++i)
      {
          char ch = source[i];
          //encrypt lowercase letters
          if (ch >= 'a' && ch <= 'z') {
              ch = ch + k;
              if (ch > 'z') {
                  ch = ch - 'z' + 'a' - 1;
              }
              output[i] = ch;
          }
          //encrypt uppercase letters
          else if (ch >= 'A' && ch <= 'Z') {
              ch = ch + k;
              if (ch > 'Z') {
                  ch = ch - 'Z' + 'A' - 1;
              }
              output[i] = ch;
          }
      }

      // our output length must equal our source length
      assert(output.length() == source_length);

      // return the transformed string
      return output;
  }

  /// Decrypt source string using Caeser Cipher
  std::string caesar_decrypt(const std::string& source, int key)
  {

      const auto source_length = source.length();

      //as above, assert data is good
      assert(source_length > 0);

      int k = key;

      std::string output = source;

      //iterate through text
      for (size_t i = 0; i < source_length; ++i)
      {
          char ch = source[i];
          //encrypt lowercase letters
          if (ch >= 'a' && ch <= 'z') {
              ch = ch - k;
              if (ch < 'a') {
                  ch = ch + 'z' - 'a' + 1;
              }
              output[i] = ch;
          }
          //encrypt uppercase letters
          else if (ch >= 'A' && ch <= 'Z') {
              ch = ch - k;
              if (ch < 'A') {
                  ch = ch + 'Z' - 'A' + 1;
              }
              output[i] = ch;
          }
      }

      // our output length must equal our source length
      assert(output.length() == source_length);

      // return the transformed string
      return output;
  }


  //loads file into string
  std::string read_file(const std::string& filename)
  {
    std::string file_text = "John Q. Smith\nThis is my test string";


    std::ifstream inputfile;

    inputfile.open(filename);

    file_text.assign((std::istreambuf_iterator<char>(inputfile)),
    (std::istreambuf_iterator<char>()));


    inputfile.close();

    return file_text;
  }

  std::string get_student_name(const std::string& string_data)
  {
    std::string student_name;

    // find the first newline
    size_t pos = string_data.find('\n');
    // did we find a newline
    if (pos != std::string::npos)
    { // we did, so copy that substring as the student name
      student_name = string_data.substr(0, pos);
    }

    return student_name;
  }

  //saves info to the data file
  //Includes my name, key used, and current date for demonstration purposes
  void save_data_file(const std::string& filename, const std::string& key, const std::string& data)
  {
      std::fstream file;
      file.open(filename);
      file << "Key used: " << key << std::endl;
      file << data << std::endl;

      file.close();

  }

  int main()
  {
    std::cout << "Encyption Decryption Test!" << std::endl;

    const std::string file_name = "inputdatafile.txt";
    const std::string encrypted_file_name = "encrypteddatafile.txt";
    const std::string decrypted_file_name = "decrytpteddatafile.txt";
    const std::string source_string = read_file(file_name);
    std::string key = "password";
    std::string encrypted_string = "ENCRYPTION FAILED"; //these defaults will save to file if the encryption/decryption fails
    std::string decrypted_string = "DECRYPTION FAILED"; //this is good for troubleshooting
    int caesar_key = 0; //initalize caesar key as 0 for now

    //Presents user with choice for different ciphers
    int choice = 0;
    while (choice != 9) {
        std::cout << "Menu:" << std::endl;
        std::cout << "  1. XOR Encryption" << std::endl;
        std::cout << "  2. Caesar Cipher" << std::endl;
        std::cout << "  9. Exit" << std::endl;
        std::cout << "Enter choice: ";
        std::cin >> choice;

        switch (choice) {
        case 1:
            std::cout << "You have selected the XOR encryption cipher!" << std::endl;

            //encrypts using XOR cipher
            encrypted_string = xor_encrypt_decrypt(source_string, key);
            // decrypt encryptedString with key
            decrypted_string = xor_encrypt_decrypt(encrypted_string, key);

            choice = 9; //this will cause while loop to break automatically
            break;
        case 2:
            std::cout << "You have selected the Caesar Cipher!" << std::endl;
            std::cout << "Enter the key for this cipher: " << std::endl;
            std::cin >> caesar_key; //user can pick key for the caesar cipher

            //encrypts user Caeser Cipher
            encrypted_string = caesar_encrypt(source_string, caesar_key);

            //decrypts
            decrypted_string = caesar_decrypt(encrypted_string, caesar_key);

            key = std::to_string(caesar_key); //converts key to string so it can be printed in the file

            choice = 9; //this will cause while loop to break automatically
            break;

        }
    }

    // save encrypted_string to file
    save_data_file(encrypted_file_name, key, encrypted_string);

    // save decrypted_string to file
    save_data_file(decrypted_file_name, key, decrypted_string);

    std::cout << "Read File: " << file_name << " - Encrypted To: " << encrypted_file_name << " - Decrypted To: " << decrypted_file_name << std::endl;
    std::cout << "Encryption successful! Check inputdatafile against decrypteddatafile to verify! Press any key to close the application." << std::endl;

    system("pause");

  }
  
```
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Algorithm and Data Structures: Vector Sorting Project
![image](https://user-images.githubusercontent.com/79820705/173485528-772da47a-ebd6-42f5-bb5a-159a060cc530.png)

The artifact I chose for the Data Structures and Algorithm section is a C++ project I worked on for an algorithms course in late 2020. It’s a program that reads from a CSV file filled with ‘bids’ for various ‘auction items’ and loads them into structs and then into a vector. The user is presented with a menu, which allows them to display the list of bids and then sort them using either a selection sort or a quicksort. The program also tracks the time taken to perform each sort for demonstration purposes. 

I chose this artifact because the use of vectors and structs demonstrates a strong understanding of data structures. It also uses two different sorting algorithms, which demonstrates an understanding of algorithm concepts. The quicksort algorithm uses recursion, which is another skill that is therefore exemplified by this project. I improved the artifact by writing two new algorithms: A bubble sort algorithm and an insertion sort algorithm. The code was written in a modular fashion, making these new additions relatively easy to implement. These two new additions further demonstrate experience in writing algorithms to accomplish specific goals. 

After finishing the enhancements, I have met the course outcomes I planned to meet. The four algorithms demonstrate the ability to design computing solutions that solve a given problem (sorting bids) using algorithmic principles. This lines up with course outcome CS-499-03. The variety of algorithms available, which vary in speed and efficiency, demonstrates the ability to manage the trade-off involved in design choices. 

The original code was, somehow, not complete when I began my enhancement. Some of the inclusions in the header did not work as intended. As a result, I ran into challenges getting the program to work initially (as it had been two years since I had worked on it), and it was a little challenging to figure out what the problem was. Creating and improving this project helped me to understand structs a lot more, which was initially a challenging concept to wrap my head around. Figuring out the logic behind various sorting algorithms was also very enlightening, as it required me to think in terms of for loops and while loops, which is a fundamental concept in C++ and programming in general. In developing this artifact, I have gained a much better understanding of loops, structs, data structures, and the deceptively simple logic behind commonplace sorting algorithms. 

### Original Code

```cpp

//============================================================================
// Name        : VectorSorting.cpp
// Author      : Jeremiah Norcross
// Version     : 1.0
// Copyright   : Copyright © 2017 SNHU COCE
// Description : Vector Sorting Algorithms
//============================================================================

#include <algorithm>
#include <iostream>
#include <time.h>

#include "CSVparser.hpp"

using namespace std;

//============================================================================
// Global definitions visible to all methods and classes
//============================================================================
int l = 0;
int h = 0;
int midpoint = 0;
string temp = "";
string pivot = "";
bool done = false;



// forward declarations
double strToDouble(string str, char ch);

// define a structure to hold bid information
struct Bid {
    string bidId; // unique identifier
    string title;
    string fund;
    double amount;
    Bid() {
        amount = 0.0;
    }
};

//============================================================================
// Static methods used for testing
//============================================================================

/**
 * Display the bid information to the console (std::out)
 *
 * @param bid struct containing the bid info
 */
void displayBid(Bid bid) {
    cout << bid.bidId << ": " << bid.title << " | " << bid.amount << " | "
            << bid.fund << endl;
    return;
}

/**
 * Prompt user for bid information using console (std::in)
 *
 * @return Bid struct containing the bid info
 */
Bid getBid() {
    Bid bid;

    cout << "Enter Id: ";
    cin.ignore();
    getline(cin, bid.bidId);

    cout << "Enter title: ";
    getline(cin, bid.title);

    cout << "Enter fund: ";
    cin >> bid.fund;

    cout << "Enter amount: ";
    cin.ignore();
    string strAmount;
    getline(cin, strAmount);
    bid.amount = strToDouble(strAmount, '$');

    return bid;
}

/**
 * Load a CSV file containing bids into a container
 *
 * @param csvPath the path to the CSV file to load
 * @return a container holding all the bids read
 */
vector<Bid> loadBids(string csvPath) {
    cout << "Loading CSV file " << csvPath << endl;

    // Define a vector data structure to hold a collection of bids.
    vector<Bid> bids;

    // initialize the CSV Parser using the given path
    csv::Parser file = csv::Parser(csvPath);

    try {
        // loop to read rows of a CSV file
        for (int i = 0; i < file.rowCount(); i++) {

            // Create a data structure and add to the collection of bids
            Bid bid;
            bid.bidId = file[i][1];
            bid.title = file[i][0];
            bid.fund = file[i][8];
            bid.amount = strToDouble(file[i][4], '$');

            //cout << "Item: " << bid.title << ", Fund: " << bid.fund << ", Amount: " << bid.amount << endl;

            // push this bid to the end
            bids.push_back(bid);
        }
    } catch (csv::Error &e) {
        std::cerr << e.what() << std::endl;
    }
    return bids;
}

// FIXME (2a): Implement the quick sort logic over bid.title

/**
 * Partition the vector of bids into two parts, low and high
 *
 * @param bids Address of the vector<Bid> instance to be partitioned
 * @param begin Beginning index to partition
 * @param end Ending index to partition
 */
int partition(vector<Bid>& bids, int begin, int end) {
	// Initialize variables
	int l = 0;
	int h = 0;
	int midpoint = 0;
	string temp = "";
	string pivot = "";
	bool done = false;

	// Pick middle value as the pivot

	midpoint = begin + (end - begin) / 2;
	pivot = bids.at(midpoint).title;

	l = begin;
	h = end;

	while (!done) {
		// Increments 1 while bids[midpoint] < pivot
		while (bids.at(l).title < pivot) {
			++l;
		}


		while (pivot < bids.at(h).title) {
			--h;
		}


		//Return h if there are zero or one items remaining (all bids are partitioned)
		if (l >= h) {
			done = true;
		}
		else {
			// swap bids[l] and bids[h], update l and h
			temp = bids.at(l).title;
			bids.at(l).title = bids.at(h).title;
			bids.at(h).title = temp;

			++l;
			--h;
		}

	}
	return h;
}

/**
 * Perform a quick sort on bid title
 * Average performance: O(n log(n))
 * Worst case performance O(n^2))
 *
 * @param bids address of the vector<Bid> instance to be sorted
 * @param begin the beginning index to sort on
 * @param end the ending index to sort on
 */
void quickSort(vector<Bid>& bids, int begin, int end) {
	int j = 0;

	/* Base case (for due diligence): If there are 1 or zero elements,
	 * partition is already sorted. Return.
	 */
	if (begin >= end) {
		return;
	}

	// Partition array. j is location of last element in low partition
	j = partition(bids, begin, end);

	//Recursively sort low and high partitions
	quickSort(bids, begin, j);
	quickSort(bids, j + 1, end);

	return;
}

// FIXME (1a): Implement the selection sort logic over bid.title

/**
 * Perform a selection sort on bid title
 * Average performance: O(n^2))
 * Worst case performance O(n^2))
 *
 * @param bid address of the vector<Bid>
 *            instance to be sorted
 */
void selectionSort(vector<Bid>& bids) {
	int i = 0;
	int j = 0;
	int indexSmallest = 0;
	int size = bids.size();

	for (i = 0; i < size - 1; i++) {

		//Find index of lowest remaining element
		indexSmallest = i;
		for (j = i + 1; j < size; ++j) {

			if (bids.at(j).title < bids.at(indexSmallest).title) {
				indexSmallest = j;
			}
		}

		//Swap bids.at(i).title and bids.at(indexSmallest).title
		string temp = bids.at(i).title;
		bids.at(i).title = bids.at(indexSmallest).title;
		bids.at(indexSmallest).title = temp;

	}
}

/**
 * Simple C function to convert a string to a double
 * after stripping out unwanted char
 *
 * credit: http://stackoverflow.com/a/24875936
 *
 * @param ch The character to strip out
 */
double strToDouble(string str, char ch) {
    str.erase(remove(str.begin(), str.end(), ch), str.end());
    return atof(str.c_str());
}

/**
 * The one and only main() method
 */
int main(int argc, char* argv[]) {

    // process command line arguments
    string csvPath;
    switch (argc) {
    case 2:
        csvPath = argv[1];
        break;
    default:
        csvPath = "eBid_Monthly_Sales_Dec_2016.csv";
    }

    // Define a vector to hold all the bids
    vector<Bid> bids;

    // Define a timer variable
    clock_t ticks;

    int choice = 0;
    while (choice != 9) {
        cout << "Menu:" << endl;
        cout << "  1. Load Bids" << endl;
        cout << "  2. Display All Bids" << endl;
        cout << "  3. Selection Sort All Bids" << endl;
        cout << "  4. Quick Sort All Bids" << endl;
        cout << "  9. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {

        case 1:
            // Initialize a timer variable before loading bids
            ticks = clock();

            // Complete the method call to load the bids
            bids = loadBids(csvPath);

            cout << bids.size() << " bids read" << endl;

            // Calculate elapsed time and display result
            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;

        case 2:
            // Loop and display the bids read
            for (int i = 0; i < bids.size(); ++i) {
                displayBid(bids[i]);
            }
            cout << endl;

            break;

        // FIXME (1b): Invoke the selection sort and report timing results

        case 3:

            selectionSort(bids);

            cout << "Bids selection sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;
        // FIXME (2b): Invoke the quick sort and report timing results

        case 4:
        	quickSort(bids, 0, bids.size() - 1);

        	cout << "Bids quick sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;
        }
    }

    cout << "Good bye." << endl;

    return 0;
}
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

### Enhanced Code

```cpp
//============================================================================
// Name        : VectorSorting.cpp
// Author      : Jeremiah Norcross
// Version     : 1.0
// Copyright   : Copyright © 2022 SNHU COCE
// Description : Vector Sorting Algorithms
//============================================================================

#include <algorithm>
#include <iostream>
#include <time.h>

#include "CSVparser.hpp"
#include "CSVparser.cpp"

using namespace std;

//============================================================================
// Global definitions visible to all methods and classes
//============================================================================
int l = 0;
int h = 0;
int midpoint = 0;
string temp = "";
string pivot = "";
bool done = false;



// forward declarations
double strToDouble(string str, char ch);

// define a structure to hold bid information
struct Bid {
    string bidId; // unique identifier
    string title;
    string fund;
    double amount;
    Bid() {
        amount = 0.0;
    }
};

//============================================================================
// Static methods used for testing
//============================================================================

/**
 * Display the bid information to the console (std::out)
 *
 * @param bid struct containing the bid info
 */
void displayBid(Bid bid) {
    cout << bid.bidId << ": " << bid.title << " | " << bid.amount << " | "
            << bid.fund << endl;
    return;
}

/**
 * Prompt user for bid information using console (std::in)
 *
 * @return Bid struct containing the bid info
 */
Bid getBid() {
    Bid bid;

    cout << "Enter Id: ";
    cin.ignore();
    getline(cin, bid.bidId);

    cout << "Enter title: ";
    getline(cin, bid.title);

    cout << "Enter fund: ";
    cin >> bid.fund;

    cout << "Enter amount: ";
    cin.ignore();
    string strAmount;
    getline(cin, strAmount);
    bid.amount = strToDouble(strAmount, '$');

    return bid;
}

/**
 * Load a CSV file containing bids into a container
 *
 * @param csvPath the path to the CSV file to load
 * @return a container holding all the bids read
 */
vector<Bid> loadBids(string csvPath) {
    cout << "Loading CSV file " << csvPath << endl;

    // Define a vector data structure to hold a collection of bids.
    vector<Bid> bids;

    // initialize the CSV Parser using the given path
    csv::Parser file = csv::Parser(csvPath);

    try {
        // loop to read rows of a CSV file
        for (int i = 0; i < file.rowCount(); i++) {

            // Create a data structure and add to the collection of bids
            Bid bid;
            bid.bidId = file[i][1];
            bid.title = file[i][0];
            bid.fund = file[i][8];
            bid.amount = strToDouble(file[i][4], '$');

            //cout << "Item: " << bid.title << ", Fund: " << bid.fund << ", Amount: " << bid.amount << endl;

            // push this bid to the end
            bids.push_back(bid);
        }
    } catch (csv::Error &e) {
        std::cerr << e.what() << std::endl;
    }
    return bids;
}

/**
 * Partition the vector of bids into two parts, low and high
 *
 * @param bids Address of the vector<Bid> instance to be partitioned
 * @param begin Beginning index to partition
 * @param end Ending index to partition
 */
int partition(vector<Bid>& bids, int begin, int end) {
	// Initialize variables
	int l = 0;
	int h = 0;
	int midpoint = 0;
	string temp = "";
	string pivot = "";
	bool done = false;

	// Pick middle value as the pivot

	midpoint = begin + (end - begin) / 2;
	pivot = bids.at(midpoint).title;

	l = begin;
	h = end;

	while (!done) {
		// Increments 1 while bids[midpoint] < pivot
		while (bids.at(l).title < pivot) {
			++l;
		}


		while (pivot < bids.at(h).title) {
			--h;
		}


		//Return h if there are zero or one items remaining (all bids are partitioned)
		if (l >= h) {
			done = true;
		}
		else {
			// swap bids[l] and bids[h], update l and h
			temp = bids.at(l).title;
			bids.at(l).title = bids.at(h).title;
			bids.at(h).title = temp;

			++l;
			--h;
		}

	}
	return h;
}

/**
 * Perform a quick sort on bid title
 * Average performance: O(n log(n))
 * Worst case performance O(n^2))
 *
 * @param bids address of the vector<Bid> instance to be sorted
 * @param begin the beginning index to sort on
 * @param end the ending index to sort on
 */
void quickSort(vector<Bid>& bids, int begin, int end) {
	int j = 0;

	/* Base case (for due diligence): If there are 1 or zero elements,
	 * partition is already sorted. Return.
	 */
	if (begin >= end) {
		return;
	}

	// Partition array. j is location of last element in low partition
	j = partition(bids, begin, end);

	//Recursively sort low and high partitions
	quickSort(bids, begin, j);
	quickSort(bids, j + 1, end);

	return;
}

/**
 * Perform a selection sort on bid title
 * Average performance: O(n^2))
 * Worst case performance O(n^2))
 *
 * @param bid address of the vector<Bid>
 *            instance to be sorted
 */
void selectionSort(vector<Bid>& bids) {
	int i = 0;
	int j = 0;
	int indexSmallest = 0;
	int size = bids.size();

	for (i = 0; i < size - 1; i++) {

		//Find index of lowest remaining element
		indexSmallest = i;
		for (j = i + 1; j < size; ++j) {

			if (bids.at(j).title < bids.at(indexSmallest).title) {
				indexSmallest = j;
			}
		}

		//Swap bids.at(i).title and bids.at(indexSmallest).title
		string temp = bids.at(i).title;
		bids.at(i).title = bids.at(indexSmallest).title;
		bids.at(indexSmallest).title = temp;

	}
}

/**
 * Perform a selection sort on bid title
 * Average performance: O(n log(n)))
 * Worst case performance O(n^2))
 *
 * @param bid address of the vector<Bid>
 *            instance to be sorted
 */
void bubbleSort(vector<Bid>& bids) {
    int i = 0;
    int j = 0;
    int size = bids.size();

    for (i = 0; i < size - 1; i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (bids.at(j).title > bids.at(j + 1).title) { //compare title at current position and next position
                swap(bids.at(j), bids.at(j + 1)); //swap if current is larger than next
            }
        }
    }

}
/**
 * Perform an insertion sort on bid title
 * Average performance: O(n log(n)))
 * Worst case performance O(n^2))
 *
 * @param bid address of the vector<Bid>
 *            instance to be sorted
 */
void insertionSort(vector<Bid>& bids) {
    int i = 1;
    int j = 0;
    int size = bids.size();

    for (i = 1; i < size; i++) {
        j = i;
        while (j > 0 && bids.at(j).title < bids.at(j - 1).title) { //checks if in correct order
            swap(bids.at(j), bids.at(j - 1)); //swaps if not
            j--;
        }
    }

}

/**
 * Simple C function to convert a string to a double
 * after stripping out unwanted char
 *
 * credit: http://stackoverflow.com/a/24875936
 *
 * @param ch The character to strip out
 */
double strToDouble(string str, char ch) {
    str.erase(remove(str.begin(), str.end(), ch), str.end());
    return atof(str.c_str());
}

/**
 * The one and only main() method
 */
int main(int argc, char* argv[]) {

    // process command line arguments
    string csvPath;
    switch (argc) {
    case 2:
        csvPath = argv[1];
        break;
    default:
        csvPath = "eBid_Monthly_Sales_Dec_2016.csv";
    }

    // Define a vector to hold all the bids
    vector<Bid> bids;

    // Define a timer variable
    clock_t ticks;

    int choice = 0;
    while (choice != 9) {
        cout << "Menu:" << endl;
        cout << "  1. Load Bids" << endl;
        cout << "  2. Display All Bids" << endl;
        cout << "  3. Selection Sort All Bids" << endl;
        cout << "  4. Quick Sort All Bids" << endl;
        cout << "  5. Bubble Sort All Bids" << endl;
        cout << "  6. Insertion Sort All Bids" << endl;
        cout << "  9. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice) {

        case 1:
            // Initialize a timer variable before loading bids
            ticks = clock();

            // Complete the method call to load the bids
            bids = loadBids(csvPath);

            cout << bids.size() << " bids read" << endl;

            // Calculate elapsed time and display result
            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;

        case 2:
            // Loop and display the bids read
            for (int i = 0; i < bids.size(); ++i) {
                displayBid(bids[i]);
            }
            cout << endl;

            break;

        case 3:

            selectionSort(bids);

            cout << "Bids selection sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;

        case 4:
        	quickSort(bids, 0, bids.size() - 1);

        	cout << "Bids quick sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

            break;


        case 5:
            bubbleSort(bids);

            cout << "Bids bubble sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;

        case 6:
            insertionSort(bids);

            cout << "Bids insertion sorted!" << endl;

            ticks = clock() - ticks; // current clock ticks minus starting clock ticks
            cout << "time: " << ticks << " clock ticks" << endl;
            cout << "time: " << ticks * 1.0 / CLOCKS_PER_SEC << " seconds" << endl;
        }
    }

    cout << "Good bye." << endl;

    return 0;
}
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Databases: MySQL Database Project

To demonstrate this enhancement, I recorded a [short video](https://www.youtube.com/watch?v=ngnQKZtPAnM) to demonstrate my use of AWS and MySQL Workbench. 

The original artifact was a SQL script that I wrote for an introductory SQL course (DAD 220) that I took at the end of 2019. The original project involved using a MySQL database. The script creates a database called “Messaging”, and then populates the database with various tables to simulate a database of messages sent between various Olympic athletes. The intention of the artifact was to demonstrate basic SQL skills. I chose this artifact for that exact purpose. The script contains basic SQL queries such as “CREATE”, “ALTER”, “UPDATE”, “INSERT”, “SELECT”, etc. It therefore demonstrates understanding of database concepts and a solid grasp of CRUD concepts. The artifact shows that I understand how to use SQL to create tables, insert rows and columns, and display the tables in increasingly complex ways using various joins. 

The original project used a MySQL client and server that had already been set up before by the professor. Therefore, to enhance the project, I used Amazon’s AWS service to create and host my own database. Then, I used the MySQL Workbench to submit the queries to it. I did not significantly alter the script itself, though I did condense the content, clean up the comments, and add a few more create statements. Using AWS and the MySQL Workbench to host and query the database demonstrates the ability to use real-world tools to solve problems, and better showcases my ability to work with databases in the real world. Rather than just tinkering with a script to show my theoretical knowledge of databases, I used AWS and the MySQL workbench (two widely used tools) to put my knowledge and skills into a real, tangible product. I met the course outcomes I intended to meet. The use of AWS and MySQL workbench demonstrates, first and foremost, the ability to use real-world tools in computing practices to accomplish specific goals. It also demonstrates database administration skills and a firm grasp of SQL concepts. This accomplishes goal CS-499-04. 

I had not used AWS or the MySQL Workbench before, so learning how to do so was both challenging and rewarding. I spent a lot of time reading documentation and tutorials so that I could get a solid grasp on AWS and the MySQL Workbench client. I faced some challenges in creating the database and getting the MySQL Workbench client to connect to it. I found myself unable to connect, and spent a good deal of time troubleshooting. As it turned out, I had a security feature turned on that disallowed access from my remote machine. Overall, I now have a much better understanding of how to create and manage databases in the real world, and how to connect to those databases to perform queries. 



### Original Code
```mysql
/* ===================================================================
This is a database to demonstrate various relational database concepts. 
The table features various Olympic athletes in a "messaging" database.
====================================================================== */



/* =========================
Creates the Messaging database. 
Database Name: messaging
========================= */
CREATE DATABASE IF NOT EXISTS messaging;

/* Use the new Messaging database that was created. */
USE messaging;

/* =========================
Creates the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id INT(8) NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id INT(8) NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
    contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id INT(8) NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
    receiver_id INT(8) NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime DATETIME NOT NULL,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;

/* =========================
Populates the Person table. 
========================= */
INSERT INTO person (first_name, last_name)
VALUES
("Michael", "Phelps"),
("Katie", "Ledecky"),
("Usain", "Bolt"),
("Allyson", "Felix"),
("Kevin", "Durant"),
("Diana", "Taurasi");

/* =========================
Populates the Contact List table. 
========================= */
INSERT INTO contact_list (person_id, contact_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(2, 4),
(3, 1),
(3, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 6);

/* =========================
Populates the Message table. 
========================= */
INSERT INTO message (sender_id, receiver_id, message, send_datetime)
VALUES
(1, 2, "Congrats on winning the 800m Freestyle!", "2016-12-25 09:00:00"),
(2, 1, "Congrats on winning 23 gold medals!", "2016-12-25 09:01:00"),
(3, 1, "You're the greatest swimmer ever", "2016-12-25 09:02:00"),
(1, 3, "Thanks!  You're the greatest sprinter ever", "2016-12-25 09:04:00"),
(1, 4, "Good luck on your race", "2016-12-25 09:05:00");

/* ========================= Verify Results ========================= */

/* Shows all of the tables in the database */
SHOW tables;

/* =========================
Shows the details for each of the tables created. 
DESCRIBE and SHOW COLUMNS FROM will do the same thing.
i.e. DESCRIBE table_name;
     SHOW COLUMNS FROM table_name;
========================= */
select * from person;
select * from contact_list;
select * from message;

```

<br>
<br>
<br>
<br>

### Enhanced Code

```mysql

/* ==================================     SUMMARY    =================================
This is a database to demonstrate various relational database concepts. 
The table features various Olympic athletes in a "messaging" database.
====================================================================== */

/* ============================== CREATION AND POPULATION ==================
This first section demonstrates the ability to create and populate tables
========================================================================= */

/* =========================
Creates the Messaging database. 
Database Name: messaging
========================= */
CREATE DATABASE IF NOT EXISTS messaging;

/* Use the new Messaging database that was created. */
USE messaging;

/* =========================
Creates the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id INT(8) NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id INT(8) NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
    contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id INT(8) NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
    receiver_id INT(8) NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime DATETIME NOT NULL,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;

/* =========================
Populates the Person table. 
========================= */
INSERT INTO person (first_name, last_name)
VALUES
("Michael", "Phelps"),
("Katie", "Ledecky"),
("Usain", "Bolt"),
("Allyson", "Felix"),
("Kevin", "Durant"),
("Diana", "Taurasi");

/* =========================
Populates the Contact List table. 
========================= */
INSERT INTO contact_list (person_id, contact_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(2, 4),
(3, 1),
(3, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 6);

/* =========================
Populates the Message table. 
========================= */
INSERT INTO message (sender_id, receiver_id, message, send_datetime)
VALUES
(1, 2, "Congrats on winning the 800m Freestyle!", "2016-12-25 09:00:00"),
(2, 1, "Congrats on winning 23 gold medals!", "2016-12-25 09:01:00"),
(3, 1, "You're the greatest swimmer ever", "2016-12-25 09:02:00"),
(1, 3, "Thanks!  You're the greatest sprinter ever", "2016-12-25 09:04:00"),
(1, 4, "Good luck on your race", "2016-12-25 09:05:00");

/* ========================= Verify Results ========================= */

/* Shows all of the tables in the database */
SHOW tables;

/* =========================
Shows the details for each of the tables created. 
DESCRIBE and SHOW COLUMNS FROM will do the same thing.
i.e. DESCRIBE table_name;
     SHOW COLUMNS FROM table_name;
========================= */
select * from person;
select * from contact_list;
select * from message;


/* ================= ALTERING TABLES =====================
This next section includes many updates and alterations to the tables created
========================================================== */

/* =========================
Inserts new person into Person table 
========================= */
INSERT INTO person (first_name, last_name)
VALUES ("Jeremiah", "Norcross");

/* =========================
Adds age column to Person table
========================= */
ALTER TABLE person 
ADD age INT(255) UNSIGNED NOT NULL;

/* =========================
Populates age column. 
========================= */
UPDATE person
SET age = 34
WHERE person_id = 1;

UPDATE person
SET age = 22
WHERE person_id = 2;

UPDATE person
SET age = 33
WHERE person_id = 3;

UPDATE person
SET age = 33
WHERE person_id = 4;

UPDATE person
SET age = 31
WHERE person_id = 5;

UPDATE person
SET age = 37
WHERE person_id = 6;

UPDATE person
SET age = 22
WHERE person_id = 7;

/* =========================
Deletes a row from the Person table. 
========================= */
DELETE FROM person 
WHERE first_name = "Diana"
AND last_name = "Taurasi";

/* =========================
Adds favorite column to contact_list table 
========================= */
ALTER TABLE contact_list
ADD favorite VARCHAR(10);

/* =========================
Populates favorite column. 
========================= */
UPDATE contact_list
SET favorite = 'y'
WHERE contact_id = 1;


UPDATE contact_list
SET favorite = 'n'
WHERE contact_id <> 1;


INSERT INTO contact_list (person_id, contact_id, favorite)
VALUES 
(5, 7, 'n'),
(6, 7, 'n'),
(1, 7, 'n');

/* =========================
Creates new tables for 'images' 
========================= */
CREATE TABLE image (
image_id int(8) NOT NULL AUTO_INCREMENT,
image_name VARCHAR(50) NOT NULL,
image_location VARCHAR(250) NOT NULL,
PRIMARY KEY (image_id)
) AUTO_INCREMENT = 1;
    

CREATE TABLE message_image (
message_id INT(8) NOT NULL,
image_id INT(8) NOT NULL,
PRIMARY KEY (message_id, image_id)
);

/* =========================
Populates image table 
========================= */
INSERT INTO image (image_name, image_location)
VALUES 
('Congrats.jpg', 'C:\\Users\\admin\\Pictures'),
('Thank you.jpg', 'C:\\Users\\admin\\Pictures'),
('Lucky cat.jpg', 'C:\\Users\\admin\\Pictures'),
('Good Luck.jpg', 'C:\\Users\\admin\\Pictures'),
('Sonic the Hedgehog.gif', 'C:\\Users\\admin\\Pictures');

/* =========================
Populates the message_image table.
========================= */
INSERT INTO message_image (message_id, image_id)
VALUES
(1, 1),
(2, 1),
(4, 5),
(5, 3),
(5, 4);

/* =========================
Various Select statements to verify results. 
========================= */
SELECT 
s.first_name AS "Sender First Name",
s.last_name AS "Sender Last Name",
r.first_name AS "Receiver Last Name",
r.last_name AS "Receiver Last Name",
message_id AS "Message ID",
message AS "Message",
send_datetime AS "Message Timestamp"
FROM
person s,
person r,
message
WHERE
s.person_id = 1 AND
sender_id = 1 AND
r.person_id = receiver_id;


SELECT 
person_id AS "Person ID", 
first_name AS "First Name", 
last_name AS "Last Name",
COUNT(sender_id) AS "Count of messages"
FROM 
person,
message
WHERE 
sender_id = person_id
GROUP BY 
person_id;


SELECT 
message_image.message_id AS "Message ID",
message AS "Message",
send_datetime AS "Message Timestamp",
image_name AS "First Image Name",
image_location AS "First Image Location"
FROM
message, image 
JOIN message_image ON
message_id = message_image.message_id AND
image.image_id = message_image.image_id
WHERE
message.message_id = message_image.message_id
GROUP BY
message_image.message_id;

```

