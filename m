Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D840B6CD
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046511; cv=none; b=MAREWXKgdnwviRPsm3twPlh8NAhVijFc0DY2/G3sX3YHJO7R4zkRhQp1dinfPcy4FlIgyD+gMhgI5A/+V4Yg8QZYikC5+7K6wgChKcdadRneOcTqgEFyY1OnWFuZYW3ltJBRTUix2MOqpIHV/YYQdCO5EaxJmx+GKKsBaK7QoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046511; c=relaxed/simple;
	bh=J1QrUkuCPy+hMIqEHUhMsm6Fqi+FN9vOCp7ny90Ooeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhkLtYubC85uIIWzizx4gnGk9xEp+qKasS6KiolWXdr1u3DfU0APfwqnuXc0/NIN0w+/GhQoOXX2e21FG/E16Nwsa90LHWLWVAG+k/W7keQUmeuwPDJx8iSlFmcLVcvgwbFp4W91yDO2aR7CnKVPkqhYXCjEYIyt4DFKbtJkL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTEDf9eu; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTEDf9eu"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9c98e437cso5640570a34.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046508; x=1775651308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/Fqm4OtXr/VmWUhtsFNvtODjwgy3ptQNhCaO0O0Jq4=;
        b=lTEDf9eu+cDY/zydX7Hknhw2JuYrBac2FC/OzCjd4LZQ7F6VL58f2Yozfc5+aQWxYt
         p+GipiCRLdN+K/lYoTIZOtoDr91N/6QG5PaiAConP8sFn8FwaegkLKzhCY5zW8h4QSDp
         2dznJUABMm3dHy4LJKtGI/Sl8sEx4K53fPpzHrYOgdr88u7zXBmNdlhBcoqmA91na7hu
         NiNGiig3vHEJSSJVXfEYunXzUkmywJZU8O+tpU+G/Mh/5evSHlJqWTH/rHyb7vpscDxz
         qTRwwvXkNv/sjWXvBZB13JeyFXUoVOiziUJUM22Db110DGSYan7uBrtpSZVWoIm1dacR
         z1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046508; x=1775651308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/Fqm4OtXr/VmWUhtsFNvtODjwgy3ptQNhCaO0O0Jq4=;
        b=auD/kvf3+gw/N5yAP6MQgjCuvZVuFU7plE1Aog0511ibIDmHkVKgGOwt3nwRIGOVfC
         UAdBB8xoiuJYutusi+Jkohm/U4igU8u91aOtflrJ+gWhgLXAATxRcboo2BYM5o2RWUeh
         9nTZWB22lmlIwG9guhN4608890c8MyhuH26FWdQLbmOOjOyV5CkXJkMBoQ539iShbCC1
         M2v1oiG3rqRgQ3bQ1f+FzBGs9ZkwT58BEcIn0T8wi/qudduLDf3vjwet/+PZYmifQR1Q
         +ObGXQd/FXNvrLefGtFNlEkhDERgN5EvR02BCxcKoINysdFvColexwIcSCtHMzjP1wqI
         oYvQ==
X-Gm-Message-State: AOJu0YzJ1e7s9PnKdF9pYkgnlFjjVJ4WS6Z/M14alyAXyMiuYL64XUnD
	VilFi4BXXoywTR1tngqr125XgNtHCBuMs9JsaArDSv0mZ831G9bYpWrOGeUqDM0Ed6k=
X-Gm-Gg: ATEYQzzaATMFYERsA41g88t0J3/xSQqFJpfCNxjKHpb6+cZCBVD4bUNGO+RGMKmBDwz
	jvYRz4lbF0B1daunOFkmBswKpakxPeXORgbSTysCmoPwi0Hzgw9tnTSnYnhVvJAn3W0pJUKRv1q
	1GTXh7NX+8VSvvHB7uvK4ecDrawE6+ZYqoojnwDAE/NMJzfAKJ1kgYSe/kT4Lugy9Aiev3e1V7F
	PQkurCSTyD0Uw96AfTI/1wegkrcVlmeIceg7KOL3Y7E+GhGlmvucn4Zkwwvg1sl3TRyYI9y7hPU
	BsDFiqbGCp1ekSpsHmliXlrahzcOvFV7rlMQPBhU05mfNn0RgQK5YY8aNXrLXorRo/Gtw87dtIg
	QRCq8uxMVeEw8i9P+1klM2fH9BRRRAWsyxSR27kVPanJ79a3FuFXrbVEEUWuOTqetl+ohqv68bQ
	DgjDXuOUaC8IbV1LGnDYw0S9YPN1QUJbW+F1+FPsPdGO2C
X-Received: by 2002:a05:6830:4410:b0:7d9:f50f:96cf with SMTP id 46e09a7af769-7db991d714emr2341086a34.6.1775046508452;
        Wed, 01 Apr 2026 05:28:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a384631sm10358337a34.7.2026.04.01.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/7] selftests/bpf: Add syscall ctx variable offset tests
Date: Wed,  1 Apr 2026 14:28:13 +0200
Message-ID: <20260401122818.2240807-5-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401122818.2240807-1-memxor@gmail.com>
References: <20260401122818.2240807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11618; h=from:subject; bh=J1QrUkuCPy+hMIqEHUhMsm6Fqi+FN9vOCp7ny90Ooeo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs373M5QvSbd5uv8HczjohJ11hR5nJP5X7f5T2yD6UY7zy yMyoo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOJtmZk+Nly576/g1OClNYVtZv6eQ YftbZey9ZMmn+t4UV1d790CiPDsy6fdTe0m+SbnZ0O33FgtH3wgYNfI/qEq+SOTdafjisxAAA=
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

