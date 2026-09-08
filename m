Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32276353A62
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842006; cv=none; b=QVNdC6MiNkPy38zSD4UvM1Tg8UdIA/JUdp8T4f5skEXK4JZ2Crc+TTMciR7L1nrgarCG3tVFVCF+kyfZb3cSoBYzPwtVNfpEVxHsEx6QBpS5/XhHU8edQKuy2dEjXwHT7rUKAkJKYPAndECzD/2SBKoyTctt5jLGWWE0XiYoddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842006; c=relaxed/simple;
	bh=Emup6ePJmDo+IEuYo0wR0gEMTGf+zRxl86iC80rq66U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXYdxjMvVsrEwQUKMHAvrKPliomAPvskPzcTSOEiluIx55M2wCWzlQrTDHdxZ7VqxckHf/bqP4IC2VYnYl0SvHLbnxYPy2kICQRA9ChJPb1sagUXop0XGIkbKFypACTEaH1D4F2D5dAMq/1Pfr2glXRI/fPEFo0oK1brY6n9PqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNxPQI/2; arc=none smtp.client-ip=95.215.58.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNxPQI/2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Emup6ePJmDo+IEuYo0wR0gEMTGf+zRxl86iC80rq66U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788842001; v=1; x=1789446801;
 b=NNxPQI/2xoG1J3nUcvhtyWTtpXOe6DOiWUz7G2oaqYQSFcpSp/EFA5bMBrEZ6/xe12YDWu9+
 DJIpHfEiY5pmlBjjKXrE5afx7IJSVMWBhgSVwOsyRPSfb+5urIMKPf3+HPEiTlh4fzXdx+jGnbC
 jc/V4T27ImYZpWD36VJycB2Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dafc58c5039ae507;
	Tue, 08 Sep 2026 04:33:21 +0000
X-Mizu-Trace-ID: dafc58c5039ae507
X-Migadu-Flow: FLOW_OUT
Message-ID: <0113dee7-6e88-4aa8-a719-143d017512c6@linux.dev>
Date: Mon, 7 Sep 2026 21:33:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add C tests for by-value
 arguments up to 16 bytes
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051049.3982644-1-yonghong.song@linux.dev>
 <20260904051931.EDD761F00A3E@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904051931.EDD761F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 10:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] `take_with_ptr_global` and its test are missing the `#if defined(__clang__)` guard used for other global functions taking structs by value, which will cause the test to fail when built with GCC.
> - [Medium] `take_two_pairs_global` lacks the surrounding `int` arguments explicitly promised in the commit message to catch slot counting bugs.
> --
>
> commit a3823ad45ae612d86e218eeec89944cc894c7843
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add C tests for by-value arguments up to 16 bytes
>
> This commit extends the by-value argument tests with aggregate cases written
> in C. It relies on the compiler to lower arguments into register pairs instead
> of using hand-written register layouts.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
>> index 044fc4a800554..b10fb4aeb4056 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
> [ ... ]
>> +__noinline __u64 take_two_pairs_global(struct pair p, struct pair q)
>> +{
>> +	return p.lo + p.hi + q.lo + q.hi;
>> +}
>> +
>> +SEC("tc")
>> +__success __retval(0)
>> +int aggregate_arg_two_structs_c_test(struct __sk_buff *skb)
>> +{
>> +	__u64 a = skb->len ^ MIX_A;
>> +	__u64 b = skb->len ^ MIX_B;
>> +	struct pair p = { .lo = a, .hi = b };
>> +	struct pair q = { .lo = b, .hi = a };
>> +
>> +	if (take_two_pairs_global(p, q) != 2 * (a + b))
>> +		return 1;
>> +
>> +	return 0;
>> +}
> [Severity: Medium]
> Does this function signature and test implementation match the strategy
> described in the commit message?
>
> The commit message explicitly states a defensive testing strategy of having
> "two struct arguments in a row, each with an int argument on either side so
> that a wrong slot count shows up as a wrong value in the parameters around
> it".
>
> However, take_two_pairs_global completely omits these surrounding int
> arguments. Can these be added to properly validate register slot counting?

I will change commit message. With previous kernel support, it won't have wrong
slot count.

>
> [ ... ]
>> +__noinline __u64 take_with_ptr_global(struct with_ptr s)
>> +{
>> +	return s.x;
>> +}
>> +
>> +SEC("tc")
>> +__failure __msg("type STRUCT in take_with_ptr_global() is not composed of scalars")
>> +int aggregate_arg_ptr_member_fail(struct __sk_buff *skb)
>> +{
>> +	struct with_ptr s = { .p = skb, .x = skb->len };
>> +
>> +	return take_with_ptr_global(s);
>> +}
> [Severity: Medium]
> Should take_with_ptr_global and its test aggregate_arg_ptr_member_fail
> be enclosed within the #if defined(__clang__) guard?
>
> Other global functions taking structs by value in this file are guarded.
> Since GCC passes aggregates by invisible reference, it will produce a
> different BTF signature (a pointer instead of a struct).
>
> Will this cause the test to fail when compiled with GCC, as the verifier
> might not emit the specific "type STRUCT ... is not composed of scalars"
> failure message?

There is no need to guard with __clang__. This is a negative test
where both gcc and clang will fail.

>

