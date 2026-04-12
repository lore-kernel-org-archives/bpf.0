Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D615347500
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775963515; cv=none; b=XnFVTXPRGT60WtS68DD19EW6BzqJU45FcBuatG0keQn/E7PzJQj5yszvqTyxMlj30nDhf9zsVfe8BBewV4zynLZROBC1WbjDlyn24i3QI2u23L3DtGtFRGUibKe8Zs/w8NXdmAT3Q5AU5RQHD7dszFQ7YJMkVKJfZ/OR4DSZFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775963515; c=relaxed/simple;
	bh=MLQNp+WSSZSoyjWsjivyOsT3Vc1p7VuXWOWB+8jwY/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sm7m/MQmCOrC6hFmkGHkE4iDBVR1L9lFu3wIyoQkQJ5DaKlQXUBhMrgedBrCJg9oSf2FfN8ASEjcDcjSgw+nCQfp0BWHqugFKBCWY+OpC+QbLvrWtdZbwsgPZ0HJcHWJvCJfccMWhNqd2pGWEoNP4ONr33Pn9guya4+4xj2iRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEMwWe2A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEMwWe2A"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdab08so2618327b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775963512; x=1776568312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvRO7riYgbO8ZT+sbEx1MtqqA1shkegejHwyQ9PKqlI=;
        b=bEMwWe2ADtSZMua0WjfBUy0GRQt80dskuPcNdLdsaKmKytiv6MxueJ8UdIwfx9e0BX
         3PEGW/s81GKmp44O6OQ3tDl30ztcMP54OStZ4Nj/ZezHeuMnok+J0Hl+vf7c2vEot3i4
         gnTwa3iwL9PRBrWrDiA3UUQinngbEj9594QUGf8cLdt5WQQEpcRcm1n7zJVx2E/v4pwG
         1wNPqEod2e6oQlAsEez1G773iFb26p+ITX8m9eNjX0AhPBSxMJkUnIOb2Qxc6rJHsCWA
         25Q8eqVch7HvuoIx3d6On8ua1daN22ffDbp2608RUuu8exTo8vE2qjjaqgW/zIiqOQpq
         EzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775963512; x=1776568312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvRO7riYgbO8ZT+sbEx1MtqqA1shkegejHwyQ9PKqlI=;
        b=is3/s7oMyayJQXvkCEBlmb5CtZEbT4Vl2XKqkZ4P+L5301j+jsuL27IAqdpz2iyJJA
         uK6ldQaWjjd/qrKM9+4bZoJtDoxRQyF44Eb+GMh4g0Kqg9LyaM+zSqGbqLbVnPAJGQl3
         Px4QTaczvPmFomASkCEalarAXzqvxZhvegpHSbggDgnqwrtTMwOoyyoXzLYGc6sQDzjP
         VbDs0R33sg5wPDK6gJ2VLRy4PymYNSIXYOEortTOEclfVFMdTCMyzfnHXtjGhk+fv6yj
         Ko0T4skEQyShbhOQjXwTTQWg3srOAXSwPle1qP9bnge4shWDREnSRS2nMpq1L0HEgmhF
         sCNw==
X-Gm-Message-State: AOJu0YyvTVylr4KDHKXqDiN/PMBVh5hkgo9gbWm+gg6lO3+252VFvsQ5
	MixiZLs+i1EyHZfTFkAt/0zcG26i2ONxGE0xezc0ziXvywAnFLa3b2ZjvVAxfA==
X-Gm-Gg: AeBDiets5IApn6IchsSzfcIKQjMAOYFTERIBCxzR7ETihcfAw4W/BrA+ogz+DxEL5vL
	qZQSvtUBH3cguEmsHJi3sWewCtxzYShbkgpjObzQBl8pe9BVTHb8JwBX1WWWH8Gp3gVl6KAKD2+
	G498EwjyV/b+R0aUeQfi/9eboCvC9bW61kftloMw3rWtWiwP8AFLUhCALfJnWUovS7+bG6I6nzT
	rFclzDeFWWlpf1t9VGK/47QvvD7GCa41qcxtAnpFcit5a815+6R+46JvBjt63L6uNjmu2j3MHXC
	v95hSxM5gcERoOlL1rYLjh7dQn9rk2rWkmK1Wq2wTuzobPKngC8ItjjC3yWOBROiR/xt0Um5XHF
	N27J2Apbpp/B7vm+l+XgP7juu9gqAOBW7RJfIKicwbvGwEtWQVwCWQcsxhjuw3dIGG2iAc8cdc/
	oHXxVpCZBfVwd6PkqYodxQC3J0aOjf7Y6PSV48qWWL+YPHI9nvfcQbdM4IMTJRWuPfTfou3zrPQ
	/v/pgTvoe9Pd5crQNVOqkliqohHEsV9ghOsZ2gJqII=
X-Received: by 2002:a05:6a00:98d:b0:82c:d92f:3b64 with SMTP id d2e1a72fcca58-82f0c219546mr9150740b3a.14.1775963511094;
        Sat, 11 Apr 2026 20:11:51 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c337b1dsm8101896b3a.18.2026.04.11.20.11.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 20:11:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/6] bpf: Move check_cfg() into cfg.c
Date: Sat, 11 Apr 2026 20:11:34 -0700
Message-ID: <20260412031139.41248-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260412031139.41248-1-alexei.starovoitov@gmail.com>
References: <20260412031139.41248-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier.c is huge. Move check_cfg(), compute_postorder(),
compute_scc() into cfg.c

Mechanical move. No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  115 +++-
 kernel/bpf/Makefile          |    2 +-
 kernel/bpf/cfg.c             |  783 ++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 1026 +---------------------------------
 4 files changed, 929 insertions(+), 997 deletions(-)
 create mode 100644 kernel/bpf/cfg.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e3f18667e030..aa92a597bc5c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -983,6 +983,41 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
 	})
 
+static inline void mark_prune_point(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].prune_point = true;
+}
+
+static inline bool bpf_is_prune_point(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].prune_point;
+}
+
+static inline void mark_force_checkpoint(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].force_checkpoint = true;
+}
+
+static inline bool bpf_is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].force_checkpoint;
+}
+
+static inline void mark_calls_callback(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].calls_callback = true;
+}
+
+static inline bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].calls_callback;
+}
+
+static inline void mark_jmp_point(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].jmp_point = true;
+}
+
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
@@ -1179,13 +1214,91 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
-bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
+int bpf_check_cfg(struct bpf_verifier_env *env);
 int bpf_compute_postorder(struct bpf_verifier_env *env);
+int bpf_compute_scc(struct bpf_verifier_env *env);
+
+struct bpf_map_desc {
+	struct bpf_map *ptr;
+	int uid;
+};
+
+struct bpf_kfunc_call_arg_meta {
+	/* In parameters */
+	struct btf *btf;
+	u32 func_id;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
+	/* Out parameters */
+	u32 ref_obj_id;
+	u8 release_regno;
+	bool r0_rdonly;
+	u32 ret_btf_id;
+	u64 r0_size;
+	u32 subprogno;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
+
+	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
+	 * generally to pass info about user-defined local kptr types to later
+	 * verification logic
+	 *   bpf_obj_drop/bpf_percpu_obj_drop
+	 *     Record the local kptr type to be drop'd
+	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
+	 *     Record the local kptr type to be refcount_incr'd and use
+	 *     arg_owning_ref to determine whether refcount_acquire should be
+	 *     fallible
+	 */
+	struct btf *arg_btf;
+	u32 arg_btf_id;
+	bool arg_owning_ref;
+	bool arg_prog;
+
+	struct {
+		struct btf_field *field;
+	} arg_list_head;
+	struct {
+		struct btf_field *field;
+	} arg_rbtree_root;
+	struct {
+		enum bpf_dynptr_type type;
+		u32 id;
+		u32 ref_obj_id;
+	} initialized_dynptr;
+	struct {
+		u8 spi;
+		u8 frameno;
+	} iter;
+	struct bpf_map_desc map;
+	u64 mem_size;
+};
+
+int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			 const struct bpf_func_proto **ptr);
+int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env, s32 func_id,
+			     s16 offset, struct bpf_kfunc_call_arg_meta *meta);
+bool bpf_is_async_callback_calling_insn(struct bpf_insn *insn);
+bool bpf_is_sync_callback_calling_insn(struct bpf_insn *insn);
+static inline bool bpf_is_iter_next_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_ITER_NEXT;
+}
+
+static inline bool bpf_is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_SLEEPABLE;
+}
+bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta);
+struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
+int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
 bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7c1eeee87fda..8649ee9651a9 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
new file mode 100644
index 000000000000..365dcbb848af
--- /dev/null
+++ b/kernel/bpf/cfg.c
@@ -0,0 +1,783 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/sort.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+/* non-recursive DFS pseudo code
+ * 1  procedure DFS-iterative(G,v):
+ * 2      label v as discovered
+ * 3      let S be a stack
+ * 4      S.push(v)
+ * 5      while S is not empty
+ * 6            t <- S.peek()
+ * 7            if t is what we're looking for:
+ * 8                return t
+ * 9            for all edges e in G.adjacentEdges(t) do
+ * 10               if edge e is already labelled
+ * 11                   continue with the next edge
+ * 12               w <- G.adjacentVertex(t,e)
+ * 13               if vertex w is not discovered and not explored
+ * 14                   label e as tree-edge
+ * 15                   label w as discovered
+ * 16                   S.push(w)
+ * 17                   continue at 5
+ * 18               else if vertex w is discovered
+ * 19                   label e as back-edge
+ * 20               else
+ * 21                   // vertex w is explored
+ * 22                   label e as forward- or cross-edge
+ * 23           label t as explored
+ * 24           S.pop()
+ *
+ * convention:
+ * 0x10 - discovered
+ * 0x11 - discovered and fall-through edge labelled
+ * 0x12 - discovered and fall-through and branch edges labelled
+ * 0x20 - explored
+ */
+
+enum {
+	DISCOVERED = 0x10,
+	EXPLORED = 0x20,
+	FALLTHROUGH = 1,
+	BRANCH = 2,
+};
+
+
+static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = bpf_find_containing_subprog(env, off);
+	subprog->changes_pkt_data = true;
+}
+
+static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = bpf_find_containing_subprog(env, off);
+	subprog->might_sleep = true;
+}
+
+/* 't' is an index of a call-site.
+ * 'w' is a callee entry point.
+ * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
+ * Rely on DFS traversal order and absence of recursive calls to guarantee that
+ * callee's change_pkt_data marks would be correct at that moment.
+ */
+static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
+{
+	struct bpf_subprog_info *caller, *callee;
+
+	caller = bpf_find_containing_subprog(env, t);
+	callee = bpf_find_containing_subprog(env, w);
+	caller->changes_pkt_data |= callee->changes_pkt_data;
+	caller->might_sleep |= callee->might_sleep;
+}
+
+enum {
+	DONE_EXPLORING = 0,
+	KEEP_EXPLORING = 1,
+};
+
+/* t, w, e - match pseudo-code above:
+ * t - index of current instruction
+ * w - next instruction
+ * e - edge
+ */
+static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+
+	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
+		return DONE_EXPLORING;
+
+	if (e == BRANCH && insn_state[t] >= (DISCOVERED | BRANCH))
+		return DONE_EXPLORING;
+
+	if (w < 0 || w >= env->prog->len) {
+		verbose_linfo(env, t, "%d: ", t);
+		verbose(env, "jump out of range from insn %d to %d\n", t, w);
+		return -EINVAL;
+	}
+
+	if (e == BRANCH) {
+		/* mark branch target for state pruning */
+		mark_prune_point(env, w);
+		mark_jmp_point(env, w);
+	}
+
+	if (insn_state[w] == 0) {
+		/* tree-edge */
+		insn_state[t] = DISCOVERED | e;
+		insn_state[w] = DISCOVERED;
+		if (env->cfg.cur_stack >= env->prog->len)
+			return -E2BIG;
+		insn_stack[env->cfg.cur_stack++] = w;
+		return KEEP_EXPLORING;
+	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
+		if (env->bpf_capable)
+			return DONE_EXPLORING;
+		verbose_linfo(env, t, "%d: ", t);
+		verbose_linfo(env, w, "%d: ", w);
+		verbose(env, "back-edge from insn %d to %d\n", t, w);
+		return -EINVAL;
+	} else if (insn_state[w] == EXPLORED) {
+		/* forward- or cross-edge */
+		insn_state[t] = DISCOVERED | e;
+	} else {
+		verifier_bug(env, "insn state internal bug");
+		return -EFAULT;
+	}
+	return DONE_EXPLORING;
+}
+
+static int visit_func_call_insn(int t, struct bpf_insn *insns,
+				struct bpf_verifier_env *env,
+				bool visit_callee)
+{
+	int ret, insn_sz;
+	int w;
+
+	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
+	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
+	if (ret)
+		return ret;
+
+	mark_prune_point(env, t + insn_sz);
+	/* when we exit from subprog, we need to record non-linear history */
+	mark_jmp_point(env, t + insn_sz);
+
+	if (visit_callee) {
+		w = t + insns[t].imm + 1;
+		mark_prune_point(env, t);
+		merge_callee_effects(env, t, w);
+		ret = push_insn(t, w, BRANCH, env);
+	}
+	return ret;
+}
+
+struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem)
+{
+	size_t new_size = sizeof(struct bpf_iarray) + n_elem * sizeof(old->items[0]);
+	struct bpf_iarray *new;
+
+	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
+	if (!new) {
+		/* this is what callers always want, so simplify the call site */
+		kvfree(old);
+		return NULL;
+	}
+
+	new->cnt = n_elem;
+	return new;
+}
+
+static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
+{
+	struct bpf_insn_array_value *value;
+	u32 i;
+
+	for (i = start; i <= end; i++) {
+		value = map->ops->map_lookup_elem(map, &i);
+		/*
+		 * map_lookup_elem of an array map will never return an error,
+		 * but not checking it makes some static analysers to worry
+		 */
+		if (IS_ERR(value))
+			return PTR_ERR(value);
+		else if (!value)
+			return -EINVAL;
+		items[i - start] = value->xlated_off;
+	}
+	return 0;
+}
+
+static int cmp_ptr_to_u32(const void *a, const void *b)
+{
+	return *(u32 *)a - *(u32 *)b;
+}
+
+static int sort_insn_array_uniq(u32 *items, int cnt)
+{
+	int unique = 1;
+	int i;
+
+	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
+
+	for (i = 1; i < cnt; i++)
+		if (items[i] != items[unique - 1])
+			items[unique++] = items[i];
+
+	return unique;
+}
+
+/*
+ * sort_unique({map[start], ..., map[end]}) into off
+ */
+int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
+{
+	u32 n = end - start + 1;
+	int err;
+
+	err = copy_insn_array(map, start, end, off);
+	if (err)
+		return err;
+
+	return sort_insn_array_uniq(off, n);
+}
+
+/*
+ * Copy all unique offsets from the map
+ */
+static struct bpf_iarray *jt_from_map(struct bpf_map *map)
+{
+	struct bpf_iarray *jt;
+	int err;
+	int n;
+
+	jt = bpf_iarray_realloc(NULL, map->max_entries);
+	if (!jt)
+		return ERR_PTR(-ENOMEM);
+
+	n = bpf_copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->items);
+	if (n < 0) {
+		err = n;
+		goto err_free;
+	}
+	if (n == 0) {
+		err = -EINVAL;
+		goto err_free;
+	}
+	jt->cnt = n;
+	return jt;
+
+err_free:
+	kvfree(jt);
+	return ERR_PTR(err);
+}
+
+/*
+ * Find and collect all maps which fit in the subprog. Return the result as one
+ * combined jump table in jt->items (allocated with kvcalloc)
+ */
+static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
+					  int subprog_start, int subprog_end)
+{
+	struct bpf_iarray *jt = NULL;
+	struct bpf_map *map;
+	struct bpf_iarray *jt_cur;
+	int i;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++) {
+		/*
+		 * TODO (when needed): collect only jump tables, not static keys
+		 * or maps for indirect calls
+		 */
+		map = env->insn_array_maps[i];
+
+		jt_cur = jt_from_map(map);
+		if (IS_ERR(jt_cur)) {
+			kvfree(jt);
+			return jt_cur;
+		}
+
+		/*
+		 * This is enough to check one element. The full table is
+		 * checked to fit inside the subprog later in create_jt()
+		 */
+		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
+			u32 old_cnt = jt ? jt->cnt : 0;
+			jt = bpf_iarray_realloc(jt, old_cnt + jt_cur->cnt);
+			if (!jt) {
+				kvfree(jt_cur);
+				return ERR_PTR(-ENOMEM);
+			}
+			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
+		}
+
+		kvfree(jt_cur);
+	}
+
+	if (!jt) {
+		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		return ERR_PTR(-EINVAL);
+	}
+
+	jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
+	return jt;
+}
+
+static struct bpf_iarray *
+create_jt(int t, struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog;
+	int subprog_start, subprog_end;
+	struct bpf_iarray *jt;
+	int i;
+
+	subprog = bpf_find_containing_subprog(env, t);
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+	jt = jt_from_subprog(env, subprog_start, subprog_end);
+	if (IS_ERR(jt))
+		return jt;
+
+	/* Check that the every element of the jump table fits within the given subprogram */
+	for (i = 0; i < jt->cnt; i++) {
+		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
+			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
+					t, subprog_start, subprog_end);
+			kvfree(jt);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return jt;
+}
+
+/* "conditional jump with N edges" */
+static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+	bool keep_exploring = false;
+	struct bpf_iarray *jt;
+	int i, w;
+
+	jt = env->insn_aux_data[t].jt;
+	if (!jt) {
+		jt = create_jt(t, env);
+		if (IS_ERR(jt))
+			return PTR_ERR(jt);
+
+		env->insn_aux_data[t].jt = jt;
+	}
+
+	mark_prune_point(env, t);
+	for (i = 0; i < jt->cnt; i++) {
+		w = jt->items[i];
+		if (w < 0 || w >= env->prog->len) {
+			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
+			return -EINVAL;
+		}
+
+		mark_jmp_point(env, w);
+
+		/* EXPLORED || DISCOVERED */
+		if (insn_state[w])
+			continue;
+
+		if (env->cfg.cur_stack >= env->prog->len)
+			return -E2BIG;
+
+		insn_stack[env->cfg.cur_stack++] = w;
+		insn_state[w] |= DISCOVERED;
+		keep_exploring = true;
+	}
+
+	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
+}
+
+/*
+ * Instructions that can abnormally return from a subprog (tail_call
+ * upon success, ld_{abs,ind} upon load failure) have a hidden exit
+ * that the verifier must account for.
+ */
+static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
+{
+	struct bpf_subprog_info *subprog;
+	struct bpf_iarray *jt;
+
+	if (env->insn_aux_data[t].jt)
+		return 0;
+
+	jt = bpf_iarray_realloc(NULL, 2);
+	if (!jt)
+		return -ENOMEM;
+
+	subprog = bpf_find_containing_subprog(env, t);
+	jt->items[0] = t + 1;
+	jt->items[1] = subprog->exit_idx;
+	env->insn_aux_data[t].jt = jt;
+	return 0;
+}
+
+/* Visits the instruction at index t and returns one of the following:
+ *  < 0 - an error occurred
+ *  DONE_EXPLORING - the instruction was fully explored
+ *  KEEP_EXPLORING - there is still work to be done before it is fully explored
+ */
+static int visit_insn(int t, struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
+	int ret, off, insn_sz;
+
+	if (bpf_pseudo_func(insn))
+		return visit_func_call_insn(t, insns, env, true);
+
+	/* All non-branch instructions have a single fall-through edge. */
+	if (BPF_CLASS(insn->code) != BPF_JMP &&
+	    BPF_CLASS(insn->code) != BPF_JMP32) {
+		if (BPF_CLASS(insn->code) == BPF_LD &&
+		    (BPF_MODE(insn->code) == BPF_ABS ||
+		     BPF_MODE(insn->code) == BPF_IND)) {
+			ret = visit_abnormal_return_insn(env, t);
+			if (ret)
+				return ret;
+		}
+		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+		return push_insn(t, t + insn_sz, FALLTHROUGH, env);
+	}
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_EXIT:
+		return DONE_EXPLORING;
+
+	case BPF_CALL:
+		if (bpf_is_async_callback_calling_insn(insn))
+			/* Mark this call insn as a prune point to trigger
+			 * is_state_visited() check before call itself is
+			 * processed by __check_func_call(). Otherwise new
+			 * async state will be pushed for further exploration.
+			 */
+			mark_prune_point(env, t);
+		/* For functions that invoke callbacks it is not known how many times
+		 * callback would be called. Verifier models callback calling functions
+		 * by repeatedly visiting callback bodies and returning to origin call
+		 * instruction.
+		 * In order to stop such iteration verifier needs to identify when a
+		 * state identical some state from a previous iteration is reached.
+		 * Check below forces creation of checkpoint before callback calling
+		 * instruction to allow search for such identical states.
+		 */
+		if (bpf_is_sync_callback_calling_insn(insn)) {
+			mark_calls_callback(env, t);
+			mark_force_checkpoint(env, t);
+			mark_prune_point(env, t);
+			mark_jmp_point(env, t);
+		}
+		if (bpf_helper_call(insn)) {
+			const struct bpf_func_proto *fp;
+
+			ret = bpf_get_helper_proto(env, insn->imm, &fp);
+			/* If called in a non-sleepable context program will be
+			 * rejected anyway, so we should end up with precise
+			 * sleepable marks on subprogs, except for dead code
+			 * elimination.
+			 */
+			if (ret == 0 && fp->might_sleep)
+				mark_subprog_might_sleep(env, t);
+			if (bpf_helper_changes_pkt_data(insn->imm))
+				mark_subprog_changes_pkt_data(env, t);
+			if (insn->imm == BPF_FUNC_tail_call) {
+				ret = visit_abnormal_return_insn(env, t);
+				if (ret)
+					return ret;
+			}
+		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			struct bpf_kfunc_call_arg_meta meta;
+
+			ret = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
+			if (ret == 0 && bpf_is_iter_next_kfunc(&meta)) {
+				mark_prune_point(env, t);
+				/* Checking and saving state checkpoints at iter_next() call
+				 * is crucial for fast convergence of open-coded iterator loop
+				 * logic, so we need to force it. If we don't do that,
+				 * is_state_visited() might skip saving a checkpoint, causing
+				 * unnecessarily long sequence of not checkpointed
+				 * instructions and jumps, leading to exhaustion of jump
+				 * history buffer, and potentially other undesired outcomes.
+				 * It is expected that with correct open-coded iterators
+				 * convergence will happen quickly, so we don't run a risk of
+				 * exhausting memory.
+				 */
+				mark_force_checkpoint(env, t);
+			}
+			/* Same as helpers, if called in a non-sleepable context
+			 * program will be rejected anyway, so we should end up
+			 * with precise sleepable marks on subprogs, except for
+			 * dead code elimination.
+			 */
+			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
+				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
+		}
+		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
+
+	case BPF_JA:
+		if (BPF_SRC(insn->code) == BPF_X)
+			return visit_gotox_insn(t, env);
+
+		if (BPF_CLASS(insn->code) == BPF_JMP)
+			off = insn->off;
+		else
+			off = insn->imm;
+
+		/* unconditional jump with single edge */
+		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
+		if (ret)
+			return ret;
+
+		mark_prune_point(env, t + off + 1);
+		mark_jmp_point(env, t + off + 1);
+
+		return ret;
+
+	default:
+		/* conditional jump with two edges */
+		mark_prune_point(env, t);
+		if (bpf_is_may_goto_insn(insn))
+			mark_force_checkpoint(env, t);
+
+		ret = push_insn(t, t + 1, FALLTHROUGH, env);
+		if (ret)
+			return ret;
+
+		return push_insn(t, t + insn->off + 1, BRANCH, env);
+	}
+}
+
+/* non-recursive depth-first-search to detect loops in BPF program
+ * loop == back-edge in directed graph
+ */
+int bpf_check_cfg(struct bpf_verifier_env *env)
+{
+	int insn_cnt = env->prog->len;
+	int *insn_stack, *insn_state;
+	int ex_insn_beg, i, ret = 0;
+
+	insn_state = env->cfg.insn_state = kvzalloc_objs(int, insn_cnt,
+							 GFP_KERNEL_ACCOUNT);
+	if (!insn_state)
+		return -ENOMEM;
+
+	insn_stack = env->cfg.insn_stack = kvzalloc_objs(int, insn_cnt,
+							 GFP_KERNEL_ACCOUNT);
+	if (!insn_stack) {
+		kvfree(insn_state);
+		return -ENOMEM;
+	}
+
+	ex_insn_beg = env->exception_callback_subprog
+		      ? env->subprog_info[env->exception_callback_subprog].start
+		      : 0;
+
+	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
+	insn_stack[0] = 0; /* 0 is the first instruction */
+	env->cfg.cur_stack = 1;
+
+walk_cfg:
+	while (env->cfg.cur_stack > 0) {
+		int t = insn_stack[env->cfg.cur_stack - 1];
+
+		ret = visit_insn(t, env);
+		switch (ret) {
+		case DONE_EXPLORING:
+			insn_state[t] = EXPLORED;
+			env->cfg.cur_stack--;
+			break;
+		case KEEP_EXPLORING:
+			break;
+		default:
+			if (ret > 0) {
+				verifier_bug(env, "visit_insn internal bug");
+				ret = -EFAULT;
+			}
+			goto err_free;
+		}
+	}
+
+	if (env->cfg.cur_stack < 0) {
+		verifier_bug(env, "pop stack internal bug");
+		ret = -EFAULT;
+		goto err_free;
+	}
+
+	if (ex_insn_beg && insn_state[ex_insn_beg] != EXPLORED) {
+		insn_state[ex_insn_beg] = DISCOVERED;
+		insn_stack[0] = ex_insn_beg;
+		env->cfg.cur_stack = 1;
+		goto walk_cfg;
+	}
+
+	for (i = 0; i < insn_cnt; i++) {
+		struct bpf_insn *insn = &env->prog->insnsi[i];
+
+		if (insn_state[i] != EXPLORED) {
+			verbose(env, "unreachable insn %d\n", i);
+			ret = -EINVAL;
+			goto err_free;
+		}
+		if (bpf_is_ldimm64(insn)) {
+			if (insn_state[i + 1] != 0) {
+				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				ret = -EINVAL;
+				goto err_free;
+			}
+			i++; /* skip second half of ldimm64 */
+		}
+	}
+	ret = 0; /* cfg looks good */
+	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
+	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
+
+err_free:
+	kvfree(insn_state);
+	kvfree(insn_stack);
+	env->cfg.insn_state = env->cfg.insn_stack = NULL;
+	return ret;
+}
+
+/*
+ * For each subprogram 'i' fill array env->cfg.insn_subprogram sub-range
+ * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
+ * with indices of 'i' instructions in postorder.
+ */
+int bpf_compute_postorder(struct bpf_verifier_env *env)
+{
+	u32 cur_postorder, i, top, stack_sz, s;
+	int *stack = NULL, *postorder = NULL, *state = NULL;
+	struct bpf_iarray *succ;
+
+	postorder = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
+	state = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
+	stack = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
+	if (!postorder || !state || !stack) {
+		kvfree(postorder);
+		kvfree(state);
+		kvfree(stack);
+		return -ENOMEM;
+	}
+	cur_postorder = 0;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		env->subprog_info[i].postorder_start = cur_postorder;
+		stack[0] = env->subprog_info[i].start;
+		stack_sz = 1;
+		do {
+			top = stack[stack_sz - 1];
+			state[top] |= DISCOVERED;
+			if (state[top] & EXPLORED) {
+				postorder[cur_postorder++] = top;
+				stack_sz--;
+				continue;
+			}
+			succ = bpf_insn_successors(env, top);
+			for (s = 0; s < succ->cnt; ++s) {
+				if (!state[succ->items[s]]) {
+					stack[stack_sz++] = succ->items[s];
+					state[succ->items[s]] |= DISCOVERED;
+				}
+			}
+			state[top] |= EXPLORED;
+		} while (stack_sz);
+	}
+	env->subprog_info[i].postorder_start = cur_postorder;
+	env->cfg.insn_postorder = postorder;
+	env->cfg.cur_postorder = cur_postorder;
+	kvfree(stack);
+	kvfree(state);
+	return 0;
+}
+
+/*
+ * Compute strongly connected components (SCCs) on the CFG.
+ * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
+ * If instruction is a sole member of its SCC and there are no self edges,
+ * assign it SCC number of zero.
+ * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computation.
+ */
+int bpf_compute_scc(struct bpf_verifier_env *env)
+{
+	const u32 NOT_ON_STACK = U32_MAX;
+
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	const u32 insn_cnt = env->prog->len;
+	int stack_sz, dfs_sz, err = 0;
+	u32 *stack, *pre, *low, *dfs;
+	u32 i, j, t, w;
+	u32 next_preorder_num;
+	u32 next_scc_id;
+	bool assign_scc;
+	struct bpf_iarray *succ;
+
+	next_preorder_num = 1;
+	next_scc_id = 1;
+	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
+	if (!stack || !pre || !low || !dfs) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	for (i = 0; i < insn_cnt; i++) {
+		if (pre[i])
+			continue;
+		stack_sz = 0;
+		dfs_sz = 1;
+		dfs[0] = i;
+dfs_continue:
+		while (dfs_sz) {
+			w = dfs[dfs_sz - 1];
+			if (pre[w] == 0) {
+				low[w] = next_preorder_num;
+				pre[w] = next_preorder_num;
+				next_preorder_num++;
+				stack[stack_sz++] = w;
+			}
+			/* Visit 'w' successors */
+			succ = bpf_insn_successors(env, w);
+			for (j = 0; j < succ->cnt; ++j) {
+				if (pre[succ->items[j]]) {
+					low[w] = min(low[w], low[succ->items[j]]);
+				} else {
+					dfs[dfs_sz++] = succ->items[j];
+					goto dfs_continue;
+				}
+			}
+			if (low[w] < pre[w]) {
+				dfs_sz--;
+				goto dfs_continue;
+			}
+			assign_scc = stack[stack_sz - 1] != w;
+			for (j = 0; j < succ->cnt; ++j) {
+				if (succ->items[j] == w) {
+					assign_scc = true;
+					break;
+				}
+			}
+			if (bpf_calls_callback(env, w))
+				assign_scc = true;
+			do {
+				t = stack[--stack_sz];
+				low[t] = NOT_ON_STACK;
+				if (assign_scc)
+					aux[t].scc = next_scc_id;
+			} while (t != w);
+			if (assign_scc)
+				next_scc_id++;
+			dfs_sz--;
+		}
+	}
+	env->scc_info = kvzalloc_objs(*env->scc_info, next_scc_id,
+				      GFP_KERNEL_ACCOUNT);
+	if (!env->scc_info) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	env->scc_cnt = next_scc_id;
+exit:
+	kvfree(stack);
+	kvfree(pre);
+	kvfree(low);
+	kvfree(dfs);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11f0c5a050b3..00fcd7f9c06b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -230,11 +230,6 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
-struct bpf_map_desc {
-	struct bpf_map *ptr;
-	int uid;
-};
-
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
 	bool raw_mode;
@@ -264,59 +259,6 @@ struct bpf_kfunc_meta {
 	s32 id;
 };
 
-struct bpf_kfunc_call_arg_meta {
-	/* In parameters */
-	struct btf *btf;
-	u32 func_id;
-	u32 kfunc_flags;
-	const struct btf_type *func_proto;
-	const char *func_name;
-	/* Out parameters */
-	u32 ref_obj_id;
-	u8 release_regno;
-	bool r0_rdonly;
-	u32 ret_btf_id;
-	u64 r0_size;
-	u32 subprogno;
-	struct {
-		u64 value;
-		bool found;
-	} arg_constant;
-
-	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
-	 * generally to pass info about user-defined local kptr types to later
-	 * verification logic
-	 *   bpf_obj_drop/bpf_percpu_obj_drop
-	 *     Record the local kptr type to be drop'd
-	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
-	 *     Record the local kptr type to be refcount_incr'd and use
-	 *     arg_owning_ref to determine whether refcount_acquire should be
-	 *     fallible
-	 */
-	struct btf *arg_btf;
-	u32 arg_btf_id;
-	bool arg_owning_ref;
-	bool arg_prog;
-
-	struct {
-		struct btf_field *field;
-	} arg_list_head;
-	struct {
-		struct btf_field *field;
-	} arg_rbtree_root;
-	struct {
-		enum bpf_dynptr_type type;
-		u32 id;
-		u32 ref_obj_id;
-	} initialized_dynptr;
-	struct {
-		u8 spi;
-		u8 frameno;
-	} iter;
-	struct bpf_map_desc map;
-	u64 mem_size;
-};
-
 struct btf *btf_vmlinux;
 
 static const char *btf_type_name(const struct btf *btf, u32 id)
@@ -524,13 +466,13 @@ static bool is_callback_calling_function(enum bpf_func_id func_id)
 	       is_async_callback_calling_function(func_id);
 }
 
-static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
+bool bpf_is_sync_callback_calling_insn(struct bpf_insn *insn)
 {
 	return (bpf_helper_call(insn) && is_sync_callback_calling_function(insn->imm)) ||
 	       (bpf_pseudo_kfunc_call(insn) && is_sync_callback_calling_kfunc(insn->imm));
 }
 
-static bool is_async_callback_calling_insn(struct bpf_insn *insn)
+bool bpf_is_async_callback_calling_insn(struct bpf_insn *insn)
 {
 	return (bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm)) ||
 	       (bpf_pseudo_kfunc_call(insn) && is_async_callback_calling_kfunc(insn->imm));
@@ -3907,11 +3849,6 @@ static int insn_stack_access_frameno(int insn_flags)
 	return insn_flags & INSN_F_FRAMENO_MASK;
 }
 
-static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].jmp_point = true;
-}
-
 static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 {
 	return env->insn_aux_data[insn_idx].jmp_point;
@@ -4480,7 +4417,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 				return 0;
 			}
-		} else if (is_sync_callback_calling_insn(insn) && idx != subseq_idx - 1) {
+		} else if (bpf_is_sync_callback_calling_insn(insn) && idx != subseq_idx - 1) {
 			/* exit from callback subprog to callback-calling helper or
 			 * kfunc call. Use idx/subseq_idx check to discern it from
 			 * straight line code backtracking.
@@ -8911,10 +8848,6 @@ static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
-static bool is_iter_next_kfunc(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_ITER_NEXT;
-}
 
 static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10831,7 +10764,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return -EFAULT;
 	}
 
-	if (is_async_callback_calling_insn(insn)) {
+	if (bpf_is_async_callback_calling_insn(insn)) {
 		struct bpf_verifier_state *async_cb;
 
 		/* there is no real recursion here. timer and workqueue callbacks are async */
@@ -11594,8 +11527,8 @@ static bool can_elide_value_nullness(enum bpf_map_type type)
 	}
 }
 
-static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
-			    const struct bpf_func_proto **ptr)
+int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			 const struct bpf_func_proto **ptr)
 {
 	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID)
 		return -ERANGE;
@@ -11646,7 +11579,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* find function prototype */
 	func_id = insn->imm;
-	err = get_helper_proto(env, insn->imm, &fn);
+	err = bpf_get_helper_proto(env, insn->imm, &fn);
 	if (err == -ERANGE) {
 		verbose(env, "invalid func %s#%d\n", func_id_name(func_id), func_id);
 		return -EINVAL;
@@ -12177,10 +12110,6 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_SLEEPABLE;
-}
 
 static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12720,7 +12649,7 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
-static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
@@ -13949,10 +13878,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
-				s32 func_id,
-				s16 offset,
-				struct bpf_kfunc_call_arg_meta *meta)
+int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
+			     s32 func_id,
+			     s16 offset,
+			     struct bpf_kfunc_call_arg_meta *meta)
 {
 	struct bpf_kfunc_meta kfunc;
 	int err;
@@ -13993,7 +13922,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 	enum bpf_arg_type at;
 	s64 size;
 
-	if (get_helper_proto(env, insn->imm, &fn) < 0)
+	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
 		return S64_MIN;
 
 	at = fn->arg_type[arg];
@@ -14114,7 +14043,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	u32 nargs, type_size;
 	s64 size;
 
-	if (fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+	if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
 		return S64_MIN;
 
 	btf = meta.btf;
@@ -14364,7 +14293,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (!insn->imm)
 		return 0;
 
-	err = fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
+	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
 	if (err == -EACCES && meta.func_name)
 		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
 	if (err)
@@ -14373,7 +14302,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
-	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
+	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
 
 	if (!insn->off &&
 	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
@@ -14410,7 +14339,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
-	sleepable = is_kfunc_sleepable(&meta);
+	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 		return -EACCES;
@@ -14640,7 +14569,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
 				type |= PTR_UNTRUSTED;
 			else if (is_kfunc_rcu_protected(&meta) ||
-				 (is_iter_next_kfunc(&meta) &&
+				 (bpf_is_iter_next_kfunc(&meta) &&
 				  (get_iter_from_state(env->cur_state, &meta)
 					   ->type & MEM_RCU))) {
 				/*
@@ -14700,7 +14629,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (is_kfunc_pkt_changing(&meta))
+	if (bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
 
 	nargs = btf_type_vlen(meta.func_proto);
@@ -14716,7 +14645,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
-	if (is_iter_next_kfunc(&meta)) {
+	if (bpf_is_iter_next_kfunc(&meta)) {
 		err = process_iter_next_call(env, insn_idx, &meta);
 		if (err)
 			return err;
@@ -18343,191 +18272,6 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
-{
-	struct bpf_subprog_info *subprog;
-
-	subprog = bpf_find_containing_subprog(env, off);
-	subprog->changes_pkt_data = true;
-}
-
-static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
-{
-	struct bpf_subprog_info *subprog;
-
-	subprog = bpf_find_containing_subprog(env, off);
-	subprog->might_sleep = true;
-}
-
-/* 't' is an index of a call-site.
- * 'w' is a callee entry point.
- * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
- * Rely on DFS traversal order and absence of recursive calls to guarantee that
- * callee's change_pkt_data marks would be correct at that moment.
- */
-static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
-{
-	struct bpf_subprog_info *caller, *callee;
-
-	caller = bpf_find_containing_subprog(env, t);
-	callee = bpf_find_containing_subprog(env, w);
-	caller->changes_pkt_data |= callee->changes_pkt_data;
-	caller->might_sleep |= callee->might_sleep;
-}
-
-/* non-recursive DFS pseudo code
- * 1  procedure DFS-iterative(G,v):
- * 2      label v as discovered
- * 3      let S be a stack
- * 4      S.push(v)
- * 5      while S is not empty
- * 6            t <- S.peek()
- * 7            if t is what we're looking for:
- * 8                return t
- * 9            for all edges e in G.adjacentEdges(t) do
- * 10               if edge e is already labelled
- * 11                   continue with the next edge
- * 12               w <- G.adjacentVertex(t,e)
- * 13               if vertex w is not discovered and not explored
- * 14                   label e as tree-edge
- * 15                   label w as discovered
- * 16                   S.push(w)
- * 17                   continue at 5
- * 18               else if vertex w is discovered
- * 19                   label e as back-edge
- * 20               else
- * 21                   // vertex w is explored
- * 22                   label e as forward- or cross-edge
- * 23           label t as explored
- * 24           S.pop()
- *
- * convention:
- * 0x10 - discovered
- * 0x11 - discovered and fall-through edge labelled
- * 0x12 - discovered and fall-through and branch edges labelled
- * 0x20 - explored
- */
-
-enum {
-	DISCOVERED = 0x10,
-	EXPLORED = 0x20,
-	FALLTHROUGH = 1,
-	BRANCH = 2,
-};
-
-static void mark_prune_point(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].prune_point = true;
-}
-
-static bool is_prune_point(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].prune_point;
-}
-
-static void mark_force_checkpoint(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].force_checkpoint = true;
-}
-
-static bool is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].force_checkpoint;
-}
-
-static void mark_calls_callback(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].calls_callback = true;
-}
-
-bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].calls_callback;
-}
-
-enum {
-	DONE_EXPLORING = 0,
-	KEEP_EXPLORING = 1,
-};
-
-/* t, w, e - match pseudo-code above:
- * t - index of current instruction
- * w - next instruction
- * e - edge
- */
-static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
-{
-	int *insn_stack = env->cfg.insn_stack;
-	int *insn_state = env->cfg.insn_state;
-
-	if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
-		return DONE_EXPLORING;
-
-	if (e == BRANCH && insn_state[t] >= (DISCOVERED | BRANCH))
-		return DONE_EXPLORING;
-
-	if (w < 0 || w >= env->prog->len) {
-		verbose_linfo(env, t, "%d: ", t);
-		verbose(env, "jump out of range from insn %d to %d\n", t, w);
-		return -EINVAL;
-	}
-
-	if (e == BRANCH) {
-		/* mark branch target for state pruning */
-		mark_prune_point(env, w);
-		mark_jmp_point(env, w);
-	}
-
-	if (insn_state[w] == 0) {
-		/* tree-edge */
-		insn_state[t] = DISCOVERED | e;
-		insn_state[w] = DISCOVERED;
-		if (env->cfg.cur_stack >= env->prog->len)
-			return -E2BIG;
-		insn_stack[env->cfg.cur_stack++] = w;
-		return KEEP_EXPLORING;
-	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
-		if (env->bpf_capable)
-			return DONE_EXPLORING;
-		verbose_linfo(env, t, "%d: ", t);
-		verbose_linfo(env, w, "%d: ", w);
-		verbose(env, "back-edge from insn %d to %d\n", t, w);
-		return -EINVAL;
-	} else if (insn_state[w] == EXPLORED) {
-		/* forward- or cross-edge */
-		insn_state[t] = DISCOVERED | e;
-	} else {
-		verifier_bug(env, "insn state internal bug");
-		return -EFAULT;
-	}
-	return DONE_EXPLORING;
-}
-
-static int visit_func_call_insn(int t, struct bpf_insn *insns,
-				struct bpf_verifier_env *env,
-				bool visit_callee)
-{
-	int ret, insn_sz;
-	int w;
-
-	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
-	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
-	if (ret)
-		return ret;
-
-	mark_prune_point(env, t + insn_sz);
-	/* when we exit from subprog, we need to record non-linear history */
-	mark_jmp_point(env, t + insn_sz);
-
-	if (visit_callee) {
-		w = t + insns[t].imm + 1;
-		mark_prune_point(env, t);
-		merge_callee_effects(env, t, w);
-		ret = push_insn(t, w, BRANCH, env);
-	}
-	return ret;
-}
-
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
 
@@ -18563,7 +18307,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 
 	if (bpf_helper_call(call)) {
 
-		if (get_helper_proto(env, call->imm, &fn) < 0)
+		if (bpf_get_helper_proto(env, call->imm, &fn) < 0)
 			/* error would be reported later */
 			return false;
 		cs->fastcall = fn->allow_fastcall &&
@@ -18582,7 +18326,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 	if (bpf_pseudo_kfunc_call(call)) {
 		int err;
 
-		err = fetch_kfunc_arg_meta(env, call->imm, call->off, &meta);
+		err = bpf_fetch_kfunc_arg_meta(env, call->imm, call->off, &meta);
 		if (err < 0)
 			/* error would be reported later */
 			return false;
@@ -18784,530 +18528,6 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
-{
-	size_t new_size = sizeof(struct bpf_iarray) + n_elem * sizeof(old->items[0]);
-	struct bpf_iarray *new;
-
-	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
-	if (!new) {
-		/* this is what callers always want, so simplify the call site */
-		kvfree(old);
-		return NULL;
-	}
-
-	new->cnt = n_elem;
-	return new;
-}
-
-static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
-{
-	struct bpf_insn_array_value *value;
-	u32 i;
-
-	for (i = start; i <= end; i++) {
-		value = map->ops->map_lookup_elem(map, &i);
-		/*
-		 * map_lookup_elem of an array map will never return an error,
-		 * but not checking it makes some static analysers to worry
-		 */
-		if (IS_ERR(value))
-			return PTR_ERR(value);
-		else if (!value)
-			return -EINVAL;
-		items[i - start] = value->xlated_off;
-	}
-	return 0;
-}
-
-static int cmp_ptr_to_u32(const void *a, const void *b)
-{
-	return *(u32 *)a - *(u32 *)b;
-}
-
-static int sort_insn_array_uniq(u32 *items, int cnt)
-{
-	int unique = 1;
-	int i;
-
-	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
-
-	for (i = 1; i < cnt; i++)
-		if (items[i] != items[unique - 1])
-			items[unique++] = items[i];
-
-	return unique;
-}
-
-/*
- * sort_unique({map[start], ..., map[end]}) into off
- */
-static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
-{
-	u32 n = end - start + 1;
-	int err;
-
-	err = copy_insn_array(map, start, end, off);
-	if (err)
-		return err;
-
-	return sort_insn_array_uniq(off, n);
-}
-
-/*
- * Copy all unique offsets from the map
- */
-static struct bpf_iarray *jt_from_map(struct bpf_map *map)
-{
-	struct bpf_iarray *jt;
-	int err;
-	int n;
-
-	jt = iarray_realloc(NULL, map->max_entries);
-	if (!jt)
-		return ERR_PTR(-ENOMEM);
-
-	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->items);
-	if (n < 0) {
-		err = n;
-		goto err_free;
-	}
-	if (n == 0) {
-		err = -EINVAL;
-		goto err_free;
-	}
-	jt->cnt = n;
-	return jt;
-
-err_free:
-	kvfree(jt);
-	return ERR_PTR(err);
-}
-
-/*
- * Find and collect all maps which fit in the subprog. Return the result as one
- * combined jump table in jt->items (allocated with kvcalloc)
- */
-static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
-					  int subprog_start, int subprog_end)
-{
-	struct bpf_iarray *jt = NULL;
-	struct bpf_map *map;
-	struct bpf_iarray *jt_cur;
-	int i;
-
-	for (i = 0; i < env->insn_array_map_cnt; i++) {
-		/*
-		 * TODO (when needed): collect only jump tables, not static keys
-		 * or maps for indirect calls
-		 */
-		map = env->insn_array_maps[i];
-
-		jt_cur = jt_from_map(map);
-		if (IS_ERR(jt_cur)) {
-			kvfree(jt);
-			return jt_cur;
-		}
-
-		/*
-		 * This is enough to check one element. The full table is
-		 * checked to fit inside the subprog later in create_jt()
-		 */
-		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
-			u32 old_cnt = jt ? jt->cnt : 0;
-			jt = iarray_realloc(jt, old_cnt + jt_cur->cnt);
-			if (!jt) {
-				kvfree(jt_cur);
-				return ERR_PTR(-ENOMEM);
-			}
-			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
-		}
-
-		kvfree(jt_cur);
-	}
-
-	if (!jt) {
-		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
-		return ERR_PTR(-EINVAL);
-	}
-
-	jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
-	return jt;
-}
-
-static struct bpf_iarray *
-create_jt(int t, struct bpf_verifier_env *env)
-{
-	struct bpf_subprog_info *subprog;
-	int subprog_start, subprog_end;
-	struct bpf_iarray *jt;
-	int i;
-
-	subprog = bpf_find_containing_subprog(env, t);
-	subprog_start = subprog->start;
-	subprog_end = (subprog + 1)->start;
-	jt = jt_from_subprog(env, subprog_start, subprog_end);
-	if (IS_ERR(jt))
-		return jt;
-
-	/* Check that the every element of the jump table fits within the given subprogram */
-	for (i = 0; i < jt->cnt; i++) {
-		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
-			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
-					t, subprog_start, subprog_end);
-			kvfree(jt);
-			return ERR_PTR(-EINVAL);
-		}
-	}
-
-	return jt;
-}
-
-/* "conditional jump with N edges" */
-static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
-{
-	int *insn_stack = env->cfg.insn_stack;
-	int *insn_state = env->cfg.insn_state;
-	bool keep_exploring = false;
-	struct bpf_iarray *jt;
-	int i, w;
-
-	jt = env->insn_aux_data[t].jt;
-	if (!jt) {
-		jt = create_jt(t, env);
-		if (IS_ERR(jt))
-			return PTR_ERR(jt);
-
-		env->insn_aux_data[t].jt = jt;
-	}
-
-	mark_prune_point(env, t);
-	for (i = 0; i < jt->cnt; i++) {
-		w = jt->items[i];
-		if (w < 0 || w >= env->prog->len) {
-			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
-			return -EINVAL;
-		}
-
-		mark_jmp_point(env, w);
-
-		/* EXPLORED || DISCOVERED */
-		if (insn_state[w])
-			continue;
-
-		if (env->cfg.cur_stack >= env->prog->len)
-			return -E2BIG;
-
-		insn_stack[env->cfg.cur_stack++] = w;
-		insn_state[w] |= DISCOVERED;
-		keep_exploring = true;
-	}
-
-	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
-}
-
-/*
- * Instructions that can abnormally return from a subprog (tail_call
- * upon success, ld_{abs,ind} upon load failure) have a hidden exit
- * that the verifier must account for.
- */
-static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
-{
-	struct bpf_subprog_info *subprog;
-	struct bpf_iarray *jt;
-
-	if (env->insn_aux_data[t].jt)
-		return 0;
-
-	jt = iarray_realloc(NULL, 2);
-	if (!jt)
-		return -ENOMEM;
-
-	subprog = bpf_find_containing_subprog(env, t);
-	jt->items[0] = t + 1;
-	jt->items[1] = subprog->exit_idx;
-	env->insn_aux_data[t].jt = jt;
-	return 0;
-}
-
-/* Visits the instruction at index t and returns one of the following:
- *  < 0 - an error occurred
- *  DONE_EXPLORING - the instruction was fully explored
- *  KEEP_EXPLORING - there is still work to be done before it is fully explored
- */
-static int visit_insn(int t, struct bpf_verifier_env *env)
-{
-	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
-	int ret, off, insn_sz;
-
-	if (bpf_pseudo_func(insn))
-		return visit_func_call_insn(t, insns, env, true);
-
-	/* All non-branch instructions have a single fall-through edge. */
-	if (BPF_CLASS(insn->code) != BPF_JMP &&
-	    BPF_CLASS(insn->code) != BPF_JMP32) {
-		if (BPF_CLASS(insn->code) == BPF_LD &&
-		    (BPF_MODE(insn->code) == BPF_ABS ||
-		     BPF_MODE(insn->code) == BPF_IND)) {
-			ret = visit_abnormal_return_insn(env, t);
-			if (ret)
-				return ret;
-		}
-		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
-		return push_insn(t, t + insn_sz, FALLTHROUGH, env);
-	}
-
-	switch (BPF_OP(insn->code)) {
-	case BPF_EXIT:
-		return DONE_EXPLORING;
-
-	case BPF_CALL:
-		if (is_async_callback_calling_insn(insn))
-			/* Mark this call insn as a prune point to trigger
-			 * is_state_visited() check before call itself is
-			 * processed by __check_func_call(). Otherwise new
-			 * async state will be pushed for further exploration.
-			 */
-			mark_prune_point(env, t);
-		/* For functions that invoke callbacks it is not known how many times
-		 * callback would be called. Verifier models callback calling functions
-		 * by repeatedly visiting callback bodies and returning to origin call
-		 * instruction.
-		 * In order to stop such iteration verifier needs to identify when a
-		 * state identical some state from a previous iteration is reached.
-		 * Check below forces creation of checkpoint before callback calling
-		 * instruction to allow search for such identical states.
-		 */
-		if (is_sync_callback_calling_insn(insn)) {
-			mark_calls_callback(env, t);
-			mark_force_checkpoint(env, t);
-			mark_prune_point(env, t);
-			mark_jmp_point(env, t);
-		}
-		if (bpf_helper_call(insn)) {
-			const struct bpf_func_proto *fp;
-
-			ret = get_helper_proto(env, insn->imm, &fp);
-			/* If called in a non-sleepable context program will be
-			 * rejected anyway, so we should end up with precise
-			 * sleepable marks on subprogs, except for dead code
-			 * elimination.
-			 */
-			if (ret == 0 && fp->might_sleep)
-				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
-				mark_subprog_changes_pkt_data(env, t);
-			if (insn->imm == BPF_FUNC_tail_call) {
-				ret = visit_abnormal_return_insn(env, t);
-				if (ret)
-					return ret;
-			}
-		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			struct bpf_kfunc_call_arg_meta meta;
-
-			ret = fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-			if (ret == 0 && is_iter_next_kfunc(&meta)) {
-				mark_prune_point(env, t);
-				/* Checking and saving state checkpoints at iter_next() call
-				 * is crucial for fast convergence of open-coded iterator loop
-				 * logic, so we need to force it. If we don't do that,
-				 * is_state_visited() might skip saving a checkpoint, causing
-				 * unnecessarily long sequence of not checkpointed
-				 * instructions and jumps, leading to exhaustion of jump
-				 * history buffer, and potentially other undesired outcomes.
-				 * It is expected that with correct open-coded iterators
-				 * convergence will happen quickly, so we don't run a risk of
-				 * exhausting memory.
-				 */
-				mark_force_checkpoint(env, t);
-			}
-			/* Same as helpers, if called in a non-sleepable context
-			 * program will be rejected anyway, so we should end up
-			 * with precise sleepable marks on subprogs, except for
-			 * dead code elimination.
-			 */
-			if (ret == 0 && is_kfunc_sleepable(&meta))
-				mark_subprog_might_sleep(env, t);
-			if (ret == 0 && is_kfunc_pkt_changing(&meta))
-				mark_subprog_changes_pkt_data(env, t);
-		}
-		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
-
-	case BPF_JA:
-		if (BPF_SRC(insn->code) == BPF_X)
-			return visit_gotox_insn(t, env);
-
-		if (BPF_CLASS(insn->code) == BPF_JMP)
-			off = insn->off;
-		else
-			off = insn->imm;
-
-		/* unconditional jump with single edge */
-		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
-		if (ret)
-			return ret;
-
-		mark_prune_point(env, t + off + 1);
-		mark_jmp_point(env, t + off + 1);
-
-		return ret;
-
-	default:
-		/* conditional jump with two edges */
-		mark_prune_point(env, t);
-		if (bpf_is_may_goto_insn(insn))
-			mark_force_checkpoint(env, t);
-
-		ret = push_insn(t, t + 1, FALLTHROUGH, env);
-		if (ret)
-			return ret;
-
-		return push_insn(t, t + insn->off + 1, BRANCH, env);
-	}
-}
-
-/* non-recursive depth-first-search to detect loops in BPF program
- * loop == back-edge in directed graph
- */
-static int check_cfg(struct bpf_verifier_env *env)
-{
-	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state;
-	int ex_insn_beg, i, ret = 0;
-
-	insn_state = env->cfg.insn_state = kvzalloc_objs(int, insn_cnt,
-							 GFP_KERNEL_ACCOUNT);
-	if (!insn_state)
-		return -ENOMEM;
-
-	insn_stack = env->cfg.insn_stack = kvzalloc_objs(int, insn_cnt,
-							 GFP_KERNEL_ACCOUNT);
-	if (!insn_stack) {
-		kvfree(insn_state);
-		return -ENOMEM;
-	}
-
-	ex_insn_beg = env->exception_callback_subprog
-		      ? env->subprog_info[env->exception_callback_subprog].start
-		      : 0;
-
-	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
-	insn_stack[0] = 0; /* 0 is the first instruction */
-	env->cfg.cur_stack = 1;
-
-walk_cfg:
-	while (env->cfg.cur_stack > 0) {
-		int t = insn_stack[env->cfg.cur_stack - 1];
-
-		ret = visit_insn(t, env);
-		switch (ret) {
-		case DONE_EXPLORING:
-			insn_state[t] = EXPLORED;
-			env->cfg.cur_stack--;
-			break;
-		case KEEP_EXPLORING:
-			break;
-		default:
-			if (ret > 0) {
-				verifier_bug(env, "visit_insn internal bug");
-				ret = -EFAULT;
-			}
-			goto err_free;
-		}
-	}
-
-	if (env->cfg.cur_stack < 0) {
-		verifier_bug(env, "pop stack internal bug");
-		ret = -EFAULT;
-		goto err_free;
-	}
-
-	if (ex_insn_beg && insn_state[ex_insn_beg] != EXPLORED) {
-		insn_state[ex_insn_beg] = DISCOVERED;
-		insn_stack[0] = ex_insn_beg;
-		env->cfg.cur_stack = 1;
-		goto walk_cfg;
-	}
-
-	for (i = 0; i < insn_cnt; i++) {
-		struct bpf_insn *insn = &env->prog->insnsi[i];
-
-		if (insn_state[i] != EXPLORED) {
-			verbose(env, "unreachable insn %d\n", i);
-			ret = -EINVAL;
-			goto err_free;
-		}
-		if (bpf_is_ldimm64(insn)) {
-			if (insn_state[i + 1] != 0) {
-				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
-				ret = -EINVAL;
-				goto err_free;
-			}
-			i++; /* skip second half of ldimm64 */
-		}
-	}
-	ret = 0; /* cfg looks good */
-	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
-	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
-
-err_free:
-	kvfree(insn_state);
-	kvfree(insn_stack);
-	env->cfg.insn_state = env->cfg.insn_stack = NULL;
-	return ret;
-}
-
-/*
- * For each subprogram 'i' fill array env->cfg.insn_subprogram sub-range
- * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
- * with indices of 'i' instructions in postorder.
- */
-int bpf_compute_postorder(struct bpf_verifier_env *env)
-{
-	u32 cur_postorder, i, top, stack_sz, s;
-	int *stack = NULL, *postorder = NULL, *state = NULL;
-	struct bpf_iarray *succ;
-
-	postorder = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	state = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	stack = kvzalloc_objs(int, env->prog->len, GFP_KERNEL_ACCOUNT);
-	if (!postorder || !state || !stack) {
-		kvfree(postorder);
-		kvfree(state);
-		kvfree(stack);
-		return -ENOMEM;
-	}
-	cur_postorder = 0;
-	for (i = 0; i < env->subprog_cnt; i++) {
-		env->subprog_info[i].postorder_start = cur_postorder;
-		stack[0] = env->subprog_info[i].start;
-		stack_sz = 1;
-		do {
-			top = stack[stack_sz - 1];
-			state[top] |= DISCOVERED;
-			if (state[top] & EXPLORED) {
-				postorder[cur_postorder++] = top;
-				stack_sz--;
-				continue;
-			}
-			succ = bpf_insn_successors(env, top);
-			for (s = 0; s < succ->cnt; ++s) {
-				if (!state[succ->items[s]]) {
-					stack[stack_sz++] = succ->items[s];
-					state[succ->items[s]] |= DISCOVERED;
-				}
-			}
-			state[top] |= EXPLORED;
-		} while (stack_sz);
-	}
-	env->subprog_info[i].postorder_start = cur_postorder;
-	env->cfg.insn_postorder = postorder;
-	env->cfg.cur_postorder = cur_postorder;
-	kvfree(stack);
-	kvfree(state);
-	return 0;
-}
-
 static int check_abnormal_return(struct bpf_verifier_env *env)
 {
 	int i;
@@ -20724,7 +19944,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
-	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
+	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
 			  cur->jmp_history_cnt > 40;
 
@@ -21004,7 +20224,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 * Use bigger 'n' for checkpoints because evicting checkpoint states
 		 * too early would hinder iterator convergence.
 		 */
-		n = is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
+		n = bpf_is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
 		if (sl->miss_cnt > sl->hit_cnt * n + n) {
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
@@ -21307,13 +20527,13 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 
 	/* Ensure that the buffer is large enough */
 	if (!env->gotox_tmp_buf || env->gotox_tmp_buf->cnt < max_index - min_index + 1) {
-		env->gotox_tmp_buf = iarray_realloc(env->gotox_tmp_buf,
-						    max_index - min_index + 1);
+		env->gotox_tmp_buf = bpf_iarray_realloc(env->gotox_tmp_buf,
+						        max_index - min_index + 1);
 		if (!env->gotox_tmp_buf)
 			return -ENOMEM;
 	}
 
-	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf->items);
+	n = bpf_copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf->items);
 	if (n < 0)
 		return n;
 	if (n == 0) {
@@ -21465,7 +20685,7 @@ static int do_check(struct bpf_verifier_env *env)
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
 
-		if (is_prune_point(env, env->insn_idx)) {
+		if (bpf_is_prune_point(env, env->insn_idx)) {
 			err = is_state_visited(env, env->insn_idx);
 			if (err < 0)
 				return err;
@@ -23460,190 +22680,6 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
-/*
- * Compute strongly connected components (SCCs) on the CFG.
- * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
- * If instruction is a sole member of its SCC and there are no self edges,
- * assign it SCC number of zero.
- * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computation.
- */
-static int compute_scc(struct bpf_verifier_env *env)
-{
-	const u32 NOT_ON_STACK = U32_MAX;
-
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	const u32 insn_cnt = env->prog->len;
-	int stack_sz, dfs_sz, err = 0;
-	u32 *stack, *pre, *low, *dfs;
-	u32 i, j, t, w;
-	u32 next_preorder_num;
-	u32 next_scc_id;
-	bool assign_scc;
-	struct bpf_iarray *succ;
-
-	next_preorder_num = 1;
-	next_scc_id = 1;
-	/*
-	 * - 'stack' accumulates vertices in DFS order, see invariant comment below;
-	 * - 'pre[t] == p' => preorder number of vertex 't' is 'p';
-	 * - 'low[t] == n' => smallest preorder number of the vertex reachable from 't' is 'n';
-	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
-	 */
-	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
-	if (!stack || !pre || !low || !dfs) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	/*
-	 * References:
-	 * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
-	 * [2] D. J. Pearce "A Space-Efficient Algorithm for Finding Strongly Connected Components"
-	 *
-	 * The algorithm maintains the following invariant:
-	 * - suppose there is a path 'u' ~> 'v', such that 'pre[v] < pre[u]';
-	 * - then, vertex 'u' remains on stack while vertex 'v' is on stack.
-	 *
-	 * Consequently:
-	 * - If 'low[v] < pre[v]', there is a path from 'v' to some vertex 'u',
-	 *   such that 'pre[u] == low[v]'; vertex 'u' is currently on the stack,
-	 *   and thus there is an SCC (loop) containing both 'u' and 'v'.
-	 * - If 'low[v] == pre[v]', loops containing 'v' have been explored,
-	 *   and 'v' can be considered the root of some SCC.
-	 *
-	 * Here is a pseudo-code for an explicitly recursive version of the algorithm:
-	 *
-	 *    NOT_ON_STACK = insn_cnt + 1
-	 *    pre = [0] * insn_cnt
-	 *    low = [0] * insn_cnt
-	 *    scc = [0] * insn_cnt
-	 *    stack = []
-	 *
-	 *    next_preorder_num = 1
-	 *    next_scc_id = 1
-	 *
-	 *    def recur(w):
-	 *        nonlocal next_preorder_num
-	 *        nonlocal next_scc_id
-	 *
-	 *        pre[w] = next_preorder_num
-	 *        low[w] = next_preorder_num
-	 *        next_preorder_num += 1
-	 *        stack.append(w)
-	 *        for s in successors(w):
-	 *            # Note: for classic algorithm the block below should look as:
-	 *            #
-	 *            # if pre[s] == 0:
-	 *            #     recur(s)
-	 *            #	    low[w] = min(low[w], low[s])
-	 *            # elif low[s] != NOT_ON_STACK:
-	 *            #     low[w] = min(low[w], pre[s])
-	 *            #
-	 *            # But replacing both 'min' instructions with 'low[w] = min(low[w], low[s])'
-	 *            # does not break the invariant and makes itartive version of the algorithm
-	 *            # simpler. See 'Algorithm #3' from [2].
-	 *
-	 *            # 's' not yet visited
-	 *            if pre[s] == 0:
-	 *                recur(s)
-	 *            # if 's' is on stack, pick lowest reachable preorder number from it;
-	 *            # if 's' is not on stack 'low[s] == NOT_ON_STACK > low[w]',
-	 *            # so 'min' would be a noop.
-	 *            low[w] = min(low[w], low[s])
-	 *
-	 *        if low[w] == pre[w]:
-	 *            # 'w' is the root of an SCC, pop all vertices
-	 *            # below 'w' on stack and assign same SCC to them.
-	 *            while True:
-	 *                t = stack.pop()
-	 *                low[t] = NOT_ON_STACK
-	 *                scc[t] = next_scc_id
-	 *                if t == w:
-	 *                    break
-	 *            next_scc_id += 1
-	 *
-	 *    for i in range(0, insn_cnt):
-	 *        if pre[i] == 0:
-	 *            recur(i)
-	 *
-	 * Below implementation replaces explicit recursion with array 'dfs'.
-	 */
-	for (i = 0; i < insn_cnt; i++) {
-		if (pre[i])
-			continue;
-		stack_sz = 0;
-		dfs_sz = 1;
-		dfs[0] = i;
-dfs_continue:
-		while (dfs_sz) {
-			w = dfs[dfs_sz - 1];
-			if (pre[w] == 0) {
-				low[w] = next_preorder_num;
-				pre[w] = next_preorder_num;
-				next_preorder_num++;
-				stack[stack_sz++] = w;
-			}
-			/* Visit 'w' successors */
-			succ = bpf_insn_successors(env, w);
-			for (j = 0; j < succ->cnt; ++j) {
-				if (pre[succ->items[j]]) {
-					low[w] = min(low[w], low[succ->items[j]]);
-				} else {
-					dfs[dfs_sz++] = succ->items[j];
-					goto dfs_continue;
-				}
-			}
-			/*
-			 * Preserve the invariant: if some vertex above in the stack
-			 * is reachable from 'w', keep 'w' on the stack.
-			 */
-			if (low[w] < pre[w]) {
-				dfs_sz--;
-				goto dfs_continue;
-			}
-			/*
-			 * Assign SCC number only if component has two or more elements,
-			 * or if component has a self reference, or if instruction is a
-			 * callback calling function (implicit loop).
-			 */
-			assign_scc = stack[stack_sz - 1] != w;	/* two or more elements? */
-			for (j = 0; j < succ->cnt; ++j) {	/* self reference? */
-				if (succ->items[j] == w) {
-					assign_scc = true;
-					break;
-				}
-			}
-			if (bpf_calls_callback(env, w)) /* implicit loop? */
-				assign_scc = true;
-			/* Pop component elements from stack */
-			do {
-				t = stack[--stack_sz];
-				low[t] = NOT_ON_STACK;
-				if (assign_scc)
-					aux[t].scc = next_scc_id;
-			} while (t != w);
-			if (assign_scc)
-				next_scc_id++;
-			dfs_sz--;
-		}
-	}
-	env->scc_info = kvzalloc_objs(*env->scc_info, next_scc_id,
-				      GFP_KERNEL_ACCOUNT);
-	if (!env->scc_info) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	env->scc_cnt = next_scc_id;
-exit:
-	kvfree(stack);
-	kvfree(pre);
-	kvfree(low);
-	kvfree(dfs);
-	return err;
-}
-
 /* replace a generic kfunc with a specialized version if necessary */
 static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
@@ -23880,7 +22916,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		goto err_free_env;
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
-	env->succ = iarray_realloc(NULL, 2);
+	env->succ = bpf_iarray_realloc(NULL, 2);
 	if (!env->succ)
 		goto err_free_env;
 	env->prog = *prog;
@@ -23967,7 +23003,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 			goto skip_full_check;
 	}
 
-	ret = check_cfg(env);
+	ret = bpf_check_cfg(env);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -23995,7 +23031,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = compute_scc(env);
+	ret = bpf_compute_scc(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.52.0

