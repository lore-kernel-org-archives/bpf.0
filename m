Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD953CC9F0
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304495; cv=none; b=ANZiaWH+QqHeLGnm7a/Btm4lhULW8d305X659S7KwEW1o0YwGG9DNKZB8T80Rc0DQxEI7xZa6mqKJvb9wFUCxGYpMjhjkkl5+57cHqx8+gadgA9tP78yOoC+1bA0KFT9dlMNCs4rs/2lgnZ5RIx8FGOGQzMSkliM0ahMYOpGm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304495; c=relaxed/simple;
	bh=ufnmS0984/p5wu3nfDJ0z0RE9P2jiZnA7BgBMK86XKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5MSkfZf1vw99UU7uD2vb+mkPLPFBWmpx3GokI9wU76FwAj9c9CLHt5dl00xJpgpsKBfF9dIMrM58BGUlYB4KUuaO3gCuPEKl4NsbZ8OtFhSPrwRnlpe/b8o/RvPWLXOIo/ZuzGCMwOGnyqa0H/U+F7BsJ+Jh3+CTbpt4cNmh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nSdGZyGj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nSdGZyGj"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a9f445cbso41460866d6.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772304493; x=1772909293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFqTQMVrtJPqzL/BePS8P0TFU1hJNorLfMpqhHDX3s0=;
        b=nSdGZyGjvspBtrTz6s6xqKQ1Z0Dku+JkAmaoQhtkwJH9HgZGkwrQhVRkvlolp7exOt
         fJ16gbp90vdF0WwMNuAUJqaU8E/nYr2z9PrJ/IdEm4PAirF/lhnLMFs/BXyugQklRmEN
         Q9Xen/iAYoG+xSabp6Dz6PtqONS6e2YRimbHXZ6BQpuTW8wBrVcOreBJLFzzD3LohO8u
         ECOFLUcuu03qSz3yRG3nGhNYOKfEhvmMaGHUhVM6/q+b5DUz3p/Re7zATCKQ25NeuS6J
         1I4TaWka0YSGoRcT60Of7+s+/UXJjIzJHrHFdBN09NHnrHlf+WNSjZ+vV4z4TTb+JRQv
         uT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304493; x=1772909293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFqTQMVrtJPqzL/BePS8P0TFU1hJNorLfMpqhHDX3s0=;
        b=ifZYOldgip+9jXW5uhl4lnA8063StJh06PCY3qvucWaK5H69AqzckClhWfvBoGh8ZC
         odSG72OjnbJrQ7oFMTRs00T15UKukQHphyBrJMqo/W9rTC2IPunheKgw3m6aiY23iyOf
         j1nk8Bs0yBP8VTGxXTuh0Zhx0VfEv7bPHlYbPhUjvNzF5lCVb3z8uPGxFHMcfSNTeAxB
         s5P8jb9V8CQxu1WKZIEyEabXAwVftPc3GeyA4dNKkLETizfHHNdvNyktVsuqFHjPSakk
         NG1Mcnm4lUG3bCBOXH817RImPG+U11FPc3mQs8/QXDzMq3uHLiGB18uMwdU+ij3lX9zz
         sNdg==
X-Gm-Message-State: AOJu0YxAUfjN4q1op+zlqKGL69It+NPdI7qWaPVDkTDp+ysB1n2P6F2O
	YMVCVNSSIjJgt0lpxkGaRGOWqk4njxOE6GybBrHoOF9OYWLRQ5XkMgRFIYPt77KYrTntwSShNMn
	xUqQA
X-Gm-Gg: ATEYQzx2jB0xcK1xDQ8DBuu8zXHwiOZu3YddxHb/TvWfsX02Cy+aVFCBd+cZPuo/2FH
	j4X4AYjpTubGR13rv+G0gMy6PhCs3SUsAUDtce2AciZiGw9xQM+8O5wDx0x0xGzhDxOIcno8Tvk
	8+3iXRQQRbtW5Umu90kGAFHz9FOVMHY7T0AFKdYOmQ7caRs24VPncgUn0uV1gC+FvaaLXNPIKcf
	qdTYinWcVDabrxPjFHol6DA8/9XeV/3/8N1/9GOHlbtfYgZhEKA+84xvH/QrqfltQv9YzB0LfgV
	iiX2dqUuqGrJWtQ3MXNzqhzNsY0F+jtGGUdgnt27z/3VuiKCM5tE3hjtXeVlnRwH9u2Q5t7fom2
	muSrILjsoICYVQ4tdeJoYmXDJqagKFJCYyiWorg8gfF9UUiQoiMlHHHGwqqrdtDSbn08UYwxvx+
	VAi+ZsLX6qFTiwY0hU9f823Q==
X-Received: by 2002:a05:622a:190f:b0:4f1:b63f:a165 with SMTP id d75a77b69052e-5075299110fmr87841991cf.35.1772304492448;
        Sat, 28 Feb 2026 10:48:12 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ab3d88sm76160561cf.21.2026.02.28.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:12 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/5] bpf: Allow void global functions in the verifier
Date: Sat, 28 Feb 2026 13:47:58 -0500
Message-ID: <20260228184759.108145-5-emil@etsalapatis.com>
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

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c                              |  7 ++-
 kernel/bpf/verifier.c                         | 61 ++++++++++++++++---
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 4 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..09fcbb125155 100644
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
index ebcca81ccdaf..786f6ab3e817 100644
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
@@ -10848,9 +10871,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -17915,7 +17940,7 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 static bool program_returns_void(struct bpf_verifier_env *env)
 {
 	const struct bpf_prog *prog = env->prog;
-	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum bpf_prog_type prog_type = prog->type;
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_LSM:
@@ -17928,6 +17953,16 @@ static bool program_returns_void(struct bpf_verifier_env *env)
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
@@ -18022,8 +18057,12 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 {
 	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
+	struct bpf_func_state *cur_frame = cur_func(env);
 	int err;
 
+	if (subprog_returns_void(env, cur_frame->subprogno))
+		return 0;
+
 	err = check_reg_arg(env, BPF_REG_0, SRC_OP);
 	if (err)
 		return err;
@@ -24523,10 +24562,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
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

