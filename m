Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EC441041
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207185; cv=none; b=nu8wCuA23mfvfBKInQ+lCv/DF7PGsfJBuagfoo7olYo3ILY8D3MK/sMalzGGBz0Cao0+gN4OTSymN83Bzdb7F6HppwjowTA03VCz3s3ETTON4dX6Rca4hSK/gnqkt64IrKT2ex+yb4hrVfbG1yB2YBCw1lIpka+wuls12WGtdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207185; c=relaxed/simple;
	bh=zCNwjpcwoMooLZa43Jy76nkcjNChRFhWGVi0LRmeXwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLYbUxbT+JmCgpyRIn0JzMsDvjzVYwXzvlJJdP7pLt+lsEunXXFtTLzzEYeOJPH3d6RyaTjO2lLVAE4SK387fU66gDDxQt0KRdVAfdqh+2TUDMxFZ6N4SEDyQ1Z+/+nO0QSLDkmzVSBqO6V/02Yl7g4HJoPFu81MbqXCSvDbI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=d+Pxvnr0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="d+Pxvnr0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c9f6b78ca4so274206485a.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207182; x=1772811982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YvNlRKv0L27n2l28AMEGHqcCg83we8CeKw8iVeXoeA=;
        b=d+Pxvnr0hsuOLrRbGMtaSFi+o4YlX1EdbmH2wdBCO0cXxrz5CAFUUIkhAJNvnsG+49
         9W4XTnZ1KyTRiWniLQ9yz3vIx1XZeyS1eMMv8s6j7tQD8OdNo1/Rc7NKRxYhqRwVaUae
         dvjld4KMOJmBAtA5hI1/tK4dvUgo2aZa12Xcq7MKiVI/wqIeRDxa5EjXSraVEfo1BMJ4
         sIg0Yus8eRj3In+y/oamsZ/e9aeW09ynFk8V+/9ryTOp2d2yHJqazGU7vD67p5qp6BiN
         0OeVn9cEg7iGHEvONUyKy4wGvH0uitpKXjydZ6VuSpMo/6sYY8ZJ1kMEpGvtc8jI7r/o
         CtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207182; x=1772811982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YvNlRKv0L27n2l28AMEGHqcCg83we8CeKw8iVeXoeA=;
        b=k8i82S0Mo/EERXYRC8OTbkkf4H3MdghO+n8bzScrO5quKRTvzv5ofwHYqGazdl2wuB
         vn6Jy3JFfyVxlXFoy77Ku6tEJFV8rMv2wt6WS/A+c3vi5dr8dzNBaImNSB8vCQcXx7vI
         AkXeh4lYosA3Pamx4WIcNSTIARFwpXxyXQWyYV8n/5ylmeBFcoH787AW4Tksf+NHrYOo
         m833HH3vwbNihcM0eZfK+XRkyL97k3Phnoheoxo9qGPh2937o583rSooQ5Eu+gh6Tt0Y
         EqkNbX7VZ4pgk8sAtrJ0iVzMYHOqN+KV7wpQBfy6gV3va8o3ADbLT2BQrNzc3t/InY5F
         b5Xg==
X-Gm-Message-State: AOJu0YwuBGGNFDovzDGLFgHfSLdw6zTjpyMeUNARZpfdhm3QaFKTLcmf
	1p8P+8wSSayaxkhGwL3QlmwWykFgNLAHqgLbvIIG9NKXg2mBhmG6jq/waQ+i2D4wxAbKd+yxxSr
	hNH1+hjg=
X-Gm-Gg: ATEYQzxPbZKF9kGzEb80g9I76tkiMQHS0RZkVovZwtAQcVkudkpHyd2PpxIWE8gwSx5
	dMNCGEFQwT66X9WHu59kaF83vqBrynQTkAMJET5fjVVDAbJRsodQ3OP9vJNR2bXvX5wbd3jgHvm
	JqziPXpzz0fKtN35DuCyseIdHpaSWNTtODlvf5TmmXJW6f5h7CkqsaQ1YwXITZHuBZv4ZcLbJji
	eXCw1YloPbhEds8PoUOZSC9Y15NCiYWwXB9vO2/dmBr9g36GaAXAAdldOc6RJt0uKAEFcwfF2xc
	zoEFdRnRrwY4wmiae53htJcZ2OXDVNTiDQ2CG7QqT/NeQCdgDpVcjc35buVuEYaAc5LYVJz0XFE
	NGJKBUgp77DXVMFCQKUZyL7fQgpy7E43PHH2/20h2w7rz8KCcSECst10m46YBODWUwmTjIF8LH2
	p9ftTdI5SEeaWNPzXGdink7K/DtXkFKCtl
X-Received: by 2002:a05:620a:410a:b0:8c9:f996:81fd with SMTP id af79cd13be357-8cbc8df3b87mr408516685a.33.1772207182373;
        Fri, 27 Feb 2026 07:46:22 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm544180385a.4.2026.02.27.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:46:22 -0800 (PST)
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
Subject: [PATCH bpf-next v5 4/5] bpf: Allow void global functions in the verifier
Date: Fri, 27 Feb 2026 10:46:15 -0500
Message-ID: <20260227154616.6846-5-emil@etsalapatis.com>
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

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c                              |  7 +-
 kernel/bpf/verifier.c                         | 64 ++++++++++++++++---
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7708958e3fb8..51f8d3dece5d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7836,15 +7836,16 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function returns int, exception cb also requires this */
+	/* check that function is void or returns int, exception cb also requires this */
 	t = btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_int(t) && !btf_is_any_enum(t)) {
+	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)) {
 		if (!is_global)
 			return -EINVAL;
 		bpf_log(log,
-			"Global function %s() doesn't return scalar. Only those are supported.\n",
+			"Global function %s() return value not void or scalar. "
+			"Only those are supported.\n",
 			tname);
 		return -EINVAL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb4d14516043..702b3583cd78 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -444,6 +444,29 @@ static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
 }
 
+static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
+{
+	const struct btf_type *type, *func, *func_proto;
+	const struct btf *btf = env->prog->aux->btf;
+	u32 btf_id;
+
+	btf_id = env->prog->aux->func_info[subprog].type_id;
+
+	func = btf_type_by_id(btf, btf_id);
+	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
+		return false;
+
+	func_proto = btf_type_by_id(btf, func->type);
+	if (!func_proto)
+		return false;
+
+	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
+	if (!type)
+		return false;
+
+	return btf_type_is_void(type);
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info *info;
@@ -10861,9 +10884,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		subprog_aux(env, subprog)->called = true;
 		clear_caller_saved_regs(env, caller->regs);
 
-		/* All global functions return a 64-bit SCALAR_VALUE */
-		mark_reg_unknown(env, caller->regs, BPF_REG_0);
-		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
+		if (!subprog_returns_void(env, subprog)) {
+			mark_reg_unknown(env, caller->regs, BPF_REG_0);
+			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+		}
 
 		/* continue with next insn after call */
 		return 0;
@@ -17952,7 +17977,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 static bool program_returns_void(struct bpf_verifier_env *env)
 {
 	const struct bpf_prog *prog = env->prog;
-	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum bpf_prog_type prog_type = prog->type;
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_LSM:
@@ -17965,6 +17990,16 @@ static bool program_returns_void(struct bpf_verifier_env *env)
 		if (!prog->aux->attach_func_proto->type)
 			return true;
 		break;
+	case BPF_PROG_TYPE_EXT:
+		/*
+		 * If the actual program is an extension, let it
+		 * return void - attaching will succeed only if the
+		 * program being replaced also returns void, and since
+		 * it has passed verification its actual type doesn't matter.
+		 */
+		if (subprog_returns_void(env, 0))
+			return true;
+		break;
 	default:
 		break;
 	}
@@ -17981,7 +18016,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const struct btf_type *reg_type, *ret_type = NULL;
-	int ret, err;
+	int err;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!frame->in_async_callback_fn && program_returns_void(env))
@@ -18059,8 +18094,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 static int check_subprogram_return_code(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
+	struct bpf_func_state *cur_frame = cur_func(env);
 	int err;
 
+	if (subprog_is_global(env, cur_frame->subprogno) &&
+	    subprog_returns_void(env, cur_frame->subprogno))
+			return 0;
+
 	err = check_reg_arg(env, BPF_REG_0, SRC_OP);
 	if (err)
 		return err;
@@ -24560,10 +24600,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 		if (subprog_is_exc_cb(env, subprog)) {
 			state->frame[0]->in_exception_callback_fn = true;
-			/* We have already ensured that the callback returns an integer, just
-			 * like all global subprogs. We need to determine it only has a single
-			 * scalar argument.
+
+			/*
+			 * Global functions are scalar or void, make sure
+			 * we return a scalar.
 			 */
+			if (subprog_returns_void(env, subprog)) {
+				verbose(env, "exception cb cannot return void\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
+			/* Also ensure the callback only has a single scalar argument. */
 			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_ANYTHING) {
 				verbose(env, "exception cb only supports single integer argument\n");
 				ret = -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 8a0fdff89927..d28ecc4ee2d0 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -51,7 +51,7 @@ __noinline int exception_cb_ok_arg_small(int a)
 
 SEC("?tc")
 __exception_cb(exception_cb_bad_ret_type)
-__failure __msg("Global function exception_cb_bad_ret_type() doesn't return scalar.")
+__failure __msg("Global function exception_cb_bad_ret_type() return value not void or scalar.")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func7.c b/tools/testing/selftests/bpf/progs/test_global_func7.c
index f182febfde3c..9e59625c1c92 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func7.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func7.c
@@ -12,7 +12,7 @@ void foo(struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("foo() doesn't return scalar")
+__success
 int global_func7(struct __sk_buff *skb)
 {
 	foo(skb);
-- 
2.49.0

