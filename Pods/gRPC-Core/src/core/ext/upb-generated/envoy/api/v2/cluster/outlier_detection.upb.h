/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     envoy/api/v2/cluster/outlier_detection.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#ifndef ENVOY_API_V2_CLUSTER_OUTLIER_DETECTION_PROTO_UPB_H_
#define ENVOY_API_V2_CLUSTER_OUTLIER_DETECTION_PROTO_UPB_H_

#if COCOAPODS==1
  #include  "third_party/upb/upb/generated_util.h"
#else
  #include  "upb/generated_util.h"
#endif
#if COCOAPODS==1
  #include  "third_party/upb/upb/msg.h"
#else
  #include  "upb/msg.h"
#endif
#if COCOAPODS==1
  #include  "third_party/upb/upb/decode.h"
#else
  #include  "upb/decode.h"
#endif
#if COCOAPODS==1
  #include  "third_party/upb/upb/encode.h"
#else
  #include  "upb/encode.h"
#endif

#if COCOAPODS==1
  #include  "third_party/upb/upb/port_def.inc"
#else
  #include  "upb/port_def.inc"
#endif

#ifdef __cplusplus
extern "C" {
#endif

struct envoy_api_v2_cluster_OutlierDetection;
typedef struct envoy_api_v2_cluster_OutlierDetection envoy_api_v2_cluster_OutlierDetection;
extern const upb_msglayout envoy_api_v2_cluster_OutlierDetection_msginit;
struct google_protobuf_Duration;
struct google_protobuf_UInt32Value;
extern const upb_msglayout google_protobuf_Duration_msginit;
extern const upb_msglayout google_protobuf_UInt32Value_msginit;


/* envoy.api.v2.cluster.OutlierDetection */

UPB_INLINE envoy_api_v2_cluster_OutlierDetection *envoy_api_v2_cluster_OutlierDetection_new(upb_arena *arena) {
  return (envoy_api_v2_cluster_OutlierDetection *)upb_msg_new(&envoy_api_v2_cluster_OutlierDetection_msginit, arena);
}
UPB_INLINE envoy_api_v2_cluster_OutlierDetection *envoy_api_v2_cluster_OutlierDetection_parse(const char *buf, size_t size,
                        upb_arena *arena) {
  envoy_api_v2_cluster_OutlierDetection *ret = envoy_api_v2_cluster_OutlierDetection_new(arena);
  return (ret && upb_decode(buf, size, ret, &envoy_api_v2_cluster_OutlierDetection_msginit, arena)) ? ret : NULL;
}
UPB_INLINE char *envoy_api_v2_cluster_OutlierDetection_serialize(const envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena, size_t *len) {
  return upb_encode(msg, &envoy_api_v2_cluster_OutlierDetection_msginit, arena, len);
}

UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_consecutive_5xx(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(4, 8)); }
UPB_INLINE const struct google_protobuf_Duration* envoy_api_v2_cluster_OutlierDetection_interval(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_Duration*, UPB_SIZE(8, 16)); }
UPB_INLINE const struct google_protobuf_Duration* envoy_api_v2_cluster_OutlierDetection_base_ejection_time(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_Duration*, UPB_SIZE(12, 24)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_max_ejection_percent(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(16, 32)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_5xx(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(20, 40)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_enforcing_success_rate(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(24, 48)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_success_rate_minimum_hosts(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(28, 56)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_success_rate_request_volume(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(32, 64)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_success_rate_stdev_factor(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(36, 72)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_consecutive_gateway_failure(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(40, 80)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_gateway_failure(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(44, 88)); }
UPB_INLINE bool envoy_api_v2_cluster_OutlierDetection_split_external_local_origin_errors(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, bool, UPB_SIZE(0, 0)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_consecutive_local_origin_failure(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(48, 96)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_local_origin_failure(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(52, 104)); }
UPB_INLINE const struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_enforcing_local_origin_success_rate(const envoy_api_v2_cluster_OutlierDetection *msg) { return UPB_FIELD_AT(msg, const struct google_protobuf_UInt32Value*, UPB_SIZE(56, 112)); }

UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_consecutive_5xx(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(4, 8)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_consecutive_5xx(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_consecutive_5xx(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_consecutive_5xx(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_interval(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_Duration* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_Duration*, UPB_SIZE(8, 16)) = value;
}
UPB_INLINE struct google_protobuf_Duration* envoy_api_v2_cluster_OutlierDetection_mutable_interval(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_Duration* sub = (struct google_protobuf_Duration*)envoy_api_v2_cluster_OutlierDetection_interval(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_Duration*)upb_msg_new(&google_protobuf_Duration_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_interval(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_base_ejection_time(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_Duration* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_Duration*, UPB_SIZE(12, 24)) = value;
}
UPB_INLINE struct google_protobuf_Duration* envoy_api_v2_cluster_OutlierDetection_mutable_base_ejection_time(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_Duration* sub = (struct google_protobuf_Duration*)envoy_api_v2_cluster_OutlierDetection_base_ejection_time(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_Duration*)upb_msg_new(&google_protobuf_Duration_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_base_ejection_time(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_max_ejection_percent(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(16, 32)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_max_ejection_percent(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_max_ejection_percent(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_max_ejection_percent(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_5xx(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(20, 40)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_enforcing_consecutive_5xx(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_5xx(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_5xx(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_enforcing_success_rate(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(24, 48)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_enforcing_success_rate(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_enforcing_success_rate(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_enforcing_success_rate(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_success_rate_minimum_hosts(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(28, 56)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_success_rate_minimum_hosts(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_success_rate_minimum_hosts(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_success_rate_minimum_hosts(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_success_rate_request_volume(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(32, 64)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_success_rate_request_volume(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_success_rate_request_volume(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_success_rate_request_volume(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_success_rate_stdev_factor(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(36, 72)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_success_rate_stdev_factor(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_success_rate_stdev_factor(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_success_rate_stdev_factor(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_consecutive_gateway_failure(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(40, 80)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_consecutive_gateway_failure(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_consecutive_gateway_failure(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_consecutive_gateway_failure(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_gateway_failure(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(44, 88)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_enforcing_consecutive_gateway_failure(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_gateway_failure(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_gateway_failure(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_split_external_local_origin_errors(envoy_api_v2_cluster_OutlierDetection *msg, bool value) {
  UPB_FIELD_AT(msg, bool, UPB_SIZE(0, 0)) = value;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_consecutive_local_origin_failure(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(48, 96)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_consecutive_local_origin_failure(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_consecutive_local_origin_failure(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_consecutive_local_origin_failure(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_local_origin_failure(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(52, 104)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_enforcing_consecutive_local_origin_failure(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_enforcing_consecutive_local_origin_failure(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_enforcing_consecutive_local_origin_failure(msg, sub);
  }
  return sub;
}
UPB_INLINE void envoy_api_v2_cluster_OutlierDetection_set_enforcing_local_origin_success_rate(envoy_api_v2_cluster_OutlierDetection *msg, struct google_protobuf_UInt32Value* value) {
  UPB_FIELD_AT(msg, struct google_protobuf_UInt32Value*, UPB_SIZE(56, 112)) = value;
}
UPB_INLINE struct google_protobuf_UInt32Value* envoy_api_v2_cluster_OutlierDetection_mutable_enforcing_local_origin_success_rate(envoy_api_v2_cluster_OutlierDetection *msg, upb_arena *arena) {
  struct google_protobuf_UInt32Value* sub = (struct google_protobuf_UInt32Value*)envoy_api_v2_cluster_OutlierDetection_enforcing_local_origin_success_rate(msg);
  if (sub == NULL) {
    sub = (struct google_protobuf_UInt32Value*)upb_msg_new(&google_protobuf_UInt32Value_msginit, arena);
    if (!sub) return NULL;
    envoy_api_v2_cluster_OutlierDetection_set_enforcing_local_origin_success_rate(msg, sub);
  }
  return sub;
}

#ifdef __cplusplus
}  /* extern "C" */
#endif

#if COCOAPODS==1
  #include  "third_party/upb/upb/port_undef.inc"
#else
  #include  "upb/port_undef.inc"
#endif

#endif  /* ENVOY_API_V2_CLUSTER_OUTLIER_DETECTION_PROTO_UPB_H_ */
