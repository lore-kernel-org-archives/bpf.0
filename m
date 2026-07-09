Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326213A2549
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626689; cv=none; b=DcCXnau+YttZEeh38aF4XWDWeV+zhrIhyLBAmHFfhdLc4j7bGMRT+Tw7/ZpG61FXE62spOLAOZRPDLQTDT66izFWZiYW5pniY1EaWvMwTHrkWNaVt4kWIBbMXtVStvkY7etmQuJLhc+lxeYqC3aEJ3WhVGIjRr4ww7dkd9DbuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626689; c=relaxed/simple;
	bh=AC1/fNgqBVPZyi6+9RpZzs/aCo5JFhGPgyefkz5sOTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBAVU1gdmHRdi7mVcccH59tV8KqWYH1oYqCAK2nHmEfbyNbd1xACFytqY0TeUBk+JgTUbL0byqeHqIN5LhTcxOApsl+TUBdQdQAz1un73c/HDK9nrxdvOmHjJ7Kvb11NyOILwWCYkJ6J+1oKvo0KpdiqCin5f6AOJjcQaYE20Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1JTg8tN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1JTg8tN"
Message-ID: <f186b429-66e6-4468-a901-cbead8fcca08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783626675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6Xnl4UdvQxwiAToaTN9V+4Hqu1vsN/08HKZxMAbOSw=;
	b=s1JTg8tNP/WtQdDVczlu7DmXEeftSKzUjxSsxSNkdd2m8/7RqTrCZcIapxulDM6pT+UAw4
	Gs67psjuUPJvklE0nwNF6N98GAp/YFjhctRve8OPKoCZnOpUxhi5V+4IZ4ZovGEd5nze3p
	5mX4J7fgEjh1Ooq26WlJBrhtOPt5Zqg=
Date: Thu, 9 Jul 2026 12:51:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201025.2160583-1-yonghong.song@linux.dev>
 <20260708202456.8A5E91F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260708202456.8A5E91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 1:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unconditional use of `__int128` in `bpf_testmod` breaks compilation on 32-bit host architectures.
> --
>
> --- Patch [9]: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte returns in R0:R2 ---
> commit 5ed3844739f04c920bb1c37cdf474501b3ca9fef
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add C tests for 16-byte returns in R0:R2
>
> This commit adds selftests to exercise 16-byte return values passed in the
> R0:R2 register pair. The tests include an __int128 return, a 16-byte struct
> return, and a 16-byte union return.
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>
>> @@ -825,6 +825,18 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
>>   	return 0;
>>   }
>>   
>> +__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
>> +{
>> +	return ((__int128)a << 64) | b;
>> +}
> [Severity: Low]
> Will this unconditional use of __int128 break the build on 32-bit host
> architectures?
>
> The __int128 type is a compiler extension that is typically only available
> on 64-bit systems.
>
> [ ... ]
>
>> @@ -1358,6 +1370,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
> [Severity: Low]
> If bpf_kfunc_call_test_i128 needs to be conditionally excluded for 32-bit
> builds to fix the issue above, should this BTF ID registration also be
> conditionally excluded to prevent a missing symbol error during the build?
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> [ ... ]
>
>> @@ -118,6 +127,8 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
>>   struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>>   long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>>   int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
>> +__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
> [Severity: Low]
> Does this declaration also need to be guarded for 64-bit architectures,
> so that including this header doesn't fail on 32-bit host compilers?

We may need to guard with __SIZEOF_INT128__ in selftests. But current CI all supports 64bit,
so I am not sure whether we should do it or not.

