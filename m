Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C944397691
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504656; cv=none; b=JT38zFLBJZpDP1nYb154Run77gueJGQHvDl1lcA4F5ZVV/Bjc/G8hgvwyu5ZKv683ltyhZ65mV3wgk+AeRTnIfiVJXrKTpMrTxoosWJhwVxQxbxLdFkEi6QWzRLxHgNUnCGvBeQf+NKSwsEDlh0xqM+P5f8rYnKESnm7IdFzNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504656; c=relaxed/simple;
	bh=J1QrUkuCPy+hMIqEHUhMsm6Fqi+FN9vOCp7ny90Ooeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMmdYb33UHQ5vXBFEMvR8PPusQork4bF6y3aEtVo/MVUjyevgzyG1z77BaVZL0NZGrcsFcOmj9i8uLn/NA1FMdEj7G54NeGK8xR9lFiq98RG/CLQyh4QwCns+Q8wwSmYCexIA/SnF9T70iHhPcqR8r9nRnFeiJT44ZM2UFCMGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mgo1Rh5j; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgo1Rh5j"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-4230a00de40so2283129fac.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504653; x=1776109453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/Fqm4OtXr/VmWUhtsFNvtODjwgy3ptQNhCaO0O0Jq4=;
        b=Mgo1Rh5jQoKzVWwb3oFekZu51m2WLe/AnrOjn2qQ94qlbnIBVj1wKynylDnoddKOEY
         kqvM2jVibdzCXfvTDT4HmJuDn00JXeRdbMzD5wurJzDiIDBpsqj+gpFt0CIoj2Yf7nab
         +Hkw4x47x03gMsX0SybO6bCLf1RYakOWICLshgGoH/xtUeUoAWw1S28AJ1c6XciyvO+O
         4xRyCc9TcD0JlDznsn5IbI+pn0JYcQUC2PIwvDrb+3BHFahSYYaKrfRoiiLfu45UVNOg
         yklRR8g455EdXBDBFakLIwczbgw10ySmEIjXfwKMANRZ3p6Zw94C9BMGjloNTrEw9VKO
         L5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504653; x=1776109453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/Fqm4OtXr/VmWUhtsFNvtODjwgy3ptQNhCaO0O0Jq4=;
        b=ElvRFhD+ZEHSusdvTNn+hG1lb7IXVRWVTElsPFfv6skUvqIy38JQ8t+avJ96wjPSTn
         1Mwg8eaf5ksLryhgR/nWO0TDRTkUMU2T0Y/icHPk1Af6UOZthXkb50RhYygIt2NHprGT
         utGbI5eWNijeKRyluOW9qd6qTqMJTpLuCGYqf18l5zNcmgWVerag3L8iEfh9xq7Sq2r9
         1SIl/LfCyQDoqPy++E4oezV34fE4tcqqV9mqgEc9h0Ws3S+4kJLa1UWLB2hLqlMIrVep
         r/qntTZDkyOXosNpaPiW79LZR7/M+RFsN7pNFH5JWxtEMiW/gUbrXCTxyUjnHywlXP08
         eugw==
X-Gm-Message-State: AOJu0Yyzsfm4/+fzAIM4DXr8mWGlQjULIf/VfsOWghTfnfFiGcUeuhE9
	LLstDqrLBSmL0vlYfBQXa4+ZtmPsqVqKKs65thge83HkGryhVQkO3St0zj7Uhm43U14=
X-Gm-Gg: AeBDiesQ0BV1meyGtcHowp+h7UhAzlZGCe1uFfGi8oaHYEQZprFmY2f3tnYRybnA2h+
	gx2IE14rOLw8JTFakXd8eMTxmbUu0NzSSOEcEAAxaiXskCUfk5IdjOUbrSvzysXqHw1+zoywhqQ
	Ccb2CQZAdMIR4nsa5+Sqro/N8x6GyDkqBjmm9qtcz48Pm/YBelboJMbNdVXl6Ozy7BxXlp+bsPP
	7yns2PdyQJ8OvVdsMUyjchsLb/YFzLzDyZcIig7CIfKnh3l5Fo3u9VTAEL3p+PyGCJEA0Ps0bdh
	1Fu1WSy8nX8hSaXtrspVBijRwjs3P45xwInH7LNudvDkTzeTMvb0b9+0eZGs4BcO0hDsPjBSU5n
	mliTa3T0cSpkjc6gW5iYhRUl+Tom7Tev987Wb5L/5c5S+TsmR1cvUHjH8mcXUsps5JSBfnKWcjo
	vgeckcYC2PcXSamETCXFreUS3S6fYAER0WxClIHI++5Gsbi1Unxh8UHw==
X-Received: by 2002:a05:6870:3312:b0:423:3af4:de45 with SMTP id 586e51a60fabf-4233af4ecc6mr5012049fac.26.1775504652945;
        Mon, 06 Apr 2026 12:44:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25a55asm12569657fac.10.2026.04.06.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 4/7] selftests/bpf: Add syscall ctx variable offset tests
Date: Mon,  6 Apr 2026 21:43:58 +0200
Message-ID: <20260406194403.1649608-5-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406194403.1649608-1-memxor@gmail.com>
References: <20260406194403.1649608-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11618; h=from:subject; bh=J1QrUkuCPy+hMIqEHUhMsm6Fqi+FN9vOCp7ny90Ooeo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD1vm8gXpNm+332BuZ52Qk66wo8zkn8r9P0p7ZB/KMV55 ZGbUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcP8LIcCFQePcji40pcZcjNoSVfR PzixJ9np8lv9mq4yC7+3E2e0aGX3M4Mv301JvcHM7rLZWb/nDaPs+C65NV1ze9OSZwZOsMXgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
for syscall programs, and cover disallowed cases for other program types
lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
so that kfunc related logic can be tested. While at it, convert assembly
tests to C. Unfortunately, ctx_pointer_to_helper_2's unpriv case conflicts
with usage of kfuncs in the file and cannot be run.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 271 +++++++++++++++++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 2 files changed, 267 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 4c285ac8fff6..6e683dd8002a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -4,6 +4,10 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+static const char ctx_strncmp_target[] = "ctx";
+static const char ctx_snprintf_fmt[] = "";
 
 SEC("tc")
 __description("context stores via BPF_ATOMIC")
@@ -69,7 +73,6 @@ __naked void ctx_pointer_to_helper_1(void)
 SEC("socket")
 __description("pass modified ctx pointer to helper, 2")
 __failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
-__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=-612 disallowed")
 __naked void ctx_pointer_to_helper_2(void)
 {
 	asm volatile ("					\
@@ -292,7 +295,7 @@ padding_access("cgroup/post_bind4", bpf_sock, dst_port, 2);
 __failure __msg("invalid bpf_context access")
 padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
 
-SEC("syscall")
+SEC("?syscall")
 __description("syscall: write to ctx with fixed offset")
 __success
 int syscall_ctx_fixed_off_write(void *ctx)
@@ -304,6 +307,174 @@ int syscall_ctx_fixed_off_write(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__description("syscall: read ctx with fixed offset")
+__success
+int syscall_ctx_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+	volatile __u32 val;
+
+	val = *(__u32 *)(p + 4);
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: read ctx with variable offset")
+__success
+int syscall_ctx_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+	volatile __u32 val;
+
+	off &= 0xfc;
+	p += off;
+	val = *(__u32 *)p;
+	(void)val;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: write ctx with variable offset")
+__success
+int syscall_ctx_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	*(__u32 *)p = 0;
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: reject negative variable offset ctx access")
+__failure __msg("min value is negative")
+int syscall_ctx_neg_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 4;
+	p -= off;
+	return *(__u32 *)p;
+}
+
+SEC("?syscall")
+__description("syscall: reject unbounded variable offset ctx access")
+__failure __msg("unbounded memory access")
+int syscall_ctx_unbounded_var_off(void *ctx)
+{
+	__u64 off = (__u32)bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off <<= 2;
+	p += off;
+	return *(__u32 *)p;
+}
+
+SEC("?syscall")
+__description("syscall: helper read ctx with fixed offset")
+__success
+int syscall_ctx_helper_fixed_off_read(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper write ctx with fixed offset")
+__success
+int syscall_ctx_helper_fixed_off_write(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
+SEC("?syscall")
+__description("syscall: helper read ctx with variable offset")
+__success
+int syscall_ctx_helper_var_off_read(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	return bpf_strncmp(p, 4, ctx_strncmp_target);
+}
+
+SEC("?syscall")
+__description("syscall: helper write ctx with variable offset")
+__success
+int syscall_ctx_helper_var_off_write(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	return bpf_probe_read_kernel(p, 4, 0);
+}
+
+SEC("?syscall")
+__description("syscall: helper read zero-sized ctx access")
+__success
+int syscall_ctx_helper_zero_sized_read(void *ctx)
+{
+	return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);
+}
+
+SEC("?syscall")
+__description("syscall: helper write zero-sized ctx access")
+__success
+int syscall_ctx_helper_zero_sized_write(void *ctx)
+{
+	return bpf_probe_read_kernel(ctx, 0, 0);
+}
+
+SEC("?syscall")
+__description("syscall: kfunc access ctx with fixed offset")
+__success
+int syscall_ctx_kfunc_fixed_off(void *ctx)
+{
+	char *p = ctx;
+
+	p += 4;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: kfunc access ctx with variable offset")
+__success
+int syscall_ctx_kfunc_var_off(void *ctx)
+{
+	__u64 off = bpf_get_prandom_u32();
+	char *p = ctx;
+
+	off &= 0xfc;
+	p += off;
+	bpf_kfunc_call_test_mem_len_pass1(p, 4);
+	return 0;
+}
+
+SEC("?syscall")
+__description("syscall: kfunc access zero-sized ctx")
+__success
+int syscall_ctx_kfunc_zero_sized(void *ctx)
+{
+	bpf_kfunc_call_test_mem_len_pass1(ctx, 0);
+	return 0;
+}
+
 /*
  * For non-syscall program types without convert_ctx_access, direct ctx
  * dereference is still allowed after adding a fixed offset, while variable
@@ -314,7 +485,7 @@ int syscall_ctx_fixed_off_write(void *ctx)
  * for non-syscall ctx pointers at fixed, variable, and zero-sized accesses.
  */
 #define no_rewrite_ctx_access(type, name, off, load_t)			\
-	SEC(type)							\
+	SEC("?" type)							\
 	__description(type ": read ctx at fixed offset")		\
 	__success							\
 	int no_rewrite_##name##_fixed(void *ctx)			\
@@ -326,7 +497,7 @@ int syscall_ctx_fixed_off_write(void *ctx)
 		(void)val;						\
 		return 0;						\
 	}								\
-	SEC(type)							\
+	SEC("?" type)							\
 	__description(type ": reject variable offset ctx access")	\
 	__failure __msg("variable ctx access var_off=")			\
 	int no_rewrite_##name##_var(void *ctx)			\
@@ -338,7 +509,7 @@ int syscall_ctx_fixed_off_write(void *ctx)
 		p += off_var;						\
 		return *(load_t *)p;					\
 	}								\
-	SEC(type)							\
+	SEC("?" type)							\
 	__description(type ": reject negative offset ctx access")	\
 	__failure __msg("invalid bpf_context access")			\
 	int no_rewrite_##name##_neg(void *ctx)			\
@@ -347,6 +518,96 @@ int syscall_ctx_fixed_off_write(void *ctx)
 									\
 		p -= 612;						\
 		return *(load_t *)p;					\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper read ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_helper_read_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper write ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_helper_write_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		return bpf_probe_read_kernel(p, 4, 0);			\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper read ctx with variable offset") \
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_helper_read_var(void *ctx)		\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper write ctx with variable offset") \
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_helper_write_var(void *ctx)		\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		return bpf_probe_read_kernel(p, 4, 0);			\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper read zero-sized ctx access") \
+	__failure __msg("R4 type=ctx expected=fp")			\
+	int no_rewrite_##name##_helper_read_zero(void *ctx)		\
+	{								\
+		return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);	\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject helper write zero-sized ctx access") \
+	__failure __msg("R1 type=ctx expected=fp")			\
+	int no_rewrite_##name##_helper_write_zero(void *ctx)		\
+	{								\
+		return bpf_probe_read_kernel(ctx, 0, 0);			\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject kfunc ctx at fixed offset")	\
+	__failure __msg("dereference of modified ctx ptr")		\
+	int no_rewrite_##name##_kfunc_fixed(void *ctx)		\
+	{								\
+		char *p = ctx;						\
+									\
+		p += off;						\
+		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
+		return 0;						\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject kfunc ctx with variable offset")	\
+	__failure __msg("variable ctx access var_off=")			\
+	int no_rewrite_##name##_kfunc_var(void *ctx)			\
+	{								\
+		__u64 off_var = bpf_get_prandom_u32();			\
+		char *p = ctx;						\
+									\
+		off_var &= 4;						\
+		p += off_var;						\
+		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
+		return 0;						\
+	}								\
+	SEC("?" type)							\
+	__description(type ": reject kfunc zero-sized ctx access")	\
+	__failure __msg("R1 type=ctx expected=fp")			\
+	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
+	{								\
+		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
+		return 0;						\
 	}
 
 no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 061356f10093..d876314a4d67 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -723,6 +723,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
@@ -1287,7 +1288,6 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
-- 
2.52.0

