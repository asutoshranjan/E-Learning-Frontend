# Swift Load

<p align="center">
  <img src="https://user-images.githubusercontent.com/81508078/179827193-ffdd1d75-5d39-4550-b949-63bbd5312608.gif" alt="animated" />
</p>
<br />
Swift Load is a YouTube video uploader that helps you to Upload Multiple Videos on YouTube directly from a google sheet very
conveniently with just One Click. Built during my Internship at IIIT DELHI under Prof. Anuj Grover Project E-Learning (A Online Lectures Video Workflow Optimization Project) as we had a lot of videos to upload on youtube from spreadsheet data. It uses the GoogleSheet API for fetching data from a sheet and send that data to its backend through a POST request, which is then used by the backend flask app to upload the desiered videos from the user's system. Additionaly, it has a data sheet preview in the app, an update sheet button to fetch the lastes data if its changed, and a form if the user wants to upload a single video. The UI is simple minimal responsive and fun to use providing a good User Experience.

## Getting Started

Follow this guide to setup Swift Load on your local machine
- Set up Swift Load's Backend Server [Swift Load - Server](https://github.com/asutoshranjan/E-Learning-Backend)
- Now as our frontend Flutter application can communicate with the server we are ready to **Upload Videos** on YouTube
- Install all the required packages and dependencies run
```
flutter pub get
```

<br />
<br />

Swift Load Guide
- Click **Open Sheet** to Open the Google Sheet ![Asset 6](https://user-images.githubusercontent.com/81508078/179820671-a2c35bd4-7c0f-4ee9-8662-c320246e0239.png)

- After you make the necessary changes click on **Update Sheet** ![Asset 8](https://user-images.githubusercontent.com/81508078/179820974-1d1924b9-fbec-4629-b63d-d96e7feabd59.png)

- The to **Upload Preview** list shows all the videos to be uploaded ![Asset 9](https://user-images.githubusercontent.com/81508078/179821266-d3e2a7ee-07da-4c75-86cc-0fb1d311ac9c.png)

- Now just click on the **Upload** button to upload the videos ![Asset 10](https://user-images.githubusercontent.com/81508078/179821384-8b3d2188-3381-4381-96b5-83b6da731822.png)

- If you want to upload a single video without using the sheet you can do so by filling the upload a video fields ![Asset 11](https://user-images.githubusercontent.com/81508078/179821452-f3c2374f-b4b3-4929-8895-d599be1caa2d.png)


<br />
If you liked the project give it a star<br />
If you want to add some additional functionalities open an issue I will try implimenting or you can also send a pull request.<br />
<br />
Keep Building!💙


