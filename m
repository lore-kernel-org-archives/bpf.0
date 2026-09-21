Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAA310651
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958336; cv=none; b=AkwR9ZYR316cmNN2MQinZMA/QymP6SrcPfeC3LuhJkD/yxT/zj354KnDv8fhGjg2WdKYLSpIGLZFLW0qUORoqQ3avwe74j6wLEXwtuHiQWam+EIHaDRZ9XbmKAda8LwM+Vpj2MkdKDRb4i+IaxHX7fB1fHykOBhb1kJdA2lowQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958336; c=relaxed/simple;
	bh=Kg0s1wZKEup61DABDIaHETPaRyjLyokSY+LT7iicn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzU24KEU4TFyCbt7j6ao7GQMUqxCV73fclMW5BSQ+rNrGbYzS+7lx/JLy3MYmztyFO2nRANolY4sMtf/t4l/LuKcSePe/hyARcH++gWCYrujfvZPalr39Px1D3Dndp5hOOFR+2VyWR9on0mB7UHlj7WI/blCGa68+MvVK6WyUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGd40flF; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGd40flF"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso10181205e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958332; x=1790563132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuiZ0bjYrqZ+n8WU1V/RgB2hm9jYHfwa8J5ZsgunpiE=;
        b=aGd40flF1Lko6qLM4flEQ8o3h0QyNTg/MBpqHlx9RXMP1REpGHwUOOKc0XL8Zb/O35
         v1z0iV9Ep/WukZMlkg8vbqq0IOMgG3pmqfqkcudxU4MCRwK5NMHQrTFSNQm4pNWq3cbl
         rubhEFnES+9Ubny93b7FWcStW7H59WZuSIX1o7nh18c9fXlhVOoSeq/t8/KS/AJToYb4
         nmeBI7F/Hgll3kq41QGJ2XTohH2TIlTqb1T+0CHx/WgfckTBXZTvgbjafr+LQTLTROrf
         sqAkHJmeIu7VZXhb3XoeRGjXEkWZKSHYrr3swv0DcCcXfPimRtTDrTzbzayvt28TZedk
         Fhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958332; x=1790563132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuiZ0bjYrqZ+n8WU1V/RgB2hm9jYHfwa8J5ZsgunpiE=;
        b=oZM3vGGz3Ywm9mmyQ8JuPjgxbwpkIvWSLrZamyGjezIvfLM1jXsxWz0Aj1e2ylFOTU
         EeR8oW7eE21WYLHZvYCGfPHVs6O/6Ocjt6dqzog0PPnrVoFU6xbaokmLKx4lLHUlqnk7
         ceIudlwoLB9fxT13jM1JEPZwDHsAZEL5fuBlTNe4HgtnVWhxOONem4xQUYmB+DhvDEPy
         qIfMuk5Dd2J297VVWugPwNy4jSWNpbrnB6RxM7pR6uVbeSur3KFKjqfhPIPkBT3Swsen
         YlP4YIvZv3a3IFT9aU13RRJdghj5qhmVSde9D5GXbmUgn6T6MH9fymbI6MjJZfIucz+g
         m99A==
X-Gm-Message-State: AFuF++mRVQAUabt/wu+gbcSLsOeZNV8iNRTpHoKJDWUsgpMWsPfPsguX
	y80KFCd27RzTKCx1kWLWRiI+p+yl/QJalyswlbP1NysZ+jNe0GanSxCKrWjBPsgR
X-Gm-Gg: AYBFou13VX3BZ/bzrBG/PJkuTibDinKMnFKpopYJkJmd0kVi8YA50jTR3xCumCQ9zYl
	fuhww77+1RYzpTYIzLBnnMySgU+s3KOjNqvs76oxhkhshDcb2nhAh8xNK3GhQQQCMn410+xmjx3
	mO0JZaCGszHdGDhKdK/YN48qa18Veqr97bzDplDqlXhVYkljnimcL4j2EukdzlkcKxzXUA1eDCp
	r4vaLre6C1MMnQW+hRO+pTnQga9JnCtXwVuaelNjvHPPp/O7lFi5U7RE+e+guMes0chn2sZ39ka
	keOCgSIGZxMIQTjW7ycf8KJkBXQpe3nlAm9jzKL503koHYpYR78iR5QebJPf6b0fwwvi3MOTNAm
	nXfaTqhMWnsqg+y7UcuM2KH/m2tSfZRyhuArQ3XdhjCcbolCoTljszQM+4LO2wRqMCFGGAWfRnV
	kri/fawjw771bUm6pATYjjmUdV2JtjrthrlYc//xVmCr12nc1dhqz4npe6JG8XmPP1Bwvz6pPEc
	C7KEUVveHP7pzxriGmHFoc/FP1Kp9VS4gFyOytWW2anjFtIqvHXXb3eEPr54ZkhDNyxCTBrFbw/
	u8p8FqX8qKzbBuSKmksFy3ywKJtDIjPeQEOy5Q==
X-Received: by 2002:a05:600c:3b8c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fc572f58fmr162549285e9.17.1789958332117;
        Sun, 20 Sep 2026 19:38:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd066d5dsm175370105e9.4.2026.09.20.19.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/11] bpf: Fix generic __uninit kfunc output buffers
Date: Mon, 21 Sep 2026 04:38:28 +0200
Message-ID: <20260921023843.411943-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10136; i=memxor@gmail.com; h=from:subject; bh=Kg0s1wZKEup61DABDIaHETPaRyjLyokSY+LT7iicn4s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9M2/bfoEgjo+/v2nY790uuM6tz8cl7n8dCW+NSq/X uHt/820o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5/4eRYYlwsN+Jy4Grwj6d ZNy6lu1HO7+55GfGYLHVG5yPmauZP2ZkWHm083iA0N8JlVcFUpcfuH9u6ZL38VemVivVHmkLmOr zlRUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack liveness treats __uninit kfunc arguments as writes. Even with
write-only access checks, ordinary clobber handling leaves poisoned stack
bytes poisoned after the call, so the output cannot be read.

Reuse the helper output descriptor for generic kfunc buffers. Record the
output after resolving its memory type, and initialize its stack bytes
only after all arguments have been checked. This prevents an output from
making an aliased, uninitialized input appear valid.

Track the output by its ABI argument slot, since a kfunc pointer may be
passed on the stack or follow a multi-slot by-value argument. Keep the
single-output restriction in prototype validation; multiple-output
tracking is a separate extension.

Document that output buffers must be fully initialized on every return
path, including error returns and padding.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 26 ++++++++----
 include/linux/bpf_verifier.h |  7 ++--
 kernel/bpf/verifier.c        | 80 ++++++++++++++++++++++++++----------
 3 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3f300118a623..f393c3c3d3b4 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -164,19 +164,31 @@ suffix should be used.
 2.3.3 __uninit Annotation
 -------------------------
 
-This annotation is used to indicate that the argument will be treated as
-uninitialized.
+Use ``__uninit`` on a pointer parameter for an output that the kfunc
+initializes without reading its incoming contents.
 
-An example is given below::
+For generic memory buffers, the kfunc must initialize every byte in the
+declared range on every return path, including error returns and struct
+padding. The range is determined by the pointed-to type or the associated
+``__sz`` or ``__szk`` size argument.
+
+The annotation does not change the accepted pointer types. A stack-backed
+struct passed as a generic memory buffer must still be scalar-only.
+
+A stack buffer with a verifier-known constant offset and size may be
+uninitialized before the call and is considered initialized afterwards.
+For variable offsets or sizes, the usual stack-initialization and
+variable-offset restrictions still apply.
+
+For dynptr parameters, ``__uninit`` indicates that the kfunc constructs a
+dynptr in the supplied storage. For example::
 
-        __bpf_kfunc int bpf_dynptr_from_skb(..., struct bpf_dynptr_kern *ptr__uninit)
+        __bpf_kfunc int bpf_dynptr_from_skb(..., struct bpf_dynptr *ptr__uninit)
         {
         ...
         }
 
-Here, the dynptr will be treated as an uninitialized dynptr. Without this
-annotation, the verifier will reject the program if the dynptr passed in is
-not initialized.
+Without this annotation, a dynptr argument must already be initialized.
 
 2.3.4 __nullable Annotation
 ---------------------------
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cf85141ea167..6ff1c227d298 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1548,10 +1548,11 @@ struct ref_obj_desc {
 
 /*
  * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
- * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access().
+ * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access()
+ * after all arguments have been checked.
  */
 struct arg_raw_mem_desc {
-	u8 regno;
+	u8 argno; /* One-based ABI argument slot; zero means no output. */
 	int size;
 };
 
@@ -1579,6 +1580,7 @@ struct bpf_call_arg_meta {
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
 	struct ret_mem_desc ret_mem;
+	struct arg_raw_mem_desc arg_raw_mem;
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
@@ -1617,7 +1619,6 @@ struct bpf_call_arg_meta {
 	s64 const_map_key;
 	struct btf *ret_btf;
 	struct btf_field *kptr_field;
-	struct arg_raw_mem_desc arg_raw_mem;
 };
 
 int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de40785d6a7b..f4b88e402ff5 100644
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
@@ -6988,7 +6994,7 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
+	bool raw_mode = meta && meta->arg_raw_mem.argno == arg_slot_from_argno(argno) + 1;
 
 	access_size = abs(access_size);
 
@@ -7017,11 +7023,9 @@ static int check_stack_range_initialized(
 				reg_arg_name(env, argno), tn_buf);
 			return -EACCES;
 		}
-		/* Only initialized buffer on stack is allowed to be accessed
-		 * with variable offset. With uninitialized buffer it's hard to
-		 * guarantee that whole memory is marked as initialized on
-		 * helper return since specific bounds are unknown what may
-		 * cause uninitialized stack leaking.
+		/*
+		 * The call may touch any byte in the possible range, but does not
+		 * definitely initialize all of it. Fall back to ordinary stack checks.
 		 */
 		raw_mode = false;
 
@@ -7223,8 +7227,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * stack initialization checks, including their privilege exceptions.
 	 */
 	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.regno == reg_from_argno(mem_argno))
-		meta->arg_raw_mem.regno = 0;
+	    meta->arg_raw_mem.argno == arg_slot_from_argno(mem_argno) + 1)
+		meta->arg_raw_mem.argno = 0;
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8941,8 +8945,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
-	if (!meta->btf && arg_type_is_raw_mem(arg_type))
-		meta->arg_raw_mem.regno = slot + 1;
+	if (arg_type_is_raw_mem(arg_type))
+		meta->arg_raw_mem.argno = slot + 1;
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
@@ -9565,6 +9569,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 	return 0;
 }
 
+static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			  int insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_reg_state *reg;
+	u32 slot = meta->arg_raw_mem.argno - 1;
+	int i, err;
+
+	if (!meta->arg_raw_mem.size)
+		return 0;
+	reg = get_func_arg_reg(caller, cur_regs(env), slot);
+
+	/*
+	 * Validate every argument before initializing outputs: an input argument
+	 * may alias an output buffer. Use the normal stack-write checks to discard
+	 * stale spills and preserve the rules for special stack objects.
+	 */
+	for (i = 0; i < meta->arg_raw_mem.size; i++) {
+		err = check_mem_access(env, insn_idx, reg, argno_from_arg(slot + 1), i, BPF_B,
+				       BPF_WRITE, -1, false, false);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
@@ -9863,9 +9894,13 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_UNUSED)
+		enum bpf_arg_type type = fn->arg_type[i];
+
+		if (type == ARG_UNUSED)
 			break;
-		if (!arg_type_is_raw_mem(fn->arg_type[i]))
+		/* Struct pointers may resolve to generic memory during argument checking. */
+		if (!arg_type_is_raw_mem(type) &&
+		    !(base_type(type) == ARG_PTR_TO_BTF_ID && (type & MEM_UNINIT)))
 			continue;
 		if (seen)
 			return false;
@@ -11588,16 +11623,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	regs = cur_regs(env);
 
-	/* Mark slots with STACK_MISC in case of raw mode, stack offset
-	 * is inferred from register state.
-	 */
-	for (i = 0; i < meta.arg_raw_mem.size; i++) {
-		err = check_mem_access(env, insn_idx, regs + meta.arg_raw_mem.regno,
-				       argno_from_reg(meta.arg_raw_mem.regno), i, BPF_B,
-				       BPF_WRITE, -1, false, false);
-		if (err)
-			return err;
-	}
+	err = mark_raw_stack(env, &meta, insn_idx);
+	if (err)
+		return err;
 
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
@@ -13101,6 +13129,10 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
+	if (!check_raw_mode_ok(proto)) {
+		verbose(env, "multiple __uninit buffers are not supported\n");
+		return -EINVAL;
+	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -14178,6 +14210,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	err = mark_raw_stack(env, &meta, insn_idx);
+	if (err)
+		return err;
+
 	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
 	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||
 	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
-- 
2.53.0

