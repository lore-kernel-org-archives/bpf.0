Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EF153598
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820383; cv=none; b=YptH+tltCcxjgK52ASO6AQgeQcYq4YdUnCKjtp5//+3bHEhL+TnU2zAOvjziorhvGcCD4GJA3QCZa6q/aHXm9QBiJklNZH12Wo74WcPXS4gPo4W+KXSidwDYeCmsn/Bh08q/dkEyxZLj22ebUR5ntsVUAkjsQptQH2U0k6FXSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820383; c=relaxed/simple;
	bh=ECC1hcbd25MYx8SEVsUG1MuYC9kGj2yPu4Er56WBfcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te042P29IPfKAZ6GULAgBOITLUHU6Q6eFo/zSW7C5U6jfSDx1NXSsVMUcM9ZWyfvKysaDsANniCc8jYnlREYbXz4tk0kLKpZYafwSKoKUrgtskF7IILKSFP8SfP7by6ISwjI/c9MhuwtQasPGmnPMOYJNqhZ7f7EkRWOh5/KOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBuHa5/p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBuHa5/p"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so101749765e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820380; x=1771425180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ywk9JsMrs7KtbTAoXY0FLrxoKF9DiObbVGBOJ9cJJg=;
        b=kBuHa5/pDfQXbe7LiehdGXwyWFapJBXtKElkyGdvfZVH7eSwjhUmK1JWSiy1RjKd2J
         3OIx/YkNck9x9L2AOU5tjP1xfBbyW3PHmdN9nMlf+uPKZFz+B1zY+PHCSRDPC8YvwGsH
         xhFsmsSrCvhxvrB5gSw4hBMp0T1IfHMUqUOMyJ1eF91YRvqBp8VW6INV+RgxSVvHR9pf
         tULm2eY8hp7cZgQ7o19Hf8wROPNYWy+TuDBbLG7PWv/XaZUbdaMg+stqAYSAytZwehJy
         CUB4YiZvuTUj15Zv1jE5Kh4FioiNe1mv3OXBtu80MzuTcwRUKyA9xQRFT2Pr2DsSYD73
         qGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820380; x=1771425180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Ywk9JsMrs7KtbTAoXY0FLrxoKF9DiObbVGBOJ9cJJg=;
        b=cjtY/O0QsUsM1ZcSdFY/3GshBor584IgsTWln9fdvAMiA1Vw5o5Vq+w9yJiCFBvlGK
         KYP4R8MI4+bMCxIXOH3oA5OlXfpIeQkqX8ncOK8xcqJgE30UH2DD75wC8tc6FIF2a2Hp
         cTVdJb9nwSV5tWxsoI8ZtE3faztS+Ut1dtA+DLdA/+mg/j/Xq+g7uHXRBstawgBtf5k2
         OAQs5MkTkVU9sxm8Kr+PGVL3Q5j0CJ170DT6YNy3pB5//Wal44db0QhhOvg3CrSYTMpu
         2J/hFD3d9V8mKgRVXUQpwt0rtN6jQrO1o29lIS/PErhFbG5KJy1qQ9IU1CJ8pMLrGsbj
         v1bA==
X-Forwarded-Encrypted: i=1; AJvYcCXSRgz0ZznUEKCkb2BW7eNYG+2QZj0pgGGMRIkXlYU9tk5oRFIQhrGqyyuInUU70UBuwM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7d0i+LO5ZLoP5E9g3/Fyn17CeyKc4ZKYJLtnak3hQblM222cZ
	/W1g3Zer0kmA4sZPuy35lB7gq2eTU/i7aH6S/7+7Srzq6Yn46Yn7Xedf
X-Gm-Gg: AZuq6aLso6MEBqGkLaepO+wxVAm/S1/yVsG3fteR2qfLiFD3heNmowkSabK9hvYveDZ
	6pZdpj3Xef2VHzWbQsk+FcDzUbn79z/dh/ZB2QOTx/4jS7iLyp2hgqe0I649XtOELCqahaMzjnF
	KGZT+vV5Qw1yNfXpH8NXy2XPXe2PvzuJdYwc0CVSlqoIoFPuf95yHQe1Qk9dRrZrIOaYWRhyJLZ
	w99NqIltUwu0V2mrXVpVKI2xvCA00PBLHQLqQe1awpu4UgFmjnoDQSO6a/PiOSp6Bjee1m4J87F
	7Ku2devV9OFuQsEU1num0n2grOkK609QMm/QxnvL+IQEz2t/7a08k8ltfKsOm00GjO59mAqamFV
	N5zhfgThMXIkKpUogclqOrR1IU3oQrFc5RakFWiO694vHyYNy5krkK5mi5tWeb5Ox6jdxDWwJAP
	liD8jdGVVOB/OVUf9mstYRW+ORUX7Tl4LFKSouHf1wMeBeIXz4XyAQEpMRmxlBVVCbeslmw3okn
	KuO4iXyOddUsxbYMGpr
X-Received: by 2002:a05:600c:6092:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-4835082d0c7mr88386175e9.26.1770820380048;
        Wed, 11 Feb 2026 06:33:00 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:32:59 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v5 1/5] io_uring: introduce callback driven main loop
Date: Wed, 11 Feb 2026 14:32:40 +0000
Message-ID: <198c028781463250627eef40b33eda3d73204d39.1770818588.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770818588.git.asml.silence@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The io_uring_enter() has a fixed order of execution: it submits
requests, waits for completions, and returns to the user. Allow to
optionally replace it with a custom loop driven by a callback called
loop_step. The basic requirements to the callback is that it should be
able to submit requests, wait for completions, parse them and repeat.
Most of the communication including parameter passing can be implemented
via shared memory.

The callback should return IOU_LOOP_CONTINUE to continue execution or
IOU_LOOP_STOP to return to the user space. Note that the kernel may
decide to prematurely terminate it as well, e.g. in case the process was
signalled or killed.

The hook takes a structure with parameters. It can be used to ask the
kernel to wait for CQEs by setting cq_wait_idx to the CQE index it wants
to wait for. Spurious wake ups are possible and even likely, the callback
is expected to handle it. There will be more parameters in the future
like timeout.

It can be used with kernel callbacks, for example, as a slow path
deprecation mechanism overwiting SQEs and emulating the wanted
behaviour, however it's more useful together with BPF programs
implemented in following patches.

Note that keeping it separately from the normal io_uring wait loop
makes things much simpler and cleaner. It keeps it in one place instead
of spreading a bunch of checks in different places including disabling
the submission path. It holds the lock by default, which is a better fit
for BPF synchronisation and the loop execution model. It nicely avoids
existing quirks like forced wake ups on timeout request completion. And
it should be easier to implement new features.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h |  5 ++
 io_uring/Makefile              |  2 +-
 io_uring/io_uring.c            |  6 +++
 io_uring/loop.c                | 96 ++++++++++++++++++++++++++++++++++
 io_uring/loop.h                | 27 ++++++++++
 5 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..cceac329fcfd 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -41,6 +41,8 @@ enum io_uring_cmd_flags {
 	IO_URING_F_COMPAT		= (1 << 12),
 };
 
+struct iou_loop_params;
+
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
@@ -355,6 +357,9 @@ struct io_ring_ctx {
 		struct io_alloc_cache	rw_cache;
 		struct io_alloc_cache	cmd_cache;
 
+		int (*loop_step)(struct io_ring_ctx *ctx,
+				 struct iou_loop_params *);
+
 		/*
 		 * Any cancelable uring_cmd is added to this list in
 		 * ->uring_cmd() by io_uring_cmd_insert_cancelable()
diff --git a/io_uring/Makefile b/io_uring/Makefile
index 931f9156132a..1c1f47de32a4 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					advise.o openclose.o statx.o timeout.o \
 					cancel.o waitid.o register.o \
 					truncate.o memmap.o alloc_cache.o \
-					query.o
+					query.o loop.o
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3a7be1695c39..52f9a5c766c1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -95,6 +95,7 @@
 #include "eventfd.h"
 #include "wait.h"
 #include "bpf_filter.h"
+#include "loop.h"
 
 #define SQE_COMMON_FLAGS (IOSQE_FIXED_FILE | IOSQE_IO_LINK | \
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
@@ -2577,6 +2578,11 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	if (unlikely(smp_load_acquire(&ctx->flags) & IORING_SETUP_R_DISABLED))
 		goto out;
 
+	if (io_has_loop_ops(ctx)) {
+		ret = io_run_loop(ctx);
+		goto out;
+	}
+
 	/*
 	 * For SQ polling, the thread will do all submissions and completions.
 	 * Just return the requested submit count, and wake the thread if
diff --git a/io_uring/loop.c b/io_uring/loop.c
new file mode 100644
index 000000000000..26c7e44ac4bf
--- /dev/null
+++ b/io_uring/loop.c
@@ -0,0 +1,96 @@
+#include "io_uring.h"
+#include "wait.h"
+#include "loop.h"
+
+struct iou_loop_state {
+	struct iou_loop_params		p;
+	struct io_ring_ctx		*ctx;
+};
+
+static inline int io_loop_nr_cqes(const struct io_ring_ctx *ctx,
+				  const struct iou_loop_state *ls)
+{
+	return ls->p.cq_wait_idx - READ_ONCE(ctx->rings->cq.tail);
+}
+
+static inline void io_loop_wait_start(struct io_ring_ctx *ctx, unsigned nr_wait)
+{
+	atomic_set(&ctx->cq_wait_nr, nr_wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+}
+
+static inline void io_loop_wait_finish(struct io_ring_ctx *ctx)
+{
+	__set_current_state(TASK_RUNNING);
+	atomic_set(&ctx->cq_wait_nr, IO_CQ_WAKE_INIT);
+}
+
+static void io_loop_wait(struct io_ring_ctx *ctx, struct iou_loop_state *ls,
+			 unsigned nr_wait)
+{
+	io_loop_wait_start(ctx, nr_wait);
+
+	if (unlikely(io_local_work_pending(ctx) ||
+		     io_loop_nr_cqes(ctx, ls) <= 0) ||
+		     READ_ONCE(ctx->check_cq)) {
+		io_loop_wait_finish(ctx);
+		return;
+	}
+
+	mutex_unlock(&ctx->uring_lock);
+	schedule();
+	io_loop_wait_finish(ctx);
+	mutex_lock(&ctx->uring_lock);
+}
+
+static int __io_run_loop(struct io_ring_ctx *ctx)
+{
+	struct iou_loop_state ls = {};
+
+	while (true) {
+		unsigned nr_wait;
+		int step_res;
+
+		if (unlikely(!ctx->loop_step))
+			return -EFAULT;
+
+		step_res = ctx->loop_step(ctx, &ls.p);
+		if (step_res == IOU_LOOP_STOP)
+			break;
+		if (step_res != IOU_LOOP_CONTINUE)
+			return -EINVAL;
+
+		nr_wait = io_loop_nr_cqes(ctx, &ls);
+		if (nr_wait > 0)
+			io_loop_wait(ctx, &ls, nr_wait);
+
+		if (task_work_pending(current)) {
+			mutex_unlock(&ctx->uring_lock);
+			io_run_task_work();
+			mutex_lock(&ctx->uring_lock);
+		}
+		if (unlikely(task_sigpending(current)))
+			return -EINTR;
+
+		nr_wait = max(nr_wait, 0);
+		io_run_local_work_locked(ctx, nr_wait);
+
+		if (READ_ONCE(ctx->check_cq) & BIT(IO_CHECK_CQ_OVERFLOW_BIT))
+			io_cqring_do_overflow_flush(ctx);
+	}
+
+	return 0;
+}
+
+int io_run_loop(struct io_ring_ctx *ctx)
+{
+	int ret;
+
+	if (!io_allowed_run_tw(ctx))
+		return -EEXIST;
+
+	mutex_lock(&ctx->uring_lock);
+	ret = __io_run_loop(ctx);
+	mutex_unlock(&ctx->uring_lock);
+	return ret;
+}
diff --git a/io_uring/loop.h b/io_uring/loop.h
new file mode 100644
index 000000000000..d7718b9ce61e
--- /dev/null
+++ b/io_uring/loop.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef IOU_LOOP_H
+#define IOU_LOOP_H
+
+#include <linux/io_uring_types.h>
+
+struct iou_loop_params {
+	/*
+	 * The CQE index to wait for. Only serves as a hint and can still be
+	 * woken up earlier.
+	 */
+	__u32			cq_wait_idx;
+};
+
+enum {
+	IOU_LOOP_CONTINUE = 0,
+	IOU_LOOP_STOP,
+};
+
+static inline bool io_has_loop_ops(struct io_ring_ctx *ctx)
+{
+	return data_race(ctx->loop_step);
+}
+
+int io_run_loop(struct io_ring_ctx *ctx);
+
+#endif
-- 
2.52.0

