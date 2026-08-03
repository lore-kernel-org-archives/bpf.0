Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D113DDAA
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761482; cv=none; b=poU2yGxNWnRwrermJwaX1xVVmDwMYG20HkoleMCim+fqo8VwK7M9+w3YOlyElv3YgNg9LZXLVH6LJqdNERLxc2jbSuVbGaz1dILzh49V9t/hraFgncSzDLY94ebXtHHsaKool19H0VW4StKeOUlXLBBTq1T50KY3z/5LYMGOAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761482; c=relaxed/simple;
	bh=kDLcrZWj4JvL8Ww/g29xITHCPinsWsKn51+LVvPKCeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBjyrv1VYzJiITRNl4W6yeb68DWZ25oIH9bBMcvedzSQacrOigAXC5RNzrpHuonok8NZzLfAy9tA2HWWbrYuY0B8OXja11aszAwU1RaiwALuFT2+joOCxKF10jy0asS8mUgsKCOdAaIB5HJPJpBSPktieSv5uYwIBkGfzfqcrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByXYdiBq; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByXYdiBq"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso1149964f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761479; x=1786366279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1D4jXGlAMOV+k2U7rw3ixQ+v9QGhHchI5jnX1Cf+B4=;
        b=ByXYdiBqmVvaoDwAnsZ3u3neuanPuXLcDF+v4a7Mg8eX5WfMkG4bL85vhlpKRWOVhD
         ORDKXGZeHelyW0sp9VdVL4+XjAleuhMCDiMiMRUhhqEzrcjaxomkAAvFvth5nbOoEMG6
         W0M9Aik444eSLWzh7BfPs+QEkot3QVesaQ/wxrckebEBxlUPbAWjcXpAo6TAXTE3NwUR
         0Ky1M8jaNRXtCgLQf3+lWWLvYSx26frkNv8PXvUrAIhXrj4ZvvyZLyLEzeOm3cCH0b+y
         Lb54piEJ32QhPLn1cAXB4PUQo8WY/S04ObuTIyYUvsZ2fGcz2wMbNkbpvtjcx34JwHZY
         XvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761479; x=1786366279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1D4jXGlAMOV+k2U7rw3ixQ+v9QGhHchI5jnX1Cf+B4=;
        b=c8LCT8fLPSaAN4WkYKENIQt5oBiBzxy5LUn84Sz1dRl80L8l9DVxgrCCJ1EU7ECxDh
         BY/9zhebxsNpgxudFKVUerymG4RJB7YSd1qq7vHZaHWy2gi+XkAFmL5cUS5clTIlen5e
         opDXid4zLV4WEFsMMmkQ9zgCFnEIsjMZreciZrAWD12ACEitmLhrW6n55VvY74mtZZ6s
         ozghMKj+MqaIfE6Exj+1A76ZYN50OXD9knVwABK1xVsZLDWRk3GAftZUpa9U+CmbYzXy
         2CdusbWlZrmC86nb+62aPIJhj9vmXy1jxPTkjfV1vULuZqNTg2AlIJPY2RWdfzXUfrES
         sZSA==
X-Gm-Message-State: AOJu0YwxwSMgRsd2G6Vx8M/p1Fac/oDpveUxqheKby+E6345tzDt496J
	d/J3kidTRFhw3dJhDaU9XpDHJI5PjIsD3nrqsM+sc9kUjPO5/710Xpvw9WF86aAQ
X-Gm-Gg: AR+sD10cP13sVM9m/YhYrJusbkGil46qhY2Bn+hD69JVMBZ0Vt5oJc4uE6brSsQrHHZ
	gabEsagJIMQXCod97Se4A6I3ChjLCb9DBO9a2bR8H8Nn40b9V506/hg5o+VH0ICtz9NNTxu0unj
	FMsWGNqLa2FSRNcWbRVHa0CYklpiUXPnCnPSb7qLCoNmrYe4AMFg7H3NQAAGTthvEnVo4M/OInC
	Um7CMVs7HpKGB/keJS/MQ4oq2FLGLfbJihzNLfgPnVQbs6jNj3UM8/pTXH15GleeZnNe7cn9zQD
	5PKJ9XkzKCtCIyNKrRfXDwnn+ecc4trww1di9di/wvOlrhybFa7J/+gmnin/WQfcXaxbks5USeN
	PaykcWJgbPu3dFqV52kz3hRlYkYfZ0ujJQt+D+Xay4Y8fceLGkd2YtwfaKJs5WeASNAKgdz9Gao
	MRXhOsg0OnpNf7hdbdD7qF+uc7BEfYhLEbJDiwFMtActbfDH25oJWFNvgyTybHE+NQBIpA0LgOJ
	vVXCnnjZgblkK9Tq2PvaC+k7F5GCDtXqi1ZKMFlx7s39OIrFezy+Up0DcG/CI0knDEFXsSPzegj
	biRpNfHk8lteuL2qrDpb/VHTGlo=
X-Received: by 2002:a05:6000:46c4:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-47fd72ab2f2mr20467943f8f.8.1785761478496;
        Mon, 03 Aug 2026 05:51:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm29985928f8f.12.2026.08.03.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/9] bpf: Support __arena and __arena_nullable on struct_ops arguments
Date: Mon,  3 Aug 2026 14:51:03 +0200
Message-ID: <20260803125115.2264733-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14283; i=memxor@gmail.com; h=from:subject; bh=zohIdrO1lmN26EDHHLHaux42zv2h41rD+sh0k0KOcPk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb9Ox3zfmfy+cY+OwZc5qZUPXIr6uPR5LGiXmOh9+c vDo+qbKjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwkg5Xhn3HL0+qDJ5hPch80 Sbr/T95KqSyzKNvfxz4xdPmiQ5Mq1jIyXNlj7btKnT/UjK3/jGZj4VqFRWwFMXXCOapC1zbN7r7 EBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

A struct_ops callback cannot receive an arena pointer directly, so
passing one takes two steps. The pointer arrives as a bare u64 that the
callback casts, and because the two sides address the arena through
different bases it also has to be rebased by hand on the way in.

Add the __arena and __arena_nullable stub argument suffixes to make this
convenient. The callback declares the parameter as an arena pointer,
receives it as a PTR_TO_ARENA register, and dereferences it directly,
while the kernel caller just passes the natural kernel arena address
(kaddr). The trampoline converts the value while saving the arguments
into the BPF ctx, ctx[slot] = (u32)(kaddr - kern_vm_start), so the
program never sees a kernel address and nothing rewrites the ctx after
the fact. The converted value keeps the upper 32 bits clear as the JITs
require of arena pointer registers and behaves like any cast_kern'ed
arena pointer, so cast_user recovers the full user-visible address.

__arena converts unconditionally and the kernel caller must not pass
NULL. __arena_nullable preserves NULL, tested on the full 64-bit kernel
pointer, and surfaces to the verifier as PTR_TO_ARENA (but not as a
PTR_TO_ARENA | PTR_MAYBE_NULL). The reason is that PTR_TO_ARENA in
program's type state already encompasses NULL-ness, so it is not
meaningful to force a NULL check for the program.

This patch adds the generic side. bpf_tramp_collect_arena_args() derives
the conversion map from the prog's ctx_arg_info, keyed by the flattened
ctx byte offset since preceding 16-byte arguments occupy two slots. Only
the struct_ops indirect trampoline converts: it dispatches to a single
prog whose arena is fixed at generation time. Generic trampolines can
mix progs with different arenas and reject arena ctx args defensively,
which is unreachable today as only struct_ops progs carry them. Arch
trampolines that do not implement the conversion are gated out at
verification time with bpf_jit_supports_arena_args().

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 10 ++++++
 include/linux/bpf.h          | 19 +++++++++++
 kernel/bpf/bpf_struct_ops.c  | 34 ++++++++++++++-----
 kernel/bpf/btf.c             | 10 ++++--
 kernel/bpf/trampoline.c      | 64 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 23 ++++++++++---
 6 files changed, 143 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 8e84484636c5..48cf746f9ff9 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -305,6 +305,16 @@ arena argument support (currently x86-64); verification fails otherwise. The
 program can pass any value without compromising the kernel. A value that does
 not point into the arena is a program bug.
 
+The suffixes have the same meaning on the arguments of struct_ops stub
+functions, with the conversion running in the opposite direction. The
+kernel caller passes the kernel arena address and the trampoline converts
+it while saving the arguments, so the callback receives an arena pointer
+it can dereference directly. With ``__arena`` the kernel caller must not
+pass NULL. With ``__arena_nullable`` a NULL kernel pointer arrives as NULL.
+However, there is no obligation to prove to the verifier that such a pointer is
+non-NULL before use, in-line with existing semantics of arena pointers used in
+a program (or obtained from any other source).
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6da8a6be930c..2f606c325680 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1292,6 +1292,20 @@ struct bpf_tramp_nodes {
 	int nr_nodes;
 };
 
+/*
+ * Which 8-byte ctx slots of a struct_ops trampoline hold arena kernel
+ * pointers that save_args() converts to the arena pointer form,
+ * ctx[slot] = (u32)(kaddr - kern_vm_start).
+ */
+struct bpf_tramp_arena_args {
+	u32 slots;
+	u32 nullable_slots;	/* subset of @slots where NULL is preserved */
+	u64 kern_vm_start;
+};
+
+bool bpf_tramp_collect_arena_args(struct bpf_tramp_nodes *tnodes, u32 flags,
+				  struct bpf_tramp_arena_args *aargs);
+
 struct bpf_tramp_run_ctx;
 
 /* Different use cases for BPF trampoline:
@@ -1693,6 +1707,11 @@ struct bpf_ctx_arg_aux {
 	u32 btf_id;
 	u32 ref_id;
 	bool refcounted;
+	/*
+	 * We don't encode NULL-ness in the type for the program, but still need
+	 * to distinguish it for the purposes of telling JITs what sequence to emit.
+	 */
+	bool arena_nullable;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4e7a48c02be5..827a6216a620 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -147,6 +147,8 @@ void bpf_struct_ops_image_free(void *image)
 
 #define MAYBE_NULL_SUFFIX "__nullable"
 #define REFCOUNTED_SUFFIX "__ref"
+#define ARENA_SUFFIX "__arena"
+#define ARENA_MAYBE_NULL_SUFFIX "__arena_nullable"
 
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
@@ -159,7 +161,7 @@ void bpf_struct_ops_image_free(void *image)
  * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
  * the information that used by the verifier to check the arguments of the
  * BPF struct_ops program assigned to the member. Here, we only care about
- * the arguments that are marked as __nullable.
+ * the arguments that are marked as __nullable, __ref or __arena.
  *
  * The array of struct bpf_ctx_arg_aux is eventually assigned to
  * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
@@ -175,7 +177,8 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
-	bool is_nullable = false, is_refcounted = false;
+	bool is_nullable = false, is_refcounted = false, is_arena = false;
+	bool is_arena_nullable = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
@@ -226,26 +229,30 @@ static int prepare_arg_info(struct btf *btf,
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
 		/* Skip arguments that is not suffixed with
-		 * "__nullable or __ref".
+		 * "__nullable", "__ref", "__arena" or "__arena_nullable".
 		 */
 		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
 						     MAYBE_NULL_SUFFIX);
 		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
 						       REFCOUNTED_SUFFIX);
+		is_arena_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
+							   ARENA_MAYBE_NULL_SUFFIX);
+		is_arena = btf_param_match_suffix(btf, &stub_args[arg_no], ARENA_SUFFIX);
 
 		if (is_nullable)
 			suffix = MAYBE_NULL_SUFFIX;
 		else if (is_refcounted)
 			suffix = REFCOUNTED_SUFFIX;
+		else if (is_arena_nullable)
+			suffix = ARENA_MAYBE_NULL_SUFFIX;
+		else if (is_arena)
+			suffix = ARENA_SUFFIX;
 		else
 			continue;
 
-		/* Should be a pointer to struct */
-		pointed_type = btf_type_resolve_ptr(btf,
-						    args[arg_no].type,
-						    &arg_btf_id);
-		if (!pointed_type ||
-		    !btf_type_is_struct(pointed_type)) {
+		/* Should be a pointer to struct, or any pointer for __arena/__arena_nullable */
+		pointed_type = btf_type_resolve_ptr(btf, args[arg_no].type, &arg_btf_id);
+		if (!pointed_type || (!is_arena && !is_arena_nullable && !btf_type_is_struct(pointed_type))) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
 				stub_fname, suffix);
 			goto err_out;
@@ -273,6 +280,15 @@ static int prepare_arg_info(struct btf *btf,
 		} else if (is_refcounted) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
 			info->refcounted = true;
+		} else if (is_arena || is_arena_nullable) {
+			/*
+			 * Both types get PTR_TO_ARENA. In verifier state,
+			 * PTR_TO_ARENA encompasses potential NULL values, but
+			 * we do not force the program to check it, or maintain
+			 * precision around it, since it has no safety implication.
+			 */
+			info->reg_type = PTR_TO_ARENA;
+			info->arena_nullable = is_arena_nullable;
 		}
 
 		info++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bf86df91a70b..e31f56f401eb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6963,15 +6963,19 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		return false;
 	}
 
-	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
+	/*
+	 * Check for PTR_TO_RDONLY_BUF_OR_NULL, PTR_TO_RDWR_BUF_OR_NULL or
+	 * PTR_TO_ARENA (both nullable and non-nullable cases).
+	 */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
 		u32 type, flag;
 
 		type = base_type(ctx_arg_info->reg_type);
 		flag = type_flag(ctx_arg_info->reg_type);
-		if (ctx_arg_info->offset == off && type == PTR_TO_BUF &&
-		    (flag & PTR_MAYBE_NULL)) {
+		if (ctx_arg_info->offset == off &&
+		    (type == PTR_TO_ARENA ||
+		     (type == PTR_TO_BUF && (flag & PTR_MAYBE_NULL)))) {
 			info->reg_type = ctx_arg_info->reg_type;
 			return true;
 		}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ed7999ad6c66..d2d7a2904345 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -529,6 +529,53 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	return tnodes;
 }
 
+static bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
+		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
+			return true;
+	return false;
+}
+
+/*
+ * Collect which ctx slots of a struct_ops trampoline hold arena kernel
+ * pointers that save_args() must convert to the arena pointer form. Only
+ * the struct_ops indirect trampoline converts: it dispatches to a single
+ * prog whose arena is known at generation time. Return false when there
+ * is nothing to convert.
+ */
+bool bpf_tramp_collect_arena_args(struct bpf_tramp_nodes *tnodes, u32 flags,
+				  struct bpf_tramp_arena_args *aargs)
+{
+	const struct bpf_prog *prog;
+	int i;
+
+	memset(aargs, 0, sizeof(*aargs));
+
+	if (!(flags & BPF_TRAMP_F_INDIRECT) ||
+	    tnodes[BPF_TRAMP_FENTRY].nr_nodes != 1)
+		return false;
+
+	prog = tnodes[BPF_TRAMP_FENTRY].nodes[0]->link->prog;
+	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
+		const struct bpf_ctx_arg_aux *info = &prog->aux->ctx_arg_info[i];
+
+		if (base_type(info->reg_type) != PTR_TO_ARENA)
+			continue;
+		aargs->slots |= BIT(info->offset / 8);
+		if (info->arena_nullable)
+			aargs->nullable_slots |= BIT(info->offset / 8);
+	}
+	if (!aargs->slots)
+		return false;
+	if (WARN_ON_ONCE(!prog->aux->arena))
+		return false;
+	aargs->kern_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
+	return true;
+}
+
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
@@ -685,6 +732,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	u32 orig_flags = tr->flags;
 	bool ip_arg = false;
 	int err, total, size;
+	int kind, i;
 
 	tnodes = bpf_trampoline_get_progs(tr, &total, &ip_arg);
 	if (IS_ERR(tnodes))
@@ -695,6 +743,22 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
+	/*
+	 * Arena ctx args are converted only by the struct_ops indirect
+	 * trampoline, which dispatches to a single known prog. Generic
+	 * trampolines can mix progs with different arenas, so no conversion
+	 * is possible here. Not reachable today: only struct_ops progs get
+	 * arena ctx args and they never ride generic trampolines.
+	 */
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+		for (i = 0; i < tnodes[kind].nr_nodes; i++) {
+			if (bpf_prog_has_arena_ctx_arg(tnodes[kind].nodes[i]->link->prog)) {
+				err = -ENOTSUPP;
+				goto out;
+			}
+		}
+	}
+
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c50237f49f1..c9129330dede 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18845,6 +18845,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
+	const struct bpf_struct_ops_arg_info *arg_info;
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
@@ -18923,10 +18924,23 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
-	for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
-		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
+	arg_info = &st_ops_desc->arg_info[member_idx];
+	for (i = 0; i < arg_info->cnt; i++) {
+		const struct bpf_ctx_arg_aux *info = &arg_info->info[i];
+
+		if (info->refcounted)
 			has_refcounted_arg = true;
-			break;
+		if (base_type(info->reg_type) == PTR_TO_ARENA) {
+			if (!bpf_jit_supports_arena_args()) {
+				verbose(env, "JIT does not support arena arguments\n");
+				return -ENOTSUPP;
+			}
+			if (!prog->aux->arena) {
+				verbose(env,
+					"arena argument of %s requires a program with an associated arena\n",
+					mname);
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -18947,8 +18961,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
-					  st_ops_desc->arg_info[member_idx].cnt);
+	return bpf_prog_ctx_arg_info_init(prog, arg_info->info, arg_info->cnt);
 }
 #define SECURITY_PREFIX "security_"
 
-- 
2.53.0

