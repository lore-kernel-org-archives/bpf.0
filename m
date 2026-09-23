Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409754B1C6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190721; cv=none; b=Gp+hoH1ZTKDLPK1xO8PyD/CMgfF/5N5nygqRvOQilYrfMgWUprE/us/J967fIKmm13wUnsnBeepwzwQfIJxNFD0B2wCKB+Ipndq1ri17dQvZ9Swa2iHdMZsbgYIANxeXRXjr1gqvQfJSXeHjKybNoAD6qAQLy4mC5WSC7SQdH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190721; c=relaxed/simple;
	bh=aYrYwX8zFsQk5ctH574vdVOZgA1xzSo75U+lc9Ddoc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkkFAhIFNRMAq+ypTVUGXwYrp40+ovL4X1yv8W4tVTCeF9pjkpC9jBnNiZDj3CG+O7nVSOyrfRPaMFhqIoqQZsKIoo+2nPmPbbN5mFdyS+Vq159RalDeEkp4g/gZAUU7I2cWfFpdwBEis9qu7+qv8Xj5rCObWlaKAw3pBvOWlU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDAXSlCR; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDAXSlCR"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso4176835e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190717; x=1790795517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82sfZXTvOoPqh4CwzCUuEiioBDVQFJU8AA54Ee/lyWw=;
        b=fDAXSlCR27jhIzhHX5Un9Um/BEzvPCicLjpyihq8ZNgNAUhgulfuZgbSBOzbfRMPjG
         9nSGzIxlI2HdjNJGieT7b+Qjsn1jEmiwQcX/HpM6ebeBY+PvXbTT/VI1DsE/tU/GoJWw
         JoOVp0DzpTZD1+k4CENtKeBDFKtGUINC/eY/rShsiAnncQAoYE6oSLFfhWcHIIeRxijm
         BjOZTtwBVvZYinX8ee3bpg40IMX8zMdok/nug5VUacNtZ6B1aU0F1wpEjzWWSMtHyDLZ
         o5I9wfjotEnA8AA//M7VnuMDq3ur/wXe1mQSrS/VqlOF24YRBiyTTEoDGmiKRzM6ZQN4
         hi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190717; x=1790795517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=82sfZXTvOoPqh4CwzCUuEiioBDVQFJU8AA54Ee/lyWw=;
        b=PqdcZQLdiDdetPow5LsA+Ahb7tlmqOSrGjI7kNggsigIaaA3z21jzQMhcpN5LuNP57
         ROBmf8AHHSVgDJbNzMDGkTQ4gbYllEBCft5zG7NsXtdz2dyzLDbtS/nlH89zkDGksbRT
         h/VUpDRQhRlqgX+DGtnwMXvMlgfoSHJS+mzaQMYN4paugTg71Xk6Bg/2HU5/e/lEFq56
         xwvvs1MYUS8mgjbnuGgk5pK750j0Ef04MIuUbvH8ZDr5aKaiJLA9uIWL6rHZT+08RYL4
         QVd10PPXRl9K5mFKQlRzWRvbprIOBPcL1nqyrlPDR0kMD99+c5XvhnacUwhxBkHXsHAh
         e5yw==
X-Gm-Message-State: AFuF++mkrhaU+Phf/P7PfmiMXYiPwEsmqc6PJ9i83kb+QEiiNxUaOG/4
	hBrSHtEuHl14KKYng9Glz9pg+eya3mx3gf74hNn3sw44LLf309uhXyhJB2seUHwt
X-Gm-Gg: AYBFou32saMvrZLRz/OCT83V+71mQ05o1iOjL0bcMGd5zwOBGI5ugBGWy7ZHNW8lxEJ
	23sDO/kvx2aaZwxY5fk2gGugYKCEq/6yzxVrAjMI/E/kHdTykUBsY94zJ3NBJSEMm6Fk05pnTHp
	mBJgorZ70f+tUP+grLljUAOM/YeYDkPUy8oS5NGQhbkSyrlzo5U2B57l3wIBmBQw8XAA1BuK+8T
	VXmzKix+8/RHXJEi9717NO5Pz3H60cPsPWVljamXAub5mdrEXSXet+6IKi7V/9gMPaJ6LSlZ9oD
	VxcyhQ2cFknaztrgPyvdnpAzjkVlB6iwRvv97q8x6UfSvSjlREsM48RtefyhZPjj00w2Agz39VS
	+MjN5m8ulxJIorhwXgyj97W+p+R4yY1PxfeILU17kLL91Abh2SgsPiZxc1MO+WMk/dVrF57aOGj
	g6Q9xrgvbo4adJNN7FMv8L/vCNkCluRItNNIwqyCV8oEqR+wFitxezc95nMnGY4RZKkhBNt7w9P
	hV3xVcRABoAoSQ626OEXDCAcGcJkt0af+Tu+0JqfgRIjRI3PeaKX3XV6luI9598XXvy4T6Rj+Lq
	V4eGq5toax3w1yV3+BgE9W7Ricy8m5sN9WHthQ==
X-Received: by 2002:a05:600c:8b5b:b0:49f:c196:47b9 with SMTP id 5b1f17b1804b1-49fe66c8bb6mr3109745e9.4.1790190716939;
        Wed, 23 Sep 2026 12:11:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cca160sm6911625e9.12.2026.09.23.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 08/18] bpf: Grow the verifier id scratch on demand
Date: Wed, 23 Sep 2026 21:11:15 +0200
Message-ID: <20260923191139.2816206-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7287; i=memxor@gmail.com; h=from:subject; bh=aYrYwX8zFsQk5ctH574vdVOZgA1xzSo75U+lc9Ddoc8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4rcP63Rb/ZNr126InNxe28/i8uU1L3vKLzVl0VUCD WqrvrF1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKGkxj+Gfy7H36y6tfTf2Fx HoXi2+2ORlzJNFjG8Ubm4ve0w69yZjEyLBL6vU/wqZb+Ce8rOSG2ykfMTHMS49exntW6s2l9tV8 CDwA=
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
the id, and the id stack reports -ENOMEM, so an allocation failure is
never unsafe. This removes the last structure whose size scaled with
the stack bound and shrinks the env by 10 KiB.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 29 ++++++++++++++----------
 kernel/bpf/states.c          | 44 +++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c        | 20 +++++++++-------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0f348ce81fe2..d8cafd3d74aa 100644
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
@@ -842,18 +839,27 @@ struct bpf_id_pair {
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
@@ -948,10 +954,8 @@ struct bpf_verifier_env {
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
-	union {
-		struct bpf_idmap idmap_scratch;
-		struct bpf_idset idset_scratch;
-	};
+	struct bpf_idmap idmap_scratch;
+	struct bpf_idset idset_scratch;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1209,6 +1213,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
+bool bpf_id_scratch_reserve(void **arr, u32 *cap, u32 cnt, size_t elem_size);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			 int insn_flags, int spi, int frame, const u16 *linked_regs,
 			 u8 linked_regs_cnt);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index e84f37d724d5..5078e4832c6e 100644
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
index d8f43f3a8991..8641f1a8d017 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10136,8 +10136,9 @@ static int idstack_push(struct bpf_idmap *idmap, u32 id)
 		if (idmap->map[i].old == id)
 			return 0;
 
-	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
-		return -EFAULT;
+	if (!bpf_id_scratch_reserve((void **)&idmap->map, &idmap->cap, idmap->cnt,
+				    sizeof(*idmap->map)))
+		return -ENOMEM;
 
 	idmap->map[idmap->cnt++].old = id;
 	return 0;
@@ -18438,12 +18439,13 @@ static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
 			return;
 		}
 	}
-	/* New id */
-	if (idset->num_ids < BPF_ID_MAP_SIZE) {
-		idset->entries[idset->num_ids].id = id;
-		idset->entries[idset->num_ids].cnt = 1;
-		idset->num_ids++;
-	}
+	/* New id; one that cannot be recorded counts as shared and is kept */
+	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, idset->num_ids,
+				    sizeof(*idset->entries)))
+		return;
+	idset->entries[idset->num_ids].id = id;
+	idset->entries[idset->num_ids].cnt = 1;
+	idset->num_ids++;
 }
 
 /* Find id in idset and return its count, or 0 if not found */
@@ -22003,6 +22005,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	kfree(env->idmap_scratch.map);
+	kfree(env->idset_scratch.entries);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.53.0

