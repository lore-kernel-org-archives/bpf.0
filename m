Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC07330656
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328036; cv=none; b=op1/q4lutmxvNPVb5dmfgtaPL/1rFDS5haDK96Izst3OmUb0vh5UsEjhJTX/RT4FZ12FhK6cygUiUsfbpAEIIh/AoR82DZYIDcluXNq2vOLv4PxcgktL2r0GIvLCeLvK/lTf88RWRtaDlsjkC58hBBqa985EvQACGVfrEAQH5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328036; c=relaxed/simple;
	bh=WxJloX3R/WzEg0WLlQ0stBo7GSLvF/JaQdvC9yOTAis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCntOPlHBRuL89GKEKfb/HzfZFEcGCnu+v92NW5xq3HZDY+7l65t96XX+9bDU0LARBxtwk+DFjRo5ttHjH5mD2toh/+3D7umhrjxNZ/6SRqYA1TyUPL8ydZimdIfGKZZmgcnRYPgUPkbMwI+CQO+9KPfFWH8P3ceE6O2xMyOeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWkG5T7g; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWkG5T7g"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43626796202so3781889f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328033; x=1771932833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faRGKgv5qJb1+/JxWP4eHk/m1t0T9QReuMl1+myc6PQ=;
        b=IWkG5T7gzItYKkCg7ey+Uaz97dy6joIj3f5MFAQ3IuZrACNOHvOEskPauSemLIXqZ0
         NbjDihhAym3al89maXAq7bKLumwDuW0GwK0bpghaYspbMK71k7ZW540/5NKDpM7vxbkf
         Ui7iY3JWFQb0/GNUuUDGPHGeHsdOBAVcVN71FK8yS0Ctb7UgbdPDyyiaj5Lc5arsicVy
         /s94kZsaymD2MTh4QW+oBeVhMiVU0hf2sRWUGx1/a1yC4KeLl7+wFxVCcd8V2BTafwxN
         D7Hkq8ytzJpxyWIBvqoLa5IndXdVsMSf190l5aR8pRMtDdaf+k+SlkZEAjpxSpOJWHlW
         Av9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328033; x=1771932833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faRGKgv5qJb1+/JxWP4eHk/m1t0T9QReuMl1+myc6PQ=;
        b=ME1tAFOEg+IuwtXO/xox4ZzBkFmQtN7n790F+JYuQ1Gw+wClNHwsCU0a6ky09G/PxI
         dj8usFt5ydNxdtFy5kQ5QEyaMN7GfdPT98P8Lvle8vUgSncVh20rKwa5AXuryhfuSZ0k
         rYasiRYdnzLRkCZtmUAKe4ccRVOmIoWwsT0SIrgxprirC+UVV13qzl1ErggV73r8kw0b
         sBL4r78mhRUA2OV8Icjdea8BzFO4BahpXwgdWzJDfxmSj/M7eMz3pAgLb3HvZ1QjT3gT
         CaSfmawfXVP0J8k2sF/ngI/fiIA2EHHcBN/KPUZCUZix6RnfeSgzRrtvd9N6k7GjBg/v
         vZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFEsEkF54jO8lBpUDAi/57ud2Lg0/WJvValjPqiPomCygMkjJkPchpeIfkYrtbjVcz5e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSBOzVXBh9JFZQ7sF8vS/mHeoNxPDmkJxw4zPmHt7+OXUokaQ
	o3Nw2eW/Rl7k+N+QZtVnRxIY0YhGmHcGrECok5c5BPRsz0CGWCFTIbhN
X-Gm-Gg: AZuq6aJvYO+JY7VJkU8rSxPWmXxSaXTFLEvCcJZdcOxELah5GKkK/3L9Og7UteEL39e
	Qdb1+WbyQRlyTPR2tZuv3B+W325Jb/h5TbxxYKT0sLS5SUx0TNBPgjJry03DVzgMRiE35yKzFsC
	TTCRGyi7mH6tI4v0n1Rhr6oGk9AiHlh5O9RL3kt8Fey3Q1d/8TFxajbsigIOOIR4liX/Wkk9mrZ
	pfJBnEiDaXuRUB/9stc7R2sBEStsVm7msi1ac2PQRQji7RzMG322NPJRsUT5K8lFISUfT8N2GGX
	0YhDv/TJA696HQZr5S8+VEFJyNADSSdZfmBTmr+0ukDkXbb7ePWw1TYRXRQySf+vrCzAom0sER8
	XGKvk0aITm1HsuRtPj3JHgQG9S431uxLEwkXqSZWoyhxBL+bLwT4EV0sfpXYCqsl0GNwqWmNu8t
	t+3LMYyOkx4WHXxGGrO94eLMDmbHu/NxnQeznMPETceRpXuh2/Lgh5E4n7QrK+F4U+moyL9TJ8O
	v22DZ3uhUXl/61M8JJr2yA8v4lRfypzX25BDJI/
X-Received: by 2002:a05:6000:2dc8:b0:436:32e9:993f with SMTP id ffacd0b85a97d-437978c7713mr22165026f8f.3.1771328033033;
        Tue, 17 Feb 2026 03:33:53 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm36258343f8f.27.2026.02.17.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:33:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v8 1/5] io_uring: introduce callback driven main loop
Date: Tue, 17 Feb 2026 11:33:43 +0000
Message-ID: <a1a4ba10e3c25ed69259a989b9d147fbf2a716d3.1771327059.git.asml.silence@gmail.com>
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
 io_uring/io_uring.c            | 11 ++++
 io_uring/loop.c                | 97 ++++++++++++++++++++++++++++++++++
 io_uring/loop.h                | 27 ++++++++++
 io_uring/wait.h                |  1 +
 6 files changed, 142 insertions(+), 1 deletion(-)
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
index 1e627b7a2f3a..0c8bb4e8480a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -95,6 +95,7 @@
 #include "eventfd.h"
 #include "wait.h"
 #include "bpf_filter.h"
+#include "loop.h"
 
 #define SQE_COMMON_FLAGS (IOSQE_FIXED_FILE | IOSQE_IO_LINK | \
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
@@ -589,6 +590,11 @@ void io_cqring_do_overflow_flush(struct io_ring_ctx *ctx)
 	mutex_unlock(&ctx->uring_lock);
 }
 
+void io_cqring_overflow_flush_locked(struct io_ring_ctx *ctx)
+{
+	__io_cqring_overflow_flush(ctx, false);
+}
+
 /* must to be called somewhat shortly after putting a request */
 static inline void io_put_task(struct io_kiocb *req)
 {
@@ -2582,6 +2588,11 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
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
index 000000000000..3006c9f63a1a
--- /dev/null
+++ b/io_uring/loop.c
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+			io_cqring_overflow_flush_locked(ctx);
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
diff --git a/io_uring/wait.h b/io_uring/wait.h
index 5e236f74e1af..037e512dd80c 100644
--- a/io_uring/wait.h
+++ b/io_uring/wait.h
@@ -25,6 +25,7 @@ int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 		   struct ext_arg *ext_arg);
 int io_run_task_work_sig(struct io_ring_ctx *ctx);
 void io_cqring_do_overflow_flush(struct io_ring_ctx *ctx);
+void io_cqring_overflow_flush_locked(struct io_ring_ctx *ctx);
 
 static inline unsigned int __io_cqring_events(struct io_ring_ctx *ctx)
 {
-- 
2.52.0

