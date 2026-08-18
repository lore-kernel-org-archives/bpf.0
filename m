Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E983793D5
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083615; cv=none; b=kHCCyMbFbnL7sAOC6fkUVSwbxvlUIJjLqFi1YpJ7G7qD1D177e3rqvc06eT3EgY05vgZmPL3xb4BfWXL2QG/n4y2fXpeffY5mekWRqhp31zccCowXxGkEl4Cp1ZhZwec1wSemKIuQ2pkxNjVDCeddsFhYlA4+3zsuEnjkVz4/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083615; c=relaxed/simple;
	bh=pw2VKTeijUS0mD7622T+XsHyQ54fWSMv6vBNMQOlT1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLL93gDTCTkfQRlGAFm80u7VYTxTpaFzD1VWrpze51ayL/Ys6DBw44QD2h6Fnnv8jfvKiidsN8k0oBoJaWxqgYUWnaEMt5i4zRCYSTT1CyVl26/X4Uyx7DiPgi5yRJSqPPP/eL86qs4CVMbggm+6TiOrPMxdjyKrYzr26u2stRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfCG0ol7; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfCG0ol7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pw2VKTeijUS0mD7622T+XsHyQ54fWSMv6vBNMQOlT1U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787083610; v=1; x=1787688410;
 b=AfCG0ol7ffLABRZ9il0lupn9de5+TOPGeL9K8ILNKBeyKSkWHX5Jpdb/ubL3qevf28O1I1bb
 Pnzyg+AvNx/5HnJr+/hNDsUiYd6BxnXuqWnmDrnaxXMrZhqjo/whXzdtczKzs+rq2IPgc8sVCYA
 6qIVbCmEVgp+cciILnfAH8pU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:7612:abfc:71b6:4eb2] (2620:10d:c090:500::5:97cb)
	by smtp.migadu.com with ESMTPS id dd65d28a1e961842;
	Tue, 18 Aug 2026 20:06:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <1e1e55cc-0d67-40b4-8527-3990fc6859f6@linux.dev>
Date: Tue, 18 Aug 2026 13:06:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover mixed arena and
 stack atomics
To: Eduard Zingerman <eddyz87@gmail.com>,
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 vineet.gupta@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
 <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
 <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
 <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/26 4:36 PM, Eduard Zingerman wrote:
> On Sun, 2026-08-16 at 16:17 -0700, Eduard Zingerman wrote:
>> On Sun, 2026-08-16 at 10:56 +0000, Yiyang Chen wrote:
>>> Add a verifier test with one atomic RMW instruction reached through
>>> PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
>>> shared instruction with the existing incompatible-pointer diagnostic.
>>>
>>> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
>>> ---

>>> [...]
>>> +SEC("socket")
>>> +__description("arena and stack atomic at the same instruction")
>>> +__failure __msg("same insn cannot be used with different pointers")
>>> +__arch_x86_64
>>> +__load_if_JITed()
>>> +__naked void mixed_arena_stack_atomic(void)
>>> +{
>>> +	asm volatile ("					\
>>> +	r1 = %[arena] ll;				\
>>> +	r6 = r10;					\
>>> +	r6 += -8;					\
>>> +	r9 = 0;					\
>>> +	*(u64 *)(r6 + 0) = r9;			\
>>> +	r7 = 8192;					\
>>> +	.8byte %[addr_space_cast];			\
>>
>> I'm going to fix this to:
>>
>> 	r7 = addr_space_cast(r7, 0, 1);			\
>>
>> as in the test case above.
>> Waiting for CI [1].
>>
>> [1] https://github.com/kernel-patches/bpf/pull/13325
> 
> 
> A...and it requires another exception for GCC-BPF:
> https://github.com/kernel-patches/bpf/blob/bpf-next_base/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
> 
> Ihor, it's a third time GCC-BPF strikes this weekend.
> What do people think about downgrading it to may-fail until the
> DENYLIST decreases to something reasonable?

I get your frustration, but red CI makes us to look at things
which is good. "May fail" runs and "warnings" are very likely
to be ignored.

I think the tests and the denylist will be in a stable shape soon.
Flakiness on the way there is expected.

> 
> Anyway, I'll wrap-up with this patch-set in the evening.
> 
>>> +	call %[bpf_get_prandom_u32];			\
>>> +	if w0 != 0 goto 1f;				\
>>> +	r8 = r6;					\
>>> +	goto 2f;					\
>>> +1:	r8 = r7;					\
>>> +2:	r9 = 1;					\
>>> +	lock *(u64 *)(r8 + 0) += r9;			\
>>> +	r0 = 0;					\
>>> +	exit;						\
>>> +"	:
>>> +	: __imm_addr(arena),
>>> +	  __imm_insn(addr_space_cast, addr_space_cast_insn),
>>> +	  __imm(bpf_get_prandom_u32)
>>> +	: __clobber_all);
>>> +}
>>> +
>>>  static __noinline
>>>  u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
>>>  {

