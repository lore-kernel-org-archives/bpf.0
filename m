Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B222989B5
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836700; cv=none; b=GidA+tioXSTJWQqcAXS4C+ilTc31xmIA96/egSpbukSGaidhNTjMRlFM0t5pruzEsM6HsTZa93DYlKrEXbVw414LkFMoY3tZg8Tl18WcXLwz+VdfWcQubA9DZ5PAugXy4I9ijjTyncKoBtWWhelsxdAtEbOhTlIvCpx/SHJOx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836700; c=relaxed/simple;
	bh=CoHy3LRwTTLZwhcP1TIk0vtfJ9o3Mi0iufHhrWtXsB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrONyIsYZ+FwYeKtpiNT9J43LYknaoy3QSMK8J1VLuz9eKWFmXdETvFKnHChQxgYhTHswf1MPJ7hrrteiGTYDm87tIWEtRqJQV6vLElhgaQVZyrzQc61HhFIbh1gU1f+UYWXGvJJQzcrbjoeefvjTl9emfETC4v9awOpjqm5fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD6H27Ep; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD6H27Ep"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359249bbacso895424f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836697; x=1771441497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BsVErE189v1ItMyYEEYF03dum7yffqndOa5SnbMjgo=;
        b=BD6H27EpmWIrqQOr5lXowHJ777+i5Z0rzh+1pPHQM3mcgdFDkbLaiOLhbVb/MToP1E
         APxgOuO6d3tOAPX5Q3s02jfvcOdjCYadm2u+iVlv3pMyNM+JC5nRSEZiarJDbD7TbdFd
         o7XKGscZnwArrHOt8V02PpJsGyaurgM3LzbL8mDixpcThUO0X2qTQ58d8WVX5JSjlCjm
         E8ZMHSVZcoEl6UcDz++r/2kW4r4+g3N69MUVB5dx7MFEFjnVMgU3aEUwmWS7KtmezTvL
         S6L1T68TUeUrY95ZR5M3mQYm8W8DjYqxQ+tlKcZVHrTTx4jbeF19dzLFEQhflhcgir6S
         Jhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836697; x=1771441497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4BsVErE189v1ItMyYEEYF03dum7yffqndOa5SnbMjgo=;
        b=H/HHwsoeddWpADk1hLpmzvCcHiiF0t8UbKZ2N94VDtRpJ0F9ljpbOlVuGt67b3C5Sx
         nIPJfhVfUlZzUoEngIusNlJhVIXvw7gg63Dfwlq+nYIExnm+7awpZf+UOTaiN/C2XUZf
         iE7qWTwW5vgqjFhsXrBBvLDlke0zGfWQ+uiaHpynjlYp9ZoLR8D8VzpOFwP/ZPKqf4+U
         /2p3qzOpTIuZbx1faGWC9rBm4+ai/Z4e1EOabbaPz6TSnQD3VjdzK9yPhqNktbGXCsBo
         ExenkGFt4GwZha7d+L95cLBgf47YrPb7QjWdWoa7ivR1lIjaCNXHilY+8/D2uWPZ9cWw
         aBJg==
X-Forwarded-Encrypted: i=1; AJvYcCUjvCa/75CjpO92TD5Z6BQ1r2gixiDBVVOYurDnn5nqh8z1JSRKhqxSEUs3S6znIbIePys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLzwweHkV/5FG9EfKAfOkpK3JxwPDGzWxdm53uQtqqFewhwiN
	lhq+3X+oWJzGUzq74c4wqKrm5r+Lgq6IjMnW4jwlQpXOHJTzNaUHiZiH
X-Gm-Gg: AZuq6aL5DZWSqehLngh96S4mLo1YYoHNV6UvLfGU5xxXvVI//72zO4tjZdFMpQCPM10
	C+zaFGyCJsQPA0A3fLu3Jtd+ItX8HAiXeC7e8vv23QHbfvJIg5EQd0WaHOaariD9sn5nZXaxAPt
	7K09+qcYBgCc3Yam0C48qqlaMUMeEcEUMaSOhu0oXqsR8lx7tuc3AZ+hci/ZgwIhchQnk4gz+me
	65RKWx33v3o0sMpqXqkrWlm5GST0C5dPUsVQXnblZVrMynK6aUoSrBpEAq0N6zBL0y8keIVFI3P
	nCkSpKM59/acTSBT/znF4ZuLCdqS06Y7Z/W23sNUDTcgg0++MtzEWC8QBt8KQh9kNDBZQ1jnwBw
	Ff7lSWn5LvMJa/YCCynWQKz97zOvZXfg1Nr9BurJ+7sOq8S+S+9kpqlW6MNJfXIKpQAyAQCucOx
	NmFUYcVXT8sTEyjz6BvHU7iTAVJ3jJ0ujqDuS41QZi8kVIYkt5GxeIxhqX16dX0jM3URy5RVYXO
	Xx7NNGwwk3SBfjRon527PzB3mzlkQ==
X-Received: by 2002:a05:6000:2012:b0:436:5286:727f with SMTP id ffacd0b85a97d-43779ec3bfdmr11407690f8f.25.1770836697399;
        Wed, 11 Feb 2026 11:04:57 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm6174169f8f.24.2026.02.11.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:04:56 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 1/5] io_uring: introduce callback driven main loop
Date: Wed, 11 Feb 2026 19:04:52 +0000
Message-ID: <efa65f15822f686bc2a8abda7ba799d3cf46f6c3.1770836401.git.asml.silence@gmail.com>
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
 io_uring/loop.c                | 97 ++++++++++++++++++++++++++++++++++
 io_uring/loop.h                | 27 ++++++++++
 5 files changed, 136 insertions(+), 1 deletion(-)
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
index 000000000000..d5d05ec92389
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

