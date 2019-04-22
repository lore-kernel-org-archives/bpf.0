Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE9CC282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDFF20881
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOjFlpZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDVPz7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:55:59 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50132 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfDVPz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:55:58 -0400
Received: by mail-vk1-f202.google.com with SMTP id 62so5756710vkx.16
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S+Ghpb4mnKd0L6h4L3SS3V7Glk39AhU3yORjjysqrFw=;
        b=AOjFlpZYuInOq/9RmGoHnckBMzblwGWjrwMioOxqquJuRUwdgpX/h2RCOiDwttyzy4
         Cv0dWiLqUAfb0JDGaJJyiqengF4xM/iuggTFE0uldY9Frsc1hIaDiHOn/GlwWCWwfPw+
         ndxqjAZsCFZgYXV51KGPXCjNx1syKG5+1Oa3sGIZspFBNt8qJoMdcK2AOWjJZlLN+bsJ
         0+Xib19OWwyqBpYuGCYMfZkN9d0qOlIPIRGFpDwvCejM7W2e8QLAxwbFuhrwAiBZnefW
         VZvguLUC6HsmWD2Ds9vHtZaWquHPh2DCrtFQlCDuvDUH6btkwGwtJdDz6CmhtBtY859Q
         wQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S+Ghpb4mnKd0L6h4L3SS3V7Glk39AhU3yORjjysqrFw=;
        b=AEOQJzQoPHKv7ThQWemKNVWyfQpAHvTsIv+Vg9y69OVk8I/X4HfKYXRunHNPH9iWns
         OwKs79HEOS9ptNUHgzHxU2i9xt0i6JZHRf90uTjy1h0uefwyG8xOwRF7TdSea97/THOT
         zrSMxGU8I5X+5uudeQEoi++qp09Swz/Hf/oxfMUewl0qBh7Yl/HUeppPFMgCkdbaBt0x
         sazYso9F3lOE25D9NtEA2NsqBJdsTDKjO0BUJkygGvs3q3bDRAlWWHhCmgbjzItbbtCa
         tr8wpWwaVUG0nzl36wkZ6v8naa9QqA0lXBRXTmhIOyLPSp70h0p0DJ51nD9ya8mhBcDb
         xkqg==
X-Gm-Message-State: APjAAAUh41zB2GcmdCguoDa2KIEJybCSYod/shdqXtbP5JRhvsVA/uix
        GXFHQnVHWVX76fenr4vopYUqhYc=
X-Google-Smtp-Source: APXvYqzbq81Ni9QOKwxCdqCWL3o+ugT+1Qzid49ZIL39lcVBRGtBZxbFnnS03xvZfL9VAKxNiVDicQw=
X-Received: by 2002:a67:efdb:: with SMTP id s27mr9862184vsp.132.1555948557259;
 Mon, 22 Apr 2019 08:55:57 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:44 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-2-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 1/9] flow_dissector: switch kernel context to
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
index e81f2b0e8a83..beaedd487be1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1275,6 +1275,10 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
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
index 1833926a63fc..776e3aa35a00 100644
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
@@ -6121,7 +6155,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_skb_load_bytes:
-		return &bpf_skb_load_bytes_proto;
+		return &bpf_flow_dissector_load_bytes_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6248,9 +6282,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
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
@@ -6285,7 +6317,6 @@ static bool sk_filter_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
@@ -6312,7 +6343,6 @@ static bool cg_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
@@ -6358,7 +6388,6 @@ static bool lwt_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6601,7 +6630,6 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct __sk_buff, data_end):
 		info->reg_type = PTR_TO_PACKET_END;
 		break;
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range_till(struct __sk_buff, family, local_port):
 		return false;
 	}
@@ -6803,7 +6831,6 @@ static bool sk_skb_is_valid_access(int off, int size,
 	switch (off) {
 	case bpf_ctx_range(struct __sk_buff, tc_classid):
 	case bpf_ctx_range(struct __sk_buff, data_meta):
-	case bpf_ctx_range_ptr(struct __sk_buff, flow_keys):
 	case bpf_ctx_range(struct __sk_buff, tstamp):
 	case bpf_ctx_range(struct __sk_buff, wire_len):
 		return false;
@@ -6877,24 +6904,65 @@ static bool flow_dissector_is_valid_access(int off, int size,
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
@@ -7201,15 +7269,6 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
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
 
@@ -8214,7 +8273,7 @@ const struct bpf_prog_ops sk_msg_prog_ops = {
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
2.21.0.593.g511ec345e18-goog

