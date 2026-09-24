Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E053DC4CF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219483; cv=none; b=Vnn/VCUulbvBvdFX5I0q6Sb9x8fee1LU7BazJ0PIIXL+9ddC0RsXPRWxufVDzu8SJpVI0Rfv0+kt6/7XuLhp03QERCZsVvrEqg/Suss8bIx131yQlQaEZr1t1bZkQigfJlxB+zI3kldE9+D+IDChtnwSTSzswPpuGJq+xfmqXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219483; c=relaxed/simple;
	bh=SqR5Xr4Nc4ekHGOm6sgqVXXxR0XCcCcLIh8J/3zyB94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhZtlaHNykep/wC496g4sZug4EfK4g4/j9AczIyHPbYuDxYmekyrDzJ9kx17XmKfqSKv93LXpF3XQ8OeJY6/RpZy4CxawUwfRMte6/GphExiyN9DkqUqES0jsMGG/7B0luC2V150vLvEZ8EhhZ1wNq+lKq/myx3hVliaJ2u4cXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXZLKTdP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXZLKTdP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso6831415ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219480; x=1790824280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbIZQE7PyDhKzAJQTzVgKxEVSmZ1ZRP964/gamd3SWA=;
        b=gXZLKTdPDBE/z5+PHy6YNNgVrAH+n2VTJkEbmQe2zfyOkWgVjRQgBSJETm3F11cRCe
         4ty+y2K/k2e2ZXsiHdwq3P0zYxMoTelIpDTLND3Xiat8lJnuF53bGxhiWpT42A25tlL6
         0QxV0wt2Nm+iNS43IybZqQeJFvVB9z0DUb0M/V0m+krZNZ59we7gHrA+fMpwrV8TucxZ
         rDCw6w0UGIRiIbTtDukLjvPnD66upR4WPbzKt17tS2KJSBloDbRIRtfp7aS+YajCQmt3
         agQ301SFaMRfZ4VdfqXR5ZTQieZMSo11EFefl8ZC/8g8FLEe2x3CrcK9qogMABv6jWC3
         IUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219480; x=1790824280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cbIZQE7PyDhKzAJQTzVgKxEVSmZ1ZRP964/gamd3SWA=;
        b=dUE7eZvN1RM3U4g9eCsRqN0NiOQBC55/1ZoVtstrLIHBIO/FMLzNJP0zvQ0oEsVB2e
         2x4KpEkyYMGnbLYaM3LvioWe1nyGj64kXZEjTpJgzFFX3K8ZWz2Oigy4HxBrroCPds03
         usKJlu1bqJghEP87ArBQOyR8YtQ85Zmnw6iODJG0OKUkvo0UVQQwKoEFKtEjI+7XpUs6
         08lJb4OJVpSyCiRgZWADliCBBwnaA3WIUC8YhUqS2TBK3NM56oNnPV9sHcCj0rqPftAF
         dU56uOIJqlUy1x4QZlrv/bqgUr8Ofc8pe+Ol/2GGU6pbV4Jt1p6MtU2wOhMv/R5od2rr
         XEfA==
X-Gm-Message-State: AFuF++kgz9N7M2maChiDk4INccXbGhwG+dZQchAxkFnV43tITSxyDk9B
	JRxMBlCXR/t9CWMFxWmOifWy40gXCcGBZv3PBtWdk0kLymCL6APVDUeOC2uR3Q==
X-Gm-Gg: AYBFou0LvmDw4/Qi60QfPZ1xLUkmS5umE+yuLP+vpWkZkpta9l3ybF4N+bUbetPr3hC
	sxbpIJCMNOyALtIWyGgoPOmNTeKfzy3D90LZin/naGXv8+mkkp6EcSzQktW4bECLDgo939GN1+b
	exykGuuOLHhuT2L1RbGTTPRty+/VFcvUY5G0ZIz9173NU7mH1ALWq7jgWUO/Kvlz80Hvy4LxOHD
	G/EjDsuSZEoWI4+8j+jiJJcS48RFoU8W+dPh56mXpzikeB2qoBgDwjiknBfKxLhMpqGjRSjMyll
	c9cIxrLErmgUISHufcP4kPhBoLPsghmYgSKZBZqwmG5uiwtq5PJ4ELlXR1k2kD+ET+/CRt3Qr2t
	bfBMqB8rMbiPGxHe/mwZ8SySSBEbe4ojyNBm7eTXXmoC0f+zzaW3yB+EnG6mTk1uYVyzBBqDxBk
	KnezWZq888kgyzzsmWQLe9z0i2HhXYQ908S8qLiFY3XNhsfEUDQOYT2VmuQYeEMkQ318uGTif2M
	AN1XBQYhweFj/Nrq/E2zT+Usvf4Dpw55C721OG1n/T3d0CoCgnlVGt91u2havQZvPl5pxTLxdqy
	h7KwHEIlLdUHN8vgZ3GacIYQvKeVAnRohWXTmOzLcKM=
X-Received: by 2002:a17:902:fda7:b0:2dd:c053:d73f with SMTP id d9443c01a7336-2df7dc37ebbmr8849945ad.38.1790219479344;
        Wed, 23 Sep 2026 20:11:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516a32sm18959345ad.4.2026.09.23.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/17] bpf: Recognize pointers to functions in read-only maps
Date: Thu, 24 Sep 2026 03:10:35 +0000
Message-ID: <20260924031042.1690890-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Compilers put pointers to functions into read-only data: tables of
functions, struct ops, vtables, where they're mixed with sizes,
alignments and other data. Rust vtables are like that.
Let callx call through them:

  r6 = vtable ll
  r1 = *(u64 *)(r6 + 0)      // data
  r2 = *(u64 *)(r6 + 8)      // pointer to a function
  callx r2

libbpf keeps such data in a frozen read-only array map like .rodata and
stores the byte offset of static function within the program into
the pointer. The kernel guesses: aligned 64-bit value that is equal to
the offset of a static subprog is a pointer to it. If the guess is wrong
the program either fails to load, since it uses a pointer as a number,
or sees an address instead of the number. Safe either way.

Add resolve_func_ptrs() that scans such maps of a program with callx
after the maps are resolved and before check_cfg(), so all callees of
callx, including the ones referenced by data only, are known before
the main pass. The prog must be the only user of the map and it must
be allowed to leak pointers (CAP_PERFMON), since it reads function
addresses as data.

- check_cfg() treats ld_imm64 of such map like ld_imm64 BPF_PSEUDO_FUNC
  for every function in the map: they're reachable, first insns are
  prune and jump points, effects are merged into the subprog that
  refers to the map.

- 64-bit load of the pointer is PTR_TO_FUNC. If the offset is variable
  (tbl[i]) all possible offsets, given bounds and var_off, must be
  pointers. The verifier forks a state for each. If none of them
  overlaps with a pointer (tbl[i].data) it's a regular load.

- The value of the pointer is not known until JIT, so reject everything
  that would const-fold its bytes: narrow or misaligned loads, const
  strings. bpf_compute_const_regs() skips them too.

- The map has offsets until JIT, so the load of the pointer sets
  jit_required like callx does. Otherwise the prog that reads the pointer
  and passes it to a helper as a callback could run in the interpreter.

After JIT jit_subprogs() replaces the offsets in the map with addresses
of functions. Other progs that use the map were verified with its old
content const-folded, so there must be none. Add 'user' to bpf_map:
__add_used_map() records the first prog that uses the map and marks
the map as shared when another prog comes. Only the sole user can store
addresses into the map. After that no other prog can use it. The prog
that failed to load is not a user. libbpf loads it again to get the log.

The offsets are adjusted when insns are patched or removed, same as
subprog starts. Dead function is removed and the pointer becomes NULL.
The prog may still read it, e.g. when the load is hoisted above a branch,
but callx of it is dead code too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  10 +
 include/linux/bpf_verifier.h |  29 +++
 kernel/bpf/cfg.c             |  76 +++++++
 kernel/bpf/const_fold.c      |   3 +
 kernel/bpf/core.c            |   5 +
 kernel/bpf/fixups.c          |  65 +++++-
 kernel/bpf/verifier.c        | 386 ++++++++++++++++++++++++++++++++++-
 7 files changed, 565 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..9525d3ecd923 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -344,8 +344,18 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
 	char *excl_prog_sha;
+	/*
+	 * Which programs use the map, see bpf_map_claim(): 0 - none so far,
+	 * aux of the program - only that one, the same with BPF_MAP_USER_PATCHED
+	 * set - only that one and it stored the addresses of its functions into
+	 * the map, BPF_MAP_USER_MANY - more than one.
+	 */
+	unsigned long user;
 };
 
+#define BPF_MAP_USER_MANY	1UL
+#define BPF_MAP_USER_PATCHED	1UL
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 931f305fa440..578bccf5cf76 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -786,6 +786,21 @@ int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier_log *lo
 
 #define BPF_MAX_SUBPROGS 256
 
+/*
+ * A pointer to a static subprog in the value of a frozen read-only array map:
+ * a 64-bit value that is the offset in bytes of the first instruction of
+ * the subprog in the program.
+ */
+struct bpf_func_ptr {
+	struct bpf_map *map;
+	u32 map_off;		/* offset of the pointer in the value of the map */
+	u32 orig_off;		/* what the map has: the first instruction of the subprog */
+	u32 xlated_off;		/* the same after instructions were patched and removed */
+};
+
+/* the subprog that a bpf_func_ptr pointed to was removed as dead code */
+#define BPF_FUNC_PTR_DELETED ((u32)-1)
+
 struct bpf_subprog_arg_info {
 	enum bpf_arg_type arg_type;
 	union {
@@ -965,6 +980,13 @@ struct bpf_verifier_env {
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
+	/*
+	 * Pointers to static subprogs found in frozen read-only maps of the
+	 * program, see resolve_func_ptrs(). Sorted by map and map_off.
+	 */
+	struct bpf_func_ptr *func_ptrs;
+	u32 func_ptr_cnt;
+	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
 	 * subprog_cnt * subprog_cnt bits, where bit (caller * subprog_cnt + callee)
@@ -1324,6 +1346,13 @@ static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u
 }
 
 bool bpf_map_is_rdonly(const struct bpf_map *map);
+struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
+				       const struct bpf_map *map, u32 *cnt);
+struct bpf_func_ptr *bpf_map_range_func_ptrs(struct bpf_verifier_env *env,
+					     const struct bpf_map *map,
+					     u64 off, u64 size, u32 *cnt);
+void bpf_adjust_func_ptrs(struct bpf_verifier_env *env, u32 off, u32 len);
+void bpf_adjust_func_ptrs_after_remove(struct bpf_verifier_env *env, u32 off, u32 len);
 int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 			bool is_ldsx);
 
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..0de2f634ef67 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -421,6 +421,76 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
 }
 
+/*
+ * Return pointers to functions in the read-only map that ld_imm64 instruction
+ * 't' loads the address of, or of its value, if there are any.
+ */
+static struct bpf_func_ptr *insn_func_ptrs(struct bpf_verifier_env *env, int t, u32 *cnt)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[t];
+
+	*cnt = 0;
+	if (!env->func_ptr_cnt || !bpf_is_ldimm64(insn))
+		return NULL;
+	if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
+	    insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE &&
+	    insn->src_reg != BPF_PSEUDO_MAP_FD &&
+	    insn->src_reg != BPF_PSEUDO_MAP_IDX)
+		return NULL;
+
+	return bpf_map_func_ptrs(env, env->used_maps[env->insn_aux_data[t].map_index], cnt);
+}
+
+/*
+ * ld_imm64 that loads the address of a map that has pointers to functions
+ * is similar to ld_imm64 with BPF_PSEUDO_FUNC that loads the address of one
+ * function: any of them may be read from the map and called via callx later.
+ * Treat it as a call of all of them.
+ */
+static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
+				struct bpf_func_ptr *ptrs, u32 cnt)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+	int ret, w;
+	u32 i;
+
+	ret = push_insn(t, t + 2, FALLTHROUGH, env);
+	if (ret)
+		return ret;
+
+	/*
+	 * Explore one function at a time like push_insn() does, so that
+	 * DISCOVERED function is a caller of 't' and not the one that waits in
+	 * insn_stack[], which merge_callee_effects() relies on.
+	 */
+	for (i = 0; i < cnt; i++) {
+		w = ptrs[i].xlated_off;
+		if (insn_state[w])
+			continue;
+
+		if (env->cfg.cur_stack >= env->prog->len)
+			return -E2BIG;
+
+		insn_stack[env->cfg.cur_stack++] = w;
+		insn_state[w] = DISCOVERED;
+		return KEEP_EXPLORING;
+	}
+
+	/* all functions are explored, their effects are known */
+	mark_prune_point(env, t);
+	for (i = 0; i < cnt; i++) {
+		w = ptrs[i].xlated_off;
+		merge_callee_effects(env, t, w);
+
+		/* the same marks as push_insn() leaves on a branch target */
+		mark_prune_point(env, w);
+		mark_jmp_point(env, w);
+		mark_jump_target(env, w);
+	}
+	return DONE_EXPLORING;
+}
+
 /*
  * Instructions that can abnormally return from a subprog (tail_call
  * upon success, ld_{abs,ind} upon load failure) have a hidden exit
@@ -453,11 +523,17 @@ static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
+	struct bpf_func_ptr *ptrs;
 	int ret, off, insn_sz;
+	u32 cnt;
 
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
 
+	ptrs = insn_func_ptrs(env, t, &cnt);
+	if (ptrs)
+		return visit_func_ptrs_insn(t, env, ptrs, cnt);
+
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) != BPF_JMP &&
 	    BPF_CLASS(insn->code) != BPF_JMP32) {
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 28dec733e596..b1528adbeb79 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -180,9 +180,12 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 		bool is_ldsx = mode == BPF_MEMSX;
 		int off = src->val + insn->off;
 		u64 val = 0;
+		u32 cnt;
 
 		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
 		    off < 0 || off + size > map->value_size ||
+		    /* so are the addresses of functions that the map points to */
+		    bpf_map_range_func_ptrs(env, map, off, size, &cnt) ||
 		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
 			*dst = unknown;
 			break;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 868350977f0c..273f74068068 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3029,6 +3029,11 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			map->ops->map_poke_untrack(map, aux);
 		if (sleepable)
 			atomic64_dec(&map->sleepable_refcnt);
+		/*
+		 * The program that didn't load is not a user of the map. libbpf
+		 * loads the program again to get the log of the verifier.
+		 */
+		cmpxchg(&map->user, (unsigned long)aux, 0);
 		bpf_map_put(map);
 	}
 }
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 75936842d177..053b24deb471 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -361,6 +361,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, off, len);
+	bpf_adjust_func_ptrs(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -559,6 +560,9 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	/* before subprogs are adjusted, since it looks at them */
+	bpf_adjust_func_ptrs_after_remove(env, off, cnt);
+
 	err = adjust_subprog_starts_after_remove(env, off, cnt);
 	if (err)
 		return err;
@@ -1124,6 +1128,59 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
 	env->subprog_info[env->subprog_cnt].start = env->prog->len;
 }
 
+/*
+ * Replace the offsets of functions with their addresses in the maps of
+ * the program, see resolve_func_ptrs() in verifier.c. The program must be
+ * the only user of such map. From now on no other program can use it, see
+ * bpf_map_claim().
+ */
+static int resolve_func_ptrs(struct bpf_verifier_env *env, struct bpf_prog *prog,
+			     struct bpf_prog **func)
+{
+	unsigned long me = (unsigned long)prog->aux;
+	struct bpf_func_ptr *ptr;
+	int i, err, subprog;
+	u64 addr, new, *slot;
+
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		ptr = &env->func_ptrs[i];
+
+		/* pointers are sorted by map */
+		if ((!i || ptr->map != ptr[-1].map) &&
+		    cmpxchg(&ptr->map->user, me, me | BPF_MAP_USER_PATCHED) != me) {
+			verbose(env, "map '%s' is used by another program\n", ptr->map->name);
+			return -EBUSY;
+		}
+
+		/* it's the address of the value of the map whatever the offset is */
+		err = ptr->map->ops->map_direct_value_addr(ptr->map, &addr, 0);
+		if (verifier_bug_if(err, env, "no value of map '%s'", ptr->map->name))
+			return -EFAULT;
+		slot = (u64 *)(unsigned long)(addr + ptr->map_off);
+
+		/*
+		 * The function that is dead code is removed and the pointer is
+		 * NULL. The program may read it, but callx of it is dead code
+		 * too, see check_func_callx().
+		 */
+		new = 0;
+		if (ptr->xlated_off != BPF_FUNC_PTR_DELETED) {
+			subprog = bpf_find_subprog(env, ptr->xlated_off);
+			if (verifier_bug_if(!func || subprog <= 0, env, "no function at insn %u",
+					    ptr->xlated_off))
+				return -EFAULT;
+			new = (unsigned long)func[subprog]->bpf_func;
+		}
+
+		/* the map is frozen and nothing else uses it */
+		if (verifier_bug_if(*slot != (u64)ptr->orig_off * sizeof(struct bpf_insn), env,
+				    "map '%s' offset %u changed", ptr->map->name, ptr->map_off))
+			return -EFAULT;
+		WRITE_ONCE(*slot, new);
+	}
+	return 0;
+}
+
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog, **func, *tmp;
@@ -1314,6 +1371,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		cond_resched();
 	}
 
+	/* the addresses of all functions are final */
+	err = resolve_func_ptrs(env, prog, func);
+	if (err)
+		goto out_free;
+
 	/*
 	 * Cleanup func[i]->aux fields which aren't required
 	 * or can become invalid in future
@@ -1400,8 +1462,9 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog *prog, *orig_prog;
 	u32 *orig_subprog_starts;
 
+	/* all functions that the maps point to are removed as dead code */
 	if (env->subprog_cnt <= 1)
-		return 0;
+		return resolve_func_ptrs(env, env->prog, NULL);
 
 	prog = orig_prog = env->prog;
 	if (bpf_prog_need_blind(prog)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71b8825ffe1d..fec5a1ae6a4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3120,6 +3120,8 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
+		if (bpf_is_callx(&insn[i]))
+			env->has_callx = true;
 		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
 		if (BPF_OP(code) == BPF_CALL)
@@ -6028,6 +6030,110 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	return 0;
 }
 
+static int cmp_func_ptrs(const void *_a, const void *_b)
+{
+	const struct bpf_func_ptr *a = _a, *b = _b;
+
+	if (a->map != b->map)
+		return a->map < b->map ? -1 : 1;
+	if (a->map_off != b->map_off)
+		return a->map_off < b->map_off ? -1 : 1;
+	return 0;
+}
+
+/* Find the first pointer to a function at or after 'off' in the value of 'map' */
+static u32 func_ptr_lower_bound(struct bpf_verifier_env *env, const struct bpf_map *map, u64 off)
+{
+	u32 l = 0, r = env->func_ptr_cnt, m;
+	struct bpf_func_ptr *p;
+
+	while (l < r) {
+		m = l + (r - l) / 2;
+		p = &env->func_ptrs[m];
+		if (p->map < map || (p->map == map && p->map_off < off))
+			l = m + 1;
+		else
+			r = m;
+	}
+	return l;
+}
+
+/*
+ * Return pointers to functions that overlap with 'size' bytes at offset 'off'
+ * of the value of 'map' and their number in 'cnt'.
+ */
+struct bpf_func_ptr *bpf_map_range_func_ptrs(struct bpf_verifier_env *env,
+					     const struct bpf_map *map,
+					     u64 off, u64 size, u32 *cnt)
+{
+	u32 first, last;
+
+	*cnt = 0;
+	if (!env->func_ptr_cnt || !size)
+		return NULL;
+
+	/* a pointer that starts up to 7 bytes before 'off' overlaps too */
+	first = func_ptr_lower_bound(env, map, off >= sizeof(u64) ? off - sizeof(u64) + 1 : 0);
+	last = func_ptr_lower_bound(env, map, off + size);
+	if (first >= last)
+		return NULL;
+
+	*cnt = last - first;
+	return &env->func_ptrs[first];
+}
+
+/* Return all pointers to functions in the value of 'map' */
+struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
+				       const struct bpf_map *map, u32 *cnt)
+{
+	return bpf_map_range_func_ptrs(env, map, 0, (u64)map->value_size, cnt);
+}
+
+/* instructions [off, off + len) replaced the instruction at 'off' */
+void bpf_adjust_func_ptrs(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	struct bpf_func_ptr *p;
+	u32 i;
+
+	if (len <= 1)
+		return;
+
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		p = &env->func_ptrs[i];
+		if (p->xlated_off <= off || p->xlated_off == BPF_FUNC_PTR_DELETED)
+			continue;
+		p->xlated_off += len - 1;
+	}
+}
+
+/*
+ * Instructions [off, off + len) are about to be removed. It's called before
+ * the starts of subprogs are adjusted. A subprog is gone when all of its
+ * instructions are. Otherwise, e.g. when its first instruction is a nop,
+ * it starts where the removed instructions did.
+ */
+void bpf_adjust_func_ptrs_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	struct bpf_func_ptr *p;
+	int subprog;
+	u32 i;
+
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		p = &env->func_ptrs[i];
+		if (p->xlated_off < off || p->xlated_off == BPF_FUNC_PTR_DELETED)
+			continue;
+		if (p->xlated_off >= off + len) {
+			p->xlated_off -= len;
+			continue;
+		}
+		subprog = bpf_find_subprog(env, p->xlated_off);
+		if (subprog > 0 && env->subprog_info[subprog + 1].start > off + len)
+			p->xlated_off = off;
+		else
+			p->xlated_off = BPF_FUNC_PTR_DELETED;
+	}
+}
+
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
@@ -6552,12 +6658,132 @@ static int require_callx_jit(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
+			      int regno, int subprog)
+{
+	mark_reg_known_zero(env, regs, regno);
+	regs[regno].type = PTR_TO_FUNC;
+	regs[regno].subprogno = subprog;
+}
+
+/* a read from a table of functions branches into that many states at most */
+#define BPF_MAX_FUNC_PTR_TARGETS 64
+/* and that many pointers at most are next to what is read at variable offset */
+#define BPF_MAX_FUNC_PTR_RANGE 4096
+
+/* Count up to 'limit' offsets in [min_off, max_off] that the read is possible at */
+static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 limit)
+{
+	u64 o = min_off, next;
+	u32 cnt = 0;
+
+	if (!tnum_in(offs, tnum_const(o))) {
+		next = tnum_step(offs, o);
+		if (next <= o)
+			return 0;
+		o = next;
+	}
+	while (o <= max_off && cnt < limit) {
+		cnt++;
+		next = tnum_step(offs, o);
+		if (next <= o)
+			break;
+		o = next;
+	}
+	return cnt;
+}
+
+/*
+ * A read from a frozen read-only map that has pointers to functions, see
+ * resolve_func_ptrs(). The bounds and var_off of the offset tell where the read
+ * is possible at, e.g. var_off is the stride of the elements of an array.
+ * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is variable
+ * and only pointers can be read, which is how an element of a table of
+ * functions is loaded, the verification continues with each of them. Other
+ * reads that overlap with a pointer are rejected, because their result is not
+ * known until the program is jitted.
+ *
+ * Return -ENOENT if there are no pointers to functions in the bytes that are read.
+ */
+static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
+			       int size, int value_regno)
+{
+	u64 min_off = reg_umin(reg) + off, max_off = reg_umax(reg) + off;
+	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_map *map = reg->map_ptr;
+	struct bpf_verifier_state *branch;
+	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
+	struct bpf_func_ptr *ptrs;
+	u32 i, cnt, n = 0;
+	u64 o, lo, hi;
+	int err;
+
+	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
+	if (!ptrs)
+		return -ENOENT;
+	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
+		goto overlap;
+
+	for (i = 0; i < cnt; i++) {
+		/* the offsets at which the read overlaps with the pointer */
+		lo = ptrs[i].map_off >= size ? ptrs[i].map_off - size + 1 : 0;
+		lo = max(lo, min_off);
+		hi = min(ptrs[i].map_off + sizeof(u64) - 1, max_off);
+		for (o = lo; o <= hi; o++) {
+			if (!tnum_in(offs, tnum_const(o)))
+				continue;
+			if (o != ptrs[i].map_off || size != sizeof(u64) || value_regno < 0)
+				goto overlap;
+			if (n == BPF_MAX_FUNC_PTR_TARGETS) {
+				verbose(env, "read from map '%s' may yield more than %d pointers to functions\n",
+					map->name, BPF_MAX_FUNC_PTR_TARGETS);
+				return -E2BIG;
+			}
+			subprog = bpf_find_subprog(env, ptrs[i].xlated_off);
+			if (verifier_bug_if(subprog <= 0, env,
+					    "no function at insn %u for map '%s' offset %u",
+					    ptrs[i].xlated_off, map->name, ptrs[i].map_off))
+				return -EFAULT;
+			targets[n++] = subprog;
+		}
+	}
+	/* pointers are next to what is read, e.g. the data of an array of vtables */
+	if (!n)
+		return -ENOENT;
+	/* either every offset that the read is possible at is a pointer or none */
+	if (count_read_offsets(offs, min_off, max_off, n + 1) != n)
+		goto overlap;
+
+	/* the map has the offset of the function until the program is jitted */
+	err = require_callx_jit(env);
+	if (err)
+		return err;
+
+	for (i = 0; i < n - 1; i++) {
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx,
+				    env->cur_state->speculative);
+		if (IS_ERR(branch))
+			return PTR_ERR(branch);
+		mark_reg_func_ptr(env, branch->frame[branch->curframe]->regs, value_regno,
+				  targets[i]);
+	}
+	mark_reg_func_ptr(env, regs, value_regno, targets[n - 1]);
+	return 0;
+
+overlap:
+	verbose(env, "read of %d bytes at offset [%llu,%llu] of map '%s' overlaps with a pointer to a function\n",
+		size, min_off, max_off, map->name);
+	return -EACCES;
+}
+
 static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
 			      int bpf_size, int value_regno, bool is_ldsx)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	int size = bpf_size_to_bytes(bpf_size);
 	struct bpf_map *map = reg->map_ptr;
+	int err;
 
 	switch (map->map_type) {
 	case BPF_MAP_TYPE_INSN_ARRAY:
@@ -6575,13 +6801,18 @@ static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state
 		break;
 	}
 
+	if (env->func_ptr_cnt) {
+		err = check_func_ptr_read(env, reg, off, size, value_regno);
+		if (err != -ENOENT)
+			return err;
+	}
+
 	/* If map is read-only, track its contents as scalars. */
 	if (tnum_is_const(reg->var_off) &&
 	    bpf_map_is_rdonly(map) &&
 	    map->ops->map_direct_value_addr) {
 		int map_off = off + reg->var_off.value;
 		u64 val = 0;
-		int err;
 
 		err = bpf_map_direct_read(map, map_off, size, &val, is_ldsx);
 		if (err)
@@ -8893,6 +9124,7 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 	int map_off;
 	u64 map_addr;
 	char *str_ptr;
+	u32 cnt;
 
 	if (reg->type != PTR_TO_MAP_VALUE)
 		return -EINVAL;
@@ -8942,6 +9174,11 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		verbose(env, "string is not zero-terminated\n");
 		return -EINVAL;
 	}
+	/* the bytes of a pointer to a function are not known until the program is jitted */
+	if (bpf_map_range_func_ptrs(env, map, map_off, strlen(str_ptr + map_off) + 1, &cnt)) {
+		verbose(env, "string overlaps with a pointer to a function\n");
+		return -EACCES;
+	}
 	return 0;
 }
 
@@ -10888,12 +11125,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 /*
  * callx dst_reg: call a bpf subprog whose address is in dst_reg.
  *
- * The address of a subprog is loaded into a register by ld_imm64 with
- * src_reg == BPF_PSEUDO_FUNC, which is allowed for static subprogs only.
- * Hence all possible callees of callx are discovered by add_subprogs() and
- * are reachable in the control flow graph before the main verification pass
- * begins. PTR_TO_FUNC register identifies the callee, so from here on callx
- * is verified as a direct call of that static subprog.
+ * The address of a subprog is either loaded into a register by ld_imm64 with
+ * src_reg == BPF_PSEUDO_FUNC, or it is read from a frozen read-only map, see
+ * resolve_func_ptrs(). Both are possible for static subprogs only. Hence all
+ * possible callees of callx are discovered by add_subprogs() and are reachable
+ * in the control flow graph before the main verification pass begins.
+ * PTR_TO_FUNC register identifies the callee, so from here on callx is verified
+ * as a direct call of that static subprog.
  */
 static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx)
@@ -10932,7 +11170,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
-	/* check_ld_imm() allows to take the address of static subprogs only */
+	/* PTR_TO_FUNC is a pointer to a static subprog */
 	subprog = reg->subprogno;
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
@@ -19603,6 +19841,30 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Keep track of whether the map is used by one program only. Such program may
+ * store the addresses of its functions into the map when it's frozen, see
+ * resolve_func_ptrs(), since nothing else relies on what the map has. After
+ * that the map is not available to other programs.
+ */
+static int bpf_map_claim(struct bpf_verifier_env *env, struct bpf_map *map)
+{
+	unsigned long me = (unsigned long)env->prog->aux, old;
+
+	for (;;) {
+		old = READ_ONCE(map->user);
+		if (old == me || old == BPF_MAP_USER_MANY)
+			return 0;
+		if (old & BPF_MAP_USER_PATCHED) {
+			verbose(env, "map '%s' has addresses of functions of another program\n",
+				map->name);
+			return -EBUSY;
+		}
+		if (cmpxchg(&map->user, old, old ? BPF_MAP_USER_MANY : me) == old)
+			return 0;
+	}
+}
+
 static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
 	int i, err;
@@ -19640,6 +19902,10 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
 	env->used_maps[env->used_map_cnt++] = map;
 
+	err = bpf_map_claim(env, map);
+	if (err)
+		return err;
+
 	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
 		err = bpf_insn_array_init(map, env->prog);
 		if (err) {
@@ -20056,6 +20322,104 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* that many pointers to functions are recognized in the maps of a program at most */
+#define BPF_MAX_FUNC_PTRS (1 << 20)
+
+static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 map_off,
+			u32 xlated_off)
+{
+	struct bpf_func_ptr *ptrs;
+
+	if (env->func_ptr_cnt == BPF_MAX_FUNC_PTRS) {
+		verbose(env, "too many pointers to functions in maps, the limit is %d\n",
+			BPF_MAX_FUNC_PTRS);
+		return -E2BIG;
+	}
+
+	/* grow by doubling, the array is sorted and searched later */
+	if (!(env->func_ptr_cnt & (env->func_ptr_cnt - 1))) {
+		ptrs = kvrealloc(env->func_ptrs,
+				 array_size(max(2 * env->func_ptr_cnt, 16U), sizeof(*ptrs)),
+				 GFP_KERNEL_ACCOUNT);
+		if (!ptrs)
+			return -ENOMEM;
+		env->func_ptrs = ptrs;
+	}
+	env->func_ptrs[env->func_ptr_cnt++] = (struct bpf_func_ptr){
+		.map = map,
+		.map_off = map_off,
+		.orig_off = xlated_off,
+		.xlated_off = xlated_off,
+	};
+	return 0;
+}
+
+/*
+ * Compilers put pointers to functions into read-only data: tables of functions,
+ * structures of operations, vtables, where they are mixed with other data.
+ * The loader stores such data in a frozen read-only array map and resolves
+ * a pointer to a static function to the offset in bytes of its first
+ * instruction in the program: the address of the function in the program.
+ *
+ * Find 64-bit values that look like that in the maps of a program that uses
+ * callx. It's a guess. When the value is not a pointer, the program either
+ * fails to load, because it does with a pointer what can be done with
+ * a number only, or it sees the address of a function instead of the number.
+ * It's known before the control flow graph of the program is built and the main
+ * verification pass begins which functions may be called via callx.
+ *
+ * When the program is jitted the offsets are replaced with the addresses of
+ * the functions in the map itself, see jit_subprogs(). Hence the program has to
+ * be the only user of the map, see bpf_map_claim(): nothing else may rely on
+ * what the map had.
+ *
+ * The program reads the addresses of its functions from there like any other
+ * data, so it has to be allowed to leak pointers.
+ */
+static int resolve_func_ptrs(struct bpf_verifier_env *env)
+{
+	int insn_cnt = env->prog->len;
+	int i, err, subprog;
+	struct bpf_map *map;
+	u64 addr, val;
+	u32 off;
+
+	if (!env->has_callx || !env->allow_ptr_leaks)
+		return 0;
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		map = env->used_maps[i];
+		/* coincidences in maps that are shared with other programs don't matter */
+		if (READ_ONCE(map->user) != (unsigned long)env->prog->aux)
+			continue;
+		if (map->map_type != BPF_MAP_TYPE_ARRAY || map->max_entries != 1 ||
+		    !bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
+		    !IS_ERR_OR_NULL(map->record))
+			continue;
+		if (map->ops->map_direct_value_addr(map, &addr, 0))
+			continue;
+
+		for (off = 0; off + sizeof(u64) <= map->value_size; off += sizeof(u64)) {
+			if (!(off % SZ_64K))
+				cond_resched();
+			val = *(u64 *)(unsigned long)(addr + off);
+			if (!val || val % sizeof(struct bpf_insn) ||
+			    val / sizeof(struct bpf_insn) >= insn_cnt)
+				continue;
+			subprog = bpf_find_subprog(env, val / sizeof(struct bpf_insn));
+			if (subprog <= 0 || bpf_subprog_is_global(env, subprog))
+				continue;
+			err = add_func_ptr(env, map, off, val / sizeof(struct bpf_insn));
+			if (err)
+				return err;
+		}
+	}
+	if (env->func_ptr_cnt)
+		sort(env->func_ptrs, env->func_ptr_cnt, sizeof(*env->func_ptrs),
+		     cmp_func_ptrs, NULL);
+	return 0;
+}
+
 /* drop refcnt of maps used by the rejected program */
 static void release_maps(struct bpf_verifier_env *env)
 {
@@ -22026,6 +22390,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Find pointers to functions in the read-only maps of the program. */
+	ret = resolve_func_ptrs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Build kfunc prototypes after resolving program resources. */
 	ret = add_kfuncs(env);
 	if (ret < 0)
@@ -22232,6 +22601,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
+	kvfree(env->func_ptrs);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.55.0

