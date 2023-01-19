##AE 4803 - Homework 1 Question 4
##By Noe Lepez Da Silva Duarte

import numpy as np
import matplotlib.pyplot as plt

# Part a

x0 = 1
fx = (2 ** x0) / x0
exact_soln = (2 ** x0) * (x0 * np.log(2) - 1) / x0

# Part b

h = np.logspace(0, -10, 1000)
errors_b = []
for i in h:
    fxh = 2 ** (x0 + i) / (x0 + i)
    ans = (fxh - fx) / i
    er = np.abs((exact_soln - ans) / exact_soln)*100
    errors_b.append(er)

plot1 = plt.figure()
ax = plot1.add_subplot(111)
ax.plot(h, errors_b)

# create axes and labels
ax.set_xlabel('h')
ax.set_ylabel('Relative error (%)')
ax.set_title('True relative error of equation 1 as a function of h')
ax.set_xscale('log')
ax.set_yscale('log')
plt.grid()

plt.savefig('Q4_b', dpi=300)
plt.show()

# Part c

errors_c = []
for i in h:
    fw = (2 ** (x0 + i / 2)) / (x0 + i / 2)
    bw = (2 ** (x0 - i / 2)) / (x0 - i / 2)
    ans = (fw - bw) / i
    er = np.abs((exact_soln - ans) / exact_soln)*100
    errors_c.append(er)

plot2 = plt.figure()
ax = plot2.add_subplot(111)
ax.plot(h, errors_c, color='red')

# create axes and labels
ax.set_xlabel('h')
ax.set_ylabel('Relative error (%)')
ax.set_title('True relative error of equation 2 as a function of h')
ax.set_xscale('log')
ax.set_yscale('log')
plt.grid()

plt.savefig('Q4_c', dpi=300)
plt.show()

# Part d

plot3 = plt.figure()
ax = plot3.add_subplot(111)
ax.plot(h, errors_b, label='Equation 1')
ax.plot(h, errors_c, color='red', label='Equation 2')

# create axes and labels
ax.set_xlabel('h')
ax.set_ylabel('Relative error (%)')
ax.set_title('True relative error of equations 1 & 2 as a function of h')
ax.set_xscale('log')
ax.set_yscale('log')
plt.legend()
plt.grid()

plt.savefig('Q4_d', dpi=300)
plt.show()
