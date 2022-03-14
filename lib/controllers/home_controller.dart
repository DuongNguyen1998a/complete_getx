import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Models
import '../models/task.dart';
/// Screens
import '../screens/auth_screen.dart';
/// Services
import '../services/home_service.dart';
/// Themes
import '../utils/my_themes.dart';
/// Controllers
import '../controllers/internet_controller.dart';

class HomeController extends GetxController {
  HomeService homeService = HomeService();
  InternetController internetController = InternetController();
  ScrollController listController = ScrollController();
  var taskList = <Task>[].obs;
  var taskListPagination = <Task>[].obs;
  var isLoadingTaskList = false.obs;
  var isShowBtnToTop = false.obs;
  var isLoadMore = false.obs;
  var itemPerPage = 10.obs;
  var defaultTheme = true.obs;

  @override
  onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoadingTaskList(true);

      var internetResult = await internetController.getConnectionType();

      if (internetResult == 0) {
        Get.snackbar('', 'Internet connection error.');
        taskList.assignAll([]);
        taskListPagination.assignAll([]);
        isLoadingTaskList(false);
        return;
      }

      Response response = await homeService.fetchData();

      // debugPrint(response.statusText!);

      if (response.statusCode! == 200) {
        var jsonData = response.body as List;
        var outputData = jsonData.map((task) => Task.fromJson(task)).toList();
        taskList.assignAll(outputData);

        isLoadingTaskList(false);

        taskListPagination.assignAll([]);
        for (int i = 0; i < 10; i++) {
          taskListPagination.add(taskList[i]);
        }
      }
      else if (response.statusCode! == 0) {
        isLoadingTaskList(false);
        taskListPagination.assignAll([]);
        Get.snackbar('', response.statusText!);
      }
      else if (response.statusCode! == 1) {
        isLoadingTaskList(false);
        taskListPagination.assignAll([]);
        Get.snackbar('', response.statusText!);
      }
    } catch (e) {
      rethrow;
    }
  }

  void favoriteItem(int index) {
    if (taskList.asMap().containsKey(index)) {
      taskList[index].completed = !taskList[index].completed;
      taskList.refresh();
    }
  }

  void toggleFab(double value) {
    if (value > 0) {
      isShowBtnToTop.value = true;
    } else {
      isShowBtnToTop.value = false;
    }
  }

  void moveToTop() {
    if (listController.hasClients) {
      final position = listController.position.minScrollExtent;
      listController.animateTo(
        position,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  void loadMore() {
    if (listController.position.pixels > 0 && listController.position.atEdge) {
      isLoadMore(true);
    }
    else {
      isLoadMore(false);
    }
  }

  void addDataLoadMore() {
    int lastIndex = taskListPagination.length;
    if (taskListPagination.asMap().containsKey(lastIndex - 1)) {
      for (int i = 0; i < 10; i++) {
        taskListPagination.insert(lastIndex, taskList[taskListPagination.length - 1]);
      }
      loadMore();
    }
  }

  void removeItem(int index) {
    if (taskListPagination.asMap().containsKey(index)) {
      taskListPagination.removeAt(index);
    }
  }

  void darkTheme() {
    defaultTheme.value = !defaultTheme.value;

    if (!defaultTheme.value) {
      Get.changeTheme(MyThemes.darkTheme);
    }
    else {
      Get.changeTheme(MyThemes.lightTheme);
    }
  }

  void signOut() {
    Get.off(() => const AuthScreen());
  }
}
