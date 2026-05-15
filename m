Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF13F39F8
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870137; cv=none; b=rUZY2FJYXoJzyBWtbe3573MFz+KNzsSkF9g8moOt64yMVzb4FVfFHsVeouALJYOPzvHuwqG2Kurs04FdY7lw787task3fAZT3WxePciox4LnwSgPXSPBoJHKui8wCiTYKqkTHn40F7Zh0PeZUJfacrEdXdOAPO4W4+qoYT7PMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870137; c=relaxed/simple;
	bh=EzLZY2F+AfoiAqJglprgnxt0f4oRhejEz4pJY/TpFu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNh4xnyli4OS+bIJzpdFpBI+VT48Sk0dL7ESSILfqM0wO3m+o79PisdYcaMH6hEEcCfiLp0QagtPsyLmxA0GixsESLL/Lsz0I1/i1MHl1BlTXxy6dOZzcbX0iV0zUI35htWoy2CcFHzgJNOCAHiISKI4ixWz6xX+C+wId76n8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PEEy6BTy; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PEEy6BTy"
Message-ID: <3252fd2e-1499-4789-975d-47fe42c06a37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778870121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8ERAbEZHGcGSMm842/tvzaknIerBVlE/UC2D7DPuKc=;
	b=PEEy6BTy5gANgYslRq/kuh+/Un561wwJ+Ao0vUiRY8YC0nsa7kBCr7ga1eafDyvTN6XaT1
	fMSwxzjcjvP8iZ3zHrvRaUvDJ6BZxoomLBaDuIqX9o225F7YJrt5UFtlEIQc48Jn5fTPVu
	CakX8UyprCvbtCVAc4vPrgn/a4AMWps=
Date: Fri, 15 May 2026 11:35:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 24/25] bpf, arm64: Add JIT support for stack
 arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045158.2402494-1-yonghong.song@linux.dev>
 <20260515082000.DBCE2C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515082000.DBCE2C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 10:20 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Incoming stack arguments 6-8 are mapped to caller-saved registers `x5-x7` without being spilled to the stack, allowing them to be corrupted by function calls. This bypasses verifier bounds checks and enables arbitrary kernel memory read/write.
> --
>
> commit 20fea8a10865fdb2efc7f0e237022c9e2e575fd7
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf, arm64: Add JIT support for stack arguments
>
> Implement stack argument passing for BPF-to-BPF and kfunc calls with
> more than 5 parameters on arm64, following the AAPCS64 calling
> convention.
>
>> BPF convention uses fixed offsets from BPF_REG_PARAMS (r11): off=-8 is
>> always arg 6, off=-16 arg 7, etc. The verifier invalidates all outgoing
>> stack arg slots after each call, so the compiler must re-store before
>> every call. This means x5-x7 don't need to be saved on stack.
> While it is true that the verifier invalidates outgoing stack arg slots after
> each call, does this logic safely apply to incoming stack arguments?
>
> Incoming arguments are modeled as memory accesses relative to BPF_REG_PARAMS
> and the verifier assumes these memory slots are preserved across helper and
> subprog calls.
>
> Since x5-x7 are caller-saved registers per AAPCS64, what happens if a BPF
> program makes a call (which clobbers x5-x7) and subsequently reads its
> incoming stack arguments 6-8?

Verifier will reject this. The call will clear all stack arg slots, so
subsequent read of incoming stack arguments will be rejected by verifier.

>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 085e650662e3d..e3bbeaa94590c 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
>> +static const u8 stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) };
>> +
>> +#define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
>> +
>> +static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
>> +{
>> +	int idx = bpf_off / sizeof(u64) - 1;
>> +
>> +	if (idx < NR_STACK_ARG_REGS)
>> +		emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
> Could emit_stack_arg_load() read corrupted values if the BPF program reads
> an incoming argument after making a helper or subprog call that clobbered
> the x5-x7 registers?

Verifier will reject this as load (read) cannot be behind helper/subprog-call/kfunc
and store (write).

>
> If LLVM treats the incoming arguments as preserved memory and doesn't spill
> them locally, a mismatch could occur where the verifier applies its bounds
> tracking to the original argument but the program actually reads a clobbered
> value, potentially leading to arbitrary memory reads or writes.
>

