Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937226F2A0
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260715; cv=none; b=BNsfWZZ0ybXN68n6lCTKGVH334DktSn8LouA247Rb9TqnGRx6DrqIyOxjYIl0PlT7SrWtxho8HIUrJLIQPNtEJI/o0v7oocTqz3Asm1AxYsP6x+s8SIKxtaEOZMOUr7q5mqV/ENZ13UeQl5PRGnZZkZhU/y4sR2QjTWE+Y70o9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260715; c=relaxed/simple;
	bh=3tiUDuHBxLzeML7xpJBjUm48woPX+RnX5daOYNFabeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sxkt1HKWZlj1PJTwchCMVukoFBXwJYghVBwKJV82HFaFSRSM51MTXQfy6GvFZhANuSimcpdYupgP0YIoYdmaGAHzr4zuezBkn7RcA/G/3tTIkc2rl/XiowpAW9iiBd9TOHsynq6Ed6RUxDfOmhG270kP3rYiaP7DptkUEv06IQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BETRRurr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BETRRurr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so28336995e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771260711; x=1771865511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvzBn+mDyuRtR03E8BLahAxwAeeDwyyxlBfKV0yK9iA=;
        b=BETRRurrxGnFxSSzeWyZrhiRVRB47endaH/egXav33ZbzxShagkTA6yPzpA+nhP1sL
         tuNY/Sapv+Jk8uuit2JpinN4bhLlGXTHuaWDzAXWflMh/G9+k9Yhy3Rdpk77S6G+uOFA
         hqCIOTM22j35L3iZXd0IMh6ZqoNLLhUCjnKIagC2o2iErEdCtWfUvm5miN/S5ZDY7Y2f
         5sE3K/tzmOi/hIIEFDro1SNxrZeqDz4t5y50F2ZTLuK+c16mS0+k2eDGbzM+fErF1HNi
         TuOdMyvxXy7jjo9VJp3j2Ae9wqPbydi3zY2Iuu/q5Ny5VaSgHU2AgxkQcO4vQ0G1ALMr
         i3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771260711; x=1771865511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvzBn+mDyuRtR03E8BLahAxwAeeDwyyxlBfKV0yK9iA=;
        b=BL72MWeNhPrlwRIabjGGu0YEjciP6LGq+oGiA4TNG2jSkPmJSGWf8jHrT51KUN9jv0
         c9KpJNrVk9ot7TLcOuyO4iMS23oz8QlOQNS/5l9CAsO6P4WHR5fbzvUGFJHj1b8MDQJX
         ewt3H1I7sweGxiWrrBda7a9BI7xNXYfe/RcAxvWW6qm1Qp2C8+Ztc2fLza7+iscO1yFV
         5Im108A4JsMAyyxQcoGw9t2VwuGrgqYcrWz0acuQPXbRDOG94NltKBMZfKfTzjrNr+tY
         EEdmOI997U/+xkCCg+ze4xJRopVpg24TH390mQQMa+wuE59VPsmThwVIhaUPr1gxYE29
         ptkw==
X-Forwarded-Encrypted: i=1; AJvYcCX1wKvmqAP1t2f0pr4+7BeVOa3Ed3bc/yTSrWzPtB3BaFJxgm6H9bVfP45dJD2Gz3eHOmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcq9U+mG4f1zjqC4sjRLj+6PsqgO9B5BHW9GxngV6mRiM0pY9p
	B6oPxvzyWOvhDEfXkHKXmbdMU4UvVFuBPFIE0ph3ARjNG1eXNHt/d/Zc
X-Gm-Gg: AZuq6aI4SLUvWyO/hHHU5ii3bTtuox3WlfIOn/XNl8LCI7k8/DkNaUgjSGWKwxP9xmC
	XZHbpBm/DDpIQDmbvr+ZT753i36BdP1YL/TjPh/24C17/r3xucgD1rA2MFO/Lwp3EyhDPaHgjh9
	+voPF0QqATYCY85HFZmdYNYMeeeCjI0ihPalSadKc83Fk3JcV8olVCk2eZ0hsS5zX/Ba8ZCauwL
	JS5jm8aQl3Yrqt0zmmy+j9CpWleFgryul8B+i1efeFigCSxL9HvgN3D6SiVaqZTo7f8LR7GGNUf
	f0CMKJBxyEM2/WJIY13FSpDhXu2wDFIF/LbJxJNl2miDvO9+lW306QlzHSgo8sGBzGzG6SssEij
	P1TKWh3kny0X/nlIahg5GK4kdn/tqI2a2UO/aI7CIDP/Cz6VRvHZA+A5WZTWikDd2mQZkbcBkg8
	pF5bupraagnKgUsGsaj/+zgDNrU3jcN3A9sEeMncfulhsFk/Jmn+LVm1+5lOo/wg698cbr1Qzhj
	AfxO+zd
X-Received: by 2002:a05:600c:3552:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-48373a636d6mr186050665e9.35.1771260710974;
        Mon, 16 Feb 2026 08:51:50 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b64b08bsm76454255e9.6.2026.02.16.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:51:50 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 4/5] io_uring/bpf-ops: implement bpf ops registration
Date: Mon, 16 Feb 2026 16:51:25 +0000
Message-ID: <9d2aab4d43ec6f96fd64c30f9db5e21c17b145cc.1771260487.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771260487.git.asml.silence@gmail.com>
References: <cover.1771260487.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement BPF struct ops registration. It's registered off the BPF
path, and can be removed by BPF as well as io_uring. To protect it,
introduce a global lock synchronising registration. ctx->uring_lock can
be nested under it. ctx->bpf_ops is write protected by both locks and
so it's safe to read it under either of them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h |  5 ++
 io_uring/bpf-ops.c             | 91 +++++++++++++++++++++++++++++++++-
 io_uring/bpf-ops.h             |  8 +++
 io_uring/io_uring.c            |  1 +
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index cceac329fcfd..976d85f82f86 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -8,6 +8,9 @@
 #include <linux/llist.h>
 #include <uapi/linux/io_uring.h>
 
+struct iou_loop_params;
+struct io_uring_bpf_ops;
+
 enum {
 	/*
 	 * A hint to not wake right away but delay until there are enough of
@@ -481,6 +484,8 @@ struct io_ring_ctx {
 	DECLARE_HASHTABLE(napi_ht, 4);
 #endif
 
+	struct io_uring_bpf_ops		*bpf_ops;
+
 	/*
 	 * Protection for resize vs mmap races - both the mmap and resize
 	 * side will need to grab this lock, to prevent either side from
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 1cc4fc647add..6f7f47bb66ac 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -5,10 +5,12 @@
 
 #include "io_uring.h"
 #include "register.h"
+#include "loop.h"
 #include "memmap.h"
 #include "bpf-ops.h"
 #include "loop.h"
 
+static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_params_type;
 
 __bpf_kfunc_start_defs();
@@ -144,16 +146,103 @@ static int bpf_io_init_member(const struct btf_type *t,
 			       const struct btf_member *member,
 			       void *kdata, const void *udata)
 {
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	const struct io_uring_bpf_ops *uops = udata;
+	struct io_uring_bpf_ops *ops = kdata;
+
+	switch (moff) {
+	case offsetof(struct io_uring_bpf_ops, ring_fd):
+		ops->ring_fd = uops->ring_fd;
+		return 1;
+	}
+	return 0;
+}
+
+static int io_install_bpf(struct io_ring_ctx *ctx, struct io_uring_bpf_ops *ops)
+{
+	if (ctx->flags & (IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL))
+		return -EOPNOTSUPP;
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
+		return -EOPNOTSUPP;
+
+	if (ctx->bpf_ops)
+		return -EBUSY;
+	if (WARN_ON_ONCE(!ops->loop_step))
+		return -EINVAL;
+
+	ops->priv = ctx;
+	ctx->bpf_ops = ops;
+	ctx->loop_step = ops->loop_step;
 	return 0;
 }
 
 static int bpf_io_reg(void *kdata, struct bpf_link *link)
 {
-	return -EOPNOTSUPP;
+	struct io_uring_bpf_ops *ops = kdata;
+	struct io_ring_ctx *ctx;
+	struct file *file;
+	int ret = -EBUSY;
+
+	file = io_uring_register_get_file(ops->ring_fd, false);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	ctx = file->private_data;
+
+	scoped_guard(mutex, &io_bpf_ctrl_mutex) {
+		guard(mutex)(&ctx->uring_lock);
+		ret = io_install_bpf(ctx, ops);
+	}
+
+	fput(file);
+	return ret;
+}
+
+static void io_eject_bpf(struct io_ring_ctx *ctx)
+{
+	struct io_uring_bpf_ops *ops = ctx->bpf_ops;
+
+	if (WARN_ON_ONCE(!ops))
+		return;
+	if (WARN_ON_ONCE(ops->priv != ctx))
+		return;
+
+	ops->priv = NULL;
+	ctx->bpf_ops = NULL;
+	ctx->loop_step = NULL;
 }
 
 static void bpf_io_unreg(void *kdata, struct bpf_link *link)
 {
+	struct io_uring_bpf_ops *ops = kdata;
+	struct io_ring_ctx *ctx;
+
+	guard(mutex)(&io_bpf_ctrl_mutex);
+	ctx = ops->priv;
+	if (ctx) {
+		guard(mutex)(&ctx->uring_lock);
+		if (WARN_ON_ONCE(ctx->bpf_ops != ops))
+			return;
+
+		io_eject_bpf(ctx);
+	}
+}
+
+void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
+{
+	/*
+	 * ->bpf_ops is write protected by io_bpf_ctrl_mutex and uring_lock,
+	 * and read protected by either. Try to avoid taking the global lock
+	 * for rings that never had any bpf installed.
+	 */
+	scoped_guard(mutex, &ctx->uring_lock) {
+		if (!ctx->bpf_ops)
+			return;
+	}
+
+	guard(mutex)(&io_bpf_ctrl_mutex);
+	guard(mutex)(&ctx->uring_lock);
+	if (ctx->bpf_ops)
+		io_eject_bpf(ctx);
 }
 
 static struct bpf_struct_ops bpf_ring_ops = {
diff --git a/io_uring/bpf-ops.h b/io_uring/bpf-ops.h
index b9e589ad519a..b39b3fd3acda 100644
--- a/io_uring/bpf-ops.h
+++ b/io_uring/bpf-ops.h
@@ -17,4 +17,12 @@ struct io_uring_bpf_ops {
 	void *priv;
 };
 
+#ifdef CONFIG_IO_URING_BPF_OPS
+void io_unregister_bpf_ops(struct io_ring_ctx *ctx);
+#else
+static inline void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
+{
+}
+#endif
+
 #endif /* IOU_BPF_OPS_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 548ea5a080a0..b154dac396d3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2154,6 +2154,7 @@ static __cold void io_req_caches_free(struct io_ring_ctx *ctx)
 
 static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_unregister_bpf_ops(ctx);
 	io_sq_thread_finish(ctx);
 
 	mutex_lock(&ctx->uring_lock);
-- 
2.52.0

