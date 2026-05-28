Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608D23BCF7
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944641; cv=none; b=Af6HONb1qTy5K9uNuNOiVW8z1BxVgk8rjNVjPoLf6/cGccFOckhSOm4Wv58KAEovlFyo7VkwzEley0oshRE+7kjV9SCYPVDFxZa1J1hrRiZfHiO2dKR3vDQUfyv2kfs+oxXAqW1ax1OrPrSS0smJSy+DGjau3pv5rNizbuitj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944641; c=relaxed/simple;
	bh=3QTt2ZIA82tDnJVl7Aj20uwzE/H0zuyLXxH6GTcVprA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWAEaFIIHCuRCFLpzFszKENZO5Um+PMgZa+S0i4Acx9cUR5t2lxiQcvdokR3uKgmhvuC8NmH0iFThtETTQFeBKQjTDoBtPKIg2yiSwdeggIgbCg9lrq/H0NmnmEOM7+6NhA/+SpT4kcEBaZhLBHbLOCqaKgPiY6lUYdjm5ltVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sXyDaN52; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sXyDaN52"
Message-ID: <5bc1d6cf-318f-4bd4-a422-b22ddf215b84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779944636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSdYvWKBYOCheWSOfE6JjqgvxsdRGDZ8ECMbLjeg2aM=;
	b=sXyDaN52H4GPawWpYQuNt0704MnLFVtboPBgY4qSvHycSVEjBxye7+GLmZYFVJJvtV9BcV
	9fFMa4P5k+HsBUWxj6oAgWgEYXTQLn/3tzlW1qB2rmHTUsG9Xf32Gum4oyi4la/JoCprDo
	QRwuXEJYewO7/TZha/rkvtqqCSNxuoA=
Date: Wed, 27 May 2026 22:03:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/1] bpf: reject overlarge global subprog argument
 sizes
To: =?UTF-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
 <20260527052539.3388700-2-hataegu0826@gmail.com>
 <549d58c6-05f0-4176-98ec-c88e96ee4375@linux.dev>
 <CAPa51znR2bY8mojn07L4QLWrZP6yNVunMQHdvqGN1U_N0vPm7Q@mail.gmail.com>
 <CAPa51z=fUqv-yp8SnzMQ-msss1NNdHsqnUsA8ezJ-2XX5Qo8AQ@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAPa51z=fUqv-yp8SnzMQ-msss1NNdHsqnUsA8ezJ-2XX5Qo8AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/27/26 10:53 AM, 하태구 wrote:
> Sorry for the poor formatting in the previous reply. Reflowing the main
> point:
>
> The 0x3fffffff array bound is not expected to appear in the generated
> BPF instructions. It affects the verifier through the BTF-derived
> argument size.
>
> For:
>
>    int (*p)[0x3fffffff]
>
> btf_resolve_size() returns 0xfffffffc. At the call site R1 is fp-4,
> pointing to a 4-byte stack slot. check_mem_reg() currently does:
>
>    size = -(int)mem_size
>
> for PTR_TO_STACK, so 0xfffffffc is converted to -4 and then to a
> 4-byte stack check. The caller side therefore accepts fp-4.
>
> The callee is then verified with:
>
>    R1=mem_or_null(id=1,sz=0xfffffffc)
>
> so its 4-byte load at r1 + 4 is considered inside the BTF-described
> memory region. But the actual argument is still fp-4, so r1 + 4 is
> fp+0, outside the 4-byte caller object.
>
> I rechecked this on current origin/master eb3f4b7426cf with the raw-BTF
> reproducer, and the verifier accepted the program with:
>
>    4: (85) call pc+2 // r1=fp0-4
>    7: R1=mem_or_null(id=1,sz=0xfffffffc) R10=fp0
>    9: (61) r0 = *(u32 *)(r1 +4)
>    Func#1 ('subprog') is safe for any args that match its prototype

The below is my verifier log:

arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx() R10=fp0
; int tiny = 42; @ verifier_global_subprogs.c:166
0: (b4) w1 = 42                       ; R1=42
1: (63) *(u32 *)(r10 -4) = r1         ; R1=42 R10=fp0 fp-8=mmmm????
2: (bf) r1 = r10                      ; R1=fp0 R10=fp0
3: (07) r1 += -4                      ; R1=fp-4
; return subprog_user_anon_mem_huge(p) + tiny; @ verifier_global_subprogs.c:169
4: (85) call pc+4
Func#1 ('subprog_user_anon_mem_huge') is global and assumed valid.
5: R0=scalar()
5: (61) r1 = *(u32 *)(r10 -4)         ; R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmmpppp
6: (0c) w1 += w0                      ; R0=scalar() R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
7: (bc) w0 = w1                       ; R0=scalar(id=1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
                                         R1=scalar(id=1,smin=0,smax=umax=0xffffffff,var)
8: (95) exit
Validating subprog_user_anon_mem_huge() func#1...
9: R1=mem_or_null(id=2,sz=0xfffffffc) R10=fp0
; __noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff]) @ verifier_global_subprogs.c:155
9: (b4) w0 = 0                        ; R0=0
; return p ? (*p)[1] : 0; @ verifier_global_subprogs.c:157
10: (15) if r1 == 0x0 goto pc+1       ; R1=mem(sz=0xfffffffc)
11: (61) r0 = *(u32 *)(r1 +4)         ; R0=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
12: (95) exit

from 10 to 12: R0=0 R10=fp0
12: R0=0 R10=fp0
12: (95) exit
Func#1 ('subprog_user_anon_mem_huge') is safe for any args that match its prototype
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0

As you mentioned, the key thing is due to this line of code:
         int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;

If mem_size = 0xfffffffc, then -(int)mem_size will be 4. Unfortunately,
size 4 does have coverage due to *(u32 *)(r10 -4) = r1.
If mem_size = 0xfffffff8, then -(int)mem_size will be 8 and verifier
will reject it since only 4 slot for stack.

>
> So the issue is not a large immediate in the instruction stream, but the
> oversized BTF pointee size wrapping the caller-side stack argument check.
>
> I can send v2 with the commit message and selftest comments clarified.

Please have more details in the commit message.

>
> Thanks,
> Taegu
>
> 2026년 5월 28일 (목) 오전 2:48, 하태구 <hataegu0826@gmail.com>님이 작성:
>> Hi Yonghong, Thanks for checking. Yes, the generated instruction is
>> only a 4-byte load at r1 + 4. The large array bound is not expected to
>> appear in the instruction stream. It matters through the BTF-derived
>> argument size used by the verifier. For the global subprog argument:
>> int (*p)[0x3fffffff] btf_resolve_size() resolves the pointee size to
>> 0xfffffffc. At the call site, R1 is PTR_TO_STACK pointing to the
>> 4-byte local variable at fp-4. The current stack path in
>> check_mem_reg() computes: size = -(int)mem_size so 0xfffffffc becomes
>> -4 as a signed int, and the negation validates only 4 bytes. This lets
>> the caller pass the 4-byte stack slot. The callee is then verified
>> independently with R1 as PTR_TO_MEM and mem_size 0xfffffffc, so the
>> 4-byte access at r1 + 4 is accepted as being inside the BTF-described
>> memory region. At runtime, however, the actual argument value is still
>> fp-4, so r1 + 4 addresses fp+0, outside the 4-byte object that the
>> caller provided. I rechecked this on current origin/master
>> eb3f4b7426cf with the raw-BTF reproducer. The verifier accepts the
>> program and logs: 4: (85) call pc+2 // r1=fp0-4 ... 7:
>> R1=mem_or_null(id=1,sz=0xfffffffc) R10=fp0 9: (61) r0 = *(u32 *)(r1
>> +4) Func#1 ('subprog') is safe for any args that match its prototype
>> So I agree that the objdump only shows a small load. The issue is that
>> the oversized BTF pointee size wraps the caller-side stack argument
>> check and lets that small load be accepted past the caller object. I
>> can send a v2 with the commit message and selftest comments clarified
>> to make this distinction explicit. Thanks, Taegu
>>
>> 2026년 5월 28일 (목) 오전 1:59, Yonghong Song <yonghong.song@linux.dev>님이 작성:
>>>
>>>
>>> On 5/26/26 10:25 PM, Taegu Ha wrote:
>>>> Global subprogram argument checking derives generic pointer sizes from BTF
>>>> and passes the resolved size to check_mem_reg() as a u32. The access-size
>>>> validation path then uses a signed int, and stack pointers negate the value
>>>> before calling check_helper_mem_access().
>>>>
>>>> A BTF type such as int[0x3fffffff] resolves to 0xfffffffc bytes. On a stack
>>>> pointer, (int)mem_size becomes -4 and the negation validates only four
>>>> bytes. A caller can therefore pass a four-byte stack slot while the callee
>>>> is verified with a nearly 4GiB memory argument, allowing accesses outside
>>>> the caller object.
>>>>
>>>> This was confirmed with a non-executing raw-BTF reproducer. On a
>>>> vulnerable kernel, the verifier accepted a program where the caller passed
>>>> a four-byte stack slot, while the callee argument was described by BTF as
>>>> int[0x3fffffff]. The verifier log showed:
>>>>
>>>>     R1=mem_or_null(id=1,sz=0xfffffffc)
>>>>     r0 = *(u32 *)(r1 +4)
>>>>
>>>> The program was only loaded to prove verifier acceptance and was not
>>>> attached or executed.
>>>>
>>>> Reject sizes that cannot be represented by the signed verifier access-size
>>>> API before any conversion. Cast the non-stack case after the bound check to
>>>> make the conversion explicit, and add a verifier regression test for the
>>>> oversized BTF argument.
>>>>
>>>> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
>>>> Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
>>>> ---
>>>>    kernel/bpf/verifier.c                           |  7 ++++++-
>>>>    .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
>>>>    2 files changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 7fb88e1cd7c4..1007f204a1f5 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -7107,6 +7107,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>>>>        struct bpf_reg_state saved_reg;
>>>>        int err;
>>>>
>>>> +     if (mem_size > S32_MAX) {
>>>> +             verbose(env, "R%d memory size %u is too large\n", regno, mem_size);
>>>> +             return -EACCES;
>>>> +     }
>>>> +
>>>>        if (bpf_register_is_null(reg))
>>>>                return 0;
>>>>
>>>> @@ -7119,7 +7124,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>>>>                mark_ptr_not_null_reg(reg);
>>>>        }
>>>>
>>>> -     int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
>>>> +     int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : (int)mem_size;

Since we have mem_size > S32_MAX guard, the above 'int size = ...' can be stored back to
	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;

>>>>
>>>>        err = check_helper_mem_access(env, regno, size, BPF_READ, true, NULL);
>>>>        err = err ?: check_helper_mem_access(env, regno, size, BPF_WRITE, true, NULL);
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>>> index 1e08aff7532e..0ff8f85b4d46 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>>>> @@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
>>>>        return subprog_user_anon_mem(&t);
>>>>    }
>>>>
>>>> +__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
>>>> +{
>>>> +     return p ? (*p)[1] : 0;
>>>> +}
>>>> +
>>>> +SEC("?tracepoint")
>>>> +__failure __log_level(2)
>>>> +__msg("R1 memory size 4294967292 is too large")
>>>> +int anon_user_mem_huge_size_invalid(void *ctx)
>>>> +{
>>>> +     int (*p)[0x3fffffff];
>>>> +     int tiny = 42;
>>>> +
>>>> +     p = (void *)&tiny;
>>>> +     return subprog_user_anon_mem_huge(p) + tiny;
>>>> +}
>>> Without verifier.c change, verification is successful.
>>>
>>> The objdump:
>>>
>>> 0000000000000160 <subprog_user_anon_mem_huge>:
>>> ; {
>>>         44:       b4 00 00 00 00 00 00 00 w0 = 0x0
>>> ;       return p ? (*p)[1] : 0;
>>>         45:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <L0>
>>>         46:       61 10 04 00 00 00 00 00 w0 = *(u32 *)(r1 + 0x4)
>>> <L0>:
>>>         47:       95 00 00 00 00 00 00 00 exit
>>>
>>> 0000000000000040 <anon_user_mem_huge_size_invalid>:
>>> ;       int tiny = 42;
>>>          8:       b4 01 00 00 2a 00 00 00 w1 = 0x2a
>>>          9:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = w1
>>>         10:       bf a1 00 00 00 00 00 00 r1 = r10
>>>         11:       07 01 00 00 fc ff ff ff r1 += -0x4
>>> ;       return subprog_user_anon_mem_huge(p) + tiny;
>>>         12:       85 10 00 00 ff ff ff ff call -0x1
>>>                   0000000000000060:  R_BPF_64_32  subprog_user_anon_mem_huge
>>>         13:       61 a1 fc ff 00 00 00 00 w1 = *(u32 *)(r10 - 0x4)
>>>         14:       0c 01 00 00 00 00 00 00 w1 += w0
>>>         15:       bc 10 00 00 00 00 00 00 w0 = w1
>>>         16:       95 00 00 00 00 00 00 00 exit
>>>
>>> The big 0x3fffffff does not really matter.
>>>
>>>> +
>>>>    __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
>>>>    {
>>>>        return (*p1) * (*p2); /* good, no need for NULL checks */

