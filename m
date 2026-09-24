Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EA481A92
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267525; cv=none; b=WHk8eQHjaqV3Ggqw6ucu4vveK8bu7WCZz38fKVs5nZCYKXz+QtDXYPIrUaDHwqalEJoFUIF2x9xQ2zeFBicKiYPuVXpAsnrxLIAnILlkLP+DvI6Dl8LunKcwM6/NaM5Gpx4g3R5TJHLWo2AzXLkAVqGCMRn8o//FujZ10rg+SlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267525; c=relaxed/simple;
	bh=K0FTOnDAsb5MzQCAKIOoVVR6JZJP2hFCsrK1nuyPVRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ykm9s0LQcqG654x38snEpmXdyE5pkvHX4/VN1Tuxrgy5ANwS8TDKaj49veygjvL3mk/KAtqct9lSXrzlPb3Md3xeBn0lm0+friV4z9zL4Gbu7nB2liYsu/bsStHrauEvIHgaoZLoAp3cU8YGk8a/lvc1/a5m0RQJ0r+vsbVc59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANKg1dmM; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANKg1dmM"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so183405e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267521; x=1790872321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ayAavf38XuGm52qydH21AB8+8RwQ5T64yq8luSf8uw=;
        b=ANKg1dmMn+RoccgA+AHVZa4rqw+qHGe0MQ+T87ClTfkhns70n1O8gq8yPoqXJUltoK
         OhwDOsyulctw++J6YDAxkhMbg8PCd85leWeHhPN3JAHrDMOZ3cFp+8H2xxnTcVOjeklL
         QNMBRhwTcqp/5GBYPZ8DCtMho8lXJqWe/oDjSbXAtY9++tEvHp5Bxhv5o9xsy75bJT72
         f6IcBF8kAPDwbBSOAd5eGs39UQAwn5Hy/YdRFTHbjIJnrAq16shtFb1XiRq1WX5k4+wR
         cCJHBePyJGBedHHWRxClSZDiiTJ3+AyFkxSKHyXjOGOzPc2uRndGT5/wOC50etob6f+O
         vkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267521; x=1790872321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ayAavf38XuGm52qydH21AB8+8RwQ5T64yq8luSf8uw=;
        b=bWNgxBfz9a/aSMYacI5FdP47gN9c+YH1jVELm7axLkJbh9aMuVy7e0QyehxA8crktK
         nPeCjH9nTlYBFbEwu1M018OzJnZ0/tDx5elUj8CrxWieozNTl+Bxqbu00ZcOX+eX1hMF
         N4KPOJWYgh1Xh59t15lxHR1KM0k39cq4diZ7JnlWkDKt7EzelqTOKFD4Ztl7Ds27JK71
         UddOjhvW2VTTAsbnHqoRv/NUqHS/H7Engdv7Q05kW+EzEjr5KOWgid7smnJP8UWkvqMY
         TK8LAgwmr5GvwbyPON6XjsTtX2NcNSRp485BXJ+uj1bIn8pUb438V/o9WOnYAceVy/YR
         y/Zg==
X-Gm-Message-State: AFuF++mE3Hepo98oQ9Fm3U3C/ZDyiCb7tbe8wnCGOd0JTYWV6QkObHHa
	sLJz5YBuRvjuxHVu9Pcai1/zu1qJmgg+C/9Nnw6aDS7aY3wN5DRnNnKJtkeVeYwk
X-Gm-Gg: AYBFou1kR2AYzOVrCtolbHdJF88TlNOrAw2dGG4Z2pRomhaVPuj6pBrQEPY7r0KvF5+
	wrK3pF4fpvln5Gj1R0tDRr9qs0kDZeMa+KDjVmD0ZHtD8XJi44zc/XUXpbJqi1QXmwVyMWZmpWc
	6MxXo43YTwTFZHb4F3Fh3M87PVgorWWxvDimcRIt3ujgOJIUfmlImmkLBUm2aLvVXZ/r4jfU24G
	0kWeJEqVfe86DAN/tkMGQOn06MgMUpjzVmTQRO8sVwFv/rRSG9tch89sYM2qtumTi4Oml0x2aTI
	ZSW3BgZj/iR5wYCrTsQDPwXHkrIFFUPLDlcilRNKfKCIhCfoRTlpocxMG48K0iIjOspeHRPpd3o
	Ft8q6kDE8tqO/rubKIJk+Gx8aWrn45StvpESbSonS47rTEubHWUnYaB8RGmvM056TlE+i/EWk+o
	1MtIjfMyupfzikuGZawTT+GhqpQBFHNkcDoX0XEvRlcL/H+lriyU7LZhQCn5QhhhybqJ6KoEHh+
	vGM7pAHFv5E8e0qM33bo4BsBuUrIdrTal18cTsQVY08NogTFqlRg86xKGMTtSQjpngPLa71AuID
	6hQe46yHJxV+T3SkZEGLTxliT17t7CA9xYORnw==
X-Received: by 2002:a05:600c:a416:b0:49c:fc6c:be0d with SMTP id 5b1f17b1804b1-49fe67bc287mr49944115e9.19.1790267521148;
        Thu, 24 Sep 2026 09:32:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd42f2sm82843395e9.15.2026.09.24.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/18] bpf: Grow the verifier id scratch on demand
Date: Thu, 24 Sep 2026 18:31:22 +0200
Message-ID: <20260924163144.1945455-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9646; i=memxor@gmail.com; h=from:subject; bh=K0FTOnDAsb5MzQCAKIOoVVR6JZJP2hFCsrK1nuyPVRs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7+uHazksue/Yt5zqmFTw+dtkE7dZgqzrlHatv85+/ mRG5bxZHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIMhFGhmtMe20eat4K19J2 UYv+9dFwR+31heteXhD6bOgVreL6qICR4dk2nxobAf1yheeqvmFvtv2+fOsLt8zjBXcXN56cu0o 4lBUA
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
index b314b9425b86..3ff1d4f753d3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -408,10 +408,7 @@ struct bpf_jmp_history_entry {
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
-/* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
-			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -861,18 +858,27 @@ struct bpf_id_pair {
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
@@ -981,10 +987,8 @@ struct bpf_verifier_env {
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
@@ -1248,6 +1252,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index a7c87a1d8cc8..a07af8f11a5a 100644
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
@@ -965,6 +962,27 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
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
index 8b7f2c283e5a..0a8796a12f1a 100644
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
 
@@ -10506,8 +10510,9 @@ static int idstack_push(struct bpf_idmap *idmap, u32 id)
 		if (idmap->map[i].old == id)
 			return 0;
 
-	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
-		return -EFAULT;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt,
+				    sizeof(*idmap->map)))
+		return -ENOMEM;
 
 	idmap->map[idmap->cnt++].old = id;
 	return 0;
@@ -18887,23 +18892,27 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
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
@@ -18929,6 +18938,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 	struct bpf_idset *idset = &env->idset_scratch;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
+	bool complete = true;
 
 	idset->num_ids = 0;
 
@@ -18937,9 +18947,17 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
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
@@ -22612,6 +22630,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

