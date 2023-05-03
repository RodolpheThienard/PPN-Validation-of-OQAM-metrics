#include <arm_neon.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//
unsigned long long
rdtsc (void)
{
    uint64_t value;
    asm volatile("mrs %0, cntvct_el0" : "=r" (value)); // permet de renvoyer la valeur du compteur d'horloge
    return value;
}

//
void
function (int k)
{
    double a = 10;
    double b = 20;
    for (int i = 0; i < k; i++)
        {
            for (int j = 0; j < k; j++)
                b = 2 * a + 2;
        }
    return;
}

void
function_optimised (int n)
{
    int i;
    double a[n], b[n], c[n], s[n];
    for (i = 0; i < n; i += 2) {
        float64x2_t va = vld1q_f64(&a[i]);
        float64x2_t vb = vld1q_f64(&b[i]);
        float64x2_t vs = vld1q_f64(&s[i]);
        float64x2_t vc = vfmaq_f64(vs, va, vb);
        vst1q_f64(&c[i], vc);
    }
}

//
int
main (int argc, char **argv)
{
    double a = (double)rdtsc ();
    function (atoi (argv[1]));
    double b = (double)rdtsc ();

    printf ("%lf\n", b - a);
    return 0;
}
