Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69299351C2F
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081772; cv=none; b=UliSF4E7b7Y6ablpIAPf59JAARKCUIFNiNH0PDbObRyNMQyABZ9YMNfO6hfLp4H0Pf0Kx5mPwpfEC9BdqZcX4h9w3VUd3C0TpLoDv6Il9rf/gj90KsL7W6QUDjl4rZ8yocAXZLh8fZC5saXd83LDHvkBVSZWpW53AOYa4SC9RvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081772; c=relaxed/simple;
	bh=kIKvNM7BPSkBXUN2eWH5O/FffUslGwSPxg0v8WZ5jtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg+HJ8689dgkO1E3tJlxLmbUI8pAkhwlWrQI03tBRouqAFPIeav5K25Na4R8T8uPQIUqrx+J660buaHQ1Qo4sfet59n2FMOY+8IIpFub/S5Sey9bp6FTteOXHKGpT+ptlssXrLKBTKPAdEyjA49zhiocSpTOUAVfZ9LA/F1RJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjufIYRe; arc=none smtp.client-ip=91.218.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjufIYRe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kIKvNM7BPSkBXUN2eWH5O/FffUslGwSPxg0v8WZ5jtQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787081766; v=1; x=1787686566;
 b=wjufIYReKApm19whovGAR48ngk1w3pYh+NeD/JsiUSfqlB6ZTUBRYXXfzt/Lu4V7l6s1mtu1
 cWOlBolctSOmsWls0GgBKFQhSBkW4jS5x0Dj38sxH8rkzBz+8EpHaXora9t21A8dIJ3voggMoki
 iumLcYnCrXbkOWtxhN1+gMIo=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:17dc:c6a5:7074:ce30] (2620:10d:c090:500::7:86e7)
	by smtp.migadu.com with ESMTPS id b107c2617882a1d3;
	Tue, 18 Aug 2026 19:35:54 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <ac19d435-4c92-42c8-9db1-2db1ab854c3c@linux.dev>
Date: Tue, 18 Aug 2026 12:35:46 -0700
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
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <123a014b2b4ecd7d19cbdfe62c62d994e612b6f0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
>>>   tools/testing/selftests/bpf/progs/verifier_arena.c | 39 ++++++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
>>> index b241bbcf54a8a..b22bab33301ab 100644
>>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>>> @@ -637,6 +637,45 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
>>>   
>>>   #endif
>>>   
>>> +static const struct bpf_insn addr_space_cast_insn = {
>>> +	.code = 0xbf,
>>> +	.dst_reg = BPF_REG_7,
>>> +	.src_reg = BPF_REG_7,
>>> +	.off = 1,
>>> +	.imm = 1,
>>> +};
>>> +
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
>> I'm going to fix this to:
>>
>> 	r7 = addr_space_cast(r7, 0, 1);			\
>>
>> as in the test case above.
>> Waiting for CI [1].
>>
>> [1] https://github.com/kernel-patches/bpf/pull/13325
>
> A...and it requires another exception for GCC-BPF:
> https://github.com/kernel-patches/bpf/blob/bpf-next_base/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>
> Ihor, it's a third time GCC-BPF strikes this weekend.
> What do people think about downgrading it to may-fail until the
> DENYLIST decreases to something reasonable?

While bpf-gcc is improving, slowly, we can in parallel do alittle better 
on test hygiene as well. In this case by correctly bracketing the tests 
with _BPF_FEATURE_XXX.

Co-incidently I have a series in works from an accidental discovery of 
llvm-only testing coverage (rely solely on __clang_version macro) which 
I'll follow up on the list shortly.

Thx,
-Vineet


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
>>>   static __noinline
>>>   u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
>>>   {

