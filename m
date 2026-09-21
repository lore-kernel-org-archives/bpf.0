Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF06310651
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958339; cv=none; b=CTZi5PgiyV86wgUZ8Dw+rZ6gqh7lXwqu/OQlfdjA5s0reGHynco29yBbkMbWtvEE/nKJ1tmbmRD1UEygtFHRIqwOxbM53e6pAlfuuMYxRPI4ol6kq/qBLo6il/6gB+mW7a2+1xum0iTWdFq41LrA2yEn8ElTR+H92TYdxMFMuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958339; c=relaxed/simple;
	bh=aDPCCIE/SlgX0XQ1jc4wds6GzTx3ngUSP1PASxJw/xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRtxKl9hWcwcMz17Y2gdhS7vYrKwE7LCpTGXoEahY+K4q3W0mFCFsxbzwhRqlBgmO3NK0vgEH1jcsLccScWgcoGTd8zOldZa4889CNjgBqpo24lvNUZoAFYUrnL2cW7a1jRdfdnOwugba3ygQjEVr7bDm8h9kcKO+JW9L2qzPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgLx6taf; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgLx6taf"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso9245155e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958336; x=1790563136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4G3czP2Aehx4RicD0m0ymfa3AlUehd80sORvDxi0seE=;
        b=KgLx6tafy12tAmgEqktozXNo2SnnVCSswzk1b5ljZsTN+FOtyLQJIy2y1CMlVETFtw
         ad88IeK6idj5D8DNfZeLbuO8uF1Z3a/lDiLU2muU/q/8pkc47jAvSAF1oyE02C1M/e7j
         i75d1s5mrdq/7XC1vrP7x4YUWOHUqMxNFBkTe7nmFVFlU8ieQXR5izyRE5Kc1kczbDON
         WP+fs3H81kvwEfISXrHidqbfo/GmJ5u3E6TMckwe7KWALLn7O75qbdt8Lh5qVEfqJwA3
         REuQkzYMGUu9E6dHlggG8Fwb20el2CxYOp+qrURmFG4wI5dbVzXYkVxrj06KWLi1PM3v
         HA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958336; x=1790563136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4G3czP2Aehx4RicD0m0ymfa3AlUehd80sORvDxi0seE=;
        b=B+15CArH2ojUc/57HVOoE/j4CRCdWpO5AGGade3u/NOA7jS6L46QQXJav0RNO8bwue
         8Na5n5ADvWM1Rj8oUrMtbdSpyM4aVkKY/zB+i3dgL924kMb8ZBcjLjc06aEiKMCrPW4E
         16IuItRBtz+KrIDVRkXpgnYz/NBBHqyUIs0HkBOMUi22PM+47ONAqY4z7aEFOAdpJBrE
         Wr0KKy1xe7DYo4OdIQ99jKNL+c6rHYUft/nlEJs4whgUhUZRw0IQGnCV8DXQpcQPLN88
         za2mPi+nFJhaLIKysh5CStHo/1dCZWZqcq6D70n87LZWYwha1Kty+WZ734VOPzGx3Leh
         SF5g==
X-Gm-Message-State: AFuF++lBZN5DMrDfs4wpzW2irIbcFbSEJe73Fq/d6X4NjVRde51f/YhE
	S2ECN7ITIsoV2z4Q4KArFHyRnHj3IvaQ/CPTg96NsWImNWLIoj9ACWow8eQrLE9V
X-Gm-Gg: AYBFou25CuAkkNskA8ePUI4MXYER7pnESEVQ0Da2A7fRMUJVRSVIIGh2OisUvQ5k1L6
	Vq12oIIIkrLzwCbCFKbo0b+ctwFp0QeqAFH4X4aNYvhlTUmMwSlQfFhHD1q8upQUq05i9G+pkry
	OFfumppqu8P+P256CbIzQhd2FBW7htXRyeDEj0wwRrwnV5MqM6hL1LgxAQlbrImlOXBIkx0oGA2
	ZveJR9xYERC+o2XRnlND8jDy+8BimXS+e2iycwhOBd7g/jpuRHfhl+nGEzJzTunO4TYoZPqKL+P
	9tKdeDOIG2RStfIvwe5VVfI+WqTsl3yXusDzzaM0YMX++UTezsbYU+4GW/RTCSf4gDv/yBmK/aj
	YCaHAVN4y8B0I9D63AT+0LHDG9MJrPXeAsizFAwenj7QbhKpHeupS2MPJO9GtdGkdNAfFWWEW7i
	Eqdd1GrRYAJ61weTxgdy39f8KUKVJNikZsCsAFAxDws9D2KgpOl8IaZHsO/DRp2AgFborKpX6w5
	CHA7OQ3CQ5zGSE6pHz+7nlPtnbDOCPdX0tqN07c20tbbtO1q+XnMbi9NAWRGatFYvRCm4k+wcyn
	LVa/cDVfy1dsMJpmvdPefQ0x/y0UB3O8LS0L5A==
X-Received: by 2002:a05:6000:2213:b0:487:8f:a392 with SMTP id ffacd0b85a97d-4871e395feamr12226079f8f.37.1789958335710;
        Sun, 20 Sep 2026 19:38:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244229d5sm19682967f8f.2.2026.09.20.19.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 06/11] bpf: Support multiple __uninit kfunc output arguments
Date: Mon, 21 Sep 2026 04:38:30 +0200
Message-ID: <20260921023843.411943-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7016; i=memxor@gmail.com; h=from:subject; bh=aDPCCIE/SlgX0XQ1jc4wds6GzTx3ngUSP1PASxJw/xQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9M3p0y4FfP/5xPWqPKteYo1ScoHUOYbuzsrPKZFH7 afEclR2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCI7pRn+8DGk7Vwm/NRfN1yX aSVLpcaCs497DzmVZvQzfN24ccP2p4wM3fo/drMev/1arGipyc3qymNuT+uKJSL7b511lTk65+J 5HgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A single output descriptor cannot retain the initialization ranges of two
__uninit memory arguments. Track raw-mode eligibility and the definite
output size separately for each ABI slot, so a variable-size output leaves
independent constant-size outputs intact.

Use the shared argument-checking path to record outputs for both helpers
and kfuncs. With per-slot tracking, neither needs the single-output
prototype restriction. Initialize every recorded output after checking all
arguments, skipping empty slots before looking up their register state.

Use the resolved BTF parameter when looking up __uninit for stack liveness.
A preceding by-value parameter can consume multiple ABI slots, so its slot
number cannot index the BTF parameter array.

Suggested-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 +++---
 kernel/bpf/verifier.c        | 68 ++++++++++++------------------------
 2 files changed, 28 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6ff1c227d298..9ddbb20ec1e9 100644
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
-	u8 argno; /* One-based ABI argument slot; zero means no output. */
-	int size;
+	u16 mask;
+	int size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f4b88e402ff5..0c94f1214cc3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6994,7 +6994,9 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.argno == arg_slot_from_argno(argno) + 1;
+	u32 arg_slot = arg_slot_from_argno(argno);
+	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+		       (meta->arg_raw_mem.mask & BIT(arg_slot));
 
 	access_size = abs(access_size);
 
@@ -7034,7 +7036,7 @@ static int check_stack_range_initialized(
 	}
 
 	if (raw_mode) {
-		meta->arg_raw_mem.size = access_size;
+		meta->arg_raw_mem.size[arg_slot] = access_size;
 		return 0;
 	}
 
@@ -7226,9 +7228,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * checked range. Disable raw mode for this output and apply the ordinary
 	 * stack initialization checks, including their privilege exceptions.
 	 */
-	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.argno == arg_slot_from_argno(mem_argno) + 1)
-		meta->arg_raw_mem.argno = 0;
+	if (!tnum_is_const(size_reg->var_off))
+		meta->arg_raw_mem.mask &= ~BIT(arg_slot_from_argno(mem_argno));
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8946,7 +8947,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		return err;
 
 	if (arg_type_is_raw_mem(arg_type))
-		meta->arg_raw_mem.argno = slot + 1;
+		meta->arg_raw_mem.mask |= BIT(slot);
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
@@ -9573,24 +9574,28 @@ static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta
 			  int insn_idx)
 {
 	struct bpf_func_state *caller = cur_func(env);
-	struct bpf_reg_state *reg;
-	u32 slot = meta->arg_raw_mem.argno - 1;
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
@@ -9888,28 +9893,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
-{
-	bool seen = false;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		enum bpf_arg_type type = fn->arg_type[i];
-
-		if (type == ARG_UNUSED)
-			break;
-		/* Struct pointers may resolve to generic memory during argument checking. */
-		if (!arg_type_is_raw_mem(type) &&
-		    !(base_type(type) == ARG_PTR_TO_BTF_ID && (type & MEM_UNINIT)))
-			continue;
-		if (seen)
-			return false;
-		seen = true;
-	}
-
-	return true;
-}
-
 static bool check_args_pair_invalid(const struct bpf_func_proto *fn, int arg)
 {
 	bool is_fixed = fn->arg_type[arg] & MEM_FIXED_SIZE;
@@ -10036,7 +10019,6 @@ static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_
 			    struct bpf_call_arg_meta *meta)
 {
 	return check_arg_prog_aux(env, fn) &&
-	       check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -13129,10 +13111,6 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
-	if (!check_raw_mode_ok(proto)) {
-		verbose(env, "multiple __uninit buffers are not supported\n");
-		return -EINVAL;
-	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -13929,7 +13907,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
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

