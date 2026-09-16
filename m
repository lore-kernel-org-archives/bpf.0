Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02917497B63
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574914; cv=none; b=axmR7HyMXexCe64rqnbjjGLp3ifEeh0fK+N3b4q1KYNwrv7P4z4dTJwSSws7CGNwfNpDYk0ZN5SdkNtOUmVYzxw/pKz2sH1Wmi0FPdHMQZI4u/Uql07IdtChQsBcI8kXMf7YV+A7xchutaUFtu0tXTrDtv7rfyyHfsilfGrsarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574914; c=relaxed/simple;
	bh=XLKzwphqLrVMpBcY9qwHNashtiSozqL2PuzIuqBflVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzeRsyZlf9ctc3maxXXXgcmkqvLXUuY/1n962ue5JMmIGh1cjhixNVBmVV8JMFzYzDOEzbSwm7lrPqCo1pjuQ0Ovlg1U6CPtgnoEvtJV/F7JAsSHIbq7Ri+iU3z920/TAlwkZl6tM5QIkNvpBafQFnHwzM70AOs1v7AnOEbPzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6OFhPJf; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6OFhPJf"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so14399095e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574907; x=1790179707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBvW1yUiYzobvyC+N9lw4aE78y/HxYVZMp71MoJYvZU=;
        b=I6OFhPJfXfbpt7C3Rg4a5sOgwSFT89PK9SH8kWREkt54qIaW7xC1nV1m2YUgGSzfjt
         Rb+lQIuECTNkkgCQegaAkLa4By9LRsVzfi7xtOZcmhaho8ul3WLxyFzkGdvsNqGJG09y
         aQIdN0eP/XhutC7la6e62TS/SjZSsTDCAAZsTtNgRZS42FOACAlytGXNJvvrs9tFWLgt
         KQUrY32kQ+9vB0psXVNZhe9rTyqe3IOnkpCxzX7M68G3uyeuzypsUmovtS5upZbu07/X
         KDGgKxi+ixG8rplL+3+nweY2ToYBfQOt86Q+tbCEUF6WMd5MgWH34iHdNLUY/Kky1yB6
         +QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574907; x=1790179707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBvW1yUiYzobvyC+N9lw4aE78y/HxYVZMp71MoJYvZU=;
        b=qGcz0b7ocobKi4cXtaQnH1Mx0QUtxriq8UC6dUtE0+P88kaVv3EPteIVcAt4Ft8JFQ
         OdB7oxjkfSJ+rdIFPpnDEsys51Xr4krFTPFOxoRqpkG7PiO+VjNXnslL8ypgCi+Lhbnc
         OIXuI/feP+RcqVMQV58rot3XDSroRk5dZ7kpAl/pENTASQryj7rnPQs3l9W3yy8wdBBF
         Esx9tDG/iiX/0AN8LBn+LtGiOn7xz6Il5jqiEiKxCR5ulLaa/OodyaY1xKCP+lv26O0j
         SqPPakFp1LCCcepYksEPc9p46b0Q7jH5eCRmKUAd3zHXApkQIP/kzSxrQkpoiu51CalS
         V7hw==
X-Gm-Message-State: AFuF++lMvGlWukxzFCRE+lFn1OvQn60OTwrGg1fPCnOoqzOtsZqtvnyv
	LdgXVXk97h/bgh17BS1rBfbnniGPgj1bJ2oUv9SaSlBbDXc7ohGWNRhrbLNP2erd
X-Gm-Gg: AYBFou1bE0tZmGFP7jy8DT68j/hMEPDdeCWulqQmv1Ptu9VFE1nwLt+nx77vqj/Ay3o
	Zx2DOg7hxHf54xt5P/i9RLT9R/glg97Npqq/IJAIhDDNC1zNu0SvAO3NMqKA40mLPEfH3+hsRMW
	O3A+RIjXLCBEuqdbUJMxAq2hQhj2Dbl9tpC1e2S8SccnzrweAcNG7NlU33ZwmXR7W8jA5j2Up0h
	yhrgUqTXVjvoCZneyz55pBM0E2EWsEwSb69yXd3RbwQAMGj2Av5V7LARpPqinXqWxj4Qw86t0LE
	t8yHNeSMuIkZyNrS3pgIo4bAfjVeldZzxYfnXSoQe2nzbvHE10U0YDrZHRrx+Xx1PHw3KVy8D5J
	TXgWm0JtlzfltNZ/WNR1I1pEihYdqrUQDJHkggf0aMKDoGvDlLlWlLkXT7qAVMMp5gX8JXW1Z5y
	cz2Ab3vp0NH8dUePoCAERTlnPnlXGnY3T3Y1aNwLzkrrHoH71VzoSqiAQPP7rdJ1a1m0YEgHWER
	DhqjnkD69WmvqkxdmK3S9PLMxQyNqL688wsNEP0hOKzuHceE5eLR34OGbUD9OyCdoSG5mr9hiaE
	0vwk1uAHVdRElCFasAeJ+teQsOm6/vOIZXS+st8=
X-Received: by 2002:a05:600c:3b02:b0:49c:fc6c:be05 with SMTP id 5b1f17b1804b1-49eb7334cbemr32713395e9.28.1789574906701;
        Wed, 16 Sep 2026 09:08:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm1796215e9.3.2026.09.16.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:08:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Fix generic __uninit kfunc output buffers
Date: Wed, 16 Sep 2026 18:08:15 +0200
Message-ID: <20260916160821.3157543-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916160821.3157543-1-memxor@gmail.com>
References: <20260916160821.3157543-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10181; i=memxor@gmail.com; h=from:subject; bh=XLKzwphqLrVMpBcY9qwHNashtiSozqL2PuzIuqBflVU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvVvuf/NvdtPrq5qyY1cM7O+E8z9FZy3D0tKbfKc7d6r f2HCHHzjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE8wojQ0PLGs5lb3f51Uf+ EX+xv3XXrz93Hh0LEDp2SisofFIiXy8jw5nEBzqtt3lfMKZl7LhtdSjxyI2iL2FnK2Mz/7nde84 ozQAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack liveness treats __uninit kfunc arguments as writes, but generic memory
argument validation still checks them as both reads and writes. A checkpoint
can consequently poison an output buffer before the call and cause its read
check to reject the program. Allowing that read would not suffice: ordinary
clobber checks leave poisoned bytes poisoned after the call.

Check generic __uninit memory arguments as write-only and reuse the helper
output descriptor to record definite initialization of a single output.
Apply the writes after validating all arguments so an output does not make
an aliased, uninitialized input appear valid. Look up the output register
state only when there are recorded bytes to initialize.

Preserve MEM_UNINIT when a scalar-only struct pointer is resolved to a
fixed-size memory argument. Use a common access-mode helper for fixed-size
and sized arguments. Disable raw mode for a variable-size argument only
when it is the tracked output.

Document that generic output buffers must be fully initialized on every
return path, including error returns and padding. Multiple-output tracking
is left to a separate change.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/bpf/86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 27 +++++++++----
 include/linux/bpf_verifier.h |  7 ++--
 kernel/bpf/verifier.c        | 77 +++++++++++++++++++++++++++---------
 3 files changed, 82 insertions(+), 29 deletions(-)

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
index cf85141ea167..3c1b06a3daf3 100644
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
+	u8 regno; /* Register number, or one-based kfunc argument slot. */
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
index 6c6b8d8520cd..0433a5183682 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6981,7 +6981,7 @@ static int check_stack_range_initialized(
 	 */
 	bool allow_poison = access_size < 0 || clobber;
 	/* The call will initialize the memory; uninitialized stack allowed */
-	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
+	bool raw_mode = meta && meta->arg_raw_mem.regno == abs(argno.argno);
 
 	access_size = abs(access_size);
 
@@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * raw mode so that the program is required to initialize all
 	 * the memory that the helper could just partially fill up.
 	 */
-	if (!tnum_is_const(size_reg->var_off))
+	if (!tnum_is_const(size_reg->var_off) &&
+	    meta->arg_raw_mem.regno == abs(mem_argno.argno))
 		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
@@ -8885,6 +8886,16 @@ static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return 0;
 }
 
+static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_type,
+						 const struct bpf_call_arg_meta *meta)
+{
+	if (arg_type & MEM_UNINIT)
+		return BPF_WRITE;
+	if (meta->btf)
+		return BPF_READ | BPF_WRITE;
+	return arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
@@ -9176,15 +9187,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		enum bpf_access_type access_type;
 		bool known_memory;
 
+		if (meta->btf && (arg_type & MEM_UNINIT)) {
+			if (meta->arg_raw_mem.regno) {
+				verbose(env, "multiple __uninit buffers are not supported\n");
+				return -EINVAL;
+			}
+			meta->arg_raw_mem.regno = slot + 1;
+		}
+
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
 		if (!(arg_type & MEM_FIXED_SIZE))
 			break;
 
-		access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(arg_type, meta);
 
 		err = check_mem_reg(env, reg, argno, arg_size, access_type, meta, &known_memory);
 		if (err < 0) {
@@ -9230,9 +9247,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		if (meta->btf && bpf_register_is_null(buff_reg))
 			break;
 
-		access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
-		if (meta->btf)
-			access_type = BPF_READ | BPF_WRITE;
+		access_type = func_arg_access_type(fn->arg_type[arg - 1], meta);
 
 		zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
 
@@ -9550,6 +9565,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 	return 0;
 }
 
+static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
+			  int insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_reg_state *reg;
+	u32 slot = meta->arg_raw_mem.regno - 1;
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
@@ -11572,16 +11614,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
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
@@ -12437,7 +12472,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & PTR_MAYBE_NULL);
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
 }
@@ -14140,6 +14175,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

