Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EB38CFFF
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418930; cv=none; b=aggVrBdbbHQ3M+PuVpIX9BOE/uOVUO5iZDNI1PxdN+AVaefu3cPa/tvjP/yDDCsNaync7ucvlyWAMGh/R5ZRSvvbi3ZN2/F8H3JvWhfLM3OKRsBnnQ8o+844+kZ5XovoAvgQiBuvsrVUdENhn0Et+F+EPWYGQ9ijOBdBmH0Ua5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418930; c=relaxed/simple;
	bh=kvpcehoMduKDxA1yvFCo4yTCM0jz1bcpNtVoumgt2Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oMkqGRW9sjtrWzcU8qojtXm86gnWgcO1u7tYwhmI+spnlpIY7I3KNvc5d02COSW7kpZRvA+7iVlvRLqEzfLX7PFKz04JmesLCnMgmcBhkb0H1TjM5HqaZfZ+a4VAEGttZLGuYeZvFv51+4uUkHBHwiZdOr+6xpRp+tb4SRLmiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKNVTR1k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKNVTR1k"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso27618005e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773418926; x=1774023726; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVUcrM5mSMmhElIpYnOQdSPu3JaamQtAtE8ULTNtIkE=;
        b=DKNVTR1khJx8lY1MUKrHwGo9VorPnyOTfOrM+ApNZ+EUJjH2rJZDTBzThdUR69dHAl
         ltw0wKu8FraimfhGJAt+lEpmCdwERcctmOWsyajIsWydy05VViZjn/SR1oaAo2LHgmim
         YfDKJRd1gzoUj0kWq8t8mFQmIgo8HRLaQ8Qw1UEsKTt+qO/9NowUAA4RCl28BI8fNBsN
         j4LTJjA0R2odt6GRLLlMAHi6dj7RiblgLJh13y7ZHcdr7VJFbk+KLOEtvm7/pBpwQ9jC
         1MRx7bWmeHxq4rRTvqOZqghuRZ2CA394MGjEJTTHwwtOuvt2ygyVnI1wyF3rwR5iwZlS
         88+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418926; x=1774023726;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVUcrM5mSMmhElIpYnOQdSPu3JaamQtAtE8ULTNtIkE=;
        b=H/BYRSI7P9gGDGCrjcGj0ABLijKI/MwbG37AbhRJyU8gaPojy2IYZOVkwl1PrOyYPG
         42G392yM8YxyvnxAZbFG+/0lXasEUIyqbvlL8SRNzh00WyU2V3TZYfaxw+YpdfVEZ9Zi
         B0izQ7BpNZRdpJAFSu1PoSGnJhGG6wlfcPPRb+IJ6ImbbI6LNq2KQQC1vXBj2/0LKlHM
         CoYoySI5c0Ptrc7dmD66/m5aNqTVcFp6kE46RShP2wauK80ZA/3IH18lu4l+hsODjnlT
         jD8qYfiEauZug8h9lUzvDLy3bqvzSt/rsWdlpaWg/30O9BgMp96GFFgpVAvuuzDYCuq2
         cbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXhZLeVhRJLOCagQvuES/oRq6gT4zwOnlAXiP7hjmzT6E1X5DRkuijHCRHEMfKnBi7pzoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjFZcbfzYjYOIo+kodJdZQW4kSa7xxefQz6tKAFAMTcVWw308
	jNUHqh1ZED92wrpBcyp7+fvpgVgkq/5dB4FMgMAFDilDUml4dPhnmLeD
X-Gm-Gg: ATEYQzztO+fJwA3Sbfz5K0BvvTN7VkEZDPYLLFnenFPTdyr+iS9WYhn8pZASIaO4zBO
	it+GU46JOuY87xZlQ6DSHm1rZAtZWihkyxy/hZF9PVWtfT3jdkDUUm+Iyzb7U69Li2l9Lsigi2D
	0gqYAh07vhBwTOKLIf27y6fN3JFXXGzCN9V/I9O6ug6s48ERZq2v1g7Fv6UxO/hUbW8E+wGVgK8
	SslpMvMTSs9mP4dFtRl8cOTcTImMvWZ57hHJPyjklW/BNmkKx8wZV+h3BVc8hbtCuR0UColwYk2
	vPwJmdz9lu8CJMSwPScT+dRnIfY2qq3sR0szLqmHLixz8NMmgxI2JD1Eyf58ojb0gKbBLlRcbun
	3Ukog6o1MDVnn3XEyb34AZj99emURBq0vWfE69QtEZg8nHnT1bjLTHWQ4z2HA4Fte5oubV62o1L
	6+v4sPCzJp/IV3YbRhG+JPWbTlQ7aaNxk05NNQmw==
X-Received: by 2002:a05:600c:3ba8:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-485566dda4amr70204795e9.13.1773418926142;
        Fri, 13 Mar 2026 09:22:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm322295765e9.4.2026.03.13.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:22:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve test coverage for
 kfunc call
In-Reply-To: <20260312080113.843408-1-hbathini@linux.ibm.com>
References: <20260312080113.843408-1-hbathini@linux.ibm.com>
Date: Fri, 13 Mar 2026 16:22:05 +0000
Message-ID: <87fr63aedu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hari Bathini <hbathini@linux.ibm.com> writes:

> On powerpc, immediate load instructions are sign extended. In case
> of unsigned types, arguments should be explicitly zero-extended by
> the caller. For kfunc call, this needs to be handled in the JIT code.
> In bpf_kfunc_call_test4(), that tests for sign-extension of signed
> argument types in kfunc calls, add some additional failure checks.
> And add bpf_kfunc_call_test5() to test zero-extension of unsigned
> argument types in kfunc calls.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> Changes in v2:
> - Added asm version of the selftest for consistent testing across
>   different BPF ISA versions.
> - Added comments clearly stating the intent of the test cases.
> - Updated sign-extension selftest to have additional failure checks.
>
>
>  .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
>  .../selftests/bpf/progs/kfunc_call_test.c     | 98 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 54 +++++++++-
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
>  4 files changed, 154 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> index f79c8e53cb3e..62f3fb79f5d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> @@ -74,6 +74,8 @@ static struct kfunc_test_params kfunc_tests[] = {
>  	TC_TEST(kfunc_call_test1, 12),
>  	TC_TEST(kfunc_call_test2, 3),
>  	TC_TEST(kfunc_call_test4, -1234),
> +	TC_TEST(kfunc_call_test5, 0),
> +	TC_TEST(kfunc_call_test5_asm, 0),
>  	TC_TEST(kfunc_call_test_ref_btf_id, 0),
>  	TC_TEST(kfunc_call_test_get_mem, 42),
>  	SYSCALL_TEST(kfunc_syscall_test, 0),
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> index 8b86113a0126..5edc51564f71 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> @@ -2,8 +2,106 @@
>  /* Copyright (c) 2021 Facebook */
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
>  #include "../test_kmods/bpf_testmod_kfunc.h"
>  
> +SEC("tc")
> +int kfunc_call_test5(struct __sk_buff *skb)
> +{
> +	struct bpf_sock *sk = skb->sk;
> +	int ret;
> +	u32 val32;
> +	u16 val16;
> +	u8 val8;
> +
> +	if (!sk)
> +		return -1;
> +
> +	sk = bpf_sk_fullsock(sk);
It looks like this socket stuff is not really needed in this test. 
> +	if (!sk)
> +		return -1;
> +
> +	/*
> +	 * Test with constant values to verify zero-extension.
> +	 * ISA-dependent BPF asm:
> +	 *   With ALU32:    w1 = 0xFF; w2 = 0xFFFF; w3 = 0xFFFFffff
> +	 *   Without ALU32: r1 = 0xFF; r2 = 0xFFFF; r3 = 0xFFFFffff
> +	 * Both zero-extend to 64-bit before the kfunc call.
> +	 */
> +	ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFffffULL);
> +	if (ret)
> +		return ret;
> +
> +	val32 = bpf_get_prandom_u32();
> +	val16 = val32 & 0xFFFF;
> +	val8 = val32 & 0xFF;
> +	ret = bpf_kfunc_call_test5(val8, val16, val32);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Test multiplication with different operand sizes:
> +	 *
> +	 * val8 * 0xFF:
> +	 *   - Both operands promote to int (32-bit signed)
> +	 *   - Result: 32-bit multiplication, truncated to u8, then zero-extended
> +	 *
> +	 * val16 * 0xFFFF:
> +	 *   - Both operands promote to int (32-bit signed)
> +	 *   - Result: 32-bit multiplication, truncated to u16, then zero-extended
> +	 *
> +	 * val32 * 0xFFFFffffULL:
> +	 *   - val32 (u32) promotes to unsigned long long (due to ULL suffix)
> +	 *   - Result: 64-bit unsigned multiplication, truncated to u32, then zero-extended
> +	 */
> +	ret = bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 * 0xFFFFffffULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * Assembly version testing the multiplication edge case explicitly.
> + * This ensures consistent testing across different ISA versions.
> + */
> +SEC("tc")
> +__naked int kfunc_call_test5_asm(void)
> +{
> +	asm volatile (
> +		/* Get a random u32 value */
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 = r0;"              /* Save val32 in r6 */
> +
> +		/* Prepare first argument: val8 * 0xFF */
> +		"r1 = r6;"
> +		"r1 &= 0xFF;"           /* val8 = val32 & 0xFF */
> +		"r7 = 0xFF;"
> +		"r1 *= r7;"             /* 64-bit mult: r1 = r1 * r7 */
> +
> +		/* Prepare second argument: val16 * 0xFFFF */
> +		"r2 = r6;"
> +		"r2 &= 0xFFFF;"         /* val16 = val32 & 0xFFFF */
> +		"r7 = 0xFFFF;"
> +		"r2 *= r7;"             /* 64-bit mult: r2 = r2 * r7 */
> +
> +		/* Prepare third argument: val32 * 0xFFFFffff */
> +		"r3 = r6;"              /* val32 */
> +		"r7 = 0xFFFFffff;"
> +		"r3 *= r7;"             /* 64-bit mult: r3 = r3 * r7 */
> +
> +		/* Call kfunc with multiplication results */
> +		"call bpf_kfunc_call_test5;"
> +
> +		/* Check return value */
> +		"if r0 != 0 goto exit_%=;"
> +		"r0 = 0;"
> +		"exit_%=: exit;"
> +		:
> +		: __imm(bpf_get_prandom_u32)
> +		: __clobber_all);
> +}
> +
>  SEC("tc")
>  int kfunc_call_test4(struct __sk_buff *skb)
>  {
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e62c6b78657f..94edbd2afa67 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -760,12 +760,63 @@ __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
>  
>  __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
>  {
> -	/* Provoke the compiler to assume that the caller has sign-extended a,
> +	/*
> +	 * Make val as volatile to avoid compiler optimizations.
> +	 * Verify that negative signed values remain negative after
> +	 * sign-extension (JIT must sign-extend, not zero-extend).
> +	 */
> +	volatile long val;
> +
> +	/* val will be positive, if JIT does zero-extension instead of sign-extension */
> +	val = a;
> +	if (val >= 0)
> +		return 1;
> +
> +	val = b;
> +	if (val >= 0)
> +		return 2;
> +
> +	val = c;
> +	if (val >= 0)
> +		return 3;
> +
> +	/*
> +	 * Provoke the compiler to assume that the caller has sign-extended a,
>  	 * b and c on platforms where this is required (e.g. s390x).
>  	 */
>  	return (long)a + (long)b + (long)c + d;
>  }
>  
> +__bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
> +{
> +	/*
> +	 * Make val as volatile to avoid compiler optimizations on the below checks
> +	 * In C, assigning u8/u16/u32 to long performs zero-extension.
> +	 */
> +	volatile long val = a;
> +
> +	/* Check zero-extension */
> +	if (val != (unsigned long)a)
> +		return 1;
> +	/* Check no sign-extension */
> +	if (val < 0)
> +		return 2;
> +
> +	val = b;
> +	if (val != (unsigned long)b)
> +		return 3;
> +	if (val < 0)
> +		return 4;
> +
> +	val = c;
> +	if (val != (unsigned long)c)
> +		return 5;
> +	if (val < 0)
> +		return 6;
> +
> +	return 0;
> +}
> +
>  static struct prog_test_ref_kfunc prog_test_struct = {
>  	.a = 42,
>  	.b = 108,
> @@ -1228,6 +1279,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index b393bf771131..aa0b8d41e71b 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -110,6 +110,7 @@ __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
>  int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
>  struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> +int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
>  
>  void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
>  void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> -- 
> 2.53.0
