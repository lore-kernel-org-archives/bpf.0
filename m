Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F71A0B15
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748383; cv=none; b=MwuLgM7ZkGHRyVXjJHhrlEs4lrvNYRPx784DMSeAIj8bVqwVBH3lmqqMEpF+q1zZzDzOVKIWvcWqs0iX4k3+YJaOEtZrWAWSz/23dM2t3lIO3Wdh8OsDbohFX+Uw4GCR3KctkoX/KgeLbAx24cLDe9NRnKJwuEyVfF1T92dJLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748383; c=relaxed/simple;
	bh=gyiZaGexLsI4y+FR1dlhdW8b9m3jF0eAfg6r1Ieo7RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4pa7rGfFMdqLPs3KumpXEpm0SH8mdxQq6qxid/P6CWcmTK+jEk18EWWpCr0YHemo/B8lI1/2yX5r/plQWcxb4iStuMSU4pcF8QJ7pL6d3L/9UmOfEPuzooqmvXVZgwYriFrEa2M0l4Ml9GQbhCodyhIr6rcKcM3DbxXo/zn6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=lApzunDq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="lApzunDq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014600ad12so42520591cf.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770748381; x=1771353181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt2eki7VFIDTT4gS7AYWK94UnDxULTPOTvYXmAFc3/0=;
        b=lApzunDqGJ8Wdf45ISgnA4DgcWH2wXpUbyrHIXE/825NDqH49zAlmFRixhtSVoJzud
         lEZrhsVXUF5pk+UP8KGpDDYJJ/Wm4QLnOZ5RfcfjKTuHotDuP8svyJqvWLpOSKKI7gF4
         VjCJ8G8+tsG3pZ+0uubF5TUGfr3VXLr6ji7XUc4pDX7rTFzPZ97xMCorWn4WrqTRBJpI
         xpwCeRcoiM8LxOdbp2gk+LZyj7CzoHP9GkNluGRvjP7SwjLht+69r338BxIN99Boo1d6
         8YURF7aof25hwuOXWkUnXCTCHYPqe+UdK+z7OC4cTVdP0MM79i0/NpIEY8BlFbTlXp16
         P/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770748381; x=1771353181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vt2eki7VFIDTT4gS7AYWK94UnDxULTPOTvYXmAFc3/0=;
        b=NU5EorU5UkBj7ztlkPT3xfGpCnsLO80d1mEBlu5+PbQXRmjwKIFZZoH1Hl6Pywws5V
         6PmsKC4ekxDm12WJYx9dyHSHIB7vK9UIqRWo2d7O6+NQidu/hG9r/NCO9JiaGF9aMebE
         IXaL/Ih0M+0x+z1uqEFhwlWLKLrO0p1F9WCp3tKKk0OJAgxUvFTGD6iWwGVTq6cqgfX6
         GBj6UbTuUJztRgz41rXDuyhGiY87PBd28x/uDbMFfVjKCoGumxVgFTP05pnF+N8uO4DP
         Pus+2oG4o614iVsexv4efxSRsOXr06IoIy8tEAKBdxSMAw0XZ15QiRr72pXFSxqERs9Q
         LYow==
X-Gm-Message-State: AOJu0Yw6ruyYVbgNQm4xCp/R28TgkGy1HkqxokVf9rP7+XQUPYW8bJ8i
	b8suUjAP6fN4NY6e48q1IyjAgIr+SERBdaA1MXZ5v5bgJfK8xCD12d7pryvpggiU/d3EsWvI/eh
	1WYIJ/qs=
X-Gm-Gg: AZuq6aJo7s1s0xcnyVhpMWVW6/kDbnrNK2EcmoepWqcntGIWkdOCl5HTVPPRPx6e66F
	fJv8kZoaGoLP//No/2gG0alnET5CTi5GSM8VOwMTf8E5r7zFaTVJWWnugQhv9mPC/bvIaqLiI9y
	pq+q7G+7PVLDax+BpYM7mV3DNEykYuu55vCFS7WPA8W7+Pe0Mn0/dDDCz+N0tKEG1g8HmJCDGFP
	+geiHUezsPVMSLmmRzeWp2rjERKxJKgDCSZyrZidd0hc1PcPjuhYHWCEcR9mwkAFqIHi8p3LYCz
	+VHJO4P45NeK4ljWe44ZdCUTrdorvyYRMEhnI3bV14bggOnbqAFAwwKEnZ46QqSwbwSHHUjfVDK
	N+YxndVgbDw6SIkg+wyNJIuLePBnCXeQ7x2zGS2hmsL/HS4hf5fJg4dq6DujgYAB+uPg4dnGSZR
	ILRc8/rRdRkL+XBvwPGsiB3A==
X-Received: by 2002:a05:622a:510:b0:502:a1d7:7d52 with SMTP id d75a77b69052e-50673cf3847mr39367541cf.4.1770748381440;
        Tue, 10 Feb 2026 10:33:01 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063913b829sm105348641cf.7.2026.02.10.10.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:33:00 -0800 (PST)
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
Subject: [PATCH v2 1/2] bpf: Allow void global functions in the verifier
Date: Tue, 10 Feb 2026 13:32:56 -0500
Message-ID: <20260210183257.217285-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260210183257.217285-1-emil@etsalapatis.com>
References: <20260210183257.217285-1-emil@etsalapatis.com>
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
 kernel/bpf/btf.c                              |  7 +--
 kernel/bpf/verifier.c                         | 49 ++++++++++++++++---
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 4 files changed, 49 insertions(+), 11 deletions(-)

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
index edf5342b982f..f4ec3c385584 100644
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
@@ -17882,6 +17907,10 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		default:
 			break;
 		}
+	} else {
+		/* If this is a void global subprog, there is no return value. */
+		if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env, frame->subprogno))
+			return 0;
 	}
 
 	/* eBPF calling convention is such that R0 is used
@@ -24502,10 +24531,18 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
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

