import numpy as np

def calculate(list):
    if len(list) != 9:
        raise ValueError("List must contain nine numbers.")

    arr = np.array(list).reshape(3, 3)

    mean_axis1 = np.mean(arr, axis=0).tolist()
    mean_axis2 = np.mean(arr, axis=1).tolist()
    mean_flattened = np.mean(arr).tolist()
    
    variance_axis1 = np.var(arr, axis=0).tolist()
    variance_axis2 = np.var(arr, axis=1).tolist()
    variance_flattened = np.var(arr).tolist()
    
    std_dev_axis1 = np.std(arr, axis=0).tolist()
    std_dev_axis2 = np.std(arr, axis=1).tolist()
    std_dev_flattened = np.std(arr).tolist()
    
    max_axis1 = np.max(arr, axis=0).tolist()
    max_axis2 = np.max(arr, axis=1).tolist()
    max_flattened = np.max(arr).tolist()
    
    min_axis1 = np.min(arr, axis=0).tolist()
    min_axis2 = np.min(arr, axis=1).tolist()
    min_flattened = np.min(arr).tolist()
    
    sum_axis1 = np.sum(arr, axis=0).tolist()
    sum_axis2 = np.sum(arr, axis=1).tolist()
    sum_flattened = np.sum(arr).tolist()

    calculations = {
        'mean': [mean_axis1, mean_axis2, mean_flattened],
        'variance': [variance_axis1, variance_axis2, variance_flattened],
        'standard deviation': [std_dev_axis1, std_dev_axis2, std_dev_flattened],
        'max': [max_axis1, max_axis2, max_flattened],
        'min': [min_axis1, min_axis2, min_flattened],
        'sum': [sum_axis1, sum_axis2, sum_flattened]
    }

    return calculations
