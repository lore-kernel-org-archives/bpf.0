Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB036AB7A
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883479; cv=none; b=fu/E0HkyfpsjA2tXcKEzKscyzLqpFtWZ/hBiCVw/jWP8CuHkD2A2dHaSvrDAtvqXtPTrTQRN+QWqdqY5s9CC5RecsJRfmxv6KlSVPzpA6TmIPWXnwDNO6riBAjGTeDEiGnjAVdWKjAYxgXS4cEhO63HD/7+8NvbXXmrmzrFo820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883479; c=relaxed/simple;
	bh=o0OeWPqyoTFh/9mRaS5e8ITI25F2WmujQjQoIbgrQx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEZi1Sm1ZPpxs4NJn+/dQa9tHHK5NZCdloRkr7nMuUbc/ud5vom05hEHVFmBqE9ti6ylCODpBStDr3cTCkq/91VP+8kAUu0xTZeyLY4HcyNmh79LrMr77MADLzpoPrSSkbJ7diOPZ+viyx8RwJitw6mm5KQhnPKcuxgXsS4aYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=kZo559Y2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="kZo559Y2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-897023602b1so54774826d6.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771883477; x=1772488277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0dynJu288w3qB1oep5GFG4u7DoZ86wo0wJEPlcHgzY=;
        b=kZo559Y2PNNGeMXfoDkDUP+LOLuk6xQ0xJQDFDA0yj7T3ximx9HrbM1BcBn1HQ5Tjs
         2ZqJ0TrmFE6V7dlK7WYdYZznPqt05lZTh3J4KFooJj/2eCYGYix5X8z0wdyEOkT2xiam
         HnB7sEY9Pj/fEtykFEpHlPTrnA0RKEAwd1IxMBlF4XBeczwSkkeXHUU0+Fs+J9X09D64
         0gBmNEda36ji7jyTcewrHMAIrJYGXpS+ZnX2BJ7XsD2Iz0ipuYaOzVcrdKiih5E3ZWeU
         onPhaIoYwSiO5kAxES8gWtSQRO1ginx/2+SjGfnyJAPF9bYnvQXTiETYPyrrkBSH0pVk
         YpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883477; x=1772488277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0dynJu288w3qB1oep5GFG4u7DoZ86wo0wJEPlcHgzY=;
        b=lVIhm+afYufUOxd1X9/j08f6f5wnYuAXPCSUKMlh83N01pyXaas0StwwcKmbfvTMte
         TSN5Hy2b/iO0cMzEqES5k48BF5NV7jxw9y9bfsRnhAUnUn7gE0L72pf99+TqtUecCOQk
         9SYBp+L/MYqaWfq9FiijFGpz9nTpkmgLofoNVlbldSqDTqngGSwUTtJShpOUTW7v0icL
         YDxNwvrCGs2ZUKgdHbKlKWz/KkZcVWhoP0wbEb79jvccSI8LSdcqCO/dfYhFkEU7QZul
         00fornCpgJfWd9BvfACU4mK6JnMaM1Aq6xP6XQa6GwnVL5lZ5agtfeNIO4AQ3sWAZZqF
         Gxkw==
X-Gm-Message-State: AOJu0YyW981UNK3eRHoYasHR8afGKCRvioFDgFCiR9GYIHowOSOUldZY
	A+fQnsfaGBHjoX2bfxRvOFxLqwtCet0FFxy5cMEoGjFjOsMtgFFSXBgbPEHKKb0TSDDBJQ6QQyR
	9yXk9e78=
X-Gm-Gg: ATEYQzxL4EyYn0bkZ/F2guj36msiag3jm3rffh6b4C2aGEOzcSnsEjT5MKAfxOqqvEG
	wGK1fvehnbnEXn9TZBFGa7c6+xhQRcbFm3c2qkoEmNIH0nJn2TiWqKmB3p27z/JpCaCvVAGv1zt
	79VyjB2nC7HYdc0MKogmmlZLFI7w1w6IHIs0zfr5DTl03olC57OkUSzG68JPmI2p9BxFFDtgtU7
	YUktd6ysMYc76U+H6EYKankEG71OlkqU3mvp2pwiifttReo8g8aMLKEct8aTVc4QOXouYUErNHK
	Ir+nwgO2VUKhjMBMqu/xOSNx4By3RkJQmjdkpRFzHmSvoOduXLJkdui2UTHcE+YN9ohX0KEh1Cy
	qrFfv/K8zagORWy4uynYlziHS2V5XAghKyWGqzRFWNF0hk96jJcZfJ+byD9bTzOsSU+5Rpw/57P
	DcHd8X30PK4qQQv4kOLystNA==
X-Received: by 2002:a05:6214:c48:b0:894:7c8b:1216 with SMTP id 6a1803df08f44-89979d3f6f0mr133953046d6.35.1771883477305;
        Mon, 23 Feb 2026 13:51:17 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d100c18sm815115485a.38.2026.02.23.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:51:17 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the verifier
Date: Mon, 23 Feb 2026 16:50:45 -0500
Message-ID: <20260223215046.1706110-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260223215046.1706110-1-emil@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
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
index 0162f946032f..e997c3776fa7 100644
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
+	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", func->type))
+		return false;
+
+	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
+	if (verifier_bug_if(!type, env, "btf_id %u not found", func_proto->type))
+		return false;
+
+	return btf_type_is_void(type);
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info *info;
@@ -10840,9 +10863,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
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
@@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		default:
 			break;
 		}
+	} else {
+		/* If this is a void global subprog, there is no return value. */
+		if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env, frame->subprogno))
+			return 0;
 	}
 
 	/* eBPF calling convention is such that R0 is used
@@ -24452,10 +24491,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
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

