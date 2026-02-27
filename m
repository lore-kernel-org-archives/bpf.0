Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05221D585
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207184; cv=none; b=V8RTmvJyVVHhhy4SJxNpGGkGuTtC2bCAuGbi17IQj8VsteOMznR8QGtyubMV985vtUOmiKO7bwyRpGYuWxhlQ0mD02uj7AvwFwuRwDrgEfeVgvmIQBAijTA/a0eeuGD0rNB7cv28YcD7wzhH8BX9HFsD4L2AGu6fX3VG/Y3ke+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207184; c=relaxed/simple;
	bh=q3zeTGKSyOUV6fqIlAI+NRbt3Ag2bqZBrG7bVblAeo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGVZBlfpcE+VcYahE8CZTSQPARzrPTX1RLUdhBaiOU/czkWbNc4SdX2XVONDInAzlOTLcJGRDW/iQhuaYlQv9EiBaQfj0EK+Ynh8BSjTyU9Gk7w5VCPyjOXqXYj3aQec/uYchVXLNbdr5P+D4ELE2tnyBcwTsgLwsrPq6Ck/E7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=2rx5yGbB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="2rx5yGbB"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a917a4feso36025736d6.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207182; x=1772811982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uezZmXXOPTD2SjcSQj5hqu/DFsEFnL3l6cRHMmFshso=;
        b=2rx5yGbBJ2MKszCTb6r7SQQDRhzFwjRiiGB3CEt+jQFflsIQWadRjqSkaAXiGiYGCH
         DHESLpnArfhf8/2mgMAf9PRc/7nWppPdO0VKxVTo3wIUsIBkapsvwiEtta6cIHGG0U9X
         tW58tPh11rLfW4+ntDHOLeAh/cmXx6L6Lcq4p5gKcq7CiXtMPncn5cjMzU5kVDdrP9CK
         2QvzgKKLiz65ZZ1nkJj2OijqWq1Oz3K0PxaXTNxZHPDCql8bGeT72KQ3SplOSC7Wr44w
         VtS1BXuHTTBbAEKx1O53UFCCyxtfCdAMQtW6Ds7n5VoyP5p9spikkD5VnYzZ3RGLO2Gm
         /qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207182; x=1772811982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uezZmXXOPTD2SjcSQj5hqu/DFsEFnL3l6cRHMmFshso=;
        b=kqGHgpAsY/9Q5/5lJh2Fg+3c7tF6+oEHzpc1y5n1JEarbXZ+5/1sKtVcLxfXUXG70X
         Mz68sCVt1LexTdTFRnElJTAChhge2X1q98KgMhnGzdPo9I1GMcDRpn7yWKNzcbPIa8D2
         t8SD+gEFA9yrR8DtypJ2kSNLReMNfiE4U3tZPO+S1B8WU43931h5UbZMU29SgYTVJ4i2
         Irpv7l8nM3KmZefogF1G47lWxXmth3vcZC3myX+t9yVt4CYdu9yQsHyt/XeJmOraErzJ
         SY3IU+ssEazW5ntLC8wCNefaix+txSzUOOk0hs14Kc6q3Rfmq2IBsQqqDbByFb7XE/xX
         rCdg==
X-Gm-Message-State: AOJu0YzRD4uJsZt9L3a00nmNKL8JSC1o0TjoJUfK+y/RIb+u3YHcNPg0
	rMs68Hnf/ML+ASO2M2OA/JLHSYYip2s6g3P3hUp0Z/zpTV9s6K+uYFhUol6HNja/Iu9x98Bsvbl
	4ALMEEAM=
X-Gm-Gg: ATEYQzzhyWyo8oud7EUJI2st+JviZ3dM6jZLpsK1y0GUelqubl0IaM/L5AUUgZnDMdU
	iWeXmS2x80oXAsaHq6X1rN317egscFv5MXSX+IsWKI0/pPW4JqhKaLT2Op/VF7DcTwS0R2zNnPY
	FYsX+9Im/Csla+hN0KHug3mfFAU6s04wuUWfWpmXrSqlZ16i/WskoSW1ObdveJmGCTRsvHDa8om
	7/clRptgMEQpO3KExAlX1BayvEF1ntNBJaeu5uPhBtqwi0KQZUn5J9iSE4hiokzzagdx0iIfOBF
	3AVkVDp7VfmYZPDCLNg033zzgyJvzHgA5Bwo+tDbwKm9kizz5jpuRdukmgdUt1KcKHadyh9f1sV
	/4w1n6WpYdff0ooxBrpGvO2T2WCRbBGWr6ErVF65eCEdoIuTjrwKAqgilEMVcncDQUHTFwC93jY
	rGwNFD5gAT21plSN8dONhw9Q==
X-Received: by 2002:a05:6214:c63:b0:890:2480:f02e with SMTP id 6a1803df08f44-899d1dbcd78mr46812836d6.28.1772207181777;
        Fri, 27 Feb 2026 07:46:21 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm544180385a.4.2026.02.27.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:46:21 -0800 (PST)
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
Subject: [PATCH bpf-next v5 3/5] bpf: extract check_subprogram_return_code() for clarity
Date: Fri, 27 Feb 2026 10:46:14 -0500
Message-ID: <20260227154616.6846-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260227154616.6846-1-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Both main progs and subprogs use the same function in the verifier,
check_return_code, to verify the type and value range of the register
being returned. However, subprogs only need a subset of the logic in
check_return_code. this also goes the way - check_return_code explicitly
checks whether it is handling a subprogram in multiple places, complicating
the logic. Separate the handling of the two into separate fucntions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 65 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b49f1a6e8dc..fb4d14516043 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17979,19 +17979,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	int ret, err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
-	const bool is_subprog = frame->subprogno;
-	bool return_32bit = false;
 	const struct btf_type *reg_type, *ret_type = NULL;
+	int ret, err;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
-	if (!is_subprog || frame->in_exception_callback_fn) {
-		if (program_returns_void(env))
-			return 0;
-	}
+	if (!frame->in_async_callback_fn && program_returns_void(env))
+		return 0;
 
-	if (!is_subprog && prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
 		/* Allow a struct_ops program to return a referenced kptr if it
 		 * matches the operator's return type and is in its unmodified
 		 * form. A scalar zero (i.e., a null pointer) is also allowed.
@@ -18025,15 +18021,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		goto enforce_retval;
 	}
 
-	if (is_subprog && !frame->in_exception_callback_fn) {
-		if (reg->type != SCALAR_VALUE) {
-			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
-				regno, reg_type_str(env, reg->type));
-			return -EINVAL;
-		}
-		return 0;
-	}
-
 	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
 		return 0;
 
@@ -18056,8 +18043,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	if (!retval_range_within(range, reg)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
-		if (!is_subprog &&
-		    prog->expected_attach_type == BPF_LSM_CGROUP &&
+		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
 		    prog_type == BPF_PROG_TYPE_LSM &&
 		    !prog->aux->attach_func_proto->type)
 			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
@@ -18070,6 +18056,29 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	return 0;
 }
 
+static int check_subprogram_return_code(struct bpf_verifier_env *env)
+{
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
+	int err;
+
+	err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+	if (err)
+		return err;
+
+	if (is_pointer_value(env, BPF_REG_0)) {
+		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
+		return -EACCES;
+	}
+
+	if (reg->type != SCALAR_VALUE) {
+		verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
+			reg_type_str(env, reg->type));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
@@ -20865,6 +20874,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state,
 				 bool exception_exit)
 {
+	struct bpf_func_state *cur_frame = cur_func(env);
+
 	/* We must do check_reference_leak here before
 	 * prepare_func_exit to handle the case when
 	 * state->curframe > 0, it may be a callback function,
@@ -20898,7 +20909,21 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return 0;
 	}
 
-	err = check_return_code(env, BPF_REG_0, "R0");
+	/*
+	 * Return from a regular global subprogram differs from return
+	 * from the main program or async/exception callback.
+	 * Main program exit implies return code restrictions
+	 * that depend on program type.
+	 * Exit from exception callback is equivalent to main program exit.
+	 * Exit from async callback implies return code restrictions
+	 * that depend on async scheduling mechanism.
+	 */
+	if (cur_frame->subprogno &&
+	    !cur_frame->in_async_callback_fn &&
+	    !cur_frame->in_exception_callback_fn)
+		err = check_subprogram_return_code(env);
+	else
+		err = check_return_code(env, BPF_REG_0, "R0");
 	if (err)
 		return err;
 	return PROCESS_BPF_EXIT;
-- 
2.49.0

