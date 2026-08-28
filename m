Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5D360EED
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941586; cv=none; b=YzmjTjGd6/rSCbFgo5tkd2iTN0+36bmlXzpyNAu2itWI4AjDP1SuHU4PGmf4KJbE3GHg8CmIsYpbFdmsQ9m3CfcJ5th0ez6vSGEDCp8FmvWIna13SHl67p6p9V/OsNDb3xsrxka/wo2Wg3ahlaQs/8PjMVzzjA9mwJp66MKArmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941586; c=relaxed/simple;
	bh=OHQYE/oIXiEsFNvdZzf6AhBGQ5Ru2IfyTHDAKmcD3z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0c/H9+sNW88Ts5OqoBxLIzhVrhwkoCSzR+uG449EnMZwXNTytMYmyRyGLj7Q4x7s9S/4rlBx/qOpJFpnZWLwq16E1vOD+iiLmm74YkRths2bl+UZ5BIcWWV5bc23QpZ2SfYcq3Dk1q3/jScaOFlsP7cKbcyL9ojEk9XoJuq0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oC3aSEt5; arc=none smtp.client-ip=95.215.58.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oC3aSEt5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OHQYE/oIXiEsFNvdZzf6AhBGQ5Ru2IfyTHDAKmcD3z8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787941580; v=1; x=1788546380;
 b=oC3aSEt5enFHNkbtm4jZUmYoIxQpBN6+iczK+hBBjlz1nVF1diQsTlyMjuGBc/+fct8rhHLo
 nmHevy1Mat1wCZQriIjaeS/1xGPFLGErVYmDn+LzRk0MoMrU7QstvkT9Xwb5c/CwTpwLjFHgyQB
 iCoWOAUbIIRvbW9Hevb0d4Ao=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 98e9a8112d5e48bf;
	Fri, 28 Aug 2026 18:26:20 +0000
X-Mizu-Trace-ID: 98e9a8112d5e48bf
X-Migadu-Flow: FLOW_OUT
Message-ID: <eef81f76-b208-4549-8b01-5e9cfa8bea86@linux.dev>
Date: Fri, 28 Aug 2026 11:26:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 09/11] selftests/bpf: Test global functions
 returning arena pointers by value
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260827061200.2519335-1-yonghong.song@linux.dev>
 <0c9dfc8370742b9ab97d7d248fb9698574ff6ca3074f761c400232d20ec7695f@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0c9dfc8370742b9ab97d7d248fb9698574ff6ca3074f761c400232d20ec7695f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> Cover the by-value struct returns a global function may now make: two
>> arena pointers filling R0:R2, an arena pointer beside a scalar, an array
>> of them, and an eight byte struct returned in R0 alone. The existing
>> cases for a struct and a union carrying a plain pointer stay rejected.
> This isn't a bug, but would it be worth adding the new union-of-arena-
> pointer case to the enumeration? The patch adds union arena_upair /
> global_ret_arena_union() / aggregate_ret_global_arena_union() as a
> sixteen-byte union of an arena pointer and a __u64[2]. Since the next
> sentence says "cases for a struct and a union carrying a plain pointer
> stay rejected", a reader might think the only union touched is a rejected
> one, when the patch actually adds a newly-accepted union case as well.

There is no need to have too many union cases. The existing one
should be enough.

>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> index 815f342eb4b05..672a3aadd9cb2 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> @@ -734,4 +734,52 @@ int check_arena_arg_ret(void *ctx)
>>   	return 0;
>>   }
>>
>> +#if defined(__clang_major__) && __clang_major__ >= 23
>> +
>> +struct arena_page_pair {
>> +	u32 __arena *first;
>> +	u32 __arena *second;
>> +};
>> +
>> +__weak struct arena_page_pair split_arena_page(u32 __arena *page)
>> +{
>> +	struct arena_page_pair pair;
>> +
>> +	pair.first = page;
>> +	pair.second = page + 1;
>> +
>> +	return pair;
>> +}
> This isn't a bug, but since the returned pointers are the first two u32
> slots of a single page rather than two halves of it (page and page + 1
> are offsets 0 and 4 within a single 4096-byte allocation), would a name
> like arena_word_pair() / struct arena_word_pair describe the helper more
> directly? The neighbouring arena return tests in the same file name
> themselves after what they exercise rather than after an imagined data
> layout (check_arena_arg_ret, check_arena_arg_quals1/2).

Okay, I will use arena_work_pair() then.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525

