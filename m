Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF909334C27
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328039; cv=none; b=PP5xp+6qb8Jo1cxZGoe5wQsud219p04AIZeDTepH1wzjyFkENM/FfZzuzMnUmsRkq05VAJHgqxf+29bxTgYqPNE2LozM4j0B4Aybslbo9D6Jz/fDOji7H0RW6Jy/JQswU98oOM1lq1dVYGtA8AIvry8pH98E+dhj8T4wOTS/eO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328039; c=relaxed/simple;
	bh=FXnktX6iI9F9MCvVYyjxyRN0DuKuhlPhArCuw2Hg4KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxTV/CLkYUDOHToHxrfoJqxQ6P8PeRsHsdRNZ41OUQFeHykhM/0ghDSdTUBCKnJjerzmS1iWZ/o891GjLbg+lKd3a4U85maLHWFVaUvnWiyH1TC/f+tYpvRAPGx7wL+qHoK6w/QYPW9XQlzChSo3TkCHSMynmlZomrmcLyilYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bML03YVU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bML03YVU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359249bbacso4080067f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328036; x=1771932836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rFGI29TUm/XHZMUUq+bMECbjvA2fMBfcIenQ+N9bZU=;
        b=bML03YVU5QNeNJbh+Xi5q2MuX/vTNvChTgv+FBR+r+GJNtNs/nKLtFhtJU2Q4msJvQ
         CjXrJzf9/LdDFG935yN46qHEOKLr8MSKnUMQoZW883uTI80uyWMRSgKkBTZqnqEmUxNw
         PhvB/p8+b6NOweE9kQdpyq46Ip/TmFcX7jDXl5X1NxYPy60H3j/nYkvBImGM3op/1RAX
         ePb6F1wKP+KmgoRucxl1V2dEOHvqYt92OfJWA3gQ0/Lo2pZ1vK4UMG6qYRd2FG0EdOI2
         tWh3AJRQsgtfLv7mhcpR6w9pfGiWjHiZ6D0VlEq4O+6OBAF27EPipAOXQY5LdbZ++4hN
         iBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328036; x=1771932836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rFGI29TUm/XHZMUUq+bMECbjvA2fMBfcIenQ+N9bZU=;
        b=aI12UTXleCa1/ybYLtO8/8gVX/25SLi4oqHImQ9lENd/B1D0ItD5lp6Vkvntx44SoE
         AM2BJcHl8gnsKPTmIQuLx1GEuPbNBWGuzIskVIL+xTZ8I9gVYdZMVRJ2xz94tdyL4sOO
         5TWPRXi86vz9fHsOHIRXMSwC9Snux4yoQP5VW4iG44OQcEK51Q/U+b4NFVippJvnv8zu
         LBZxMISOlHrsII/M2zUi8rTNBxqn8VFuAkaVXh2uIL0iRsNVGVAnmVcZMAPa4ZeXnzhN
         43hgWXGemBYXz+jpXiaamB0jSuw8udBo85/G6h3eZViVRWqmmdjFD85r300Ung0Kj2uC
         8wIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHGDfLzFEEgxjj+FOLgou/LLrwt5xjwNq+G0dO/zI6Ec6fE1t1m+tT2IN5PyhoFIYr6d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTX+V+VyuI9qIwPSlRKjfw0lxs6ePqpqKdIsM7k3cAbohKGFV
	/bRT54XLrX2uuJDLJj3WVrm9nOqtOYbGd4RWyoSojiezRarC/k25HZoYr8Bfig==
X-Gm-Gg: AZuq6aL9dXBP0ECvKMgtcZc0YRsed+NmwrdHedO3mqB7s/WyLg1wFtEzGiz2q9XuDpj
	ZYFY54G8BoB2XHEs+W/G3PVyHw4D6GV+bo+fnLvJ9ZuhZ3Iv5XFBgKms6ji52rzixkYgu8Ceq7z
	QXOAAIjpQieVzbwVsRddvlKwrvNVbs354UE8oYWZ1TUTdePfVav7mj3zOubgzlyyZu9b/hHMgXE
	PXYLNegx5IRE/56CWp6v1nmWiGK13yalZ0ymuleY3gvpAibsLB+jb63G969XXSfCC7vL30EDScG
	HSFdNaEraE1j04JB7AtVzPIdM8dyo4uOedG99DYYpyLmfXwTmQSU3HGssc6QrOZhgI018+GWt+n
	Qf3929B8fPsAIixqLdDi++NEhYxkoX1dKl4jdnaMkwH9EZlG2Ac9/j8j6jUkG0Zc+HexM/pnUFH
	0qKoSTPWREp0cGYL/dFKjXRb4w39FjnrooE/bBA/1PF5btxYjU871hLge+mJfmu/MQlvo0D8dzY
	mLH5yWtOdkL4PMcntH0JIfj1ryKHg==
X-Received: by 2002:a05:6000:40da:b0:436:339a:9a9f with SMTP id ffacd0b85a97d-4379d5e3fadmr22571463f8f.10.1771328036138;
        Tue, 17 Feb 2026 03:33:56 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm36258343f8f.27.2026.02.17.03.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:33:55 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v8 4/5] io_uring/bpf-ops: implement bpf ops registration
Date: Tue, 17 Feb 2026 11:33:46 +0000
Message-ID: <2aafe124e44c0acf5d3b412abe74101ca2c0aa29.1771327059.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771327059.git.asml.silence@gmail.com>
References: <cover.1771327059.git.asml.silence@gmail.com>
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
2.52.0

