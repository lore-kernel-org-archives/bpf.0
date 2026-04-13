Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABA2E54D1
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098038; cv=none; b=Icsw7BJQEzelCOgHw8ROase3lPefMh3X1jRkSqHAwehU4EXFQWzrtaNCF6l3AIpl+WYCN2HF++/EohCQVQwDuW9B0qRrmuPfJRCwjr0q2Plh6YqwO3bLXI8h4SZd3tzFCps2oSTdtCNBOeYHh6b1u5r/xuxELy302Ykm/JBUt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098038; c=relaxed/simple;
	bh=iGhLlks1VUBy4AOo1gJuHeSEAz5yFJug4+xtmx+taRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3b0iYeqf5UfmWD7x7rGriNysrZDXgDskuX1tktVs+LU8cauFzsDi+sqCqz7WJv266du9ysRYtPgTTs7/D8KDGCBFiFPaaVkeyhEvrGJNj0rHeENt3B7R4W63F3VbnKuP969V2Kd4IlqwGoJG9V8SupC7Iqg5rn/bTG4kyjAL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1P0jvPn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1P0jvPn"
Message-ID: <1f47b526-d995-4771-9123-fc2a4a9a7ea3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776098033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5FAyaJAYsu86kb0Ky634PFmNEjkY7mJUQSIM9SdrVs=;
	b=M1P0jvPnSFWD8ScrNggSywMMWJAgYnpF9M88UJEGpDWwUScLjZARcJ6qijeN/xBVrR9VP7
	8PXi6ZGI+NFMKKAOl+pKGjG/4InvZbPa+VTjwd/cR1hBzjD6Zw1WOoSURVKeX2daVMSnhd
	jH4rSyDoLXaMicsWJRyJdHI1w0VWrWo=
Date: Mon, 13 Apr 2026 09:33:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 09/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412045955.257613-1-yonghong.song@linux.dev>
 <CAADnVQLPruMzAt+jFMhwS_OHyMcqoviHDAPSKAYK8VW1k1FBKg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLPruMzAt+jFMhwS_OHyMcqoviHDAPSKAYK8VW1k1FBKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/12/26 3:23 PM, Alexei Starovoitov wrote:
> On Sat, Apr 11, 2026 at 10:00 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>> With [1], the compiler can emit code that passes additional arguments
>> via a dedicated stack area through bpf register
>> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>>
>> The compiler uses positive r12 offsets for incoming (callee-side) args
>> and negative r12 offsets for outgoing (caller-side) args, following the
>> x86_64/arm64 calling convention direction. There is an 8-byte gap at
>> offset 0 separating the two regions:
>>
>>    Incoming (callee reads):   r12+8 (arg6), r12+16 (arg7), ...
>>    Outgoing (caller writes):  r12-N*8 (arg6), ..., r12-8 (last arg)
>>
>> The following is an example to show how stack arguments are saved
>> and transferred between caller and callee:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>    }
>>
>>     Caller (foo)                           Callee (bar)
>>     ============                           ============
>>     Incoming (positive offsets):           Incoming (positive offsets):
>>
>>     r12+8:  [incoming arg 6]               r12+8:  [incoming arg 6] <-+
>>     r12+16: [incoming arg 7]               r12+16: [incoming arg 7] <-|+
>>                                            r12+24: [incoming arg 8] <-||+
>>     Outgoing (negative offsets):                                      |||
>>     r12-24: [outgoing arg 6 to bar] -------->-------------------------+||
>>     r12-16: [outgoing arg 7 to bar] -------->--------------------------+|
>>     r12-8:  [outgoing arg 8 to bar] -------->---------------------------+
>>
>> Note the reversed order: the caller's most negative outgoing offset
>> (arg6) maps to the callee's first positive incoming offset (arg6).
>> The caller stores arg6 at r12-24 (= -3*8 for 3 stack args), and
>> the callee reads it at r12+8.
>>
>> If the bpf function has more than one call:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>      bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>>      ...
>>    }
>>
>>     Caller (foo)                             Callee (bar2)
>>     ============                             ==============
>>     Incoming (positive offsets):             Incoming (positive offsets):
>>
>>     r12+8:  [incoming arg 6]                 r12+8:  [incoming arg 6] <+
>>     r12+16: [incoming arg 7]                 r12+16: [incoming arg 7] <|+
>>                                              r12+24: [incoming arg 8] <||+
>>     Outgoing for bar2 (negative offsets):    r12+32: [incoming arg 9] <|||+
>>     r12-32: [outgoing arg 6] ---->----------->-------------------------+|||
>>     r12-24: [outgoing arg 7] ---->----------->--------------------------+||
>>     r12-16: [outgoing arg 8] ---->----------->---------------------------+|
>>     r12-8:  [outgoing arg 9] ---->----------->----------------------------+
> The diagram looks good.
> When I suggested to use r12 I thought the whole support will take
> much longer and by that time we will land Eduard's r11 work.
> Now it looks like 6+ args will land first,
> so let's swap them. Please use r11 as a base and Eduard's spill/fill
> will use r12 if/when it happens.

Okay.

>
>>    [1] https://github.com/llvm/llvm-project/pull/189060
> Same for llvm. pls update it to use r11.

Will do.

> I feel it can land soon-ish.
>
>> +struct bpf_stack_arg_state {
>> +       struct bpf_reg_state spilled_ptr; /* for spilled scalar/pointer semantics */
>> +       u8 slot_type[BPF_REG_SIZE];
>> +};
> This is pointless. Not sure whether claude came up with this idea
> or you, but please think harder. Why slot_type[] is there?

I consulted claude for this patch and for the above data strcture,
I didn't do enough auditing for it. My fault.

> What does it give?
> Whether we pass u8 or u64 the slot is still 8 byte and this is
> still the same spilled_ptr..
> which is also wrong name here. Call it 'arg' ?

I guess we can simplify it as

struct bpf_func_state {
	struct bpf_reg_state regs[MAX_BPF_REG];
	...
	struct bpf_reg_state *stack_args;
}

>
> Also think through how i128 and structs of 8,16,24,32 bytes will be
> passed.

The llvm supports i128 type since it is not an aggregate. But the kernel
didn't handle i128 properly even if i128 is in the first 5 registers.
I will look into this after this patch set.

for stack arguments, reg states of structs (<= 64 bytes) will passed
from caller to callee.

