export const FoodPOisonRepository = {
  fetchScreenTimeData: async () => {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({ limit: 120, usage: 45 });
      }, 1000);
    });
  }
};