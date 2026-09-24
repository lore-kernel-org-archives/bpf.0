Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48540EB9D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267210; cv=none; b=iq2QuIj0BjknzjM+HSytgkO3XaE24dFM/05m9Y/+bQSR/vTe4ke8IdjyFLM4xUyV++FIiYLMA+cjcvi2gm8BcRwMJ7F/ylgoqiDsnJJTzdO965O2HTzm23NfgY6xsfUOAGvaYOmgfxzH84s8WfzSNDv8aXtezdbI2yjygsliidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267210; c=relaxed/simple;
	bh=sEW+XW3Sb86iozqoU9cVcnk1xvKvU5jeP6JfhiitAA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO8Z6Q4Yj74Z3gZ1LYSim8eaxwULEB1U2kY79wWb3RQbDBRvwiI9/tXKaXsvrD4snIDdCFTzrUmMQLBPl2f9fnsN2DxwRqfvSU1vmOefiUMG7+p6V+9YTj8911IH4UHGYbXokXakcYsuqwP3OR3FfB9Z0y+SI+OW3OcyJpZ0fd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3lcrt/I; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3lcrt/I"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe8bf90c9so103595e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267206; x=1790872006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMbu4cVKmTe5PcxDHjKCgs0Fu5f9jEei1ef6Ch90eGg=;
        b=O3lcrt/Ie/bMNQJfzMa7wy1yn3F3OygLfwX5F7QwbXazlT+PzB5fGU92B+mhkKZRc0
         tGnaRIsGcvXEN9DX/fRTev/V8uyj42bDR67cZ24EhSUZpRLxkVF+2t+Vh9dXUkab0540
         wir4SUG4gYoYy2XDMaVKFtq3zFDjLNOtELsp6ZQ/Mgsj1uk4YjwnY6mje3FHNQuHxl3A
         Nlk6kcPlU7xylJ3QTlSsx35SeXfKW6/yjQvtXuVT601aAyUGymhuK1O7wACFAwTwI9Rx
         25aS8+NIGKcdwfl5szZket4aGSMgQrXuAXJRA9qS1XZlN107BtqF3Ome6vrqUGY8MVdf
         BOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267206; x=1790872006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMbu4cVKmTe5PcxDHjKCgs0Fu5f9jEei1ef6Ch90eGg=;
        b=T3Ghuv9W0SW9mT3eizxPebC41InIK7iQvo+e5KOU2n5/sS0N+sQwgxCopM76DOSS5B
         RYIZY15x20Qpk5dVSfzmP+uZWF67iQTWnoXaos3Uds8r92+Us/mmJ8gquik3+C+sT8tr
         7g6px4jG4R/fo8ZiEQ6CWGKH97qLJLIXZc+giCRuJW/LtsDkIdi33f3oY/m3K5RJ/Ads
         yaQk2l7KDFXlQ9Ua6D4nHM0c+skv92J+zUCtJdB7mIT3uZsvvw1Kz2kUnD0M4cVFj0In
         GYr2AoCP/fOkjJWwRNOa/cmRr2JQ1hHQJ1ft9JE3aNmvlGJMtXlfjOEZjrIX6p/8FAFc
         LcTA==
X-Gm-Message-State: AFuF++mtRO3HNyMFHNTsyk5a/IihlLW/lxcgR+6oeGfYp1/BN5ObRjSs
	mozIsrM2CeCgMU8n/hsx4rOIv0/YyUVrig6vdYGUEZYXn4GHN7eEuOmPTLALbS9e
X-Gm-Gg: AYBFou1sHvBtX2lKNmUNOsN7BF9ncF4ztDLiyybwvEYO5cMYZ2WZdwleYSukktx26zE
	BpXqvyWtr/QnkAuqZuvpd4/ybulQrimFj5jaYNoCIUu9rVtf7fSfymdgvUgXUXYYlf8XeWY3r4P
	lbYYy6KelFe1WMzaOq/DUI5CnspKFRMbkfjgwuEoAPKHWMzWA7lIZ7+1IuB3xh/kCZHK5+K39sq
	ig0bMi7TIdLhIHkE4pi33XY6mDpeotx176ZtZBW9DAMv6jjozpukKaGWE+hGeJKSi/gIrDAUX5L
	cm0bpzNKR7Nx1xCdsx1TsX5gotPyiQMk5dVWykH6HXB0mYMnFZESeQDSnINKMHisrhkPao7wWIX
	p9O+OOo9+FWpYNysQjj8twxui8IVJ1J/yPSoAzkgYmhbyf61izmqsEopOhPSrt8CD79dqNdHPqL
	LH0I+oeYGgKnfB+ww02tAuPlUITcZM+l5rSCrC+BbXKASQ7SWK8Zo+LCt04O9x+huEtoXXj5X/3
	+juKSSr9Vkmu/XXlZvuIjmENcB00UlxuBVtIYRX3Rhc8DLxSObo4RLc9+P1X0CIzULxOKMOW8bm
	Unln/GptROyMhqI7CVNOobD/aOaYQMADfOnRIQ==
X-Received: by 2002:a05:600c:630a:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-49fe66fa3d9mr50538075e9.26.1790267206111;
        Thu, 24 Sep 2026 09:26:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ca26fsm771705e9.0.2026.09.24.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Add file descriptor interface for program streams
Date: Thu, 24 Sep 2026 18:26:34 +0200
Message-ID: <20260924162641.1922423-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162641.1922423-1-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22768; i=memxor@gmail.com; h=from:subject; bh=sEW+XW3Sb86iozqoU9cVcnk1xvKvU5jeP6JfhiitAA4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7242qxVLeBbfm8/hN/fE/4cGplmn/M7O/3nWaNK3d /O+Zi/831HKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJ7OJh+J8u41RgFvPGZJ77 Lian42on1/F+tGU1VTB8+rLvzt6pymGMDI29YgkPlfgvrLZvaWBxvWEZr9iVdl73r8rNkqk9MWy ebAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The existing BPF_PROG_STREAM_READ_BY_FD command only supports polling a
program stream through repeated bpf() calls. It cannot block for new data
or integrate with poll-based event loops.

Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec file
descriptor for a selected program stream. Reads block by default and
BPF_F_STREAM_NONBLOCK, the only accepted flag, provides non-blocking
behavior. poll reports readable data and reports hangup once the program
has been freed. Like pipes and sockets, the descriptor is not seekable and
lseek fails with ESPIPE.

A stream descriptor deliberately does not retain the program. Move each
stream into a separately refcounted allocation so program teardown can mark
it dead and wake descriptor users while outstanding descriptors drain
buffered data safely. Readers sample the dead flag before looking for data,
so EOF is reported only when the stream was already dead before it was
found empty; data published right before teardown is never skipped.

Only programs loaded through BPF_PROG_LOAD get streams. Classic BPF
filters, JIT subprograms and shim programs never write to one, and
kernel-side writers already resolve a subprogram to its main program, so
those programs no longer carry stream state.

Readiness needs its own counter. Stream capacity is charged before
allocation and before an element is published to the stream log, so using
that reservation as the read and poll condition can report readable data
while no element exists: a blocking reader retries instead of sleeping and
a lone non-blocking reader can see POLLIN followed by EAGAIN. Publish bytes
with release ordering after adding elements to the lockless log, use
acquire loads before consuming them or reporting readiness, limit each read
to its readable snapshot and subtract only bytes actually copied. This
keeps the aggregate count correct even when concurrent publishers update it
out of publication order. With several readers on one stream, readiness
remains advisory, as it is for pipes. The capacity counter is kept solely
for enforcing the stream size limit.

Wakeups are always deferred through irq_work. Stream writers run in
whatever context the program runs in: NMI context for perf_event programs,
sections with interrupts disabled inside bpf_spin_lock or rqspinlock
critical sections since bpf_stream_vprintk() is KF_SPINLOCK_SAFE, and
tracing programs attached anywhere in the kernel, including inside the wait
queue and epoll code itself. Waking waiters directly from there can
deadlock, and no cheap context check covers every case: on PREEMPT_RT,
spinlock_t sections do not disable interrupts, so in_nmi() or
irqs_disabled() cannot tell such a program apart from a benign one. Queue
an irq_work item after publishing instead, as bpf_ringbuf does. Coalescing
of concurrent publications is a side effect that is compatible with poll
and epoll semantics: notifications prompt waiters to re-evaluate persistent
readable state, and EPOLLET consumers drain until EAGAIN.

Synchronize pending work before releasing the final stream reference so
the callback cannot outlive the stream, but only when the work was ever
queued: irq_work_sync() waits for an RCU grace period on PREEMPT_RT and on
architectures without an irq_work interrupt.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  14 ++-
 include/uapi/linux/bpf.h       |  39 +++++++
 kernel/bpf/core.c              |   8 +-
 kernel/bpf/stream.c            | 200 ++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c           |  29 +++++
 tools/include/uapi/linux/bpf.h |  39 +++++++
 6 files changed, 306 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e1ce2afe2ed..a38badb1c2f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/mm_types.h>
 #include <linux/wait.h>
+#include <linux/irq_work_types.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -1770,12 +1771,18 @@ enum {
 };
 
 struct bpf_stream {
-	atomic_t capacity;
+	refcount_t refcnt;
+	atomic_t capacity;	/* bytes reserved against the stream limit */
+	atomic_t readable;	/* published bytes available to readers */
 	struct llist_head log;	/* list of in-flight stream elements in LIFO order */
 
 	struct mutex lock;  /* lock protecting backlog_{head,tail} */
 	struct llist_node *backlog_head; /* list of in-flight stream elements in FIFO order */
 	struct llist_node *backlog_tail; /* tail of the list above */
+	wait_queue_head_t waitq;
+	struct irq_work notify_work;
+	bool notify_used;	/* notify_work was queued at least once */
+	bool dead;
 };
 
 struct bpf_stream_stage {
@@ -1914,7 +1921,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
-	struct bpf_stream stream[2];
+	struct bpf_stream *stream[2];
 	struct mutex st_ops_assoc_mutex;
 	struct bpf_map __rcu *st_ops_assoc;
 };
@@ -4223,9 +4230,10 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
 void bpf_put_buffers(void);
 
-void bpf_prog_stream_init(struct bpf_prog *prog);
+int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len);
+int bpf_prog_stream_new_fd(struct bpf_prog *prog, enum bpf_stream_id stream_id, u32 flags);
 void bpf_stream_stage_init(struct bpf_stream_stage *ss);
 void bpf_stream_stage_free(struct bpf_stream_stage *ss);
 __printf(2, 3)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0aaa54359aeb..4687c3310996 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -936,6 +936,33 @@ union bpf_iter_link_info {
  * 		0 on success or -1 if an error occurred (in which case,
  * 		*errno* is set appropriately).
  *
+ * BPF_PROG_STREAM_OPEN
+ *	Description
+ *		Open a file descriptor for one of the BPF streams associated
+ *		with the program identified by *prog_fd*. The stream is selected
+ *		by *stream_id*.
+ *
+ *		The returned file descriptor supports **read**\ (2) and
+ *		**poll**\ (2). Reads block while the stream is empty unless
+ *		**BPF_F_STREAM_NONBLOCK** is specified in *flags*. A non-blocking
+ *		read of an empty stream fails with **EAGAIN**.
+ *
+ *		**poll**\ (2) reports **POLLIN** when data is available and
+ *		**POLLHUP** once the program has been freed, that is, after every
+ *		reference to it, including links and other file descriptors, has
+ *		been dropped. Hangup may lag the final release because program
+ *		teardown is deferred. Buffered data remains readable after
+ *		**POLLHUP** and a read returns zero after all such data has been
+ *		consumed.
+ *
+ *		The file descriptor is read-only and has the close-on-exec flag
+ *		set. It is not seekable and **lseek**\ (2) fails with **ESPIPE**.
+ *		*flags* may only contain **BPF_F_STREAM_NONBLOCK**.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -993,6 +1020,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_PROG_STREAM_OPEN,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
@@ -1524,6 +1552,11 @@ enum {
 	BPF_STREAM_STDERR = 2,
 };
 
+/* flags for BPF_PROG_STREAM_OPEN command */
+enum {
+	BPF_F_STREAM_NONBLOCK = (1U << 0),
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1950,6 +1983,12 @@ union bpf_attr {
 		__u32		flags;
 	} prog_assoc_struct_ops;
 
+	struct {
+		__u32		prog_fd;
+		__u32		stream_id;
+		__u32		flags;
+	} prog_stream_open;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 273f74068068..134700f42531 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -141,10 +141,6 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->dst_mutex);
 	mutex_init(&fp->aux->st_ops_assoc_mutex);
 
-#ifdef CONFIG_BPF_SYSCALL
-	bpf_prog_stream_init(fp);
-#endif
-
 	return fp;
 }
 
@@ -288,6 +284,9 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
+#ifdef CONFIG_BPF_SYSCALL
+		bpf_prog_stream_free(fp);
+#endif
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
@@ -3073,7 +3072,6 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
-	bpf_prog_stream_free(aux->prog);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 9829d1ebce70..e0ce37fcd557 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,11 +2,15 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/gfp.h>
+#include <linux/irq_work.h>
 #include <linux/memory.h>
 #include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/refcount.h>
 
 static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
 {
@@ -73,6 +77,42 @@ static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 	atomic_sub(len, &stream->capacity);
 }
 
+static void bpf_stream_notify(struct irq_work *work)
+{
+	struct bpf_stream *stream = container_of(work, struct bpf_stream, notify_work);
+
+	/*
+	 * Writers run in arbitrary program contexts, including NMI and regions
+	 * that already hold wait queue or epoll locks. Wake waiters from
+	 * irq_work instead, where taking those locks is safe.
+	 */
+	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
+}
+
+static void bpf_stream_queue_notify(struct bpf_stream *stream)
+{
+	/*
+	 * Record that the work has been used so that teardown only pays for
+	 * irq_work_sync(), which may wait for an RCU grace period, when a
+	 * callback could actually be in flight.
+	 */
+	if (!READ_ONCE(stream->notify_used))
+		WRITE_ONCE(stream->notify_used, true);
+	irq_work_queue(&stream->notify_work);
+}
+
+static int bpf_stream_readable_bytes(struct bpf_stream *stream)
+{
+	return atomic_read_acquire(&stream->readable);
+}
+
+static void bpf_stream_publish(struct bpf_stream *stream, int len)
+{
+	/* Pairs with atomic_read_acquire() in bpf_stream_readable_bytes(). */
+	(void)atomic_add_return_release(len, &stream->readable);
+	bpf_stream_queue_notify(stream);
+}
+
 static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
 {
 	int ret;
@@ -88,6 +128,8 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 	ret = __bpf_stream_push_str(&stream->log, str, len);
 	if (ret)
 		bpf_stream_release_capacity(stream, len);
+	else
+		bpf_stream_publish(stream, len);
 
 	return ret;
 }
@@ -96,7 +138,7 @@ static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bp
 {
 	if (stream_id != BPF_STDOUT && stream_id != BPF_STDERR)
 		return NULL;
-	return &aux->stream[stream_id - 1];
+	return aux->stream[stream_id - 1];
 }
 
 static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
@@ -164,14 +206,16 @@ static bool bpf_stream_consume_elem(struct bpf_stream_elem *elem, int *len)
 
 static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 {
-	int rem_len = len, cons_len, ret = 0;
+	int read_len, rem_len, cons_len, ret = 0;
 	struct bpf_stream_elem *elem = NULL;
 	struct llist_node *node;
 
 	mutex_lock(&stream->lock);
+	read_len = min(len, bpf_stream_readable_bytes(stream));
+	rem_len = read_len;
 
 	while (rem_len) {
-		int pos = len - rem_len;
+		int pos = read_len - rem_len;
 		int chunk, n;
 		bool cont;
 
@@ -193,7 +237,7 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 			/* Keep any successfully copied bytes; -EFAULT only if none. */
 			elem->consumed_len -= n;
 			rem_len += n;
-			ret = (len == rem_len) ? -EFAULT : 0;
+			ret = (read_len == rem_len) ? -EFAULT : 0;
 			break;
 		}
 
@@ -204,8 +248,9 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 		bpf_stream_free_elem(elem);
 	}
 
+	atomic_sub(read_len - rem_len, &stream->readable);
 	mutex_unlock(&stream->lock);
-	return ret ? ret : len - rem_len;
+	return ret ? ret : read_len - rem_len;
 }
 
 int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len)
@@ -220,6 +265,111 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
 	return bpf_stream_read(stream, buf, len);
 }
 
+static bool bpf_stream_has_data(struct bpf_stream *stream)
+{
+	return bpf_stream_readable_bytes(stream) > 0;
+}
+
+static void bpf_stream_put(struct bpf_stream *stream)
+{
+	if (refcount_dec_and_test(&stream->refcnt)) {
+		struct llist_node *list;
+
+		/* Only a stream that ever queued its work can have a callback in flight. */
+		if (READ_ONCE(stream->notify_used))
+			irq_work_sync(&stream->notify_work);
+		list = llist_del_all(&stream->log);
+		bpf_stream_free_list(list);
+		bpf_stream_free_list(stream->backlog_head);
+		mutex_destroy(&stream->lock);
+		kfree(stream);
+	}
+}
+
+static int bpf_stream_release(struct inode *inode, struct file *file)
+{
+	bpf_stream_put(file->private_data);
+	return 0;
+}
+
+static ssize_t bpf_stream_file_read(struct file *file, char __user *buf, size_t len,
+				    loff_t *ppos)
+{
+	struct bpf_stream *stream = file->private_data;
+	bool dead;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	for (;;) {
+		/*
+		 * Sample teardown state before looking for data. Nothing is
+		 * published once the program is gone, so finding the stream
+		 * empty after observing dead means EOF. The opposite order could
+		 * report EOF while data published just before teardown is still
+		 * buffered.
+		 */
+		dead = smp_load_acquire(&stream->dead);
+		ret = bpf_stream_read(stream, buf, len);
+		if (ret)
+			return ret;
+		if (dead)
+			return 0;
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(stream->waitq,
+					       bpf_stream_has_data(stream) ||
+					       READ_ONCE(stream->dead));
+		if (ret)
+			return ret;
+	}
+}
+
+static __poll_t bpf_stream_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct bpf_stream *stream = file->private_data;
+	__poll_t events = 0;
+
+	/*
+	 * poll_wait() only registers the wait queue callback. Register before
+	 * checking persistent state so a concurrent publication or teardown is
+	 * observed either by the callback or by the checks below.
+	 */
+	poll_wait(file, &stream->waitq, pts);
+	if (bpf_stream_has_data(stream))
+		events |= EPOLLIN | EPOLLRDNORM;
+	if (READ_ONCE(stream->dead))
+		events |= EPOLLHUP;
+	return events;
+}
+
+static const struct file_operations bpf_stream_fops = {
+	.release = bpf_stream_release,
+	.read = bpf_stream_file_read,
+	.poll = bpf_stream_poll,
+};
+
+int bpf_prog_stream_new_fd(struct bpf_prog *prog, enum bpf_stream_id stream_id, u32 flags)
+{
+	struct bpf_stream *stream;
+	int fd_flags = O_RDONLY | O_CLOEXEC;
+	int fd;
+
+	stream = bpf_stream_get(stream_id, prog->aux);
+	if (!stream)
+		return -ENOENT;
+	if (flags & BPF_F_STREAM_NONBLOCK)
+		fd_flags |= O_NONBLOCK;
+
+	refcount_inc(&stream->refcnt);
+	fd = anon_inode_getfd("bpf-stream", &bpf_stream_fops, stream, fd_flags);
+	if (fd < 0)
+		bpf_stream_put(stream);
+	return fd;
+}
+
 __bpf_kfunc_start_defs();
 
 /*
@@ -287,28 +437,47 @@ __bpf_kfunc_end_defs();
 
 /* Added kfunc to common_btf_ids */
 
-void bpf_prog_stream_init(struct bpf_prog *prog)
+int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
-		atomic_set(&prog->aux->stream[i].capacity, 0);
-		init_llist_head(&prog->aux->stream[i].log);
-		mutex_init(&prog->aux->stream[i].lock);
-		prog->aux->stream[i].backlog_head = NULL;
-		prog->aux->stream[i].backlog_tail = NULL;
+		struct bpf_stream *stream;
+
+		/* On failure, bpf_prog_stream_free() releases the streams allocated so far. */
+		stream = kzalloc_obj(*stream,
+				     bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+		if (!stream)
+			return -ENOMEM;
+
+		refcount_set(&stream->refcnt, 1);
+		init_llist_head(&stream->log);
+		mutex_init(&stream->lock);
+		init_waitqueue_head(&stream->waitq);
+		init_irq_work(&stream->notify_work, bpf_stream_notify);
+		prog->aux->stream[i] = stream;
 	}
+	return 0;
 }
 
 void bpf_prog_stream_free(struct bpf_prog *prog)
 {
-	struct llist_node *list;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
-		list = llist_del_all(&prog->aux->stream[i].log);
-		bpf_stream_free_list(list);
-		bpf_stream_free_list(prog->aux->stream[i].backlog_head);
+		struct bpf_stream *stream = prog->aux->stream[i];
+
+		if (!stream)
+			continue;
+		/*
+		 * Pairs with smp_load_acquire() in bpf_stream_file_read(): every
+		 * publication precedes the dead flag, so a reader that observes
+		 * it also observes all buffered data.
+		 */
+		smp_store_release(&stream->dead, true);
+		wake_up_interruptible_poll(&stream->waitq, EPOLLHUP);
+		bpf_stream_put(stream);
+		prog->aux->stream[i] = NULL;
 	}
 }
 
@@ -371,6 +540,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 		list = tail;
 	}
 	llist_add_batch(head, tail, &stream->log);
+	bpf_stream_publish(stream, ss->len);
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3..8580f38b41c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3080,6 +3080,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	prog->aux->user = get_current_user();
 	prog->len = attr->insn_cnt;
 
+	err = bpf_prog_stream_init(prog, GFP_USER);
+	if (err)
+		goto free_prog;
+
 	err = -EFAULT;
 	if (copy_from_bpfptr(prog->insns,
 			     make_bpfptr(attr->insns, uattr.is_kernel),
@@ -6313,6 +6317,28 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_PROG_STREAM_OPEN_LAST_FIELD prog_stream_open.flags
+
+static int prog_stream_open(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	u32 flags = attr->prog_stream_open.flags;
+	int ret;
+
+	if (CHECK_ATTR(BPF_PROG_STREAM_OPEN))
+		return -EINVAL;
+	if (flags & ~BPF_F_STREAM_NONBLOCK)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_stream_open.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	ret = bpf_prog_stream_new_fd(prog, attr->prog_stream_open.stream_id, flags);
+	bpf_prog_put(prog);
+	return ret;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
@@ -6485,6 +6511,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 	case BPF_PROG_ASSOC_STRUCT_OPS:
 		err = prog_assoc_struct_ops(&attr);
 		break;
+	case BPF_PROG_STREAM_OPEN:
+		err = prog_stream_open(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0aaa54359aeb..4687c3310996 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -936,6 +936,33 @@ union bpf_iter_link_info {
  * 		0 on success or -1 if an error occurred (in which case,
  * 		*errno* is set appropriately).
  *
+ * BPF_PROG_STREAM_OPEN
+ *	Description
+ *		Open a file descriptor for one of the BPF streams associated
+ *		with the program identified by *prog_fd*. The stream is selected
+ *		by *stream_id*.
+ *
+ *		The returned file descriptor supports **read**\ (2) and
+ *		**poll**\ (2). Reads block while the stream is empty unless
+ *		**BPF_F_STREAM_NONBLOCK** is specified in *flags*. A non-blocking
+ *		read of an empty stream fails with **EAGAIN**.
+ *
+ *		**poll**\ (2) reports **POLLIN** when data is available and
+ *		**POLLHUP** once the program has been freed, that is, after every
+ *		reference to it, including links and other file descriptors, has
+ *		been dropped. Hangup may lag the final release because program
+ *		teardown is deferred. Buffered data remains readable after
+ *		**POLLHUP** and a read returns zero after all such data has been
+ *		consumed.
+ *
+ *		The file descriptor is read-only and has the close-on-exec flag
+ *		set. It is not seekable and **lseek**\ (2) fails with **ESPIPE**.
+ *		*flags* may only contain **BPF_F_STREAM_NONBLOCK**.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -993,6 +1020,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_PROG_STREAM_OPEN,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
@@ -1524,6 +1552,11 @@ enum {
 	BPF_STREAM_STDERR = 2,
 };
 
+/* flags for BPF_PROG_STREAM_OPEN command */
+enum {
+	BPF_F_STREAM_NONBLOCK = (1U << 0),
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1950,6 +1983,12 @@ union bpf_attr {
 		__u32		flags;
 	} prog_assoc_struct_ops;
 
+	struct {
+		__u32		prog_fd;
+		__u32		stream_id;
+		__u32		flags;
+	} prog_stream_open;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.53.0

