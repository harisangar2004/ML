LINEAR REGRESSION


import numpy as np                                                                                                                                         

import matplotlib.pyplot as plt                                                                                                                            

# Sample data                                                                                                                                              

X = np.array([1, 2, 3, 4, 5])  # Independent variable (input)                                                                                              

y = np.array([2, 4, 5, 4, 5])  # Dependent variable (output)                                                                                               

# Mean of X and y                                                                                                                                          

mean_X = np.mean(X)                                                                                                                                        

mean_y = np.mean(y)                                                                                                                                        

# Calculate the coefficients (slope m and intercept b)                                                                                                     

numerator = np.sum((X - mean_X) * (y - mean_y))                                                                                                            

denominator = np.sum((X - mean_X) ** 2)                                                                                                                    

m = numerator / denominator                                                                                                                                

b = mean_y - (m * mean_X)                                                                                                                                  

# Regression line equation: y = mx + b                                                                                                                     

print(f"Slope (m): {m}")                                                                                                                                   

print(f"Intercept (b): {b}")                                                                                                                               

# Predict y values based on the model                                                                                                                      

y_pred = m * X + b                                                                                                                                         

# Function to predict y for a given x                                                                                                                      

def predict(x):                                                                                                                                            

        return m * x + b                                                                                                                                   
                 # Test prediction for a specific x value                                                                                                  

x_value = 6                                                                                                                                                

predicted_y = predict(x_value)                                                                                                                             

print(f"Predicted y for x = {x_value}: {predicted_y}")                                                                                                     

# Plot the data and the regression line                                                                                                                    

plt.scatter(X, y, color='blue', label='Data points')                                                                                                       

plt.plot(X, y_pred, color='red', label='Regression line')                                                                                                  

plt.scatter(x_value, predicted_y, color='green', label=f'Predicted y for x={x_value}', zorder=5)                                                           

plt.xlabel('X')                                                                                                                                            

plt.ylabel('y')                                                                                                                                            

plt.legend()                                                                                                                                               

plt.show()
