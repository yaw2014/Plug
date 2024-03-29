//
//  Constants.h
//  blinQ
//
//  Created by Le Thanh Hai on 5/1/14.
//  Copyright (c) 2014 templum. All rights reserved.
//

#ifndef blinQ_Constants_h
#define blinQ_Constants_h

//old server: http://www.fourballoon.com/blinq/webservices/
//new server: http://techgeek.site11.com/webservices/
//aws server: http://templumapp.com/temp/plug/webservices/
//url
#define GROUPS_RETRIEVE_URL                     @"http://templumapp.com/temp/plug/webservices/get_list_groups.php"
#define ASK_QUESTION_URL                        @"http://templumapp.com/temp/plug/webservices/ask_a_question.php"
#define GET_MY_QUESTIONS_URL                    @"http://templumapp.com/temp/plug/webservices/get_my_questions.php"
#define GET_QUESTIONS_FOR_ME_URL                @"http://templumapp.com/temp/plug/webservices/get_questions_for_me.php"
#define GET_TOP_QUESTIONS_URL                   @"http://templumapp.com/temp/plug/webservices/get_top_questions.php"
#define SUBMIT_ANSWER_URL                       @"http://templumapp.com/temp/plug/webservices/submit_answer.php"
#define GET_ANSWER_FOR_QUESTION_URL             @"http://templumapp.com/temp/plug/webservices/get_answer_for_question.php"
#define SEARCH_ON_QUESTIONS_URL                 @"http://templumapp.com/temp/plug/webservices/search_on_questions.php"
#define VOTE_ANSWER_URL                         @"http://templumapp.com/temp/plug/webservices/submit_vote.php"

#define REGISTER_USER_URL                       @"http://templumapp.com/temp/plug/webservices/register_user.php"
#define SUBMIT_AVATAR_URL                       @"http://templumapp.com/temp/plug/webservices/submit_avatar.php"
//#define SUBMIT_AVATAR_URL                       @"http://54.214.241.110/gopro/webservices/submit_avatar.php"

#define LOGIN_URL                               @"http://templumapp.com/temp/plug/webservices/login.php"
#define FORGOT_PASSWORD_URL                     @"http://templumapp.com/temp/plug/webservices/forgot_password.php"
#define RETRIEVE_USER_INFO_URL                  @"http://templumapp.com/temp/plug/webservices/get_user_info.php"
#define UPDATE_USER_INFO_URL                    @"http://templumapp.com/temp/plug/webservices/update_user.php"

//key
#define USER_ID_KEY                             @"userId"
#define USER_NAME_KEY                           @"userNameKey"
#define USER_EMAIL_KEY                          @"userEmailKey"
#define USER_SECTION_KEY                        @"userSectionKey"
#define USER_YEAR_KEY                           @"userYearKey"
#define USER_CITY_KEY                           @"userCityKey"
#define USER_STATE_KEY                          @"userStateKey"
#define USER_COUNTRY_KEY                        @"userCountryKey"
#define USER_AVATAR_KEY                         @"userAvatarKey"
#define USER_CREATED_DATE_KEY                   @"userCreatedDateKey"

//notifications
#define DID_ASK_A_QUESTION_NOTI                 @"didAskAQuestionNoti"

//value
#define REQUEST_TIMER                           120.0

//message
#define EMPTY_REGISTER_FIELD_MSG                @"Please input data"
#define EMPTY_LOGIN_FIELD_MSG                   @"Please input data"
#define PASSWORD_REGISTER_NOT_MATCH_MSG         @"Password not match"
#define NEW_PASSWORD_DEFINE_MSG                 @"Please define new password"
#define EMAIL_INVALID_MSG                       @"Invalid email format"
#define EMPTY_GROUP_MSG                         @"You should select at least one group"
#define EMAIL_EMPTY_MSG                         @"Please input your email"
#define EMAIL_SENT_SUCCESS_MSG                  @"An email has been sent to your address"
#define QUESTION_SUBJECT_EMPTY_MSG              @"Please fill the subject"
#define ASK_QUESTION_SUCCESS_MSG                @"Your question has been submitted"
#define CHANGE_AVATAR_SUCCESS_MSG               @"Change avatar successfully"
#define EDIT_USER_SUCCESS_MSG                   @"Update user successfully"
#define ANSWER_SUBMIT_SUCCESS_MSG               @"Your answer has been submitted."
#define EMPTY_ANSWER_MSG                        @"Please input your answer"
#endif
