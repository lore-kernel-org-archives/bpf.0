Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C53A7849
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082522; cv=none; b=o6n6+lea8SL6k9PS5/uh0pJQw2LR1PL4iEzJYiBNwmusaBioXPLdEi/W2Prgujr5Ce4b6uoMpt+XyYevPYeMx+fibWnHpvlkrSrDRhcvpC6sUWhte0JsWdavGbudy8wTEoVwQEkJbfyTgz2HG0WnA1GgUr+xiuPOQvmbraHzPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082522; c=relaxed/simple;
	bh=PGJb0UVk6SuHSdf3WbS5866Q+VCVEVAn3w1sqRer+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQmdJzGRLfMjV9Tw7UPOQb6zn+b/I7igpaBeBmSiIttn2UFONyMWoQZXQ9ikTuzyDLsq09JltyYb3E/Okw2pk1o0b5f38I+CyFNeaupMl0MXris9REHYsfR0TbQX7eUD/cP6p+s+s2iUWySHAuGUtYmvk9XlpjpEvBYZkWCZgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3ESFqox; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3ESFqox"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so4019335e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082519; x=1788687319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAhPlX0+bNLv0gwvVLv5moDZUtsnMNWX8vGo1ZbdPCU=;
        b=F3ESFqoxhA56FBhT78Nj0KjFA6OtJDvgEgjkoEfaLDCgC1Ehp5z4BlzLEjq1Vj9f5X
         vmXuwk9liRgZAk8tfo2yNXPZImzfbWDEM4atI6yXGBWXFiGxBbAK1PoMSLQHA2FatZnE
         dGYI1+XXKsOF1cPjB/gGfbUiKq0b/p9q10/lYeTrg47Lg8lFNfqW8M8bzkX9Z5BF1lSR
         WTas9DT8EnOskVcer/5BGq6Wf3f1jcD808hzACKqKtpdKthwgoYkxeBFFntdievOXqFD
         /v6M8fGTyTdH4hLjCevX/1bEJVhpHH5uF79TT7hIW3YURXxafY+oATf4TUP9NeL1gvMG
         lFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082519; x=1788687319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAhPlX0+bNLv0gwvVLv5moDZUtsnMNWX8vGo1ZbdPCU=;
        b=VElYfEgcVseKwvqAsuQJj7qJGNa57ys1cy00qMRW/G9wu9ESgOvuJ3Pzc4a6lfbk3+
         kUJprWBCwoMxYR8fXSHcW75csrqKKVMrhPFyhKq/D4bfpbRIxQoL2Chx4Tl5k7Tm31im
         Uj5/TcUbzPgojcASe3GOWnOMQuvrFwJFCJPeITXUcYZJPzessplmK85TXt/qaf4VHUOS
         8UuTsc7hv4Rg521K4upNXlYDsJjwP3GdGtPhY+kMUtUP5OF1aTGi6pUbWIe5HJXOwEoE
         1HuJ0Y5cx95uGOzoA8jAXshsCevM6iDZ82+5cDZKAGcGR501xoDF/P6iAoNAYxTJBmD+
         XXBA==
X-Gm-Message-State: AFuF++nQS1y86Fa67CZKcW6cnQHpVW+sXdcFf3iOp64ux/TtM8grq3rb
	R07OJmvQmZmSTZVM8lZH8vHnvPaCYWbYBracaNyV8Xk+7K8OO8mJ4l9u8I/YlQjHsB0=
X-Gm-Gg: AR+sD13IxJg6RV02tAfqKf+6gzeqiVkirnN2CQ492cYyXwncddzfV7vvCuXDCOexkay
	m0giAFBJNc5jgy9Boz4Gi3atzqGvsjwouftZ7Syzz/e/+qsps6MUAzVBDgxDapmNo+ljIXBCcKP
	RzzowpWrwD4ukJiPq0i/t7xmk8oUPweUKcfiQs8WKiW74Qrv5qBYZEnBcnb11yZz5MI02lxXtKr
	+PhGhxuJrhHZyZWLx9XWGCmgUaclEOBPujOYRwoRpaO3W6coVDdvuPyMWU+NMDKYxpCyA0Hy5se
	9xOVQ97BxTGWxKn2Pg1lzXEvQgEBU5h3y3oWJDMMgWaM//18xYdOSBXbQYP3S+qVysIUjUi+yKK
	TklzWJeIvuIHuxA+Nn4G249OkBYjlrgCs2xZ5rbDjT1WiU0YwuBHXGTv6IyW6hvbQCO5fwJhOcJ
	B169U+V+Li+A3haByNcvFf0aI0d/7Ea9VcWW6UT9/kamQUcq8dWnAiVXPcjhsegEd6k/svFlYim
	0BYeCmECpYk0JnUxROmX+A+R9tP5Wab4iWd8K7gbt/sCefwy+1u+8A8RYXj73VSUikLo9mDJ7QE
	hH9w/Le7GpREIqljbZc4s3tTlaU=
X-Received: by 2002:a05:600c:8b27:b0:49c:d27f:ed81 with SMTP id 5b1f17b1804b1-49cd27fee09mr65468415e9.11.1788082518414;
        Sun, 30 Aug 2026 02:35:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm322377595e9.10.2026.08.30.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/6] bpf: Add file descriptor interface for program streams
Date: Sun, 30 Aug 2026 11:35:06 +0200
Message-ID: <20260830093514.4105972-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15918; i=memxor@gmail.com; h=from:subject; bh=PGJb0UVk6SuHSdf3WbS5866Q+VCVEVAn3w1sqRer+d0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyxy23zKyuMmVfUljfPeHt5/0ra/f0Pf3Ye7Q5uYSl4 VBeu5hiRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbiLcPw31fy87nTu7n2lPJ9 PR52n/2Bl8EJnxkr5O78TVE9efCc3xVGhtuf331axXXQ7YloMV+I2rJK+fWHZSUqmraKuF/vV7d i4gAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The existing BPF_PROG_STREAM_READ_BY_FD command only supports polling a
program stream through repeated bpf() calls. It cannot block for new data
or integrate with poll-based event loops.

Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec file
descriptor for a selected program stream. Reads block by default and
BPF_F_STREAM_NONBLOCK provides non-blocking behavior. poll reports readable
data and reports hangup once the program is released.

A stream descriptor deliberately does not retain the program. Move each
stream into a separately refcounted allocation so program teardown can mark
it dead and wake descriptor users while outstanding descriptors drain
buffered data safely.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |   8 +-
 include/uapi/linux/bpf.h       |  36 +++++++++
 kernel/bpf/core.c              |  13 +--
 kernel/bpf/stream.c            | 139 ++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c           |  27 +++++++
 tools/include/uapi/linux/bpf.h |  36 +++++++++
 6 files changed, 241 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a7eb2185c35..1745686331be 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1711,12 +1711,15 @@ enum {
 };
 
 struct bpf_stream {
+	refcount_t refcnt;
 	atomic_t capacity;
 	struct llist_head log;	/* list of in-flight stream elements in LIFO order */
 
 	struct mutex lock;  /* lock protecting backlog_{head,tail} */
 	struct llist_node *backlog_head; /* list of in-flight stream elements in FIFO order */
 	struct llist_node *backlog_tail; /* tail of the list above */
+	wait_queue_head_t waitq;
+	bool dead;
 };
 
 struct bpf_stream_stage {
@@ -1855,7 +1858,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
-	struct bpf_stream stream[2];
+	struct bpf_stream *stream[2];
 	struct mutex st_ops_assoc_mutex;
 	struct bpf_map __rcu *st_ops_assoc;
 };
@@ -4112,9 +4115,10 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
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
index 732b35cc08d1..da2370036bf0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -936,6 +936,30 @@ union bpf_iter_link_info {
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
+ *		**POLLHUP** once the program is released. Buffered data remains
+ *		readable after **POLLHUP** and a read returns zero after all such
+ *		data has been consumed.
+ *
+ *		The file descriptor is read-only and has the close-on-exec flag
+ *		set. *flags* may contain **BPF_F_RDONLY** and
+ *		**BPF_F_STREAM_NONBLOCK**. **BPF_F_WRONLY** is not supported.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -993,6 +1017,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_PROG_STREAM_OPEN,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
@@ -1524,6 +1549,11 @@ enum {
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
@@ -1950,6 +1980,12 @@ union bpf_attr {
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
index 5db77d7915df..afa030b01ed3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -142,7 +142,10 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->st_ops_assoc_mutex);
 
 #ifdef CONFIG_BPF_SYSCALL
-	bpf_prog_stream_init(fp);
+	if (bpf_prog_stream_init(fp, gfp_extra_flags)) {
+		__bpf_prog_free(fp);
+		return NULL;
+	}
 #endif
 
 	return fp;
@@ -160,9 +163,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 
 	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
 	if (!prog->stats) {
-		free_percpu(prog->active);
-		kfree(prog->aux);
-		vfree(prog);
+		__bpf_prog_free(prog);
 		return NULL;
 	}
 
@@ -288,6 +289,9 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
+#ifdef CONFIG_BPF_SYSCALL
+		bpf_prog_stream_free(fp);
+#endif
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
@@ -3067,7 +3071,6 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
-	bpf_prog_stream_free(aux->prog);
 #endif
 #ifdef CONFIG_CGROUP_BPF
 	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 2b80a0599865..d3dbb1aca792 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,11 +2,14 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/gfp.h>
 #include <linux/memory.h>
 #include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/refcount.h>
 
 static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
 {
@@ -83,6 +86,8 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 	ret = __bpf_stream_push_str(&stream->log, str, len);
 	if (ret)
 		bpf_stream_release_capacity(stream, len);
+	else if (len)
+		wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
 
 	return ret;
 }
@@ -91,7 +96,7 @@ static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bp
 {
 	if (stream_id != BPF_STDOUT && stream_id != BPF_STDERR)
 		return NULL;
-	return &aux->stream[stream_id - 1];
+	return aux->stream[stream_id - 1];
 }
 
 static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
@@ -215,6 +220,102 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
 	return bpf_stream_read(stream, buf, len);
 }
 
+static bool bpf_stream_has_data(struct bpf_stream *stream)
+{
+	return atomic_read(&stream->capacity) > 0;
+}
+
+static void bpf_stream_put(struct bpf_stream *stream)
+{
+	if (refcount_dec_and_test(&stream->refcnt)) {
+		struct llist_node *list;
+
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
+	int ret;
+
+	if (len > INT_MAX)
+		return -EINVAL;
+	if (!len)
+		return 0;
+
+	for (;;) {
+		ret = bpf_stream_read(stream, buf, len);
+		if (ret)
+			return ret;
+		if (READ_ONCE(stream->dead))
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
+	.llseek = noop_llseek,
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
@@ -282,28 +383,43 @@ __bpf_kfunc_end_defs();
 
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
+		stream = kzalloc_obj(*stream,
+				     bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+		if (!stream) {
+			bpf_prog_stream_free(prog);
+			return -ENOMEM;
+		}
+
+		refcount_set(&stream->refcnt, 1);
+		atomic_set(&stream->capacity, 0);
+		init_llist_head(&stream->log);
+		mutex_init(&stream->lock);
+		init_waitqueue_head(&stream->waitq);
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
+		WRITE_ONCE(stream->dead, true);
+		wake_up_interruptible_poll(&stream->waitq, EPOLLHUP);
+		bpf_stream_put(stream);
+		prog->aux->stream[i] = NULL;
 	}
 }
 
@@ -366,6 +482,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 		list = tail;
 	}
 	llist_add_batch(head, tail, &stream->log);
+	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..b5405f7270d1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6300,6 +6300,30 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
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
+	if (flags & ~(BPF_F_RDONLY | BPF_F_WRONLY | BPF_F_STREAM_NONBLOCK))
+		return -EINVAL;
+	if (flags & BPF_F_WRONLY)
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
@@ -6472,6 +6496,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
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
index 732b35cc08d1..da2370036bf0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -936,6 +936,30 @@ union bpf_iter_link_info {
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
+ *		**POLLHUP** once the program is released. Buffered data remains
+ *		readable after **POLLHUP** and a read returns zero after all such
+ *		data has been consumed.
+ *
+ *		The file descriptor is read-only and has the close-on-exec flag
+ *		set. *flags* may contain **BPF_F_RDONLY** and
+ *		**BPF_F_STREAM_NONBLOCK**. **BPF_F_WRONLY** is not supported.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -993,6 +1017,7 @@ enum bpf_cmd {
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
+	BPF_PROG_STREAM_OPEN,
 	__MAX_BPF_CMD,
 	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
 };
@@ -1524,6 +1549,11 @@ enum {
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
@@ -1950,6 +1980,12 @@ union bpf_attr {
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

