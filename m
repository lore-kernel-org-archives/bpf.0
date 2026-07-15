Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EC2EACEF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154480; cv=none; b=aBK62rIU4vElSkvo7wcSfw8C1Cj46TfDT3yNQLhwV+mm8yjaqhZwxD36+R1PjA41kQ+I1j3iKrsgyjjM2142lRE0af8dXqHCpAW3GLhL9c/U9EOXyU5mGDdnmcd3347EDFBmuw+tm9fNmUnbpglPoMtdrRqkIkQDdX4JFPEll0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154480; c=relaxed/simple;
	bh=NKAFqrIo/N34Qlzfl8cF07HDq2Q54AsT+hgjfQQKVCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAlBKneKCNItlp0V2nI2zYtlA3BRo8zx8RfahsmWGOhxDjwu1O7aMjuTLzL/TUI7sksuC3kf++fMi3FpuDppH7x2/GMi+xf0WM8AElAga7EtWjOGYmO4owEziB6gxAimPsnSoQRbmMHrTraiyyhVQPyyapbicTXq2/ENXVtRyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCIDexud; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCIDexud"
Message-ID: <9ddec85b-2a70-4bf6-af09-701f485d0cae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5pDJqFLXru8M/uzKbcNpqPlIPSM24gtV8scs/eEnfQ=;
	b=ZCIDexudtVUl6RNVh575inHkvo69NjBuJwSGNsBt6gChaNKiOpjZMKd08I0AwYhWwlL0QZ
	CU8LHZ2+iu0vkdP32eyEm+eINtXW31KfKSTCm6m2c6v8P9b5tg/YBJSdsC0jBzhZWZtQsu
	rVYStTmbF1wmIujnrpwo1kvSZHYveUA=
Date: Wed, 15 Jul 2026 15:27:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST management in
 do_jit
To: sashiko-reviews@lists.linux.dev,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
 <20260709110819.6BED51F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709110819.6BED51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 4:08 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `emit_st()` helper absorbs `Arg 6` pseudo-store and `BPF_REG_PARAMS` translation, causing invalid KASAN instrumentation for BPF_ST instructions.
> --
> 
> --- Patch [5]: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST management in do_jit ---
> commit b88dd49e34d6904772392eec8dfdeba3542805c4
> Author: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> bpf, x86: refactor BPF_ST management in do_jit
> 
> This commit extracts the x86-64 BPF_ST instruction emission logic into a single
> emit_st() helper function. It is intended to prepare for KASAN checks being
> inserted before memory loads and stores.
> 
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d35f58350d710..959fcaa0cde9a 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1410,6 +1410,64 @@ static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int
>>  	*pprog = prog;
>>  }
>>  
>> +static void emit_st(u8 **pprog, struct bpf_insn *insn, int dst_reg,
>> +		    s32 outgoing_arg_base, u16 outgoing_rsp)
>> +{
>> +	s32 imm32 = insn->imm;
>> +	u8 *prog = *pprog;
>> +	s32 insn_off;
>> +
>> +	switch (BPF_SIZE(insn->code)) {
> [ ... ]
>> +	case BPF_DW:
>> +		if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
>> +			/* Arg 6: store immediate in r9 register */
>> +			emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31,
>> +				       (u32)imm32);
>> +			*pprog = prog;
>> +			return;
>> +		}
>> +		EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>> +		break;
>> +	}
>> +
>> +	insn_off = insn->off;
>> +	if (dst_reg == BPF_REG_PARAMS) {
>> +		/*
>> +		 * Args 7+: reverse BPF negative offsets to
>> +		 * x86 positive rsp offsets.
>> +		 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
>> +		 */
>> +		insn_off = outgoing_arg_base - outgoing_rsp -
>> +			insn_off - 16;
>> +		dst_reg = BPF_REG_FP;
>> +	}
> 
> [Severity: High]
> Does hiding the BPF_REG_PARAMS translation inside emit_st() conflict with the
> stated goal of adding KASAN instrumentation before the call?
> 
> If KASAN checks are inserted in do_jit() before emit_st() is called, wouldn't
> they attempt to instrument Arg 6 (which uses register r9, not memory)?
> 
> Additionally, wouldn't any KASAN checks added before this helper use the raw
> BPF_REG_PARAMS pseudo-register before it is translated to BPF_REG_FP, causing
> instrumentation against an unmapped register (which evaluates to rax)?

I think sashiko is wrong, because BPF_REG_PARAMS stores should always have
non_stack_access = false, but please double check

> 
> [ ... ]
> 

