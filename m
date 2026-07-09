Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3338C40C
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567985; cv=none; b=rrYo7DvPWXSz20HYlcSO9tuz4DR1sUARWMiXGH77XFeelj2Emt1vOC0IqXuuTqBH3CHeapa+vSQEEp1UNTcrXVKgHcBbcUM+3boYT4yu0g86qsksA2pksz4wHjiBtd4efksICgETihmztnT1hroXtvsUvoKGpXWl0oLUGN+tW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567985; c=relaxed/simple;
	bh=q9V5s5y1iSQ74XrB5P54HxA0czOtEoTctnz/+G4QLNE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oNRsY2Rckzu5qdNhvL4YCDdQQYUAzW9szOGWSRg5vgcF9RmhQEpBNsRapmSu+fyA9vunY/5vkHH4Md8lsznr7pJ9ydUX42oIdeNNfcDBn96Wz1q3F/MfGTwbH572LAO2Q0ykh//U1SBWw8LJickgpZNaLZAoy80WI9dp9hHUpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxBOpqFk9qb7UBAA--.2124S3;
	Thu, 09 Jul 2026 11:32:58 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxPsdgFk9qRWsGAA--.11757S2;
	Thu, 09 Jul 2026 11:32:49 +0800 (CST)
Subject: Re: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined helpers
 if JIT is not available
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708101806.18885-1-yangtiezhu@loongson.cn>
 <20260708101806.18885-3-yangtiezhu@loongson.cn>
 <20260708104324.BE58C1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <03339dc1-f23e-e4a0-2f9c-a97f8fe51897@loongson.cn>
Date: Thu, 9 Jul 2026 11:32:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260708104324.BE58C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPsdgFk9qRWsGAA--.11757S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4ftr47Kr48JF47Cry8WFX_yoW5GrWfpF
	sxKw4ak34DXF92kasrt3y8Ww1Ygw48G3W7Gr1rGry0k3WavFn3XF1fKw17u3W5Cr4vy3WI
	vr4I9ryvk3WDGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
	UUU==

On 2026/7/8 下午6:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch unconditionally sets `prog->jit_required = 1` and skips instruction patching for helpers that can be JIT-inlined, which unnecessarily breaks the execution of these BPF helpers under the BPF interpreter when JIT is globally disabled.
> --
> 
> --- Patch [2]: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined helpers if JIT is not available ---
> commit 28807bd656d66a091e77d8589e0c48bef3c4c778
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> bpf: Reject programs with inlined helpers if JIT is not available
> 
> This commit modifies bpf_do_misc_fixups() to set prog->jit_required = 1
> when bpf_jit_inlines_helper_call() returns true. This is intended to prevent
> a kernel panic when JIT compilation fails or is disabled and the interpreter
> tries to execute an unpatched helper call with a raw ID.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 02246df2f6c36..d3be972714b22 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1840,8 +1840,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>   		}
>>   
>>   		/* Skip inlining the helper call if the JIT does it. */
>> -		if (bpf_jit_inlines_helper_call(insn->imm))
>> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
>> +			prog->jit_required = 1;
>>   			goto next_insn;
>> +		}
> 
> [Severity: High]
> Does this unnecessarily reject valid programs when JIT is globally disabled?
> 
> If JIT is disabled (net.core.bpf_jit_enable=0), prog->jit_requested will be
> false. By unconditionally skipping the instruction patching and setting
> prog->jit_required = 1, valid BPF programs using standard helpers (like
> bpf_get_smp_processor_id) will be rejected on architectures supporting this
> JIT inlining.
> 
> If this code instead checked whether JIT was actually requested:
> 
>      if (prog->jit_requested && bpf_jit_inlines_helper_call(insn->imm)) {
>          prog->jit_required = 1;
>          goto next_insn;
>      }
> 
> Would this allow the code to fall through and rewrite the offset when JIT is
> disabled? This would correctly resolve the helper's C function address,
> safely allowing the BPF interpreter to execute these standard helpers without
> crashing, while still preventing the runtime panic if dynamic JIT compilation
> fails.

If JIT is not available, rejecting the loading of programs
with inlined helpers is the intended design.

Thanks,
Tiezhu

