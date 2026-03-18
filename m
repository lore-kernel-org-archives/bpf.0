Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1B23A9BD
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845128; cv=none; b=CMix7MJbTfMYmyMKsUZUbiDyh4AlR6ImlhOcosy2YMXXtEgnjAuIZ2LVJRALDo7OM0fCO+io4insAPQ3iJoqWjjQSsHSVvZ2FqqJH+i2bL3kmrDKGG+cjXuRR8uRSYysG3vcs3jDTzgNjb0Hd+vPZe3IJu8hHSFFV3sjTRk47Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845128; c=relaxed/simple;
	bh=QPSCZi10FDACaskYGAK85G+1TthChQi2xLFTvhYuLNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlhkE0B2e1UwGM9LLHkJmbAnByse4ed4xkJ4xPeUwyh/TlY02HXsmX0biLi7kR+5AMBWbPe3zpvJwyTuyEy61X7P7FACWyEtebUUNmebiyPYXjLJhfr1T1hC1itS9oyYIy55g4LpSvA0avd0CnO6a0/zC8d0TPwTcb5+TJNAKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/F8A7hL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/F8A7hL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486507134e4so23346895e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845124; x=1774449924; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MADTMiDsblErAuBbX8+AIkpNAOepY/Y/7nR9a3LR4D8=;
        b=B/F8A7hLfxus20v1cdo8Q1rqAlYzeARVh5Yw+IIWpDOEiOyqk804ZFjY+UwyfMa4kl
         fEHFbJQNwrdSgCcW1MblqsL9K4dBmkj/ZWV1nYu4pgGu+UJ+tyPDMC/M9W7fWBDwMzTI
         fMVFN8/qD12ZMF6sXNE+vUpaAihmVZnPA/fMyXhNBZIFEayQ1VuzOkhfURMpnpuuUa11
         dC3ApKUmeCyNkGRjHrE4LgTZQVRDz/K6YS7ziF8sa+j5ZtJ7ExPENoiiWdO8NMfL8hn8
         3wVS2jzJt8xbAK8Cfz6cH99lGKWo801MmscRBxD76C0T0SZUUKk4TAj6Z99Ka2fGE2B3
         OaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845124; x=1774449924;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MADTMiDsblErAuBbX8+AIkpNAOepY/Y/7nR9a3LR4D8=;
        b=noFGMxCjUvGUZbRu2YUiPEz6tKNUHocD9qvSfByyZ4BNX36L/J3aKoPFnKTYbAu0Ni
         qJX2AbrqyWi1Fqxz81h0r2p2Dledfa/DL2AgiX2MeNayaUqi1YMwq+1hiMQB/HC7S7mQ
         spNYiL2JFv816tLA/ALRHtKzdQZSxOqNJWKe4loX1t2PJq4oZ/VcfEGzprXTQMOmueao
         DWjAODlJD+Tba9WyQ+QVL5L8AK+vv5Ao71qmKeiC2n2+6AqHgART05enpwCWnnN1A31H
         ggnBiCHyX8iXpLaa0tSfcUHqhq3CPBYwtE8iprpEpoG8o71Qy5XcnkTbu/jAUUJwmwPS
         KQFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2F3ZoazqErRP6yGkrhArYqao1Q5rwUpiIMPiD5xq16+733xR9pyien9Ut4fZYg4zzFWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlO2I8+GMu1vYBMz+mEDaBS1PvpYiTHPeWGGAMzbuEpk7SvDm
	RXPvCMGxk+LyP/cY9mfvetocv1KOdDDwdPRSE6VhKFFDXlqnM2Rj8kyz
X-Gm-Gg: ATEYQzyqs28BGA44/X3TgeVHMRFZsTd9rEUQZ3D8zv7SyRuBLFfhCBoqjeHoRLRTDMn
	JMjI7dQEdaIKZeSTR3mxnDdw0dWTuUAbsi567mz9WTFdGY4xP1nzw//vI5ldcfJTi8TWrLzZbQb
	yyAIlOJwo+mKZcbiQwB5/5Nyap/rsWoUqEBo2LULVD6PJ+cdX2parYZSs881DtzjOXOqhL1K6PQ
	NYuDq39j2IxBXQYrafHyisoJtH3jFEMtzdZSCdCAcRv12h06T/rXI5pkWcVMZima7D1mo9KwZ7T
	HynRhVcsUc2t2jG02D0oZc5X7puDLBqmRSeAVC77NFvmNky0MYUS/xw4vT3FjempldU5Hd+tXqW
	I1i6zln7+RsLkCiK11aFtTVjwolOMkY71sCkBPh61wSAWEFeprRxvF5eIZnSicwhKQm4gjeQv8K
	0Lj0wAXnszLv45XuxXSh8AhZXhHTDguHYy2A==
X-Received: by 2002:a05:600c:34d5:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-486f4457b0fmr58582705e9.26.1773845123402;
        Wed, 18 Mar 2026 07:45:23 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97e8esm145382435e9.5.2026.03.18.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:45:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Schatzberg
 <dschatzberg@meta.com>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add syscall ctx variable
 offset tests
In-Reply-To: <20260318103526.2590079-3-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
 <20260318103526.2590079-3-memxor@gmail.com>
Date: Wed, 18 Mar 2026 14:45:22 +0000
Message-ID: <878qbpkxh9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Add various tests to exercise fixed and variable offsets on PTR_TO_CTX
> for syscall programs, and cover disallowed cases for other program types
> lacking convert_ctx_access callback. Load verifier_ctx with CAP_SYS_ADMIN
> so that kfunc related logic can be tested. While at it, convert assembly
> tests to C.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  34 +-
>  .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
>  3 files changed, 325 insertions(+), 67 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 8cdfd74c95d7..04d5f46264a3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -126,29 +126,35 @@ struct test_val {
>  __maybe_unused
>  static void run_tests_aux(const char *skel_name,
>  			  skel_elf_bytes_fn elf_bytes_factory,
> -			  pre_execution_cb pre_execution_cb)
> +			  pre_execution_cb pre_execution_cb,
> +			  bool drop_sys_admin)
>  {
>  	struct test_loader tester = {};
>  	__u64 old_caps;
>  	int err;
>  
> -	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
> -	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> -	if (err) {
> -		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> -		return;
> +	if (drop_sys_admin) {
> +		/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
> +		err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
> +		if (err) {
> +			PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> +			return;
> +		}
>  	}
>  
>  	test_loader__set_pre_execution_cb(&tester, pre_execution_cb);
>  	test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
>  	test_loader_fini(&tester);
>  
> -	err = cap_enable_effective(old_caps, NULL);
> -	if (err)
> -		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> +	if (drop_sys_admin) {
> +		err = cap_enable_effective(old_caps, NULL);
> +		if (err)
> +			PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
> +	}
>  }
>  
> -#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
> +#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, true)
> +#define RUN_WITH_CAP_SYS_ADMIN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL, false)
>  
>  void test_verifier_align(void)                { RUN(verifier_align); }
>  void test_verifier_and(void)                  { RUN(verifier_and); }
> @@ -173,7 +179,7 @@ void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
>  void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
>  void test_verifier_const(void)                { RUN(verifier_const); }
>  void test_verifier_const_or(void)             { RUN(verifier_const_or); }
> -void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
> +void test_verifier_ctx(void)                  { RUN_WITH_CAP_SYS_ADMIN(verifier_ctx); }
>  void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
>  void test_verifier_d_path(void)               { RUN(verifier_d_path); }
>  void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
> @@ -293,7 +299,8 @@ void test_verifier_array_access(void)
>  {
>  	run_tests_aux("verifier_array_access",
>  		      verifier_array_access__elf_bytes,
> -		      init_array_access_maps);
> +		      init_array_access_maps,
> +		      true);
>  }
>  void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_context); }
>  
> @@ -306,5 +313,6 @@ void test_verifier_value_ptr_arith(void)
>  {
>  	run_tests_aux("verifier_value_ptr_arith",
>  		      verifier_value_ptr_arith__elf_bytes,
> -		      init_value_ptr_arith_maps);
> +		      init_value_ptr_arith_maps,
> +		      true);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> index 371780290c0d..c054c8cb7242 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -4,6 +4,10 @@
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +const char ctx_strncmp_target[] = "ctx";
> +const char ctx_snprintf_fmt[] = "";
>  
>  SEC("tc")
>  __description("context stores via BPF_ATOMIC")
> @@ -69,7 +73,6 @@ __naked void ctx_pointer_to_helper_1(void)
>  SEC("socket")
>  __description("pass modified ctx pointer to helper, 2")
>  __failure __msg("negative offset ctx ptr R1 off=-612 disallowed")
> -__failure_unpriv __msg_unpriv("negative offset ctx ptr R1 off=-612 disallowed")
>  __naked void ctx_pointer_to_helper_2(void)
>  {
>  	asm volatile ("					\
> @@ -295,77 +298,324 @@ padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
>  SEC("syscall")
>  __description("syscall: write to ctx with fixed offset")
>  __success
> -__naked void syscall_ctx_fixed_off_write(void)
> +int syscall_ctx_fixed_off_write(void *ctx)
>  {
> -	asm volatile ("					\
> -	r0 = 0;						\
> -	*(u32*)(r1 + 0) = r0;				\
> -	r1 += 4;					\
> -	*(u32*)(r1 + 0) = r0;				\
> -	exit;						\
> -"	::: __clobber_all);
> +	char *p = ctx;
> +
> +	*(__u32 *)p = 0;
> +	*(__u32 *)(p + 4) = 0;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: read ctx with fixed offset")
> +__success
> +int syscall_ctx_fixed_off_read(void *ctx)
> +{
> +	char *p = ctx;
> +	volatile __u32 val;
> +
> +	val = *(__u32 *)(p + 4);
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: read ctx with variable offset")
> +__success
> +int syscall_ctx_var_off_read(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +	volatile __u32 val;
> +
> +	off &= 0xfc;
> +	p += off;
> +	val = *(__u32 *)p;
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: write ctx with variable offset")
> +__success
> +int syscall_ctx_var_off_write(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 0xfc;
> +	p += off;
> +	*(__u32 *)p = 0;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: reject negative variable offset ctx access")
> +__failure __msg("min value is negative")
> +int syscall_ctx_neg_var_off(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 4;
> +	p -= off;
> +	return *(__u32 *)p;
> +}
> +
> +SEC("syscall")
> +__description("syscall: reject unbounded variable offset ctx access")
> +__failure __msg("unbounded memory access")
> +int syscall_ctx_unbounded_var_off(void *ctx)
> +{
> +	__u64 off = (__u32)bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off <<= 2;
> +	p += off;
> +	return *(__u32 *)p;
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_fixed_off_read(void *ctx)
> +{
> +	char *p = ctx;
> +
> +	p += 4;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write ctx with fixed offset")
> +__success
> +int syscall_ctx_helper_fixed_off_write(void *ctx)
> +{
> +	char *p = ctx;
> +
> +	p += 4;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read ctx with variable offset")
> +__success
> +int syscall_ctx_helper_var_off_read(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 0xfc;
> +	p += off;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write ctx with variable offset")
> +__success
> +int syscall_ctx_helper_var_off_write(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 0xfc;
> +	p += off;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper read zero-sized ctx access")
> +__success
> +int syscall_ctx_helper_zero_sized_read(void *ctx)
> +{
> +	return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: helper write zero-sized ctx access")
> +__success
> +int syscall_ctx_helper_zero_sized_write(void *ctx)
> +{
> +	return bpf_probe_read_kernel(ctx, 0, 0);
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access ctx with fixed offset")
> +__success
> +int syscall_ctx_kfunc_fixed_off(void *ctx)
> +{
> +	char *p = ctx;
> +
> +	p += 4;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access ctx with variable offset")
> +__success
> +int syscall_ctx_kfunc_var_off(void *ctx)
> +{
> +	__u64 off = bpf_get_prandom_u32();
> +	char *p = ctx;
> +
> +	off &= 0xfc;
> +	p += off;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__description("syscall: kfunc access zero-sized ctx")
> +__success
> +int syscall_ctx_kfunc_zero_sized(void *ctx)
> +{
> +	bpf_kfunc_call_test_mem_len_pass1(ctx, 0);
> +	return 0;
>  }
Tests are comprehensive. Do we need to test rejection of unaligned read
too?
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  
>  /*
> - * Test that program types without convert_ctx_access can dereference
> - * their ctx pointer after adding a fixed offset. Variable and negative
> - * offsets should still be rejected.
> + * For non-syscall program types without convert_ctx_access, direct ctx
> + * dereference is still allowed after adding a fixed offset, while variable
> + * and negative direct accesses reject.
> + *
> + * Passing ctx as a helper or kfunc memory argument is only permitted for
> + * syscall programs, so the helper and kfunc cases below validate rejection
> + * for non-syscall ctx pointers at fixed, variable, and zero-sized accesses.
>   */
> -#define no_rewrite_ctx_access(type, name, off, ld_op)			\
> +#define no_rewrite_ctx_access(type, name, off, load_t)			\
>  	SEC(type)							\
>  	__description(type ": read ctx at fixed offset")		\
>  	__success							\
> -	__naked void no_rewrite_##name##_fixed(void)			\
> +	int no_rewrite_##name##_fixed(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 += %[__off];						\
> -		r0 = *(" #ld_op " *)(r1 + 0);				\
> -		r0 = 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__off, off)				\
> -		: __clobber_all);					\
> +		char *p = ctx;						\
> +		volatile load_t val;					\
> +									\
> +		val = *(load_t *)(p + off);				\
> +		(void)val;						\
> +		return 0;						\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject variable offset ctx access")	\
>  	__failure __msg("variable ctx access var_off=")			\
> -	__naked void no_rewrite_##name##_var(void)			\
> +	int no_rewrite_##name##_var(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r6 = r1;						\
> -		call %[bpf_get_prandom_u32];				\
> -		r1 = r6;						\
> -		r0 &= 4;						\
> -		r1 += r0;						\
> -		r0 = *(" #ld_op " *)(r1 + 0);				\
> -		r0 = 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm(bpf_get_prandom_u32)				\
> -		: __clobber_all);					\
> +		__u64 off_var = bpf_get_prandom_u32();			\
> +		char *p = ctx;						\
> +									\
> +		off_var &= 4;						\
> +		p += off_var;						\
> +		return *(load_t *)p;					\
>  	}								\
>  	SEC(type)							\
>  	__description(type ": reject negative offset ctx access")	\
> -	__failure __msg("negative offset ctx ptr")			\
> -	__naked void no_rewrite_##name##_neg(void)			\
> +	__failure __msg("invalid bpf_context access")			\
> +	int no_rewrite_##name##_neg(void *ctx)			\
>  	{								\
> -		asm volatile ("						\
> -		r1 += %[__neg_off];					\
> -		r0 = *(" #ld_op " *)(r1 + 0);				\
> -		r0 = 0;							\
> -		exit;"							\
> -		:							\
> -		: __imm_const(__neg_off, -(off))			\
> -		: __clobber_all);					\
> +		char *p = ctx;						\
> +									\
> +		p -= 612;						\
> +		return *(load_t *)p;					\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_helper_read_fixed(void *ctx)		\
> +	{								\
> +		char *p = ctx;						\
> +									\
> +		p += off;						\
> +		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_helper_write_fixed(void *ctx)		\
> +	{								\
> +		char *p = ctx;						\
> +									\
> +		p += off;						\
> +		return bpf_probe_read_kernel(p, 4, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read ctx with variable offset") \
> +	__failure __msg("variable ctx access var_off=")			\
> +	int no_rewrite_##name##_helper_read_var(void *ctx)		\
> +	{								\
> +		__u64 off_var = bpf_get_prandom_u32();			\
> +		char *p = ctx;						\
> +									\
> +		off_var &= 4;						\
> +		p += off_var;						\
> +		return bpf_strncmp(p, 4, ctx_strncmp_target);		\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write ctx with variable offset") \
> +	__failure __msg("variable ctx access var_off=")			\
> +	int no_rewrite_##name##_helper_write_var(void *ctx)		\
> +	{								\
> +		__u64 off_var = bpf_get_prandom_u32();			\
> +		char *p = ctx;						\
> +									\
> +		off_var &= 4;						\
> +		p += off_var;						\
> +		return bpf_probe_read_kernel(p, 4, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper read zero-sized ctx access") \
> +	__failure __msg("R4 type=ctx expected=fp")			\
> +	int no_rewrite_##name##_helper_read_zero(void *ctx)		\
> +	{								\
> +		return bpf_snprintf(0, 0, ctx_snprintf_fmt, ctx, 0);	\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject helper write zero-sized ctx access") \
> +	__failure __msg("R1 type=ctx expected=fp")			\
> +	int no_rewrite_##name##_helper_write_zero(void *ctx)		\
> +	{								\
> +		return bpf_probe_read_kernel(ctx, 0, 0);			\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc ctx at fixed offset")	\
> +	__failure __msg("dereference of modified ctx ptr")		\
> +	int no_rewrite_##name##_kfunc_fixed(void *ctx)		\
> +	{								\
> +		char *p = ctx;						\
> +									\
> +		p += off;						\
> +		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
> +		return 0;						\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc ctx with variable offset")	\
> +	__failure __msg("variable ctx access var_off=")			\
> +	int no_rewrite_##name##_kfunc_var(void *ctx)			\
> +	{								\
> +		__u64 off_var = bpf_get_prandom_u32();			\
> +		char *p = ctx;						\
> +									\
> +		off_var &= 4;						\
> +		p += off_var;						\
> +		bpf_kfunc_call_test_mem_len_pass1(p, 4);		\
> +		return 0;						\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject kfunc zero-sized ctx access")	\
> +	__failure __msg("R1 type=ctx expected=fp")			\
> +	int no_rewrite_##name##_kfunc_zero(void *ctx)			\
> +	{								\
> +		bpf_kfunc_call_test_mem_len_pass1(ctx, 0);		\
> +		return 0;						\
>  	}
>  
> -no_rewrite_ctx_access("syscall", syscall, 4, u32);
> -no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
> -no_rewrite_ctx_access("tracepoint", tp, 8, u64);
> -no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
> -no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
> -no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
> -no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
> -no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), u64);
> +no_rewrite_ctx_access("kprobe", kprobe, 8, __u64);
> +no_rewrite_ctx_access("tracepoint", tp, 8, __u64);
> +no_rewrite_ctx_access("raw_tp", raw_tp, 8, __u64);
> +no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, __u64);
> +no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, __u64);
> +no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, __u32);
> +no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), __u64);
>  
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 94edbd2afa67..f91b484d80f2 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -716,6 +716,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
>  BTF_ID_FLAGS(func, bpf_kfunc_common_test)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
> @@ -1280,7 +1281,6 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
> -BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
> -- 
> 2.52.0
