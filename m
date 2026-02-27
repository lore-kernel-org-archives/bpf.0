Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212028726D
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232493; cv=none; b=UvTsVu29XyNgU9tSTRTF/OvKYOvjDm+iYZBF6cQhzC656pUcgj2IcFW9lze6hgQmEwxbjUSE3fEvDzfe6bEt2rFG5uTG2APzG+1tYo6RXxXtCYeqIDe113kwBnQoSx/MMM0mAAxbYZwuHtdaq7AFtajMY93DsJbziBDaXd08MKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232493; c=relaxed/simple;
	bh=i5A/zO3gYcpJtrJsDtXvpZ1k+13umceX+zAkTFbimzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSZ4g+Y+uTcqqs6moOmK66m/GT/MnqV0dCIkNde63XDebjXLPA8t5EjAXacBcgxYJAzzslyeA6LeO0OP/cNOlQbUNtoNysUa8UjlEPmzTASD58tJCJ7ObmN0tt3d1FquEN2Z3UQOsGdQ3q+yw4QPILMsVd4ldz3kU9u8uIYGB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihf5KETq; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihf5KETq"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4c543472fso3096944a34.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232490; x=1772837290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTMyO5gvKwtG6Ah3qk23h+OquNxDZU9+mi2NVJCx2hk=;
        b=ihf5KETq7zah38wmD14SKzghR6tXazZhS++FQd07OSqAnqgVyb6+Way9K1eRbwvA6q
         Wh0E4yAAMWi37fkcgJ9uzrakAgHBvo1Qn/KYRx+6aj0r4rXzuQTed3MAWFkimweUHDs3
         S0l4W1CsOjTt/YLxRp0iQzT5gWDEas+FVWOe6mqD1YWtZgs/wEfguK5gZcoBzir6BOAD
         n3xKTUVTXV/9GLRCpDfPYcEcsFQeIxXni8qGzLGLCoA3on1iotitqwvBM8Lc0ZmRWGbt
         BnDo9A4rYuJz6nTdimqMlC84TKZbAyp4GN0bXfhYGicPDtYCtS1+ZHFg3nw0ukoFSOj1
         1Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232490; x=1772837290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OTMyO5gvKwtG6Ah3qk23h+OquNxDZU9+mi2NVJCx2hk=;
        b=tEVZN/zezR9mLhGuGszszcbMdCdRK8VEy0C97naBCeqEXnzNZwp2CBOL0usQR29QQc
         YXVGDFfrg68BhAOpA59yjWCRCJ9R/vl1fYCdHe85f77xYs8ccWUpaHgSMlTaPxSIAGNS
         9mw57JUXNkzNFmPmk2p7rYk4EQIeVcjEM6BPv1/TwdzCLbRWbFKYjbEKwf4L07MSOK0w
         Ldb//BdqkqocojizQK6FY4JsMWFmcxXO0sgiNL22CPX/oHCCs2BJS+OhjiGuJ3dPPnDv
         LQNIPH2yXYzpzcUDg7/oafMw+08z77lUxzH2uHcVdA4QEMY7MI1I5gf6yneIx6TUi8Td
         mTKw==
X-Gm-Message-State: AOJu0YyovPp9nML5oCIlQ3sO1kE7U2sfGZsDMMwJQXhpAh9xDKcjX/p/
	4kEtnrqmFepUucXbkmcG47mXQOj1nlYKIenMZqfhAaj6TQLmZVXymqE0oz5RZQTP
X-Gm-Gg: ATEYQzwUnbNTJ52v98e5rmTKNMMqP8n+T2WzdeRRQxKBOQG3q+sFbd31OjSbBGsnqZ0
	w3LtXvaI6aboNO/Mij/X5yTk+7rzak0J0/thvmuBaN8SkS5rIf3V2HjrwITYyBbofD0IdDuxhK7
	xKL/tIn1dZFUq/BpefpQHq29xC+MUjaebyQINx4fryvZOuo36GZ5yWjKzcg1eG3pAM0R/WGk95q
	ap2wR/RlckE/8QnCzDBghgRePbkcs0oUepyoV9kiUCx7LvipkknHcaP3vWVgqy7s5JP3XB6CbYd
	yB3oB6icqn6BQMV49l46N6dArkU15zGwqUyY62HbwW4YQXwWiOfumq5E+Wn6CXOENTCjFr6tuoQ
	eW8AXFx82sN0jZIN3b9NMo31QjoI1KMVyRDQQrdbf/u0KSXo6j071Db8TYMyJOWcYZtzsh3J4oe
	0iFwiQvAsRlNWChqUezAufu3OhBv/OVR3xy3upC+zeZ6Q=
X-Received: by 2002:a05:6871:339a:b0:409:5e29:e899 with SMTP id 586e51a60fabf-416276ea734mr2692968fac.6.1772232489921;
        Fri, 27 Feb 2026 14:48:09 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf23977sm5542219fac.4.2026.02.27.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:09 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	syzbot@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/5] bpf: Register dtor for freeing special fields
Date: Fri, 27 Feb 2026 14:48:01 -0800
Message-ID: <20260227224806.646888-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
References: <20260227224806.646888-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12213; h=from:subject; bh=i5A/zO3gYcpJtrJsDtXvpZ1k+13umceX+zAkTFbimzg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0rrfbC5DMT2efvFuoEZLGiwwV/tgl9Li+7bbh5 mQcphD+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdKwAKCRBM4MiGSL8RymvdEA Cn+QlCu9B2WQP0atoyAnyntvfopqAbcQjIlAXKm0G7DExcn6RyiTwkZvssXiXfm89yCFrEngLqQgt8 30jggXr25M3WJWA3bbnQbJLxtUVtDekn3Z9WcpE9JX0Gz1wUtzbwypeg20D46o8a6iJlAYlFCiYDPF o+lF5Fkwn3kWilDleTjt39Iz1gfYJMSx2At/TiJFqAXTdRp2qUbJ2RAglpOjuxaBpyCEZc5oycvXFJ DlvUrRdTjZDPGwRKCooqFpEwpj9o9kVYFfB1DYNb0DEZRhlZbXWHkX/ozpkXVXOe/UN+lXgNAHRema gtSr7UE6p1MIwb2nEl9p04wECtTJqzJrJ+dbtI9KnSbd45Oo9CSLVuGm4QQJQY6c8uhCZInyOOnjNv LN5pha/XfTFU6ARnitQgcMZLBCwMoXI0WbE/wAB+h0gK+HNj1dLjtuur5MAa+gw6qayRAObp72aJJK cxeu6XR9ny3d2i8XUNw2GvSWuJHT/J1QSEkDfwoo2VTCVCr25cT7oO8mD+Ygq8yEz9J9HmhwezoIYO BI+8AaUG4DOElPDCclB0wD1kah2JBo5w/4nSt7S6tC0jy+LO9Fa64LWyLEmk6h4KAjZpy2G68gs0Ox 218jdVP9d5KUKlmP53tTUQdy9FYdfx9lnShvta7Acgj15wKUnb5OwJL4U49g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There is a race window where BPF hash map elements can leak special
fields if the program with access to the map value recreates these
special fields between the check_and_free_fields done on the map value
and its eventual return to the memory allocator.

Several ways were explored prior to this patch, most notably [0] tried
to use a poison value to reject attempts to recreate special fields for
map values that have been logically deleted but still accessible to BPF
programs (either while sitting in the free list or when reused). While
this approach works well for task work, timers, wq, etc., it is harder
to apply the idea to kptrs, which have a similar race and failure mode.

Instead, we change bpf_mem_alloc to allow registering destructor for
allocated elements, such that when they are returned to the allocator,
any special fields created while they were accessible to programs in the
mean time will be freed. If these values get reused, we do not free the
fields again before handing the element back. The special fields thus
may remain initialized while the map value sits in a free list.

When bpf_mem_alloc is retired in the future, a similar concept can be
introduced to kmalloc_nolock-backed kmem_cache, paired with the existing
idea of a constructor.

Note that the destructor registration happens in map_check_btf, after
the BTF record is populated and (at that point) avaiable for inspection
and duplication. Duplication is necessary since the freeing of embedded
bpf_mem_alloc can be decoupled from actual map lifetime due to logic
introduced to reduce the cost of rcu_barrier()s in mem alloc free path in
9f2c6e96c65e ("bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.").

As such, once all callbacks are done, we must also free the duplicated
record. To remove dependency on the bpf_map itself, also stash the key
size of the map to obtain value from htab_elem long after the map is
gone.

  [0]: https://lore.kernel.org/bpf/20260216131341.1285427-1-mykyta.yatsenko5@gmail.com

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_mem_alloc.h |  6 +++
 kernel/bpf/hashtab.c          | 87 +++++++++++++++++++++++++++++++++++
 kernel/bpf/memalloc.c         | 58 ++++++++++++++++++-----
 3 files changed, 140 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index e45162ef59bb..4ce0d27f8ea2 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,6 +14,8 @@ struct bpf_mem_alloc {
 	struct obj_cgroup *objcg;
 	bool percpu;
 	struct work_struct work;
+	void (*dtor_ctx_free)(void *ctx);
+	void *dtor_ctx;
 };
 
 /* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
@@ -32,6 +34,10 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 /* The percpu allocation with a specific unit size. */
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
+void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma,
+			    void (*dtor)(void *obj, void *ctx),
+			    void (*dtor_ctx_free)(void *ctx),
+			    void *ctx);
 
 /* Check the allocation size for kmalloc equivalent allocator */
 int bpf_mem_alloc_check_size(bool percpu, size_t size);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3b9d297a53be..582f0192b7e1 100644
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
@@ -457,6 +462,84 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+static void htab_mem_dtor(void *obj, void *ctx)
+{
+	struct htab_btf_record *hrec = ctx;
+	struct htab_elem *elem = obj;
+	void *map_value;
+
+	if (IS_ERR_OR_NULL(hrec->record))
+		return;
+
+	map_value = htab_elem_value(elem, hrec->key_size);
+	bpf_obj_free_fields(hrec->record, map_value);
+}
+
+static void htab_pcpu_mem_dtor(void *obj, void *ctx)
+{
+	void __percpu *pptr = *(void __percpu **)obj;
+	struct htab_btf_record *hrec = ctx;
+	int cpu;
+
+	if (IS_ERR_OR_NULL(hrec->record))
+		return;
+
+	for_each_possible_cpu(cpu)
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
+}
+
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -2281,6 +2364,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2303,6 +2387,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2482,6 +2567,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
@@ -2502,6 +2588,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
+	.map_check_btf = htab_map_check_btf,
 	.map_mem_usage = htab_map_mem_usage,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..682a9f34214b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -102,6 +102,8 @@ struct bpf_mem_cache {
 	int percpu_size;
 	bool draining;
 	struct bpf_mem_cache *tgt;
+	void (*dtor)(void *obj, void *ctx);
+	void *dtor_ctx;
 
 	/* list of objects to be freed after RCU GP */
 	struct llist_head free_by_rcu;
@@ -260,12 +262,14 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }
 
-static int free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
 	int cnt = 0;
 
 	llist_for_each_safe(pos, t, llnode) {
+		if (c->dtor)
+			c->dtor((void *)pos + LLIST_NODE_SZ, c->dtor_ctx);
 		free_one(pos, percpu);
 		cnt++;
 	}
@@ -276,7 +280,7 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -308,7 +312,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
 			llnode = llist_del_all(&c->free_by_rcu_ttrace);
-			free_all(llnode, !!c->percpu_size);
+			free_all(c, llnode, !!c->percpu_size);
 		}
 		return;
 	}
@@ -417,7 +421,7 @@ static void check_free_by_rcu(struct bpf_mem_cache *c)
 	dec_active(c, &flags);
 
 	if (unlikely(READ_ONCE(c->draining))) {
-		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
+		free_all(c, llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
 		atomic_set(&c->call_rcu_in_progress, 0);
 	} else {
 		call_rcu_hurry(&c->rcu, __free_by_rcu);
@@ -635,13 +639,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
-	free_all(__llist_del_all(&c->free_llist), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra), percpu);
-	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
+	free_all(c, __llist_del_all(&c->free_llist), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
+	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);
+	free_all(c, __llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(c, llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void check_mem_cache(struct bpf_mem_cache *c)
@@ -680,6 +684,9 @@ static void check_leaked_objs(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 {
+	/* We can free dtor ctx only once all callbacks are done using it. */
+	if (ma->dtor_ctx_free)
+		ma->dtor_ctx_free(ma->dtor_ctx);
 	check_leaked_objs(ma);
 	free_percpu(ma->cache);
 	free_percpu(ma->caches);
@@ -1014,3 +1021,32 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
 
 	return 0;
 }
+
+void bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma, void (*dtor)(void *obj, void *ctx),
+			    void (*dtor_ctx_free)(void *ctx), void *ctx)
+{
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	int cpu, i;
+
+	ma->dtor_ctx_free = dtor_ctx_free;
+	ma->dtor_ctx = ctx;
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
+}
-- 
2.47.3

