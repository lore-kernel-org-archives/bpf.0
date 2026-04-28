Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E63CF05C
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407288; cv=none; b=Q9e60AvzrGdOJFjmLT5GiiOSCA2Vg1lC2zQGsIcFU+3Fmbc1nLi2HkyZuF84ImE9ZrtR0qHlG5SSbKfuD5QZQt2aysBFKl8ungMfamBVTwXw/bbaehc0F39eZ1ltyybg1DWM+3K0qKxZnNugvyYmt4je34yJdL6q8OqecGGUWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407288; c=relaxed/simple;
	bh=s11elbOmmWbgLkPscqKFhPlCvBvYL61h4NbQZm++E3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSwTP89ry4uwyPyaFckze9u6MUxkaj1jZGYkB7fr5WgL5W9uqpFo6hHBF5LW091wdAjJX9u5eYpQ3JAOVsfjYvAx6lDztILLj2dx/swggI+/39dOCjySr5LSg1K6EzP4n1NHnOlZu6iMyK+hp3p/CIuX7dtXJRDom/8pO2dzDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du5IhJcB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du5IhJcB"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79827d28fc4so119830287b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407285; x=1778012085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7C2p62ej3x7acXzZsIkVlCc2slHtuqq0OJeK8NTK0I=;
        b=Du5IhJcB28I9CSxdByqmmMJj3f37RESOThufSwCsRP0WlAj1hqm2H2ZanHjnL1Ex/+
         D2K0qjbLTinvW9Zmrk/rt2CaZeQc/QMrc3Fjf9idOzSxqFx/ShkaIM7ubD/xn9zLMmF8
         AJufhOeG7/B8jgCCLBdTs8Q3SgoX30NooDw8T2TQiN695YlYhwJejW2iAR8/4E7p/NFe
         1m8YUQZiinqKk7n05cev0IDDw2BltmM9eO3i9AKHu1UpndVa1pjluk+w0RFOPqdSIrJv
         YYKBCMBgZQfx6eoCr35sw8gH11jfO4moX2eUl7h/t9L2wJKRX76jmqa8BZgVXD5LMRyx
         oAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407285; x=1778012085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7C2p62ej3x7acXzZsIkVlCc2slHtuqq0OJeK8NTK0I=;
        b=ELXWaQqrSCzOoYjpoNePr176h0IK8S3R/BzZR0teabzRjpvbzKolKG9wGdeNPDJFxd
         3vmFGo4mN0/j4GJ6xscowJM2cSCXJZ4+5/hCrYxhkANgRzyLxZ1XYbG9eIV1QiZTvDIv
         gUUvHhztn7o0xMqZPd89Nl8xBygCelcBFlQdDSRWwnja68QLV8U3AZjYSvyBsFpAhzv0
         iFzwStz7/kKL0WT6yJbqbke1p3JiFyuOEWbh7wZnnXD+6fiK6QKwdC0W1e0Uu0Lzl0pD
         SlYTN0nP4hAjYxaQOoFbB83aJYw+t1isg3bpOn46vrNchiVBPYcu4Y2Nq9FH9Hqq9pjY
         ufQg==
X-Forwarded-Encrypted: i=1; AFNElJ/WGLDTZETCL8HBhyUp2hmJJZFLpw0A0NPgzu0+d5gje3x4cvaGqqK37EWdIX3HsQCNosw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgtB1uVgdPdqGAiv7Pd/gC9MIut8ceNOP2SlawFogBwQD7sdV
	Ig2qz5T7saGUP4zix3Rd4ssIY4HE+pemYEkuj35FCQL9q91VVVIhDIxr
X-Gm-Gg: AeBDievFnMb3teZ4aQhRBw98aEhkjLmPigabluKtoatRF9u9d6j/Y59939FFWhB9H7W
	PXafpBlucXIfUh9VvzZJENcdOoaxZd2iVBc5eVCHA4pG12dD5LtPKfPVeQ83OBb8iNBUhIEvPEM
	C5pXhoTFB77LXLMf1KCnlUMJcz8aGE6mGWwb8pXOon9lN22K4dz5QXOPvUGuTLUXlO+ggTtt8ZM
	Oyp/p2mqCzbu5Sln7tNfKVRRX00efj0v926dgrHLw9SgatKyWyxmbtgjWa+5DZGIvgjXzKqPQVJ
	FQZXgZOWfnwltcfTibWDd+OQswhsNEYqn3k3LX4J0QsakTce2mjasHk7acU4fJeY5lcROCQDQVz
	Uohkjz+VYSdWRSSsERUnTEWHWp92yRePfjDrdowzOYh0XaGqdqLbQrV5CM6+JKk8du5hR9aYo11
	9XqbPjLG9y6YQYdojs5ay1ensjFfyLxXUo6+3wG7tu50/j3U5Lgq3+gPirh1kESjnO4HHmWf9HF
	AdJdH4GrLA=
X-Received: by 2002:a05:690c:e3cd:b0:7b2:1bf1:800d with SMTP id 00721157ae682-7bcf4fbe2c3mr48359857b3.4.1777407284696;
        Tue, 28 Apr 2026 13:14:44 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4c60:c627:eabb:73c3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25af5385sm1392077b3.48.2026.04.28.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:14:44 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 3/4] bpf: Fix deadlock in kptr dtor in nmi
Date: Tue, 28 Apr 2026 16:14:21 -0400
Message-ID: <20260428201422.1518903-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428201422.1518903-1-utilityemal77@gmail.com>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defer freeing of referenced kptrs using irq_work queue.

This fixes a deadlock in BPF tracing programs running under NMI.

Each kptr is tagged with an auxiliary data field storing an llist_node
and a pointer to the object to be freed. These are assembled together
to form a queue for deletion outside NMI.

Add a field to each data structure capable of holding referenced kptrs
to store the llist_head, as well as an irq_work struct to the btf kptr
field to store the task callback.

The llist_nodes are linked in the queue safely, allowing them to be torn
down once NMI is over.

This irq_work struct is foribly synchronized on btf teardown, enabled by
the change in btf cleanup code introduced in the previous commit, adding
the rcu_work teardown.

At dtor time, if the execution is in an nmi context, enqueue the
referenced kptr nodes in the llist_head and enqueue a job to drain the
list, calling the respective dtor callback from a safe context.

If running outside nmi, use synchronous dtor path.

This touches arraymap, hashtab, and bpf local storage. It's important to
note however, that the bpf_local_storage code rejects nmi updates
already, the code changes in that case are just to accommodate the changes
to the record extending the kptr.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Reported-by: Justin Suess <utilityemal77@gmail.com>
Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/bpf.h            |  69 ++++++++++++
 kernel/bpf/arraymap.c          |  36 ++++++-
 kernel/bpf/bpf_local_storage.c |  13 ++-
 kernel/bpf/btf.c               |   6 +-
 kernel/bpf/hashtab.c           | 181 +++++++++++++++++++++++++++----
 kernel/bpf/syscall.c           | 190 +++++++++++++++++++++++++++++++--
 6 files changed, 456 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 715b6df9c403..037bdadbed96 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -9,6 +9,8 @@
 
 #include <crypto/sha2.h>
 #include <linux/workqueue.h>
+#include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/file.h>
 #include <linux/percpu.h>
 #include <linux/err.h>
@@ -234,6 +236,10 @@ struct btf_field_kptr {
 	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
 	 */
 	btf_dtor_kfunc_t dtor;
+	struct irq_work irq_work;
+	struct llist_head irq_work_items;
+	struct llist_head free_list;
+	u32 aux_off;
 	u32 btf_id;
 };
 
@@ -257,6 +263,7 @@ struct btf_field {
 struct btf_record {
 	u32 cnt;
 	u32 field_mask;
+	u32 kptr_ref_aux_size;
 	int spin_lock_off;
 	int res_spin_lock_off;
 	int timer_off;
@@ -266,6 +273,67 @@ struct btf_record {
 	struct btf_field fields[];
 };
 
+struct bpf_kptr_dtor_aux {
+	struct llist_node node;
+	void *ptr;
+};
+
+static inline struct bpf_kptr_dtor_aux *
+bpf_kptr_ref_aux(const struct btf_field *field, void *value)
+{
+	return value + field->kptr.aux_off;
+}
+
+static inline void bpf_kptr_aux_init_field(struct btf_field *field, u32 *aux_off)
+{
+	if (field->type != BPF_KPTR_REF)
+		return;
+
+	field->kptr.aux_off = *aux_off;
+	*aux_off += sizeof(struct bpf_kptr_dtor_aux);
+}
+
+static inline void bpf_kptr_aux_init_value(const struct btf_record *rec, void *value)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec) || !rec->kptr_ref_aux_size)
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		struct bpf_kptr_dtor_aux *aux;
+
+		if (rec->fields[i].type != BPF_KPTR_REF)
+			continue;
+
+		aux = bpf_kptr_ref_aux(&rec->fields[i], value);
+		init_llist_node(&aux->node);
+		aux->ptr = NULL;
+	}
+}
+
+static inline bool bpf_kptr_ref_has_deferred_dtor(const struct btf_record *rec,
+						  void *value)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec) || !rec->kptr_ref_aux_size)
+		return false;
+
+	for (i = 0; i < rec->cnt; i++) {
+		struct bpf_kptr_dtor_aux *aux;
+
+		if (rec->fields[i].type != BPF_KPTR_REF)
+			continue;
+
+		aux = bpf_kptr_ref_aux(&rec->fields[i], value);
+		if (READ_ONCE(aux->ptr))
+			return true;
+	}
+
+	return false;
+}
+
 /* Non-opaque version of bpf_rb_node in uapi/linux/bpf.h */
 struct bpf_rb_node_kern {
 	struct rb_node rb_node;
@@ -2602,6 +2670,7 @@ void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
 void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
+int bpf_map_attr_ref_kptr_aux_size(const union bpf_attr *attr);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 5e25e0353509..919861b553c2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -54,6 +54,7 @@ int array_map_alloc_check(union bpf_attr *attr)
 {
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	int numa_node = bpf_map_attr_numa_node(attr);
+	int aux_size;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
@@ -74,8 +75,12 @@ int array_map_alloc_check(union bpf_attr *attr)
 	/* avoid overflow on round_up(map->value_size) */
 	if (attr->value_size > INT_MAX)
 		return -E2BIG;
+	aux_size = bpf_map_attr_ref_kptr_aux_size(attr);
+	if (aux_size < 0)
+		return aux_size;
 	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
-	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+	if (percpu &&
+	    round_up(attr->value_size, 8) + aux_size > PCPU_MIN_UNIT_SIZE)
 		return -E2BIG;
 
 	return 0;
@@ -89,8 +94,13 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	bool bypass_spec_v1 = bpf_bypass_spec_v1(NULL);
 	u64 array_size, mask64;
 	struct bpf_array *array;
+	int aux_size;
 
 	elem_size = round_up(attr->value_size, 8);
+	aux_size = bpf_map_attr_ref_kptr_aux_size(attr);
+	if (aux_size < 0)
+		return ERR_PTR(aux_size);
+	elem_size += aux_size;
 
 	max_entries = attr->max_entries;
 
@@ -205,7 +215,7 @@ static int array_map_direct_value_meta(const struct bpf_map *map, u64 imm,
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u64 base = (unsigned long)array->value;
-	u64 range = array->elem_size;
+	u64 range = map->value_size;
 
 	if (map->max_entries != 1)
 		return -ENOTSUPP;
@@ -553,6 +563,9 @@ static int array_map_check_btf(struct bpf_map *map,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
 {
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	int i;
+
 	/* One exception for keyless BTF: .bss/.data/.rodata map */
 	if (btf_type_is_void(key_type)) {
 		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
@@ -572,6 +585,25 @@ static int array_map_check_btf(struct bpf_map *map,
 	if (!btf_type_is_i32(key_type))
 		return -EINVAL;
 
+	if (!IS_ERR_OR_NULL(map->record) && map->record->kptr_ref_aux_size) {
+		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+			for (i = 0; i < array->map.max_entries; i++) {
+				void __percpu *pptr =
+					array->pptrs[i & array->index_mask];
+				int cpu;
+
+				for_each_possible_cpu(cpu)
+					bpf_kptr_aux_init_value(
+						map->record,
+						per_cpu_ptr(pptr, cpu));
+			}
+		} else {
+			for (i = 0; i < array->map.max_entries; i++)
+				bpf_kptr_aux_init_value(map->record,
+							array_map_elem_ptr(array, i));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6fc6a4b672b5..8b0be9612f20 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -81,6 +81,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 		atomic_set(&selem->state, 0);
+		bpf_kptr_aux_init_value(smap->map.record, SDATA(selem)->data);
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -800,14 +801,20 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-				   sdata.data[attr->value_size]);
+	smap->elem_size = offsetof(
+		struct bpf_local_storage_elem,
+		sdata.data[attr->value_size]);
+	err = bpf_map_attr_ref_kptr_aux_size(attr);
+	if (err < 0)
+		goto free_buckets;
+	smap->elem_size += err;
 
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
 
-free_smap:
+free_buckets:
 	kvfree(smap->buckets);
+free_smap:
 	bpf_map_area_free(smap);
 	return ERR_PTR(err);
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2b0511663319..a82a52aa7293 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4074,7 +4074,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 				    u32 field_mask, u32 value_size)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
-	u32 next_off = 0, field_type_size;
+	u32 next_off = 0, value_data_size, aux_off, field_type_size;
 	struct btf_record *rec;
 	int ret, i, cnt;
 
@@ -4098,6 +4098,8 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
 	rec->task_work_off = -EINVAL;
+	value_data_size = round_up(value_size, 8);
+	aux_off = value_data_size;
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4171,8 +4173,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			ret = -EFAULT;
 			goto end;
 		}
+		bpf_kptr_aux_init_field(&rec->fields[i], &aux_off);
 		rec->cnt++;
 	}
+	rec->kptr_ref_aux_size = aux_off - value_data_size;
 
 	if (rec->spin_lock_off >= 0 && rec->res_spin_lock_off >= 0) {
 		ret = -EINVAL;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4..c3ad371948c3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -86,6 +86,8 @@ struct bpf_htab {
 	struct bpf_map map;
 	struct bpf_mem_alloc ma;
 	struct bpf_mem_alloc pcpu_ma;
+	struct irq_work nmi_free_irq_work;
+	struct llist_head nmi_free_elems;
 	struct bucket *buckets;
 	void *elems;
 	union {
@@ -100,6 +102,7 @@ struct bpf_htab {
 	atomic_t count;
 	bool use_percpu_counter;
 	u32 n_buckets;	/* number of hash buckets */
+	u32 kptr_ref_aux_size;
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
 };
@@ -130,6 +133,8 @@ struct htab_btf_record {
 	u32 key_size;
 };
 
+static void htab_nmi_free_irq_work(struct irq_work *work);
+
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 {
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
@@ -328,7 +333,8 @@ static int prealloc_init(struct bpf_htab *htab)
 		goto skip_percpu_elems;
 
 	for (i = 0; i < num_entries; i++) {
-		u32 size = round_up(htab->map.value_size, 8);
+		u32 size = round_up(htab->map.value_size, 8) +
+			   htab->kptr_ref_aux_size;
 		void __percpu *pptr;
 
 		pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
@@ -419,6 +425,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
+	int aux_size;
 
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
@@ -447,8 +454,12 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	    attr->value_size == 0)
 		return -EINVAL;
 
-	if ((u64)attr->key_size + attr->value_size >= KMALLOC_MAX_SIZE -
-	   sizeof(struct htab_elem))
+	aux_size = bpf_map_attr_ref_kptr_aux_size(attr);
+	if (aux_size < 0)
+		return aux_size;
+
+	if ((u64)attr->key_size + round_up(attr->value_size, 8) + aux_size >=
+	    KMALLOC_MAX_SIZE - sizeof(struct htab_elem))
 		/* if key_size + value_size is bigger, the user space won't be
 		 * able to access the elements via bpf syscall. This check
 		 * also makes sure that the elem_size doesn't overflow and it's
@@ -456,7 +467,8 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 */
 		return -E2BIG;
 	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
-	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+	if (percpu &&
+	    round_up(attr->value_size, 8) + aux_size > PCPU_MIN_UNIT_SIZE)
 		return -E2BIG;
 
 	return 0;
@@ -526,6 +538,33 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 			      const struct btf_type *key_type, const struct btf_type *value_type)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	u32 num_entries = htab->map.max_entries;
+	int i;
+
+	if (htab_is_prealloc(htab) && !IS_ERR_OR_NULL(map->record) &&
+	    map->record->kptr_ref_aux_size) {
+		if (htab_has_extra_elems(htab))
+			num_entries += num_possible_cpus();
+		for (i = 0; i < num_entries; i++) {
+			struct htab_elem *elem = get_htab_elem(htab, i);
+
+			if (htab_is_percpu(htab)) {
+				void __percpu *pptr = htab_elem_get_ptr(
+					elem, htab->map.key_size);
+				int cpu;
+
+				for_each_possible_cpu(cpu)
+					bpf_kptr_aux_init_value(
+						map->record,
+						per_cpu_ptr(pptr, cpu));
+			} else {
+				void *value = htab_elem_value(
+					elem, htab->map.key_size);
+
+				bpf_kptr_aux_init_value(map->record, value);
+			}
+		}
+	}
 
 	if (htab_is_prealloc(htab))
 		return 0;
@@ -551,6 +590,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	struct bpf_htab *htab;
+	int aux_size;
 	int err;
 
 	htab = bpf_map_area_alloc(sizeof(*htab), NUMA_NO_NODE);
@@ -558,6 +598,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&htab->map, attr);
+	init_irq_work(&htab->nmi_free_irq_work, htab_nmi_free_irq_work);
+	init_llist_head(&htab->nmi_free_elems);
 
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
@@ -582,10 +624,17 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab->elem_size = sizeof(struct htab_elem) +
 			  round_up(htab->map.key_size, 8);
+	aux_size = bpf_map_attr_ref_kptr_aux_size(attr);
+	if (aux_size < 0) {
+		err = aux_size;
+		goto free_htab;
+	}
+	htab->kptr_ref_aux_size = aux_size;
 	if (percpu)
 		htab->elem_size += sizeof(void *);
 	else
-		htab->elem_size += round_up(htab->map.value_size, 8);
+		htab->elem_size += round_up(htab->map.value_size, 8) +
+					    aux_size;
 
 	/* check for u32 overflow */
 	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
@@ -648,7 +697,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true);
+						 round_up(htab->map.value_size, 8) + aux_size,
+						 true);
 			if (err)
 				goto free_map_locked;
 		}
@@ -834,22 +884,74 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	return insn - insn_buf;
 }
 
-static void check_and_free_fields(struct bpf_htab *htab,
-				  struct htab_elem *elem)
+static bool check_and_free_fields(struct bpf_htab *htab, struct htab_elem *elem)
 {
+	bool deferred = false;
+
 	if (IS_ERR_OR_NULL(htab->map.record))
-		return;
+		return false;
 
 	if (htab_is_percpu(htab)) {
 		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
 		int cpu;
 
-		for_each_possible_cpu(cpu)
-			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+		for_each_possible_cpu(cpu) {
+			void *value = per_cpu_ptr(pptr, cpu);
+
+			bpf_obj_free_fields(htab->map.record, value);
+			if (in_nmi() &&
+			    bpf_kptr_ref_has_deferred_dtor(htab->map.record, value))
+				deferred = true;
+		}
 	} else {
 		void *map_value = htab_elem_value(elem, htab->map.key_size);
 
 		bpf_obj_free_fields(htab->map.record, map_value);
+		if (in_nmi() &&
+		    bpf_kptr_ref_has_deferred_dtor(htab->map.record, map_value))
+			deferred = true;
+	}
+	return deferred;
+}
+
+static void htab_nmi_queue_free(struct bpf_htab *htab, struct htab_elem *elem)
+{
+	if (llist_add((struct llist_node *)&elem->fnode, &htab->nmi_free_elems))
+		irq_work_queue(&htab->nmi_free_irq_work);
+}
+
+static void htab_elem_free_nofields(struct bpf_htab *htab, struct htab_elem *l)
+{
+	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
+		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
+	bpf_mem_cache_free(&htab->ma, l);
+}
+
+static void htab_nmi_free_irq_work(struct irq_work *work)
+{
+	struct bpf_htab *htab =
+		container_of(work, struct bpf_htab, nmi_free_irq_work);
+	struct llist_node *node, *tmp, *list;
+
+	list = llist_del_all(&htab->nmi_free_elems);
+	if (!list)
+		return;
+
+	list = llist_reverse_order(list);
+	llist_for_each_safe(node, tmp, list) {
+		struct htab_elem *elem;
+
+		elem = container_of((struct pcpu_freelist_node *)node,
+				    struct htab_elem, fnode);
+		if (htab_is_prealloc(htab)) {
+			if (htab_is_lru(htab))
+				bpf_lru_push_free(&htab->lru, &elem->lru_node);
+			else
+				pcpu_freelist_push(&htab->freelist,
+						   &elem->fnode);
+		} else {
+			htab_elem_free_nofields(htab, elem);
+		}
 	}
 }
 
@@ -1002,11 +1104,16 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
-		check_and_free_fields(htab, l);
-		pcpu_freelist_push(&htab->freelist, &l->fnode);
+		if (check_and_free_fields(htab, l))
+			htab_nmi_queue_free(htab, l);
+		else
+			pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
-		htab_elem_free(htab, l);
+		if (check_and_free_fields(htab, l))
+			htab_nmi_queue_free(htab, l);
+		else
+			htab_elem_free_nofields(htab, l);
 	}
 }
 
@@ -1082,12 +1189,23 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 
 	if (prealloc) {
 		if (old_elem) {
-			/* if we're updating the existing element,
-			 * use per-cpu extra elems to avoid freelist_pop/push
-			 */
-			pl_new = this_cpu_ptr(htab->extra_elems);
-			l_new = *pl_new;
-			*pl_new = old_elem;
+			if (in_nmi() && htab->kptr_ref_aux_size) {
+				struct pcpu_freelist_node *l;
+
+				l = __pcpu_freelist_pop(&htab->freelist);
+				if (!l)
+					return ERR_PTR(-E2BIG);
+				l_new = container_of(l, struct htab_elem,
+						     fnode);
+			} else {
+				/*
+				 * If updating an existing element, use per-cpu
+				 * extra elems to avoid freelist_pop/push.
+				 */
+				pl_new = this_cpu_ptr(htab->extra_elems);
+				l_new = *pl_new;
+				*pl_new = old_elem;
+			}
 		} else {
 			struct pcpu_freelist_node *l;
 
@@ -1131,6 +1249,15 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
+		if (htab->kptr_ref_aux_size) {
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				bpf_kptr_aux_init_value(
+					htab->map.record,
+					per_cpu_ptr(pptr, cpu));
+		}
+
 		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
@@ -1139,10 +1266,14 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		size = round_up(size, 8);
 		memcpy(htab_elem_value(l_new, key_size), value, size);
 	} else if (map_flags & BPF_F_LOCK) {
+		bpf_kptr_aux_init_value(htab->map.record,
+					htab_elem_value(l_new, key_size));
 		copy_map_value_locked(&htab->map,
 				      htab_elem_value(l_new, key_size),
 				      value, false);
 	} else {
+		bpf_kptr_aux_init_value(htab->map.record,
+					htab_elem_value(l_new, key_size));
 		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}
 
@@ -1270,7 +1401,11 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
-	check_and_free_fields(htab, elem);
+	if (check_and_free_fields(htab, elem)) {
+		bpf_map_dec_elem_count(&htab->map);
+		htab_nmi_queue_free(htab, elem);
+		return;
+	}
 	bpf_map_dec_elem_count(&htab->map);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
@@ -1634,6 +1769,7 @@ static void htab_map_free(struct bpf_map *map)
 	 * underneath and is responsible for waiting for callbacks to finish
 	 * during bpf_mem_alloc_destroy().
 	 */
+	irq_work_sync(&htab->nmi_free_irq_work);
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
@@ -2316,7 +2452,8 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 static u64 htab_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	u32 value_size = round_up(htab->map.value_size, 8);
+	u32 value_size = round_up(htab->map.value_size, 8) +
+			 htab->kptr_ref_aux_size;
 	bool prealloc = htab_is_prealloc(htab);
 	bool percpu = htab_is_percpu(htab);
 	bool lru = htab_is_lru(htab);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2caafce00f24..f26c8ed81690 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -661,12 +661,93 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
 	return field;
 }
 
+static void bpf_kptr_call_dtor(const struct btf_field *field, void *ptr)
+{
+	struct btf_struct_meta *pointee_struct_meta;
+
+	if (!btf_is_kernel(field->kptr.btf)) {
+		pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
+							   field->kptr.btf_id);
+		__bpf_obj_drop_impl(ptr,
+				    pointee_struct_meta ?
+					    pointee_struct_meta->record :
+					    NULL,
+				    false);
+		return;
+	}
+
+	field->kptr.dtor(ptr);
+}
+
+static void bpf_kptr_ref_process_queue(struct btf_field *field)
+{
+	struct llist_node *node, *tmp, *list;
+
+	list = llist_del_all(&field->kptr.irq_work_items);
+	if (!list)
+		return;
+
+	list = llist_reverse_order(list);
+	llist_for_each_safe(node, tmp, list) {
+		struct bpf_kptr_dtor_aux *aux;
+		void *ptr;
+
+		aux = container_of(node, struct bpf_kptr_dtor_aux, node);
+		ptr = xchg(&aux->ptr, NULL);
+		if (!ptr)
+			continue;
+		bpf_kptr_call_dtor(field, ptr);
+	}
+}
+
+static void bpf_kptr_ref_irq_work(struct irq_work *irq_work)
+{
+	struct btf_field_kptr *kptr =
+		container_of(irq_work, struct btf_field_kptr, irq_work);
+	struct btf_field *field = container_of(kptr, struct btf_field, kptr);
+
+	bpf_kptr_ref_process_queue(field);
+}
+
+static void bpf_kptr_record_init(struct btf_record *rec)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		if (rec->fields[i].type != BPF_KPTR_REF)
+			continue;
+		init_irq_work(&rec->fields[i].kptr.irq_work,
+			      bpf_kptr_ref_irq_work);
+		init_llist_head(&rec->fields[i].kptr.irq_work_items);
+		init_llist_head(&rec->fields[i].kptr.free_list);
+	}
+}
+
+static void bpf_kptr_record_flush(struct btf_record *rec)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		if (rec->fields[i].type != BPF_KPTR_REF)
+			continue;
+		irq_work_sync(&rec->fields[i].kptr.irq_work);
+		bpf_kptr_ref_process_queue(&rec->fields[i]);
+	}
+}
+
 void btf_record_free(struct btf_record *rec)
 {
 	int i;
 
 	if (IS_ERR_OR_NULL(rec))
 		return;
+	bpf_kptr_record_flush(rec);
 	for (i = 0; i < rec->cnt; i++) {
 		switch (rec->fields[i].type) {
 		case BPF_KPTR_UNREF:
@@ -751,6 +832,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		}
 		new_rec->cnt++;
 	}
+	bpf_kptr_record_init(new_rec);
 	return new_rec;
 free:
 	btf_record_free(new_rec);
@@ -792,14 +874,79 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 		return false;
 
 	for (i = 0; i < rec_a->cnt; i++) {
-		if (memcmp(&rec_a->fields[i], &rec_b->fields[i],
-			   sizeof(rec_a->fields[i])))
+		struct btf_field a = rec_a->fields[i];
+		struct btf_field b = rec_b->fields[i];
+
+		switch (a.type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
+			memset(&a.kptr.irq_work, 0, sizeof(a.kptr.irq_work));
+			memset(&a.kptr.irq_work_items, 0,
+			       sizeof(a.kptr.irq_work_items));
+			memset(&a.kptr.free_list, 0, sizeof(a.kptr.free_list));
+			memset(&b.kptr.irq_work, 0, sizeof(b.kptr.irq_work));
+			memset(&b.kptr.irq_work_items, 0,
+			       sizeof(b.kptr.irq_work_items));
+			memset(&b.kptr.free_list, 0, sizeof(b.kptr.free_list));
+			break;
+		default:
+			break;
+		}
+
+		if (memcmp(&a, &b, sizeof(a)))
 			return false;
 	}
 
 	return true;
 }
 
+int bpf_map_attr_ref_kptr_aux_size(const union bpf_attr *attr)
+{
+	const struct btf_type *value_type;
+	struct btf_record *rec;
+	struct btf *btf;
+	u32 btf_value_type_id;
+	u32 value_size;
+	int aux_size;
+
+	if (!attr->btf_value_type_id)
+		return 0;
+
+	btf = btf_get_by_fd(attr->btf_fd);
+	if (IS_ERR(btf))
+		return 0;
+
+	btf_value_type_id = attr->btf_value_type_id;
+	value_type = btf_type_id_size(btf, &btf_value_type_id, &value_size);
+	if (!value_type || value_size != attr->value_size) {
+		aux_size = 0;
+		goto out;
+	}
+
+	/*
+	 * This helper is only sizing hidden storage for valid ref-kptr fields.
+	 * Leave full BTF validation to the regular map_check_btf() path.
+	 */
+	if (!__btf_type_is_struct(value_type) &&
+	    BTF_INFO_KIND(value_type->info) != BTF_KIND_DATASEC) {
+		aux_size = 0;
+		goto out;
+	}
+
+	rec = btf_parse_fields(btf, value_type, BPF_KPTR_REF, attr->value_size);
+	if (IS_ERR(rec)) {
+		aux_size = 0;
+		goto out;
+	}
+	aux_size = rec ? rec->kptr_ref_aux_size : 0;
+	btf_record_free(rec);
+out:
+	btf_put(btf);
+	return aux_size;
+}
+
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
 {
 	if (WARN_ON_ONCE(!btf_record_has_field(rec, BPF_TIMER)))
@@ -830,8 +977,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		return;
 	fields = rec->fields;
 	for (i = 0; i < rec->cnt; i++) {
-		struct btf_struct_meta *pointee_struct_meta;
-		const struct btf_field *field = &fields[i];
+		struct btf_field *field = (struct btf_field *)&fields[i];
 		void *field_ptr = obj + field->offset;
 		void *xchgd_field;
 
@@ -857,14 +1003,35 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			if (!xchgd_field)
 				break;
 
-			if (!btf_is_kernel(field->kptr.btf)) {
-				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
-									   field->kptr.btf_id);
-				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
-								 pointee_struct_meta->record : NULL,
-								 fields[i].type == BPF_KPTR_PERCPU);
+			if (field->type == BPF_KPTR_REF && in_nmi()) {
+				struct bpf_kptr_dtor_aux *aux;
+
+				aux = bpf_kptr_ref_aux(field, obj);
+				WARN_ON_ONCE(READ_ONCE(aux->ptr));
+				WRITE_ONCE(aux->ptr, xchgd_field);
+				if (llist_add(&aux->node,
+					      &field->kptr.irq_work_items))
+					irq_work_queue(&field->kptr.irq_work);
+				break;
+			}
+
+			if (field->type == BPF_KPTR_PERCPU) {
+				struct btf_struct_meta *pointee_struct_meta;
+
+				pointee_struct_meta = NULL;
+				if (!btf_is_kernel(field->kptr.btf))
+					pointee_struct_meta =
+						btf_find_struct_meta(
+							field->kptr.btf,
+							field->kptr.btf_id);
+				__bpf_obj_drop_impl(
+					xchgd_field,
+					pointee_struct_meta ?
+						pointee_struct_meta->record :
+						NULL,
+					true);
 			} else {
-				field->kptr.dtor(xchgd_field);
+				bpf_kptr_call_dtor(field, xchgd_field);
 			}
 			break;
 		case BPF_UPTR:
@@ -1276,6 +1443,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
 				       BPF_TASK_WORK,
 				       map->value_size);
+	bpf_kptr_record_init(map->record);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-- 
2.53.0

