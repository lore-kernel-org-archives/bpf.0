Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2560DDA9
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820300; cv=none; b=DWP6832bA4r2A5jxoSkCBNpRKqr/I0cWzqV9DMBTl5ACRW7A3YemUaa5RZlGp5RPpBbim/9E4sSD8OiTC14B395PruJfhir1NEG8/I05McE56jHVnftUD3Cop8wTNaXlhPUD5rM5rHAlSxY9J6qRSFtnbXuwkRSNYOQR3uXHNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820300; c=relaxed/simple;
	bh=sI6rYbH26WJZhVc3yCl3ljSSwMgbjb1jhAZYx8HjX84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNA72fFnj1HkT43GBXTlOHU5ObrZukx0Kzy9NxRs/vf5no0syyEaa+2SAnYOw6lXw+ECUu1m8bGmVHExzTKAtbJuO3gyTX2T2Bcn6noPNx4yfXMn4Wy6rGPQxH8LaazeiuQqVWTZtyKEQLa4s+YBcaxtE7kG1uF/3u46SmRut0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJb/uKL4; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJb/uKL4"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-41706b23543so520355fac.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773820297; x=1774425097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwu6ui9njBZMnT9EDr5rlgN7Rx03bCTT/g9a5mqO4yo=;
        b=OJb/uKL4ExYFOBDkYZIsVEJxr42HU9++FrAUhaodsSqs+9bDWMspOiLPDP4XCE/qpa
         tl89Bqc+BjAeCGjwHlVU7lbDSLVmE/EJuyVgBQ6bglZ8VMNYbYI1BHvVZwDW3C9AH5q3
         cWO/u0pzUWTQz0XNVJQyUiVIIfdT1j/bsf0PISYS3hntnQXMNY+2mu8mzYihGK4VtAoo
         VP8t5Cf7saopwSFZ9Hbeua2ijpjydh5+DcjbqJ4cfRAZ9p5MOg1OGXT37srQG+ly5SVT
         GgPpKxOKimPYxjfAyBK+henIMfF9TJvP/FoAZMx80C7aY69EQve0yhtTCgxZ3giBIaYF
         L5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820297; x=1774425097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwu6ui9njBZMnT9EDr5rlgN7Rx03bCTT/g9a5mqO4yo=;
        b=G15ICve8RFxH7E6LPGjrLGOO5K/eeGqcGT9EO8aJwCR/qvdkf7UEkj+FEV81shv34C
         pm5Tk6TgnnzEmGCCI2U071I8d5Ojo8Lfpd31zaU1sxe+P63R+YdHBOSu/+DzCxFQDsnZ
         0ana8Irw5YmumbbOVN79p6xN+ivodj2qNtZCBPwrxsGFICCDJ52ZKyPNYRueHYwwb+Wz
         aI0+2RU7R1uR9ZjeM2cNG2dxCkenB8+9FJ5ckaS57IR4y/a7fpcKdjVn7RvWNvTyfeAl
         mw7mk9zzNyOvHoFR7PFen8BQenVPW3qxjvrwD1wMLDgDK/HVc4f1YBMak7+UGhtGQYhL
         8ZpA==
X-Gm-Message-State: AOJu0Yyvrc/r0mLfFMajKUk6rw5u3TmcThwi22/KI1SbolkTEF1rlacC
	i6bCYtSge+xKKkuF12bfzxJ6m81l90B/E0Pr2dQq1Tnn5FprbJ57Pirbpw5oau+LAa4=
X-Gm-Gg: ATEYQzyqfnmkqYlGeLcDUVvbBKl8KPJEDcjrbRb4EioOl0b9JT2coyaQHzljd5Jbljn
	iFEGUr7pM/XSb3bNZT4FxzU3jTl6sToKmWbHAUYyiE32Wo/j28myPvxMbvBN4JiyjNhy2II2EeV
	srfmGk2KdPUCBaDfyqYek8s0Lh1Ol/t2ryJRHhgbypeoOOshfGBrm7PR7V23FkXZnvO0J4XVgLB
	8mZk0lqR3qhLWp92SxxJoKF/eFNjWkIkd8VGYBruB9M0tk7IC+2RxO5pwzO3DEsxQqmKAMcKdUe
	azN02oX2jI0BmE2U8Ka0QZWpNlElHSRsXiyKBcMGjcMDxtBqjAU2TZCRhV6jMd8y8MRz+2OKaUc
	LvjK4T9z7JOzCzMNIATm/0rXlGUt0wEd5gSSnnw6U2XtP3N1pdV4v9FC72xslrpo74IXlQwoK96
	FTM48MDD4VQKQtdvyiUVLWQtCCg3CrcehL5aB64nkutqw232PG7M3JRw==
X-Received: by 2002:a05:6870:d6a0:b0:417:46cd:fa60 with SMTP id 586e51a60fabf-41bd2200b3dmr1838131fac.19.1773820297200;
        Wed, 18 Mar 2026 00:51:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2d4cc69sm2089099fac.18.2026.03.18.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:51:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
Date: Wed, 18 Mar 2026 00:51:31 -0700
Message-ID: <20260318075133.1031781-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318075133.1031781-1-memxor@gmail.com>
References: <20260318075133.1031781-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7887; h=from:subject; bh=sI6rYbH26WJZhVc3yCl3ljSSwMgbjb1jhAZYx8HjX84=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpullsOegabadXja13HlLJL1j7SCNdFmbkvbt/LMss gCC+dNmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabpZbAAKCRBM4MiGSL8RyvyPEA Cp8rmPYN6ufxm70T0leZzAFaR9ve411KKdnQFEzn0Y6aYU1/Ch3fajijd5TEnNpBlPIrQJXXqnoyyV xW1L3+RBPbr/4VLHuEwN+VnlJZyrQXQL2rMp9n+eG9MjHCFPPOvXsxRSJzMnoHN6a0RY2agcdtBIim ockP9Y77ncOYoCBTYAVRzCJIb9ZpihzfMYR5OwIYZt3pDBkI+SB+DWaSvy3wW5KgzNzYYJOBKel0UO KMraIsfB57Sz6yu0aGmVN6NIZBsuc7EI3/S98sM6/KAJ2KGpMF72JSBOCXK/nrn35IkMrSsHSqHU/Z KvlsmQQq3nkqP+c6qlzQNXIOMkYzqXiMOSHtSkz2EOyBC1JC5XR1w3HS/wrQFtwwJxNolCxpEPGBdC 5lpZ2W4hwIg2EAmlmgglmoB5ZSktaQAuEl6zgbu6hS2AQNGphoyDDjE0x00HjSgeYC1upSp/HPwCOI 2haY5pXWvl7CsB6duW03ZMjfg0nSOIQpTAyHYgz7NAmXIr9ukPfi+/q6Co1jBjDf/etwkxzUc8JrVk tfa2MksbPt0AoWvwDGlCxpqMZBCwi/sTU3qWzwfNh7ZsbsBpIttDuyVIj4beIxvYld9bMg+nrRA1GV h2Kt5Qxt1O7HyuECqh18kk1PeUAIX3E8seBlC8TVN3NBZ3qyU6cJhwNwi//A==
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
 kernel/bpf/verifier.c                         | 65 ++++++++++++-------
 .../bpf/progs/verifier_global_subprogs.c      |  1 -
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..dc4321c14647 100644
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
@@ -13566,6 +13583,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
+			arg_type = ARG_PTR_TO_CTX;
+			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
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

