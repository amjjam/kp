/******************************************************************************
 * This is kp.H - it defines the class KP which serves Kp data.               *
 ******************************************************************************/

#ifndef _KP_H_
#define _HP_H_

#include <vector>
#include <string>
#include <iostream>
#include <fstream>

#include "../lib/time/include/Time.H"

class KPV{
public:
  KPV(Time t, float kp);
  KPV(double t, float kp);
  KPV(int yr, int mo, int dy, int hr, float kp);
  ~KPV();
  Time &getTime();
  float getKp();
private:
  Time t;
  float kp;
};


class KPS{
public:
  KPS(std::string f);
  KPS(std::vector<std::string> f);
  ~KPS();
  int size();
  KPV &operator[](int i);
private:
  void load(std::string);
  void load(std::vector<std::string>);
  std::vector<class KPV> kp;
};

#endif
