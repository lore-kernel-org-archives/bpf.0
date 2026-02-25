Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668F29D264
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990445; cv=none; b=D4QyzP82zaYbcCEk+V7C8tTCvfb3kaOHDDUicoCTY74/agAESDwDp4Q7DQA9YBgKHAfVvHsXKWu+RGchBjZ9eg5ioYsjAevUDDJGmIZdHJoAIpIO8kmYIFKCZdcNd0JNynY/Ape1O4PVohhC6hSuLIfdBqsE6AjbQyOBNBs0BRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990445; c=relaxed/simple;
	bh=PEqY92yFPgYMQXGxNLiQJ6xuvtcSLwW0Co0je5WgQf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnI3H1YqG9z8vyTO+TqZitDyCWYivkLmPpHf6JE0JfBZEpG/FvS1AGQRXEP8Eb10WxGUREd1+rMadG8rCcyfTwA/RMiEP3tko7JhiW2iaHPC914xVJ9F4WM9gGU+9Bzjt7JtwFYYv5uUVHzolDZoiN90utO2KlRbDr9kfYNeEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uISTe0E2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uISTe0E2"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8972a14e27bso81110926d6.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771990443; x=1772595243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7tHcPv/W/JPAD786S3DV5rTkfRAHFs4d+g2SWZkd4=;
        b=uISTe0E2UulSAPkBwiuXRWnZpeXKeFN+d3QgSmkpD8DSxK3LalKdRqEidQvDpFreu5
         PaXHqb9g2NMObB2wsyz0V0YjMLVfHpFs5ZQvf+kaUM4EKyHXxW0XtwpNy62u+eHvJpC6
         yRk4cSpRJ8dC4KwCzr0mnfvY4ZbfIeOfCZ4kRfAg6vr0qNsO2deh7WhQ2n0bUQcOCznj
         4vpixaIBelb0KGzmlYCzm0+YhvH1diAqELEKDceD6I1ubHqr/ZFed55lmSr4unTPSAUC
         E6fHhAgsajgHXZ/eGHkOneROoqfmt8seNmyXhtid0hYGpOuUH/kZuFkqfEgLuLkIiRaj
         PR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990443; x=1772595243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pl7tHcPv/W/JPAD786S3DV5rTkfRAHFs4d+g2SWZkd4=;
        b=pXcFphEb9VA5EjkLaH6zM1eUUZt9tXhRUU7VCVN9v/a/2KG7mAaGHyrBQyZF2UA36W
         OrgQEYTNXWHl9ZCS4EecjgtCoPx2Cv84dUJmQvAoSRHs96zRJDDHik/+epICTj5U+1Nw
         23DIsUVsFSqvXROAli8SvuPvLgl25FUzCV3Q0euXQYzKmenxEiqUUdcDkffUbr5r3p9t
         WJFRJ97Bw+/3mRBueLt54Gl+YwZLUxVaReJ3fxTmGdYObCsvLanQIlIIQiQaRb1kCQL4
         i5yWVKGpKKTKRUYnYT2FSYRhgqJ9OzNVb3BiIdHEpVrx/xSXeLmA+euRv10kFLS7RIXN
         AAEQ==
X-Gm-Message-State: AOJu0YxqmoxPE86gRDl0Wnfng6CzCDldwccMsUl0+DcvUX1xBor+jDTh
	9V8k9A5Eu7j7mbMavVfY00m763N15nlIMnSJQhfis29SrCcvnNgmuddrpa1W4aCQFfzXT+Y4QAs
	hNZ1Aytc=
X-Gm-Gg: ATEYQzwbR8cRt49NC0T0KKRwnfVAaVCNeVi9d4Aqzzgv5RYYgx8zeZhcKu3kuRzPidR
	coITNgJLC4UIgicieSfHOldmN456NSyCqkLkncXCjg7wAHtxYUnT1ji7gIJ833rYbdm4coum9zG
	NfyNEuo6f6IFX0sa9LgKoSCbMcD6HpTVEL17OwiOZaiYnicH/BvatutoyJUrp87+lHLEXrpUzJZ
	5wcP3d6tgOvUhh9jOmUhWb65ttpcu9n0fIxRZyZ7V+Vb7fKFruBTA/vFi9rtocl2GXsAEmVjtpJ
	n9wjcGoGmlGcFnrNspV7qjrBBukgb+sNiwoksJfyXBzH8SC1Aez8GwJNRxCalfYyFkoTYmIZ5r2
	V2tV65qsC9XNHCxhuRkR+46FltA6QdSFS0khu1d26adU8ZaFc+blmOSsEOc+bNr0siV2HZ2qntt
	L3/+U2TWw4B3Y9LIanM6uUDQ==
X-Received: by 2002:a05:6214:4101:b0:894:81db:af6d with SMTP id 6a1803df08f44-89979efc9f7mr219609746d6.56.1771990443355;
        Tue, 24 Feb 2026 19:34:03 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm112207986d6.44.2026.02.24.19.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:34:03 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/4] bpf: Allow void global functions in the verifier
Date: Tue, 24 Feb 2026 22:33:55 -0500
Message-ID: <20260225033356.518313-4-emil@etsalapatis.com>
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

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c                              |  7 ++-
 kernel/bpf/verifier.c                         | 59 +++++++++++++++++--
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 4 files changed, 59 insertions(+), 11 deletions(-)

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
index 8ed5060f6ea8..be597b90116c 100644
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
@@ -10857,9 +10880,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -18045,6 +18070,16 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
+
+		/*
+		 * If the actual program is an extension, let it
+		 * return void - attaching will succeed only if the
+		 * program being replaced also returns void, and since
+		 * it has passed verification its actual type doesn't matter.
+		 */
+		if (env->prog->type == BPF_PROG_TYPE_EXT && subprog_returns_void(env, frame->subprogno))
+			return 0;
+
 		switch (prog_type) {
 		case BPF_PROG_TYPE_LSM:
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -18074,6 +18109,10 @@ static int check_return_code(struct bpf_verifier_env *env)
 		default:
 			break;
 		}
+	} else {
+		/* If this is a void global subprog, there is no return value. */
+		if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env, frame->subprogno))
+			return 0;
 	}
 
 	/* eBPF calling convention is such that R0 is used
@@ -24603,10 +24642,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
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

