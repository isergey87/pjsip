/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.8
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.pjsip.pjsua2;

public final class pjsip_cred_data_type {
  public final static pjsip_cred_data_type PJSIP_CRED_DATA_PLAIN_PASSWD = new pjsip_cred_data_type("PJSIP_CRED_DATA_PLAIN_PASSWD", pjsua2JNI.PJSIP_CRED_DATA_PLAIN_PASSWD_get());
  public final static pjsip_cred_data_type PJSIP_CRED_DATA_DIGEST = new pjsip_cred_data_type("PJSIP_CRED_DATA_DIGEST", pjsua2JNI.PJSIP_CRED_DATA_DIGEST_get());
  public final static pjsip_cred_data_type PJSIP_CRED_DATA_EXT_AKA = new pjsip_cred_data_type("PJSIP_CRED_DATA_EXT_AKA", pjsua2JNI.PJSIP_CRED_DATA_EXT_AKA_get());

  public final int swigValue() {
    return swigValue;
  }

  public String toString() {
    return swigName;
  }

  public static pjsip_cred_data_type swigToEnum(int swigValue) {
    if (swigValue < swigValues.length && swigValue >= 0 && swigValues[swigValue].swigValue == swigValue)
      return swigValues[swigValue];
    for (int i = 0; i < swigValues.length; i++)
      if (swigValues[i].swigValue == swigValue)
        return swigValues[i];
    throw new IllegalArgumentException("No enum " + pjsip_cred_data_type.class + " with value " + swigValue);
  }

  private pjsip_cred_data_type(String swigName) {
    this.swigName = swigName;
    this.swigValue = swigNext++;
  }

  private pjsip_cred_data_type(String swigName, int swigValue) {
    this.swigName = swigName;
    this.swigValue = swigValue;
    swigNext = swigValue+1;
  }

  private pjsip_cred_data_type(String swigName, pjsip_cred_data_type swigEnum) {
    this.swigName = swigName;
    this.swigValue = swigEnum.swigValue;
    swigNext = this.swigValue+1;
  }

  private static pjsip_cred_data_type[] swigValues = { PJSIP_CRED_DATA_PLAIN_PASSWD, PJSIP_CRED_DATA_DIGEST, PJSIP_CRED_DATA_EXT_AKA };
  private static int swigNext = 0;
  private final int swigValue;
  private final String swigName;
}

