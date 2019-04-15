Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35120C10F12
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FCB2073F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzwGLhhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfDORiJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:09 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:56858 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfDORiH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:07 -0400
Received: by mail-yb1-f201.google.com with SMTP id c14so13655665ybf.23
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BBK/FvIa9mXvLtohrKiViMBXeEqDh+JGk7px0mpp14A=;
        b=DzwGLhhsoyUM4uSlJ7lQUqtvNaZ71EkSwZo3urocMryBMTEpQxpyUBf4xS9GuVdqZq
         W5eJ1MOGlhKNsywbkI1Fsru0uA03WBa0x+NDBoZrVihy9iUNwwwsqwVkOboVZayMvubJ
         QjrZd8kN+EgLdCwLY6cPO6sCDa6xBdB4bGNvoGC/6VV1aLSYJ9vPtR8pjU/0o87CpghW
         U/+4a9CqAMzRRQVHa3o5bSMsFJNIOMRAxQaOrpk/NvuZiuJwH1KaKnmBJtkTmELpNmwJ
         6JjrAy6zVxLHOoLIZYsiqm6k1V4KfUWCSH5BggFPVpJg8AZX3kw2BakAdXTpcW9d61OZ
         IaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BBK/FvIa9mXvLtohrKiViMBXeEqDh+JGk7px0mpp14A=;
        b=TmaXc7+o3OboqYSqOsxg74cPDA/C8cXDDDwe8szmnEjVQVUkBB3vmH3s9MXRTHCbQQ
         whRD1oi+V/hNfq7VA2JpKEWU0MCUKxA1IFCk/hZ0B8JXV3ZFcDLUATAW2rs5ENB6oQOv
         G5o3+RYhoNa45QBr+dAOD919v5qaJ1Uc9cce7RhV9qT1bC5DtEz5rhuEnaevyz8BgtHo
         PUVaNwsoFEPJKchh+H81c2G9djRv0yf4yZBtamr1KunJDdn6cPXUVCcFQ7qy6mrToeUd
         yd8DR7DllbvXwZRks7yUgwPtlBgHoeQvgRscWAJT5Bm7qhKKJCvw4BX8ReXLXpPXc02L
         PEjw==
X-Gm-Message-State: APjAAAXvchlMTK2I8b9DISxhzgUJa1yZf7NE93Qvs0+ccB2EA6BmcPpJ
        9yVyYkFIPGGpTE4UhdKxfmxrBU0=
X-Google-Smtp-Source: APXvYqxX0+4ZxIudfc/RIy0JqJoZBP6LQM8yj+EcFG4EENDINTQ6OMnY5pvjSF+Szh0zlOAXRP6KKQk=
X-Received: by 2002:a25:ef50:: with SMTP id w16mr10085465ybm.20.1555349886747;
 Mon, 15 Apr 2019 10:38:06 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:37:56 -0700
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
Message-Id: <20190415173801.257254-2-sdf@google.com>
Mime-Version: 1.0
References: <20190415173801.257254-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 1/6] flow_dissector: switch kernel context to
 struct bpf_flow_dissector
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
 include/net/flow_dissector.h |   7 +++
 include/net/sch_generic.h    |  11 ++--
 net/bpf/test_run.c           |   4 --
 net/core/filter.c            | 105 +++++++++++++++++++++++++++--------
 net/core/flow_dissector.c    |  45 +++++++--------
 6 files changed, 117 insertions(+), 59 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a06275a618f0..4d2365ffa444 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1273,6 +1273,10 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 }
 #endif
 
+struct bpf_flow_dissector;
+bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		      __be16 proto, int nhoff, int hlen);
+
 struct bpf_flow_keys;
 bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 2b26979efb48..7c5a8d9a8d2a 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -305,4 +305,11 @@ static inline void *skb_flow_dissector_target(struct flow_dissector *flow_dissec
 	return ((char *)target_container) + flow_dissector->offset[key_id];
 }
 
+struct bpf_flow_dissector {
+	struct bpf_flow_keys	*flow_keys;
+	const struct sk_buff	*skb;
+	void			*data;
+	void			*data_end;
+};
+
 #endif
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index e8f85cd2afce..21f434f3ac9e 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -364,13 +364,10 @@ struct tcf_proto {
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
index 2221573dacdb..006ad865f7fb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -382,7 +382,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	u32 repeat = kattr->test.repeat;
 	struct bpf_flow_keys flow_keys;
 	u64 time_start, time_spent = 0;
-	struct bpf_skb_data_end *cb;
 	u32 retval, duration;
 	struct sk_buff *skb;
 	struct sock *sk;
@@ -423,9 +422,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				       current->nsproxy->net_ns->loopback_dev);
 	skb_reset_network_header(skb);
 
-	cb = (struct bpf_skb_data_end *)skb->cb;
-	cb->qdisc_cb.flow_keys = &flow_keys;
-
 	if (!repeat)
 		repeat = 1;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 95a27fdf9a40..52c2424226e9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1730,6 +1730,40 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
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
@@ -6119,7 +6153,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_skb_load_bytes:
-		return &bpf_skb_load_bytes_proto;
+		return &bpf_flow_dissector_load_bytes_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6246,9 +6280,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
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
@@ -6283,7 +6315,6 @@ static bool sk_filter_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
@@ -6310,7 +6341,6 @@ static bool cg_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
@@ -6356,7 +6386,6 @@ static bool lwt_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6599,7 +6628,6 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data_end):
 		info->reg_type = PTR_TO_PACKET_END;
 		break;
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 		return false;
 	}
@@ -6801,7 +6829,6 @@ static bool sk_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6875,24 +6902,65 @@ static bool flow_dissector_is_valid_access(int off, int size,
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
+	}
+
+	return insn - insn_buf;
 }
 
 static u32 bpf_convert_ctx_access(enum bpf_access_type type,
@@ -7199,15 +7267,6 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
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
 
@@ -8212,7 +8271,7 @@ const struct bpf_prog_ops sk_msg_prog_ops = {
 const struct bpf_verifier_ops flow_dissector_verifier_ops = {
 	.get_func_proto		= flow_dissector_func_proto,
 	.is_valid_access	= flow_dissector_is_valid_access,
-	.convert_ctx_access	= bpf_convert_ctx_access,
+	.convert_ctx_access	= flow_dissector_convert_ctx_access,
 };
 
 const struct bpf_prog_ops flow_dissector_prog_ops = {
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 795449713ba4..ef6d9443cc75 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -688,39 +688,34 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
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
+		.data = skb->data,
+		.data_end = skb->data + skb_headlen(skb),
+	};
+
+	return bpf_flow_dissect(prog, &ctx, skb->protocol,
+				skb_network_offset(skb), skb_headlen(skb));
+}
 
-	/* Save Control Block */
-	memcpy(&cb_saved, cb, sizeof(cb_saved));
-	memset(cb, 0, sizeof(*cb));
+bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		      __be16 proto, int nhoff, int hlen)
+{
+	struct bpf_flow_keys *flow_keys = ctx->flow_keys;
+	u32 result;
 
 	/* Pass parameters to the BPF program */
 	memset(flow_keys, 0, sizeof(*flow_keys));
-	cb->qdisc_cb.flow_keys = flow_keys;
-	flow_keys->n_proto = skb->protocol;
-	flow_keys->nhoff = skb_network_offset(skb);
+	flow_keys->n_proto = proto;
+	flow_keys->nhoff = nhoff;
 	flow_keys->thoff = flow_keys->nhoff;
 
-	bpf_compute_data_pointers((struct sk_buff *)skb);
-	result = BPF_PROG_RUN(prog, skb);
-
-	/* Restore state */
-	memcpy(cb, &cb_saved, sizeof(cb_saved));
+	result = BPF_PROG_RUN(prog, ctx);
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff,
-				   skb_network_offset(skb), skb->len);
+	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-				   flow_keys->nhoff, skb->len);
+				   flow_keys->nhoff, hlen);
 
 	return result == BPF_OK;
 }
-- 
2.21.0.392.gf8f6787159e-goog

