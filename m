Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F24BFE81
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278452; cv=none; b=BfveqVrsxeMSBhGAgzOsF4y6UlLFzIYcsBL9w9lLxpkQC9AMXMJ0Q4y3OQ6UwCkOALkFssy3XiL75WjweNN9teKanu3d2xFZwRYGRbgSRLbG1+aWAjt1oOhbM02i2FiH8ZN+3h7/Kx9ApvedUgFvTZ/Ch7bMIMFePAEr5q3VStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278452; c=relaxed/simple;
	bh=1cHflBFa7MXRprmcxaPGtzF2PQD9CSurwue4VHkXruU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgB0mzyrsy8gwDBmHNHoKaHP4ygW9vOz4Gh2XKoZkTvgnmzQ4NT1vgbIR9DM0aSHYIyL6rWSRn058zPXFiktV9VYYRNjFJAyh6S2l/GDSGPsMkmgb7EpIaxBvN6Aq7/telx835fjAJ3gpg75bn26ELbN0cxkZEcC3cEo3tOHKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCVvzxh8; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCVvzxh8"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so92035f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790278447; x=1790883247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KShod/ogDjVZKlSiidsb1WJl2E9yT6W0rAzz8dAiSAk=;
        b=bCVvzxh8UEzeea1SBv7hxh3BVTsN6iy9ZwCjyC6YceMU6I+WDEAD/Gb5/82XkN69/e
         U43rYmUZQUU1ud7zh+uGkhQ/8ttdbdjAisVOOCPIoKm2N4AUOBU7O5+O2/paKZdBL3MV
         M+tPMCDRJYimL+/IaLh1Fw3ydKYH/Os/kSNUui6x1TcJatZJ/jFjUG8l1vupNj3MAxUI
         WDFcf6kT5IbPA0gRHmhCafW94/Y+CqgM/3XVaM7ty/b+Lqs2AMxkIYYE23UvtJk+/ngV
         BwA7hH/l3JKquSrvcCvPm8ZJ2jOT9lA3WyIrqfIZX7JIgQiLPdx5kTSTNMHsM6Ryqziz
         gdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278447; x=1790883247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KShod/ogDjVZKlSiidsb1WJl2E9yT6W0rAzz8dAiSAk=;
        b=eSeZDCX+dkVOmZdOcZLgcJ76mQvBaKeBKxCQo3FJ8V/AQLg3292bGL9+1/GB8f+3T4
         bMk5c2bxP9opc4RHKMRily1/VASG74sbs2GB1XHo4CHiZd2eobhKPrpFruXht1g1qVW4
         efwt9SANvQZ/lqeDI3jzD0zCqThmgooOgSG1ipOjXYFyHdKvTqnqTm7kQFzS4/bx9ZxO
         Lu3gbaC4+KoG319E/WOy1iB44WXAO+/F4gy9pfvf46hPXyGMWFuPBiIrTjxxZWJId3Ff
         8oKq3ymLYAkm7qgPx5948xmMA7B/WTVkS4KcJt+YEMU6IWVl544XvpaeJa/IZwOs5HL+
         BtCA==
X-Gm-Message-State: AFuF++lmZp/E22Pl14C9gZ9UE/ZTS7jPpB18N62vDMUxGupOeZ9x03Zp
	/ZCFesKFgJxBebKWeVNhcAmy4rhfnWRK6GyPocTH5WhnO6xBRdnOA9icSXJ7jajL
X-Gm-Gg: AYBFou3IqW7fdRzfRvK9sU5IbxSSryjNjOqPmlLGuHY/LZ3zDWUCNS86jIF5YOQ7Fxq
	QLb3DP6eeOq6M79qzzBlLXKWF9ptj6zVq9iyPdpT3bmm1o4hgiNy4v5ypFXOFz/ZhAJJ7cKQRU1
	V7faCYT75fCeHOxLsUbF4PaYIE2G3qtqum9oqNuStjMBZEYIzuBGUV2ZRhAlUwIxQrORA/Snnxj
	RBjTprnvkMBq0/v1vmRKBYmSxCz1JueDpfri3vl/9puHs/970iEbN3Z7b3/gl/rf3lnejIzORvW
	IvOU+HQeE2/mbk6v5YZ2MlEImBaoioOnp8ruiEsePWKbH+BUCengnGQGx/FhbxxjCT7ZUeEZfUk
	qV1/eFHM49X+DuQL5WOUvDiOe9eNW+KEzjZEmP6ZOqpgKTGc4zwYvk2lqFbJQzLqMRJvYzRlJfw
	eaBx7LBuTWzTiXqNGOrTb2ZFXX9WjomIW4bE/KLXlvImjNXDc9cC5fOfCk0jEk5H3tXdWYhpzDo
	GgtR+bDLOU5LQ45SRx0Iwi2Hy60g6z3HCqSXLDBcG3YMsdMpdVqftsJS0VxOkbNTHrSk/XxFhMU
	opXmhmFixEYNkZO8/ffaq3ZWXXN6cQDeGQXZqQ==
X-Received: by 2002:a05:6000:2083:b0:487:27f9:844 with SMTP id ffacd0b85a97d-4887172ac0cmr6021835f8f.57.1790278447186;
        Thu, 24 Sep 2026 12:34:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ed6esm1271324f8f.29.2026.09.24.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:34:06 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf: Return the id scratch to a fixed array sized for the stack budget
Date: Thu, 24 Sep 2026 21:34:01 +0200
Message-ID: <20260924193403.3032037-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9f3d900a69be ("bpf: Grow the verifier id scratch on demand") turned
the id map comparing the ids of two states, which also serves as the id
stack of release_reference() and as the id set of
bpf_clear_singular_ids(), into arrays grown on demand, so that the env
would not embed a map sized for 2 KiB frames. That gave the map a way to
fail, and with it release_reference() and the iterator destroy path an
-ENOMEM to hand up, states_equal() a case where states compare unequal
for lack of memory, and bpf_clear_singular_ids() a flag to keep every id
when the set could not record them all.

The env is allocated once per program load, so the map can afford to be
sized for the largest state again: MAX_BPF_STACK_SLOTS in each of
MAX_CALL_FRAMES frames, which a state on a private stack can reach since
every frame there may use the whole budget. That makes the map 34 KiB
instead of 10 KiB, a small price per load for having no growth that can
fail. Make the map and the set a fixed union in the env again and drop
the growth and its failure handling.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DLNQW1IRYK94.1DP0M5VKZSY32@gmail.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 29 +++++++++------------
 kernel/bpf/states.c          | 44 ++++++++++---------------------
 kernel/bpf/verifier.c        | 50 +++++++++++-------------------------
 3 files changed, 40 insertions(+), 83 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1c787208ff82..646e447cebd8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -411,7 +411,10 @@ struct bpf_jmp_history_entry {
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));

+/* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
+#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
+			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -866,27 +869,18 @@ struct bpf_id_pair {
 	u32 cur;
 };

-/*
- * Scratch map from the ids of one verifier state to those of another, also
- * used as a stack of ids. Grown on demand by bpf_id_scratch_reserve().
- */
 struct bpf_idmap {
 	u32 tmp_id_gen;
 	u32 cnt;
-	u32 cap;
-	struct bpf_id_pair *map;
+	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
 };

-struct bpf_idset_entry {
-	u32 id;
-	u32 cnt;
-};
-
-/* Scratch set of ids with a use count each, grown on demand */
 struct bpf_idset {
 	u32 num_ids;
-	u32 cap;
-	struct bpf_idset_entry *entries;
+	struct {
+		u32 id;
+		u32 cnt;
+	} entries[BPF_ID_MAP_SIZE];
 };

 /* see verifier.c:compute_scc_callchain() */
@@ -995,8 +989,10 @@ struct bpf_verifier_env {
 	 * via callx. Allocated when the first such edge is recorded.
 	 */
 	unsigned long *callx_edges;
-	struct bpf_idmap idmap_scratch;
-	struct bpf_idset idset_scratch;
+	union {
+		struct bpf_idmap idmap_scratch;
+		struct bpf_idset idset_scratch;
+	};
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1264,7 +1260,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
-bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index a1f7b4a87502..5c7169bfb4e9 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -335,18 +335,21 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 			return false;
 	}

+	/* Reached the end of known mappings; haven't seen this id before */
+	if (idmap->cnt < BPF_ID_MAP_SIZE) {
+		map[idmap->cnt].old = old_id;
+		map[idmap->cnt].cur = cur_id;
+		idmap->cnt++;
+		return true;
+	}
+
 	/*
-	 * Reached the end of known mappings; haven't seen this id before. If
-	 * the map cannot grow, treat the states as not equivalent, which only
-	 * costs pruning.
+	 * idmap slots are bounded by the number of registers and stack slots.
+	 * Since referenced dynptrs acquire intermediate references that do
+	 * not live in either, so the map can be exhausted. Since it is unlikely,
+	 * fail the verification by treating the states as not equivalent.
 	 */
-	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt, sizeof(*map)))
-		return false;
-	map = idmap->map;
-	map[idmap->cnt].old = old_id;
-	map[idmap->cnt].cur = cur_id;
-	idmap->cnt++;
-	return true;
+	return false;
 }

 /*
@@ -964,27 +967,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	return true;
 }

-/*
- * Make room for one more entry in an id scratch array, doubling it as needed.
- * Returns false if it could not grow; callers then treat the id as unknown
- * or the states as different, which is always safe.
- */
-bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size)
-{
-	u32 new_cap;
-	void *p;
-
-	if (cnt < *cap)
-		return true;
-	new_cap = *cap ? *cap * 2 : 64;
-	p = krealloc_array(*arr, new_cap, elem_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
-	if (!p)
-		return false;
-	*arr = p;
-	*cap = new_cap;
-	return true;
-}
-
 static void reset_idmap_scratch(struct bpf_verifier_env *env)
 {
 	struct bpf_idmap *idmap = &env->idmap_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 865b6c6eb8dd..955f1650163c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1041,7 +1041,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j, err;
+	int spi, i, j;

 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1051,12 +1051,8 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;

-		if (i == 0) {
-			err = release_reference(env, st->id);
-			if (err == -ENOMEM)
-				return err;
-			WARN_ON_ONCE(err);
-		}
+		if (i == 0)
+			WARN_ON_ONCE(release_reference(env, st->id));

 		bpf_mark_reg_not_init(env, st);

@@ -10531,9 +10527,8 @@ static int idstack_push(struct bpf_idmap *idmap, u32 id)
 		if (idmap->map[i].old == id)
 			return 0;

-	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt,
-				    sizeof(*idmap->map)))
-		return -ENOMEM;
+	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
+		return -EFAULT;

 	idmap->map[idmap->cnt++].old = id;
 	return 0;
@@ -18959,27 +18954,23 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }

-/*
- * Find id in idset and increment its count, or add new entry. Returns false
- * when a new id could not be recorded, which leaves the counts incomplete.
- */
-static bool idset_cnt_inc(struct bpf_idset *idset, u32 id)
+/* Find id in idset and increment its count, or add new entry */
+static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
 {
 	u32 i;

 	for (i = 0; i < idset->num_ids; i++) {
 		if (idset->entries[i].id == id) {
 			idset->entries[i].cnt++;
-			return true;
+			return;
 		}
 	}
-	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, idset->num_ids,
-				    sizeof(*idset->entries)))
-		return false;
-	idset->entries[idset->num_ids].id = id;
-	idset->entries[idset->num_ids].cnt = 1;
-	idset->num_ids++;
-	return true;
+	/* New id */
+	if (idset->num_ids < BPF_ID_MAP_SIZE) {
+		idset->entries[idset->num_ids].id = id;
+		idset->entries[idset->num_ids].cnt = 1;
+		idset->num_ids++;
+	}
 }

 /* Find id in idset and return its count, or 0 if not found */
@@ -19005,7 +18996,6 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 	struct bpf_idset *idset = &env->idset_scratch;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
-	bool complete = true;

 	idset->num_ids = 0;

@@ -19014,17 +19004,9 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		complete &= idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
 	}));

-	/*
-	 * An id that could not be recorded may be shared, and a later
-	 * occurrence of it may have been recorded with a count of one. Without
-	 * complete counts keep every id; clearing is only an optimization.
-	 */
-	if (!complete)
-		return;
-
 	bpf_for_each_reg_in_vstate(st, func, reg, ({
 		if (reg->type != SCALAR_VALUE)
 			continue;
@@ -22737,8 +22719,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
-	kfree(env->idmap_scratch.map);
-	kfree(env->idset_scratch.entries);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
--
2.53.0

