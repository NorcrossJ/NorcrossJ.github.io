## Professional Self-Assessment

WIP.

## Software Designing and Engineering: Encryption Project
![Selecting the Caesar Cipher](https://github.com/NorcrossJ/NorcrossJ.github.io/blob/main/Encryption%201.png)
![You can see that the above document was encrypted and became the second document](https://github.com/NorcrossJ/NorcrossJ.github.io/blob/main/Encryption%202.png)

The artifact I chose to enhance is an encryption program from a Secure Coding course I took, and it was created in April of 2021. It is written in C++. The original program takes an input text file (with some pre-generated text), loads it into a string, and then performs a XOR encryption on it. The program then saves the string into a file called encrypteddatafile.txt. It then does the same thing to decrypt the text, saving the decrypted text into decrypteddatafile.txt. 
	I chose this artifact because it demonstrates several basic C++ competencies, such as reading from a file, using loops, use of ints and strings, saving data to a file, printing to the terminal, etc. It also demonstrates interest in and understanding of encryption and security, which is important for anyone who wants to get into cybersecurity in the future. I improved this artifact by implementing a menu that allows the user to choose whether to use the already-implemented XOR cipher algorithm, or the newly implemented Caesar Cipher algorithm. This expands the complexity of the artifact in an interesting way, and there is room to add even more encryption algorithms as the code was written in a modular fashion. With the added encryption algorithm and interactivity from the user, I have met the course objectives I planned to meet. The enhanced artifact uses algorithmic principles (in the encryption algorithms) to solve a given problem (namely encrypting strings that would otherwise be plaintext and easier to attack). The code also demonstrates the ability to use well-founded and innovating techniques to implementing computer solutions. The use of encryption algorithms demonstrates a security mindset that anticipates adversarial exploits in software architecture. Due to this, the enhanced artifact meets objectives CS-499-03, 04, and 05. 
	When enhancing the artifact, one challenge for me was getting the Caesar Cipher to work. The famous Caesar Cipher is something that is easy to conceptualize and do on paper, but is much harder to do with C++. For example, using a key of four is easy to do in your head because we all know the alphabet by heart and can shift the letters easily. However, the algorithm to do that needs to be explicitly stated in the code, and there is no easy shortcut to perform that kind of shift due to the way letters are represented in the code. The solution I ended up using is a rather ugly (yet effective) series of if and else if statements in a for loop that iterates through the string and transforms the characters based on whether they are upper or lower case. Coming up with this solution required me to look on Github and other similar solutions, as well as looking at C++ documentation and learning how characters are represented in the code. I had to learn what it meant to “add” a number to a character to transform it into a different one. Overall, improving the artifact gave me a deeper understanding of the inner workings of the language.


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
  
## Algorithm and Data Structures: Vector Sorting Project

## Databases: MySQL Database Project
