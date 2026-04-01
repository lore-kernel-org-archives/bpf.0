Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2B407115
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046506; cv=none; b=PLg04w/A0n/lkccCjvGk6d4ykux5zfpWlSlMlG3QWajC6Vyh2XO0vRFOUvoPm/4GOax2HsMYy+CxTMJwFiTbarmW5z6UCkBgAmdDrmnf1oF8/ATaSnfvNxnZRhTkdWKimgbqmvc6/3GGI19pOiTZ1tp5QKm7G1Rd557cDYP1KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046506; c=relaxed/simple;
	bh=02k8xxkxzFUzoQyy/XFAXPm/KhaKDKrxNsdzx3c9HYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e43vgk2CwLBfORW3+KiH1dqi22wYUo95D/Fw8rGcb+U1V3gkF/zIhnpEK2xdilkUkNVb1GI+K2biLGMxJ4+QIHG2YtWFNRPrzqs8/w6bdvng9QY98OrN1PWhqiVEdBNJX0AY+NGN6pUhWnBg/Lou9yY9vkh3U8cyUfQa7L4z4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8Oh+y08; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8Oh+y08"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-46726528f1cso4354440b6e.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046503; x=1775651303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwQHgt38p9q6X9XfefWujMbURzsjlswsESossDPg2+8=;
        b=d8Oh+y08LeWeO5IYZXTCOZOe+kuIOvMqS/jBCXucOdEP8zzdgCqpCtG+JqoAR63EuF
         pF6JV9zSKH7sI+97buBkN/0mYWanaGaUB7eB6s2XhE8r4nJ8IINarAkGIfXq4ieXPmfY
         EFDYp8vHRUjQ5cAQiGY/DHt4m8VXxQjJ0eiepWQ6I1hYfU78zUsdrcjNtCpCj5BFgC4Q
         UmYdeBV9/x52JFRCrFvNavgQlV764dkKfjkqzxezezcWKdwmMdMVFUk8ssYykEy3I389
         rHFpav0zYr+o/nAhpM3mfgpqwJkUGsNptxEG4UD6IYJDfLePESoWIO5CmV/ZaMqUQltY
         gjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046503; x=1775651303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwQHgt38p9q6X9XfefWujMbURzsjlswsESossDPg2+8=;
        b=fF8I9BC+iq8yK5gO0g/N2h9BunmTN66udV5HmpjauLBKi6EblZw1r7cugBOZGwyDyA
         TSCAwvPb0zI7n6ydnyd7wPbbL9WcAV6qaLfHBG2ZjtD8wNyyw0PyU+41NZN1gtSfBvwu
         8DIF/sf8fcDKG+VTVu989OhANkDkFQkU8VIFr2cYxt2WxeMIZfn6l/Q4zdTsqTRmHTZ/
         tRJ3uFekdrhinjstbbpgcRtFKwhpp2y3OtMz4HjQCNbxcB4hfqly1gVhVlu0fdEHDp/6
         CP9zsmModr9ynHkWUCeZO2pCX62wR0+GIH6EyC3eQe7J4n8R+DRGlI4ivyYFaBzfC3gP
         Ovug==
X-Gm-Message-State: AOJu0YzXBxbb2FKk5FnRO8kJCjcyM4DSxeldQNTPZqh6H1HxklA6JVaV
	KgGYsDj2yJxYSHfyGnGG/e+//ak3JfDDP3uwGn8GVCm1tsT3JbKNJ//BdepG39vExvo=
X-Gm-Gg: ATEYQzxs0LZe3D/MUBCUB3gM94npX3sWJWTyqnU89KBPN6u+WdkKylax1cxInJXag0O
	zENs6cxaDPfrXId1qAiRU4p77VzFXUfXfPEyeEDXEjIpy6jwxs7CFNnpPhHktuT//8fXKoEeLOZ
	K45itJGSMVS01C0EB1khWk+3Pich/EOurkpbEMmcLHoWFKbZQ8vD05wSmYMsseYyw2oWfQTGMak
	JMnr6uzd8hDOte5McEN10O07X6Wae8mJHkcGf0oQIzbTDUIYyGEjBvfhuse9zAkGi0GrecfxYLd
	Gtgh/xYfz9e9KYqF5C5w+p+d+W8q+2+sCRipEOF57i9j42u2Npis9D0IuFZkrnH7UbThUiih9iJ
	SNpeFsvboNZN6SllI1pUHzy2cByrjdObs9dvNIQtakNAvlJK89xM96Ng3wbI0yztLywS7GtsO76
	cLyr3oyc50/O0w2rL/TXanbXjsXLB86CYsW1p1Kul1ol0L
X-Received: by 2002:a05:6808:6f86:b0:46a:72dc:28cc with SMTP id 5614622812f47-46adffc1acamr1732054b6e.1.1775046502920;
        Wed, 01 Apr 2026 05:28:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fef82absm8515530b6e.8.2026.04.01.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/7] bpf: Support variable offsets for syscall PTR_TO_CTX
Date: Wed,  1 Apr 2026 14:28:10 +0200
Message-ID: <20260401122818.2240807-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11314; h=from:subject; bh=02k8xxkxzFUzoQyy/XFAXPm/KhaKDKrxNsdzx3c9HYg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs312G8LqzdVc7RBN+mrFpOFVXvT6gM0Hw5TSu3wFT5wXy C2/vKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZwIZwcQrARBQDGP4Z2x9RzUqKvLVk1Zu2Pu2Ps4 PPsQVO2WH1gNdTsditysmN4Z96P+On0ykScSdsRX5839D/TYOTm2vT6uzV1sV6sV0TTzEDAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
Fixed offsets are already enabled for all program types that do not
convert their ctx accesses, since the changes we made in the commit
de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
that we also lift the restriction on passing syscall context into
helpers, which was not permitted before, and passing modified syscall
context into kfuncs.

The structure of check_mem_access can be mostly shared and preserved,
but we must use check_mem_region_access to correctly verify access with
variable offsets.

The check made in check_helper_mem_access is hardened to only allow
PTR_TO_CTX for syscall programs to be passed in as helper memory. This
was the original intention of the existing code anyway, and it makes
little sense for other program types' context to be utilized as a memory
buffer. In case a convincing example presents itself in the future, this
check can be relaxed further.

We also no longer use the last-byte access to simulate helper memory
access, but instead go through check_mem_region_access. Since this no
longer updates our max_ctx_offset, we must do so manually, to keep track
of the maximum offset at which the program ctx may be accessed.

Take care to ensure that when arg_type is ARG_PTR_TO_CTX, we do not
relax any fixed or variable offset constraints around PTR_TO_CTX even in
syscall programs, and require them to be passed unmodified. There are
several reasons why this is necessary. First, if we pass a modified ctx,
then the global subprog's accesses will not update the max_ctx_offset to
its true maximum offset, and can lead to out of bounds accesses. Second,
tail called program (or extension program replacing global subprog) where
their max_ctx_offset exceeds the program they are being called from can
also cause issues. For the latter, unmodified PTR_TO_CTX is the first
requirement for the fix, the second is ensuring max_ctx_offset >= the
program they are being called from, which has to be a separate change
not made in this commit.

All in all, we can hint using arg_type when we expect ARG_PTR_TO_CTX and
make our relaxation around offsets conditional on it.

Drop coverage of syscall tests from verifier_ctx.c temporarily for
negative cases until they are updated in subsequent commits.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 104 +++++++++++-------
 .../selftests/bpf/progs/verifier_ctx.c        |   1 -
 .../bpf/progs/verifier_global_subprogs.c      |   1 -
 3 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..4b34f4198215 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5897,6 +5897,10 @@ static int __check_mem_access(struct bpf_verifier_env *env, int regno,
 		verbose(env, "invalid access to packet, off=%d size=%d, R%d(id=%d,off=%d,r=%d)\n",
 			off, size, regno, reg->id, off, mem_size);
 		break;
+	case PTR_TO_CTX:
+		verbose(env, "invalid access to context, ctx_size=%d off=%d size=%d\n",
+			mem_size, off, size);
+		break;
 	case PTR_TO_MEM:
 	default:
 		verbose(env, "invalid access to memory, mem_size=%u off=%d size=%d\n",
@@ -6390,9 +6394,14 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 	return 0;
 }
 
+static bool is_var_ctx_off_allowed(struct bpf_prog *prog)
+{
+	return resolve_prog_type(prog) == BPF_PROG_TYPE_SYSCALL;
+}
+
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
-static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
-			    enum bpf_access_type t, struct bpf_insn_access_aux *info)
+static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
+			      enum bpf_access_type t, struct bpf_insn_access_aux *info)
 {
 	if (env->ops->is_valid_access &&
 	    env->ops->is_valid_access(off, size, t, env->prog, info)) {
@@ -6423,6 +6432,34 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 	return -EACCES;
 }
 
+static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
+			    int off, int access_size, enum bpf_access_type t,
+			    struct bpf_insn_access_aux *info)
+{
+	/*
+	 * Program types that don't rewrite ctx accesses can safely
+	 * dereference ctx pointers with fixed offsets.
+	 */
+	bool var_off_ok = is_var_ctx_off_allowed(env->prog);
+	bool fixed_off_ok = !env->ops->convert_ctx_access;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *reg = regs + regno;
+	int err;
+
+	if (var_off_ok)
+		err = check_mem_region_access(env, regno, off, access_size, U16_MAX, false);
+	else
+		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+	if (err)
+		return err;
+	off += reg->umax_value;
+
+	err = __check_ctx_access(env, insn_idx, off, access_size, t, info);
+	if (err)
+		verbose_linfo(env, insn_idx, "; ");
+	return err;
+}
+
 static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
 				  int size)
 {
@@ -7853,17 +7890,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
-		/*
-		 * Program types that don't rewrite ctx accesses can safely
-		 * dereference ctx pointers with fixed offsets.
-		 */
-		bool fixed_off_ok = !env->ops->convert_ctx_access;
-		struct bpf_retval_range range;
 		struct bpf_insn_access_aux info = {
 			.reg_type = SCALAR_VALUE,
 			.is_ldsx = is_ldsx,
 			.log = &env->log,
 		};
+		struct bpf_retval_range range;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -7871,19 +7903,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
-		if (err < 0)
-			return err;
-
-		/*
-		 * Fold the register's constant offset into the insn offset so
-		 * that is_valid_access() sees the true effective offset.
-		 */
-		if (fixed_off_ok)
-			off += reg->var_off.value;
-		err = check_ctx_access(env, insn_idx, off, size, t, &info);
-		if (err)
-			verbose_linfo(env, insn_idx, "; ");
+		err = check_ctx_access(env, insn_idx, regno, off, size, t, &info);
 		if (!err && t == BPF_READ && value_regno >= 0) {
 			/* ctx access returns either a scalar, or a
 			 * PTR_TO_PACKET[_META,_END]. In the latter
@@ -8456,22 +8476,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_ptr_to_btf_access(env, regs, regno, 0,
 					       access_size, BPF_READ, -1);
 	case PTR_TO_CTX:
-		/* in case the function doesn't know how to access the context,
-		 * (because we are in a program of type SYSCALL for example), we
-		 * can not statically check its size.
-		 * Dynamically check it now.
-		 */
-		if (!env->ops->convert_ctx_access) {
-			int offset = access_size - 1;
-
-			/* Allow zero-byte read from PTR_TO_CTX */
-			if (access_size == 0)
-				return zero_size_allowed ? 0 : -EACCES;
-
-			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						access_type, -1, false, false);
+		/* Only permit reading or writing syscall context using helper calls. */
+		if (is_var_ctx_off_allowed(env->prog)) {
+			int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
+							  zero_size_allowed);
+			if (err)
+				return err;
+			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
+				env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
+			return 0;
 		}
-
 		fallthrough;
 	default: /* scalar_value or invalid ptr */
 		/* Allow zero-byte read from NULL, regardless of pointer type */
@@ -9415,6 +9429,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MEM | MEM_RINGBUF,
 		PTR_TO_BUF,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_CTX,
 	},
 };
 
@@ -9724,6 +9739,17 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		 * still need to do checks instead of returning.
 		 */
 		return __check_ptr_off_reg(env, reg, regno, true);
+	case PTR_TO_CTX:
+		/*
+		 * Allow fixed and variable offsets for syscall context, but
+		 * only when the argument is passed as memory, not ctx,
+		 * otherwise we may get modified ctx in tail called programs and
+		 * global subprogs (that may act as extension prog hooks).
+		 */
+		if (arg_type != ARG_PTR_TO_CTX &&
+		    resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
+			return 0;
+		fallthrough;
 	default:
 		return __check_ptr_off_reg(env, reg, regno, false);
 	}
@@ -10771,7 +10797,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			 * invalid memory access.
 			 */
 		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_CTX);
 			if (ret < 0)
 				return ret;
 			/* If function expects ctx type in BTF check that caller
@@ -13645,7 +13671,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 			fallthrough;
-		case KF_ARG_PTR_TO_CTX:
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -13663,6 +13688,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
+		case KF_ARG_PTR_TO_CTX:
+			arg_type = ARG_PTR_TO_CTX;
+			break;
 		default:
 			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 			return -EFAULT;
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 371780290c0d..ae756764ffba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -359,7 +359,6 @@ __naked void syscall_ctx_fixed_off_write(void)
 		: __clobber_all);					\
 	}
 
-no_rewrite_ctx_access("syscall", syscall, 4, u32);
 no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
 no_rewrite_ctx_access("tracepoint", tp, 8, u64);
 no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index f02012a2fbaa..2250fc31574d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
 
 SEC("?tracepoint")
 __failure __log_level(2)
-__msg("invalid bpf_context access")
 __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
 int anon_user_mem_invalid(void *ctx)
 {
-- 
2.52.0

