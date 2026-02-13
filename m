Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5D17BA2
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008726; cv=none; b=ENrZGHEmLd8MPR9tQCsSX8+R7WGcjr3r8t/qmwTFMNGPT3ZrVHrOk6qsSJI2LVSKY6S76QLhAmuhxU7YLbSziNLKJsoKzh6MB5z9b1LOhOHkN4HYCtpWOo08hLmzNU/jHOgfvTlbv1L5q0R2Gd2gIeiXubMlrJuAb+C2ZUwXmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008726; c=relaxed/simple;
	bh=wvA8v+RXyxY7w8V0QZnZHrsdKjaHlPdJyUvPEhl9ga4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xc8JBIF/hEpwRYousX77rQBkS2sGILVjo82LFBZ2HCaLJLPO5Y2YPhpQTlZGGF7fFFO1U9S2LcJCQvp4KFcWBR1DNWZ9pdvWUHEd7ua0/V9oAAQ7KQN4Qz3/eJgNZpD10Gv5IDcFCVjfQVv8x3OiFOMrCQtRTcEHXzA5oWHTxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOjVIXPz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOjVIXPz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483703e4b08so9399965e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771008723; x=1771613523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCUUEAI7JNZHKraGp8jFXhExEVVobTUoqzEt7QgsLGQ=;
        b=IOjVIXPzp7mfVNzEmzVdNNIs72hA2AE3TlVpKvA05dwsbOLj3r5mzDXYM28VVw7hQO
         HYF0PX0HZe+rI1XUVa0TB/yussdbuGPAb34dRKQYKJC0S7B3lP0a7y5wIAUGnJuMAdrd
         5OYGvJV8CcwltQGzlXsv6LGcCH+4RiaXg5Y47ETtWy5PHzRJOFGjWL5mOD2oOJSi1yE/
         ChW8cr8eMCXrne1SwSM+ikjvgt4eRA6atLJyaS3VLUjjzzWcdenlNU09nX4/x008LPRu
         sdTALH28Y4L9n5xlMWSMjygzpzuooffz6PiMGcu24Uzv9nFGSRQnor3DGuDM1pV7sUzi
         JwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771008723; x=1771613523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCUUEAI7JNZHKraGp8jFXhExEVVobTUoqzEt7QgsLGQ=;
        b=tCUx3w9RQhHZOxLjInf2bkaW6bz9rbW1FQzZl0MxjoTIFYxnaZn4a786IbuNzx3YnE
         h1Wpod0xGOoE+QATRcm9qfjjSj7XqB4OPI87VK5x/TuMK2cfKuzZ+VbU1G3eFiuTqbYl
         8EHSpvwdaAR4a+YTFgz52XFsXrxpSWEMG6CuiHc9d6D+tl610kVxjlvZn/3PmWqIqHct
         Im7bEFs7lbhCQ9hkSpivcqNPvj2KnCnpDtot29lv+p9ooZBCXXkm5p87uQm4WcMyyh+z
         sIcaKeX5CkV81IDHX68hMbCDXxYaMIMYnmm5iw5eY9fa7IeIha1NXhEYrgxu2nOn1ZeZ
         ALQg==
X-Gm-Message-State: AOJu0YwayS7zNRCQbMkNr34J5LW8/4u47t1V8r7SelM9v16OMX08BkfW
	kKe3n9Ynot1RuXRacqEnD83nq8iaHOpjujV7bOl1g9c7Wq1XP2TdCtTmcjtORQ==
X-Gm-Gg: AZuq6aIzAWNdeaqO2Yco6nk21a5ZCHu+4p+CDYJDdDbdxyuLo7o/YBK2u4sbs23Jgb0
	3VkBS+8x8pLT7JIpGJqdozPoCpbOA6tkp/ZZk2tG/GSgg2u47OztCa429dfsknguSJFJp5I7w8A
	mSha/TWcR8Omi6pVChIgjmv+nqdRHDo0+5hFA4ER6ahfIUxrmPK9knOKaTOz5AFUKqMMKMRIVZm
	BtWHaew3zOHJUFQOVXuNnBVlo05QK0uKTv0YEwqRxhtLCxg6JmNOwDYbuixux0XG2vc62SoIsRT
	YM7qBPZvVW3BgTmrf8W1J1aA92fNiHNHNl5zx+cRotMSq2v1Nbpr1odcb+ZRNuyVNkKD92Iex44
	YwjFhm9B7LtMX5nMVvd5DNcBm8Z62PCpRKP4Roipwq04hTkrprIpG6CDNoWfamqSa5MYNNsrqb8
	OGxsWZ2xvzZOGqxp1BrsJ2Pr6g6g==
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr13065355e9.4.1771008722907;
        Fri, 13 Feb 2026 10:52:02 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a1c2sm412858185e9.9.2026.02.13.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:52:02 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] bpf: Fix special fields mem leak for non-prealloc maps
Date: Fri, 13 Feb 2026 18:51:55 +0000
Message-ID: <20260213185155.337935-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

cancel_and_free() uses xchg(&ptr, NULL) to steal the cb/ctx pointer.
For non-preallocated maps, the element is freed via bpf_mem_cache_free()
making it immediately available for reuse. Between the xchg and the
free, a concurrent BPF program sees NULL, treats it as first use,
allocates a new cb/ctx, and stores it via cmpxchg. The allocation is
then orphaned when the element is freed, causing a memory leak.

Use BPF_PTR_POISON instead of NULL in the xchg so that concurrent
readers can distinguish "being destroyed" from "never initialized"
and refuse to allocate. For preallocated maps, clear the poison
before recycled elements are handed back to BPF programs.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c | 25 +++++++++++++++----------
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53be..9117554f5133 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -279,6 +279,36 @@ static void htab_free_elems(struct bpf_htab *htab)
 	bpf_map_area_free(htab->elems);
 }
 
+/*
+ * Clear special fields (timer/wq/task_work) poisoned by cancel_and_free()
+ * in recycled preallocated map elements.
+ *
+ * Uses WRITE_ONCE to match the READ_ONCE/xchg/cmpxchg used by concurrent
+ * readers on the underlying pointer (bpf_async_kern.cb / bpf_task_work_kern.ctx).
+ */
+static void bpf_obj_init_special_fields(const struct btf_record *rec, void *obj)
+{
+	void **p;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	if (rec->timer_off >= 0) {
+		p = obj + rec->timer_off;
+		WRITE_ONCE(*p, NULL);
+	}
+
+	if (rec->wq_off >= 0) {
+		p = obj + rec->wq_off;
+		WRITE_ONCE(*p, NULL);
+	}
+
+	if (rec->task_work_off >= 0) {
+		p = obj + rec->task_work_off;
+		WRITE_ONCE(*p, NULL);
+	}
+}
+
 /* The LRU list has a lock (lru_lock). Each htab bucket has a lock
  * (bucket_lock). If both locks need to be acquired together, the lock
  * order is always lru_lock -> bucket_lock and this only happens in
@@ -300,6 +330,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
+		bpf_obj_init_special_fields(htab->map.record,
+					    htab_elem_value(l, htab->map.key_size));
 		return l;
 	}
 
@@ -1033,6 +1065,13 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	}
 
 	memcpy(l_new->key, key, key_size);
+	/*
+	 * Clear async fields poisoned by cancel_and_free() in recycled elements.
+	 * copy_map_value() skips special fields, so zeroed fields survive the copy.
+	 */
+	bpf_obj_init_special_fields(htab->map.record,
+				    htab_elem_value(l_new, key_size));
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb04..da51ba35a898 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1477,7 +1477,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 	struct bpf_async_cb *cb;
 
 	cb = READ_ONCE(async->cb);
-	if (!cb)
+	if (!cb || cb == BPF_PTR_POISON)
 		return -EINVAL;
 
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
@@ -1511,7 +1511,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, fla
 		return -EINVAL;
 
 	t = READ_ONCE(async->timer);
-	if (!t || !READ_ONCE(t->cb.prog))
+	if (!t || (void *)t == BPF_PTR_POISON || !READ_ONCE(t->cb.prog))
 		return -EINVAL;
 
 	if (flags & BPF_F_TIMER_ABS)
@@ -1557,7 +1557,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 		return -EOPNOTSUPP;
 
 	t = READ_ONCE(async->timer);
-	if (!t)
+	if (!t || (void *)t == BPF_PTR_POISON)
 		return -EINVAL;
 
 	cur_t = this_cpu_read(hrtimer_running);
@@ -1669,11 +1669,12 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	if (!READ_ONCE(async->cb))
+	cb = READ_ONCE(async->cb);
+	if (!cb || cb == BPF_PTR_POISON)
 		return;
 
-	cb = xchg(&async->cb, NULL);
-	if (!cb)
+	cb = xchg(&async->cb, BPF_PTR_POISON);
+	if (!cb || cb == BPF_PTR_POISON)
 		return;
 
 	bpf_async_update_prog_callback(cb, NULL, NULL);
@@ -3183,7 +3184,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 		return -EINVAL;
 
 	w = READ_ONCE(async->work);
-	if (!w || !READ_ONCE(w->cb.prog))
+	if (!w || (void *)w == BPF_PTR_POISON || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
 	if (!refcount_inc_not_zero(&w->cb.refcnt))
@@ -4267,6 +4268,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	struct bpf_task_work_ctx *ctx, *old_ctx;
 
 	ctx = READ_ONCE(twk->ctx);
+	if (ctx == BPF_PTR_POISON)
+		return ERR_PTR(-EINVAL);
 	if (ctx)
 		return ctx;
 
@@ -4285,6 +4288,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 		 * memory and try to reuse already set context.
 		 */
 		bpf_mem_free(&bpf_global_ma, ctx);
+		if (old_ctx == BPF_PTR_POISON)
+			return ERR_PTR(-EINVAL);
 		return old_ctx;
 	}
 
@@ -4476,7 +4481,7 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	int ret;
 
 	cb = READ_ONCE(async->cb);
-	if (!cb)
+	if (!cb || cb == BPF_PTR_POISON)
 		return -EINVAL;
 
 	/*
@@ -4517,8 +4522,8 @@ void bpf_task_work_cancel_and_free(void *val)
 	struct bpf_task_work_ctx *ctx;
 	enum bpf_task_work_state state;
 
-	ctx = xchg(&twk->ctx, NULL);
-	if (!ctx)
+	ctx = xchg(&twk->ctx, BPF_PTR_POISON);
+	if (!ctx || ctx == BPF_PTR_POISON)
 		return;
 
 	state = xchg(&ctx->state, BPF_TW_FREED);
-- 
2.53.0

