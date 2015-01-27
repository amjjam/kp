/***************************************************************************
 * This program tests the KP library.                                      *
 ***************************************************************************/

#include "../../include/kp.H"

int main(int argc, char *argv[]){
  std::vector<std::string> files;

  files.push_back("../dat/kp2013.wdc");
  files.push_back("../dat/kp2014.wdc");

  KPS d(files);

  int yr,mo,dy,hr;

  for(int i=0;i<100;i++){
    d[i].getTime().get(yr,mo,dy,hr);
    std::cout << yr << "/" << mo << "/" << dy << " " << hr << " " 
	      << d[i].getKp() << std::endl;
  }
  
  return 0;
}
