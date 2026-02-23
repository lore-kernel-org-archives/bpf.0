Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F12773F0
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855849; cv=none; b=hXBskB3PSEEywNhK4SQZlVmDKvliChi0vSahkaolrOEoucBpD/LXPWEfycPykJYDontPPZOBLCjN8joO/kp0EenjTGc1hAKGBvPqXomnizDNecX+Kr00tXypmxkjQXsav3Y5ngPsxZP0KmytRNo5ttp3U+pE7D39uYiTfVUSujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855849; c=relaxed/simple;
	bh=sAmpA/t65W41B0yOtP1AfdLRml3XOiZTMLNfCBu9Qh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/sDa3BKk1y7LH4E85PffVdGFavKktIZmmVSqZd5BTWI99iMuEtj9APTpx57m6kn3iS6thmbQ7+sWWGC3B9P+KTvnkkj7d24vFZRtB+RQov06CfY7hrP7gYaRGBeJwZM/FjRMlI9CJxh7SI5SYEZtDjREUFRDDkYL3IQJOD3zIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZImoh4UA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZImoh4UA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4362507f396so4220619f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855846; x=1772460646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVZ7NiAv763L4Pu2O9i5WPJsIVLKf0ckp/pKmOLKCtc=;
        b=ZImoh4UA5kIT/83oCOu/JP4M7CQ+p95h7qMhcZM5zUmjsFbc1feVXUAZjPzej80VUe
         JL4NvIJwuCD0wjr7ozXJsMQLBuE4IV+Mvj51RV9HYpnJhtsnwjfIwvyLf0Pf7mlFE6Qk
         ETRi+N1rh72szpWOYsqMb3AZfZ+KJ8L3em/2sD7RRU2HaU0pGb7JxDEsWFj2PiUwc7n+
         pdta91h721CWsyEYgeU93eg0kDN/dOg7kpyqf49jzMAAbAHNrIlxsmVH+ZNoPNhgJ5wD
         mZD71+JjKl73LomBBkt9rAb2x5pP6O+JA8sqjkK3xXOKUeEMW4uXDVOniigt4kh/z2AL
         6g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855846; x=1772460646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVZ7NiAv763L4Pu2O9i5WPJsIVLKf0ckp/pKmOLKCtc=;
        b=Ng1tExPgvBxRdOegrgXNRu6iSHXYSHJayPvw4/hVmy6EeweDxDhchCk7NlLdBrlYFr
         Udd0yTLzqrCmKCZhX4jyr2C17a/jqlXaXOMwF8qi5ObRSC5kQauUuORhypQvwB5psdoE
         w2d/INSTWuA/4Q9nLwAoIJzD1X1I+Fc92Rei8IYeQzDYzZu/cr6ltWh/xHD6rtQ/biKP
         51Igg6Y2kuq7h1wRgjpXcLwc1964dtgiJDHL+ny7urveI30aTNVIN23i5INyyhr4XiiC
         rc1YQL9/flZtkGjrOiN0oNikPcnj9a2UmbynM4mxNvSZw+18QY/mJrYFaq1Icl6bcJvA
         FaFA==
X-Forwarded-Encrypted: i=1; AJvYcCWZoYoAwIP8Fgm7wg4YRwGPZe2kSDS7drW9eQel6ilzw6Admy6MJ4hfjZfCEoCDKWLN7AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrO94PDo4oGqt5lY9t4OYTs0ljgvf4SAPHWR7B00Xr3y/5jiZ
	wVlwYW2Mi0LkwfBKVn8gvvfCXZMNXRlp29SaJ6TjLfCZ3Ln5yb3MruxxZqMcHg==
X-Gm-Gg: ATEYQzx/xR7mJ56Tz8OErj4WnkhOIbkNoB7Y1p6OI2N3Hs0Nsv+TUQwMm9n8LhqeONc
	M4dgx2xqQPNJoo+dKuhyxO3WQD5v2jN/w28QAwa3CdMYNvpuRd+D7ihbq0HGudQj9IrgCYOeYG6
	zT+MmvCpYS18rFKwht/yvCQGut/1NcmMD17Qn5t9p3iTh+aI9IL7gp7k7/veNal0ZBvBHgQ8X6j
	coftM1hfWDrMCANWkP0N94WxYk+6huUfaJK2f4xPlJCtcJcVYcfl4/eIGzJXP2TlelOsaHJu1dI
	2cyhw0bI9BlzZxPvtFAWAOFWOtdfxpCJcg/sV8DiKhwUxB6DqdS3CRaY4NiyuNVLmLy8VP1JPME
	0OS/6ovscLi3hJ4UJkYl5LulNufou+2UQA1eWAD8fhJKgzjrY7NRN63mBKncWxNwNuEwOTCltAz
	uBMTeVexJi3qIXvyX/kNTi+tMHd94/zpnhcPRMo7MuFA8Ig3g9HNdANssySB2dHM1mtMytluWe8
	21leGLSxw==
X-Received: by 2002:a05:6000:2283:b0:437:81b0:6650 with SMTP id ffacd0b85a97d-4396f189ffbmr17327631f8f.56.1771855845857;
        Mon, 23 Feb 2026 06:10:45 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:44 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 04/10] io_uring/bpf-ops: implement bpf ops registration
Date: Mon, 23 Feb 2026 14:10:15 +0000
Message-ID: <2aafe124e44c0acf5d3b412abe74101ca2c0aa29.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
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
index 17518f4ecca9..1ffe7ba73b89 100644
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
@@ -143,16 +145,103 @@ static int bpf_io_init_member(const struct btf_type *t,
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

