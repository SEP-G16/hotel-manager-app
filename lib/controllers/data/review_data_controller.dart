import 'package:get/get.dart';
import 'package:hotel_manager/controllers/network/review_network_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';

import '../../models/review.dart';

class ReviewDataController extends GetxController {
  ReviewNetworkController _rnc = ReviewNetworkController.instance;

  static ReviewDataController instance = Get.find();

  RxList<Review> _reviewList = <Review>[].obs;
  List<Review> get reviewList => _reviewList;
  RxList<Review> listenableReviewList = <Review>[].obs;

  ReviewDataController._();

  static Future<ReviewDataController> create() async {
    final ReviewDataController controller = ReviewDataController._();
    await controller._initController();
    return controller;
  }

  Future<void> reinitController() async
  {
    await _initController();
  }

  Future<void> _initController() async {
    _reviewList.assignAll(await _getReviews());
    listenableReviewList.assignAll(_reviewList);
  }

  Future<List<Review>> _getReviews() async {
    try {
      List<Map<String, dynamic>> reviewsMapList =
          await _rnc.getReviews();
      List<Review> reviews = reviewsMapList.map((map) => Review.fromMap(map)).toList();
      reviews.sort(
              (a, b) => b.createdAt.compareTo(a.createdAt));
      return reviews;
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> acceptReview({required int tempReviewId}) async {
    try {
      await _rnc.acceptReview(tempReviewId: tempReviewId);
      Review review = _reviewList
          .where((tempReview) => tempReview.id == tempReviewId)
          .toList()
          .first;
      _reviewList
          .removeWhere((tempReview) => tempReview.id == tempReviewId);
      _reviewList.add(review.copyWith(status: ReviewStatus.Approved));
      _reviewList.sort(
          (a, b) => a.createdAt.isBefore(b.createdAt) ? 1 : 0); //check sort
      listenableReviewList.assignAll(_reviewList);
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectReview({required int tempReviewId}) async {
    try {
      await _rnc.rejectReview(tempReviewId: tempReviewId);
      _reviewList
          .removeWhere((tempReview) => tempReview.id == tempReviewId);
      listenableReviewList.assignAll(_reviewList);
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
