Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAF214812
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697376; cv=none; b=G/gqYCgpFh2nh/oFFQmH8p+kogEEpdD8zbbMT9lDqyomBnrxAlSBGaIYqEKa8u8Ce7qdKEnu16Tq45tNFwrbfZ6jRJZncWL6eyKMKoIcfKW90KI9bMLMW9bGLFWgpKAR/MXy2XYz12KvuP/nhcyYCXR1MJqRUv9teoLX7u57MfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697376; c=relaxed/simple;
	bh=knObZZoXaHM3H75TTRhA62u72ja266TBRel3P4IUGSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=expdjuZatk9TvX57qRPsKmRu7MiRxY4lwtEk38wyfWhx07dDHWIhnQwc6d0x45YLcAIbl9OmYrYUF3CeWmhqB9OZoBQWhDRX7MmRzmlXKALYIMGODcFzYTUEMVdLvAttodewYLO1LRL2Ml8ln4PzPEzPz0W92gZAabbsJsuFUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z0+yl0uu; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z0+yl0uu"
Message-ID: <9401462c-ea70-4541-acb0-78cf2e6c34dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783697372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXiIb4G2Y6Na9zdV82XnxnRmzylX8534BTdTHojWgqo=;
	b=Z0+yl0uulz0auik+88i91CyVFLOv5xCNiAWEHwjnIWV7obLzygj4TeCukAiUdtYqCDTZEn
	Nee0o9zirqgonsm7ek6zdOsPsrl47zdJ9HC0ExqjhfcPTx3vzk7KuAjb9GwAwZ0z5bpUoV
	f32j4Ep1i+flzpEEsGyn1WfVZsgn2eQ=
Date: Fri, 10 Jul 2026 23:29:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for >8 byte return value
 on fexit attach
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
 <20260710144409.2580215-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260710144409.2580215-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/10 22:44, Yonghong Song wrote:
> The BPF trampoline preserves only 8 bytes of the target's return value
> (R0), so attaching an fexit/fmod_ret/fsession program to a function that
> returns a >8 byte value is now rejected by the verifier.
> 
> Add a bpf_testmod function returning __int128 and an fexit program that
> targets it. The program is expected to fail to load with the
> "with a >8 byte return value is not supported for this attach type"
> message.
> 
> __int128 is only available on 64-bit targets (where the compiler defines
> __SIZEOF_INT128__). Guard the testmod function and the test with
> __SIZEOF_INT128__ so a 32-bit build still compiles; on such builds
> the subtest is simply not run.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/tracing_failure.c      | 12 ++++++++++++
>  tools/testing/selftests/bpf/progs/tracing_failure.c |  6 ++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c  | 13 +++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> index f9f9e1cb87bf..6c199f5ff4db 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> @@ -76,6 +76,14 @@ static void test_fexit_noreturns(void)
>  			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
>  }
>  
> +#ifdef __SIZEOF_INT128__
> +static void test_fexit_int128_ret(void)
> +{
> +	test_tracing_fail_prog("fexit_int128_ret",
> +			       "with a >8 byte return value is not supported for this attach type");
> +}


Seems that this subtest can be simplified to

static void test_fexit_int128_ret(void)
{
#ifdef __SIZEOF_INT128__
	test_tracing_fail_prog("fexit_int128_ret",
			       "with a >8 byte return value is not supported for this attach
type");
#else
	test__skip();
#endif
}

Then, no '#ifdef' below.

Thanks,
Leon

> +#endif
> +
>  void test_tracing_failure(void)
>  {
>  	if (test__start_subtest("bpf_spin_lock"))
> @@ -86,4 +94,8 @@ void test_tracing_failure(void)
>  		test_tracing_deny();
>  	if (test__start_subtest("fexit_noreturns"))
>  		test_fexit_noreturns();
> +#ifdef __SIZEOF_INT128__
> +	if (test__start_subtest("fexit_int128_ret"))
> +		test_fexit_int128_ret();
> +#endif
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
> index 65e485c4468c..f7a095767679 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> @@ -30,3 +30,9 @@ int BPF_PROG(fexit_noreturns)
>  {
>  	return 0;
>  }
> +
> +SEC("?fexit/bpf_testmod_test_int128_ret")
> +int BPF_PROG(fexit_int128_ret)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 30f1cd23093c..902dbf658250 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -161,6 +161,15 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
>  	return bpf_testmod_test_struct_arg_result;
>  }
>  
> +#ifdef __SIZEOF_INT128__
> +noinline __int128
> +bpf_testmod_test_int128_ret(int a)
> +{
> +	bpf_testmod_test_struct_arg_result = a;
> +	return (__int128)a;
> +}
> +#endif
> +
>  __weak noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name(void)
>  {
>  }
> @@ -514,6 +523,10 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>  
>  	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
>  
> +#ifdef __SIZEOF_INT128__
> +	(void)bpf_testmod_test_int128_ret(i);
> +#endif
> +
>  	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
>  
>  	bpf_testmod_test_struct_ops3();

