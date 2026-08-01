Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF63AFCE6
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570427; cv=none; b=pfGuDv77XMVgKXT2I4/bmlgvjFLhJmp04Ys25OZhN921UztH7XZFjC6rVknSZI7enTNZvofSkgh1YEWRPJ8yPiPXVS7kH0nm1L8Q1ywVnhnMJLx0A7YwHJOaCKiigFH0FIrR9abyySYNisUVtH48YywFcLlzHWgZovRTEhfT5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570427; c=relaxed/simple;
	bh=0wHtW1O4/Rn60VJSFipVhyQZL+kY8huJUY9nhgNzPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0WLTN70PW2IJNuedNWLGGKR5uUtce8s0C4Ket+eFPM3WRar2Y0SMl4R3GA4TtIG+yJlgkElDj4RxgHe7B+ttDiFH/VtFbGKbsTnLQQUy/dKwy9rTRVi/JfIplmLLRAXIBw3rsxWvcMm9Lp1LaCLsULqGar0yh56vjUtEbCTifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJf3FajD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJf3FajD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84847482584so1150752b3a.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570425; x=1786175225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCfMiGZIUhe5llE2FijoP+MmekVj597fitZJKYNucEo=;
        b=fJf3FajDx1pmCQztBEaU+qAnGbQ5Ag2utAXLwETpbRCmRATPQSX/+zopvfWhRguwwb
         4d00zq7UofV0HMg81OQf9NRPy43tBm3hHPWYBDsWfm8uiX5N1IRuaKkJ8XQZZHRxTSLl
         Hc2tfzsMZoGEN9vy9xAh6acfTKU6x7dcCAbCElWzZ/fotYkDpU1h37T1h06GgqaGONW3
         xrVEelqy3c07guC4w7u/2mHRrcACbo0TA4KeTKbhq1mwprT6rH+oK7YYVvNii7n4lE0z
         AnLSgH0v5Lh+6NSioa2un5Yfo/SnSmkAj07p2pnmUzoRFBXnFWKcPSdljgic5sIPxmlF
         jkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570425; x=1786175225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCfMiGZIUhe5llE2FijoP+MmekVj597fitZJKYNucEo=;
        b=cDk8MIVc+CniV+PQgUkFfnDN67jl5HUVBlMqTKilJipz3CviB5HA0SLymG7lgq9s7m
         wzHbRQhqdVNMMoHL94BmwStwAzYVJvs0DKIjNFGxlBpFgPfPGw83Sbi0CqKTqZAVNaTO
         6JN3tmu4uYULG9TTQtA9a9e0kPuU3d1ofkMLsZNKvu9aG0WzEKlG6qPnO9uY71MZXbHN
         FOC7/qZY5duApaXpEoyfqO6D0ysrG+rTUWpc3OcGSRQBAHDMvfdUzUZpedE8SpypH9mB
         MRnsa//mmchg+dX1V3frYHKK+n3lbQTA2HBPuaGAWZ4t8thW5b8G8RgTI1vWNiPRGHlD
         y+iw==
X-Gm-Message-State: AOJu0Yw/1Au4IRoRlfW0fBfC3m+6rEMYVpqnHQYTf2ZGT1uvZtKZYMbp
	xB2npDYYQlcIgi2IzK0bZsMuh//8N2K6tjmjIZpExJdnqQwmgjbAH8nDHHfRHw==
X-Gm-Gg: AR+sD13qzq1CafvFYtz9+bumWUL98X0cM/auNiinmaaByRXuVfoVXXo7kFtnqK+gdL0
	fQag0cc9zFXj8rKZ+Ngni6vEO7zSlDs6btx92dXSsBlWcs2XNT7wPV9aNr9uAZhhSWkxBvAD+L7
	zXHWhrvHIa77/wWVTk0Oqk9RkiMk7q9MyWVYspnuSndenLRtLIrvq59e+2pZUje/ZoIIc2OCmA+
	xG3YZRRLuH/x07KE6ShVel0kt/yT6YsUP+YU/hmYIniJQG050VtJMwlxJQ65D5NWUV/HwtdOxd3
	qlB6w2z9lIam/24LhpgI8xam0GZ1DhbVCngIV2xJPZJcQFv5pKOATjndn1ub+q34J4aqMdxvNTQ
	OhgosdFfJ6lg/iNCipvADvy2rEQ/ZfRN7FbfauoOEMgY95Bn/M3Cxm5w9R8NPlqY5Es0AcPHGD0
	xHhXQedRkVSH4DZmhBjCQUjQzSd+o4eDnUaAkYcBl9UQTt6rejGScyVgCVJUWLgw==
X-Received: by 2002:a05:6a00:430d:b0:848:2ef5:50dc with SMTP id d2e1a72fcca58-84ee49a3159mr1977801b3a.36.1785570424604;
        Sat, 01 Aug 2026 00:47:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe869c7sm1398333b3a.26.2026.08.01.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:47:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 18/18] bpf: Generate kfunc argument prototype at add-call time
Date: Sat,  1 Aug 2026 00:46:33 -0700
Message-ID: <20260801074633.1595644-19-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfunc argument checking re-derives each argument's kfunc_ptr_arg_type
from BTF on every verification of a call in check_kfunc_args(). Now that
get_kfunc_arg_type() is a function of the kfunc's BTF alone, it no
longer inspects register state. The classification can be computed once
when the call is added and cached. This is a step toward describing
kfuncs with a bpf_func_proto and sharing the helper argument-checking
path.

Generate the classification at bpf_add_kfunc_call() time:

- Extend struct bpf_func_proto to be able to describe a kfunc: widen
  arg_type[] and the arg_btf_id[]/arg_size[] union from 5 to
  MAX_BPF_FUNC_ARGS, since a kfunc may take up to 12 arguments (5 in
  registers, 7 on the stack).

- Embed a bpf_func_proto in struct bpf_kfunc_desc, populated by
  gen_kfunc_arg_proto() which runs get_kfunc_arg_type() for each
  argument and stores the result in proto.arg_type[]. Grow the
  descriptor table's descs[] as a flexible array to not waste memory.

- check_kfunc_args() reads the cached classification from meta->fn

The KF_ARG_PTR_TO_CTX classification depends on the resolved program type,
and for BPF_PROG_TYPE_EXT that is the target program's type, which
resolve_prog_type() reads from prog->aux->saved_dst_prog_type. That field
is normally recorded later during verification in check_attach_btf_id(),
after bpf_add_kfunc_call() has run.

Record saved_dst_prog_type and saved_dst_attach_type from dst_prog at
program load time in bpf_prog_load() so the resolved type is available
at add-call time without reordering check_attach_btf_id(). This keeps
e.g. an freplace of an XDP program calling bpf_xdp_metadata_rx_hash()
classifying its struct xdp_md * argument as context.

The classification result is unchanged; it is only computed earlier and
cached.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h          | 36 ++++++-------
 include/linux/bpf_verifier.h |  9 ++--
 kernel/bpf/syscall.c         |  4 ++
 kernel/bpf/verifier.c        | 98 +++++++++++++++++++++++++++++-------
 4 files changed, 109 insertions(+), 38 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be53655d1362..356884587ae1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -960,6 +960,21 @@ enum bpf_return_type {
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
@@ -984,7 +999,7 @@ struct bpf_func_proto {
 			enum bpf_arg_type arg4_type;
 			enum bpf_arg_type arg5_type;
 		};
-		enum bpf_arg_type arg_type[5];
+		enum bpf_arg_type arg_type[MAX_BPF_FUNC_ARGS];
 	};
 	union {
 		struct {
@@ -994,7 +1009,7 @@ struct bpf_func_proto {
 			u32 *arg4_btf_id;
 			u32 *arg5_btf_id;
 		};
-		u32 *arg_btf_id[5];
+		u32 *arg_btf_id[MAX_BPF_FUNC_ARGS];
 		struct {
 			size_t arg1_size;
 			size_t arg2_size;
@@ -1002,7 +1017,7 @@ struct bpf_func_proto {
 			size_t arg4_size;
 			size_t arg5_size;
 		};
-		size_t arg_size[5];
+		size_t arg_size[MAX_BPF_FUNC_ARGS];
 	};
 	int *ret_btf_id; /* return value btf_id */
 	bool (*allowed)(const struct bpf_prog *prog);
@@ -1192,21 +1207,6 @@ struct bpf_prog_offload {
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
index b54c1a5c9b11..a2a40caca0a0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1302,7 +1302,6 @@ static inline u32 type_flag(u32 type)
 	return type & ~BPF_BASE_TYPE_MASK;
 }
 
-/* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
 	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
@@ -1489,6 +1488,7 @@ struct bpf_call_arg_meta {
 	/* Common */
 	struct btf *btf;
 	u32 func_id;
+	const struct bpf_func_proto *fn;
 	u8 release_regno;
 	u32 ret_btf_id;
 	u32 subprogno;
@@ -1617,6 +1617,7 @@ enum bpf_reg_arg_type {
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
+	struct bpf_func_proto proto;
 	u32 func_id;
 	s32 imm;
 	u16 offset;
@@ -1624,13 +1625,15 @@ struct bpf_kfunc_desc {
 };
 
 struct bpf_kfunc_desc_tab {
+	u32 nr_descs;
 	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
 	 * verification. JITs do lookups by bpf_insn, where func_id may not be
 	 * available, therefore at the end of verification do_misc_fixups()
 	 * sorts this by imm and offset.
+	 *
+	 * Grown one entry at a time by bpf_add_kfunc_call().
 	 */
-	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
-	u32 nr_descs;
+	struct bpf_kfunc_desc descs[];
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 67704ddd29cb..a9e373fc9a6a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3043,6 +3043,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
+	if (dst_prog) {
+		prog->aux->saved_dst_prog_type = dst_prog->type;
+		prog->aux->saved_dst_attach_type = dst_prog->expected_attach_type;
+	}
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9e32dbd9358..590a5d478def 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2721,8 +2721,12 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			       struct bpf_func_proto *proto);
+
 int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 {
+	struct bpf_call_arg_meta meta;
 	struct bpf_kfunc_btf_tab *btf_tab;
 	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
@@ -2808,11 +2812,30 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	if (err)
 		return err;
 
-	desc = &tab->descs[tab->nr_descs++];
+	memset(&meta, 0, sizeof(meta));
+	meta.btf = kfunc.btf;
+	meta.func_id = kfunc.id;
+	meta.func_proto = kfunc.proto;
+	meta.func_name = kfunc.name;
+	meta.kfunc_flags = kfunc.flags ? *kfunc.flags : 0;
+
+	tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), GFP_KERNEL_ACCOUNT);
+	if (!tab)
+		return -ENOMEM;
+	prog_aux->kfunc_tab = tab;
+
+	desc = &tab->descs[tab->nr_descs];
+	memset(desc, 0, sizeof(*desc));
+
+	err = gen_kfunc_arg_proto(env, &meta, &desc->proto);
+	if (err)
+		return err;
+
 	desc->func_id = func_id;
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
+	tab->nr_descs++;
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
 	return 0;
@@ -8332,9 +8355,9 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
-			  const struct bpf_func_proto *fn,
 			  int insn_idx)
 {
+	const struct bpf_func_proto *fn = meta->fn;
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
@@ -8847,6 +8870,8 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		if (fn->arg_type[i] == ARG_DONTCARE)
+			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
 		if (meta->arg_raw_mem.regno)
@@ -8895,6 +8920,8 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		if (fn->arg_type[i] == ARG_DONTCARE)
+			break;
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
@@ -8916,6 +8943,8 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
+		if (arg_type == ARG_DONTCARE)
+			break;
 		if (base_type(arg_type) != ARG_PTR_TO_MEM)
 			continue;
 		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
@@ -8932,6 +8961,8 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
+		if (arg_type == ARG_DONTCARE)
+			break;
 		if (arg_type_is_release(arg_type)) {
 			if (meta->release_regno)
 				return false;
@@ -10321,9 +10352,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -11463,6 +11495,43 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
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
@@ -12046,16 +12115,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
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
@@ -12072,7 +12131,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
-		int kf_arg_type;
+		int kf_arg_type = meta->fn->arg_type[i];
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
@@ -12117,9 +12176,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		kf_arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
-		if (kf_arg_type < 0)
-			return kf_arg_type;
 
 		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
 			continue;
@@ -12986,6 +13042,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
+	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
 
@@ -13002,6 +13059,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
+	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	if (!desc) {
+		verifier_bug(env, "kfunc descriptor not found for func_id %u", insn->imm);
+		return -EFAULT;
+	}
+	meta.fn = &desc->proto;
+
 	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
 
 	if (!insn->off &&
-- 
2.52.0

