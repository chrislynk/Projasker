<?php
/**
 * config-mini.php mini app configuration stores app-wide settings
 * 
 * Stores configuration data like time zone settings, session save path, 
 * 
 *
 * There is a reference to an include file named credentials.php which provides 
 * WP style constants to identify DB credentials
 *
 * Place both config-mini.php and credentials.php in a sub folder named include 
 * and reference config-mini.php at the top of every PHP page thus:
 *
 *<code>
 *include 'include/config-mini.php';
 *</code>
 *
 * No need to reference credentials.php as it is referenced by config-mini.php
 * @package nmMini
 * @author Bill Newman <williamnewman@gmail.com>
 * @version 1.0 2012/07/29 
 * @link http://www.newmanix.com/ 
 * @license http://opensource.org/licenses/osl-3.0.php Open Software License ("OSL") v. 3.0
 * @see credentials.php
 * @todo none
 */

define('DEBUG', TRUE); # TRUE = Show raw database errors & all PHP notices, etc.
date_default_timezone_set('America/Los_Angeles'); #sets default date/timezone for this website
//ini_set('session.save_path','/home/classes/horsey01/sessions'); #optional folder set to 0700 outside webroot to store session data
//ini_set('session.cookie_domain', '.seattlecentral.edu'); # "dot" (period) then domain name - apply session cookies to subdomains!

# End Config area --------------------------------
ob_start();  #buffers our page to be prevent header errors. Call before INC files or ANY html!
header("Cache-Control: no-cache");header("Expires: -1");#Helps stop browser & proxy caching
define('THIS_PAGE', basename($_SERVER['PHP_SELF'])); # Current page name, stripped of folder info - (saves resources)
$title = THIS_PAGE; //fallback unique title - see title tag in header.php
if(DEBUG)
{# When debugging, show all errors & warnings
	ini_set('error_reporting', E_ALL | E_STRICT);  
}else{# zero will hide everything except fatal errors
	ini_set('error_reporting', 0);  
}

include 'credentials.php'; #Stores DB credentials - should not be visible in config file

#error handling function -------------
function myerror($myFile, $myLine, $msg)
{
    if(DEBUG)
    {
       echo "Error in file: <b>" . $myFile . "</b><br /> on line: <b>" . $myLine . "</b><br />";
       echo "Error Message: <b>" . $msg . "</b>";
    }else{
	   echo "I'm sorry, we have encountered an error!";
    }
}