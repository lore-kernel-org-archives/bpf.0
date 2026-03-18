Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277236E460
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830134; cv=none; b=VLCSWW+C1eVoYYeZeGTK07lzwkWnnhKGnfuxeu7Pffh5ZPrKm+/uG6UTVTCmYQa7u1cttOGQc/J/EuoZLGZ8WEmsyfuXQz354Xx1ybTNyH0PLIFhZpnQFEJEAnl+KBmqFD2g3MjbSJsEjBC+2/UxUP7XSLqy6X8bNY9+tmukfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830134; c=relaxed/simple;
	bh=lCr6nUOu+PXxgyu5CJ7uxvxIO8wSDWtAF5Jxt9m+4po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blzpYLpNn5VwzwWbmCu7f/hmmAw0oYiKFOHpSXTSLQY7aSjGnnuRsCeNNE/OPwOe79PjYuH7qPz1O4ZgF3cM2fA8IKMx/Drsvz9SW/cDZanPQhUP1QfAqmLIS+KI/J+7hWJx5lJ0jQbEsLK17ituwutAC5G1eAqxTi0KQMFkXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avt+FVEB; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avt+FVEB"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d74dbfe84cso4611355a34.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830131; x=1774434931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V/zUHKerO4HnF7CBbAyadgAqEXyowqcj8yCHQ8wsic=;
        b=avt+FVEBbyP5yAxwewqxEBaBeeU2YCS5ucvLDijt+a67sxKYrR8qzolRonsQm+QVpZ
         GA1VqwG+sZfZ9hzckD9nbYaVjZ4AjhvHYQmfO5PVm1YMo+UcGsqxdMmhXDzkkOLXOR+f
         M6q7t33gj/DxVwBZKJmTdGp8dNRmVkgU3f3aXhDHkpUt8KdJ0fUt/sLj1q91qrr4ye6R
         x+NY6NRjSVwAD3fM3oQHplXu5n94tO0CctpqSa1ZvPrTQaQ6FrARJmtT+4wMRBC/9wSF
         xYGs0R3hDtzTW8FekqROaVKFm4XfIBFdpo+fnMBqp5a94YOf9bvtNtqixqjXc1cTjmj4
         PhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830131; x=1774434931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5V/zUHKerO4HnF7CBbAyadgAqEXyowqcj8yCHQ8wsic=;
        b=PrurGGXTUL5swGVLyp3dD0u9G9o2YT8LfJaVr5l3+4aUyXo886Y8rJjDHI5Nn64qn/
         x7dk5sR8JAMW0EV0NFvYXoNLyCRlBBhP1V0VCqAOGnfdGOLilkl7nkTT/Vb7n+4TLRhM
         yfMBQ5Bqb8MUnSmQK+pTFaoSTC1+Sl/ZlyS0qlyB8xXEQxP9phF+FbF/rCQmzfR7wZJ1
         SOVQYNvn5BqmXlUPXdPAOrGgOO8ti3KSlxTP22Y58G1q5ufd+y/B20ssH70RobKzDmEL
         RmCZiSxdhVONfzW6C+g0+8rWz7CVcrK3sXgoLsNpWHoWS3yULIQzy/6vLb+xzxM8TtsI
         KvIw==
X-Gm-Message-State: AOJu0YxqQE6Qdkz4TbuhZ0GMXe4IVy0Zd4qVfRppgjqY7fnkyZhEM6W4
	mFP+bzVxARDQtCRs0VDqtqYvvTfLizZ47Nz1phyCj+Bsi47kCG2Qr7EK5GpxCvgJp/o=
X-Gm-Gg: ATEYQzyv1zGuhCoUr26wRGhKZsZtlTEig7xDMOHBxMNG77y9qE3rgkuosvFLQPlIP66
	XEXYD0G55hkEX5PDs6mOiVXnNZtAu1nmedOvTY4qQy/ewwe2kocm/NUOfK8vIg+hE+1iDb+fud8
	mspps1pk5y32K8nQukbogim8X5w5PdH4y3PFKRfZvQVrX+td8CPgf7rqogP5ZnsqeuLFCc/ypLV
	pW5wHFFsCWD5HNSMIkvxk0DTxNOcVM3FzAMjPTGbN7muxAD+sj05cTDEhM6wxenL2q5FxUIlQm9
	P7lDFxHnFY0PZywSotu900rFjLk6ud7OE/6UIG+hbV+D/RpSiY+XBzCVJ3hzYnqv8YeZiWSW6Xe
	0wGeURYzCH2SzAIlNuN0Cd+Hp+3Tv+kIKFZHGQUSSW0wbaA2GTm5rsvgHet7suttPnQj6DI8XTA
	aRBacq/9PvhTpXLCENf73yfLlJ119YryWkKM1/CbXBVc7dTQeonH7WKZ0=
X-Received: by 2002:a05:6830:4905:b0:7d7:4721:9a3f with SMTP id 46e09a7af769-7d7ca82b06cmr1702250a34.33.1773830131282;
        Wed, 18 Mar 2026 03:35:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c996cd31sm1849655a34.8.2026.03.18.03.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:35:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
Date: Wed, 18 Mar 2026 03:35:24 -0700
Message-ID: <20260318103526.2590079-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318103526.2590079-1-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8212; h=from:subject; bh=lCr6nUOu+PXxgyu5CJ7uxvxIO8wSDWtAF5Jxt9m+4po=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpun/luEgoa/OQBX0WJTmHjgV4NlGhqXBLHzSBxzY2 1ZHu9vWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabp/5QAKCRBM4MiGSL8RylGdD/ 9tSyVzp28QIgeill2JyK+oBoP8uVj1Yr4N3fDJw+fTru5FVR8VdlzOHHT3dI3KK9+w0k0OZx7pdb2K Ycze+piHTW4AbUyWWwNoy5necAAY0i45ok2eGorL41DHrXmDzSvY0wnom45iKGkRzxzFH2WFSOwRke r7hnNOyzQIpIQnifYZIqr4aGQ6M+H0KUaUHdWKBJYvgWj4w5MohxyFqjgpRny/JVeKItgTWNAlTvCQ OyYr61inwvcbTjqikHXhO74SvGSMlcDOY7HXSoHHH+23ztnJUHAfV+wvRJI2gGzSq6jy4zS24aZ78V pMq7MLD6DT3JO3xDP0iWI20cOGHAYWyLUGvXbhz7J/EzhgDp+lyD1k7OxFnfnmvITHH9sHboy+6UOp yoBk9JUdrlREtpkOW1dTB+ccbxX5mty+oObwqKNFxg2swWGfYWBrKTh4JLAhSKS52DsJ2mAnm1RZ74 wz695klm1H2vpPokqgfwgQxuRuMV1f3WnlW8KA/kksW5nYsBKvIJhpe/WsmeAvLNxNlKoSf5Q2x4QX RIKHPAHhilTgVnMPkNyUlzePqxQE1oB0x4JqyMqkz9AJz2Th7E+FpVI10AIjkd5H3ENi2HX1BPj8lB GfGc7y4TpsPEEmq2L51Sh6RUm9Sg/63dx4lG7ol6FdKJ8TFHRzr6O3jnWHFA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Cc: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <dschatzberg@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 67 ++++++++++++-------
 .../bpf/progs/verifier_global_subprogs.c      |  1 -
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..14bf64e0c600 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		 * Program types that don't rewrite ctx accesses can safely
 		 * dereference ctx pointers with fixed offsets.
 		 */
+		bool var_off_ok = resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL;
 		bool fixed_off_ok = !env->ops->convert_ctx_access;
 		struct bpf_retval_range range;
 		struct bpf_insn_access_aux info = {
@@ -7857,16 +7858,26 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
-		if (err < 0)
-			return err;
-
 		/*
 		 * Fold the register's constant offset into the insn offset so
-		 * that is_valid_access() sees the true effective offset.
+		 * that is_valid_access() sees the true effective offset. If the
+		 * register's offset is allowed to be variable, then the maximum
+		 * possible offset is simulated (which is equal to var_off.value
+		 * when var_off is constant).
 		 */
-		if (fixed_off_ok)
-			off += reg->var_off.value;
+		if (var_off_ok) {
+			err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
+			if (err)
+				return err;
+			off += reg->umax_value;
+		} else {
+			err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+			if (err < 0)
+				return err;
+			if (fixed_off_ok)
+				off += reg->var_off.value;
+		}
+
 		err = check_ctx_access(env, insn_idx, off, size, t, &info);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
@@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
+		if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL) {
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
@@ -9401,6 +9406,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MEM | MEM_RINGBUF,
 		PTR_TO_BUF,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_CTX,
 	},
 };
 
@@ -9710,6 +9716,17 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
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
@@ -10757,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			 * invalid memory access.
 			 */
 		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_CTX);
 			if (ret < 0)
 				return ret;
 			/* If function expects ctx type in BTF check that caller
@@ -13565,7 +13582,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 			fallthrough;
-		case KF_ARG_PTR_TO_CTX:
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -13583,6 +13599,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
+		case KF_ARG_PTR_TO_CTX:
+			arg_type = ARG_PTR_TO_CTX;
+			break;
 		default:
 			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 			return -EFAULT;
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

