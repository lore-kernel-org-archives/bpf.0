Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07220427FA6
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963878; cv=none; b=ZLNelSPGNwA3dLj2s+MCRylTj7qn1Bf7Z+3Is2L5MD+23s/ZwKNz6xfMH/T4A8L6Lle/Ps5O5l9dSKmo1mugExzmYr3ly1b0j3SeUKysTirdEEPhpfwVPxcSTxycqq6mDPPPkPWIMjlQWrWc9D1i5x+FAw5Ax5FOTzvidt/99bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963878; c=relaxed/simple;
	bh=cXvqygc3EnmHewu1PoLROt5m0VbjRETvrA+zGid7msA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUr2+a+awhcCrsGdwJ1JkoH7Ld7C8boFKJyBGAS+2EWeMpBc9A1z4gKmALMXUJtwcr/77cVHjkp0GKHJ/KKc6Y1TWXskCie5nbOtJzqevu6FWqrFI5JX0xq4QznBeETjIAm0q/aYMxIyYsjN/weo0hhW/wtlonngms9UnyqNrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdQMk2Bx; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdQMk2Bx"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so264694f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963874; x=1786568674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnFvYJyaqCCYOv2w1y+jlPU6CQrB/fRCCk7JEFWHQD0=;
        b=kdQMk2BxethlQjMqh6PXsJLv4jGaXCNcqiDehIiSzTIQ7bSuvOvqhE5VcdUDPlyIBL
         2SpIx5bqwJTWKCFCEJvFfStVviltos40WJ7h4UBAT4bTYNgrs3JGYTwwD5STDuumHsJl
         o7nVgo1FfFRRxZ9TG2BlIVp8sHRUeJ1j85TyRKh2/3SMqFgGJl6Q/T8lj6nshiW3ZJGC
         McgTjcEim7Q8jxtbIYg15/2Teqo8cOzSJ4U3vJoDpdiZOOQvG6TDWvoveDUR2lPzwaRb
         oBRSFY7nOYkuBzViAfAvc9I4ybPERcSLgaKg7HZKHuKP/SEa6MDddhDBupI/zXZ1pWDw
         uHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963874; x=1786568674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnFvYJyaqCCYOv2w1y+jlPU6CQrB/fRCCk7JEFWHQD0=;
        b=IjKrHugwkDrT2ZUF9U+DCDBYMYYOgCsYMJ++IP17D+5cv6Ukfd/u7WeQZhVo5lMIdW
         RztKk7vQxBdZpMHitMB2KVpdIIO7ZmZlyzWFAtNx/TEuCaVHyc6Hc0/jUNs5PWhREBEX
         lPSsiV5Iip/7kC0ar0gciyDJTA0JqCWkcBXsQaME2wzBED5MaJJU3ysaApClcvLRN9Y8
         SyBdyi+ep6WBrqtlA6Ep/G55Isxs/alvhL/iIQQZhQ53sETbDk6FPGkEaja3z1Uqljrx
         KU2teRSKLsPyM2cd53FY9RWDM+rjwshBycVGXrcKwupcHhiFm9wtzaaGBNL7+2oes4iC
         uw3A==
X-Gm-Message-State: AOJu0Ywz1DEXwXgxccOrvFbKoKXT6f1GB7bqWro/c5H+KKCTCBvdFzdL
	K+jTH65ohUxm5QQikRbpoC2AX9ZTCIdY+lZ7CWqgSw64kxowG89rMFpqnVjgSWW9
X-Gm-Gg: AR+sD12oAvvH0TiLv48RUKgx2NrL8zpJRvkwOJD3bpxLX6HK8iPgMPtLVvbp25vW2Bg
	/UmIECeaz5S7KGJBLbVzYvCiNcU/MB2IaHivVFMm/HKySinB8YqzhRwG9PLKHCnikFtYdO1Uhq6
	cTPlMPBfsgAJ0Jg6dMDAPl7KIBqK0YvQvCQNWcwvu/6gKbJfwHsDCgJH2WM9+QlphXzWkQLgZvg
	haFWaWG+LHacwFmKjZfo0eczNY0Ke0NlDPXsTW9kkxKt9hUsBaUI7/a572TJu6fRuzm2r4uQc5N
	sOYpNqxlcPii+djIN2zxdqKgVk+7ZlP8DMqXnowM0AxKvqdb3h6xWOFYmJrVbMPiqxmtlLOg7Rn
	2+YCOGCd8tNZweyX/IUyPL3BUR0j8313b3OzNcfnAFApbTdBm/7bLxPjUar3riSXUSCpOFYlqUO
	pFEJGep/6vBummI7Otr0si9jtLwGXmbmgAwk7ICQT2qCdESRfHGrTn7fnsXd3SEdz8thLJLWVtJ
	DBu1Wrzq9qUGtdVTDSZPU3WxDFUMXXcA4TgCgf8GcYvgXPuTisuNvbOsQjmOFVzJYAY8M8wI9oo
	erM4u+mW6b+snuDzsLUcgPW1o/o=
X-Received: by 2002:adf:fcd2:0:b0:47f:80c3:92a0 with SMTP id ffacd0b85a97d-47fec62d449mr13942464f8f.29.1785963874320;
        Wed, 05 Aug 2026 14:04:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b431dsm252749f8f.13.2026.08.05.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/13] bpf: Support __arena and __arena__nullable on struct_ops arguments
Date: Wed,  5 Aug 2026 23:04:16 +0200
Message-ID: <20260805210427.3218326-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15106; i=memxor@gmail.com; h=from:subject; bh=f5dPQmpdvpaF1aSL8oXyfaHtDbYfS+7jro6eJsRIeKY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40RRuq+aNN05e/3TmVRyzOwv/xYU/jC49Pe7x8uyW1 ycCWX8d7ShlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBE2iQZ/hd3MscIJu8U2nnt P7MwV33Znp32XNG1tzh5fNUOrGeZasnwv9Jg7yu/BT01l/5Ueh6MaGBYL9PN3rjS6HHDhIS1ya+ XcwAA
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

This patch adds the generic side. bpf_tramp_collect_arena_args() derives
the conversion map from the prog's ctx_arg_info, keyed by the flattened
ctx byte offset since preceding 16-byte arguments occupy two slots.
prepare_arg_info() also records arena and nullable argument flags in the
struct_ops function model for arch trampolines. Only the struct_ops
indirect trampoline converts: it dispatches to a single prog whose arena
is fixed at generation time. Generic trampolines can mix progs with
different arenas and reject arena ctx args defensively, which is
unreachable today as only struct_ops progs carry them. Arch trampolines
that do not implement the conversion are gated out at verification time
with bpf_jit_supports_arena_args().

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 10 +++++++
 include/linux/bpf.h          | 19 +++++++++++++
 kernel/bpf/bpf_struct_ops.c  | 53 +++++++++++++++++++++++++----------
 kernel/bpf/btf.c             | 10 +++++--
 kernel/bpf/trampoline.c      | 54 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 23 +++++++++++----
 6 files changed, 147 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index cd9b90d072cf..c044659b7689 100644
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
index f47556b56a48..0d1773af8373 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1289,6 +1289,20 @@ struct bpf_tramp_nodes {
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
@@ -1690,6 +1704,11 @@ struct bpf_ctx_arg_aux {
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
index 4e7a48c02be5..ebfb7fff453e 100644
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
@@ -225,27 +229,35 @@ static int prepare_arg_info(struct btf *btf,
 	/* Prepare info for every nullable argument */
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
-		/* Skip arguments that is not suffixed with
-		 * "__nullable or __ref".
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
+		if (!pointed_type || (!is_arena && !is_arena_nullable && !btf_type_is_struct(pointed_type))) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
 				stub_fname, suffix);
 			goto err_out;
@@ -268,7 +280,19 @@ static int prepare_arg_info(struct btf *btf,
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
+			info->arena_nullable = is_arena_nullable;
+			model->arg_flags[arg_no] |= BTF_FMODEL_ARENA_ARG;
+			if (is_arena_nullable)
+				model->arg_flags[arg_no] |= BTF_FMODEL_NULLABLE_ARG;
+		} else if (is_nullable) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 		} else if (is_refcounted) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
@@ -460,6 +484,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
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
index ed7999ad6c66..67d0ba8a05cd 100644
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
@@ -920,6 +967,13 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
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
index 2b7f6f6bbe76..6897b08dd010 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18872,6 +18872,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
+	const struct bpf_struct_ops_arg_info *arg_info;
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
@@ -18950,10 +18951,23 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
 
@@ -18974,8 +18988,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
-					  st_ops_desc->arg_info[member_idx].cnt);
+	return bpf_prog_ctx_arg_info_init(prog, arg_info->info, arg_info->cnt);
 }
 #define SECURITY_PREFIX "security_"
 
-- 
2.53.0

