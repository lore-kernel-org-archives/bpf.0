Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E53C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5850121874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/hchAYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCVT7O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:14 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54943 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVT7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:11 -0400
Received: by mail-pg1-f202.google.com with SMTP id n10so3062906pgp.21
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r75uNEhgLeVjTyRWDK6ob3CcZ9pFIgKHL2eDVm8Z/Pw=;
        b=Y/hchAYvAPKxkZhhupDufgqr1DGAIgxmNOCqIkRkzr7anqhTLibZMffCcOQNtU7V7z
         O4KNMVBKl8E0ZTazypTsuUpFAguBB1hZLhLo0OvLgWjvU6KFlLm78We4n9oSM0UuaLrE
         clFKIPuY/dkKqaQW5jMD3LApFeBex9K8vYRk3EAq0mdO7uwnGr1OMWQFeuBlll5cfTii
         5U4P6NwLbxZb2/y5gX9Pke1VRVNRD8A9x/IRdDeB9o0TrX/m5R6VYIivbIP76QNJaRir
         T/q+WcwZuvloCI8PvhNVM4I/KAYopIkJK0rXVopMOsTgRJrRhYny/961onXhdl7t/K6J
         wRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r75uNEhgLeVjTyRWDK6ob3CcZ9pFIgKHL2eDVm8Z/Pw=;
        b=Z5cPvfEYEtKBB/tdPRbgHAK74E+D3xNP+gsPnGYEYb2mxbFIbwwFV4kY9ZBBBC5Ho8
         ew4fa7hMR2F2oDY/pggUbqIMMnX07ca6hldIZ06zdSZWKxc7lrRvCOqf+9R5+dMwqifc
         z4+3olTskyFD6iXbli1FlBjdwM+jZP9yarWwXGa+eWLIU1nwU6aHyvqqMKYNgnfLLffa
         uIvjuDsIshrQP1AmCbjoC00wVC8LZbNVUB6ghL2zDhbvYccZE6qDW7euJ8mcQApGcbq1
         tvxvCVrRZQ3omf2icp1vsLmPnSyccqV9act/qzjeXQX5awgUmROxBiGMGQEU5TKqzb7u
         12Mw==
X-Gm-Message-State: APjAAAWXNP482p/CTeSQ6sUGOAGdBziRigy4SJo1XpvgaEJxkJvxLMgr
        kjSmZkzsNfMyz/tT3sVa3nZheco=
X-Google-Smtp-Source: APXvYqy69pF1jcmzQzDzf2CMBj6eZXs9L2hvTdoQoOJ+nIiTD+wBdx1sQAXjk3Ux6HBQwFS7AILWSAE=
X-Received: by 2002:a63:ed11:: with SMTP id d17mr10652385pgi.211.1553284751121;
 Fri, 22 Mar 2019 12:59:11 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:58:57 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-3-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 2/8] flow_dissector: switch kernel context to struct bpf_flow_dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct bpf_flow_dissector has a small subset of sk_buff fields that
flow dissector BPF program is allowed to access and an optional
pointer to real skb. Real skb is used only in bpf_skb_load_bytes
helper to read non-linear data.

The real motivation for this is to be able to call flow dissector
from eth_get_headlen context where we don't have an skb and need
to dissect raw bytes.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h       |   4 ++
 include/net/flow_dissector.h |  11 +++
 include/net/sch_generic.h    |  11 ++-
 net/bpf/test_run.c           |   4 --
 net/core/filter.c            | 132 ++++++++++++++++++++++++++++-------
 net/core/flow_dissector.c    |  46 ++++++------
 6 files changed, 150 insertions(+), 58 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9027a8c4219f..a62149af940b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1275,6 +1275,10 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 }
 #endif
 
+struct bpf_flow_dissector;
+bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		      int nhoff, int hlen);
+
 struct bpf_flow_keys;
 bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 2b26979efb48..41baa8624ea3 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -305,4 +305,15 @@ static inline void *skb_flow_dissector_target(struct flow_dissector *flow_dissec
 	return ((char *)target_container) + flow_dissector->offset[key_id];
 }
 
+struct bpf_flow_dissector {
+	struct bpf_flow_keys	*flow_keys;
+	const struct sk_buff	*skb;
+	void			*data;
+	void			*data_end;
+	__be16			protocol;
+	__u16			vlan_tci;
+	__be16			vlan_proto;
+	__u8			vlan_present;
+};
+
 #endif
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 31284c078d06..cc9ffdd44bf1 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -351,13 +351,10 @@ struct tcf_proto {
 };
 
 struct qdisc_skb_cb {
-	union {
-		struct {
-			unsigned int		pkt_len;
-			u16			slave_dev_queue_mapping;
-			u16			tc_classid;
-		};
-		struct bpf_flow_keys *flow_keys;
+	struct {
+		unsigned int		pkt_len;
+		u16			slave_dev_queue_mapping;
+		u16			tc_classid;
 	};
 #define QDISC_CB_PRIV_LEN 20
 	unsigned char		data[QDISC_CB_PRIV_LEN];
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fab142b796ef..7444ca87abf4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -252,7 +252,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	u32 repeat = kattr->test.repeat;
 	struct bpf_flow_keys flow_keys;
 	u64 time_start, time_spent = 0;
-	struct bpf_skb_data_end *cb;
 	u32 retval, duration;
 	struct sk_buff *skb;
 	struct sock *sk;
@@ -290,9 +289,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				       current->nsproxy->net_ns->loopback_dev);
 	skb_reset_network_header(skb);
 
-	cb = (struct bpf_skb_data_end *)skb->cb;
-	cb->qdisc_cb.flow_keys = &flow_keys;
-
 	if (!repeat)
 		repeat = 1;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 62a7a2f50200..906ec0e67111 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1729,6 +1729,40 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_4(bpf_flow_dissector_load_bytes,
+	   const struct bpf_flow_dissector *, ctx, u32, offset,
+	   void *, to, u32, len)
+{
+	void *ptr;
+
+	if (unlikely(offset > 0xffff))
+		goto err_clear;
+
+	if (unlikely(!ctx->skb))
+		goto err_clear;
+
+	ptr = skb_header_pointer(ctx->skb, offset, len, to);
+	if (unlikely(!ptr))
+		goto err_clear;
+	if (ptr != to)
+		memcpy(to, ptr, len);
+
+	return 0;
+err_clear:
+	memset(to, 0, len);
+	return -EFAULT;
+}
+
+static const struct bpf_func_proto bpf_flow_dissector_load_bytes_proto = {
+	.func		= bpf_flow_dissector_load_bytes,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	   u32, offset, void *, to, u32, len, u32, start_header)
 {
@@ -5857,7 +5891,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_skb_load_bytes:
-		return &bpf_skb_load_bytes_proto;
+		return &bpf_flow_dissector_load_bytes_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5984,9 +6018,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 			return false;
 		break;
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
-		if (size != sizeof(__u64))
-			return false;
-		break;
+		return false;
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 		if (size != sizeof(__u64))
 			return false;
@@ -6021,7 +6053,6 @@ static bool sk_filter_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
@@ -6048,7 +6079,6 @@ static bool cg_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
@@ -6094,7 +6124,6 @@ static bool lwt_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6337,7 +6366,6 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data_end):
 		info->reg_type = PTR_TO_PACKET_END;
 		break;
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 		return false;
 	}
@@ -6539,7 +6567,6 @@ static bool sk_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6613,29 +6640,95 @@ static bool flow_dissector_is_valid_access(int off, int size,
 					   const struct bpf_prog *prog,
 					   struct bpf_insn_access_aux *info)
 {
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off >= sizeof(struct __sk_buff))
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, data):
+		if (size != size_default)
+			return false;
 		info->reg_type = PTR_TO_PACKET;
-		break;
+		return true;
 	case bpf_ctx_range(struct __sk_buff, data_end):
+		if (size != size_default)
+			return false;
 		info->reg_type = PTR_TO_PACKET_END;
-		break;
+		return true;
 	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
+		if (size != sizeof(__u64))
+			return false;
 		info->reg_type = PTR_TO_FLOW_KEYS;
-		break;
+		return true;
 	case bpf_ctx_range(struct __sk_buff, protocol):
 	case bpf_ctx_range(struct __sk_buff, vlan_present):
 	case bpf_ctx_range(struct __sk_buff, vlan_tci):
 	case bpf_ctx_range(struct __sk_buff, vlan_proto):
-		break;
+		bpf_ctx_record_field_size(info, size_default);
+		return bpf_ctx_narrow_access_ok(off, size, size_default);
 	default:
 		return false;
 	}
+}
 
-	return bpf_skb_is_valid_access(off, size, type, prog, info);
+static u32 flow_dissector_convert_ctx_access(enum bpf_access_type type,
+					     const struct bpf_insn *si,
+					     struct bpf_insn *insn_buf,
+					     struct bpf_prog *prog,
+					     u32 *target_size)
+
+{
+	struct bpf_insn *insn = insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct __sk_buff, data):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_flow_dissector, data),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_flow_dissector, data));
+		break;
+
+	case offsetof(struct __sk_buff, data_end):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_flow_dissector, data_end),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_flow_dissector, data_end));
+		break;
+
+	case offsetof(struct __sk_buff, flow_keys):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_flow_dissector, flow_keys),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_flow_dissector, flow_keys));
+		break;
+
+	case offsetof(struct __sk_buff, protocol):
+		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_flow_dissector, protocol, 2,
+						     target_size));
+		break;
+
+	case offsetof(struct __sk_buff, vlan_present):
+		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_flow_dissector, vlan_present, 1,
+						     target_size));
+		break;
+
+	case offsetof(struct __sk_buff, vlan_tci):
+		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_flow_dissector, vlan_tci, 2,
+						     target_size));
+		break;
+
+	case offsetof(struct __sk_buff, vlan_proto):
+		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_flow_dissector, vlan_proto, 2,
+						     target_size));
+		break;
+	}
+
+	return insn - insn_buf;
 }
 
 static u32 bpf_convert_ctx_access(enum bpf_access_type type,
@@ -6942,15 +7035,6 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 						     skc_num, 2, target_size));
 		break;
 
-	case offsetof(struct __sk_buff, flow_keys):
-		off  = si->off;
-		off -= offsetof(struct __sk_buff, flow_keys);
-		off += offsetof(struct sk_buff, cb);
-		off += offsetof(struct qdisc_skb_cb, flow_keys);
-		*insn++ = BPF_LDX_MEM(BPF_SIZEOF(void *), si->dst_reg,
-				      si->src_reg, off);
-		break;
-
 	case offsetof(struct __sk_buff, tstamp):
 		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, tstamp) != 8);
 
@@ -7955,7 +8039,7 @@ const struct bpf_prog_ops sk_msg_prog_ops = {
 const struct bpf_verifier_ops flow_dissector_verifier_ops = {
 	.get_func_proto		= flow_dissector_func_proto,
 	.is_valid_access	= flow_dissector_is_valid_access,
-	.convert_ctx_access	= bpf_convert_ctx_access,
+	.convert_ctx_access	= flow_dissector_convert_ctx_access,
 };
 
 const struct bpf_prog_ops flow_dissector_prog_ops = {
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index bb1a54747d64..0dac3382e841 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -688,37 +688,37 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    struct flow_dissector *flow_dissector,
 			    struct bpf_flow_keys *flow_keys)
 {
-	struct bpf_skb_data_end cb_saved;
-	struct bpf_skb_data_end *cb;
-	u32 result;
-
-	/* Note that even though the const qualifier is discarded
-	 * throughout the execution of the BPF program, all changes(the
-	 * control block) are reverted after the BPF program returns.
-	 * Therefore, __skb_flow_dissect does not alter the skb.
-	 */
-
-	cb = (struct bpf_skb_data_end *)skb->cb;
+	struct bpf_flow_dissector ctx = {
+		.flow_keys = flow_keys,
+		.skb = skb,
+		.protocol = skb->protocol,
+		.vlan_tci = skb->vlan_tci,
+		.vlan_proto = skb->vlan_proto,
+		.vlan_present = skb->vlan_present,
+		.data = skb->data,
+		.data_end = skb->data + skb_headlen(skb),
+	};
+
+	return bpf_flow_dissect(prog, &ctx, skb_network_offset(skb),
+				skb_headlen(skb));
+}
 
-	/* Save Control Block */
-	memcpy(&cb_saved, cb, sizeof(cb_saved));
-	memset(cb, 0, sizeof(*cb));
+bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		      int nhoff, int hlen)
+{
+	struct bpf_flow_keys *flow_keys = ctx->flow_keys;
+	u32 result;
 
 	/* Pass parameters to the BPF program */
 	memset(flow_keys, 0, sizeof(*flow_keys));
-	cb->qdisc_cb.flow_keys = flow_keys;
-	flow_keys->nhoff = skb_network_offset(skb);
+	flow_keys->nhoff = nhoff;
 	flow_keys->thoff = flow_keys->nhoff;
 
-	bpf_compute_data_pointers((struct sk_buff *)skb);
-	result = BPF_PROG_RUN(prog, skb);
-
-	/* Restore state */
-	memcpy(cb, &cb_saved, sizeof(cb_saved));
+	result = BPF_PROG_RUN(prog, ctx);
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, skb->len);
+	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-				   flow_keys->nhoff, skb->len);
+				   flow_keys->nhoff, hlen);
 
 	return result == BPF_OK;
 }
-- 
2.21.0.392.gf8f6787159e-goog

