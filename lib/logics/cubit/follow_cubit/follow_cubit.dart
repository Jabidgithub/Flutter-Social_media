import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit() : super(FollowInitial());
}
