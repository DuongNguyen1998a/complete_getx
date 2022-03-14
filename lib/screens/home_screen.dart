import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

/// Controllers
import '../controllers/home_controller.dart';

/// Utils
import '../utils/dimensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'List of Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              homeController.darkTheme();
            },
            icon: const Icon(Icons.update),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            homeController.signOut();
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => homeController.isLoadingTaskList.value
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, __) => Card(
                    color: Colors.grey.shade100,
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height15,
                      horizontal: Dimensions.height15,
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height15,
                        horizontal: Dimensions.height15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  color: Colors.white,
                                  width: 180,
                                  height: 10,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: const SizedBox(
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: const SizedBox(
                              width: 100,
                              height: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: homeController.fetchData,
                  child: Column(
                    children: [
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          child: !homeController.isLoadingTaskList.value &&
                                  homeController.taskListPagination.isNotEmpty
                              ? ListView.builder(
                                  controller: homeController.listController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      homeController.taskListPagination.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      homeController.removeItem(index);
                                    },
                                    child: Card(
                                      margin: EdgeInsets.symmetric(
                                        vertical: Dimensions.height15,
                                        horizontal: Dimensions.height15,
                                      ),
                                      elevation: 8,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.height15,
                                          horizontal: Dimensions.height15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${index + 1}. ${homeController.taskListPagination[index].title}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                  () => IconButton(
                                                    onPressed: () {
                                                      homeController
                                                          .favoriteItem(index);
                                                    },
                                                    icon: homeController
                                                            .taskList[index]
                                                            .completed
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_outline_outlined,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                                'UserId: ${homeController.taskListPagination[index].userId}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      homeController.fetchData();
                                    },
                                    child: const Text(
                                      'Internet connection error. Please try aagin.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                          onNotification: (notification) {
                            if (homeController.listController.position.pixels >
                                0) {
                              homeController.toggleFab(homeController
                                  .listController.position.pixels);
                              homeController.loadMore();
                              return true;
                            } else {
                              homeController.toggleFab(homeController
                                  .listController.position.pixels);
                              return false;
                            }
                          },
                        ),
                      ),
                      Obx(
                        () => homeController.isLoadMore.value
                            ? TextButton(
                                onPressed: () {
                                  homeController.addDataLoadMore();
                                },
                                child: const Text('Load more'),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: homeController.isShowBtnToTop.value,
          child: FloatingActionButton(
            isExtended: true,
            onPressed: () {
              homeController.moveToTop();
            },
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
