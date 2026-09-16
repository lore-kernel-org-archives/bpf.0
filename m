Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7324A1DE6
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574917; cv=none; b=F3aVQWkWGTnc9RUXNRyVrgQrQSPCePnuMZ/T+DgFK4YmHZWGDjSTw5QCWYMtRs47geAEffGgIoyuJvp1fs3zmA4+SnfNzk+Q0gV/mm+MgrVc5PCqH43A4YOWKUE/oC855QS4l/ybqEem9Q3USsb1t81ABWA27TYYHTa4hg22qcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574917; c=relaxed/simple;
	bh=DiePERBkeRwttMKnxlnyUGF7ax3lacun/Cfn17XJ4RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P935okjbd6uC+qu6soH84WK/slU2HuO8nCBPjWA9ptXMzBHAOyFvHHTRzFMkptnJ2cAYyszOcJ/J6d5gkIhLnkAfgMPXPaY9g7qC2lay8NMwQATav9FH//5EQVP7htokjq6BvH241oYwmyJOIK4D1SjWYoqlZQBdDfhjgxlTb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpavNdcH; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpavNdcH"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so12161115e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574910; x=1790179710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ie/ZsBJH1Qaa3/hs/+OFi2Um1awR9HnQzqRgHmLirGo=;
        b=kpavNdcHRa/W9SKxfoxG9OzDHKqQX4sZBaClQnhUbvaxT+odk9fOkejn1nc3wDnaly
         3kXjy3uDEs+3F9ALruBxuTr6gVYPCrqkY0RW91SR+VAgsCyT5n6G23/y/KTmf2qc+3I7
         Xwl3EoGCWYW10iWxybgWe+QxRrRI3R5M3QdAwgR6OKMsvW1yJPTxliQpRYh/2oBh0xPz
         hxBksNMCx893zSGfLr5JM0FZmfoi17qGW9ie8ARqk0FjiTVUX/K3v4aLEVzhtVP5bbNQ
         fYTjtGOMxx+G9dzpAQr6V3FfYmmyGAhBtQbq2NPLl6PyKCW/fNyx/AiwWoZs6XY7o8ft
         H//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574910; x=1790179710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ie/ZsBJH1Qaa3/hs/+OFi2Um1awR9HnQzqRgHmLirGo=;
        b=wsrnvpIUeQnzP+PVRtfFVGiVRERN0zw7hlzRWGewznDsqNmcVVltJdaW10vvI/6Gdu
         LT5ePChCXCESY5DMHUqlxshTdfYTC9L8yXHQZ0NrYZVfiBQr9WX/XDlGwDdhTEIWuRPh
         FuKFFUBfXYDLtEl7639Lpm+Rs1xQAsCWPrvc/7Ue+c0eynXZCdYQYBHfXcMkdo6pOnQp
         RqQqkIR9jRN1BzGavPONHZjxgjke0ysVyixfn1ZPmRsuoaQ+Jg0Rbg6K8gS/4n9wDG5A
         hqMaWhjvMCN5j5oGVxNAEGgi+uaq6gKc/i5URgz5CQnNAzhSC4HXaqXbuUXL3sRkybDV
         OLPQ==
X-Gm-Message-State: AFuF++lmEmzOFYT6kgjneLCs9Shzl/bTzqx6Ny28l9RGvfy1kCwCsViU
	2uOLBTY3vMcKUvSdDzfP72E4H5HjHDsaPwYSVZ3g1EjUWt9/GO5Ckb9eiEop/xqU
X-Gm-Gg: AYBFou3I+uifaEJADXlrILJgmcfoW82svXQMOCrsuB7s7AUkJyThBTTebm27yRJ9fja
	2HhLDnNqnbwTTpEi7qhfw1AprBB26BD6M80aP+Qt+N1fri8des0M6F/MvHqfdQ0wp6P7BuuSPQT
	e/RPjME9Bkw6sjXqANoOKbR6EiFpQkpCxi2EYDSRS6+uACViQBshHTs1dpVP8IWlSQ7SILOShe+
	E0jhDluNwgFW5ZUdG8MmJxLowvCLBYYeBILy0WakBbu5E4hR7IlXSBEBdI5/g4ykDFdibW2tc0J
	3DlC2fC1bWueoSkY2fSL8JpINA+HG+FOBA4692urNlvyuS64HwnSHvACauKV8dcEVslt4fy/DWy
	nejOnR/9bucgzoZDGdfCCwRLgGhwXAe1Ou9p5sPVnx2kF6zn1fvNwMy1KNafqZY/UyDWZCxaVoo
	LC/bZRFUw0+mxhvMOBMdH/6NVZtQwHbMQqqi1ap7VebZ0oTaAlWmU97C82bSRSNWk2oClDGxPhg
	8sXptEc4rhi/exxoEi0jFYr6dzsXXHf4H9ESuGyGPkNIHhzAHlYIA9+INNCatmCSgZBN2aRYsjJ
	6QK4AtAiGmDJ3kptzwJqw/EgMNTN1d/4Z80kqg==
X-Received: by 2002:a05:600c:630a:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49eb7325340mr37480695e9.17.1789574910135;
        Wed, 16 Sep 2026 09:08:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm2364355e9.0.2026.09.16.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:08:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] bpf: Support multiple __uninit kfunc output arguments
Date: Wed, 16 Sep 2026 18:08:17 +0200
Message-ID: <20260916160821.3157543-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916160821.3157543-1-memxor@gmail.com>
References: <20260916160821.3157543-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7068; i=memxor@gmail.com; h=from:subject; bh=DiePERBkeRwttMKnxlnyUGF7ax3lacun/Cfn17XJ4RQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvVvhfPFx16ty1rr9Jj37byt/oudRINC5mWtj49qGu5d JLAumCvjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkiBAjw/FH05gKEvfrBO/1 SOKcN/OMkssBs90Rm2xeMu1uzT5r4c7I8NL+D/uSi8UR5Z/K8+v4tv/5y8Gy1vhVv8AhriMVm26 8ZAUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A single output descriptor cannot retain the initialization ranges of two
__uninit memory arguments. Track raw-mode eligibility and the definite
output size separately for each argument slot, so a variable-size output
also leaves independent constant-size outputs intact.

Normalize helper register numbers and kfunc argument numbers through one
slot conversion helper. After checking every argument, initialize each
recorded output. Skip empty entries before looking up register state: an
unused slot need not have an allocated stack-argument record. Helpers keep
their existing single-output restriction.

Use the resolved BTF parameter when looking up __uninit for stack liveness.
A preceding by-value parameter can consume multiple ABI slots, so its slot
number cannot index the BTF parameter array. Keep this argument-slot handling
with the extension rather than the minimal single-output regression fix.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 +++---
 kernel/bpf/verifier.c        | 60 ++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3c1b06a3daf3..9ddbb20ec1e9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1547,13 +1547,13 @@ struct ref_obj_desc {
 };
 
 /*
- * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
- * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access()
- * after all arguments have been checked.
+ * Memory arguments a call fills in, indexed by argument slot. The verifier allows the
+ * stack to be uninitialized if the range is a known constant. Stack slots are marked as
+ * STACK_MISC by check_mem_access() after all arguments have been checked.
  */
 struct arg_raw_mem_desc {
-	u8 regno; /* Register number, or one-based kfunc argument slot. */
-	int size;
+	u16 mask;
+	int size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0433a5183682..644ada706c62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -302,6 +302,12 @@ static int arg_idx_from_argno(argno_t a)
 	return arg_from_argno(a) - 1;
 }
 
+/* Normalize helper register numbers and kfunc argument numbers to ABI slots. */
+static u32 arg_slot_from_argno(argno_t a)
+{
+	return abs(a.argno) - 1;
+}
+
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -6981,7 +6987,9 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == abs(argno.argno);
+	u32 arg_slot = arg_slot_from_argno(argno);
+	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		       (meta->arg_raw_mem.mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7023,7 +7031,7 @@ static int check_stack_range_initialized(
 	}
 
 	if (raw_mode) {
-		meta->arg_raw_mem.size = access_size;
+		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
 	}
 
@@ -7215,9 +7223,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.regno == abs(mem_argno.argno))
-		meta->arg_raw_mem.regno = 0;
+	if (!tnum_is_const(size_reg->var_off))
+		meta->arg_raw_mem.mask &= ~BIT(arg_slot_from_argno(mem_argno));
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -9035,7 +9042,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		 */
 		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
 		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
-			meta->arg_raw_mem.regno = 0;
+			meta->arg_raw_mem.mask &= ~BIT(slot);
 
 		err = check_helper_mem_access(env, reg, argno, meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
@@ -9187,13 +9194,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		enum bpf_access_type access_type;
 		bool known_memory;
 
-		if (meta->btf && (arg_type & MEM_UNINIT)) {
-			if (meta->arg_raw_mem.regno) {
-				verbose(env, "multiple __uninit buffers are not supported\n");
-				return -EINVAL;
-			}
-			meta->arg_raw_mem.regno = slot + 1;
-		}
+		if (meta->btf && (arg_type & MEM_UNINIT))
+			meta->arg_raw_mem.mask |= BIT(slot);
 
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
@@ -9569,24 +9571,28 @@ static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta
 			  int insn_idx)
 {
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_reg_state *reg;
-	u32 slot = meta->arg_raw_mem.regno - 1;
+	u32 slot;
 	int i, err;
 
-	if (!meta->arg_raw_mem.size)
-		return 0;
-	reg = get_func_arg_reg(caller, cur_regs(env), slot);
-
 	/*
 	 * Validate every argument before initializing outputs: an input argument
 	 * may alias an output buffer. Use the normal stack-write checks to discard
 	 * stale spills and preserve the rules for special stack objects.
 	 */
-	for (i = 0; i < meta->arg_raw_mem.size; i++) {
-		err = check_mem_access(env, insn_idx, reg, argno_from_arg(slot + 1), i, BPF_B,
-				       BPF_WRITE, -1, false, false);
-		if (err)
-			return err;
+	for (slot = 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
+		struct bpf_reg_state *reg;
+		argno_t argno = argno_from_arg(slot + 1);
+
+		if (!meta->arg_raw_mem.size[slot])
+			continue;
+		reg = get_func_arg_reg(caller, cur_regs(env), slot);
+
+		for (i = 0; i < meta->arg_raw_mem.size[slot]; i++) {
+			err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
+					       BPF_WRITE, -1, false, false);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -9893,9 +9899,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
-		if (meta->arg_raw_mem.regno)
+		if (meta->arg_raw_mem.mask)
 			return false;
-		meta->arg_raw_mem.regno = i + 1;
+		meta->arg_raw_mem.mask = BIT(i);
 	}
 
 	return true;
@@ -13894,7 +13900,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	if (is_kfunc_arg_uninit(btf, &args[i]))
 		return -size;
 	return size;
 }
-- 
2.53.0

