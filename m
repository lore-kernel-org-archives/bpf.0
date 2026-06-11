Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EF31F5821
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167067; cv=none; b=WdhWdMgbHLepgUmQZrv7pOR9bYQW1S/1/2Wt3czfSAiO7+CGLKCEkxPrhmL6tv8grc8RyBphl7YH7zSXAZAZUYMPA1tcGCb81BuKZcGorJd71mkdNGBwYrBvMkVH7MV7ZmIQ4x8ieagd3bHv+eSHTCcWbJjCL1RkbHeToW8Ox9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167067; c=relaxed/simple;
	bh=SlXS4po6XQg1j575v8xfgxW21ndMClG45vNxGbuajfs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hxAdQv9ggrXYSfJyG4mSVBpYVcDx+DAdOoUgP+g9I7Q0vvpV+wnWMmYJfRJz5R/MHhjJkKqwLCIefPHIQU5oUd/4N+MV9cWh5gkswAoGo4fEhTS95ru0zlVfIONFVHZx8Js06gJKW1aTIKYYl0Qe7J2VaECmGvJLHKjqdneL860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxRenQcypqIgMTAA--.44323S3;
	Thu, 11 Jun 2026 16:37:37 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx2+DHcypqPbqiAA--.47474S3;
	Thu, 11 Jun 2026 16:37:27 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] bpf: Fix unaligned interpreter panic on JIT
 fallback path
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260611070009.26257-1-yangtiezhu@loongson.cn>
 <20260611071828.8C8DF1F00893@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fed2e4ef-f96b-6e6e-0f89-6c7fc04a5d37@loongson.cn>
Date: Thu, 11 Jun 2026 16:37:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260611071828.8C8DF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2+DHcypqPbqiAA--.47474S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw18try8Ww48KFW7XFWxZrc_yoWrJFW8pF
	95Gr4jkw4DXFZ7u39rJw1vq3W5Xw48Ga48Gas5KryFkanIvrn3CF15Kw48WanxGr48ur1a
	vw42yF17C3Z5GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07j0sjUUUUUU=

On 2026/6/11 下午3:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Type confusion between BPF helper enum IDs and address offsets in `bpf_fixup_fallback_inline_helpers()` leads to potential silent instruction corruption.
> --
> 
> commit e06144ee47e54fe6934472bff4024530f26b7737
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> bpf: Fix unaligned interpreter panic on JIT fallback path
> 
> This commit introduces a fallback fixup phase to rewrite the call offsets
> for inlined helpers when JIT compilation fails or is skipped. This prevents
> unaligned memory access panics when falling back to the interpreter.
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f3..de0c46b495b40 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>> @@ -2608,6 +2608,30 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>>   	return prog;
>>   }
>>   
>> +/*
>> + * Rewrite the helper call offset for inlined helpers when fallback to
>> + * the interpreter happens due to JIT compilation failure or JIT disabled.
>> + */
>> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
>> +{
>> +	struct bpf_insn *insn = fp->insnsi;
>> +	const struct bpf_func_proto *fn;
>> +	int i;
>> +
>> +	if (!env || !env->ops->get_func_proto)
>> +		return;
>> +
>> +	for (i = 0; i < fp->len; i++, insn++) {
>> +		if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {
>> +			if (bpf_jit_inlines_helper_call(insn->imm)) {
> 
> [Severity: High]
> Could this cause a type confusion where a patched address offset is
> misinterpreted as a helper enum ID?
> 
> Since bpf_do_misc_fixups() already patches insn->imm with a 32-bit address
> offset (fn->func - __bpf_call_base) for helpers that are NOT expected to be
> inlined by the JIT, insn->imm will already be an offset when reaching this
> loop for non-inlined helpers.
> 
> If the distance between a non-inlined helper and __bpf_call_base happens to
> match the enum ID of an inlined helper (for example,
> BPF_FUNC_get_smp_processor_id = 8), wouldn't bpf_jit_inlines_helper_call()
> falsely return true?
> 
>> +				fn = env->ops->get_func_proto(insn->imm, fp);
>> +				if (fn && fn->func)
>> +					insn->imm = fn->func - __bpf_call_base;
> 
> If the type confusion triggers, it seems this line would overwrite the
> original, correct offset with the offset of an entirely different helper
> function, potentially causing the interpreter to execute the wrong helper.

To address the type confusion risk between raw helper enum IDs and
already-patched massive 32-bit address offsets (since regular helper
conversions leave src_reg at 0), I will apply a strict bounds check
against __BPF_FUNC_MAX_ID to safely isolate and filter out previously
fixed-up helper calls. Also, I have replaced fp with env->prog for
better type safety when calling get_func_proto().

Here is the updated function:

static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env 
*env, struct bpf_prog *fp)
{
         struct bpf_insn *insn = fp->insnsi;
         const struct bpf_func_proto *fn;
         int i;

         if (!env || !env->ops->get_func_proto)
                 return;

         for (i = 0; i < fp->len; i++, insn++) {
                 if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg 
== 0) {
                         /* Filter out already-patched address offsets. */
                         if (insn->imm >= __BPF_FUNC_MAX_ID)
                                 continue;

                         if (bpf_jit_inlines_helper_call(insn->imm)) {
                                 fn = 
env->ops->get_func_proto(insn->imm, env->prog);
                                 if (fn && fn->func)
                                         insn->imm = fn->func - 
__bpf_call_base;
                         }
                 }
         }
}

Thanks,
Tiezhu

