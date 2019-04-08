Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C11C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F920857
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGMv2Yz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDHQEg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:04:36 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50956 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHQEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:04:35 -0400
Received: by mail-pf1-f201.google.com with SMTP id a3so10736433pfi.17
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2019 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vO6B3Pv/5qkgaiMHpbPzlVhWvLiaewqJLMK80sDOIGk=;
        b=VGMv2Yz+2Yu2BpT0ZHqjPN9371VbqPuj3Oe5EpOsSr9XlErqtZC5S5DyIDsNX/25al
         Lfr0MAsilDgaiLDfkVrUdCOObccqcifO0PsMY4YN/MEzoLJFNXI7rRy710ahsrNPy7Ad
         50sULTsm+ynoqCYZwApW8FubwQne/7h/JI7wAW+rzltdS9mVVojUET5Mhg8arSDHaUz4
         joHSRsZMUZrEtrfwPNx0jcOeq7EG+7AI8eET7alxM2QbA6wBXkaPPDoN+vdelFeACrKI
         vgtNaGWhCtc+vqsOgTTqT3w3IEivgcFSrW6nTaZ3NPvZykjiOC4ClHMPg1XISRHUmDfq
         /pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vO6B3Pv/5qkgaiMHpbPzlVhWvLiaewqJLMK80sDOIGk=;
        b=B92ZaI2obFdx+MEfV6yYTVTxkZZ7CHYPDQuhxjWQtag9K/BtofThlhwOT+F1Ge64lQ
         qtnUFfEQspDhh5ZoNPzCUdfJqjyL8f1XCID5svOGYYjCKJPXOBzh0gNXWdEdbsvWIMXR
         R+V9jS2AX2gtv3tvxFmFut72DEVfXArqYPXfgTCFK7aggR84v/AZ6ZUgB+Sf0acE9+B3
         EwnoRWKDhbfspqmUWx8wdL0FKXKSUfdlliyA1lwy2PLF5lZHsC/bYuI9bMUG0FgmLBRs
         WmvJSRMTfXA9iZQ4mwp2AeTLUSA6jl0e1KUW8m8JPR4bm50EbTPGoWnr2hjPBR12H5lm
         +nzg==
X-Gm-Message-State: APjAAAV1UJQrv722owQEX7ezUrcD7vK/+BmW5DDYRq/rGSOsbHx2kQ/g
        NoUk0mNNYrfJbutOw+ecUGKGBoc=
X-Google-Smtp-Source: APXvYqyAqFeN9BYo9OwmD12A0nNtuhF89pN6sEAnLYYccc+1zXYRsvSzrhIResq7vrXFlw4OgoDHAv4=
X-Received: by 2002:a17:902:54e:: with SMTP id 72mr1271717plf.15.1554739474608;
 Mon, 08 Apr 2019 09:04:34 -0700 (PDT)
Date:   Mon,  8 Apr 2019 09:04:30 -0700
Message-Id: <20190408160432.151478-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v2 1/3] bpf: support input __sk_buff context in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
* ctx_in/ctx_size_in - input context
* ctx_out/ctx_size_out - output context

The intended use case is to pass some meta data to the test runs that
operate on skb (this has being brought up on recent LPC).

For programs that use bpf_prog_test_run_skb, support __sk_buff input and
output. Initially, from input __sk_buff, copy _only_ cb and priority into
skb, all other non-zero fields are prohibited (with EINVAL).
If the user has set ctx_out/ctx_size_out, copy the potentially modified
__sk_buff back to the userspace.

We require all fields of input __sk_buff except the ones we explicitly
support to be set to zero. The expectation is that in the future we might
add support for more fields and we want to fail explicitly if the user
runs the program on the kernel where we don't yet support them.

The API is intentionally vague (i.e. we don't explicitly add __sk_buff
to bpf_attr, but ctx_in) to potentially let other test_run types use
this interface in the future (this can be xdp_md for xdp types for
example).

v2:
  * Addressed comments from Martin Lau

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h |   7 ++
 kernel/bpf/syscall.c     |  10 ++-
 net/bpf/test_run.c       | 135 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 837024512baf..8e96f99cebf8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -396,6 +396,13 @@ union bpf_attr {
 		__aligned_u64	data_out;
 		__u32		repeat;
 		__u32		duration;
+		__u32		ctx_size_in;	/* input: len of ctx_in */
+		__u32		ctx_size_out;	/* input/output: len of ctx_out
+						 *   returns ENOSPC if ctx_out
+						 *   is too small.
+						 */
+		__aligned_u64	ctx_in;
+		__aligned_u64	ctx_out;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1d65e56594db..5bb963e8f9b0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1949,7 +1949,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	return cgroup_bpf_prog_query(attr, uattr);
 }
 
-#define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
+#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
 
 static int bpf_prog_test_run(const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
@@ -1962,6 +1962,14 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
 		return -EINVAL;
 
+	if ((attr->test.ctx_size_in && !attr->test.ctx_in) ||
+	    (!attr->test.ctx_size_in && attr->test.ctx_in))
+		return -EINVAL;
+
+	if ((attr->test.ctx_size_out && !attr->test.ctx_out) ||
+	    (!attr->test.ctx_size_out && attr->test.ctx_out))
+		return -EINVAL;
+
 	prog = bpf_prog_get(attr->test.prog_fd);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fab142b796ef..3c6e3855c886 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -123,12 +123,118 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 	return data;
 }
 
+static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
+{
+	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
+	u32 size = kattr->test.ctx_size_in;
+	void *data;
+
+	if (!size)
+		return NULL;
+
+	if (size > max_size)
+		return ERR_PTR(-E2BIG);
+
+	data = kzalloc(max_size, GFP_USER);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(data, data_in, size)) {
+		kfree(data);
+		return ERR_PTR(-EFAULT);
+	}
+	return data;
+}
+
+static int bpf_ctx_finish(const union bpf_attr *kattr,
+			  union bpf_attr __user *uattr, const void *data,
+			  u32 size)
+{
+	void __user *data_out = u64_to_user_ptr(kattr->test.ctx_out);
+	int err = -EFAULT;
+	u32 copy_size = size;
+
+	if (!kattr->test.ctx_size_out)
+		return 0;
+
+	if (copy_size > kattr->test.ctx_size_out) {
+		copy_size = kattr->test.ctx_size_out;
+		err = -ENOSPC;
+	}
+
+	if (copy_to_user(data_out, data, copy_size))
+		goto out;
+	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
+		goto out;
+	if (err != -ENOSPC)
+		err = 0;
+out:
+	return err;
+}
+
+/**
+ * range_is_zero - test whether buffer is initialized
+ * @buf: buffer to check
+ * @from: check from this position
+ * @to: check up until (excluding) this position
+ *
+ * This function returns true if the there is a non-zero byte
+ * in the buf in the range [from,to).
+ */
+static inline bool range_is_zero(void *buf, size_t from, size_t to)
+{
+	return !memchr_inv((u8 *)buf + from, 0, to - from);
+}
+
+static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
+{
+	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
+
+	if (!__skb)
+		return 0;
+
+	/* make sure the fields we don't use are zeroed */
+	if (!range_is_zero(__skb, 0, offsetof(struct __sk_buff, priority)))
+		return -EINVAL;
+
+	/* priority is allowed */
+
+	if (!range_is_zero(__skb, offsetof(struct __sk_buff, priority) +
+			   FIELD_SIZEOF(struct __sk_buff, priority),
+			   offsetof(struct __sk_buff, cb)))
+		return -EINVAL;
+
+	/* cb is allowed */
+
+	if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
+			   FIELD_SIZEOF(struct __sk_buff, cb),
+			   sizeof(struct __sk_buff)))
+		return -EINVAL;
+
+	skb->priority = __skb->priority;
+	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
+
+	return 0;
+}
+
+static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
+{
+	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
+
+	if (!__skb)
+		return;
+
+	__skb->priority = skb->priority;
+	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
+}
+
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
 	bool is_l2 = false, is_direct_pkt_access = false;
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
+	struct __sk_buff *ctx = NULL;
 	u32 retval, duration;
 	int hh_len = ETH_HLEN;
 	struct sk_buff *skb;
@@ -141,6 +247,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
+	if (IS_ERR(ctx)) {
+		kfree(data);
+		return PTR_ERR(ctx);
+	}
+
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -158,6 +270,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	sk = kzalloc(sizeof(struct sock), GFP_USER);
 	if (!sk) {
 		kfree(data);
+		kfree(ctx);
 		return -ENOMEM;
 	}
 	sock_net_set(sk, current->nsproxy->net_ns);
@@ -166,6 +279,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb = build_skb(data, 0);
 	if (!skb) {
 		kfree(data);
+		kfree(ctx);
 		kfree(sk);
 		return -ENOMEM;
 	}
@@ -180,32 +294,37 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		__skb_push(skb, hh_len);
 	if (is_direct_pkt_access)
 		bpf_compute_data_pointers(skb);
+	ret = convert___skb_to_skb(skb, ctx);
+	if (ret)
+		goto out;
 	ret = bpf_test_run(prog, skb, repeat, &retval, &duration);
-	if (ret) {
-		kfree_skb(skb);
-		kfree(sk);
-		return ret;
-	}
+	if (ret)
+		goto out;
 	if (!is_l2) {
 		if (skb_headroom(skb) < hh_len) {
 			int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
 
 			if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
-				kfree_skb(skb);
-				kfree(sk);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out;
 			}
 		}
 		memset(__skb_push(skb, hh_len), 0, hh_len);
 	}
+	convert_skb_to___skb(skb, ctx);
 
 	size = skb->len;
 	/* bpf program can never convert linear skb to non-linear */
 	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
 		size = skb_headlen(skb);
 	ret = bpf_test_finish(kattr, uattr, skb->data, size, retval, duration);
+	if (!ret)
+		ret = bpf_ctx_finish(kattr, uattr, ctx,
+				     sizeof(struct __sk_buff));
+out:
 	kfree_skb(skb);
 	kfree(sk);
+	kfree(ctx);
 	return ret;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

