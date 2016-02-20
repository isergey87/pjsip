#define PJ_CONFIG_IPHONE 1
//#define __IPHONE_OS_VERSION_MIN_REQUIRED 70000
//don`t use conference
#define PJMEDIA_CONF_USE_SWITCH_BOARD 1

//Specify the factor with wich RTCP RTT statistics should be normalized if exceptionally high. For e.g. mobile networks with potentially large fluctuations, this might be unwanted.

//Use (0) to disable this feature.
#define PJMEDIA_RTCP_NORMALIZE_FACTOR 0

#define PJMEDIA_HAS_VIDEO 0


#include <pj/config_site_sample.h>

#ifdef PJ_LOG_MAX_LEVEL
#  undef PJ_LOG_MAX_LEVEL
#endif


# define PJ_LOG_MAX_LEVEL 6
