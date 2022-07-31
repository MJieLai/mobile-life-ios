# mobile-life-ios

There are a few special handling in this project: 
1. Toast message is used to show if any API error return. 

2. The image size is reduced before display in the Image List view.
    - It is reduced by replacing the original width and height with 200 x 200. 
    - This is to prevent lagging when scroll through the Image List view. 

3. Internet connection checking is added. 
    - Loaded image will be kept as cache when there is no internet connection.  

4. Image info is passed into Image Detail view instead of load API. 
    - This is to minimise the API call.
    - And to provide a smoother user experience without a lot of waiting for data load. 

5. Blur slider in Image Detail view is not set to integer value only. 
    - This is because the API are able to support value with decimal. 
    - This allow user to aplly any minor blurness to the image. 
