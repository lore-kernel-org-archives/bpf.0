Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947649F122
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269080; cv=none; b=cyJBMcfY00sHWyjGqiGJQFQOUrlyi3T5PsVTnbAKAtRa2HD+wpxfZlCzHX8kQKUWkg9rEVzxO0dPYgRh8bIHQWlFvmsjvzEPcQUfKeGP5kBDqqt+Wb4HHD4NhXGwJ5JNE8vrPS7O3N0/rSNc3gkDjO2MSK/E+ArqE14cK35vNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269080; c=relaxed/simple;
	bh=O732tdMK6vNIOSVP3C0a6xsUs+ygTdP/iGjmOfDgclM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2lfjFOca+FzAmA3nWmJ9MU7YCSpYBRPuiSvotcKiTY+Ie/W+wxRsX5oaMBb8DCTag4Bht8hCoF/KmTblofbJfNkfYU2F9MKrxvcQINvpFBRiZ7jqcEsH6wMtyRM9lT6lYs9NN+FNxZctqCvAeNxddnAt8ELxd01Xur1tVU5DYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th70hAwF; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th70hAwF"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso216065e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269076; x=1790873876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHwO3j/RIPR4z1fmP4SyMJijhlNUwLOE+OCR6slMEFE=;
        b=Th70hAwFMG1Of42KkCffhSjhCni/rUgdQEkRp52aUPrFqtHo2psgHw/I48XvvZ8GKN
         52lAnrV8wlsWbhlgfcRMDBsFhGOl4nGWBYPDc8/zTMylNrRBIrGPBEmHpGhITIGrMNRG
         Idjz1dsM7Medn9jU19ypvQKKahFquQAjrZx1hpbw7ergzxTAE4yo3KfVxU7JJ/fiIN8k
         DvP1jI0j96tRQ68/x53s7mWaQ6pMg7UXoGgk8+ehH4U34gUL+KBV9F3bleE5HdD5Pw4G
         dxAisnDFBA4wHxHx6J0ch9Ni8lXfLCcdsC8Eu5E1Cd8wBPt2pzKzbwOha0jBVh3pP60r
         0xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269076; x=1790873876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHwO3j/RIPR4z1fmP4SyMJijhlNUwLOE+OCR6slMEFE=;
        b=qdAY82ZuJ6lczIwJAZmDBbL/dD9gP7fTyxxKuCek1cdcpaj4MgRc+5wieF6MJDoJiX
         pC1jNF4fA6hEu35dfyFHdTdMMglWgxQSE6sWHNNORWrduBNX1c1rwG32l3NDyI/fGyqU
         oEdSgpLrOVF4LwZb24Q4NOCEScLl7n0fbNacxVQA5XDkor7d1k+lLwNJ6pJ79ejnJceH
         kL0Yeq4NsjoiY4wEjIW7J2iUs+39K+JEhsluBMGhTdKY5bq660Z6b9Mk9jo3KbtPSVld
         6YAgC7nYHABqsZiT/8gXrq/BgsgBCwytOkjO4R+N4OUZgFioeGM7kF8d5v1vC1S6P8gB
         dgSA==
X-Gm-Message-State: AFuF++k65xb2r4xka3i6gsg/WQ1wE9/1MQClyi5arw/P+Bw3MiVB/YC/
	oafggCBNyydwjEsGvG/a5ayUxbpBTDn9WBiAs0HOg/2M2YpIEcdYM/V9DDmeTo+W
X-Gm-Gg: AYBFou1YZiK0pUPYqOqAVuys7r2AIBrmetJs42+7kSKXVkWzL/el1HDmuxpy5azGs7m
	W1LZbmRojLuqinUgZhCbhaNquoDGSYeylGV85Y7/tols7B7fNYiO1EltqClxkWiodVexZ4jTeZN
	5Grq20+E0JFzcJn8pVmc/DubWAV6IqqjC0a/wsx87l2Qlff9s68Xz4JPCTIqwq89WN9HoiFLy+2
	gqz2SWkAdJ2A572zEsg1S/Sh24e90tqNJwVXUzjaDr0FRQkQWJG1ud/0LGL+YzEngxAnxeONZ6k
	v8iTBHUXpFVUo3EDdS68JTE2hbfexJ559plsJCWw2zIAvY8f2RtQ+wXC62AASGMEQnBsrf760cp
	9jxacMfDandsx/aw4qL0JjOL79jmpTDCukwPv0El0PqwEgEDS2+HD9O4WFst1CBf3k/nqiCuhnK
	r+YkXVE5qfXxdgZwNo8C0OHNXFAhsI5wWOJj5Z2lKrY2JiBQ/xftO3YzyfJd0Vd2tzVd6vtFBlb
	qO1m0HZrz22YYw457lfSrX6KapSuvsIju8ypofKzFg/xLtUId1Mduqo8WgP5FS5gToOqJAeH7Y5
	drAN6YYDmWemtIy+mnv3zqSnGF0fyzBJ8NfpxQ==
X-Received: by 2002:a05:600c:4ed2:b0:49f:e3f2:f5a3 with SMTP id 5b1f17b1804b1-49fe6685393mr56586775e9.0.1790269075881;
        Thu, 24 Sep 2026 09:57:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm119075455e9.3.2026.09.24.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/18] bpf: Grow the verifier id scratch on demand
Date: Thu, 24 Sep 2026 18:57:09 +0200
Message-ID: <20260924165740.2146806-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9646; i=memxor@gmail.com; h=from:subject; bh=O732tdMK6vNIOSVP3C0a6xsUs+ygTdP/iGjmOfDgclM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraOHHoH1Rb581mF5X1JuVOumUzarP5z88yW9bMm0jd /Xs6bt6O0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR2mpGhvaXPp1NUofWbHuw p6O5wy4/sm1T260y6XU9H05c8fg4awPDf89HFf1xug8DeyVmF+42LTlibb/0ZOAEsTCnU26T7Ju 5eAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The id map used to compare the ids of two states, which also serves as
the id stack of release_reference() and as the id set of
bpf_clear_singular_ids(), is a fixed array embedded in struct
bpf_verifier_env and sized for the most registers and stack slots a
state can possibly hold: 1312 entries, 10 KiB, for 512-byte frames, and
four times that once frames may reach 2 KiB, which pushes the env
allocation from 64 KiB to 128 KiB for every program verified. States
compare a few dozen ids in practice.

Turn the map and the set into arrays grown on demand, starting at 64
entries and doubling, and free them with the env. A map that cannot
grow treats the states as different, an id set that cannot grow keeps
every id of the state, since its counts are then incomplete, and the id
stack reports -ENOMEM, which release_reference()
hands to its callers. The iterator destroy path used to warn on any
failure of release_reference(), which could only come from a bug while
the id stack could not run out of room; it now returns -ENOMEM and
keeps warning about anything else. An allocation failure thus fails
the load and is never unsafe. This removes the last structure whose
size scaled with the stack bound and shrinks the env by 10 KiB.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 29 ++++++++++++---------
 kernel/bpf/states.c          | 44 +++++++++++++++++++++----------
 kernel/bpf/verifier.c        | 50 +++++++++++++++++++++++++-----------
 3 files changed, 83 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d3c31105a3ac..c5f2e18b7e54 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -409,10 +409,7 @@ struct bpf_jmp_history_entry {
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
-/* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
-			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -863,18 +860,27 @@ struct bpf_id_pair {
 	u32 cur;
 };
 
+/*
+ * Scratch map from the ids of one verifier state to those of another, also
+ * used as a stack of ids. Grown on demand by bpf_id_scratch_reserve().
+ */
 struct bpf_idmap {
 	u32 tmp_id_gen;
 	u32 cnt;
-	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
+	u32 cap;
+	struct bpf_id_pair *map;
 };
 
+struct bpf_idset_entry {
+	u32 id;
+	u32 cnt;
+};
+
+/* Scratch set of ids with a use count each, grown on demand */
 struct bpf_idset {
 	u32 num_ids;
-	struct {
-		u32 id;
-		u32 cnt;
-	} entries[BPF_ID_MAP_SIZE];
+	u32 cap;
+	struct bpf_idset_entry *entries;
 };
 
 /* see verifier.c:compute_scc_callchain() */
@@ -983,10 +989,8 @@ struct bpf_verifier_env {
 	 * via callx. Allocated when the first such edge is recorded.
 	 */
 	unsigned long *callx_edges;
-	union {
-		struct bpf_idmap idmap_scratch;
-		struct bpf_idset idset_scratch;
-	};
+	struct bpf_idmap idmap_scratch;
+	struct bpf_idset idset_scratch;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1252,6 +1256,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5c7169bfb4e9..a1f7b4a87502 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -335,21 +335,18 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 			return false;
 	}
 
-	/* Reached the end of known mappings; haven't seen this id before */
-	if (idmap->cnt < BPF_ID_MAP_SIZE) {
-		map[idmap->cnt].old = old_id;
-		map[idmap->cnt].cur = cur_id;
-		idmap->cnt++;
-		return true;
-	}
-
 	/*
-	 * idmap slots are bounded by the number of registers and stack slots.
-	 * Since referenced dynptrs acquire intermediate references that do
-	 * not live in either, so the map can be exhausted. Since it is unlikely,
-	 * fail the verification by treating the states as not equivalent.
+	 * Reached the end of known mappings; haven't seen this id before. If
+	 * the map cannot grow, treat the states as not equivalent, which only
+	 * costs pruning.
 	 */
-	return false;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt, sizeof(*map)))
+		return false;
+	map = idmap->map;
+	map[idmap->cnt].old = old_id;
+	map[idmap->cnt].cur = cur_id;
+	idmap->cnt++;
+	return true;
 }
 
 /*
@@ -967,6 +964,27 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	return true;
 }
 
+/*
+ * Make room for one more entry in an id scratch array, doubling it as needed.
+ * Returns false if it could not grow; callers then treat the id as unknown
+ * or the states as different, which is always safe.
+ */
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size)
+{
+	u32 new_cap;
+	void *p;
+
+	if (cnt < *cap)
+		return true;
+	new_cap = *cap ? *cap * 2 : 64;
+	p = krealloc_array(*arr, new_cap, elem_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!p)
+		return false;
+	*arr = p;
+	*cap = new_cap;
+	return true;
+}
+
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
 	struct bpf_idmap *idmap = &env->idmap_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7b1142b0d51..c89f89c83dfc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1041,7 +1041,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1051,8 +1051,12 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->id));
+		if (i == 0) {
+			err = release_reference(env, st->id);
+			if (err == -ENOMEM)
+				return err;
+			WARN_ON_ONCE(err);
+		}
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -10525,8 +10529,9 @@ static int idstack_push(struct bpf_idmap *idmap, u32 id)
 		if (idmap->map[i].old == id)
 			return 0;
 
-	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
-		return -EFAULT;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt,
+				    sizeof(*idmap->map)))
+		return -ENOMEM;
 
 	idmap->map[idmap->cnt++].old = id;
 	return 0;
@@ -18951,23 +18956,27 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }
 
-/* Find id in idset and increment its count, or add new entry */
-static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
+/*
+ * Find id in idset and increment its count, or add new entry. Returns false
+ * when a new id could not be recorded, which leaves the counts incomplete.
+ */
+static bool idset_cnt_inc(struct bpf_idset *idset, u32 id)
 {
 	u32 i;
 
 	for (i = 0; i < idset->num_ids; i++) {
 		if (idset->entries[i].id == id) {
 			idset->entries[i].cnt++;
-			return;
+			return true;
 		}
 	}
-	/* New id */
-	if (idset->num_ids < BPF_ID_MAP_SIZE) {
-		idset->entries[idset->num_ids].id = id;
-		idset->entries[idset->num_ids].cnt = 1;
-		idset->num_ids++;
-	}
+	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, idset->num_ids,
+				    sizeof(*idset->entries)))
+		return false;
+	idset->entries[idset->num_ids].id = id;
+	idset->entries[idset->num_ids].cnt = 1;
+	idset->num_ids++;
+	return true;
 }
 
 /* Find id in idset and return its count, or 0 if not found */
@@ -18993,6 +19002,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 	struct bpf_idset *idset = &env->idset_scratch;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
+	bool complete = true;
 
 	idset->num_ids = 0;
 
@@ -19001,9 +19011,17 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+		complete &= idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
 	}));
 
+	/*
+	 * An id that could not be recorded may be shared, and a later
+	 * occurrence of it may have been recorded with a count of one. Without
+	 * complete counts keep every id; clearing is only an optimization.
+	 */
+	if (!complete)
+		return;
+
 	bpf_for_each_reg_in_vstate(st, func, reg, ({
 		if (reg->type != SCALAR_VALUE)
 			continue;
@@ -22693,6 +22711,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
+	kfree(env->idmap_scratch.map);
+	kfree(env->idset_scratch.entries);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.53.0

