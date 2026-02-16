Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FB18C2C
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247632; cv=none; b=k6oMIiRCf9QA4A6BM9tGhKTo375QhgTKDiZuXfkniLicz1+TR7p6/52ATGS0BHN17vqipusBG13KN6K7eyxEp9x7UQNAftbxxzGpfIlYCfISrV+0aD0l8+fe8EnQZXZhcq25lsAbSBUF6bmVOlwVQ+V+RJErmzKZ6Y2BsUSyX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247632; c=relaxed/simple;
	bh=q6AqSysQQcL0eT0dhkGrhfDKe8txYEvGR2xvi1+6JQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJ3UAaC+20PPF/R6JBcTApU7GgqI5laDl3NKfTv2vwXb//NRfLusGyio3fh4JIAZRj0U9C6DPzAGzVGocxa5l6j4f5ftH5AXVbi142EWAMdDK7ZGmXgAv+45vV/H9QPBwQZlZTIuupI2cR88y1u6P3WEJbE3gN7DoUvjvHNGfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj3UXFrs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj3UXFrs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so30683335e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771247629; x=1771852429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk3lojDgnbqiw0nVxd00XNCp8xsPt/H9VOFq6smCdxA=;
        b=Yj3UXFrsICgtVJIjSu1RrZ1URvjGmMFH8OcieAlv0GVm1/aQ4TMHVcZg3McFr6jViO
         NZQnXFBgqfcXcDjrrK9d7PXXH4C8w7QNKeX2hI6tqH8q59Gq2H7Phq/lwPYTQ5j1a04b
         P/JhRlOpjuWm5sGzFPG25mKhczBommyfdDyaKF1iuI0V1Q//luixX6Qpw6CeERy/nHwM
         da7E9Rl0CZwDNaC6eZqnfiUD8B6y14OfgErLR6d+6GPGvUE8X664NVT4SO5fSP6+tfml
         55iD1uL45HninXKELpo49LNeNguVzMrDPnSeGloutaa/S8/pMoxYNeKvVixviNQQTNvf
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771247629; x=1771852429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk3lojDgnbqiw0nVxd00XNCp8xsPt/H9VOFq6smCdxA=;
        b=i3xibB2GOTbjp0aXWSdzfQDW8ZBlGamcSEJQqNNTSivI32PNCSZSt3mWK+2KXALxv5
         DNTyHRrhpAs3ef3IJ6TPdDAsixQk+StEiaFtHMqxDZT32X/OhdP8RrIONqw94p0vxpo5
         BlfUg2GQ0Cl/7qC40VX35vbeb5QxENI2rsjm+FzYBGAtbWeK4sXZqS4mR5Z/Q+kzqD3i
         IezPultRsBbD7iDsbkEUJbPhSq6x8FwE7YDzKj8OKvzVZKCGAi4x6x4cfonNWZkN9vhu
         kOgwEjHrZNdLsUHtZEQxnHFcfgvCa3M+EXjwnwPivj09rOKgeXQWIOgPATD1UksSKJFs
         i/Ng==
X-Gm-Message-State: AOJu0YwHkVMHlu/CxYPBbaBQaa8Vszw367whZguyP/cwRCXbkm1LQq1h
	MxXE1+ZEWXp5TggbBzd7oEJ2/vG/pK78QoXsdYG5UK2g8DgTMTL0nbJuFXDXeQ==
X-Gm-Gg: AZuq6aL8tMqaKRkD4szmUPKQcxQVFboG9WHjMI10DUCtmn0B7UaUmqP3PVcdoNHpy1x
	i4RTkDFhWEUsO2j5bK/psLJEmULxbwlewO5T05oBkqgbg2FFTYSGtpzyhnNxLWA9N7W9PiYYJ3U
	HYBt0a9eRyo2iy3EfCB4rX/u/qFdoot2YKUipCK+U9ChwrEzXJwmv/abd5rp8Od3UbhXhZ2CfJF
	14mOSFeYGhKKNxYXT7VKSFeWumZucTMCfvV6rYR/97nc5/oJMXmO1m0V4n8JZU3XIlVxbjdp1+N
	fLq4bt4Ad+a9RIRnaHM0G6Lo10dY3e3KpzDaoZEDYS/FFTKOaifKUPcsujj2YGWunACvqnJZ8v7
	J6AqshoyJRmg4t3GDqvW2ITCRiiQJ5FUbO51Ofylfpku7VVof6KbbXgIkq9N1njM5HmgHVCQ+1V
	xHN9Voh/g=
X-Received: by 2002:a05:600c:a016:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-48373a7b2camr168743775e9.34.1771247628790;
        Mon, 16 Feb 2026 05:13:48 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:abe1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm504374805e9.6.2026.02.16.05.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:13:47 -0800 (PST)
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
Subject: [PATCH bpf-next v2] bpf: Fix special fields mem leak for non-prealloc maps
Date: Mon, 16 Feb 2026 13:13:41 +0000
Message-ID: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>
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
 include/linux/bpf.h   | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/arraymap.c |  4 ++--
 kernel/bpf/hashtab.c  |  5 +++++
 kernel/bpf/helpers.c  | 25 +++++++++++++------------
 4 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434904..90006a910dd6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -671,6 +671,36 @@ static inline bool bpf_map_has_internal_structs(struct bpf_map *map)
 
 void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
 
+/*
+ * Clear special fields (timer/wq/task_work) poisoned by cancel_and_free()
+ * in recycled map elements.
+ *
+ * Uses WRITE_ONCE to match the READ_ONCE/xchg/cmpxchg used by concurrent
+ * readers on the underlying pointer (bpf_async_kern.cb / bpf_task_work_kern.ctx).
+ */
+static inline void bpf_obj_init_special_fields(const struct btf_record *rec, void *obj)
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
 int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
 				   struct bpf_dynptr *ptr__uninit);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 67e9e811de3a..0ef68e5c4c90 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -386,7 +386,6 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
 		copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -394,8 +393,9 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
 	}
+	bpf_obj_free_fields(array->map.record, val);
+	bpf_obj_init_special_fields(array->map.record, val);
 	return 0;
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53be..7e93ece61296 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -300,6 +300,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
+		bpf_obj_init_special_fields(htab->map.record,
+					    htab_elem_value(l, htab->map.key_size));
 		return l;
 	}
 
@@ -1033,6 +1035,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	}
 
 	memcpy(l_new->key, key, key_size);
+	/* Clear special fields poisoned by cancel_and_free() in recycled elements */
+	bpf_obj_init_special_fields(htab->map.record, htab_elem_value(l_new, key_size));
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb04..4e95bc085578 100644
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
@@ -1669,11 +1669,8 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	if (!READ_ONCE(async->cb))
-		return;
-
-	cb = xchg(&async->cb, NULL);
-	if (!cb)
+	cb = xchg(&async->cb, BPF_PTR_POISON);
+	if (!cb || cb == BPF_PTR_POISON)
 		return;
 
 	bpf_async_update_prog_callback(cb, NULL, NULL);
@@ -3183,7 +3180,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 		return -EINVAL;
 
 	w = READ_ONCE(async->work);
-	if (!w || !READ_ONCE(w->cb.prog))
+	if (!w || (void *)w == BPF_PTR_POISON || !READ_ONCE(w->cb.prog))
 		return -EINVAL;
 
 	if (!refcount_inc_not_zero(&w->cb.refcnt))
@@ -4267,6 +4264,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	struct bpf_task_work_ctx *ctx, *old_ctx;
 
 	ctx = READ_ONCE(twk->ctx);
+	if (ctx == BPF_PTR_POISON)
+		return ERR_PTR(-EINVAL);
 	if (ctx)
 		return ctx;
 
@@ -4285,6 +4284,8 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 		 * memory and try to reuse already set context.
 		 */
 		bpf_mem_free(&bpf_global_ma, ctx);
+		if (old_ctx == BPF_PTR_POISON)
+			return ERR_PTR(-EINVAL);
 		return old_ctx;
 	}
 
@@ -4476,7 +4477,7 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	int ret;
 
 	cb = READ_ONCE(async->cb);
-	if (!cb)
+	if (!cb || cb == BPF_PTR_POISON)
 		return -EINVAL;
 
 	/*
@@ -4517,8 +4518,8 @@ void bpf_task_work_cancel_and_free(void *val)
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

