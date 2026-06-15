Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB41DA62E;
	Mon, 15 Jun 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486650; cv=none; b=jIZ/N+ixn3ncyLlvr4eD8c/+KEAofdYUN8d70pZxFrqwc3gGH20wJaAkKzqtsboCj+wWrc5I1l0IXKsrn9zsLMY43QrFwLC01stR8K9iZOXDW/ea0zC4VB8GWLTvkQvSALGWWt3Cjs7OtB6nO7eNchNdFiNR4GVglmgd/iPZack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486650; c=relaxed/simple;
	bh=l5IZV0u1np2bYmJeRpGYCRX+6r++EXUep8GaWJEAvuQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ff/sFuUoHUrbQn5lESA7tupLna+Dp4+YTc7T8f5U3+hQ77PL3MxHNTn6+I5kfd/pOZl2Mbpd/QFl+ncfsEKzTMLFMZll6l5JpT5KHl1Lat47YkWdfOYIOdMUU8P8nSq7FhMCgq7aYEqdLiN/Utrv1MpfH+1H4KcnPGNMCvEKbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax_ukwVC9qGCcUAA--.52398S3;
	Mon, 15 Jun 2026 09:24:00 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx+8ElVC9qAZemAA--.55405S3;
	Mon, 15 Jun 2026 09:23:50 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
 <093f957d-3d3a-4ce7-b59b-06203c556629@huaweicloud.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9c84609b-3b82-9a43-0f25-4ac632109819@loongson.cn>
Date: Mon, 15 Jun 2026 09:23:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <093f957d-3d3a-4ce7-b59b-06203c556629@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8ElVC9qAZemAA--.55405S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry7XFy7WrW8Ar18KFWkKrX_yoW5WF1UpF
	1kJrWUCryUJFs3Xry7Jr1UXFy5Jr4UJ3WUJr1rXFyUJF47Xr1jgF1UWr1vgr15Jr48Jr1U
	Ar4jvrnrZr15JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUUUU=

On 2026/6/12 下午8:37, Xu Kuohai wrote:
> On 6/11/2026 6:12 PM, Tiezhu Yang wrote:
>> When an architecture implements bpf_jit_inlines_helper_call(), such
>> as LoongArch, ARM64, and RISC-V, the BPF verifier skips rewriting
>> the helper call offset (insn->imm) during the bpf_do_misc_fixups()
>> phase if the helper is expected to be inlined by the JIT compiler.
>> As a result, insn->imm remains as the raw helper enum ID.

...

>> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env 
>> *env, struct bpf_prog *fp)
> 
> The function name is a bit long for a static function

If there are no objections, I will shorten the static function
name to bpf_fixup_inline_helpers() in v4.

>> +{
>> +    struct bpf_insn *insn = fp->insnsi;
>> +    const struct bpf_func_proto *fn;
>> +    int i;
>> +
>> +    if (!env || !env->ops->get_func_proto)
>> +        return;
>> +
>> +    for (i = 0; i < fp->len; i++, insn++) {
>> +        if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {
>> +            /* Filter out already-patched address offsets. */
>> +            if (insn->imm >= __BPF_FUNC_MAX_ID)
> 
> The check is redundant, since bpf_jit_inlines_helper_call() already
> filters out insn->imm numbers that is not a valid helper id.

Yes, I see your point. If insn->imm is an invalid helper ID,
bpf_jit_inlines_helper_call() will hit the default branch and
return false, making the prior check redundant. I will clean
this up.

>> +                continue;
>> +
>> +            if (bpf_jit_inlines_helper_call(insn->imm)) {
>> +                fn = env->ops->get_func_proto(insn->imm, env->prog);
>> +                if (fn && fn->func)
>> +                    insn->imm = fn->func - __bpf_call_base;
>> +            }
>> +        }
>> +    }
>> +}
>> +
>>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env 
>> *env, struct bpf_prog *fp,
>>                          int *err)
>>   {
>> @@ -2643,6 +2668,9 @@ struct bpf_prog 
>> *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>               *err = -ENOTSUPP;
>>               return fp;
>>           }
>> +
>> +        if (!fp->jited)
>> +            bpf_fixup_fallback_inline_helpers(env, fp);
>>       } else {
>>           *err = bpf_prog_offload_compile(fp);
>>           if (*err)
> 
> I tested it on arm64 and the patch works.
> 
> Tested-by: Xu Kuohai <xukuohai@huawei.com>

Thanks for your review and the Tested-by tag.

Thanks,
Tiezhu

