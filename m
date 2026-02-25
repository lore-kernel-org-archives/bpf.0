Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DF2135C5
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990444; cv=none; b=e/AXlGPT61l8R/j3mCSU9W8/m1/+ZlGlTMF5qCHn3sbk9vIAQe6AqBCU7hx//pMys4CHRjfZQNlovZYbDvY3CiHooBMdAOHBabG0+hmNZpa2/6c8y/BtYIpTh2GpYMfVgCE0UYF1J66JHh51pUWhPHLhZ0Ap0gtJMagaUZsG1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990444; c=relaxed/simple;
	bh=oVHGFOahnXN3lSFkuL7j9wPOxiReOSjsf1THXCl3o+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgdUBsCgMmbklOoWaC6ja5dq2KfIC5RT9Vuf86l0ICPmr+2s8H1f4hVhfd9U7jhewctg7hzkvSoDD1zjxyi25OQticFf+1kQc7ZgNyp5rWYH25Pc2qZDY8ZYncP4SAGfyCyIhKME/we7xmHJCjfXD0+TAXEtEhRnfrh9GNKkP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gOS8R2pY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gOS8R2pY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb20bcff5aso642011985a.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771990441; x=1772595241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwDxYvkA42wOfSnw935+GKooDkGXchYjWRB6mhWRpPg=;
        b=gOS8R2pYqa1vvcmw9fvdj9CCie9YhVkAUVCBLIZqiwMYKvlg3XhGopPaODN2h4PMU9
         2pdDMWP/AWKc6gdpf38wqu2/JX2uZb1iw8fm3bj2ocznp2b+pNBpOUfBr+CqPuMswpNL
         VsRJ0+P/Ff62/8LAmzisriaM1pGcuEyG8nnwIsd33cYwBnG1KI/utekCy5KIWym9bkK5
         NlwpCL5lhC3JPdNx4m5sDGScn53Li5HSV8wV5JaH+hg/VpD3P/5P97poOtQll1DqMKEd
         g0MbrC+c05Ka3vaT5Cet9VmPw8y653KYGgOhm0v/UjoKqKI3o6t0yn+7sPHKWBuyG30a
         r3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990441; x=1772595241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwDxYvkA42wOfSnw935+GKooDkGXchYjWRB6mhWRpPg=;
        b=K84Ed/NTz/rD6k8H8zirdsNIoBqrtU5gNozrg9bWwcEYyA24zLk1df3eJN+Quvhiqt
         MB+jlE3X7aw4hG4xDTTpoHusBKfMO58f4llVCdafJgdtMywOqKMx5joOGJXO2fRWpDOU
         flIRV/fjRpmlLoq7kBmeajIbdTd6dWyzCR1iFohStH6KBS7IE1V8rcgimrTZvdxh6pEV
         v6qziwPH8Zvvgem3NEese1+sqQy/Bj27fPd1hFxrKk9pSawqZGvWQhT95+Oa3+1Z5kkF
         U+08295nk9rCYv/ychKjxmZf7J3Uq0TZ+ow1z0ZrPMdJIoeeEabGC4Xu3B9sGo+tFxBd
         /M2A==
X-Gm-Message-State: AOJu0YzspFBaIAHOSxPBw2zj1a5Jis/sBpIptHgx+7jydMuCYNRwEPvL
	B1gXJvQo7l9g6lFp6Wdjd/8fLEZP0i2Wf+oBBBpN/GjmfBAjUyA4Zv+rfre7CSMmhnp6aZ9atId
	SSoP6xKs=
X-Gm-Gg: ATEYQzzwGqPSyBOBZAAQg7wEHlfiErzK5L3YRtZAYDP/52Wqsy0T46uV3A/rtwfDuS6
	TK8SOJv1Cjl7tTaXNur38zSTQSz5ow+UWvBLNOXSrdisNy0B+QTnnixx8FdBv7VoZaS1R2dYLdW
	eM+xjJvQgjY7fIvYZPeR6ctQvvKz6AIm19vZPLPM9y/wSasSYxoN0+/uPcRfZObuVdMmy0hyJno
	JoGNZUaW4/oNhDUBHR2Tg8buICx9Tng8pkOSy8bNyU00DiQQuMbwe3BAU1NdWxnlssCo8q7G5cN
	qT6nml+b6VfY/5ydaaVHijNmzcyv+PCOTFftObeUhKWeVLHNUM4VrPrVmTuwy/aQ2/nrumYsWNi
	YLSE/qaMe6bk59+wRIazIxmmOwnqQ/lbaqlH0jgHEPCjhuaG1Uc6LQy+4peg1/Qvikg3VWm61dT
	TMtEMlsYjWtUZWnESqbqLwxA==
X-Received: by 2002:a05:620a:1a9a:b0:8ca:4545:aedc with SMTP id af79cd13be357-8cb8ca0e852mr1762926085a.36.1771990440997;
        Tue, 24 Feb 2026 19:34:00 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm112207986d6.44.2026.02.24.19.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:34:00 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/4] bpf: Factor out program return value calculation
Date: Tue, 24 Feb 2026 22:33:53 -0500
Message-ID: <20260225033356.518313-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260225033356.518313-1-emil@etsalapatis.com>
References: <20260225033356.518313-1-emil@etsalapatis.com>
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

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 205 +++++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 91 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..96ec27a36b32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17837,82 +17837,14 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
+
+static int return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range,
+		bool *return_32bit)
 {
-	const char *exit_ctx = "At program exit";
-	struct tnum enforce_attach_type_range = tnum_unknown;
-	const struct bpf_prog *prog = env->prog;
-	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	int err;
-	struct bpf_func_state *frame = env->cur_state->frame[0];
-	const bool is_subprog = frame->subprogno;
-	bool return_32bit = false;
-	const struct btf_type *reg_type, *ret_type = NULL;
-
-	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog || frame->in_exception_callback_fn) {
-		switch (prog_type) {
-		case BPF_PROG_TYPE_LSM:
-			if (prog->expected_attach_type == BPF_LSM_CGROUP)
-				/* See below, can be 0 or 0-1 depending on hook. */
-				break;
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-			break;
-		case BPF_PROG_TYPE_STRUCT_OPS:
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-
-			if (frame->in_exception_callback_fn)
-				break;
-
-			/* Allow a struct_ops program to return a referenced kptr if it
-			 * matches the operator's return type and is in its unmodified
-			 * form. A scalar zero (i.e., a null pointer) is also allowed.
-			 */
-			reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
-			ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
-							prog->aux->attach_func_proto->type,
-							NULL);
-			if (ret_type && ret_type == reg_type && reg->ref_obj_id)
-				return __check_ptr_off_reg(env, reg, regno, false);
-			break;
-		default:
-			break;
-		}
-	}
 
-	/* eBPF calling convention is such that R0 is used
-	 * to return the value from eBPF program.
-	 * Make sure that it's readable at this time
-	 * of bpf_exit, which means that program wrote
-	 * something into it earlier
-	 */
-	err = check_reg_arg(env, regno, SRC_OP);
-	if (err)
-		return err;
-
-	if (is_pointer_value(env, regno)) {
-		verbose(env, "R%d leaks addr as return value\n", regno);
-		return -EACCES;
-	}
-
-	if (frame->in_async_callback_fn) {
-		exit_ctx = "At async callback return";
-		range = frame->callback_ret_range;
-		goto enforce_retval;
-	}
-
-	if (is_subprog && !frame->in_exception_callback_fn) {
-		if (reg->type != SCALAR_VALUE) {
-			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
-				regno, reg_type_str(env, reg->type));
-			return -EINVAL;
-		}
-		return 0;
-	}
+	/* Default return value range. */
+	*range = retval_range(0, 1);
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -17925,16 +17857,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		    env->prog->expected_attach_type == BPF_CGROUP_INET4_GETSOCKNAME ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET6_GETSOCKNAME ||
 		    env->prog->expected_attach_type == BPF_CGROUP_UNIX_GETSOCKNAME)
-			range = retval_range(1, 1);
+			*range = retval_range(1, 1);
 		if (env->prog->expected_attach_type == BPF_CGROUP_INET4_BIND ||
 		    env->prog->expected_attach_type == BPF_CGROUP_INET6_BIND)
-			range = retval_range(0, 3);
+			*range = retval_range(0, 3);
 		break;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
-			range = retval_range(0, 3);
-			enforce_attach_type_range = tnum_range(2, 3);
-		}
+		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS)
+			*range = retval_range(0, 3);
 		break;
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 	case BPF_PROG_TYPE_SOCK_OPS:
@@ -17945,14 +17875,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		if (!env->prog->aux->attach_btf_id)
 			return 0;
-		range = retval_range(0, 0);
+		*range = retval_range(0, 0);
 		break;
 	case BPF_PROG_TYPE_TRACING:
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_TRACE_FSESSION:
-			range = retval_range(0, 0);
+			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
@@ -17967,40 +17897,37 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_KPROBE_SESSION:
 		case BPF_TRACE_UPROBE_SESSION:
-			range = retval_range(0, 1);
 			break;
 		default:
 			return 0;
 		}
 		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
-		range = retval_range(SK_DROP, SK_PASS);
+		*range = retval_range(SK_DROP, SK_PASS);
 		break;
 
 	case BPF_PROG_TYPE_LSM:
 		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
 			/* no range found, any return value is allowed */
-			if (!get_func_retval_range(env->prog, &range))
+			if (!get_func_retval_range(env->prog, range))
 				return 0;
 			/* no restricted range, any return value is allowed */
-			if (range.minval == S32_MIN && range.maxval == S32_MAX)
+			if (range->minval == S32_MIN && range->maxval == S32_MAX)
 				return 0;
-			return_32bit = true;
+			*return_32bit = true;
 		} else if (!env->prog->aux->attach_func_proto->type) {
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
 			 */
-			range = retval_range(1, 1);
+			*range = retval_range(1, 1);
 		}
 		break;
 
 	case BPF_PROG_TYPE_NETFILTER:
-		range = retval_range(NF_DROP, NF_ACCEPT);
+		*range = retval_range(NF_DROP, NF_ACCEPT);
 		break;
 	case BPF_PROG_TYPE_STRUCT_OPS:
-		if (!ret_type)
-			return 0;
-		range = retval_range(0, 0);
+		*range = retval_range(0, 0);
 		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
@@ -18010,6 +17937,102 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return 0;
 	}
 
+	/* Continue calculating. */
+
+	return 1;
+}
+
+static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
+{
+	const char *exit_ctx = "At program exit";
+	struct tnum enforce_attach_type_range = tnum_unknown;
+	const struct bpf_prog *prog = env->prog;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_retval_range range = retval_range(0, 1);
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+	int ret, err;
+	struct bpf_func_state *frame = env->cur_state->frame[0];
+	const bool is_subprog = frame->subprogno;
+	bool return_32bit = false;
+	const struct btf_type *reg_type, *ret_type = NULL;
+
+	/* LSM and struct_ops func-ptr's return type could be "void" */
+	if (!is_subprog || frame->in_exception_callback_fn) {
+		switch (prog_type) {
+		case BPF_PROG_TYPE_LSM:
+			if (prog->expected_attach_type == BPF_LSM_CGROUP)
+				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
+				break;
+			if (!prog->aux->attach_func_proto->type)
+				return 0;
+			break;
+		case BPF_PROG_TYPE_STRUCT_OPS:
+			if (!prog->aux->attach_func_proto->type)
+				return 0;
+
+			if (frame->in_exception_callback_fn)
+				break;
+
+			/* Allow a struct_ops program to return a referenced kptr if it
+			 * matches the operator's return type and is in its unmodified
+			 * form. A scalar zero (i.e., a null pointer) is also allowed.
+			 */
+			reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+			ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
+							prog->aux->attach_func_proto->type,
+							NULL);
+			if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+				return __check_ptr_off_reg(env, reg, regno, false);
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* eBPF calling convention is such that R0 is used
+	 * to return the value from eBPF program.
+	 * Make sure that it's readable at this time
+	 * of bpf_exit, which means that program wrote
+	 * something into it earlier
+	 */
+	err = check_reg_arg(env, regno, SRC_OP);
+	if (err)
+		return err;
+
+	if (is_pointer_value(env, regno)) {
+		verbose(env, "R%d leaks addr as return value\n", regno);
+		return -EACCES;
+	}
+
+	if (frame->in_async_callback_fn) {
+		exit_ctx = "At async callback return";
+		range = frame->callback_ret_range;
+		goto enforce_retval;
+	}
+
+	if (is_subprog && !frame->in_exception_callback_fn) {
+		if (reg->type != SCALAR_VALUE) {
+			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
+				regno, reg_type_str(env, reg->type));
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
+		return 0;
+
+	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
+		enforce_attach_type_range = tnum_range(2, 3);
+
+	ret = return_retval_range(env, &range, &return_32bit);
+	if (ret < 0)
+		return ret;
+
+	/* Check if we even need to validate. */
+	if (!ret)
+		return ret;
+
 enforce_retval:
 	if (reg->type != SCALAR_VALUE) {
 		verbose(env, "%s the register R%d is not a known value (%s)\n",
-- 
2.49.0

