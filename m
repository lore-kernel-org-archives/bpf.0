Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED1352C5A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836703; cv=none; b=Bn4Wg+95bDR86s6SmeveDPN7KXog9BmT/eavVdPz1+Z96DVxWhPMP6IQsXsiuTbvI0cKN/7zYBztN+zGcT4ooDLlBLeHLDYZO+6JxDjxNxmjr+23PAp6qpDsaNnXrqjPjuhOYs6ENr4dfifwPKNruMG/L0lhnCdODP/Z6f3ifXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836703; c=relaxed/simple;
	bh=7Ea2Lwd3D/aWWccRY9jd8zhEr1CAo6TWASj6etcM0bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNXqSF6bcYVviH+d2pC4d/xNLcpR2v09XRAZos1d6GXIhqk8QjOMB0R67puMnNXPrft4eWMQNMP970+S7nAF4T2KHU+50UtoI9390MlgJ5Zq6zJeHdDxZHM2yBWU6vW/cZjYzifP5mp8F4BtRF9wuvn4FJL4lrvm3oSuaVaTYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGaUHGSG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGaUHGSG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4362d4050c1so5599995f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836701; x=1771441501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkMs8zWNzvEHNrqGln0bLO7HxamHTt1GSXLtt0yH6jA=;
        b=bGaUHGSGgkEV2LqhODO2tfFKD8iQdKAQF1x3T0jhwUCXQDLDrsQS7M8BZIP/eJCy7I
         j3w9nRXkvvlptcXBNmNPp01VTwfR7zFvj+sle0lHiZ/yWda1tt3NKU80PK45bcvRK0f7
         a+Kl5ekpyIiwdc5jLY/MMw9+cS3otf2ew9ea2g2V27xrDN7+qOE2soaOfw7EIdczSHdo
         KL7t2m5uJ4+0vBrImYrj6cqADXZnNxYUflGeswWUqjwwjlhob85DydDALw5TiHavHi48
         W501nXvYnca0idNAKmH7pqnc6cJr4fp+0HCtNYe1qtSv1833Imja01JE16A+WZUSOZIN
         /tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836701; x=1771441501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkMs8zWNzvEHNrqGln0bLO7HxamHTt1GSXLtt0yH6jA=;
        b=MxI3oGlt2ZP9N0456nV2NRV1Uh/k8vmcAi8mF61rXx7BvRFsoS+DfesjWHmI8v9kIP
         tSOPm0w5CypeBiFfxh3C0TiNB4Am3HtPwqc+HozHhjmHcBGPmKK/8C/VIGRqUHTLqEAm
         B5x+luQc32fYJEv6NWKZGZd8hGvQsi/utg2uhgP7SXhFP9ZflELiDc/fBXdmyN5SLKay
         r5Ua7Z3W5Je5z2bxYwk8GuM08KJFayAX/lKK79CCaY1wR9ssHFpVP4yW1MjwW+zwcpLA
         djH4dBU1DC6y3hCkGK+yWnlOINVsNpnBdJKg/3kvAoMAbMC8vM+R726vvFXB+DAfdTE1
         N+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVovtAM2kzbL96zLr+ndpCSXIroTlnkFKOJWQNZ/O5fkNEqnhsw/ehcQI4fYyhIccjY8Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbs/q6bQ1y5p1WoudDKe2Ef00VoqPeLeGJimxdwB0LboQT7yv
	U5P62Q7iTsNr9NzHjW43c0w9k06r70wxbFe+nML/JQaLotvHlrnzeHGM
X-Gm-Gg: AZuq6aK45W6DpGvEKjzYIFywzutuFyQaj+KNMmfLFRrj0rkdxEFG3uUzlFRpQIJuP8e
	aviPauJboGtcIfNhrlKbWfo4OHOpL+bREvsVvoNCui0thA8is9dSQs8yQhlWEAUXy9Cap452Sxw
	9p7KMbrL+1KgEVI0Y7KBJf2Cz7AjipqTmL0gj4gKYrH/swQgGiAy/+CYwzuSGG6iAG3iopp+40p
	mWkGBYQJGil3E5JGGXz3SbqNxNJP903KDJ0f1BWG+idRT2D40qjktRyP5DQCLkYHgq5cpYbKr4T
	mqBVvfGwsgjSqyTy09XNX1cbD4WgFxzJbCqU/JcsaiECPUGEan90tLaTau2GLr+gTffL2YfpJvE
	812vP+01JiayKcti2dPZ85nz61WJRqhrh0BX/xz5whQWTbpoxThJexfCkSBVyHrzifJS6MX/Mh9
	JDgsefS6OF7hNu9nCppIW06Oo1Ybopk6h3MeDRv5dB3lXYqSmMwr56ySFg08BaCljotcGyAUfde
	dLjEKfdsvu9EAls0PL10ojNIzPb0A==
X-Received: by 2002:a05:6000:310f:b0:435:a0ca:bdce with SMTP id ffacd0b85a97d-4378adcb0d3mr675978f8f.63.1770836700576;
        Wed, 11 Feb 2026 11:05:00 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm6174169f8f.24.2026.02.11.11.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:04:59 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 4/5] io_uring/bpf-ops: implement bpf ops registration
Date: Wed, 11 Feb 2026 19:04:55 +0000
Message-ID: <8e96f33aace0b74a89cbf1c65908ffe1256fbac8.1770836401.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770836401.git.asml.silence@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
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
index 1f7c03728083..259412b6b072 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2149,6 +2149,7 @@ static __cold void io_req_caches_free(struct io_ring_ctx *ctx)
 
 static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_unregister_bpf_ops(ctx);
 	io_sq_thread_finish(ctx);
 
 	mutex_lock(&ctx->uring_lock);
-- 
2.52.0

