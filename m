Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEF3DEFFC
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930128; cv=none; b=QVBPt4SxpplLT1AWz5lq20K7LdS7RE1OUJfchReHmbuMMtVfOvESUnzwH5eFr67F0F5J3XXErhlAXBI9+LbUQ6FY8mhxnZHNujK+Hh+TGbV1apXYlLiz31enHneAT2Fnzn9UV2Tk3kNHVo6kKV/gjM/BTbI7B8C9kL5kqez/uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930128; c=relaxed/simple;
	bh=ufAIpZ0vqfnpXv3s+oFLvQT7Guah5dUoVbwr9AM6L5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcWfbjgPJ+KTjL/s96fPchs5agw8MZpKM64dieU5YgkINN0l4lgjLUMZC3zTMjgJu0CJlsOKKV7gRvhDsoy0YXhVzVd5A/cjz34FknNcxNIea02GsK543qaYvXP0GruC6BsWmCPDALW6PzwU8JG/CK9Lv4bza1vsiJKpgLn6CBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks3PDyqC; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks3PDyqC"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3212044f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930125; x=1781534925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nr/Mzz5zjyW8yrdv0iIT+uDlWoBbHtqihW7EGCAPRM=;
        b=ks3PDyqCudiKPV1MfVOxsYIAgWX5v/r8YYvU9/oyd/O6Ys564DhlFb2PguJn2qReIJ
         xrDGuqvZNM2gyFp0/42oPS3rd9WBExPKsdNczyBmYCkn6PlSAfELV0S5Wm34+yZ8y0ww
         eWoWtwF90TCpYoOt5WRW0uwlmxBlJztNgP0Z7WZWFaJTZmME8DArwV87iQEWOHTT5WAl
         uOXwrbcXRicjp11lbrE2vjCLLaK5EXabJ5fXsQkzDp1tyfbnAk6iAr4u+/PpHOkUBCCW
         HwJOzqm21mlSc9LFky0kuCb3nxsc4dIFp1a1Tju0Ezzn5cr6hLKvu3baKbALMvftSww3
         Q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930125; x=1781534925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nr/Mzz5zjyW8yrdv0iIT+uDlWoBbHtqihW7EGCAPRM=;
        b=jjhyu1UsKWPAITQs48d9EXhgSzZpNeAT4dWXcx0Pwwx5Sga4xbINXQ5V+Q9LM9O6uF
         uS3ulbGI7kakjFY5pyyB/lZh18zgk6h4Y8FG9GIX8BfOQT9j7lratlTcXXD8hTHs9QNI
         1VjC9IkD7hepBNVr5gXZjgIA43C1MYK9cSF9fnISOWDV01e8L82+JG8YP8W1M5QiLXCQ
         Qmal2WJYlx3NtrzS4ShciKQ8JeeKPDCCOqIQjyq/vccjEE1jJ/O4CyYjzY2Rhk/IwV2Y
         12f+IGg1qc/Btya9ZGAG21k48SBAlyu4nfCaPaWfr6Rroon7+Gblacj9NCqnZ/lWqAtj
         RCZw==
X-Gm-Message-State: AOJu0Yxdk8YCxolvXvTbvdG7r5OPpfbIz1S2+gxD1L6jheeHrc4xiuwP
	tEUfRAFfLf1zJv7vK2d1ltIpMoRudR1+1NmJf0JLqcSgt/VIGaLpg9tZ+IwjaEAn
X-Gm-Gg: Acq92OEUM9xPsxQDVvg7H5Z2ljdU5Y8/glVIre4S3gqi8mySWNzRTZj3PlKRZR4IAw2
	7fZ6YDzxFQ/LNHJWF1upEavvbsvZYBG76hXJOKUyHe/E4LGNYcVss2wPQE9ImoyH0qQZ9WbinE9
	gmez/b5L2U7tP3Au1B4H4ajvXt4QZIBOglZxGK7myz1X0T8kM1yt5gSQWqgl+M3R2kmtf+PaJ3g
	3xmagoDItR/lz9jPMZq1iDoBOMY+oq5M3b0je2RQOxnHzP7DSpSeBSSqYCypWy1Kwt8eLAkhXfh
	CcQeUCIkJ3tPPgtaagCjknNDFv+ek1TNERjqMlw1aj4kHZtMkcccbWhOk8XhS4vpEAycJIMWhNW
	shfkLvlUNQXYXO0Zujq9JXVyEu2hZjddH18rWXZcIWh+vutty7P1uCUgTXXaFS/PDV2Uj/rF2E1
	iMG4C/+2S6sbXuHGSB2Te0Go8Ze9ttK4macsm/XEUvSH85/yKKNlVtXR3iOvD/T3zMM0AV+bj9H
	EKzWJrlmtOXT/CG/hqZSJVbiVtFgYMcDwtIxfIFjEdjA2NZApdUVylfOewZFHckmMdI0mFMAWAq
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-490c2c63f53mr206893785e9.0.1780930125027;
        Mon, 08 Jun 2026 07:48:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm397574965e9.0.2026.06.08.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/5] bpf: Cancel special fields on map value recycle
Date: Mon,  8 Jun 2026 16:48:36 +0200
Message-ID: <20260608144841.1732406-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>
References: <20260608144841.1732406-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15181; i=memxor@gmail.com; h=from:subject; bh=rMSXMLxjZjhu8EEF0G5hffQ83yMjkJkdSoaLdO6B8Zk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmtSVMw8ZowsC3dTk4x25n51ZEyGm2auSoj7VM3H+v xwP6d6OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATOTeZ4b/lULmPBceWSdX8qdX 106Y7n9qs9L51WfdpldebI15bnIrm5Gh1/PE3sDetY6ruMNyPru7LxG1b08Mep1rrLc7WuvT3Rx mAA==
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
 kernel/bpf/arraymap.c                         |  8 ++---
 kernel/bpf/hashtab.c                          | 32 +++++++++++--------
 kernel/bpf/syscall.c                          | 27 ++++++++++++++++
 .../selftests/bpf/prog_tests/htab_update.c    |  4 +--
 .../selftests/bpf/prog_tests/map_kptr.c       | 10 +-----
 .../testing/selftests/bpf/progs/htab_update.c |  4 +--
 7 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0654d2ffadc1..fc24b81cc206 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2717,6 +2717,7 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
 void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
+void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index e6271a2bf6d6..4e8d6fe6999b 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -384,7 +384,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
 		copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
+		bpf_obj_cancel_fields(array->map.record, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		bpf_obj_free_fields(array->map.record, val);
+		bpf_obj_cancel_fields(array->map.record, val);
 	}
 	return 0;
 }
@@ -432,14 +432,14 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 		cpu = map_flags >> 32;
 		ptr = per_cpu_ptr(pptr, cpu);
 		copy_map_value(map, ptr, value);
-		bpf_obj_free_fields(array->map.record, ptr);
+		bpf_obj_cancel_fields(array->map.record, ptr);
 		goto unlock;
 	}
 	for_each_possible_cpu(cpu) {
 		ptr = per_cpu_ptr(pptr, cpu);
 		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
 		copy_map_value(map, ptr, val);
-		bpf_obj_free_fields(array->map.record, ptr);
+		bpf_obj_cancel_fields(array->map.record, ptr);
 	}
 unlock:
 	rcu_read_unlock();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b4366cad3cfa..a9b2b882b90f 100644
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
+			bpf_obj_cancel_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
 	} else {
 		void *map_value = htab_elem_value(elem, htab->map.key_size);
 
-		bpf_obj_free_fields(htab->map.record, map_value);
+		bpf_obj_cancel_fields(htab->map.record, map_value);
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
+		bpf_obj_cancel_fields(htab->map.record, ptr);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		void *val;
@@ -1028,7 +1032,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			cpu = map_flags >> 32;
 			ptr = per_cpu_ptr(pptr, cpu);
 			copy_map_value(&htab->map, ptr, value);
-			bpf_obj_free_fields(htab->map.record, ptr);
+			bpf_obj_cancel_fields(htab->map.record, ptr);
 			return;
 		}
 
@@ -1036,7 +1040,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 			ptr = per_cpu_ptr(pptr, cpu);
 			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
 			copy_map_value(&htab->map, ptr, val);
-			bpf_obj_free_fields(htab->map.record, ptr);
+			bpf_obj_cancel_fields(htab->map.record, ptr);
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
index d4188a992bd8..8d12aa3728ea 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -808,6 +808,33 @@ void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
 	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
 }
 
+void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj)
+{
+	const struct btf_field *fields;
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+	fields = rec->fields;
+	for (i = 0; i < rec->cnt; i++) {
+		void *field_ptr = obj + fields[i].offset;
+
+		switch (fields[i].type) {
+		case BPF_TIMER:
+			bpf_timer_cancel_and_free(field_ptr);
+			break;
+		case BPF_WORKQUEUE:
+			bpf_wq_cancel_and_free(field_ptr);
+			break;
+		case BPF_TASK_WORK:
+			bpf_task_work_cancel_and_free(field_ptr);
+			break;
+		default:
+			break;
+		}
+	}
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
-- 
2.53.0

