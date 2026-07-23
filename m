Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970C344D9D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783314; cv=none; b=Sj0pCJY0FquzzJ27mtnzNLTVsXbP5Vbi95GL2HOEqR70OLeVwPg0xPzs+6zwFpHUFVP41N/rpyJLuINK+6Kpv4wkhOvN+/iZzYdpse3PlpojlBYlpDe5pq3hQ6p/YQhfPLpDidgppZN7uz3sslvieXEq1aZo3cCC6TFCbOZQ7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783314; c=relaxed/simple;
	bh=nrQDOFIkm7BQ3m+0sWiSi9mQ0zEsiDOS2v1It6CBcuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk+NIEPsJ8FN6Ecy0c53LiXSqowb4DfBuIpRLmLv3D0kQFeR6FPfoIPrc+s5+2yTrg7ky2Bccp7ZMqyl+Q71QSypOmYotKdXUvtfiEAf9xgIE+gE+QQkTPM4eeFbhVuVgbcHWjyYemaIJljK9DquFkpYnNWb1DBcEYGLG9TT0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbpVNWYU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbpVNWYU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e27035206so223970b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783312; x=1785388112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2P48KjdF4mq/Bpum8YmOl9M7vtrUIRVypd5dpxZrxM=;
        b=RbpVNWYUVqgeMUk7QSa53RltC5kJV8XbbDGnWsgFoSyfayjN0c8lkf/Qlb+0yySixX
         /TqoUy2UK84Q1VmP+YN+qlTTQ93W6LF4tcn6oflIcCqre5dVaQlQepHazVftvVvglV9N
         7uJ6BbPP7g9MKeSX5UAjIajgtFT7Nd7yTL+S/Fa8ft9XxCcHLuk1LoHY1xLW/ZmVGk7+
         XJc9/E1PBRkKueB+d1won+I+anXdAOoYi2ApQoa930dRsetlunLhjfvN6h7RD7g66DcK
         Tlc4jfNQbIcZhxET9JnlszxGjigl1yLQcjCTvpYfTjmqYIgLQkltB0ZD4iX7V7HxQWtj
         ky1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783312; x=1785388112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2P48KjdF4mq/Bpum8YmOl9M7vtrUIRVypd5dpxZrxM=;
        b=eEQshdKRqCgUdxDw6d+FAaj8EGySrnmaUgza8hLR9NvxPrw6xtQgohhVJMVgS2geHZ
         naJp0VLiwWNBM3Wk/vnWSUBjHF15sQmvlc3hffICAZTYe0lf8f5idrQZCaMw8J6WWLcO
         vyk1O242NEhEt/jrUFhem0FvoitinEiV01g5zibcRFHG6UwZtzqDvknrGYA9GfWHveGX
         bZgd49tiT8wFCFwG7zE7vE5w9Jqgr6PqK3rm0MEUZLxvzjitxglyiV/XgrDL0DGphQWu
         1zdc9MwmH0QDaO8w232ivjfQZMtr/sRVF4gqDr1QfLEoo9emdTB7g9r0wiRmObKg+aTq
         hJLQ==
X-Gm-Message-State: AOJu0YyL/e0CL+tmeEhQBzCt5Fs0Z219xwmWynIkgqjzJ8qeQz470u6J
	N5ofFurE7iw2x+eL6z9Frme2Xp3luJOZTApbEjIjTPSFo1i1BszvVqLJNr/cMw==
X-Gm-Gg: AR+sD101FA2XgsjOLfB3m7CUOjRqnfg7RPhu8Y1JZPKMdGKxDRfkrGpYvoxeQX68sX0
	QEsmo9dpFBJY/2mF/6kX+Rqj2mpcxpl/7k5dsnN34BZ79ziY4bF+tZGkK3zIyUqADm0hicLbV2d
	n/mIwSlpHv4jbmwlNlLaIl8EJDdRjgFzGQe7nDzs7nJMklI0LlkE9l8b4+wowBi78baQ7NK9Mas
	Ovj2nR9G++MsyjZ4BT2vQ40nVbLefwy3+JwLe3M5YmSUkVSweuL7R2cOWvNl5Ar5ereBo0NStPw
	pBoU8CuYSsG6ubLEaXwTGsWqG9I7ecvZZT5VnLC12/Bntu+Fo/Fk/h4eAloQNCjkeDgj0tDPioV
	agKwMUo5XR6pa3ViBXXWZlFfp8ULuiyBTJFNjbQmO+dkXmC297gdFZZvfVI6f8/xEmrVf
X-Received: by 2002:a05:6a00:12cd:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-84e2bbeebc7mr1895838b3a.6.1784783312386;
        Wed, 22 Jul 2026 22:08:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm1589167b3a.11.2026.07.22.22.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 18/18] bpf: Generate kfunc argument prototype at add-call time
Date: Wed, 22 Jul 2026 22:08:06 -0700
Message-ID: <20260723050806.1158442-19-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfunc argument checking re-derives each argument's kfunc_ptr_arg_type from
BTF on every verification of a call in check_kfunc_args(). Now that
get_kfunc_arg_type() is a function of the kfunc's BTF alone, it no
longer inspects register state. The classification can be computed once
when the call is added and cached. This is a step toward describing
kfuncs with a bpf_func_proto and sharing the helper argument-checking path.

Generate the classification at bpf_add_kfunc_call() time:

- Extend struct bpf_func_proto to be able to describe a kfunc: widen
  arg_type[] and the arg_btf_id[]/arg_size[] union from 5 to
  MAX_BPF_FUNC_ARGS, since a kfunc may take up to 12 arguments (5 in
  registers, 7 on the stack).

- Add a bpf_func_proto pointer to struct bpf_kfunc_desc, populated by
  gen_kfunc_arg_proto() which runs get_kfunc_arg_type() for each
  argument and stores the result in proto->arg_type[]. It is
  freed with the descriptor table in bpf_free_kfunc_desc_tab().

- check_kfunc_args() reads the cached classification from meta->fn

The KF_ARG_PTR_TO_CTX classification depends on the resolved program type,
and for BPF_PROG_TYPE_EXT the target type (saved_dst_prog_type) is only
recorded later, in check_attach_btf_id(). Make resolve_prog_type() fall
back to prog->aux->dst_prog->type, which is set at load time and holds the
same value, so the resolved type is available at add-call time without
reordering verification passes. This keeps e.g. an freplace of an XDP
program calling bpf_xdp_metadata_rx_hash() classifying its struct xdp_md *
argument as context.

The classification result is unchanged; it is only computed earlier and
cached.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h          |  36 +++++-----
 include/linux/bpf_verifier.h |  18 ++++-
 kernel/bpf/core.c            |   4 +-
 kernel/bpf/syscall.c         |   2 +-
 kernel/bpf/verifier.c        | 127 +++++++++++++++++++++++++++--------
 5 files changed, 138 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4fd360228321..2ea5ce30f729 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -962,6 +962,21 @@ enum bpf_return_type {
 };
 static_assert(__BPF_RET_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
+/* The longest tracepoint has 12 args.
+ * See include/trace/bpf_probe.h
+ *
+ * Also reuse this macro for maximum number of arguments a BPF function
+ * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
+ * stack arg slots. The JIT may map some stack arg slots to registers based
+ * on the native calling convention (e.g., arg 6 to R9 on x86-64).
+ */
+#define MAX_BPF_FUNC_ARGS 12
+
+/* The maximum number of arguments passed through registers
+ * a single function may have.
+ */
+#define MAX_BPF_FUNC_REG_ARGS 5
+
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
  * to in-kernel helper functions and for adjusting imm32 field in BPF_CALL
  * instructions after verifying
@@ -986,7 +1001,7 @@ struct bpf_func_proto {
 			enum bpf_arg_type arg4_type;
 			enum bpf_arg_type arg5_type;
 		};
-		enum bpf_arg_type arg_type[5];
+		enum bpf_arg_type arg_type[MAX_BPF_FUNC_ARGS];
 	};
 	union {
 		struct {
@@ -996,7 +1011,7 @@ struct bpf_func_proto {
 			u32 *arg4_btf_id;
 			u32 *arg5_btf_id;
 		};
-		u32 *arg_btf_id[5];
+		u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
 		struct {
 			size_t arg1_size;
 			size_t arg2_size;
@@ -1004,7 +1019,7 @@ struct bpf_func_proto {
 			size_t arg4_size;
 			size_t arg5_size;
 		};
-		size_t arg_size[5];
+		size_t arg_size[MAX_BPF_FUNC_ARGS];
 	};
 	int *ret_btf_id; /* return value btf_id */
 	bool (*allowed)(const struct bpf_prog *prog);
@@ -1194,21 +1209,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-/* The longest tracepoint has 12 args.
- * See include/trace/bpf_probe.h
- *
- * Also reuse this macro for maximum number of arguments a BPF function
- * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
- * stack arg slots. The JIT may map some stack arg slots to registers based
- * on the native calling convention (e.g., arg 6 to R9 on x86-64).
- */
-#define MAX_BPF_FUNC_ARGS 12
-
-/* The maximum number of arguments passed through registers
- * a single function may have.
- */
-#define MAX_BPF_FUNC_REG_ARGS 5
-
 /* The argument is a structure or a union. */
 #define BTF_FMODEL_STRUCT_ARG		BIT(0)
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b54c1a5c9b11..0655164e6af2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1188,6 +1188,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
+void bpf_free_kfunc_desc_tab(struct bpf_kfunc_desc_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
@@ -1305,8 +1306,19 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
-		prog->aux->saved_dst_prog_type : prog->type;
+	if (prog->type == BPF_PROG_TYPE_EXT) {
+		/*
+		 * saved_dst_prog_type is only set once check_attach_btf_id()
+		 * runs. Before that -- e.g. when generating kfunc prototypes at
+		 * add-call time -- fall back to the attach target's type, which
+		 * is available from load time and holds the same value.
+		 */
+		if (prog->aux->saved_dst_prog_type)
+			return prog->aux->saved_dst_prog_type;
+		if (prog->aux->dst_prog)
+			return prog->aux->dst_prog->type;
+	}
+	return prog->type;
 }
 
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
@@ -1489,6 +1501,7 @@ struct bpf_call_arg_meta {
 	/* Common */
 	struct btf *btf;
 	u32 func_id;
+	const struct bpf_func_proto *fn;
 	u8 release_regno;
 	u32 ret_btf_id;
 	u32 subprogno;
@@ -1617,6 +1630,7 @@ enum bpf_reg_arg_type {
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
+	struct bpf_func_proto *proto;
 	u32 func_id;
 	s32 imm;
 	u16 offset;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..a30e7471e9d8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -198,7 +198,9 @@ void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
 		prog->aux->jited_linfo = NULL;
 	}
 
-	kfree(prog->aux->kfunc_tab);
+#ifdef CONFIG_BPF_SYSCALL
+	bpf_free_kfunc_desc_tab(prog->aux->kfunc_tab);
+#endif
 	prog->aux->kfunc_tab = NULL;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 67704ddd29cb..0b5dc6788ba2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2444,7 +2444,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	module_put(prog->aux->mod);
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
-	kfree(prog->aux->kfunc_tab);
+	bpf_free_kfunc_desc_tab(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ba2608592bd5..aca37a7bf2cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2719,8 +2719,25 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int gen_kfunc_arg_proto(struct bpf_verifier_env *env,
+			       struct bpf_call_arg_meta *meta,
+			       struct bpf_func_proto *proto);
+
+void bpf_free_kfunc_desc_tab(struct bpf_kfunc_desc_tab *tab)
+{
+	u32 i;
+
+	if (!tab)
+		return;
+	for (i = 0; i < tab->nr_descs; i++)
+		kfree(tab->descs[i].proto);
+	kfree(tab);
+}
+
 int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 {
+	struct bpf_call_arg_meta meta;
+	struct bpf_func_proto *proto;
 	struct bpf_kfunc_btf_tab *btf_tab;
 	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
@@ -2806,11 +2823,29 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	if (err)
 		return err;
 
+	proto = kzalloc_obj(*proto, GFP_KERNEL_ACCOUNT);
+	if (!proto)
+		return -ENOMEM;
+
+	memset(&meta, 0, sizeof(meta));
+	meta.btf = kfunc.btf;
+	meta.func_id = kfunc.id;
+	meta.func_proto = kfunc.proto;
+	meta.func_name = kfunc.name;
+	meta.kfunc_flags = kfunc.flags ? *kfunc.flags : 0;
+
+	err = gen_kfunc_arg_proto(env, &meta, proto);
+	if (err) {
+		kfree(proto);
+		return err;
+	}
+
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
+	desc->proto = proto;
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
 	return 0;
@@ -8358,9 +8393,9 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
-			  const struct bpf_func_proto *fn,
 			  int insn_idx)
 {
+	const struct bpf_func_proto *fn = meta->fn;
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
@@ -8864,7 +8899,7 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
 		if (meta->arg_raw_mem.regno)
@@ -8881,7 +8916,7 @@ static bool check_args_pair_invalid(const struct bpf_func_proto *fn, int arg)
 	bool has_size = fn->arg_size[arg] != 0;
 	bool is_next_size = false;
 
-	if (arg + 1 < ARRAY_SIZE(fn->arg_type))
+	if (arg + 1 < MAX_BPF_FUNC_REG_ARGS)
 		is_next_size = arg_type_is_mem_size(fn->arg_type[arg + 1]);
 
 	if (base_type(fn->arg_type[arg]) != ARG_PTR_TO_MEM)
@@ -8912,7 +8947,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
@@ -8931,7 +8966,7 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
 		if (base_type(arg_type) != ARG_PTR_TO_MEM)
@@ -8947,7 +8982,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
 		if (arg_type_is_release(arg_type)) {
@@ -10338,9 +10373,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->insn_aux_data[insn_idx].non_sleepable = true;
 
 	meta.func_id = func_id;
+	meta.fn = fn;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-		err = check_func_arg(env, i, &meta, fn, insn_idx);
+		err = check_func_arg(env, i, &meta, insn_idx);
 		if (err)
 			return err;
 	}
@@ -11367,13 +11403,15 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
-		   const struct btf_type *t, const struct btf_type *ref_t,
-		   const char *ref_tname, const struct btf_param *args,
-		   int arg, int nargs, argno_t argno)
+		   const struct btf_param *args, int arg, int nargs, argno_t argno)
 {
+	const struct btf_type *t, *ref_t = NULL;
+	const char *ref_tname = NULL;
 	bool arg_mem_size = false;
 	int arg_type;
 
+	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
+
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
 	if (btf_type_is_scalar(t)) {
 		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
@@ -11394,6 +11432,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EINVAL;
 	}
 
+	ref_t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
+
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -11473,6 +11514,45 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return arg_type;
 }
 
+static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			       struct bpf_func_proto *proto)
+{
+	const struct btf *btf = meta->btf;
+	const struct btf_param *args;
+	u32 i, nargs;
+	int arg_type;
+
+	args = (const struct btf_param *)(meta->func_proto + 1);
+	nargs = btf_type_vlen(meta->func_proto);
+	if (nargs > MAX_BPF_FUNC_ARGS) {
+		verbose(env, "Function %s has %d > %d args\n", meta->func_name,
+			nargs, MAX_BPF_FUNC_ARGS);
+		return -EINVAL;
+	}
+	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
+		verbose(env, "JIT does not support kfunc %s() with %d args\n",
+			meta->func_name, nargs);
+		return -ENOTSUPP;
+	}
+
+	for (i = 0; i < nargs; i++) {
+		argno_t argno = argno_from_arg(i + 1);
+
+		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
+		    is_kfunc_arg_ignore(btf, &args[i]) ||
+		    is_kfunc_arg_implicit(meta, i))
+			continue;
+
+		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs, argno);
+		if (arg_type < 0)
+			return arg_type;
+
+		proto->arg_type[i] = arg_type;
+	}
+
+	return 0;
+}
+
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 					struct bpf_reg_state *reg,
 					const struct btf_type *ref_t,
@@ -12056,16 +12136,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 	args = (const struct btf_param *)(meta->func_proto + 1);
 	nargs = btf_type_vlen(meta->func_proto);
-	if (nargs > MAX_BPF_FUNC_ARGS) {
-		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
-			MAX_BPF_FUNC_ARGS);
-		return -EINVAL;
-	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
-		verbose(env, "JIT does not support kfunc %s() with %d args\n",
-			func_name, nargs);
-		return -ENOTSUPP;
-	}
 
 	ret = check_outgoing_stack_args(env, caller, nargs);
 	if (ret)
@@ -12082,7 +12152,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		int kf_arg_type;
+		int kf_arg_type = meta->fn->arg_type[i];
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
@@ -12127,11 +12197,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		kf_arg_type = get_kfunc_arg_type(env, meta, t, ref_t, ref_tname,
-						 args, i, nargs, argno);
-		if (kf_arg_type < 0)
-			return kf_arg_type;
-
 		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
 			continue;
 
@@ -12694,7 +12759,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			size = fn->arg_size[arg];
 			goto out;
 		}
-		if (arg + 1 < ARRAY_SIZE(fn->arg_type) &&
+		if (arg + 1 < MAX_BPF_FUNC_REG_ARGS &&
 		    arg_type_is_mem_size(fn->arg_type[arg + 1])) {
 			int size_reg = BPF_REG_1 + arg + 1;
 
@@ -12993,6 +13058,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
+	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
 
@@ -13009,6 +13075,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
+	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	if (!desc) {
+		verifier_bug(env, "kfunc descriptor not found for func_id %u", insn->imm);
+		return -EFAULT;
+	}
+	meta.fn = desc->proto;
+
 	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
 
 	if (!insn->off &&
-- 
2.52.0

