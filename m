Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869C4570C1
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920116; cv=none; b=pbA4VLnVDa70towSPZZ1o9OAJ3Rbp8+lJ7+kUXtZI8CHkcPwNvtcWQfCyq3HETXPCm9+8UgFSNnhJoBvmZ1avUIDXK6qc/uCKAQSd2wfRgp2TpPbBhevYhXliAZZepoCTHh0lgmuCe6bw+nJn9UZlEQcQTaFLPotVHco3r3tDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920116; c=relaxed/simple;
	bh=KcbQG8WPKh0s5lJP0QxAXfnCHQ4HDZKCRbw6KkjZWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQPDdAhV7YWVg+6XKQ5UAAysdYwzXlBNrc953UVCoqfRaSkSvTr0xJ0jKmK45RsXFBo4hvLm5QdPti6yFqGDGw3dejRftm9ZHhYM2WY4CLLw1ei+e0/95OHTA4jd6l5iBNEmAV2L5ASwmdGXQscALISCKcAf6Hx3qpiLoQbKBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4MGSTFF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4MGSTFF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so654610a91.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920114; x=1785524914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9qOI75ELhLEcchvPZ2jY9GPE900Au1VP+Q7bqAG/tM=;
        b=b4MGSTFFlSsg1113CPTZ+3HxOEKLMJ3rpkongqM2TGnhOyXzMAcUD/qxNgUylegaB5
         lBFSwftiui5OaezPKEUSYOm0e0X2aSf4O1yzgcA5dQ3LJoUf/Rdbi0ef44WQTDrtiiBR
         Cf8vNaQnnWRcrkpC8uS1romXMi6igWs9JVIsfvTP52GYL0N+mPbMWGe18mqLJAchYe6V
         /wb4cJ1yEkv1+X+L5JWl9agumqF31MwURnLkx7qp65dh9Yzs/Cqevq9BaUpgLj0terAd
         V7rwCBYARUOyrkEB0bF4BzzReCvOaEPIoITZ4rCucZgROilaOY4hhIRIPjU4asu0r2+d
         NxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920114; x=1785524914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9qOI75ELhLEcchvPZ2jY9GPE900Au1VP+Q7bqAG/tM=;
        b=ixR5siMxXq9Wig/YOURgQWTJVDAPSa4AwWuvL1ymJKDCNyAJk36rWWnPxTPg3VPbpB
         5AJFK7pDcT+oHUxCPMuBDxTcv3yGXldBWBBlMqI5SKXfn4WyEoc0riCXxGjqwDoSoe14
         CthJa+jY/EDGYzAtkqFlE7Zd6WxVEBF97KYx9YEMcXoOqb8bAw4qeQAfxR1+W2OnzPVB
         GEMyN4k4FY8WEl1Sdwsb1YbHuFoWDmrfFBjfuLBCKqELNbu3qj8v3R2AO1mXrz3dwf0k
         LKdle3S2UFjoNxA96YjuPZDnjtuNFLcSWmTfrzbBLYmaGU8hDRe99UCChwMt6IpKdL1K
         tyBg==
X-Gm-Message-State: AOJu0YwjP6VKbLhL5+xlJU/JX2rO1L//f2RoUupcj35yx0OLVD5Qtj2Y
	U3A40omND5CiKUTbw/IODQxWTELr1myujmclscnqnf/Y3KgEMnnup0tM0wtyiQ==
X-Gm-Gg: AR+sD11NZIj6NxURGjjci6WBIY8EM0gHjgggp15IrCX8ASA6ilYFwVEr1AcrXWeiW8c
	Q/vBSvTLcGam/da0Qoc6T0a/Q1jgBx/XO1Xs9q9rMoNcACe0AXuRN4K+k9jDQJsQyJzIPi2SuUC
	0HP8G10Ppj5W3kR808mSS1JcRvr1WuGZyG2YYfVZGxcbBwLTI1b8iVFXBWJcpiyRL5aSB+64s3E
	bTxDK8iIPKHLIOmQ0myROwoTGYv4aKCcTvoD0HeWYcz2mxoSgj7gAS2abgw46exqxs8eVn0VZ/r
	rSBElN31nuFK9g/QMa3PMMUUX/gBYyriz21yH0dk5R9MuMGeBglwgP76KxOX3ceae0h3+R5S6Et
	oh53DXkE/asCTatQBYFGfJAw/C0zqj7MHuhg5jbOopR5Ywi1nLwzZE87FNNQCClFZxIQ=
X-Received: by 2002:a17:90b:2d10:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38ec6632b70mr8028647a91.33.1784920113710;
        Fri, 24 Jul 2026 12:08:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f039b1dbfsm1996795a91.1.2026.07.24.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:33 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 18/18] bpf: Generate kfunc argument prototype at add-call time
Date: Fri, 24 Jul 2026 12:08:12 -0700
Message-ID: <20260724190813.1458271-19-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
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
 include/linux/bpf.h          |  36 +++++------
 include/linux/bpf_verifier.h |  18 +++++-
 kernel/bpf/core.c            |   4 +-
 kernel/bpf/syscall.c         |   2 +-
 kernel/bpf/verifier.c        | 112 ++++++++++++++++++++++++++++-------
 5 files changed, 128 insertions(+), 44 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2cbfa033a4eb..ef172143b9c9 100644
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
index e2076667b245..cd88772024a8 100644
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
index e44fc7296d0c..1ca8779ab59a 100644
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
@@ -8352,9 +8387,9 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
-			  const struct bpf_func_proto *fn,
 			  int insn_idx)
 {
+	const struct bpf_func_proto *fn = meta->fn;
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
@@ -8858,7 +8893,7 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
 		if (meta->arg_raw_mem.regno)
@@ -8875,7 +8910,7 @@ static bool check_args_pair_invalid(const struct bpf_func_proto *fn, int arg)
 	bool has_size = fn->arg_size[arg] != 0;
 	bool is_next_size = false;
 
-	if (arg + 1 < ARRAY_SIZE(fn->arg_type))
+	if (arg + 1 < MAX_BPF_FUNC_REG_ARGS)
 		is_next_size = arg_type_is_mem_size(fn->arg_type[arg + 1]);
 
 	if (base_type(fn->arg_type[arg]) != ARG_PTR_TO_MEM)
@@ -8906,7 +8941,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
@@ -8925,7 +8960,7 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
 		if (base_type(arg_type) != ARG_PTR_TO_MEM)
@@ -8941,7 +8976,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
 		if (arg_type_is_release(arg_type)) {
@@ -10332,9 +10367,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -11473,6 +11509,43 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
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
+		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
+		    is_kfunc_arg_ignore(btf, &args[i]) ||
+		    is_kfunc_arg_implicit(meta, i))
+			continue;
+
+		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
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
@@ -12056,16 +12129,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
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
@@ -12082,7 +12145,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		int kf_arg_type;
+		int kf_arg_type = meta->fn->arg_type[i];
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
@@ -12127,9 +12190,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		kf_arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
-		if (kf_arg_type < 0)
-			return kf_arg_type;
 
 		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
 			continue;
@@ -12682,7 +12742,7 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			size = fn->arg_size[arg];
 			goto out;
 		}
-		if (arg + 1 < ARRAY_SIZE(fn->arg_type) &&
+		if (arg + 1 < MAX_BPF_FUNC_REG_ARGS &&
 		    arg_type_is_mem_size(fn->arg_type[arg + 1])) {
 			int size_reg = BPF_REG_1 + arg + 1;
 
@@ -12981,6 +13041,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
+	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
 
@@ -12997,6 +13058,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

