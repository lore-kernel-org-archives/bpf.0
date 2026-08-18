Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9927FD76
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087016; cv=none; b=D8Qc8Z1RHbRZHqHZgbS+4xtbSU3aBajoUBIaO9hs5wDeSqsPWKrPCRBepyEvDZR951zRHcIcRpkAYBzu9C+D3FwTC11DpF3JoVa23qs1wd6rO4B8hIqWEm1YSw5WukXtdNalWNMXcqBo9HQVDrb+tiXygWukYABONt3xgsgYLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087016; c=relaxed/simple;
	bh=0AGz8ClWhv/8k8q18axKvNzjLqFvBGOkv5QBv+ymZqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9TNrPGjP1CeqNM1Mi2pXCRhtVz9guo2+126+hDC4N0gL5G0UlrN938HWTKf8lOft8s7QHhuRPZw7rh/grFb4B8iOnixmKLJNQN0Zd9z4wJJG3OKt4wL7+SKJXJGjz0BV4yTIhWPuZAAo/q1y4OBDIAyvv9D9ru5SlARHV4jqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m01nSxuI; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m01nSxuI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0AGz8ClWhv/8k8q18axKvNzjLqFvBGOkv5QBv+ymZqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787087011; v=1; x=1787691811;
 b=m01nSxuIjPkWl9aySf3YUJoeN12QU3BxhmbCBRTTyz2ztOwgfZ42SRqhIEfm/q1+nrqhnOzN
 XaiA7J4T4rMmlkM4HHCeZs80URnf4XjwFwVbD4RDHbaAsVYti8L/VUxFxfuqYla8NySsD09emq5
 PLsE3Hhpa92CSz3uX8uVXQE4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:17dc:c6a5:7074:ce30] (2620:10d:c090:500::7:86e7)
	by smtp.migadu.com with ESMTPS id b3773563f98e6be2;
	Tue, 18 Aug 2026 21:03:31 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <1f5fa9db-0051-403a-a2e9-44ee20592148@linux.dev>
Date: Tue, 18 Aug 2026 14:03:21 -0700
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
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
 <20260816-bpf-next-038-mixed-atomic-v1-v2-2-4644c1886dbc@mails.tsinghua.edu.cn>
 <cd62cd53be9bcea2d5b63fef8eece815f5095103.camel@gmail.com>
 <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
 <ac19d435-4c92-42c8-9db1-2db1ab854c3c@linux.dev>
 <ba901e5268dc739711b9a5e1d9405be6953e35f1.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <ba901e5268dc739711b9a5e1d9405be6953e35f1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/26 12:56 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-18 at 12:35 -0700, Vineet Gupta wrote:
>> On 8/16/26 4:36 PM, Eduard Zingerman wrote:
>>> On Sun, 2026-08-16 at 16:17 -0700, Eduard Zingerman wrote:
>>>> On Sun, 2026-08-16 at 10:56 +0000, Yiyang Chen wrote:
>>>>> Add a verifier test with one atomic RMW instruction reached through
>>>>> PTR_TO_ARENA and PTR_TO_STACK paths. The verifier must reject the
>>>>> shared instruction with the existing incompatible-pointer diagnostic.
>>>>>
>>>>> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
>>>>> ---
>>>>>    tools/testing/selftests/bpf/progs/verifier_arena.c | 39 ++++++++++++++++++++++
>>>>>    1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
>>>>> index b241bbcf54a8a..b22bab33301ab 100644
>>>>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>>>>> @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
>>>>>    
>>>>>    #endif
>>>>>    
>>>>> +static const struct bpf_insn addr_space_cast_insn = {
>>>>> +	.code = 0xbf,
>>>>> +	.dst_reg = BPF_REG_7,
>>>>> +	.src_reg = BPF_REG_7,
>>>>> +	.off = 1,
>>>>> +	.imm = 1,
>>>>> +};
>>>>> +
>>>>> +SEC("socket")
>>>>> +__description("arena and stack atomic at the same instruction")
>>>>> +__failure __msg("same insn cannot be used with different pointers")
>>>>> +__arch_x86_64
>>>>> +__load_if_JITed()
>>>>> +__naked void mixed_arena_stack_atomic(void)
>>>>> +{
>>>>> +	asm volatile ("					\
>>>>> +	r1 = %[arena] ll;				\
>>>>> +	r6 = r10;					\
>>>>> +	r6 += -8;					\
>>>>> +	r9 = 0;					\
>>>>> +	*(u64 *)(r6 + 0) = r9;			\
>>>>> +	r7 = 8192;					\
>>>>> +	.8byte %[addr_space_cast];			\
>>>> I'm going to fix this to:
>>>>
>>>> 	r7 = addr_space_cast(r7, 0, 1);			\
>>>>
>>>> as in the test case above.
>>>> Waiting for CI [1].
>>>>
>>>> [1] https://github.com/kernel-patches/bpf/pull/13325
>>> A...and it requires another exception for GCC-BPF:
>>> https://github.com/kernel-patches/bpf/blob/bpf-next_base/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>>>
>>> Ihor, it's a third time GCC-BPF strikes this weekend.
>>> What do people think about downgrading it to may-fail until the
>>> DENYLIST decreases to something reasonable?
>> While bpf-gcc is improving, slowly, we can in parallel do alittle better
>> on test hygiene as well. In this case by correctly bracketing the tests
>> with _BPF_FEATURE_XXX.
> Yes, that's what I ended up doing. Should have paid attention to the
> #if .. #endif bracket used by the textually preceding test.
> Sorry for lashing out.

No worries and I can sympathize with frustrations when someone's s*it is 
not together and others have to suffer

-Vineet
