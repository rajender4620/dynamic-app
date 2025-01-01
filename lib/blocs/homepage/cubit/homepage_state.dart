part of 'homepage_cubit.dart';

class HomepageState {}

final class HomepageInitial extends HomepageState {}

final class HomepageLoading extends HomepageState {}

final class HomepageLoaded extends HomepageState {
  HomepageLoaded(
    this.hniCustomerMetResponce,
    this.activitiesconductedResponce,
    this.nonhnicustomermetResponce,
    this.formData,
  );
  HniCustomerMetResponce hniCustomerMetResponce;
  HniCustomerMetResponce activitiesconductedResponce;
  HniCustomerMetResponce nonhnicustomermetResponce;
  List<HniCustomerMetResponce> formData;
}

final class HomepageFailed extends HomepageState {
  HomepageFailed(this.errorMessage);
  final String errorMessage;
}
