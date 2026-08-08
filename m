Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F0342539
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206648; cv=none; b=cn+eHVkmMsVMgwaGOyjLTUQhYTym1u/0XMSy7OSF6cAhVtZtilTT6QdjBV4CAXZ1VjmYV09h3aWv1kTf6jV/3u4/po9WmyWZGCTI7XI3HzlS4dzSRXZP81l5tBwBfXBgchUyILL2jwISwslGxH8e9UIQV1kwsaspDVquB+Xol/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206648; c=relaxed/simple;
	bh=6OHBX06XpAWH9Xj0imh0dvh2OTfPYLS7iA+TIbk+CBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXWbuRJVjiARrnJCPaE1IbeEUsfp+XQB7sisteJzusHzLRv7Iqgxq/W3hQHs6H30izr23F105NyN9NzyIYsKgHiiEZR0NHq28d3zg9S6pK39bkApoBLvmHLpOcBeD4g9wIgT4B8XyV+WHdQR3Sbopi74ASbPo70mdwZhGht1e0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KqtKeCiu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KqtKeCiu"
Message-ID: <33aafabd-7db4-45ee-93b0-027c7bf09a1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786206634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IGz0cXXRnpTusVBShxd56OiZbcLO6S1q3JeX/Jf554=;
	b=KqtKeCiuqLOEmpEEwqDpLIJgUMsYY1UA4h455b6QEsS88m3efMnOiCmTNq/eOUwjAdl0ly
	VWzfvGEVMcPAEV5UKOuKa+CvEU01joH/4ig3qmK6rb1TGOayC1SoFjdcOhZBYMuUwYWZUq
	CZhH18JNmeeBKRsHM8Z3FsLU1pbYeYk=
Date: Sat, 8 Aug 2026 09:30:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260804203522.1869244-1-yonghong.song@linux.dev>
 <20260804203613.1877773-1-yonghong.song@linux.dev>
 <20260804204750.DD1C31F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260804204750.DD1C31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 1:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Unconditional use of `__int128` in the `bpf_testmod` kernel module causes build failures on architectures lacking 128-bit integer support.
> - [Low] Redundant BPF program FD validation after successful skeleton load.
> --
>
> --- Patch [10]: [PATCH bpf-next v2 10/13] selftests/bpf: Add C tests for 16-byte returns in R0:R2 ---
> commit 9e3dc1e0617b6a9acfcd02529cae781809d11bbc
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add C tests for 16-byte returns in R0:R2
>
> Add selftests that exercise a 16-byte return value passed in the R0:R2
> register pair, written in C so that they depend on the compiler lowering
> the register-pair return. Covered are an __int128 return, a 16-byte struct
> return (from a static and from a global subprogram) and a 16-byte union
> return, plus __int128 and 16-byte struct returns from a kfunc, for which
> bpf_kfunc_call_test_i128() and bpf_kfunc_call_test_ret_pair() are added to
> bpf_testmod.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> new file mode 100644
>> index 0000000000000..42017f89c4da6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> @@ -0,0 +1,125 @@
> [ ... ]
>> +static void run_prog(struct bpf_program *prog, bool supported)
>> +{
>> +	char buf[64] = {};
>> +	int err, prog_fd;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		    .data_in = buf,
>> +		    .data_size_in = sizeof(buf),
>> +		    .repeat = 1,
>> +	);
>> +
>> +	if (!supported) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	prog_fd = bpf_program__fd(prog);
>> +	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
>> +		return;
> [Severity: Low]
> Is this manual FD validation necessary here? According to the BPF skeleton API
> guarantees, after a successful skeleton load, skeleton-generated program
> fields are guaranteed to have valid FDs. Since run_prog() is called using
> programs from successfully loaded skeletons, the extra validation appears to
> be redundant.

Yes, the following
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		return;
is redundant. Will remove.

>
> [ ... ]
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index eb0f9b5e18d85..2ceb34df472e6 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -857,6 +857,18 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
>>   	return 0;
>>   }
>>   
>> +__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
>> +{
>> +	return (__int128)(((unsigned __int128)(a + b) << 64) | (a - b));
>> +}
> [Severity: Medium]
> Will this unconditional use of __int128 cause build failures on 32-bit
> architectures? It appears bpf_kfunc_call_test_i128 is not protected by
> an #ifdef __SIZEOF_INT128__ guard, which might break compilation of the
> bpf_testmod module on platforms lacking 128-bit integer support.

Ack, will guard with __SIZEOF_INT128__.

>
> [ ... ]
>> @@ -1390,6 +1402,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
> Should this BTF ID registration also be guarded to prevent compilation
> or pahole errors when the function is omitted on 32-bit builds?

Ack, will guard.

>
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
> [ ... ]
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> index c36bb911defa7..e6e59fdce33cf 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> @@ -118,6 +127,8 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
>>   struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>>   long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>>   int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
>> +__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
> Does this unconditionally declared prototype also need to be wrapped
> with an #ifdef __SIZEOF_INT128__ guard?

Ack, will guard.

>

