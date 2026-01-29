Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0D2FE566
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650193; cv=none; b=QSAC5ZR3703qvOFSO46cz5Pt6jGLRCoWDG4V2VnnC9iY+6s5fe+DNfUIDa2B3MFw6fSSbddsFgK0j6ijF+YtKV3zHwuxslqgdNWFltm/JJvct2f2GSR2FBjerxq8FJfcj9jqojAEqL2speMIA/cW4B9pudGRiuf17xMfNX5EnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650193; c=relaxed/simple;
	bh=iGW6n1L0TDbKJIoGDSw3h/gS3PLZaJhSkhhOFFXqDLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6h4SjKt7OL9TWy0wPqogv4TFwhEftaD6HFs3ChqkLlW3dnN3nw6j5yhLfR5a5DDvJRvcvQohJU1kHxTlih2uIYtiYjRdNAzNwqcMKd8G1omju1JXAHX7DaJAW2jenxQVz4r82uMkTDbPxlBtYk3TOi+2TCe+2VEFKDvbH2h+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S5tuMrKY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S5tuMrKY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769650176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtWFc0P/X3zZfkPNCFcQLlcTxCjLef1x+lLjFThYQOk=;
	b=S5tuMrKY/4s/89/wtpe7uzV7JVItb7v7qwexPUMjqusZiao/vbafKiS4MSznuQNbO/ViVP
	7sL0z1PnSZZ3cqJ0xU5Hn6r8e1D7j+W3QSF0+uYyDwrPMzQ4QqNN1gQCmTYUFV08EBCS74
	47ESqs3t439DaOn9iKezm45dyOwlMR0=
From: Menglong Dong <menglong.dong@linux.dev>
To: bpf@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
Date: Thu, 29 Jan 2026 09:29:20 +0800
Message-ID: <3392533.aeNJFYEL58@7940hx>
In-Reply-To: <20260128150112.8873-2-leon.hwang@linux.dev>
References:
 <20260128150112.8873-1-leon.hwang@linux.dev>
 <20260128150112.8873-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/28 23:01 Leon Hwang <leon.hwang@linux.dev> write:
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

I were wondering how this problem happen, as I remember that
I added such checking. When I look back, I found that the checking
is lost during v3->v4. I recalled that the AI warned me about this
part, but I thought that checking exists in my mind :/

It seems that we can't ignore the AI's warning easily. It mostly
make sense.

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

Ah, I see you enabled the testing for arm64 in this patch. Maybe
we can move this part to the 3rd patch, or split it out to another
patch?

TBH, I prefer the previous implement. In this way, the CI can
still pass if x86_64 or arm64 return -EOPNOTSUPP, right?

Maybe you can test the not-supported case stand alone, such
as:

#if !defined(__x86_64__)
	test__fsession_not_support();
	return;
#endif

wdyt?

Thanks!
Menglong Dong

>  	if (test__start_subtest("fsession_test"))
>  		test_fsession_basic();
>  	if (test__start_subtest("fsession_reattach"))
> -- 
> 2.52.0
> 
> 
> 




