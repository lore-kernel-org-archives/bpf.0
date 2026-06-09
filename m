Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90473909A9
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036756; cv=none; b=Cq4q3EtNnApY/ZEIS0PzlJO9tmFhIhclKXSYicImAAgGObedsP2ViOVLN69JuV+cxYupUmJAjfPYJ23n8SmB5DFB3kd4dPiarjzS/7xcV7V93ozCmr0w3kGh1vfxq4hAlKpcFUUc0kTxFiUeA0UWpPzi9efzrloH6ZdtQCqdL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036756; c=relaxed/simple;
	bh=WTG6/mcT15JpXbmvlQd7U1atcNJuC0EVe3sDayEJGac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYZN0DBV4Q/nvaML9MJkifpObOjT9cspzQo3/D02VrUyg9Mr9CqGNOmu0a6qBmPIi7hmoT20fvRyUWAXcjXpUW3nSuUumMMxoYFPdt9ZUptdDzExA6DBcE109G+yudb9Mvcapaw9Q7U1RBc74uC9Za1UC1ItzwzfDD5jMr7YAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb2CgRfv; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb2CgRfv"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490a76757e5so39404765e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036752; x=1781641552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRD/sZ3N0p6AYVjTD5/kKMblOfRtJOrIPsELHEXl5fQ=;
        b=nb2CgRfvtg/qC/0z035eWGBwXS3hoDmOC5/yMmRhGpZSdJ0/J7XIpcNOzDwuE0drRG
         776mih7dz4smWwKDr1MchGke+DPoFi44HEA+8V7TlIhujpjgy2E3L0nV0rTOApE4+dcV
         gZ3yDBUkmSS2mBhRo+AC6gtaufb/9g3npOJ/QFsYzMq3MPctrbS8zbnlhYfZ+3NulRWp
         PECamcht8ZDZhKY5QfKicKdUR9i3b73Mr4uKClSqVsJ0GZeZ78Y+FCwqY5xVWAOBqT6V
         +N1Tnq97DQ+9BWnSIEX4mmCEKyENNthRr0IYQyxmeByClb/GMvprG9gtTyZOu7bxhP3r
         fudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036752; x=1781641552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRD/sZ3N0p6AYVjTD5/kKMblOfRtJOrIPsELHEXl5fQ=;
        b=iTgllHSYzznVLHnTfQu/pNRiOMKQlfOIUa/wBtqDAgIwVqwyp0c3vJWKosDtUUscrm
         hPT16RErCh2/aI25gxCDJ19UCLD0JkxB4FasVVV/yWcQ0sRcDWhDoNbWGSaHN0Dc7/Rj
         RJecWoiBS3dD+d8Dfr2jub7i3WNHekyQSb+K6WT3mwy29O8m/24wRdWc/pRY69Iog2rB
         RpMtLazR7QT9Htk4UTt2ozHIMToNN+jnn2f/NQOe0aMqXHhNzRi/H99tI6LxUlEzeCQG
         yZP8rLDgEVeQsWchfFAHLwo9UYKKahYRYkKQBuIZ8Mecm9EPWam7zrFXh95+QfGw2PR3
         uezA==
X-Gm-Message-State: AOJu0Ywvi/JKY3PZ50+VnOknyZ2fRXp6SUVzZcmhP0mPaJdPYlCvDgdl
	fqDzvQggmEhSeRjoDtdwxyi85wdcqxn1cYCEeCu62yyFryUQfm8o7DsJ6JgcLcBx
X-Gm-Gg: Acq92OEsVJd2ccdBF052lqFsiqyKhBYXHYiSZ9eI3Ys+JIYmFbS7E5WdeBp5ujhgLIh
	PcSwkNRKHv3KY1ZzZbwOrrmgf2Qq37uGxfUAh3xSEjAV4XCv60baM+i6h+L3cgnYDezkwNSyNwB
	A+BJFbYm74R9ybtu1e6tiiYrdUmBdRrfn5M3zxuiBNzvL81o4mhn8cWQPB+H+82BP+Qfsx0U6Hp
	OiWVggfYLd+vjAB4E8ockyx+1w6IX22hM0JmDGzsniemAjYna+37rztLsHOlxCmSS3j5Iqbfdof
	QEJTuDgCugPkU76b7XAUaQzs81iOMFd7nQ3eKpeya87DCfjI7z+s9cKPijfZv16yTKAQlcnAmYH
	ILE5pLdUgk7KsEV5a2ZAeoaDe9gPpF4icO+EVyqc25YnYj7DTIxicVp0ocV9MBzGYUk+F2REvki
	LTcViYFPkntt3evaaoVQtdAXvTaB4+MJwDJr6btruxqKguk8L4DnLYItWGBdyYz/FbPnBrNkIzl
	579p0Mjygugee3o25oGd7pMkIB6H8+FYHq6TImUAA0cZtgzZplD8zfMdQOAuL0P10tUc3dxN+ba
X-Received: by 2002:a05:600c:5248:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490c2522657mr351899935e9.0.1781036751985;
        Tue, 09 Jun 2026 13:25:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm503047635e9.8.2026.06.09.13.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:25:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Justin Suess <utilityemal77@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/4] bpf: Cancel special fields on map value recycle
Date: Tue,  9 Jun 2026 22:25:44 +0200
Message-ID: <20260609202548.3571690-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609202548.3571690-1-memxor@gmail.com>
References: <20260609202548.3571690-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23452; i=memxor@gmail.com; h=from:subject; bh=fgt8ptp1erlaCSNENeSVFzQTDWhh7w0wtkCLOmUK1IU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUujLPb5u8MLfaWE7T/GLmM5mnJfRn3XKh3t2bwCIob82 XEnV3N1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLm6xl+s5m5WFguK8yf2X76 O++67KfK77O+L5KY/FibbfUFtQufChkZpuzod44/mugW/rX63sNdMSumGRg8U9xedPWk45sNyir X2AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

Map update and delete paths currently call bpf_obj_free_fields() when a
value is being replaced or recycled. That makes field destruction depend
on the context of the update/delete operation. For tracing programs this
can include NMI context, where referenced kptr destructors, uptr
unpinning, and graph root destruction are not generally safe.

Introduce bpf_obj_cancel_fields() for the reusable-value path. It only
performs NMI-safe cleanup for timer, workqueue, and task_work fields.
Fields that need full destruction are left attached to the recycled value
and are destroyed by the final cleanup path instead.

Switch array and hashtab update/delete/recycle paths to this cancel
helper. Keep bpf_obj_free_fields() for final map destruction and for
bpf_mem_alloc destructors. Preallocated hashtabs do not have allocator
destructors, so teardown continues to walk the normal and extra elements
and fully destroy their fields.

This deliberately relaxes the eager-free semantics of map update/delete
for special fields. Programs that relied on a recycled map slot becoming
empty immediately after update/delete were relying on behavior that
cannot be implemented safely from every BPF execution context without
offloading arbitrary destructors.

There is a chance this change breaks programs making assumptions
regarding the eager freeing of fields. If so, we can relax semantics to
cancellation only when irqs_disabled() is true in the future. However,
theoretically, map values that get reused eagerly already have weaker
guarantees as parallel users can recreate freed fields before the new
element becomes visible again.

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  1 +
 kernel/bpf/arraymap.c                         |  8 +--
 kernel/bpf/hashtab.c                          | 32 +++++----
 kernel/bpf/syscall.c                          |  5 ++
 .../selftests/bpf/prog_tests/htab_update.c    |  4 +-
 .../selftests/bpf/prog_tests/linked_list.c    | 33 ++++-----
 .../selftests/bpf/prog_tests/map_kptr.c       | 10 +--
 .../bpf/prog_tests/refcounted_kptr.c          |  8 ++-
 .../testing/selftests/bpf/progs/htab_update.c |  4 +-
 .../testing/selftests/bpf/progs/linked_list.c | 71 +++++++++++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 20 +++++-
 11 files changed, 146 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0654d2ffadc1..56f5da2b437f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2717,6 +2717,7 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
 void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
+void bpf_obj_cancel_fields(struct bpf_map *map, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e6271a2bf6d6..248b4818178c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -384,7 +384,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
 		copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
+		bpf_obj_cancel_fields(map, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
+		bpf_obj_cancel_fields(map, val);
 	}
 	return 0;
 }
@@ -432,14 +432,14 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 		cpu = map_flags >> 32;
 		ptr = per_cpu_ptr(pptr, cpu);
 		copy_map_value(map, ptr, value);
-		bpf_obj_free_fields(array->map.record, ptr);
+		bpf_obj_cancel_fields(map, ptr);
 		goto unlock;
 	}
 	for_each_possible_cpu(cpu) {
 		ptr = per_cpu_ptr(pptr, cpu);
 		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
 		copy_map_value(map, ptr, val);
-		bpf_obj_free_fields(array->map.record, ptr);
+		bpf_obj_cancel_fields(map, ptr);
 	}
 unlock:
 	rcu_read_unlock();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b4366cad3cfa..9f394e1aa2e8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -243,6 +243,10 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 
 	if (IS_ERR_OR_NULL(htab->map.record))
 		return;
+	/*
+	 * Preallocated maps do not have a bpf_mem_alloc destructor, so fully
+	 * destroy every element, including the extra elements.
+	 */
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
 	for (i = 0; i < num_entries; i++) {
@@ -833,8 +837,8 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	return insn - insn_buf;
 }
 
-static void check_and_free_fields(struct bpf_htab *htab,
-				  struct htab_elem *elem)
+static void check_and_cancel_fields(struct bpf_htab *htab,
+				    struct htab_elem *elem)
 {
 	if (IS_ERR_OR_NULL(htab->map.record))
 		return;
@@ -844,11 +848,11 @@ static void check_and_free_fields(struct bpf_htab *htab,
 		int cpu;
 
 		for_each_possible_cpu(cpu)
-			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+			bpf_obj_cancel_fields(&htab->map, per_cpu_ptr(pptr, cpu));
 	} else {
 		void *map_value = htab_elem_value(elem, htab->map.key_size);
 
-		bpf_obj_free_fields(htab->map.record, map_value);
+		bpf_obj_cancel_fields(&htab->map, map_value);
 	}
 }
 
@@ -883,7 +887,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	htab_unlock_bucket(b, flags);
 
 	if (l == tgt_l)
-		check_and_free_fields(htab, l);
+		check_and_cancel_fields(htab, l);
 	return l == tgt_l;
 }
 
@@ -948,7 +952,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
-	check_and_free_fields(htab, l);
+	check_and_cancel_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
@@ -1001,7 +1005,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (htab_is_prealloc(htab)) {
 		bpf_map_dec_elem_count(&htab->map);
-		check_and_free_fields(htab, l);
+		check_and_cancel_fields(htab, l);
 		pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
@@ -1018,7 +1022,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 		/* copy true value_size bytes */
 		ptr = this_cpu_ptr(pptr);
 		copy_map_value(&htab->map, ptr, value);
-		bpf_obj_free_fields(htab->map.record, ptr);
+		bpf_obj_cancel_fields(&htab->map, ptr);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		void *val;
@@ -1028,7 +1032,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			cpu = map_flags >> 32;
 			ptr = per_cpu_ptr(pptr, cpu);
 			copy_map_value(&htab->map, ptr, value);
-			bpf_obj_free_fields(htab->map.record, ptr);
+			bpf_obj_cancel_fields(&htab->map, ptr);
 			return;
 		}
 
@@ -1036,7 +1040,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			ptr = per_cpu_ptr(pptr, cpu);
 			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
 			copy_map_value(&htab->map, ptr, val);
-			bpf_obj_free_fields(htab->map.record, ptr);
+			bpf_obj_cancel_fields(&htab->map, ptr);
 		}
 	}
 }
@@ -1252,11 +1256,11 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (l_old) {
 		hlist_nulls_del_rcu(&l_old->hash_node);
 
-		/* l_old has already been stashed in htab->extra_elems, free
-		 * its special fields before it is available for reuse.
+		/* l_old has already been stashed in htab->extra_elems, cancel
+		 * its reusable special fields before it is available for reuse.
 		 */
 		if (htab_is_prealloc(htab))
-			check_and_free_fields(htab, l_old);
+			check_and_cancel_fields(htab, l_old);
 	}
 	htab_unlock_bucket(b, flags);
 	if (l_old && !htab_is_prealloc(htab))
@@ -1269,7 +1273,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
-	check_and_free_fields(htab, elem);
+	check_and_cancel_fields(htab, elem);
 	bpf_map_dec_elem_count(&htab->map);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d4188a992bd8..7ed949f70f82 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -808,6 +808,11 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
 	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
 }
 
+void bpf_obj_cancel_fields(struct bpf_map *map, void *obj)
+{
+	bpf_map_free_internal_structs(map, obj);
+}
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index ea1a6766fbe9..0a28d4346924 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -23,7 +23,7 @@ static void test_reenter_update(void)
 	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
 		return;
 
-	bpf_program__set_autoload(skel->progs.bpf_obj_free_fields, true);
+	bpf_program__set_autoload(skel->progs.bpf_obj_cancel_fields, true);
 	err = htab_update__load(skel);
 	if (!ASSERT_TRUE(!err, "htab_update__load") || err)
 		goto out;
@@ -50,7 +50,7 @@ static void test_reenter_update(void)
 	/*
 	 * Second update: replace existing element with same key and trigger
 	 * the reentrancy of bpf_map_update_elem().
-	 * check_and_free_fields() calls bpf_obj_free_fields() on the old
+	 * check_and_cancel_fields() calls bpf_obj_cancel_fields() on the old
 	 * value, which is where fentry program runs and performs a nested
 	 * bpf_map_update_elem(), triggering -EDEADLK.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index dbff099860ba..8defea0253ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -131,13 +131,14 @@ static void test_linked_list_fail_prog(const char *prog_name, const char *err_ms
 	linked_list_fail__destroy(skel);
 }
 
-static void clear_fields(struct bpf_map *map)
+static void clear_fields(struct bpf_program *prog)
 {
-	char buf[24];
-	int key = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;
 
-	memset(buf, 0xff, sizeof(buf));
-	ASSERT_OK(bpf_map__update_elem(map, &key, sizeof(key), buf, sizeof(buf), 0), "check_and_free_fields");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	ASSERT_OK(ret, "clear_fields");
+	ASSERT_OK(opts.retval, "clear_fields retval");
 }
 
 enum {
@@ -170,31 +171,31 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ASSERT_OK(ret, "map_list_push_pop");
 	ASSERT_OK(opts.retval, "map_list_push_pop retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.array_map);
+		clear_fields(skel->progs.clear_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop), &opts);
 	ASSERT_OK(ret, "inner_map_list_push_pop");
 	ASSERT_OK(opts.retval, "inner_map_list_push_pop retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.inner_map);
+		clear_fields(skel->progs.clear_inner_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
 	ASSERT_OK(ret, "global_list_push_pop");
 	ASSERT_OK(opts.retval, "global_list_push_pop retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.bss_A);
+		clear_fields(skel->progs.clear_global_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_nested), &opts);
 	ASSERT_OK(ret, "global_list_push_pop_nested");
 	ASSERT_OK(opts.retval, "global_list_push_pop_nested retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.bss_A);
+		clear_fields(skel->progs.clear_global_nested_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_array_push_pop), &opts);
 	ASSERT_OK(ret, "global_list_array_push_pop");
 	ASSERT_OK(opts.retval, "global_list_array_push_pop retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.bss_A);
+		clear_fields(skel->progs.clear_global_array_list);
 
 	if (mode == PUSH_POP)
 		goto end;
@@ -204,19 +205,19 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ASSERT_OK(ret, "map_list_push_pop_multiple");
 	ASSERT_OK(opts.retval, "map_list_push_pop_multiple retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.array_map);
+		clear_fields(skel->progs.clear_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop_multiple), &opts);
 	ASSERT_OK(ret, "inner_map_list_push_pop_multiple");
 	ASSERT_OK(opts.retval, "inner_map_list_push_pop_multiple retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.inner_map);
+		clear_fields(skel->progs.clear_inner_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
 	ASSERT_OK(ret, "global_list_push_pop_multiple");
 	ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.bss_A);
+		clear_fields(skel->progs.clear_global_list);
 
 	if (mode == PUSH_POP_MULT)
 		goto end;
@@ -226,19 +227,19 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	ASSERT_OK(ret, "map_list_in_list");
 	ASSERT_OK(opts.retval, "map_list_in_list retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.array_map);
+		clear_fields(skel->progs.clear_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_in_list), &opts);
 	ASSERT_OK(ret, "inner_map_list_in_list");
 	ASSERT_OK(opts.retval, "inner_map_list_in_list retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.inner_map);
+		clear_fields(skel->progs.clear_inner_map_list);
 
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
 	ASSERT_OK(ret, "global_list_in_list");
 	ASSERT_OK(opts.retval, "global_list_in_list retval");
 	if (!leave_in_map)
-		clear_fields(skel->maps.bss_A);
+		clear_fields(skel->progs.clear_global_list);
 end:
 	linked_list__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 03b46f17cf53..ec6f2f2e8308 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -51,7 +51,6 @@ static void test_map_kptr_success(bool test_run)
 	ret = bpf_map__update_elem(skel->maps.array_map,
 				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "array_map update");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
@@ -59,49 +58,42 @@ static void test_map_kptr_success(bool test_run)
 	ret = bpf_map__update_elem(skel->maps.pcpu_array_map,
 				   &key, sizeof(key), pbuf, cpu * sizeof(buf), 0);
 	ASSERT_OK(ret, "pcpu_array_map update");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "pcpu_hash_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.hash_malloc_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_malloc_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_malloc_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "pcpu_hash_malloc_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.lru_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "lru_hash_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
 	ret = bpf_map__delete_elem(skel->maps.lru_pcpu_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "lru_pcpu_hash_map delete");
-	skel->data->ref--;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
@@ -175,7 +167,7 @@ void serial_test_map_kptr(void)
 		ASSERT_OK(kern_sync_rcu(), "sync rcu");
 		wait_for_map_release();
 
-		/* Observe refcount dropping to 1 on synchronous delete elem */
+		/* Observe refcount dropping to 1 on map release. */
 		test_map_kptr_success(true);
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d2c0542716a8..1737eba34323 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -57,6 +57,7 @@ void test_percpu_hash_refcounted_kptr_refcount_leak(void)
 		    .data_size_in = sizeof(pkt_v4),
 		    .repeat = 1,
 	);
+	LIBBPF_OPTS(bpf_test_run_opts, syscall_opts);
 
 	cpu_nr = libbpf_num_possible_cpus();
 	if (!ASSERT_GT(cpu_nr, 0, "libbpf_num_possible_cpus"))
@@ -87,8 +88,11 @@ void test_percpu_hash_refcounted_kptr_refcount_leak(void)
 	if (!ASSERT_EQ(opts.retval, 2, "opts.retval"))
 		goto out;
 
-	err = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, 0);
-	if (!ASSERT_OK(err, "bpf_map__update_elem"))
+	fd = bpf_program__fd(skel->progs.clear_percpu_hash_kptr);
+	err = bpf_prog_test_run_opts(fd, &syscall_opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+	if (!ASSERT_EQ(syscall_opts.retval, 1, "syscall_opts.retval"))
 		goto out;
 
 	fd = bpf_program__fd(skel->progs.check_percpu_hash_refcount);
diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
index 195d3b2fba00..62c1b1325ec2 100644
--- a/tools/testing/selftests/bpf/progs/htab_update.c
+++ b/tools/testing/selftests/bpf/progs/htab_update.c
@@ -22,8 +22,8 @@ struct {
 int pid = 0;
 int update_err = 0;
 
-SEC("?fentry/bpf_obj_free_fields")
-int bpf_obj_free_fields(void *ctx)
+SEC("?fentry/bpf_obj_cancel_fields")
+int bpf_obj_cancel_fields(void *ctx)
 {
 	__u32 key = 0;
 	struct val value = { .payload = 1 };
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 421f40835acd..fa97faa5358b 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -290,6 +290,77 @@ int test_list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head)
 	return list_in_list(lock, head, true);
 }
 
+#define MAX_LIST_CLEAR_NODES 256
+
+static __always_inline
+int clear_list(struct bpf_spin_lock *lock, struct bpf_list_head *head)
+{
+	struct bpf_list_node *n;
+	int i;
+
+	for (i = 0; i < MAX_LIST_CLEAR_NODES; i++) {
+		bpf_spin_lock(lock);
+		n = bpf_list_pop_front(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 0;
+		bpf_obj_drop(container_of(n, struct foo, node2));
+	}
+	return 1;
+}
+
+SEC("syscall")
+int clear_map_list(void *ctx)
+{
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return clear_list(&v->lock, &v->head);
+}
+
+SEC("syscall")
+int clear_inner_map_list(void *ctx)
+{
+	struct map_value *v;
+	void *map;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
+	if (!map)
+		return 1;
+	v = bpf_map_lookup_elem(map, &(int){0});
+	if (!v)
+		return 1;
+	return clear_list(&v->lock, &v->head);
+}
+
+SEC("syscall")
+int clear_global_list(void *ctx)
+{
+	return clear_list(&glock, &ghead);
+}
+
+SEC("syscall")
+int clear_global_nested_list(void *ctx)
+{
+	return clear_list(&ghead_nested.inner.lock, &ghead_nested.inner.head);
+}
+
+SEC("syscall")
+int clear_global_array_list(void *ctx)
+{
+	int ret;
+
+	ret = clear_list(&glock_c, &ghead_array[0]);
+	if (ret)
+		return ret;
+	ret = clear_list(&glock_c, &ghead_array[1]);
+	if (ret)
+		return ret;
+	return clear_list(&glock_c, &ghead_array_one[0]);
+}
+
 SEC("tc")
 int map_list_push_pop(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 13de169ad68f..61906f48025c 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -1036,13 +1036,31 @@ int percpu_hash_refcount_leak(void *ctx)
 	struct map_value *v;
 	int key = 0;
 
-	v = bpf_map_lookup_elem(&percpu_hash, &key);
+	v = bpf_map_lookup_percpu_elem(&percpu_hash, &key, 0);
 	if (!v)
 		return 0;
 
 	return __insert_in_list(&head, &lock, &v->node);
 }
 
+SEC("syscall")
+int clear_percpu_hash_kptr(void *ctx)
+{
+	struct node_data *n;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_percpu_elem(&percpu_hash, &key, 0);
+	if (!v)
+		return 0;
+
+	n = bpf_kptr_xchg(&v->node, NULL);
+	if (!n)
+		return 0;
+	bpf_obj_drop(n);
+	return probe_read_refcount();
+}
+
 SEC("tc")
 int check_percpu_hash_refcount(void *ctx)
 {
-- 
2.53.0

