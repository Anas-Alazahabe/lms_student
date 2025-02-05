import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/auth/data/repos/auth_repo_impl.dart';
import 'package:lms_student/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:lms_student/features/auth/presentation/manager/create_user_cubit/create_user_cubit.dart';
import 'package:lms_student/features/auth/presentation/manager/index_address_year_cubit/index_address_year_cubit.dart';
import 'package:lms_student/features/auth/presentation/manager/resend_email_cubit/resend_email_cubit.dart';
import 'package:lms_student/features/auth/presentation/manager/verify_user_cubit/verify_user_cubit.dart';
//import 'package:lms_student/features/auth/presentation/manager/grades_cubit/grades_cubit.dart';
import 'package:lms_student/features/auth/presentation/views/onboarding_view.dart';
import 'package:lms_student/features/downloads/presentataion/views/download_view.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad.dart';
import 'package:lms_student/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_student/features/home/data/repos/home_repo_impl.dart';
import 'package:lms_student/features/home/presentation/manager/ad_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/bookmark_cubit/fetch_mark_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/favorite_cubit.dart';
import 'package:lms_student/features/home/presentation/manager/subjects_cubit.dart';
import 'package:lms_student/features/home/presentation/views/ad_details_view.dart';
import 'package:lms_student/features/home/presentation/views/home_view.dart';
import 'package:lms_student/features/home/presentation/views/pdf_view.dart';
import 'package:lms_student/features/home/presentation/views/profile_view.dart';
import 'package:lms_student/features/home/presentation/views/video_view.dart';
import 'package:lms_student/features/home/presentation/views/widgets/favorite_view.dart';
import 'package:lms_student/features/home/presentation/views/widgets/subject_widget/subject_list.dart';
import 'package:lms_student/features/subject_data/data/models/quizzes_model/quiz.dart';
import 'package:lms_student/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_student/features/subject_data/data/repo/subject_repo_impl.dart';
import 'package:lms_student/features/subject_data/presentation/manager/buy_subject_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/comment_cubit/comment_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/quizzes/fetch_quizzes_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/manager/units_cubit.dart';
import 'package:lms_student/features/subject_data/presentation/views/comments_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/lesson_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/quiz_result_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/quiz_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/subject_data_view.dart';
import 'package:lms_student/features/subject_data/presentation/views/teacher_profile_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kHomeView = '/homeView';
  static const kAdView = '/homeView/adView';
  static const kSubjectDataView = '/homeView/subjectDataView';
  static const kPdfView = '/pdfView';
  static const kVideoView = '/videoView';
  static const kfavorite = '/Favorite';

  static const kQuizView = '/quizView';
  // static const kQuizSummery = '/quizSummery';
  static const kQuizResults = '/quizResults';
  static const kLessonView = '/lessonView';
  // static const kCommentsView = '/commentsRoomView';
  static const kCommentsView = '/commentsRoomView';
  static const kProfileView = '/homeView/profileView';
  // static const kSpecificationView = '/homeView/specificationView';
  static const kDownloadVeiw = '/downloadVeiw';
  static const kSubject = '/homeView/subject';
  static const kTeacherProfileview = '/kTeacherProfileview';
  static GoRouter setupRouter(
      String? token, String? deviceToken, String? gradeId) {
    return GoRouter(routes: [
      if (token == null)
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    IndexAddressYearCubit(getIt<AuthRepoImpl>())
                      ..fetchAuthData(),
              ),
              BlocProvider(
                create: (context) => CreateUserCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => ResendEmailCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => VerifyUserCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => getIt<SharedPreferencesCubit>(),
              ),
            ],
            child: OnBoaringView(
              deviceToken: deviceToken,
            ),
          ),
        ),
      if (token != null)
        GoRoute(
          path: '/',
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                // BlocProvider(
                //     create: (context) => SubjectsCubit(
                //         getIt<HomeRepoImpl>(), gradeId ?? state.extra as String)
                //       ..fetchSubjects(
                //           gradeId: gradeId ?? state.extra as String)),
                BlocProvider(
                    create: (context) => AdCubit(getIt<HomeRepoImpl>())),
                BlocProvider(
                    create: (context) => SubjectsCubit(
                          getIt<HomeRepoImpl>(),
                        )),
              ],
              child: const HomeView(
                  // gradeId: gradeId ?? state.extra as String,
                  ),
            );
          },
        ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreateUserCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => ResendEmailCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => VerifyUserCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => getIt<SharedPreferencesCubit>(),
            ),
          ],
          child: OnBoaringView(
            deviceToken: deviceToken,
          ),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(
              //     create: (context) => SubjectsCubit(
              //         getIt<HomeRepoImpl>(), state.extra as String)
              //       ..fetchSubjects(gradeId: state.extra as String)),
              BlocProvider(create: (context) => AdCubit(getIt<HomeRepoImpl>())),
              BlocProvider(
                  create: (context) => SubjectsCubit(
                        getIt<HomeRepoImpl>(),
                      )),
            ],
            child: const HomeView(
                // gradeId: state.extra as String,
                ),
          );
        },
      ),

      GoRoute(
        path: kSubject,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(
              //     create: (context) => SubjectsCubit(
              //         getIt<HomeRepoImpl>(), state.extra as String)
              //       ..fetchSubjects(gradeId: state.extra as String)),
              BlocProvider(
                  create: (context) => SubjectsCubit(
                        getIt<HomeRepoImpl>(),
                      )),

              BlocProvider(
                  create: (context) => FetchBookMarkCubit(
                        getIt<HomeRepoImpl>(),
                      )),
            ],
            child: SubjectList(
              subjects: state.extra as List<Subject>,
            ),
          );
        },
      ),

      GoRoute(
        path: kSubjectDataView,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              // BlocProvider(
              //     create: (context) => SubjectsCubit(
              //         getIt<HomeRepoImpl>(), state.extra as String)
              //       ..fetchSubjects(gradeId: state.extra as String)),
              BlocProvider(
                  create: (context) => UnitsCubit(
                        getIt<SubjectRepoImpl>(),
                      )),
              BlocProvider(
                  create: (context) => BuySubjectCubit(
                        getIt<SubjectRepoImpl>(),
                      )),
              BlocProvider(
                  create: (context) => FetchQuizzesCubit(
                        getIt<SubjectRepoImpl>(),
                      )),

              BlocProvider(
                  create: (context) => FetchBookMarkCubit(
                        getIt<HomeRepoImpl>(),
                      )),
            ],
            child: SubjectDataView(
              subject: state.extra as Subject,
            ),
          );
        },
      ),

      GoRoute(
        path: kTeacherProfileview,
        builder: (context, state) {
          return TeacherProfileView(
            teacherId: state.extra.toString(),
          );
        },
      ),

      GoRoute(
        path: kAdView,
        builder: (context, state) {
          return AdDetailsView(
            ad: state.extra as Ad,
          );
        },
      ),
      // GoRoute(
      //     path: kSubjectView,
      //     builder: (context, state) {
      //       final Map<String, dynamic> extras =
      //           state.extra as Map<String, dynamic>;
      //       final int courseId = extras['course_id'];
      //       final int courseIndex = extras['course_index'];
      //       return SubjectView(
      //         courseId: courseId,
      //         courseIndex: courseIndex,
      //       );
      //     }),
      // GoRoute(
      //     path: kCoursesView,
      //     builder: (context, state) {
      //       // final Map<String, dynamic> extras =
      //       //     state.extra as Map<String, dynamic>;
      //       // final Video video = extras['video'];
      //       // final String path = extras['path'];
      //       return CoursesView(
      //         // video: video,
      //         // path: path,
      //       );
      //     }),
      GoRoute(
          path: kVideoView,
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final String path = extras['path'];
            final bool? network = extras['network'];
            return VideoView(
              path: path,
              network: network ?? false,
            );
          }),
      GoRoute(
        path: kPdfView,
        builder: (context, state) => PdfView(
          path: state.extra as String?,
        ),
      ),
      GoRoute(
          path: kQuizView,
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final Quiz quiz = extras['quiz'];
            // final String quizId = extras['quiz_id'];

            return QuizView(
              quiz: quiz,
            );
          }),
      // // GoRoute(
      // //   path: kQuizSummery,
      // //   builder: (context, state) => BlocProvider(
      // //     create: (context) => PointsCubit(getIt<HomeRepoImpl>()),
      // //     child: QuizSummery(
      // //       quizAnswer: state.extra as QuizAnswer,
      // //     ),
      // //   ),
      // // ),
      GoRoute(
          path: kQuizResults,
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final int fullMark = extras['fullMark'];
            final int userMarks = extras['userMarks'];
            return QuizResults(
              fullMark: fullMark,
              userMarks: userMarks,
            );
          }),
      GoRoute(
          path: kLessonView,
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final Lesson lesson = extras['lesson'];
            final String subjectName = extras['subjectName'];
            final String unitName = extras['unitName'];
            final String subjectId = extras['subject_id'];
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => FetchQuizzesCubit(
                    getIt<SubjectRepoImpl>(),
                  ),
                ),
              ],
              child: LessonView(
                subjectName: subjectName,
                lesson: lesson,
                unitName: unitName,
                subjectId: subjectId,
              ),
            );
          }),
      // GoRoute(
      //   path: kCommentsView,
      //   builder: (context, state) => CommentsView(
      //     courseId: state.extra as String,
      //   ),
      // ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) {
          return ProfileView(
            user: state.extra as Box<User>,
          );
        },
      ),
      // GoRoute(
      //   path: kSpecificationView,
      //   builder: (context, state) {
      //     return MultiBlocProvider(
      //       providers: [
      //         BlocProvider(
      //           create: (context) => GradesCubit(getIt<AuthRepoImpl>()),
      //         ),
      //       ],
      //       child: const SpecificationView(),
      //     );
      //   },
      // ),

      GoRoute(
        path: kDownloadVeiw,
        builder: (context, state) {
          return
              // BlocProvider(
              //   create: (context) => DownloadsCubit(getIt<DownloadsRepoImpl>()),
              //   child: const

              const DownloadVeiw();
          // );
        },
      ),

      GoRoute(
        path: kCommentsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CommentsCubit(getIt<SubjectRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => CommentCubit(getIt<SubjectRepoImpl>()),
            ),
          ],
          child: CommentsView(
            lessonId: state.extra! as String,
          ),
        ),
      ),
    ]);
  }
}
