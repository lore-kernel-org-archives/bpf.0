Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517B33CEA1
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508881; cv=none; b=cDRHbEb0ka50VZ4S65JwQZ4k8mVWyTKRJsYU/GmYYhq/WfTi1Q/sKQd4U9M3LIfBht/HjFpEhempv+42YKksYN+G31Lfvo8AYgUD96ALSnDeuiUXdQAiwW/44o+NxWw6xmz9M0bAt4oF8vADJSqbXHo11KYEH/doTdnvcM/C1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508881; c=relaxed/simple;
	bh=DF2A1Gd2KkRL+mK3TLCrWFGlaCBn12MkbiyDGInYTRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnrHHIO9vLY4R7Qs9cDnt+4bDCougbIPvVReJjUEpz0DGD7VFgUAULRR0idl5tMFUJVtAuIL/p/GzML2i+7BxioO+lejBDle2QRP8I6ISrfxxoDSrpj5dnBQUjjoUVyl33EhuqCWXCTRMnusvL2g9Xw2hEnoeVaGxScsRxq64U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3e4SKh4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3e4SKh4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3974108f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769508877; x=1770113677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHP/nubeTxOYBfaUQh6UZzNUyhXiKY+VbQsOPOEWQLI=;
        b=j3e4SKh4SoF6Q3vp4bNiIP9gpdh3ADrV2Aoi+NQcNVyE59oDj2K2f17dFNYTAF/K47
         DqTCCsURdyqagH1tAJCv2vv5M4Van9CbqXTTwCHo22WOu/D+vLS6nYTy4pRA3vZDk+DQ
         x6xRtF8qolK0hpZf5w5CGkCqpb+3+cwSUimJeNFKJ+88URgSxFg+iU+IQ3Q+R1qwqDup
         dOFN0weH9iG4tyTYCCM74Ho7zzVQnL94URd/6hrhIx9Tp9oV1D7SWdAoOTVhFVfpdFxL
         YDPTaO7rZReplnsKcbF+XCdnX9F9kCRs+JVjnsMBXSI0CyrnbGD9pq4BrAj+wK0rXJeP
         7faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508877; x=1770113677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHP/nubeTxOYBfaUQh6UZzNUyhXiKY+VbQsOPOEWQLI=;
        b=tyXAA0NTOzaD1lPE2nr2YukE+NQ6vI7Fe0bNm2M3pu9S+lv585WE09+lVCDzjFRdsr
         0cHTArgji90xb+E4uUAJpPoD3bEEy/aM8+8q9wDKTJhMovlk9knfNtNOi2Ym2AAy1xyH
         eyWWYNw4HmDoip034TE19Jso6TtWZCwjyQPcurEU/PPs/h0x7oE1OZCy8GKjwy+TkOuT
         chuUD9VRO/u+zW+HT4En90FTGIiOjJ1IZy77XfVr3Wf4L9yt65lnMUA/w6mbDcZeUwyf
         cnZ+YTY7k6O5wSr0h8bBG3tj9ArY8SkHirXi4KNAsDISfJPUl3PJjYlm48/ClhzwxHKU
         Dk3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDyRixtjpAEoBpLXI+vjWSa3SnrXrJtSl+9hgKFN7aIfHWyoG58oqHmEKjDYH3vsNBxBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7Vr8FnvOiKJVcnonhAxnSPWi+jovYJgLfv7LmsrxB8+ffxj1
	hSfog5hweToxwcu4W3ZkIv9m4rwcYBEXGt0ZIWvFcEnSVagHOqfa3HycfHkJhVYS
X-Gm-Gg: AZuq6aLmMcTvee15FuB8LWfOWhmb1UFwfTix1qXk7Ddnih4T/ig3ydyV5fLKbuHhZnj
	M4/la9I2iaCRuRUPxtiG+6SMs2dTRwtfdzV4+F6DDDfwZabmQNfOBMIhCIaSbRyr94CE4FoXk+1
	dw1Hs4Cxkob6AItcy/KZiH8rjJfjgx1yLEnSq36LpITgS5GVofHoxdyDQkNM4ZcjWW8HyX8gtJJ
	5NOcmfYk0Xl08qDWuus+OhNfSb5FTjnaZcDybkVYGCq97B+iLfP/bVPjgfw3Ll5/D1VDptI+1yU
	u8ice/HD/fK4C04htIM23psLKbQnKbjkvu60qUYu/+E47zO7JfdvFRthvSlA7KQ7YeTJZBbqnDo
	ptZmE0yV0fbTCluhpxyWkrS9wuAynvScrUqxeqqpzrB+9pJdXOv9H6IM9lc0lqfSHo1AFIVtC5g
	rrn2Yf7ieFeOdCMAmm0okvdhTPAynRKotMfDJbbm2J227a/IKJCIbwzl5tEr8/QuvlDKWyvbp7r
	4arOy/LjjOUyIhp+Q==
X-Received: by 2002:a5d:5f56:0:b0:42b:2dfd:5350 with SMTP id ffacd0b85a97d-435dd1d92a1mr1557838f8f.56.1769508877080;
        Tue, 27 Jan 2026 02:14:37 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24acdsm38190407f8f.13.2026.01.27.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:14:36 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH v4 5/6] io_uring/bpf-ops: add bpf struct ops registration
Date: Tue, 27 Jan 2026 10:14:09 +0000
Message-ID: <ba105ce0c281f7f4ad5f06a795a0641fc83b84ac.1769470552.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769470552.git.asml.silence@gmail.com>
References: <cover.1769470552.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement BPF struct ops registration. It's registered from the BPF
path, and can be removed by BPF as well as io_uring, which is why it's
protected by a global lock io_bpf_ctrl_mutex.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h |  5 ++
 io_uring/bpf-ops.c             | 87 +++++++++++++++++++++++++++++++++-
 io_uring/bpf-ops.h             |  8 ++++
 io_uring/io_uring.c            |  1 +
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 9990df98790d..5dfe3608dbb9 100644
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
@@ -462,6 +465,8 @@ struct io_ring_ctx {
 	DECLARE_HASHTABLE(napi_ht, 4);
 #endif
 
+	struct io_uring_bpf_ops		*bpf_ops;
+
 	/*
 	 * Protection for resize vs mmap races - both the mmap and resize
 	 * side will need to grab this lock, to prevent either side from
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index ad4e3dc889ba..26955ff06ecf 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -4,10 +4,12 @@
 
 #include "io_uring.h"
 #include "register.h"
+#include "loop.h"
 #include "memmap.h"
 #include "bpf-ops.h"
 #include "loop.h"
 
+static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_params_type;
 
 __bpf_kfunc_start_defs();
@@ -141,16 +143,99 @@ static int bpf_io_init_member(const struct btf_type *t,
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
+	if (!WARN_ON_ONCE(!ops))
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
+	/* check it first to avoid taking io_bpf_ctrl_mutex */
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
index b9e589ad519a..bf4d5b9bb8c9 100644
--- a/io_uring/bpf-ops.h
+++ b/io_uring/bpf-ops.h
@@ -17,4 +17,12 @@ struct io_uring_bpf_ops {
 	void *priv;
 };
 
+#ifdef CONFIG_IO_URING_BPF
+void io_unregister_bpf_ops(struct io_ring_ctx *ctx);
+#else
+static inline void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
+{
+}
+#endif
+
 #endif /* IOU_BPF_OPS_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 09920e56c9c9..9d6eef7ccf22 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2141,6 +2141,7 @@ static __cold void io_req_caches_free(struct io_ring_ctx *ctx)
 
 static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_unregister_bpf_ops(ctx);
 	io_sq_thread_finish(ctx);
 
 	mutex_lock(&ctx->uring_lock);
-- 
2.52.0

