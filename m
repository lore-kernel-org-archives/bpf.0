Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB02ED860
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508877; cv=none; b=ZXdE5LUGTtpv2YIhTgYpVC1QuZSXH3e47gwnbGxJqg5DM6coJO54m6f7O5MRHeuzAco1MHgMD0YQ0PTxb0bg2Antkr7pghXriVsN5s5xNO/4Q/AxCPPYNHQu0b0o9fVDrIxfG92s/bXH+pP4ZApSm+PFBQC5UjHIkJEFsLiTC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508877; c=relaxed/simple;
	bh=PmLa2E/qa9vx+3T7sbbzNQ3iNQeuhouOCpLOpTlYoqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbFpeDonMRRgFsknl/evzsAsKe7NcLiqfgPx1KEFfecQUVkblUqiJB+4hICOtpNNKsI/DtZkZToC+c7RGdutXxC1rS3PA01uwH2raLxAODCvSBbdPbTLJp6CpQWTiXRQMPKI686l//Ql+f5Vi8dFjwPXcyiinpdj1mrG3PN+npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MatjPdoh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MatjPdoh"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3974056f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769508874; x=1770113674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE2SkxLTZslRj/svpD5iSf0B3A+oiEa6juQ6HgBYPtM=;
        b=MatjPdohHHLyWh95s0o6NBo8ip32EgsthHo1E6PliT1nkA7xK09MMH3JCzi6xeq9jE
         7Ze1yXicusAoAbBGAg6yWFkXmggOw90yBjD6NmaXE0LH825dErUehmjdkO/dGtcg8ig3
         hXtY3CFpMbFZShKpu+RsiP6lAff7AvUcx3B+5b8CZRiNmL8zCFktxhVtXu1mmarD/A2A
         lBDlcB3KbE5QvCVjf/VQuiwHHUlOy+WCW1l/M06I6f41dfUfQKLnSRXKg0261vGLPzPP
         uitWE8+j0GFoYj4dKX7k6RCOJMqxIvQT91H8QR6Rz1CXw2h5F7+31eo/rnl/WPPV0u96
         jaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508874; x=1770113674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KE2SkxLTZslRj/svpD5iSf0B3A+oiEa6juQ6HgBYPtM=;
        b=WXbF5j0MWaFyUhALrRbpAre/tRctkmr+Gw+cHw3YGZFQUbmZSoo591Qe/usvyKd2UO
         uaeObLIAqCOwukcB1LkiwjWDzK7DB3RRlHT0KFe5VpjHkFJjzfxgF6YyzSoeX39tBk5/
         U0gegIA3wTjLrQUbECFIsiebgQ+JR24kXTuwNKKuRasp1B7iEt+uDH2+iYKFl+e4o7aQ
         +6ENo2USrmvhaiHkLiR2PZct+VVb68n7ctqOO2jcBAsbG3JK/uMn0R8xen82BDEh30wj
         yHqNz6B8UXQzslDpy/cG/gMimzuvRk6AP5ZRto3V6NYfGvNx4tYGVDviCtjTEAfB+cy0
         7ZqA==
X-Forwarded-Encrypted: i=1; AJvYcCW1MpJcPKe6ZsiPEv8ufMcSGbJ9SskpwDAZXelf1HMK7my8mI/A1CnIZx9HIPOFXWOSWkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKX/d7M7WB2MmFd6NnAG/qFAkyA2oyO9vBWrxE76sJb0IyKIsY
	AL11to//X9YdgHDM441NRy2hlqcYHpki5jwhevirvuSJjWh6/247/eo3
X-Gm-Gg: AZuq6aLIOZlL7f7eQ/gnbnupS0k/iYAPBNk01Qxy1j0zgUCpYCq5fBc2wzQg+mfzIiY
	/5r77k7TBf8Gd4YKYyJRzO7VJFrkXb9RBzDWNIuGpEtSpWWZ+jX9mGCIrZDuCLAB442LgI9/CFA
	lJzrjqBQOQ4KhqIAfu5x6XNJq7QIVHo3gMMSMFmp05sCR1RgYzRsIeUwCWZ6vgaAtkJOWt4SftO
	WNXEzcmw5rPtLu+2bj4DNonIDgrPJdhp9ChIA1+B+oNtteTyeJCNFGBlSAoCLQxWWo04XH9jolF
	DpHIa5A4hR6TLOcQaN3Z1mKAQuU6JC0cwXSqy0de2yy34k79Vy5si/ROT7sHZmzujBzQoWE0U6H
	zXGY66EcMx+azlT8GDR6QJgJsxFkkR6vvkCUs5fB9LU/tSDNnY8kog2f8nXvHQKzCxo6sud8xDZ
	HbN2GcE+WVyKRg74aRed1VCmtv/t+JhOiWghptrTR4IcqD3oQXrdoaFFdTCI97LN/jSbbhGh5Ip
	yl+4uA70oFpNVLA/T5JyupqMYVT
X-Received: by 2002:a05:6000:1a8f:b0:435:db6e:e3b2 with SMTP id ffacd0b85a97d-435dd090a39mr1700488f8f.27.1769508873839;
        Tue, 27 Jan 2026 02:14:33 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24acdsm38190407f8f.13.2026.01.27.02.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:14:33 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/6] io_uring: introduce callback driven main loop
Date: Tue, 27 Jan 2026 10:14:05 +0000
Message-ID: <20968b8f501a4ca8801f38f1b2cf052f32d03e40.1769470552.git.asml.silence@gmail.com>
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
 io_uring/loop.c                | 88 ++++++++++++++++++++++++++++++++++
 io_uring/loop.h                | 27 +++++++++++
 5 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/loop.c
 create mode 100644 io_uring/loop.h

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index dc6bd6940a0d..9990df98790d 100644
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
@@ -342,6 +344,9 @@ struct io_ring_ctx {
 		struct io_alloc_cache	rw_cache;
 		struct io_alloc_cache	cmd_cache;
 
+		int (*loop_step)(struct io_ring_ctx *ctx,
+				 struct iou_loop_params *);
+
 		/*
 		 * Any cancelable uring_cmd is added to this list in
 		 * ->uring_cmd() by io_uring_cmd_insert_cancelable()
diff --git a/io_uring/Makefile b/io_uring/Makefile
index bf9eff88427a..d4dbc16a58a5 100644
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
index 5c503a3f6ecc..aea27e3538bb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -94,6 +94,7 @@
 #include "alloc_cache.h"
 #include "eventfd.h"
 #include "wait.h"
+#include "loop.h"
 
 #define SQE_COMMON_FLAGS (IOSQE_FIXED_FILE | IOSQE_IO_LINK | \
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
@@ -2557,6 +2558,11 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
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
index 000000000000..bf38f20f0537
--- /dev/null
+++ b/io_uring/loop.c
@@ -0,0 +1,88 @@
+#include "io_uring.h"
+#include "napi.h"
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
+static inline void io_loop_wait_finish(struct io_ring_ctx *ctx)
+{
+	__set_current_state(TASK_RUNNING);
+	atomic_set(&ctx->cq_wait_nr, IO_CQ_WAKE_INIT);
+}
+
+static void io_loop_wait(struct io_ring_ctx *ctx, struct iou_loop_state *ls,
+			 unsigned nr_wait)
+{
+	atomic_set(&ctx->cq_wait_nr, nr_wait);
+	set_current_state(TASK_INTERRUPTIBLE);
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
+int io_run_loop(struct io_ring_ctx *ctx)
+{
+	struct iou_loop_state ls = {};
+	int ret = -EINVAL;
+
+	if (!io_allowed_run_tw(ctx))
+		return -EEXIST;
+	mutex_lock(&ctx->uring_lock);
+
+	while (true) {
+		unsigned nr_wait;
+		int step_res;
+
+		if (unlikely(!ctx->loop_step)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		step_res = ctx->loop_step(ctx, &ls.p);
+		if (step_res == IOU_LOOP_STOP)
+			break;
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
+		if (task_sigpending(current)) {
+			ret = -EINTR;
+			goto out_unlock;
+		}
+
+		nr_wait = max(nr_wait, 0);
+		io_run_local_work_locked(ctx, nr_wait);
+
+		if (READ_ONCE(ctx->check_cq) & BIT(IO_CHECK_CQ_OVERFLOW_BIT))
+			io_cqring_do_overflow_flush(ctx);
+	}
+
+	ret = 0;
+out_unlock:
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

