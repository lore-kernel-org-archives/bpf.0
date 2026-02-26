Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7912D8393
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110134; cv=none; b=XiSJ6B3dL0Ywnh2jwfiJBlTN+Us6aVhwkLTxTXxY+yc7lD0ZZfUQKj61dwrWRXBDIrrcpTeu66RYhhAM0kE7q7V6Y5SyEu++jzcwt/gaqmnC8RORZthtCtxGidSQmK1d904Y9vneJ5zcQ1Ku5Gob/Z2Bq87yWkrTN4y0VyRdg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110134; c=relaxed/simple;
	bh=cE2dDHs6RKQc47MczEEt/fgaBkR+JvJoy3UpL32ZwQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8is7DbaUMYTFAFwXltnsYtlP0fCpGDImjRUZ+ZQvyyGznBTovEKtwXueRrNwSgX2dojH8el7WuCHIqQ6siFBUm89XxtnQ+uUgdSPj56Ihb6NLLg3j1bZdA2xmnmav3QbrLaAIQrWHS+wUuURfzBFRpV9VjrWTQmMc/RqwfROaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bix3hwSt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bix3hwSt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483a2338616so5509875e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110131; x=1772714931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtxpGMpLhs0MsBTHyKZ/F4kyrnSIwfSyIpyKCH7U5YU=;
        b=bix3hwStz8ZIIt7hRZRRIVey2WK6RAY2yIBXJB5FmdIK8bchBn5HUNsMr0/wVCLMG3
         5x8MTqzLPt8w1Oq7DYaICgAXnudIgyKy2mn7BcZyyQYzdl0HhZM2D+kBeGhOCbLBCFTt
         9nhtnYfUuFS5+AGi6QfIz9+kdqFzpCtO/sSgbCyB1+dxFLLjjbUnH00eENAUzY2x1MzT
         KzIygC/ytS6wiCRcHn6zgrcU/WjKlPS/aX/3VfBVs7GVVufS+m55hA3YJ+1XqFpOMEB+
         2vfFjGxigeqWvYkPvy6j1SRmPkTOsJ5TPKk+fkPrdPtXK0grN88b5cOGMwJ4j+OJ9X4f
         5xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110131; x=1772714931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtxpGMpLhs0MsBTHyKZ/F4kyrnSIwfSyIpyKCH7U5YU=;
        b=XWqyNO5T3ND3AyzHuo5ILZog0wuNCf8cv2HqPGP36qnRiKX116OrvCfqH4okKOYeFh
         kc0IuF8YNFPBXUOY1Qa9tfqIfpSmgbOHwlxG62IARmgUk3gzml3H/aM1lpK3oKpf6nAK
         nljbTaQEUICReOqLHglHfnRs8/1VOKO9/U4/tKCmiCMJAqmIk4VjroW20VjvbSUxWqYs
         wezW5ceHLRxcCLqK3wqw92OAZx/O1QOPRaDI1lryeRB7kbYOiYTLwifMCcokzlZNGRmS
         CZEAZcoN8l0fS8a8hvXyxnLCuJHMSedfL4O4La8e1at0tKh9p5lKMzcAiXj8ZY0rlEEw
         wXug==
X-Forwarded-Encrypted: i=1; AJvYcCWRJlHYP3z6OrbDUcAjhshln+6TgW/hnwJZ1S9XIHg9lAIf2O72zre1eu9PRjKYYr4oXC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws21D5Tw3wOiapQCesMfTbJZkkgF9i0W2uxjZTykoEP+EDWCNn
	wms1sxEW7Q5GJ5oo3ZcB698rvfFgDIGBkrGBdYzjGONKtkDruja/k/575iVNuA==
X-Gm-Gg: ATEYQzxkfNYG1r5jj1p0H3fMmxb9VugshM7p9H7jvyRbzRYm+xffnOZ8cMo4DMIZCl3
	Ym+a0T5Iu4i1siE9ROojIyPzx2f0nDdLVvOZMg6mtv6e1ysG7E4bGerdeAV33loWRtE37Nstdld
	kbvCI1cT/olXIdbqkB9altTjdefMnvIFYF0qeDYu+iORjSMkWSJ5th57GNPEsH+SbGkh6MzDa1N
	FMc9YoWyFwWEOm2AC0YJluJDoOXsxYcNbSKOE8+XCk/AyzldL6aFw89Rjqkpm4GYu7wReiEbg03
	gPIo93JXk+H4etFTvZcmHIug1Wn7JbESMvJJqEQxumK0znmluUfELoKgnuqkH8u51E54n9BngYL
	xRg21sq3FU2Hwch0fHGn94huRePGhOXx/X+Va8ZZYx8a6UvFeaNBGxNtGNpAfeYRiJop1bPYkyO
	teC6+zf5qZ4yseRWH+l22ANQVYP/7COkYu1eHc9LdXJSi6O20Z+pqg0QRmrJwWyIr4ukjG9G/KI
	uzZtO/fF8Ox9g==
X-Received: by 2002:a05:600c:6296:b0:483:a361:41a5 with SMTP id 5b1f17b1804b1-483c3df4633mr35734445e9.30.1772110130806;
        Thu, 26 Feb 2026 04:48:50 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:2ab0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm43734576f8f.32.2026.02.26.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:48:50 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v10 4/4] io_uring/bpf-ops: implement bpf ops registration
Date: Thu, 26 Feb 2026 12:48:41 +0000
Message-ID: <1f46bffd76008de49cbafa2ad77d348810a4f69e.1772109579.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772109579.git.asml.silence@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
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
 io_uring/bpf-ops.c             | 92 +++++++++++++++++++++++++++++++++-
 io_uring/bpf-ops.h             |  8 +++
 io_uring/io_uring.c            |  1 +
 4 files changed, 104 insertions(+), 2 deletions(-)

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
index 17518f4ecca9..e4b244337aa9 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -5,10 +5,11 @@
 
 #include "io_uring.h"
 #include "register.h"
+#include "loop.h"
 #include "memmap.h"
 #include "bpf-ops.h"
-#include "loop.h"
 
+static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_params_type;
 
 __bpf_kfunc_start_defs();
@@ -143,16 +144,103 @@ static int bpf_io_init_member(const struct btf_type *t,
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
2.53.0

