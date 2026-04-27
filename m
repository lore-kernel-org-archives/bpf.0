Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C061A073F
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322556; cv=none; b=N9rWQgz/ziZ590AfWxMzluxWlNC7sYHxaBpa9f10FqW4rhTeey/I4QgXaLr3iVbmvgRYCfJseHS0SVwKfGHiYd5YzEqPAQFlQUIc2fFQzc/qJhvGzcrWpayIwZLAeTuuYtBJFs1BAbR5xQWbZLBCQlr+UIvmdVYTeDedtfVfysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322556; c=relaxed/simple;
	bh=HbJ5qZG16sTWpJh6tMQ3NMy2C/S7Rt6bGBsorglzEDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBkLZYXcOetXQ4WXZyEnjkTTXCWxtqaGliytOjQRu0nS/SEkZB1H+X1crvUYtg0Fy7GKfSxM2zq8Rvw1g6Kk6UvmJO9bOXx8bkPP3KPqxqNvIph4KXEiGhOuOH+UVWBpiDlasw+maCl+Sh8594QALMDtX1SbyWKbG8P4d9WLIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sH0aZRKP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sH0aZRKP"
Message-ID: <7886af5e-2d1f-4fb3-bb67-68841b1d0351@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777322551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=va3kfywYwunI0nAsplfGk/cNsJtg9Lnn6S30Om8IrCw=;
	b=sH0aZRKPNmas1AhclnVsMHNahj2TmXz75X06YMl+wjVKoMmIdqEgfWJvlmbV5hyxJwlrj0
	a/3Hxjofev5s6YRUg4gC4im/gPTvJ1vbSIWhJDN2qAFGufPk0pCVA6L5ar1/WfzyeTYsN7
	P8zjZY5WBtxKfXkXgXG4kMkcB5gvGD4=
Date: Mon, 27 Apr 2026 21:42:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 17/18] bpf, arm64: Add JIT support for stack
 arguments
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20260424171724.2058333-1-yonghong.song@linux.dev>
 <8f7648b35db9645d6616e4af8c9c734c419439c1b784c04a8d649c902e77dcd5@mail.kernel.org>
 <m21pg0zs9z.fsf@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <m21pg0zs9z.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/27/26 2:06 AM, Puranjay Mohan wrote:
> bot+bpf-ci@kernel.org writes:
>
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> [ ... ]
>>
>>> @@ -1671,7 +1727,7 @@
>>>   	}
>>>   	if (src == fp) {
>>>   		src_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
>>> -		off_adj = off + ctx->stack_size;
>>> +		off_adj = off + ctx->stack_size + ctx->stack_arg_size;
>>>   	} else {
>>>   		src_adj = src;
>>>   		off_adj = off;
>> When priv_sp_used is true, does this offset calculation produce correct
>> addresses for BPF fp-relative accesses?
>>
>> Looking at build_prologue:
>>
>> arch/arm64/net/bpf_jit_comp.c:build_prologue() {
>>      ...
>>      emit(A64_MOV(1, fp, priv_sp), ctx);
>>      emit(A64_ADD_I(1, fp, fp, ctx->stack_size), ctx);  /* line 612 */
>>
>>      if (ctx->stack_size && !ctx->priv_sp_used)
>>          emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);  /* line 620 */
>>
>>      if (ctx->stack_arg_size)
>>          emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);  /* line 623 */
>>      ...
>> }
>>
>> When priv_sp_used is true:
>> - fp = priv_sp + stack_size (line 612)
>> - main SP is not decremented by stack_size (skipped at line 620)
>> - main SP is decremented by stack_arg_size (line 623-624)
>>
>> So the BPF program data lives on the private stack, while outgoing stack
>> args live on the real SP. These are separate memory regions.
>>
>> In build_insn, the computed address for fp-relative loads/stores becomes:
>>      addr = priv_sp + off + stack_size + stack_arg_size
>>
>> But the intended BPF address is:
>>      addr = fp + off = priv_sp + stack_size + off
>>
>> The computed address is stack_arg_size bytes too high, accessing memory
>> above the intended location on the private stack.
>> This would read/write into the private-stack guard region (16 bytes) or
>> past it when stack_arg_size > 16. Can this occur?  The verifier only
>> forbids tail_calls + stack_args (verifier.c:5657), not priv_stack +
>> stack_args. A kprobe BPF program that uses BPF_REG_FP and calls a kfunc
>> with 9+ arguments would trigger wrong memory accesses.
> This analysis is correct, will fix in the next version.

Thanks Puranjay, once you fixed this issue, I can submit next revision
with your and my fixes.

>
>> Note that x86's bpf_int_jit_compile prevents priv_stack allocation when
>> stack_arg_depth != 0 (x86/bpf_jit_comp.c:3883). The arm64 version has no
>> equivalent guard.
>>
>> The same issue affects the ST case:
>>
>>
[...]

>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

