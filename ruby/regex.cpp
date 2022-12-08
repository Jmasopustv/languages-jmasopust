#include <iostream>
#include <boost/regex.hpp>
using namespace std;
using namespace boost;


int main() {
    string subject = "#";
    string pattern = "#[0-9]+";


    const regex e(pattern);
    if (regex_match(subject, e, match_partial)) {
        cout << subject << " \tMATCHES\t " << pattern << endl;
    } else {
        cout << subject << " \tDOESN'T MATCH\t " << pattern << endl;
    }


    return 0;
}