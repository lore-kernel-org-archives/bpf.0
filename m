Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B7C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92A520657
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DL4/wuYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDDSvg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:51:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36819 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfDDSvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 14:51:36 -0400
Received: by mail-pl1-f202.google.com with SMTP id p11so2332578plr.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2019 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q0c5zLkORmoRFyCWuFY4I34q1R6nUaxEd76JptZ/DQg=;
        b=DL4/wuYpCH+qqH3juahopduVqiuDOkKw94auhpxCF4VTBv4Hkc/XvVlCp7K4ZMtoY4
         QIBE1lwmD+5y5GnSGCjUNashu01ow0EF7xSvbtzhQ9Aw1gpSZeFkdRuVj/qsbr4G14hi
         PUTSOSMMYE0inLxcVhqu1RWHZelcoftFj1K90558eao5gkVD5JaCZ1ViB0Gp/Y1Un9JI
         nDEemEZheQHw5moFXcP43v1rRc9bxbkraRCkZE9R744finpX2UioYzOdaD0b5q9CjTMi
         hzO37QAI7QYs/34S1Mq6Cv3lxODavS0Tbcb88Ny+YQYZZciLqPR2mxuW5IG3hu3SZITX
         fWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q0c5zLkORmoRFyCWuFY4I34q1R6nUaxEd76JptZ/DQg=;
        b=lFaHtbEzITTaXz95aR4GdF2/0XfAlxQWI+64sDquUjUAWRa23UX97PrlMeO47XvqQC
         c5sPKNr0DH3VwKHtv5I38KPqb5LSM5EJ90xobCYqW7jjKc6rX5OPru8z9kEvlTllvPZl
         aWX7Z7Wuz0APkrlaRE1X3ClyqalTl18f1CRXhhZ0ms0S4CRS0ui6wGBSDYd8Bu+mEwha
         Ird+Wjn4YbUX+m5QPCHXc8rw9hnC8WXz9EP/0d8HrBACZ1GguAZxtcQsaiY/vV2UBQbE
         lFrenpnMC6ipNLzJk/ymBIW0Wje9nGVQxGEi8Pd8cEbzoTMPMoy+JUPrkqOq4bR4xF+C
         W32A==
X-Gm-Message-State: APjAAAWb85O+frgOOgEkRFWE/9v9Ho69F6hIMKxWkpg+EPJLhO2HIKUw
        O7fG7Fk4yjEdosohEXUZeLvTYHs=
X-Google-Smtp-Source: APXvYqyFhbl6M3x3zR/Kb07H43p9+YaUhLlobrSe6ayk2u9J1vL34l+lwaSGv9mZbKc1ZbSjG65i2RA=
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr232992pgj.3.1554403895325;
 Thu, 04 Apr 2019 11:51:35 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:51:31 -0700
Message-Id: <20190404185133.95071-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 1/3] bpf: support input __sk_buff context in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
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

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h |   7 +++
 kernel/bpf/syscall.c     |   2 +-
 net/bpf/test_run.c       | 133 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 136 insertions(+), 6 deletions(-)

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
index 1d65e56594db..4ad754e2943a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1949,7 +1949,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	return cgroup_bpf_prog_query(attr, uattr);
 }
 
-#define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
+#define BPF_PROG_TEST_RUN_LAST_FIELD test.ctx_out
 
 static int bpf_prog_test_run(const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fab142b796ef..593912a66d64 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -123,12 +123,121 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 	return data;
 }
 
+static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
+{
+	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
+	u32 size = kattr->test.ctx_size_in;
+	void *data;
+
+	if ((kattr->test.ctx_size_in && !kattr->test.ctx_in) ||
+	    (!kattr->test.ctx_size_in && kattr->test.ctx_in))
+		return ERR_PTR(-EINVAL);
+
+	if ((kattr->test.ctx_size_out && !kattr->test.ctx_out) ||
+	    (!kattr->test.ctx_size_out && kattr->test.ctx_out))
+		return ERR_PTR(-EINVAL);
+
+	if (!size)
+		return NULL;
+
+	if (size > max_size)
+		return ERR_PTR(-EINVAL);
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
+	u32 copy_size = size;
+
+	if (!kattr->test.ctx_size_out)
+		return 0;
+
+	if (copy_size > kattr->test.ctx_size_out)
+		return -ENOSPC;
+
+	if (data_out && copy_to_user(data_out, data, copy_size))
+		return -EFAULT;
+	if (copy_to_user(&uattr->test.ctx_size_out, &size, sizeof(size)))
+		return -EFAULT;
+
+	return 0;
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
@@ -141,6 +250,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
@@ -158,6 +273,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	sk = kzalloc(sizeof(struct sock), GFP_USER);
 	if (!sk) {
 		kfree(data);
+		kfree(ctx);
 		return -ENOMEM;
 	}
 	sock_net_set(sk, current->nsproxy->net_ns);
@@ -166,6 +282,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb = build_skb(data, 0);
 	if (!skb) {
 		kfree(data);
+		kfree(ctx);
 		kfree(sk);
 		return -ENOMEM;
 	}
@@ -180,12 +297,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
@@ -198,14 +315,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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

