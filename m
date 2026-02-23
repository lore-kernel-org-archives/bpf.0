Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365126CE2B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855844; cv=none; b=ASTAOB0iP0TxC6CMuA2Wzhji6bIyYjeZZLOsLqo9yQr/jKXfB6CXP932HHbUcaIjuaSOFWj01LvmZT6/rahg9VbAQBEjPtel6/CPcJpVuuPaeAcTvZutFKvcZXbaqHU9EWxWlvXGUiTKLso8L/UoG8HKTtOoaXB5oceOz3yO0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855844; c=relaxed/simple;
	bh=AWztUOnsa5faZPLauaUGRJUddP5DvrYOLsgskh25IOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Z7L/rT49LksNZf9acAiawvOEg1kjvbLBQIcWEon3aSKD15g+IOnmoez95Puz3Zf0v/3Tsuq29XNHOQIGIdrKn/VB9L79kjMhkUbha+TyOD52+qraShWGRqWtrHnYmFADYzzM2bM29bUUmToMxqf5oLw9mWb2bQxH0Uq7lkoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNgM5tbO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNgM5tbO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436356740e6so4625869f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855842; x=1772460642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5townms+VWjMcw4jJ/nnoWesJGALIy6E6lXzjAxQ0yM=;
        b=ZNgM5tbOGmXx0KJLWuwzRzsMQrNf1qCyUECyNryVwsn5spPW6nIh1zA4qDHST+VEHH
         iQUoAUldj+0ogkUcJZSANZhIZ2r/Rxh+uVDOrFNrrqQeorgwDlR7W1qO2WVWovb4QKgC
         1zWmqBpHz2d3RnsBvEPAP+H++CWH+kDoxk4K+X0nhiytS8KYFPVlI5QaJylQolWPmUoO
         hMLlLaHd4Ovq7y3ISFCExBHtdTR82NlcKWTx9m0xpquIiJcG4X4NirpFC1mrHrngs3aY
         PuWuUfiSTZNOcANwgVx9hcf/NRKJH+9LONY/0zt+uooHjvPnz7vvTiEJTGluqm/o8MtT
         ztmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855842; x=1772460642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5townms+VWjMcw4jJ/nnoWesJGALIy6E6lXzjAxQ0yM=;
        b=HSKdlDvMZ4N2usq6iOTa+BsFOjmoU/v7l2ylDneXDWOSSLyGvW8+z/EU+zVDBTQ8Y0
         cRIlji/d8YRQ9BM8oHxbsR3I0APwL8bxD+WmCMryfUxUA9gBqfhR3wxMsmxA5ZIUfQYp
         +yp8G3lq79bhpvgU6vZDZDorXXbvo7wZY1zn1WbXv/IB8olaSdxXY+pZjxAX3szyQSk4
         lH4m5Ni4G4hXDG4nPjIjIdS+bdObNN4Wy8I0wUEqABQVuqqCITER/WXfkW7/1+vTXQfS
         huFBdd8SMEpVrsHaMrqRMqAXbanDV+TAm5/fCpvou34Wudlt/+e2qLr6tn2KHI01VSHp
         EBqg==
X-Forwarded-Encrypted: i=1; AJvYcCUbWTdlpQTJ46t6e4UodI8wPlPcNCouGBaDNQkAUl+/UGrJOxMG463YB0evnfj25zOhNUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQYoZCfzNM4UORzeZosRdm78eDclOrIpNPp/9UAjKh6nRlW8Y
	8j2U7NumN+Xt56YhRF0x21VSmxApw7gfoWFBzFuHnQH2J5n9m+vJzlwF
X-Gm-Gg: ATEYQzwhsXEwxyCe5C4eDqg6ipG3IvW3a+a0lh9USGVQwLz7y1qWh0zqx1NSTij/P9/
	gmsFAOOVtQjFDgWu8AR9KyeUlDHueGltJNSEgA5O2RYx0jHSJ8GLRtc8vIro+1UkrUn0TXPIZ62
	QJpThYTiqM02F4iGDzJ3cZyuYcNje2yYPuPFMc8gW16Q6tEGJ+WabBMULWomlr3ccH0ljKn4WNo
	HN7Jlo44bXqjDfPRr0nZBQk0aVVWc0LkUd5GjUFMZH7niZonJKq8kWzHSRSuHgJ6HWa8JVFJ8LZ
	SHwCY9Kwiwx0JtbqqMDfPuCiQoauEYKEjPbsjQkJK+MUMOO6zbdsHrLMUWFx2bbOS/POzsC3I8J
	TF51iesUO00vumKPN47rZOCy66emypxkxIlt0izG/TVa1tEeFbrdrvF7FhmnN0UB3uN079EAZYI
	KYRTjMJt6vLHqZlw9Vf0z5XTwr6QbpNQQ5Cj6DFpP/T7c6PXxTuoHAagY4qUQ2MVZboZlkC75QO
	R5GYEm3TQ==
X-Received: by 2002:a05:6000:4381:b0:437:812c:316d with SMTP id ffacd0b85a97d-4396f151992mr15804302f8f.2.1771855841372;
        Mon, 23 Feb 2026 06:10:41 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:40 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 01/10] io_uring: introduce callback driven main loop
Date: Mon, 23 Feb 2026 14:10:12 +0000
Message-ID: <a1a4ba10e3c25ed69259a989b9d147fbf2a716d3.1771855760.git.asml.silence@gmail.com>
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
2.53.0

