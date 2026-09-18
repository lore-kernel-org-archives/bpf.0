Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68126C3BD
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709360; cv=none; b=fACkulCugJFyV5i4GQsVrzYpAVKDVWxoZw+Z095hSRwh9cgy+p2X3cB6THzWZiy0d9sBFK/FCXU49Ufn7ETP+cW0aS2zSBHIaIjCQ39dHr4XrIuZTqOexckm9lhIyqUl4CKTChxDLZ8nCVNbivfn3RqLaN66Zwl191I7wTBmpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709360; c=relaxed/simple;
	bh=3pgjN1ChBK0r7kCQPS+/lojAsp9LdQDLRYH+Sz9yvcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmYBDTJJVPIzmVXf8+tCA7LR+lKjqTCdVZB1h2gxfK/AdqjcoFx9hZPsq38c8wyVyQKOQjLMLzAl0nopWFbH8XOErd07OzjzfHZpYhdzc7BdENb1JXLVSz3v7EWyQ8QOC/xNOme63cEyBbDNsUTRoH1RyjN+Gpy9n5/36jp0/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwhBkjV2; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwhBkjV2"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so64758f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709356; x=1790314156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6dnksB+TiTn97DHO11g0Eulh/EuaXryIvrLL3UQPww=;
        b=dwhBkjV2/yE5YFUT2kvn/0kpMdd+a07mogSSpUvy50voHE3Emjqbr2GwXgV42zrB4r
         +Orc5yjQtwg0cf3oLdV51x7v+RvWHD1Ovpt9YKXdfepzJvJm0018Qnl+GBZ1HfaJS2W2
         3haEq6Q0Dh4WKZsKmD85JWVAecc5ReMGNNZI6iDlTtcSa8CPylIahzisEVZ0TKRoQwhe
         e8ch1ViK5jR7uFqY/eSFU1MD68Dtv/5C8D4xHe2QHJvhbr8SBuC0vkyJAEYXxVZzKwZv
         lqWKh31W+O5L5vvWpRvRWEJfv0OhtcP3st4bOBpgd8WUMntEVa7UH/JxEutMXy0mHyBK
         ix2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709356; x=1790314156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6dnksB+TiTn97DHO11g0Eulh/EuaXryIvrLL3UQPww=;
        b=WUfiDIGKkqtmv+oK7T/XlBcPlV60y+YZw7SiXwlEuaxmkzVgFbR6B8jiOKKQHF025h
         aAcg4LQaC7Fyo6AbWl1dd3VcAllYgWAQm5KEwx9bOoMyNvwgkg3Jllf+B+08UgC6s9c5
         sgXUb4F2tH7I+4SkC2Nmh5NoOSANY8Y/wdnPlBDKJ5+KiHCsCv1f0U/D9SESILoqYQHi
         PIRylzQ3nlfy+UQ+jLl9FqShPNS3TwrbkNG81QLHLV42WjUIn2LaLQiBEb1K+XoI9gxB
         XqZyp8/nK77qodA5AHW91UmoBo1Pz0a85S0FOFlEPxmMc1mpnUzth2lZLCZtDGhCUKr0
         pFWA==
X-Gm-Message-State: AFuF++lFPER186iHVfoLC2Gn/Vi5C1X7vfmEKlvIrXmMPOe2Fvuy3TNq
	wAoqftS1H6tGQGb25n5ltez6RJbhGmCuL3SZ8fBymWSzQPiGgVJmqjw4WMQkjrkl
X-Gm-Gg: AYBFou2UhQRCXHFng+CpHl+u0J2hDoEK2LmQNKEX6JM/pAspv4Dy+3W2NgYUmALPd3D
	whMx0SUGfje5dVJBZl47B+MAEH+X7HYlGl5tkrDC7bM/QuxM9leeQZktci2KHHnH23yGfBpUknP
	H8EQRpQ0X3QIof2gZw8cEX5OINQQHbhtwNRaCIZGzvBLhbZD3+tTin2s/2aJIDc7ijWXnOAbZYj
	EyNgW8Qq3YOK19k8gbxIj7Q0SyUvZAhvmMbod7akOLI8AKlYxhH/lPkyUavtRPaZc5LRRRZNqOA
	MfRPJi8WS1VIQo8c3680FGv59LGlIU5t/OEjHXBwjO5h3cwo2btwgpsH4xI9YdxmpY+6+dDW+1m
	qPTsoANe9/j6CEAXx6Fy3k9v7nrIBD9LpvVLXXRBdYBpnCL4ysFa2N79t5G5rY15/89X8CVxx/6
	MniYk4ISwk87reRzOtMPUCOvIB7d8IFRrQHcQteXXqJ6kRfrwFIy5i6li0ptRJTQYZIJhzIvLxs
	8vQQmTDiLtUD3ukC8rtuxRrQeUgo+PBTXy7FRFyNIqMagi7uTEgRhppj0pu3u6GCbyZ9kXmsWE8
	OJbat3fa99BLvZxkcjL1Du76RSE8wQv4sfAn/pWRvWHuYSXO
X-Received: by 2002:a5d:5f41:0:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-4871e215994mr1717393f8f.11.1789709356024;
        Thu, 17 Sep 2026 22:29:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008f34dsm1190520f8f.36.2026.09.17.22.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/8] bpf: Fix generic __uninit kfunc output buffers
Date: Fri, 18 Sep 2026 07:28:59 +0200
Message-ID: <20260918052906.12226-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918052906.12226-1-memxor@gmail.com>
References: <20260918052906.12226-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10014; i=memxor@gmail.com; h=from:subject; bh=3pgjN1ChBK0r7kCQPS+/lojAsp9LdQDLRYH+Sz9yvcQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6ddHn2+Z1hx72tjHf4uv348pkzZq/HKfL3HNbN9jU Xaxh34zOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRHmVGhh77FsUP37Yknr2c /TD9nL3p+YO8uswXJQv2nWVftvZtXB3DH64ahWTpVKZ5qY++bo82Ylxy/1PY90sBtx+17Ge+u/C KDQcA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 27 ++++++++++----
 include/linux/bpf_verifier.h |  7 ++--
 kernel/bpf/verifier.c        | 71 +++++++++++++++++++++++++++---------
 3 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 6c2c048dccef..71fb0ca72d69 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -164,19 +164,32 @@ suffix should be used.
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
+For variable offsets or sizes, callers with neither ``CAP_PERFMON`` nor
+``CAP_SYS_ADMIN`` must initialize the potentially accessed stack range before
+the call.
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
index 21eb806b1351..d327b5356d53 100644
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
@@ -6981,7 +6987,7 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
+	bool raw_mode = meta && meta->arg_raw_mem.argno == arg_slot_from_argno(argno) + 1;
 
 	access_size = abs(access_size);
 
@@ -7216,8 +7222,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(size_reg->var_off) &&
-	    meta->arg_raw_mem.regno == reg_from_argno(mem_argno))
-		meta->arg_raw_mem.regno = 0;
+	    meta->arg_raw_mem.argno == arg_slot_from_argno(mem_argno) + 1)
+		meta->arg_raw_mem.argno = 0;
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8158,9 +8164,12 @@ static bool arg_type_is_raw_mem(enum bpf_arg_type type)
 	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
 	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
 	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized().
+	 * A kfunc's struct pointer remains ARG_PTR_TO_BTF_ID until call argument
+	 * checking resolves it to generic memory, so include it in proto validation.
 	 */
 	return (base_type(type) == ARG_PTR_TO_MEM ||
-		base_type(type) == ARG_PTR_TO_MAP_VALUE) &&
+		base_type(type) == ARG_PTR_TO_MAP_VALUE ||
+		base_type(type) == ARG_PTR_TO_BTF_ID) &&
 	       type & MEM_UNINIT;
 }
 
@@ -8939,10 +8948,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
-	if (!meta->btf && (arg_type & MEM_UNINIT) &&
+	if ((arg_type & MEM_UNINIT) &&
 	    (base_type(arg_type) == ARG_PTR_TO_MEM ||
 	     base_type(arg_type) == ARG_PTR_TO_MAP_VALUE))
-		meta->arg_raw_mem.regno = slot + 1;
+		meta->arg_raw_mem.argno = slot + 1;
 
 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
 		err = mark_arg_precision(env, argno);
@@ -9553,6 +9562,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
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
@@ -11576,16 +11612,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
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
@@ -12442,7 +12471,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
-		    (*arg_type & PTR_MAYBE_NULL);
+		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
 }
@@ -13068,6 +13097,10 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
 		return -ENOTSUPP;
 	}
 
+	if (!check_raw_mode_ok(proto)) {
+		verbose(env, "multiple __uninit buffers are not supported\n");
+		return -EINVAL;
+	}
 	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
 }
 
@@ -14145,6 +14178,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

