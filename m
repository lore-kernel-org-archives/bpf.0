Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF21E2858
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555666; cv=none; b=Yb3FiAaKGUgetGc86msW7A+XNFkxKpWNT/HBPAry6P8352f4VaD9EFRf03MXfNU0LSQR2am/Zw+dNh8DxN93JDQoXKtGTfC4/fESf4gnTNUwGZtoDz+YRMllLi4GjsnCdN+rFRSO/eSJNgsAeVnXk4khKm6HKx2iLd3fKMudV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555666; c=relaxed/simple;
	bh=Yt+uZthKogpESB2MmJkhphSFHa4PKO8FKNfHp+8Ucqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPQavuxRkNWjFvOiYEP8/vUd5l0K8UxyB2Q/leSp1j7Ht0x8IdgDPXBPKHvmaBnlUoYJ2gx0rrjYL6PQFan54Hd9VPhNWqLgIOKKRF9wByrF6edJ76kbFBnhGxWi14uhZZqgkQqa9uI5WAASetwFxcUQy/j6Md10tKhPBs063hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=oaaH4ej+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="oaaH4ej+"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894674a4c4aso120253686d6.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769555663; x=1770160463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnFnmMDx806ato6sctMLGJVPiArAuTfuOIEKyK5TFUQ=;
        b=oaaH4ej+RYK6ezqjzKykqLo02TkgkYvwDyVyhhw9/BmeWgEsNF8dQP67sGK/ar7JQZ
         5bTmdnUDcbxx7yKtPEVu5tbRnli2XTi46uh5PerCR7fLJCgxlciUtmNVC5DM3uRFCobG
         hBeB8MpGwLyA2DNLipNkWMsHztwTSLAPQmtn7UbvDcW0uCeD3OiXyY/HcC5yQh5EFVXc
         nZPg/wgS/9tzuSdH1iR6ePvHdVP8Kq4o5pHrxAzLcPuVXUz9sPLyvMOtccAJ1jUC6O/8
         f9XlLAy6Yoo3q4Mg8UZ0fqB+gTswfHboPyiba4ocFExvyjpPsSnWcHXLuvU1z8aCV1hk
         8ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769555663; x=1770160463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnFnmMDx806ato6sctMLGJVPiArAuTfuOIEKyK5TFUQ=;
        b=qyZ/Lk2pX5rI2kyc5PjvzKCchyvJCyYxYrDzbdJpiciYy+CK/aLdHv9+/CA45nlKoK
         J5oH2DxO3ZNDKBE8wYUFyf9yAUkjy4MQIFSkEg8kkUxVg5qimkg5637AfA3OgpmSVsaT
         2SBToZ+gm8BIVLsxamCZq6UAXk+BxWJ1uxKJfZokJeLKlMeuP/BkTGpepJcY46BYbu7k
         6uyh+svW/3q5JGT1KHIL5Juip/99feKAi8wKPTgY5/aNvYWX8AV0YqdgghhnPwmQAp1c
         lTOROPI2y6qyVfqHqWLLl7Gco2z0ipvWcy9WsBG/Nkz8GMp6mHv6JBOK9rXOrc8rVApF
         iFDQ==
X-Gm-Message-State: AOJu0Yy0uAhqe+xfJzy/sBSJYR1v0NsFRX4s22FrtV6kEiN7RhiRrMUv
	NcFbFjvj+b+RHMKPugmh0ZpB/7L0rKMUg0kPivnf9UM+iCdHxdfYzcXvtN633tWfHx3GFuskAH3
	ZePCr
X-Gm-Gg: AZuq6aIBZZivuPrEZD9c6tGNkI2gVQmirQsu+ye3blPbObyli06OPvMa0H1aYufDmsi
	+2Ht9vaV4YoAZHUwxepaLNSZZ1t8POU6EMnuZI0EwSXlISnHseD2L7oZMbZNlMIbrwChl9E6/bY
	AhBwhLeKnIJ8/oN5w+UDvAa2gg8IXIbZ6XDF7iq4OXC8zWIlLHHhzK13iZ9waG6XTN2TK/OnTUH
	uWWzzrXlWy20cORhaOTge67IpHfX+7WxUkX4ZizVu6y/o31mUHXRFHjfndbUh4MDvTTAxdkB/sl
	NHNZ0AU0lkH/heOiurs8i9CS47HwdcvwdlAjSTjOwCS+dtMPIxrc8lVkCUsZrvl04yQPBlCaMjh
	klf/6vISk56+agpCbvqWVluVB4o63qLuerfgEUzl+DP95Q9w4EWd9uDGg0ZgEJn7kWX1Ly9PRz7
	RZ27nTxfHkAg==
X-Received: by 2002:ad4:5ce9:0:b0:894:7852:9bd3 with SMTP id 6a1803df08f44-894cc8b4ef7mr45301196d6.42.1769555663448;
        Tue, 27 Jan 2026 15:14:23 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d373fe92sm6044196d6.32.2026.01.27.15.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 15:14:22 -0800 (PST)
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
Subject: [PATCH bpf-next] bpf: Allow void return type for global subprogs
Date: Tue, 27 Jan 2026 18:14:14 -0500
Message-ID: <20260127231414.359283-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogs are currently not allowed to return void. Adjust
verifier logic to allow global functions with a void return type.

Also adjust existing selftests that were ensuring that global subprogs
with void return types fail to verify. These tests should now load
successfully.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c                              |  7 +++--
 kernel/bpf/verifier.c                         | 29 ++++++++++++++++++-
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func7.c   |  2 +-
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8959f3bc1e92..162bfb948ba1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7835,15 +7835,16 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
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
index c2f2650db9fd..2cc740495479 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -443,6 +443,29 @@ static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
 }
 
+static bool subprog_is_void(struct bpf_verifier_env *env, int subprog)
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
@@ -10875,7 +10898,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		subprog_aux(env, subprog)->called = true;
 		clear_caller_saved_regs(env, caller->regs);
 
-		/* All global functions return a 64-bit SCALAR_VALUE */
+		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
 		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
@@ -17786,6 +17809,10 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		default:
 			break;
 		}
+	} else {
+		/* If this is a void global subprog, there is no return value. */
+		if (subprog_is_global(env, frame->subprogno) && subprog_is_void(env, frame->subprogno))
+			return 0;
 	}
 
 	/* eBPF calling convention is such that R0 is used
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

