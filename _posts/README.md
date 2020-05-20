# Project_Robo-ND_3D-Perception-Project
##  Robotics Software Engineer - Udacity Nanodegree

### Overview - 
The goal of this project is to program a PR2 to identify and acquire target objects from a cluttered space and place them in a bin. The project is based on the 'Stow Task' portion of Amazon's Robotics Challenge.

### Modules involved -
A **POINT CLOUD** is a set of data points in space. Point clouds are generally produced by 3D scanners, which measure many points on the external surfaces of objects around them. The PR2 robot in the simulation is fitted with aan RGBD camera. Now, the point cloud data that will be published over a topic, has to worked with to identify the object in the scene, the location of it to perform a pick and place operation on the same.

Various **FILTERS** were used on the incoming point cloud data. These include 
###### VoxelGrid Downsampling Filter

###

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/595ab978_screen-shot-2017-07-03-at-2.38.41-pm/screen-shot-2017-07-03-at-2.38.41-pm.png)

###

Downsampling is used to decrease the density of the pointcloud that is output from the RGB-D camera. This is done because the very feature rich pointclouds can be quite computationally expensive.
*Downsampling* can be thought of decreasing the resolution of a three dimensional point cloud.

`RANSAC.py` contains the Voxel Downsampling Code.

###### Pass Through Filtering

###

We'll use Pass Through Filtering to trim down our point cloud space along specified axes, in order to decrease the sample size. We will allow a specific region to *Pass Through*. This is called the *Region of Interest*.
*Pass Through Filtering* can be thought of as cropping a three dimensional space across one or many of the dimensions.
###

###### RANSAC Plane Fitting

###

We can model the table in our dataset as a plane, and remove it from the pointcloud using `Random Sample Consensus` or `RANSAC` algorithm.

As you can see, we selected the horizontal plane below, which was the table our target objects were sitting on.

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/595d3ec9_screen-shot-2017-07-05-at-12.31.15-pm/screen-shot-2017-07-05-at-12.31.15-pm.png)


###### Extracting Indices - Inliers and Outliers
Once we've determined where our table is located, we can create two separate point clouds: one for the table(inliers), and one for the objects beyond(outliers).
###
*Inliers*
`extracted_inliers = cloud_filtered.extract(inliers, negative=False)`

###
*Outliers*
`extracted_outliers = cloud_filtered.extract(inliers, negative=True)`

###

###### Outlier Removal Filter

###

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/595a5ebf_statistical-outlier-removal-cropped/statistical-outlier-removal-cropped.png)

###

This filter is used to statistically remove noise from the image. Here's [a cool video showing the removal in 3 dimensions.](https://youtu.be/RjQPp2_GRnI)


Much like the previous filters, we start by creating a filter object: 
```
outlier_filter = cloud_filtered.make_statistical_outlier_filter()
```
Set the number of neighboring points to analyze for any given point:
```
outlier_filter.set_mean_k(50)
```
Set threshold scale factor:
```
x = 1.0
```
Any point with a mean distance larger than global (mean distance+x*std_dev) will be considered an outlier
```
outlier_filter.set_std_dev_mul_thresh(x)
```
Finally call the filter function
```
cloud_filtered = outlier_filter.filter()
```



###
###

##### Clustering for Segmentation

Now that we've used shape attributes in the dataset to filter and segment the data, we'll move on to using other elements of our dataset such as: **color and spatial properties**

###### K-Means Clustering

###

K-Means Clustering is an appropriate clustering algorithm if you are aware of your dataspace and have a rough idea of the number of clusters.

Remember, with K-Means, we:

**1.** Choose the number of k-means (the number of clusters to look for)
**2.** Define the convergence / termination criteria (stability of solution / number of iterations)
**3.** Select the initial centroid locations, or randomly generate them
**4.** Calculate the distance of each datapoint to each of the centroids
**5.** Assign each of the datapoints to one of the centroids(clusters) based upon closest proximity
**6.** Recompute the centroid based on the datapoints that belong to it
**7.** Loop back to **Step 4** until convergence / termination criteria is met

###

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/59611b02_screen-shot-2017-07-08-at-10.48.32-am/screen-shot-2017-07-08-at-10.48.32-am.png)

###

If you are unsure of the number of clusters, it is best to use a different clustering solution! Such as DBSCAN...

###

###### DBSCAN Algorithm *(Density-Based Spatial Clustering of Applications with Noise)*
*Sometimes called* ***Euclidean Clustering***

###

DBSCAN is a nice alternative to k-means when you don't know how many clusters to expect in your data, but you do know something about how the points should be clustered in terms of density (distance between points in a cluster).

###

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/59616bad_screen-shot-2017-07-08-at-4.32.22-pm/screen-shot-2017-07-08-at-4.32.22-pm.png)

*Original data on the left and clusters identified by the DBSCAN algorithm on the right. For DBSCAN clusters, large colored points represent core cluster members, small colored points represent cluster edge members, and small black points represent outliers.*
###

DBSCAN datapoints **do not have to be spatial data; they can be color data, intensity values, or other numerical features!** This means we can cluster not only based upon proximity, but we can cluster similarly colored objects!

###
###
###

##### Object Recognition

###
###### HSV
###
HSV can help us identify objects when the lighting conditions change on an RGB image. **Hue** is the color, **Saturation** is the color intensity, and **Value** is the brightness. A conversion from RGB to HSV can be done with `OpenCV`:
```py
hsv_image = cv2.cvtColor(rgb_image, cv2.COLOR_RGB2HSV)
```
###

###### Color Histograms

Using color historgrams, we can identify the color pattern of an object, and not be limited to spatial data. Let's use this example of the Udacity can:
###
![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/59713eeb_screen-shot-2017-07-20-at-4.37.45-pm/screen-shot-2017-07-20-at-4.37.45-pm.png)
###
Using `numpy`, we can create a histogram for each one of the color channels. See `color_histogram.py` to see how we do this with code. The result is:
###
![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/59714020_screen-shot-2017-07-20-at-4.43.05-pm/screen-shot-2017-07-20-at-4.43.05-pm.png)
###

This is the RGB Signature of the blue Udacity can!

###
###### Surface Normals
###
Just as we did with plotting colors, we'll now want to plot shape. This can be done by looking at the **surface normals** of a shape in aggregate. We'll also analyze them using histograms like the ones below:

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/5972224b_screen-shot-2017-07-21-at-8.47.56-am/screen-shot-2017-07-21-at-8.47.56-am.png)
###
These **surface normal** histograms correspond to the following shapes:
![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/597801d9_normals-intuiition-quiz-image/normals-intuiition-quiz-image.jpg)
###
**B** represents the cube, **A** represents the sphere, and **C** represents the pyramid
###
###### Support Vector Machines (SVM)
###
"SVM" is just a funny name for a particular *supervised* machine learning algorithm that allows you to characterize the parameter space of your dataset into discrete classes. It is a **classification** technique that uses hyperplanes to delineate between discrete classes. The ideal hyperplane for each decision boundary is one that maximizes the margin, or space, from points.
###

![alt text](https://d17h27t6h515a5.cloudfront.net/topher/2017/July/59737b6e_screen-shot-2017-07-22-at-9.20.22-am/screen-shot-2017-07-22-at-9.20.22-am.png)
###
**Scikit-Learn** or `sklearn.svm.SVC` will help us implement the SVM algorithm. [Check this link out for documentation on scikit-learn](http://scikit-learn.org/stable/modules/classes.html#module-sklearn.svm)
###
`svm.py` will house our SVM code and `generate_clusters.py` will help us create a random dataset.
```py
svc = svm.SVC(kernel='linear').fit(X, y)
```
 The line above is the one doing the heavy lifting. The type of delineation can be changed. It must be one of *‘linear’, ‘poly’, ‘rbf’, ‘sigmoid’, ‘precomputed’* or a callable. [Read more here](http://scikit-learn.org/stable/modules/generated/sklearn.svm.SVC.html).

We also do some **SVM Image Classification**, and this can be found under `svm_image_classifer`.
###
###
###


### Final step

Now that we've identified the particular objects in the scene, we read data from the ROS parameter server, the baskets to which each objects belong, script it into an ros service and send it so that the PR2_robot performs the pick and place operation on the object. To perform this succesfully, we calculate the centroid coordinates (this is done using an inbuilt pcl function to convert a cloud to an array to calculate the centroid) and other important information like the basket it has to be dropped into, in the service message and pass it. 
