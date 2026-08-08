Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35D2C234E
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149597; cv=none; b=jVmEE6iySot76MnWJrNzr5JGWtbyQWbsf88kvU5u6JBJVyl7j/MoUTl3+qimptgUyrQ9PZMVWEiuABMovzpbe69pbu+kKJ8DZITjWLDneo27Aas7rnkvq/QUScuB/Op32bDp1E72gFyab3+DkPphpxz2WE84XZ+oR5FN/3nUQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149597; c=relaxed/simple;
	bh=CglavoFHJTB4WeORsEcu31Aj+STG4yBTNSY4ZpZkfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwzi7SzsM+ngApYLmyuPobhDjkQ3vQcf7DPKA7hsDezRlSfi47gh9XJo3CB8qzBfRHqvLdqSVCf0kh6PJBXSHPSAQEBKB9rm5/Y/QzN8hN2JGrcyEZkAk6JbnCw/6Z55+zkBCAzVe2BrvmX3be/3Lb/wUtCIrsAikn+XrVI3wnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdROf9wx; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdROf9wx"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-451fd21113cso103022fac.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149594; x=1786754394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S26IOmUg+jLWoUTDckGg3uRmC+b6091BI4sAbJ/XAx4=;
        b=PdROf9wxZ9Xn5AEpmaonaQnOYydSp1QjQI6lxOYt1c/KCwbQwC4l3oOI2WhKnj/W1W
         WdZZqpIc537sJgsdr9SkprMISYKbHWSzC51CtJULiND3ODLfUSCevK4ikObDZVgRxeIU
         Opn1rsunD/yFSWHXR/azNI3ug8K1Rk+IQTrG/ObMo0DbOQfItdAN/K8dayLMTRbHxJfz
         xdMjVSuRa+mH48eVa4sz/7oCSlrbyCvrmlX7viWMq2fFtjlUIXYyrLQq5gq29DSw4v4L
         XmdavxyRJw1VhRdb5Rln0ShHPDf5x5wnenxPN54w+xZ+vOQ0iMXQql70Vx6YfimMkLn+
         d/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149594; x=1786754394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S26IOmUg+jLWoUTDckGg3uRmC+b6091BI4sAbJ/XAx4=;
        b=lYQaMUv32WkKPVDkvVmTPxU7JGzHrTP9ECcwkStLZvdamiZyKXITunoVkw4Jw4suNX
         1L/ZEIiZmR499ZWn82DIM+Vt79uvEieNAnCEqJQGI4s5dT4BZIx/pEedZkr8mV/OCc7f
         aWcXdPGUb/mzim2wjiWKTlgMqKZixYS3xRGQjFsMZceQMyQaZp3gWCB74g7/eBEPPGv+
         Q8pfKsY09aReIT/aG9BblulsBmDHoqNRRnzUeBp+XHbYQl8cHNefRp2gmUN2V7tJARB/
         0B4JViULIHFiVsx9bfOo5k4KICavNzKMVAjlAVh4BPZx8bwPO5JI8cvwYw8UOgffKOHA
         jpsA==
X-Gm-Message-State: AOJu0YxFw8Onhg1PASh/wL7k3+Inau5kY8oilKtctvpVW1jBzxFTonf1
	IxlpYrYbqhTyv9C9xM04uwdkU/i9kYAH0m6B2imJTP4OELfPZ49ffGsbODTn5DfPbx0=
X-Gm-Gg: AR+sD12IMZiF0F4owazHmATBvjQI+S2RkPLGneusSWiianDYZKifQZa0VDQteR8RIJp
	Nl1617Lx4oUPLho1X4OajQ/25c3jhwNXATXN3Mbqhj6t66MlgUZsVONhX/9/4wF6s3j87e2c54T
	ZKoNocjyyyzOVhzDTX/LDtIMhiU7SKYKwrTVkcCPfddV9GgLKIq9O9Be6eOWQgFzCHW4taQ1Moz
	//Mt2krtpK6+SBlK+XSPvwEzdZ/087NtQn4temXcVG4tv6tPmppaWn7E9hEoUWa+G3FZeyNdxCN
	JyqGona0B/AJ/hjhxGMqg4pUboDRT2Rf+NZ5Ux+gMaCj5LA70CmZ2JlYEfh6BiqkIIwd5yxEHp+
	QXp91wKEsRvK8gQbK9EI1mVTJ4POnPBDiJ+27kATAMSxmOgcG9PYG4Or/B5Gal1c8VObAW/Ixj5
	DWkArwuEC+/5r9fahEbkK9WgQ7D8LWyP6cukDwJJEPgn/ZsRi0neHHrhtgy4Co87aTTD/lz4qSb
	GYaKyD0kxTz0PoKQdw82TlS4CovSx88WoqwCo8WSeWgYyB0Cqhva1z/nwbLvn/rEN2bHQ==
X-Received: by 2002:a05:6870:3c8b:b0:451:fbeb:e9a6 with SMTP id 586e51a60fabf-45a15758165mr1669857fac.0.1786149594310;
        Fri, 07 Aug 2026 17:39:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm3169797fac.1.2026.08.07.17.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 05/14] bpf: Support __arena and __arena__nullable on struct_ops arguments
Date: Sat,  8 Aug 2026 02:39:25 +0200
Message-ID: <20260808003938.3486067-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14822; i=memxor@gmail.com; h=from:subject; bh=PNRknwVTiZWps4Z9dcbjc4bn31WTIEdFUvTKUMY4VK4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqrIiUunLh5Bt91Ync+hw/cuZnvv+dcfNWh7HY96+ceHN c9Z0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ/gxn+J/0sXMfEK2q68WN2DOsV4w 8Ml+dNDszkY7HNalKRFzr6juEPR1DhlyyJjye8p4dfOheY8+/T+m3qH8Vm3/00Mzldik2eDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

A struct_ops callback cannot receive an arena pointer directly, so
passing one takes two steps. The pointer arrives as a bare u64 that the
callback casts, and because the two sides address the arena through
different bases it also has to be rebased by hand on the way in.

Add the __arena and __arena__nullable stub argument suffixes to make this
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
NULL. __arena__nullable preserves NULL, tested on the full 64-bit kernel
pointer, and surfaces to the verifier as PTR_TO_ARENA (but not as a
PTR_TO_ARENA | PTR_MAYBE_NULL). The reason is that PTR_TO_ARENA in the
program's type state already encompasses NULL-ness, so it is not
meaningful to force a NULL check for the program.

The composite suffix intentionally ends in __nullable. Classify
__arena__nullable before the generic suffix so scalar arena pointees do
not take the generic nullable BTF pointer path.

This patch adds the generic side. prepare_arg_info() records arena and
nullable argument flags in the struct_ops function model, and
bpf_tramp_arena_base() returns the arena base for a single-program
struct_ops indirect trampoline. Only that trampoline converts: its
program's arena is fixed at generation time. Generic trampolines can mix
programs with different arenas and reject arena context arguments
defensively, which is unreachable today as only struct_ops programs
carry them. Architectures that do not implement the conversion are
gated out at verification time with bpf_jit_supports_arena_args().

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 10 +++++++
 include/linux/bpf.h          |  9 ++++++
 include/linux/bpf_verifier.h | 10 +++++++
 kernel/bpf/bpf_struct_ops.c  | 56 +++++++++++++++++++++++++++---------
 kernel/bpf/btf.c             | 10 +++++--
 kernel/bpf/trampoline.c      | 37 ++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 23 +++++++++++----
 7 files changed, 133 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9c205d8b5fff..1004eb0bec61 100644
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
+pass NULL. With ``__arena__nullable`` a NULL kernel pointer arrives as NULL.
+However, there is no obligation to prove to the verifier that such a pointer is
+non-NULL before use, in-line with existing semantics of arena pointers used in
+a program (or obtained from any other source).
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba1b9d8ac348..b4a10c9878cf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1274,6 +1274,15 @@ struct bpf_tramp_nodes {
 	int nr_nodes;
 };
 
+/*
+ * The arena base against which a struct_ops trampoline converts the
+ * arguments marked with BTF_FMODEL_ARENA_ARG while saving them into the BPF
+ * ctx, ctx[arg] = (u32)(kaddr - kern_vm_start). Zero when the trampoline
+ * converts nothing.
+ */
+u64 bpf_tramp_arena_base(const struct btf_func_model *m,
+			 struct bpf_tramp_nodes *tnodes, u32 flags);
+
 struct bpf_tramp_run_ctx;
 
 /* Different use cases for BPF trampoline:
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a9555d17fd8e..5c8a4d9b8fce 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1302,6 +1302,16 @@ static inline u32 type_flag(u32 type)
 	return type & ~BPF_BASE_TYPE_MASK;
 }
 
+static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
+		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
+			return true;
+	return false;
+}
+
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
 	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4e7a48c02be5..d7c3030bc63b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -147,6 +147,8 @@ void bpf_struct_ops_image_free(void *image)
 
 #define MAYBE_NULL_SUFFIX "__nullable"
 #define REFCOUNTED_SUFFIX "__ref"
+#define ARENA_SUFFIX "__arena"
+#define ARENA_MAYBE_NULL_SUFFIX "__arena__nullable"
 
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
@@ -172,10 +174,12 @@ static int prepare_arg_info(struct btf *btf,
 			    const char *st_ops_name,
 			    const char *member_name,
 			    const struct btf_type *func_proto, void *stub_func_addr,
+			    struct btf_func_model *model,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
-	bool is_nullable = false, is_refcounted = false;
+	bool is_nullable = false, is_refcounted = false, is_arena = false;
+	bool is_arena_nullable = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
@@ -225,27 +229,39 @@ static int prepare_arg_info(struct btf *btf,
 	/* Prepare info for every nullable argument */
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
-		/* Skip arguments that is not suffixed with
-		 * "__nullable or __ref".
+		bool ptr_to_arena, ptr_to_struct;
+
+		/*
+		 * Skip arguments that are not suffixed with "__arena__nullable",
+		 * "__arena", "__nullable", or "__ref".
 		 */
-		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
-						     MAYBE_NULL_SUFFIX);
+		is_arena_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
+							   ARENA_MAYBE_NULL_SUFFIX);
+		is_arena = btf_param_match_suffix(btf, &stub_args[arg_no], ARENA_SUFFIX);
+		is_nullable = !is_arena_nullable &&
+			      btf_param_match_suffix(btf, &stub_args[arg_no], MAYBE_NULL_SUFFIX);
 		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
 						       REFCOUNTED_SUFFIX);
 
-		if (is_nullable)
+		if (is_arena_nullable)
+			suffix = ARENA_MAYBE_NULL_SUFFIX;
+		else if (is_arena)
+			suffix = ARENA_SUFFIX;
+		else if (is_nullable)
 			suffix = MAYBE_NULL_SUFFIX;
 		else if (is_refcounted)
 			suffix = REFCOUNTED_SUFFIX;
 		else
 			continue;
 
-		/* Should be a pointer to struct */
-		pointed_type = btf_type_resolve_ptr(btf,
-						    args[arg_no].type,
-						    &arg_btf_id);
-		if (!pointed_type ||
-		    !btf_type_is_struct(pointed_type)) {
+		/*
+		 * Should be a pointer to struct, or any pointer for __arena or
+		 * __arena__nullable.
+		 */
+		pointed_type = btf_type_resolve_ptr(btf, args[arg_no].type, &arg_btf_id);
+		ptr_to_arena = pointed_type && (is_arena || is_arena_nullable);
+		ptr_to_struct = pointed_type && btf_type_is_struct(pointed_type);
+		if (!ptr_to_arena && !ptr_to_struct) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
 				stub_fname, suffix);
 			goto err_out;
@@ -268,7 +284,18 @@ static int prepare_arg_info(struct btf *btf,
 		info->btf_id = arg_btf_id;
 		info->btf = btf;
 		info->offset = offset;
-		if (is_nullable) {
+		if (is_arena || is_arena_nullable) {
+			/*
+			 * Both types get PTR_TO_ARENA. In verifier state,
+			 * PTR_TO_ARENA encompasses potential NULL values, but
+			 * we do not force the program to check it, or maintain
+			 * precision around it, since it has no safety implication.
+			 */
+			info->reg_type = PTR_TO_ARENA;
+			model->arg_flags[arg_no] |= BTF_FMODEL_ARENA_ARG;
+			if (is_arena_nullable)
+				model->arg_flags[arg_no] |= BTF_FMODEL_NULLABLE_ARG;
+		} else if (is_nullable) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 		} else if (is_refcounted) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
@@ -460,6 +487,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
 		err = prepare_arg_info(btf, st_ops->name, mname,
 				       func_proto, stub_func_addr,
+				       &st_ops->func_models[i],
 				       arg_info + i);
 		if (err)
 			goto errout;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff6148ae8e8..6606187ed4f4 100644
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
index ed7999ad6c66..e07af35ed040 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -529,6 +529,36 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	return tnodes;
 }
 
+/*
+ * The arena base against which save_args() converts the arguments marked
+ * with BTF_FMODEL_ARENA_ARG. Only the struct_ops indirect trampoline
+ * converts: it dispatches to a single prog whose arena is known at
+ * generation time. Return 0 when there is nothing to convert.
+ */
+u64 bpf_tramp_arena_base(const struct btf_func_model *m,
+			 struct bpf_tramp_nodes *tnodes, u32 flags)
+{
+	const struct bpf_prog *prog;
+	int i;
+
+	if (!(flags & BPF_TRAMP_F_INDIRECT) ||
+	    tnodes[BPF_TRAMP_FENTRY].nr_nodes != 1)
+		return 0;
+
+	for (i = 0; i < m->nr_args; i++)
+		if (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG)
+			break;
+	if (i == m->nr_args)
+		return 0;
+
+	/* Verification rejects an arena argument without an arena. */
+	prog = tnodes[BPF_TRAMP_FENTRY].nodes[0]->link->prog;
+	if (WARN_ON_ONCE(!prog->aux->arena))
+		return 0;
+
+	return bpf_arena_get_kern_vm_start(prog->aux->arena);
+}
+
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
@@ -920,6 +950,13 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(node->link->prog);
+	/*
+	 * Arena ctx args are converted only by struct_ops indirect
+	 * trampolines. They must never be attached to a generic trampoline.
+	 */
+	if (WARN_ON_ONCE(bpf_prog_has_arena_ctx_arg(node->link->prog)))
+		return -ENOTSUPP;
+
 	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
 		 * cannot overwrite extension prog either.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 099ee2df217b..74592272b124 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18875,6 +18875,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
+	const struct bpf_struct_ops_arg_info *arg_info;
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
@@ -18953,10 +18954,23 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
 
@@ -18977,8 +18991,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
-					  st_ops_desc->arg_info[member_idx].cnt);
+	return bpf_prog_ctx_arg_info_init(prog, arg_info->info, arg_info->cnt);
 }
 #define SECURITY_PREFIX "security_"
 
-- 
2.53.0-Meta

