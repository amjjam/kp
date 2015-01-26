/******************************************************************************
 * This is kp.H - it defines the class KP which serves Kp data.               *
 ******************************************************************************/

#ifndef _KP_H_
#define _HP_H_

#include "Time.H"

class KPV{
public:
  KPV(double t, float kp);
  KPV(int yr, int mo, int dy, int hr, float kp);
  ~KP();
  double getTime();
  float getKp();
private:
  Time t;
  float kp;
};

};

class KPS{
public:
  KPS(std::string f);
  KPS(std::vector<std::string> f);
  ~KPS();
  void size();
  KPV &get(int i);
private:
  std::vector<class KPV> kp;
};

#endif
