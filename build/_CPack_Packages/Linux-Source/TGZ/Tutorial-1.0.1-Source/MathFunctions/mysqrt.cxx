
double mysqrt(double input)
{
    double tmp = input;
    while (tmp * tmp / 4 > input) {
        tmp = tmp / 2;
    }
    while (tmp * tmp < input) {
        tmp += 0.5;
    }
    return tmp;
}

