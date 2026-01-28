Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56321FF30
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613939; cv=none; b=BjHyLmuuUmL0Gu7xfY0DOvFDsb8+vTw1yhr9bGj4wMfCKUX9fkbWalUWfErG+w3xQHIRiOxg75zedVOolwDi303nqyS3UIjfmsZiBIoWzJWn1obWDbiIurJ1OaykGXzgc02MmoR2Tx0pQUSdzhpIIvCC0wx63OZH5XSDKgFNRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613939; c=relaxed/simple;
	bh=/jtDXuVaP09piBBDCaXgni7AqFCbL7j8PD6ATS7yyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEF7EJECZyU789t7pDZa51zBL4EsODNxgtNqoGnpEYyoJCBon4EtOGUF0F9foJLI+fnRruybDfl9B0Fppw0l9F5Lt+r6wciZ9LApnUjqhFo3ceL+H4Ovx6ltKGpSVX9luQyWpxlkwUS4AqHDdVCf412V1rLlGXFnT9YUQQhuI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9uEVaG7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9uEVaG7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso3084099b3a.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769613938; x=1770218738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRay3Vursv60IOvZlH+eNockW+N8+jbMH24O+Il/+jY=;
        b=j9uEVaG7kDhvsm8qp+xEFxCcySL9KloUU+VO1npuPmGcpvfgMOU/Pfd4UDTBiYUO/+
         jpW20X3cWGHeSO7WuZyTEKbQlZBFG8/tz/lSYy+qQTEZstL9SwLqsfmh1luYEJA72s1k
         lmw4GadIYku1kslcnDmpCxmOWMYHG4lhr+wNgpDv8PJnqpw2Nf2V/hB8O3JUJyPwaY+O
         nSh7QKTPyneubzYL7+qRS7Ndx2LKq8Wup3E/E3BmUJGKhjCjzPWpP2oKh1eWFUW75wFO
         xznaoYiCcpDGWHz9jusQJsTAx31Qt2AfNYqhxELvbFSjMGTKvNohAZoer/CPpzwzXXPF
         DtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769613938; x=1770218738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRay3Vursv60IOvZlH+eNockW+N8+jbMH24O+Il/+jY=;
        b=sw9kNpsMclVnLQc2cET7Pc5iFggLLRiySiY1Msd+ju2GQV4IUnhlI8cW28/7hurB6k
         rUVcvZMbYEEz5TNpJlADwIALqT5IFz+bmqryaf61A2sv6JjocnGzeTT+XVIgJShFT9UZ
         p2tKlFld+h9k3mYPptgH1WMGjemalfla0d2w8DPJw287/o+/QyJN9KpK9DqgcDLSP3Wm
         qpi2kkxSxYZBk6vUxhnlJxbw+nDoIGOZR965R3S+mLBgrBVwbOAnHiPQ5U9H9gjbMk51
         PGVOhioiH7mWqRlJV3gblDzMNyh8/Vh4Tp48xsq99nE+wpt2M5a2cbCPm3kOEkyRgsku
         giHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPWv6PsMWXNaw8eC6gMcKbYGHwkO8WWYRjrC0o/Kz5gxtAl/1ABiE2vxoefjm7KTZKHbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUqKS3WpRZcSEoU1fPHC/mm+SYuvgDx744EOudLexaNjyjwF9
	bGWvdLt8wNJ8tHnI1g1p2rFo3YPKRrrokl6lhVkSaDFbVlyS48AUCTZ4
X-Gm-Gg: AZuq6aLgh+Ugzuntdtybo1LlToPk9xRQ7m+Mgt9b0U/+1wWGztKYzxG972yPblMKDyB
	XLBpl2aSt1zesjW++2rM7NvUCl8GukrnIGHWAyG1jH2BOgo0p+ik23+U8fCdeFQoSQq52ZPWbev
	V14fTtUwmjj82cwAQqme344ISgKldtz6XrI0MwHgtpkD635qdu7VthpHCiN+6RuqqAGiJBJT4Ql
	QAkOdNjk7DSCHEojiwFqE+62vU/SjoyCis5ECX8W6ERWXj80A1S7gBb/Whq/c/2a/6dLC/+AID2
	/HNvDTxkgt0+y6CFN4N9aV1jpUXYLgryHms+jj6TNvXwP++6+WSBx+NipPgqTxBLiKCHzGkGDer
	O3Bna2ua2jw4mQuiYLMOTGwu7I7+fUPGvBLUc1pLgaYsEal7b0w5djUPziER+25juKn/15t10a3
	/qBaatpudtxTJKxgEyG8FEH9rs
X-Received: by 2002:a05:6a00:22c7:b0:81f:3d13:e070 with SMTP id d2e1a72fcca58-82369147791mr5966140b3a.12.1769613937562;
        Wed, 28 Jan 2026 07:25:37 -0800 (PST)
Received: from [172.20.10.5] ([117.20.154.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm3121727b3a.24.2026.01.28.07.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 07:25:36 -0800 (PST)
Message-ID: <8dd73aac-3c98-4bde-966d-2251dc794073@gmail.com>
Date: Wed, 28 Jan 2026 23:25:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260128150112.8873-1-leon.hwang@linux.dev>
 <20260128150112.8873-2-leon.hwang@linux.dev>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20260128150112.8873-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry about the subject.

It should be "bpf: Add bpf_jit_supports_fsession()".


On 2026/1/28 23:01, Leon Hwang wrote:
> fsession programs can currently be loaded on architectures that do not
> implement fsession support, which leads to runtime errors instead of a
> clean verifier rejection.
> 
> For example, running fsession selftests on arm64 before fsession support
> is added results in:
> 
> test_fsession_basic:PASS:fsession_test__open_and_load 0 nsec
> test_fsession_basic:PASS:fsession_attach 0 nsec
> check_result:FAIL:test_run_opts err unexpected error: -14 (errno 14)
> 
> Introduce bpf_arch_supports_fsession() to explicitly gate fsession usage
> based on architecture support. Architectures without fsession support
> will now fail program load with -EOPNOTSUPP, allowing selftests to skip
> cleanly instead of errors at runtime.
> 
> x86 declares fsession support, while the default implementation returns
> false.
> 
> Fixes: 2d419c44658f ("bpf: add fsession support")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c                   |  5 +++
>  include/linux/filter.h                        |  1 +
>  kernel/bpf/core.c                             |  5 +++
>  kernel/bpf/verifier.c                         |  3 ++
>  .../selftests/bpf/prog_tests/fsession_test.c  | 32 ++++++++++++++-----
>  5 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5a075e06cf45..070ba80e39d7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_fsession(void)
> +{
> +	return true;
> +}
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fd54fed8f95f..4e1cb4f91f49 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1167,6 +1167,7 @@ bool bpf_jit_supports_arena(void);
>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>  bool bpf_jit_supports_private_stack(void);
>  bool bpf_jit_supports_timed_may_goto(void);
> +bool bpf_jit_supports_fsession(void);
>  u64 bpf_arch_uaddress_limit(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>  u64 arch_bpf_timed_may_goto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e0b8a8a5aaa9..3b1eb632bf7c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3142,6 +3142,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>  	return false;
>  }
>  
> +bool __weak bpf_jit_supports_fsession(void)
> +{
> +	return false;
> +}
> +
>  u64 __weak bpf_arch_uaddress_limit(void)
>  {
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2f2650db9fd..6f867ebf78d1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24872,6 +24872,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	case BPF_TRACE_FENTRY:
>  	case BPF_TRACE_FEXIT:
>  	case BPF_TRACE_FSESSION:
> +		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
> +		    !bpf_jit_supports_fsession())
> +			return -EOPNOTSUPP;
>  		if (!btf_type_is_func(t)) {
>  			bpf_log(log, "attach_btf_id %u is not a function\n",
>  				btf_id);
> diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
> index 0c4b428e1cee..a299aeb8cc2e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
> @@ -29,8 +29,16 @@ static void test_fsession_basic(void)
>  	struct fsession_test *skel = NULL;
>  	int err;
>  
> -	skel = fsession_test__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
> +	skel = fsession_test__open();
> +	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
> +		return;
> +
> +	err = fsession_test__load(skel);
> +	if (err == -EOPNOTSUPP) {
> +		test__skip();
> +		goto cleanup;
> +	}
> +	if (!ASSERT_OK(err, "fsession_test__load"))
>  		goto cleanup;
>  
>  	err = fsession_test__attach(skel);
> @@ -47,8 +55,16 @@ static void test_fsession_reattach(void)
>  	struct fsession_test *skel = NULL;
>  	int err;
>  
> -	skel = fsession_test__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
> +	skel = fsession_test__open();
> +	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
> +		return;
> +
> +	err = fsession_test__load(skel);
> +	if (err == -EOPNOTSUPP) {
> +		test__skip();
> +		goto cleanup;
> +	}
> +	if (!ASSERT_OK(err, "fsession_test__load"))
>  		goto cleanup;
>  
>  	/* first attach */
> @@ -94,6 +110,10 @@ static void test_fsession_cookie(void)
>  	bpf_program__set_autoload(skel->progs.test6, false);
>  
>  	err = fsession_test__load(skel);
> +	if (err == -EOPNOTSUPP) {
> +		test__skip();
> +		goto cleanup;
> +	}
>  	if (!ASSERT_OK(err, "fsession_test__load"))
>  		goto cleanup;
>  
> @@ -111,10 +131,6 @@ static void test_fsession_cookie(void)
>  
>  void test_fsession_test(void)
>  {
> -#if !defined(__x86_64__)
> -	test__skip();
> -	return;
> -#endif
>  	if (test__start_subtest("fsession_test"))
>  		test_fsession_basic();
>  	if (test__start_subtest("fsession_reattach"))

