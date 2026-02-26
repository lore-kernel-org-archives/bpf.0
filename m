Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394C3C1960
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130520; cv=none; b=u5Ejv33H1Wdftxt5dO3YRGt7Wy8fbUcz1ZEMiQK3J36cBF12RoObJcQycfcF25JvJ/ErPwXI+HtufC9Zs1B1gb1Y00Wf5ef5r6gHZdlgo+5tlkq4PcJz5KmonL9vj+oz0uoIMeIvgKn8nVRKbg/W7vVpaI3KUdz4TfELPQ6XIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130520; c=relaxed/simple;
	bh=QYDLkInPaOcYdAtacg/WegSi4gSEJGz39eDF9qSdIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDoJj4SGbrx8iVxRfOa6+457MVPdaBJSAON8SrTVJ9XK5OU0CDnHgwud0NXaJnXLM8XAWFSG43D8aLeyAlIdczW2/f6KpznyUP4Y7rbUzgtZZgX9HUsGtk6fsKKClt250Ctn+NotipClubA0USc50m4eQVQD75Rwlx14vq3QcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0owlu8g; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0owlu8g"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso843118a34.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772130517; x=1772735317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKYTSFmtw80wTVsBpOFN5+4IrXmRYVRJssazrTN3ByY=;
        b=i0owlu8gAbDxmcsM0K2uaWLdXAXIuQrWi04AJ4nxc7jrXKMZaX7SiIw7mrAswOfWpM
         QqP5mHAd2vibnvdqwrhLJ7apptWvRWFoggiK4OsBOsuGIG+DZuAKjR255bc11RhjQIqR
         dpYrsziWtcimjItX7xF09mBxxE2yT+p48rBV9iHu4bIr+KOMh6vXTWp2Rl00J3FC8vqj
         C0ZxEZ4F98RKODn6JKQCAygP0ycysFb9x1hR9wiwj0M8NLXKigy5SJceD+0hWmscFLVn
         KjH/RdR3MHXXjCCv84gW/3YNiLwL6fXG0xFQDMC96uV3YSDhi17DS2OqiCyu/5QZ/aMV
         DJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130517; x=1772735317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKYTSFmtw80wTVsBpOFN5+4IrXmRYVRJssazrTN3ByY=;
        b=R/A9jGLedhKBZ1b+j9zrI8wm07ZLCD5l/UbjLd92yJVhfQf4PjCdkhrMZCQodvr0AJ
         pjKggjU7nEtGLoCkvN79AEt4GJqEUpBQePoksiOs9NBXoKm5AQj86wd8gcH6pnqPgyaw
         wNyX7Uk9EpmF+8lr1oBPgFhAN9x1VO28SZACIS10R+x+Yi2Fw6LXxntdetrwyPdLvBx4
         WWvTrvAZzENjZjPbnlmrL5mrf/cLTJIEMhASCahf0LM+iAc+RAZRvDgR20iVqbmEhIPq
         EpJPC5URtMxE3+M2vNP6NAYVfVv0lBmdyTrVmuLfUm75N9zNGJhLiKnV17mGzoNNBVd2
         M3jA==
X-Forwarded-Encrypted: i=1; AJvYcCXS6rYk9vHrLOvdvTj3h8gJCIBTMGUfMiiHXr+QsMoE3NvMplEmZHTI8JkdO35ZHfcwN7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNiEt8z7OABHxnLbGOSR9avgtIeKtZ5ftt+W0aKeutGCRCQej
	odV+SLLDe/bxbQAaScka4uWgMMG+LyjX+CU7YZ3/5yxtZ6woHbNb0fA2
X-Gm-Gg: ATEYQzwC+sdYseL5VmXuxmWeOrrhuIXbbK1ir7xsMvpXfTZ+xHaygTBU1SGOC9MwcqO
	vi/VB5YllCCogDK7TNyEU/vedPfhUNe+AlpDF3b9jmzxEW1psjcqKcpJTHaCUugSjuBe+WjzKiH
	lQfhZP34NUYCE7nkw6ZZdAWnUI6hMw+6KhyYNMyxXgGrDDQdO6KLhDHKJz6UUY3nGTqTSBuMaoY
	vAvVVp06TS96XWYcWV6gf8j1B91SF1n5f6NvHQxXEv/HalAP792+YUgebd78d7tlodsbNHERusD
	U9FNT6S665poeXpu5ejOZsMC391ZaO87c2PKZKH1JZPcMWe3MjB4uI53PrkaHMfPviNlw+VJrYA
	hCngdSGZHqzZQFfc+e8wTKd72FC354B9Q4uqhZK4M4+QaHeVePCrIeNK2/M6WODm4wE7rm1LnQ6
	qDsdzCnYHMQGOirroWw/R9WnoH1whEUOMVI6zVR0gAPdmd
X-Received: by 2002:a05:6871:7424:b0:409:71aa:aa90 with SMTP id 586e51a60fabf-41626b17ae9mr122501fac.0.1772130516945;
        Thu, 26 Feb 2026 10:28:36 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d45fsm2692339fac.14.2026.02.26.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:28:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: syzbot+ci3826af8b4f91bf97@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kernel-team@meta.com,
	kkd@meta.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	paulmck@kernel.org,
	syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	yatsenko@meta.com
Subject: [syzbot ci] Re: Close race in freeing special fields and map value
Date: Thu, 26 Feb 2026 10:28:22 -0800
Message-ID: <20260226182822.1734308-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <69a01309.050a0220.2fcbed.0007.GAE@google.com>
References: <69a01309.050a0220.2fcbed.0007.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test:

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 7517eaf94ac9..4ce0d27f8ea2 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,7 +14,7 @@ struct bpf_mem_alloc {
 	struct obj_cgroup *objcg;
 	bool percpu;
 	struct work_struct work;
-	void (*dtor)(void *obj, void *ctx);
+	void (*dtor_ctx_free)(void *ctx);
 	void *dtor_ctx;
 };

@@ -35,7 +35,9 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma,
-			    void (*dtor)(void *obj, void *ctx), void *ctx);
+			    void (*dtor)(void *obj, void *ctx),
+			    void (*dtor_ctx_free)(void *ctx),
+			    void *ctx);

 /* Check the allocation size for kmalloc equivalent allocator */
 int bpf_mem_alloc_check_size(bool percpu, size_t size);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 74f7a6f44c50..582f0192b7e1 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -125,6 +125,11 @@ struct htab_elem {
 	char key[] __aligned(8);
 };

+struct htab_btf_record {
+	struct btf_record *record;
+	u32 key_size;
+};
+
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 {
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
@@ -459,28 +464,80 @@ static int htab_map_alloc_check(union bpf_attr *attr)

 static void htab_mem_dtor(void *obj, void *ctx)
 {
-	struct bpf_htab *htab = ctx;
+	struct htab_btf_record *hrec = ctx;
 	struct htab_elem *elem = obj;
 	void *map_value;

-	if (IS_ERR_OR_NULL(htab->map.record))
+	if (IS_ERR_OR_NULL(hrec->record))
 		return;

-	map_value = htab_elem_value(elem, htab->map.key_size);
-	bpf_obj_free_fields(htab->map.record, map_value);
+	map_value = htab_elem_value(elem, hrec->key_size);
+	bpf_obj_free_fields(hrec->record, map_value);
 }

 static void htab_pcpu_mem_dtor(void *obj, void *ctx)
 {
-	struct bpf_htab *htab = ctx;
 	void __percpu *pptr = *(void __percpu **)obj;
+	struct htab_btf_record *hrec = ctx;
 	int cpu;

-	if (IS_ERR_OR_NULL(htab->map.record))
+	if (IS_ERR_OR_NULL(hrec->record))
 		return;

 	for_each_possible_cpu(cpu)
-		bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+		bpf_obj_free_fields(hrec->record, per_cpu_ptr(pptr, cpu));
+}
+
+static void htab_dtor_ctx_free(void *ctx)
+{
+	struct htab_btf_record *hrec = ctx;
+
+	btf_record_free(hrec->record);
+	kfree(ctx);
+}
+
+static int htab_set_dtor(const struct bpf_htab *htab, void (*dtor)(void *, void *))
+{
+	u32 key_size = htab->map.key_size;
+	const struct bpf_mem_alloc *ma;
+	struct htab_btf_record *hrec;
+	int err;
+
+	/* No need for dtors. */
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return 0;
+
+	hrec = kzalloc(sizeof(*hrec), GFP_KERNEL);
+	if (!hrec)
+		return -ENOMEM;
+	hrec->key_size = key_size;
+	hrec->record = btf_record_dup(htab->map.record);
+	if (IS_ERR(hrec->record)) {
+		err = PTR_ERR(hrec->record);
+		kfree(hrec);
+		return err;
+	}
+	ma = htab_is_percpu(htab) ? &htab->pcpu_ma : &htab->ma;
+	/* Kinda sad, but cast away const-ness since we change ma->dtor. */
+	bpf_mem_alloc_set_dtor((struct bpf_mem_alloc *)ma, dtor, htab_dtor_ctx_free, hrec);
+	return 0;
+}
+
+static int htab_map_check_btf(const struct bpf_map *map, const struct btf *btf,
+			      const struct btf_type *key_type, const struct btf_type *value_type)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	if (htab_is_prealloc(htab))
+		return 0;
+	/*
+	 * We must set the dtor using this callback, as map's BTF record is not
+	 * populated in htab_map_alloc(), so it will always appear as NULL.
+	 */
+	if (htab_is_percpu(htab))
+		return htab_set_dtor(htab, htab_pcpu_mem_dtor);
+	else
+		return htab_set_dtor(htab, htab_mem_dtor);
 }

 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
@@ -595,17 +652,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 						 round_up(htab->map.value_size, 8), true);
 			if (err)
 				goto free_map_locked;
-			/* See comment below */
-			bpf_mem_alloc_set_dtor(&htab->pcpu_ma, htab_pcpu_mem_dtor, htab);
-		} else {
-			/*
-			 * Register the dtor unconditionally.  map->record is
-			 * set by map_create() after map_alloc() returns, so it
-			 * is always NULL at this point.  The dtor checks
-			 * IS_ERR_OR_NULL(htab->map.record) and becomes a no-op
-			 * for maps without special fields.
-			 */
-			bpf_mem_alloc_set_dtor(&htab->ma, htab_mem_dtor, htab);
 		}
 	}

@@ -2318,6 +2364,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2340,6 +2387,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2519,6 +2567,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2539,6 +2588,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 137e855c718b..682a9f34214b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -102,7 +102,8 @@ struct bpf_mem_cache {
 	int percpu_size;
 	bool draining;
 	struct bpf_mem_cache *tgt;
-	struct bpf_mem_alloc *ma;
+	void (*dtor)(void *obj, void *ctx);
+	void *dtor_ctx;

 	/* list of objects to be freed after RCU GP */
 	struct llist_head free_by_rcu;
@@ -261,15 +262,14 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }

-static int free_all(struct llist_node *llnode, bool percpu,
-		    struct bpf_mem_alloc *ma)
+static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
 	int cnt = 0;

 	llist_for_each_safe(pos, t, llnode) {
-		if (ma->dtor)
-			ma->dtor((void *)pos + LLIST_NODE_SZ, ma->dtor_ctx);
+		if (c->dtor)
+			c->dtor((void *)pos + LLIST_NODE_SZ, c->dtor_ctx);
 		free_one(pos, percpu);
 		cnt++;
 	}
@@ -280,7 +280,7 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);

-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size, c->ma);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }

@@ -312,7 +312,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
 			llnode = llist_del_all(&c->free_by_rcu_ttrace);
-			free_all(llnode, !!c->percpu_size, c->ma);
+			free_all(c, llnode, !!c->percpu_size);
 		}
 		return;
 	}
@@ -421,7 +421,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 	dec_active(c, &flags);

 	if (unlikely(READ_ONCE(c->draining))) {
-		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size, c->ma);
+		free_all(c, llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 		atomic_set(&c->call_rcu_in_progress, 0);
 	} else {
 		call_rcu_hurry(&c->rcu, __free_by_rcu);
@@ -546,7 +546,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
-			c->ma = ma;
 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
 		}
@@ -569,7 +568,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->tgt = c;
-			c->ma = ma;

 			init_refill_work(c);
 			prefill_mem_cache(c, cpu);
@@ -622,7 +620,6 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 		c->objcg = objcg;
 		c->percpu_size = percpu_size;
 		c->tgt = c;
-		c->ma = ma;

 		init_refill_work(c);
 		prefill_mem_cache(c, cpu);
@@ -631,7 +628,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 	return 0;
 }

-static void drain_mem_cache(struct bpf_mem_cache *c, struct bpf_mem_alloc *ma)
+static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu = !!c->percpu_size;

@@ -642,13 +639,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c, struct bpf_mem_alloc *ma)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu, ma);
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu, ma);
-	free_all(__llist_del_all(&c->free_llist), percpu, ma);
-	free_all(__llist_del_all(&c->free_llist_extra), percpu, ma);
-	free_all(__llist_del_all(&c->free_by_rcu), percpu, ma);
-	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu, ma);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu, ma);
+	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
+	free_all(c, __llist_del_all(&c->free_llist), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
+	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp), percpu);
 }

 static void check_mem_cache(struct bpf_mem_cache *c)
@@ -687,6 +684,9 @@ static void check_leaked_objs(struct bpf_mem_alloc *ma)

 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 {
+	/* We can free dtor ctx only once all callbacks are done using it. */
+	if (ma->dtor_ctx_free)
+		ma->dtor_ctx_free(ma->dtor_ctx);
 	check_leaked_objs(ma);
 	free_percpu(ma->cache);
 	free_percpu(ma->caches);
@@ -758,7 +758,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			c = per_cpu_ptr(ma->cache, cpu);
 			WRITE_ONCE(c->draining, true);
 			irq_work_sync(&c->refill_work);
-			drain_mem_cache(c, ma);
+			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
@@ -773,7 +773,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				WRITE_ONCE(c->draining, true);
 				irq_work_sync(&c->refill_work);
-				drain_mem_cache(c, ma);
+				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
@@ -1022,9 +1022,31 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
 	return 0;
 }

-void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma,
-			    void (*dtor)(void *obj, void *ctx), void *ctx)
+void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma, void (*dtor)(void *obj, void *ctx),
+			    void (*dtor_ctx_free)(void *ctx), void *ctx)
 {
-	ma->dtor = dtor;
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	int cpu, i;
+
+	ma->dtor_ctx_free = dtor_ctx_free;
 	ma->dtor_ctx = ctx;
+
+	if (ma->cache) {
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			c->dtor = dtor;
+			c->dtor_ctx = ctx;
+		}
+	}
+	if (ma->caches) {
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				c->dtor = dtor;
+				c->dtor_ctx = ctx;
+			}
+		}
+	}
 }
