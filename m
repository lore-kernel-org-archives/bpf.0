Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1242848BE
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990445; cv=none; b=rSFP149R3XT0WUWPjCtJwdEsC6bjKv8+Pp4ZWeB5S2XqyqWRQb0SiAQyZnHkZP+LW7MZMWq8eHkoIqvGPDSdEPYAWlheOCkHiEI5Ezm8dJfHjO08vY8qgc+y8/nuD7qoC/NGoTlXh8HzJi1W6ml2JdbmtgpsSnaW5SH1ygEfYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990445; c=relaxed/simple;
	bh=a0SnQbTJ1wfk2vsqrXVX+uU7t6ICGSPMwkm9YvghOPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFMJN2OBCSeqYLRUoaFaF/YTQfKHe9CFA5aM7VjAH7HgjSQ8EZj2CblGzrhDmxps6o1FlFd1v0vmAzNKuHH/ouUhlVvNeao4E1ZHPZRCDPsxIWT4GvgrsqGl12vZrWlGfD250fc7ova5d3zR1gSZXl7DSyylb54MWFMKs/MDvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Qf4R02EK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Qf4R02EK"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899b95707afso3210126d6.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771990442; x=1772595242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJkCS2gaoI323ZVf8ecqRQqDnlqHT3ZgGVk+6yfZNrs=;
        b=Qf4R02EK/feQQ58sABnTqNSfiY+nIjWYqpExNJrlIq7/FfutIkVko2lUAg6AKFnYk+
         HrQRwuYaxyLoiJHFSobpC2eoFU9kj1QTnwbvR23ojN7IWybDmmfVQFVyOPkLdSZzrZNi
         +3Bz8iGkBs790UiyqT/uyYZLlmZOK85gRK4OB2w+/mVNq+iVC2iWLJSppkBL+cKgPfgS
         gqyE7LCoWqKy5ia9fVFyucGG8Cclz0Kea32vuTe4vBcbEZDQCHET+3wdptJUL7ofLuUv
         qx229Vxb0QxdsdWqDqpclJbynuezgbzddHzLHxMH9ZDNtUkHQGVNdu1SNv8fljg+Ypg7
         sveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990442; x=1772595242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJkCS2gaoI323ZVf8ecqRQqDnlqHT3ZgGVk+6yfZNrs=;
        b=ec1MFgPv0yI753lIfu1RU409wt1hSQS2lL2b9/AVIItlct9fYb5dN5Zn3Pn0+ffDID
         VFVbp1foOvgMhpRdcvRckEiNY2erY+/oMH5sSBPdEpys9hQbxe2MZII4M9BsXU/RtbI5
         pqvn2Jq2uvHBqMCRguK01DoqxxSBVYAzOOBxiO5UvsCx287krqO0FA1YHQfkO0yoaui2
         R4x4wYiRxHq1XCD+xf7Oj/yMohJnXi2VL/lKcpAZ6+I5Ym0KqZr12ys43PsijIJKBYgq
         adrY7ZuUGZWge5OxHnhj97Wr0T2ZVLM4J0yjQ6QFsXwGGGWFZX7u+l6TnDrG20jAj7QJ
         1MbA==
X-Gm-Message-State: AOJu0YyEtJRDTyudt2Crzyc5s8u7tDqxyfPk4qRnizB+dKp/4y94HKNC
	JXbOTUnUVSuBaC46K1bPbtIqyU0O0dZJRnRhn8FMoChf8Q06x17+O+KYIZ6YS4//mvWGdV/hbVA
	JaChk+JI=
X-Gm-Gg: ATEYQzxfZ3eIrjEa/bN8eQr+G1cuOSa074ozQW5Zwki6Aflyf0EhwvOipboHYfAVPsH
	mEhN/lYgZcJIIEkG9tuw3Rw6Lps3tMnQauYCxb6dMZgAAa7PKVLnV8qG1HUdjypNLXQKQHSrBmq
	nQcrbaBRMkmqr18V8LpvxT828laWzel52wSr4Yi5z5KmZJYRmg/zkhwQjg53+rZQVI1LJvMgHXQ
	N9OMStv0c50cMZvZCoa3OefyofRG8MT5a89v4s+jYovzBuH2efruj2F3FlKVdFMy6O2RB3fSZjH
	Sp2IynCL2BbL2uNO3BiJ/Mo67VsuoW7rbvdUkLGFBpXOsQEntzI3EKICWiUaByhy2/DfJXTYrlb
	8YR+IkQr9ftPzHWTi19oWTGBPq2M7k0RSGCrPBwfN8gFrtjXG4WExJtAifpMLkwDpIbxCnTHdlz
	K+QDwNhqA1MR8AhIEsM5Ioxg==
X-Received: by 2002:a05:6214:4111:b0:894:757d:25f6 with SMTP id 6a1803df08f44-89979d65078mr201999086d6.49.1771990442245;
        Tue, 24 Feb 2026 19:34:02 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm112207986d6.44.2026.02.24.19.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:34:02 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/4] bpf: Separate bpf_throw() and bpf_exit() return value validation
Date: Tue, 24 Feb 2026 22:33:54 -0500
Message-ID: <20260225033356.518313-3-emil@etsalapatis.com>
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

Both bpf_throw() and BPF_EXIT use the same return value validation
function, even though their validation logic is slightly different.
Using the same code path for both complicates the logic and makes
it difficult to follow, so create a new check_throw_return_code()
function just for bpf_throw()-based exits. Also factor code needed
for both functions out of check_return_code().

No functional changes.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 120 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 99 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96ec27a36b32..8ed5060f6ea8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14029,7 +14029,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 	return 1;
 }
 
-static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
+static int check_throw_return_code(struct bpf_verifier_env *env);
+static int check_return_code(struct bpf_verifier_env *env);
 
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
@@ -14257,7 +14258,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		 * to bpf_throw becomes the return value of the program.
 		 */
 		if (!env->exception_callback_subprog) {
-			err = check_return_code(env, BPF_REG_1, "R1");
+			err = check_throw_return_code(env);
 			if (err < 0)
 				return err;
 		}
@@ -17942,12 +17943,98 @@ static int return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_r
 	return 1;
 }
 
-static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
+static void
+maybe_enforce_expected_attach_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	struct tnum enforce_attach_type_range;
+	struct bpf_prog *prog = env->prog;
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+
+	/* Throw or not throw, still limit the attach type. */
+	if (prog_type != BPF_PROG_TYPE_CGROUP_SKB || prog->expected_attach_type != BPF_CGROUP_INET_EGRESS)
+		return;
+
+	enforce_attach_type_range = tnum_range(2, 3);
+
+	if (tnum_in(enforce_attach_type_range, reg->var_off))
+		prog->enforce_expected_attach_type = 1;
+}
+
+static int
+check_retval_is_bounded(struct bpf_verifier_env *env, struct bpf_retval_range range, struct bpf_reg_state *reg,
+		const char *reg_name, bool return_32bit, bool is_subprog, const char *exit_ctx)
+{
+	const struct bpf_prog *prog = env->prog;
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+
+	if (retval_range_within(range, reg, return_32bit))
+		return 0;
+
+	verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
+	if (!is_subprog &&
+		prog->expected_attach_type == BPF_LSM_CGROUP &&
+		prog_type == BPF_PROG_TYPE_LSM &&
+		!prog->aux->attach_func_proto->type)
+		verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
+
+	return -EINVAL;
+}
+
+static int check_throw_return_code(struct bpf_verifier_env *env)
 {
 	const char *exit_ctx = "At program exit";
-	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
-	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_1);
+	struct bpf_retval_range range = retval_range(0, 1);
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+	struct bpf_func_state *frame = env->cur_state->frame[0];
+	const bool is_subprog = frame->subprogno;
+	bool return_32bit = false;
+	int err, ret;
+
+	/* 
+	 * BPF_LSM_CGROUP LSM programs must not modify the return value of a void program
+	 * (see the logic in return_retval_range()).
+	 */
+	if (prog_type == BPF_PROG_TYPE_LSM && prog->expected_attach_type != BPF_LSM_CGROUP &&
+			!prog->aux->attach_func_proto->type)
+		return 0;
+
+	ret = return_retval_range(env, &range, &return_32bit);
+	if (ret < 0)
+		return ret;
+
+	/* 
+	 * Specifically for STRUCT_OPS programs, we never need
+	 * to validate the cookie.
+	 */
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS)
+		return 0;
+
+	/* Check if we even need to validate. */
+	if (!ret)
+		return ret;
+
+	err = mark_chain_precision(env, BPF_REG_1);
+	if (err)
+		return err;
+
+	err = check_retval_is_bounded(env, range, reg, "R1", 
+		return_32bit, is_subprog, exit_ctx);
+	if (err)
+		return err;
+
+	maybe_enforce_expected_attach_type(env, reg);
+
+	return 0;
+}
+
+static int check_return_code(struct bpf_verifier_env *env)
+{
+	const int regno = BPF_REG_0;
+	const char *exit_ctx = "At program exit";
+	const struct bpf_prog *prog = env->prog;
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
 	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int ret, err;
@@ -18022,9 +18109,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS && !ret_type)
 		return 0;
 
-	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
-		enforce_attach_type_range = tnum_range(2, 3);
-
 	ret = return_retval_range(env, &range, &return_32bit);
 	if (ret < 0)
 		return ret;
@@ -18044,19 +18128,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (err)
 		return err;
 
-	if (!retval_range_within(range, reg, return_32bit)) {
-		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
-		if (!is_subprog &&
-		    prog->expected_attach_type == BPF_LSM_CGROUP &&
-		    prog_type == BPF_PROG_TYPE_LSM &&
-		    !prog->aux->attach_func_proto->type)
-			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
-		return -EINVAL;
-	}
+	err = check_retval_is_bounded(env, range, reg, "R0",
+		return_32bit, is_subprog, exit_ctx);
+	if (err)
+		return err;
+
+	maybe_enforce_expected_attach_type(env, reg);
 
-	if (!tnum_is_unknown(enforce_attach_type_range) &&
-	    tnum_in(enforce_attach_type_range, reg->var_off))
-		env->prog->enforce_expected_attach_type = 1;
 	return 0;
 }
 
@@ -20888,7 +20966,7 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return 0;
 	}
 
-	err = check_return_code(env, BPF_REG_0, "R0");
+	err = check_return_code(env);
 	if (err)
 		return err;
 	return PROCESS_BPF_EXIT;
-- 
2.49.0

