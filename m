Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4D33D506
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304492; cv=none; b=AR9sUbWI0fR2lxU3IqKF+iNXOX5eS6pdoe/hcueC6GRJ6X7iP1eiSOVJk2Nc+sow6tCTIqlMDu5eE2tCXo1Pva8usj7rhvxpQ1FKlUm80GzJbWEc4SxZij91ctcsSzU08NqkW+aGjGJ7tfZvfVF9klQi2oCw2DPswVHy3S+jSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304492; c=relaxed/simple;
	bh=kMlPPo426nLOUgnR76NWL0V4DG8z7Mk/rAoYJWqi7OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJmd/YQARrpaZuhGR4SmqzRusZhr9aLA7An2eBKxje7BOlN/+ZWjZ9ACBRlBonV6F0bKROYXlehNIXNPQ9VDdMWRnHW+nMVYlMbPE4JMHvZHpp7BACxeCtsZ2lWVSAl3qbWWrZ5QMZhu0InwEZfqlbaOboLyz6lE9KQLy+zz3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=AJkVpa7u; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="AJkVpa7u"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a7bbe9d0so24999421cf.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772304489; x=1772909289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VVuYgrhmhTApRwCWEGLJFI2vuPFxDJZw/gcRpXkHns=;
        b=AJkVpa7uK0EZ8qZ/E6IcPoIra9VX+9i+PFhmNDmF21X/AV0auGHZahK5+HP9q6j0BL
         5iBLkCjN4+Y6BpE7j2WikretRjbq2dq83mWR7Vt+xHK7dtaId96I+xURU69YNIPHU6nK
         p+iWBo9akSpfEnbDbEG9PcvqEDE3kUguuOE/FvpZ9u/Z99gl20RC5SIgNuHyDoMPzpOn
         GlTxwOksS8NQM1jBBMdCUGrIM3u4+hfJO5GDKWeP/FPG6rUrzWzM3+wax/JfOndTjPvN
         xXo6srSOISQ7sbMMVrRJYHobjn17mPPHxpx6iYC8Pctx/UuNMmi9qqT/Ow11XvMyIPe7
         Fx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304489; x=1772909289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VVuYgrhmhTApRwCWEGLJFI2vuPFxDJZw/gcRpXkHns=;
        b=KHmdMo/Dn1hGOeb5HEI6J1lryxvZlU04bntWmfAXBVXeslu9fScsKvAUtcM1bhM2hD
         yrj5oXsRBcG8RWYR93VSHKUiGAHQtx4+mcrIzuN4xJvgHpKy+HSbS/Gm+c+GSlH2SIPl
         RMLZmOVBVwUJTZosxLAR8aHnzo/RCkN7f0CfRVWJG2vnspaBPw4pFhk3R/Wlezzwq9nT
         ODi0DRJ0CjfITSfPv+K3DYESvZml2HNayCS5hn85+mmXgQdhX6yKX+HccbciE4A6WE+5
         g0M6umGwuBuV030sQ/5Ofg3sJCveyqYlbqzJKiXXZv5d084AKsoNAaRF1Fir/SY1qkRI
         LQNw==
X-Gm-Message-State: AOJu0Yy6yxgpxOOGSlcsl5geeR4gWbnvI//bNUgBfSlFENvdx2SKxvpn
	2ata2Rl/Qa8tTII0y9+9D2cyDS+MH9mQRa2DKWHloWO+LIePjkm755DHMqed/EAgo+Nask7cX21
	EbcTG7Mg=
X-Gm-Gg: ATEYQzzc8khEVm8FGLBQHS3cZF/rL3XwWnY+aqG01qKpqsFsNBu48NDmCr6oUJUlWbP
	shGO1e3MiDMZZoTLph2WCgc3OGbHC5E5ck1xPrdyghgYR5XUz/iu8S1Ndo+qcy2V7wqzXSlLv6Y
	9/72+RD791aW6LuaMZtpMzBd6hInJFLH9AAm+vuNoIR5UKYJws6xKn27QS2LIpobHHIBBka4a4Q
	OoaFN6UdzuJGjjfV1W27/RmUwrIOarNkUsIByi/kQD7XwiNsAQcG1xfKzW0GS9jx4Cmq1YCeYep
	tCYR4NxiUDktpL+1DVXL90KcvAkUHVUj8qd8cN1rLXcsE7sIfO4bbwarcJx4EdrF4BBYq3uBGcM
	l9E7+N9XWwbiRrzlvhy/ZgyTNYBe2Md2Ikmb+M4DxSkyu44dW7gP4AwxWBL1PRRYB2Aw1X9nhRT
	qRyNm1hDzIjbWwL7vpewTe0g==
X-Received: by 2002:a05:622a:355:b0:4f1:ccdd:ffde with SMTP id d75a77b69052e-5075270a13bmr99517301cf.21.1772304489174;
        Sat, 28 Feb 2026 10:48:09 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d88sm76160561cf.21.2026.02.28.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:08 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 1/5] bpf: Factor out program return value calculation
Date: Sat, 28 Feb 2026 13:47:55 -0500
Message-ID: <20260228184759.108145-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228184759.108145-1-emil@etsalapatis.com>
References: <20260228184759.108145-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the return value range calculation logic in check_return_code
out of the function in preparation for separating the return value
validation logic for BPF_EXIT and bpf_throw().

No functional changes. The change made in return_retval_code's handling
of PROG_TRACING program types (not error'ing on the default case) is a
no-op because the match on the program attach type is exhaustive.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/verifier.c        | 226 +++++++++++++++++++----------------
 2 files changed, 126 insertions(+), 101 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1e30096ea7b..090aa26d1c98 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -265,6 +265,7 @@ struct bpf_reference_state {
 struct bpf_retval_range {
 	s32 minval;
 	s32 maxval;
+	bool return_32bit;
 };
 
 /* state of the program:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..0847d2b1fa5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2923,7 +2923,11 @@ static void init_reg_state(struct bpf_verifier_env *env,
 
 static struct bpf_retval_range retval_range(s32 minval, s32 maxval)
 {
-	return (struct bpf_retval_range){ minval, maxval };
+	/*
+	 * return_32bit is set to false by default and set explicitly
+	 * by the caller when necessary.
+	 */
+	return (struct bpf_retval_range){ minval, maxval, false };
 }
 
 #define BPF_MAIN_FUNC (-1)
@@ -11134,10 +11138,9 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
 
-static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg,
-				bool return_32bit)
+static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
 {
-	if (return_32bit)
+	if (range.return_32bit)
 		return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
 	else
 		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
@@ -11181,7 +11184,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return err;
 
 		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
-		if (!retval_range_within(callee->callback_ret_range, r0, false)) {
+		if (!retval_range_within(callee->callback_ret_range, r0)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
 					       "At callback return", "R0");
 			return -EINVAL;
@@ -17800,6 +17803,115 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
+
+static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+
+	/* Default return value range. */
+	*range = retval_range(0, 1);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+		switch (env->prog->expected_attach_type) {
+		case BPF_CGROUP_UDP4_RECVMSG:
+		case BPF_CGROUP_UDP6_RECVMSG:
+		case BPF_CGROUP_UNIX_RECVMSG:
+		case BPF_CGROUP_INET4_GETPEERNAME:
+		case BPF_CGROUP_INET6_GETPEERNAME:
+		case BPF_CGROUP_UNIX_GETPEERNAME:
+		case BPF_CGROUP_INET4_GETSOCKNAME:
+		case BPF_CGROUP_INET6_GETSOCKNAME:
+		case BPF_CGROUP_UNIX_GETSOCKNAME:
+			*range = retval_range(1, 1);
+			break;
+		case BPF_CGROUP_INET4_BIND:
+		case BPF_CGROUP_INET6_BIND:
+			*range = retval_range(0, 3);
+			break;
+		default:
+			break;
+		}
+		break;
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS)
+			*range = retval_range(0, 3);
+		break;
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_SOCK_OPS:
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		if (!env->prog->aux->attach_btf_id)
+			return false;
+		*range = retval_range(0, 0);
+		break;
+	case BPF_PROG_TYPE_TRACING:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
+			*range = retval_range(0, 0);
+			break;
+		case BPF_TRACE_RAW_TP:
+		case BPF_MODIFY_RETURN:
+			return false;
+		case BPF_TRACE_ITER:
+		default:
+			break;
+		}
+		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+		case BPF_TRACE_UPROBE_SESSION:
+			break;
+		default:
+			return false;
+		}
+		break;
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		*range = retval_range(SK_DROP, SK_PASS);
+		break;
+
+	case BPF_PROG_TYPE_LSM:
+		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
+			/* no range found, any return value is allowed */
+			if (!get_func_retval_range(env->prog, range))
+				return false;
+			/* no restricted range, any return value is allowed */
+			if (range->minval == S32_MIN && range->maxval == S32_MAX)
+				return false;
+			range->return_32bit = true;
+		} else if (!env->prog->aux->attach_func_proto->type) {
+			/* Make sure programs that attach to void
+			 * hooks don't try to modify return value.
+			 */
+			*range = retval_range(1, 1);
+		}
+		break;
+
+	case BPF_PROG_TYPE_NETFILTER:
+		*range = retval_range(NF_DROP, NF_ACCEPT);
+		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		*range = retval_range(0, 0);
+		break;
+	case BPF_PROG_TYPE_EXT:
+		/* freplace program can return anything as its return value
+		 * depends on the to-be-replaced kernel func or bpf program.
+		 */
+	default:
+		return false;
+	}
+
+	/* Continue calculating. */
+
+	return true;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -17808,18 +17920,17 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const bool is_subprog = frame->subprogno;
-	bool return_32bit = false;
 	const struct btf_type *reg_type, *ret_type = NULL;
+	int err;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
-				/* See below, can be 0 or 0-1 depending on hook. */
+				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
 				break;
 			if (!prog->aux->attach_func_proto->type)
 				return 0;
@@ -17877,101 +17988,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return 0;
 	}
 
-	switch (prog_type) {
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_RECVMSG ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETPEERNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
-		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
-			range = retval_range(1, 1);
-		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
-		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
-			range = retval_range(0, 3);
-		break;
-	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
-			range = retval_range(0, 3);
-			enforce_attach_type_range = tnum_range(2, 3);
-		}
-		break;
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_SOCK_OPS:
-	case BPF_PROG_TYPE_CGROUP_DEVICE:
-	case BPF_PROG_TYPE_CGROUP_SYSCTL:
-	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		break;
-	case BPF_PROG_TYPE_RAW_TRACEPOINT:
-		if (!env->prog->aux->attach_btf_id)
-			return 0;
-		range = retval_range(0, 0);
-		break;
-	case BPF_PROG_TYPE_TRACING:
-		switch (env->prog->expected_attach_type) {
-		case BPF_TRACE_FENTRY:
-		case BPF_TRACE_FEXIT:
-		case BPF_TRACE_FSESSION:
-			range = retval_range(0, 0);
-			break;
-		case BPF_TRACE_RAW_TP:
-		case BPF_MODIFY_RETURN:
-			return 0;
-		case BPF_TRACE_ITER:
-			break;
-		default:
-			return -ENOTSUPP;
-		}
-		break;
-	case BPF_PROG_TYPE_KPROBE:
-		switch (env->prog->expected_attach_type) {
-		case BPF_TRACE_KPROBE_SESSION:
-		case BPF_TRACE_UPROBE_SESSION:
-			range = retval_range(0, 1);
-			break;
-		default:
-			return 0;
-		}
-		break;
-	case BPF_PROG_TYPE_SK_LOOKUP:
-		range = retval_range(SK_DROP, SK_PASS);
-		break;
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
+		return 0;
 
-	case BPF_PROG_TYPE_LSM:
-		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* no range found, any return value is allowed */
-			if (!get_func_retval_range(env->prog, &range))
-				return 0;
-			/* no restricted range, any return value is allowed */
-			if (range.minval == S32_MIN && range.maxval == S32_MAX)
-				return 0;
-			return_32bit = true;
-		} else if (!env->prog->aux->attach_func_proto->type) {
-			/* Make sure programs that attach to void
-			 * hooks don't try to modify return value.
-			 */
-			range = retval_range(1, 1);
-		}
-		break;
+	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
+		enforce_attach_type_range = tnum_range(2, 3);
 
-	case BPF_PROG_TYPE_NETFILTER:
-		range = retval_range(NF_DROP, NF_ACCEPT);
-		break;
-	case BPF_PROG_TYPE_STRUCT_OPS:
-		if (!ret_type)
-			return 0;
-		range = retval_range(0, 0);
-		break;
-	case BPF_PROG_TYPE_EXT:
-		/* freplace program can return anything as its return value
-		 * depends on the to-be-replaced kernel func or bpf program.
-		 */
-	default:
+	if (!return_retval_range(env, &range))
 		return 0;
-	}
 
 enforce_retval:
 	if (reg->type != SCALAR_VALUE) {
@@ -17984,7 +18008,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (err)
 		return err;
 
-	if (!retval_range_within(range, reg, return_32bit)) {
+	if (!retval_range_within(range, reg)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (!is_subprog &&
 		    prog->expected_attach_type == BPF_LSM_CGROUP &&
-- 
2.49.0

