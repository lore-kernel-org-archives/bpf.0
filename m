Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4050255F
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901566; cv=none; b=fuWjyXe3/iPacfQIbxPSeSYzApoLbOrcFwdkfk5atIMmVPYyBgApZYL4XSPuk2+en6o42gDmQI5BgnpjWBNzONnIvnD4mYi/UVVQHUmQnCwIQntolSymJe06Qzpj3yMXDtkz/xkacHaxa/z9NVfcPAdEhNgfUNRXGuquVIRE0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901566; c=relaxed/simple;
	bh=NyLlmoJrUzrbPSJQk0ZNFoepQqGUbwDRoFt1ZJcd/EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM3LrsZdjLQxjcDu4Z86I/dG9ry8ZqMfNWvkvAPDzrSMzkU76ubyPOS3IPoNWEANa+LgwIqjBmvW87U4oZhL6bGivNLHHUCiduz3aidjXG9o0/nmTRwlTJUhO9Sj93AEZS08XH20xQ9xciMdEljmKCpDjLSXeta0ThAt/zTMmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yg+CTecB; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yg+CTecB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NyLlmoJrUzrbPSJQk0ZNFoepQqGUbwDRoFt1ZJcd/EM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791901561; v=1; x=1792506361;
 b=Yg+CTecBAyt/B5NexlmwMiE1DkpLv4NKVOOqfBXnmnwplVYiruGJVjX/MqvDf8Fb9n1xssCP
 kcoV33HZiiVejTap9lMLRGk2GzFHXG5hBa7JnHC/LWUuHCEp7AyBwaWeUGlO7msYHkwer1DFuO1
 l8jkfBMyZUFOw7pIhMFoNXt8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e0d2199c220c93f6;
	Tue, 13 Oct 2026 14:26:01 +0000
X-Mizu-Trace-ID: e0d2199c220c93f6
X-Migadu-Flow: FLOW_OUT
Message-ID: <4c2cf439-63b2-43c8-87f9-7c51125c3cc7@linux.dev>
Date: Tue, 13 Oct 2026 07:25:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Test trampolines on more
 BPF functions with stack args
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261013003429.1853052-1-yonghong.song@linux.dev>
 <20261013003515.1860439-1-yonghong.song@linux.dev>
 <sashiko-outbox-168817@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-168817@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/26 2:51 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: check_unreliable_func_args incorrectly counts slots, allowing corrupting trampoline
> --
>
> commit c87f5bcaff5cc54c864fa434bbfefe8d6bff2bbc
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Test trampolines on more BPF functions with stack args
>
> Add two functions to the BPF target program of the int128_tgt_prog test.
> callee_split() takes a struct holding an __int128 after five u64s, so
> on x86-64 it is passed split between r9 and the stack.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> index ad46eabe784f8..e68fd5627ec1c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> [ ... ]
>> +/*
>> + * A static function whose BTF is unreliable gets a trampoline that only knows
>> + * of the register arguments, so one taking stack arguments must be refused.
>> + */
>> +static void test_tgt_prog_unreliable(void)
>> +{
> [ ... ]
>> +	err = bpf_program__set_attach_target(tracer->progs.unreliable_entry, fd,
>> +					     "callee_unreliable");
>> +	if (!ASSERT_OK(err, "set_attach_target"))
>> +		goto out;
>> +
>> +	err = tracing_struct_int128_tracer__load(tracer);
>> +	ASSERT_ERR(err, "tracer__load");
>> +	ASSERT_HAS_SUBSTR(log_buf, "unreliable BTF and stack arguments", "log");
> [Severity: High]
> While this test accurately checks callee_unreliable() which takes 6 scalar
> arguments, is there a potential issue in the verifier's
> check_unreliable_func_args() when dealing with struct arguments that occupy
> multiple slots?
>
> In kernel/bpf/verifier.c:check_unreliable_func_args(), if
> btf_distill_func_proto() fails (e.g. because an argument is a struct larger
> than 16 bytes), the fallback path counts the number of arguments instead
> of 8-byte slots:
>
> 	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
> 		/* at least a slot for each argument */
> 		nslots = btf_type_vlen(func_proto);
> 	}
>
> For a BPF subprogram taking a 32-byte struct by value and 4 other arguments
> (5 arguments total), the actual slot count is 1 + 1 + 1 + 1 + 4 = 8 slots
> (meaning 3 slots are on the stack). But the fallback calculates nslots = 5.

The compiler should already change 32-byte struct to a pointer to struct,
so the actual slot count should be 5. So we should be okay.

>
> Since 5 <= MAX_BPF_FUNC_REG_ARGS (5), check_unreliable_func_args()
> incorrectly returns 0, permitting attachment.
>
> The generated trampoline will not save or restore the stack arguments.
>
> Does this cause the target BPF subprogram to read uninitialized stack
> memory from the trampoline frame as its arguments, leading to data corruption
> and undefined behavior?
>

