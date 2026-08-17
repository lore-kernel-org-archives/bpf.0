Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA04B0491;
	Mon, 17 Aug 2026 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933026; cv=none; b=ovTB0conUy4ROEDnRZSHHzLab5SaKkEHvF9RTozrOkSBrxHLd/zFvXJMfKQ00M4UYK033tuj18kzp6pDVsFPEQGlt6QyHziO/EV/c+Wt+6M4IsW/v1ssfjlRl2xXf+I9a+s2ab9AMerHNrPlQj5lHPhMDbfYWVHHPcjVEXooUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933026; c=relaxed/simple;
	bh=Ln1yFhAR7CM3NpHn/pMZE8Y+oColfmphkLnZ9tJ3iX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W1XxAKg2xi+r7WZEiug1zpL4U0RAPtueYc4fhqj2PHaT6Y5wHSuuVPeV4UINatbxnA8wi+dj3UWlC3GMO1Fh9Vv291kD8gQw4NPOaHYJTXgFfgaD6f3d9i++yUioIxZqlt8tonoz/hAmr5eUr47oiKS036Fx3vPt0uvwqsGwHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AgxdaTeh; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AgxdaTeh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZbFDu/0nbJJ7HMlwOHKVUYA4S3DaNydS6nkSMhavzm0=;
	b=AgxdaTehaKaiJQ0jIb2jp1nkZ4PA8W5QMJuS+CKP/sPVHFTvlc3ZPTuxa6kUpRpSwqDOnNDnS
	ZzH1CB1l9x8ByjAEE1PggUOoPvE45OorkVgpWCHvmgClrrbOhcJS8jvcVWJuricxF4Veu75w7Vm
	QVQEIEcsawovOYFdz5/fAUk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hNbm46vp0z1K96b;
	Mon, 17 Aug 2026 10:06:12 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EC8D3402AB;
	Mon, 17 Aug 2026 10:16:52 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 17 Aug
 2026 10:16:52 +0800
Message-ID: <8331116a-2a90-4342-a1d2-bd3a97bebb73@huawei.com>
Date: Mon, 17 Aug 2026 10:16:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: reject stack-argument callback subprograms
Content-Language: en-US
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, Yonghong
 Song <yonghong.song@linux.dev>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)

+cc Yonghong

On 2026/8/17 4:45, Jérémy Jean wrote:
> Helper callbacks enter BPF subprograms through bpf_callback_t, whose
> runtime ABI supplies five arguments. BTF validation nevertheless permits
> static callback subprograms to declare more than five arguments when JIT
> stack arguments are supported.
> 
> This lets verifier state for a callback use outgoing stack argument slots
> prepared at the helper call site. The helper does not pass those slots. On
> x86-64, callback loads of arguments seven and later therefore read the
> helper native frame instead of the synthetic values checked by the
> verifier. KASAN reports a slab OOB write.
> 
> Reject callback subprograms with incoming stack arguments when processing
> callback calls. Add a verifier regression test using bpf_loop() and a
> nine-argument callback.
> 
> Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>   kernel/bpf/verifier.c                         |  4 +++
>   .../selftests/bpf/progs/verifier_stack_arg.c  | 33 +++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78c..29aa4911c7f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9285,6 +9285,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>   	err = btf_check_subprog_call(env, subprog, caller->regs);
>   	if (err == -EFAULT)
>   		return err;
> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog])) {
> +		verbose(env, "callback subprog cannot have stack args\n");
> +		return -EINVAL;
> +	}

Just took a look at stack args feature. The limit looks good to me, but 
it would be better to split the fix and selftest into two separate patches.

>   
>   	/* set_callee_state is used for direct subprog calls, but we are
>   	 * interested in validating only BPF helpers that can call subprogs as
> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 7e0ce5db28a0..5acc3b63ca84 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -27,6 +27,13 @@ static int subprog_7args(int a, int b, int c, int d, int e, int f, int g)
>   	return a + b + c + d + e + f + g;
>   }
>   
> +__noinline __used
> +static int callback_9args(__u32 index, void *ctx, long a3, long a4,
> +			  long a5, long a6, long a7, long a8, long a9)
> +{
> +	return a9;
> +}
> +
>   __noinline __used
>   static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
>   {
> @@ -79,6 +86,32 @@ __naked void stack_arg_two_subprogs(void)
>   	);
>   }
>   
> +SEC("tc")
> +__description("stack_arg: callback with incoming stack args")
> +__failure
> +__msg("callback subprog cannot have stack args")
> +__naked void stack_arg_callback_many_args(void)
> +{
> +	asm volatile (
> +		"r6 = 0;"
> +		"*(u64 *)(r11 - 32) = 0;"
> +		"*(u64 *)(r11 - 24) = 0;"
> +		"*(u64 *)(r11 - 16) = 0;"
> +		"*(u64 *)(r11 - 8) = 0;"
> +		"r1 = 1;"
> +		"r2 = %[callback_9args];"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"call %[bpf_loop];"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm_ptr(callback_9args),
> +		  __imm(bpf_loop)
> +		: __clobber_all
> +	);
> +}
> +
>   SEC("tc")
>   __description("stack_arg: read from uninitialized stack arg slot")
>   __failure
