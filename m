Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49A360EFC
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033908; cv=none; b=KEfJqgNXDXMDWxRMOn2BpVFew7yPaOLAvcyCnEdNKbRnVHzgoGtDj0tnhXbtG56ZB7BAGv9Qkz95v//8cHzKchWevDPyhwCt/vn3Ddf89uBKVolRs1naBnVmwNXrsqcsFvSmvl9BHf/juZLb0/8mMRmvwEtazpP2EXzbTpmegio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033908; c=relaxed/simple;
	bh=Igya2uzXY7jxTXWYKcaZrrdYdoDyKZSmXPXaO6TUmKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJnPJOj4vv2vwnIgN2ObFRrzn8vpXieidLd85wM1BMhpeYSTXjRWNz2cEUkeij7+nL/gIn4/1/7hL50xAATiuQ9t0YRCrMjnVUw4BlUAsutuyYffcuTMegrmNvJrFcfGLrf8SeYM1POQdKuqzvUzGB8NmmwUReN4TGkxc2hziJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iAYRg+s5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iAYRg+s5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4be4CV0wvyS6UBImdwZC80T7UBusPx0vVlcSRKUsdRI=;
	b=iAYRg+s53N1gQoI2aURmCIEKXroZmdqxYGDrncPECjnWdfiW5C69P4suDTYiq5gZk4YySy
	Sby2dpkiYuuf504We4oF2HM2XRUJZ3r+cjTRReXMclprw03pdvXMQSvHj3m7aSo8+wE6pS
	ddzoOWUcq+ooaWJ0XE/GohevUs5SQjA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v11 01/10] bpf: Drop duplicate blank lines in kernel/bpf/
Date: Fri,  7 Aug 2026 00:31:16 +0800
Message-ID: <20260806163125.11172-2-leon.hwang@linux.dev>
In-Reply-To: <20260806163125.11172-1-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are many adjacent blank lines in kernel/bpf/ that have accumulated
over time.

Drop them for cleanup.

No functional changes intended.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/backtrack.c        |  2 --
 kernel/bpf/btf.c              |  1 -
 kernel/bpf/cfg.c              |  1 -
 kernel/bpf/fixups.c           |  1 -
 kernel/bpf/hashtab.c          |  2 --
 kernel/bpf/helpers.c          |  1 -
 kernel/bpf/liveness.c         |  2 --
 kernel/bpf/queue_stack_maps.c |  1 -
 kernel/bpf/syscall.c          |  5 -----
 kernel/bpf/verifier.c         | 14 --------------
 10 files changed, 30 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2f473ad4fd7c..3f150e858ae8 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -214,7 +214,6 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
 
-
 /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
 static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 {
@@ -254,7 +253,6 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 	}
 }
 
-
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 42414633cf26..c807ad263e6f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2534,7 +2534,6 @@ static void btf_bitfield_show(void *data, u8 bits_offset,
 	btf_int128_print(show, print_num);
 }
 
-
 static void btf_int_bits_show(const struct btf *btf,
 			      const struct btf_type *t,
 			      void *data, u8 bits_offset,
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index db3416a7c904..818f7afac83a 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -47,7 +47,6 @@ enum {
 	BRANCH = 2,
 };
 
-
 static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a0bddada7964..440e73e1b11b 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1446,7 +1446,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
-
 /* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..d40cb5dd446c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -998,7 +998,6 @@ static void dec_elem_count(struct bpf_htab *htab)
 		atomic_dec(&htab->count);
 }
 
-
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
@@ -2970,7 +2969,6 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 	return 0;
 }
 
-
 static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6388b6b23e49..45e2f19387b2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4871,7 +4871,6 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
-
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..9e25e241e1ff 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -269,7 +269,6 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 
 __diag_pop();
 
-
 static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
@@ -1868,7 +1867,6 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	if (need_resched())
 		cond_resched();
 
-
 	/*
 	 * When an instance is reused (must_write_initialized == true),
 	 * record into a fresh instance and merge afterward.  This avoids
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index c1c9dee4dcdd..6e8b18c32a10 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -123,7 +123,6 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	return err;
 }
 
-
 static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d111da88655..7d8c3e8e6d62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -636,7 +636,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	return ret;
 }
 
-
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
@@ -1830,7 +1829,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
-
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
@@ -3497,7 +3495,6 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer)
 	if (fd < 0)
 		return fd;
 
-
 	id = bpf_link_alloc_id(link);
 	if (id < 0) {
 		put_unused_fd(fd);
@@ -5505,7 +5502,6 @@ static int bpf_link_get_info_by_fd(struct file *file,
 	return 0;
 }
 
-
 static int token_get_info_by_fd(struct file *file,
 				struct bpf_token *token,
 				const union bpf_attr *attr,
@@ -6507,7 +6503,6 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL), 0);
 }
 
-
 /* To shut up -Wmissing-prototypes.
  * This function is used by the kernel light skeleton
  * to load bpf programs when modules are loaded or during kernel boot.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6233c0081d1..b790ee42d25a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -635,7 +635,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
 			      bool first_slot, int id, int parent_id);
 
-
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
@@ -1672,7 +1671,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-
 void bpf_free_backedges(struct bpf_scc_visit *visit)
 {
 	struct bpf_scc_backedge *backedge, *next;
@@ -2294,7 +2292,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-
 static int cmp_subprogs(const void *a, const void *b)
 {
 	return ((struct bpf_subprog_info *)a)->start -
@@ -4071,7 +4068,6 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	return err;
 }
 
-
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4869,7 +4865,6 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 		valid = false;
 	}
 
-
 	if (valid) {
 		env->insn_aux_data[insn_idx].ctx_field_size =
 			info.ctx_field_size;
@@ -6727,7 +6722,6 @@ static int check_stack_range_initialized(
 	if (err)
 		return err;
 
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
 	} else {
@@ -7443,7 +7437,6 @@ static bool is_iter_new_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
-
 static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_DESTROY;
@@ -11670,7 +11663,6 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 	return 0;
 }
 
-
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = reg_btf_record(reg);
@@ -16499,7 +16491,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -18445,8 +18436,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
 		bpf_insn_array_release(env->insn_array_maps[i]);
 }
 
-
-
 /* The verifier does more data flow analysis than llvm and will not
  * explore branches that are dead at run time. Malicious programs can
  * have dead code too. Therefore replace all dead at-run-time code
@@ -18474,8 +18463,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-
-
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
@@ -18757,7 +18744,6 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
-
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
-- 
2.55.0

