/******************************************************************************
 * This is kp.C - it implements the classes KPV and KPS. KPV stores a single  *
 * Time-tagged Kp value and KPS stores a time-series of Kp values, and can    *
 * also be initialized from a sequence of World Data Center Kp files.         *
 ******************************************************************************/

#include "../include/kp.H"

/*============================================================================
  ============================================================================
  class KPV
  ============================================================================
  ============================================================================*/

/*=============================================================================
  KPV(aTime &t, float kp) - constructor using a aTime class and float kp value
  ============================================================================*/
KPV::KPV(aTime t, float kp){
  KPV::t=t;
  KPV::kp=kp;
}


/*=============================================================================
  KPV(int yr, int mo, int dy, int hr, float kp) - constructor using
  yr/mo/dy hr time format and float kp value.
  ============================================================================*/
KPV::KPV(int yr, int mo, int dy, int hr, float kp){
  t.set(yr,mo,dy,hr);
  KPV::kp=kp;
}


/*=============================================================================
  KPV(double t, float kp) - constructor using double time and float kp
  ============================================================================*/
KPV::KPV(double t, float kp){
  KPV::t=t;
  KPV::kp=kp;
}


/*=============================================================================
  ~KPV() - destructor 
  ============================================================================*/
KPV::~KPV(){

}


/*=============================================================================
  aTime &getTime() - return time as a double
  ============================================================================*/
aTime &KPV::getTime(){
  return t;
}


/*=============================================================================
  float getKp() - return the kp value
  ============================================================================*/
float KPV::getKp(){
  return kp;
}


/*============================================================================
  ============================================================================
  class KPS
  ============================================================================
  ============================================================================*/

/*=============================================================================
  KPS(std::string f) - constructor loading from a single file
  ============================================================================*/
KPS::KPS(std::string f){
  load(f);
}


/*=============================================================================
  KPS(std::vector<std::string> f) - constructor loading from a sequence of 
  files
  ============================================================================*/
KPS::KPS(std::vector<std::string> f){
  for(unsigned int i=0;i<f.size();i++)
    load(f[i]);
}


/*============================================================================
  ~KPS() - destructor
  ===========================================================================*/
KPS::~KPS(){

}


/*=============================================================================
  int size() - returns the number of KPV data points in the object
  ============================================================================*/
int KPS::size(){
  return kp.size();
}


/*=============================================================================
  KPV &operator[](int i) - get the i'th KPV element
  ============================================================================*/
KPV &KPS::operator[](int i){
  return kp[i];
}


/*=============================================================================
  int find(aTime &t) - find the largest index for which the time is
  less than or equal to t.

  If all times are greater than t then return -1. 
  ============================================================================*/
int KPS::find(aTime &t){
  int i,n=kp.size();
  
  for(i=0;i<n;i++)
    if(kp[i].getTime()>t)
      break;
  return i-1;
}


/*=============================================================================
  void load(std::string file) - load a WDC file format
  ============================================================================*/
void KPS::load(std::string file){
  std::ifstream f(file.c_str());
  std::string l;
  float kpv;
  int yr,mo,dy;

  std::getline(f,l);
  do{
    yr=atoi(l.substr(0,2).c_str());
    if(yr>50)
      yr+=1900;
    else
      yr+=2000;
    mo=atoi(l.substr(2,2).c_str());
    dy=atoi(l.substr(4,2).c_str());
    for(int i=0;i<8;i++){
      kpv=(float)atoi(l.substr(12+i*2,2).c_str())/10;
      kp.push_back(KPV(yr,mo,dy,i*3,kpv));
    }
    std::getline(f,l);
  }while(l.size()>0);
}


/*=============================================================================
  void load(std::vector<std::string> files) - loads multiple files, in
  the sequence they are listed in the string vector
  ============================================================================*/
void KPS::load(std::vector<std::string> files){
  for(unsigned int i=0;i<files.size();i++)
    load(files[i]);
}
