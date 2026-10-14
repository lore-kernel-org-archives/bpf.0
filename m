Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE803438A1;
	Wed, 14 Oct 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944695; cv=none; b=qK2vaTPDvALsMiup3qgmuH5bslFrS7jj5/F3TCS5x3M8sQhzpTD7tpcdoCx3BhIotS5kZASJYMFh9kBYf3bn8MIvnHS7ISNFstlkArcCNW5bswdnJfCRkCJkRNvE1LBaOxoeHK0C6oR7T0V7KV1eTOg7fypQahRyEXBHmjA/QbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944695; c=relaxed/simple;
	bh=54HD4aWvf6er3plKu5EPRAeqkt1EkhUAEvOlSqVw+UQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=frZSSZaWUZWx1jO7Q6vKyIpeVO+QlAvzGiw2R1IIR3/xZzHrdPqVH+eqqNExS6mNi+QVLsmTRQWWzKqtBs4WMmIgKIIiv5XQ4IWu872+4vN1dz1tnDfgMs0X2iu8aTkIoe93FHzKZh/f9MlkUjTmuohPv11vchxlFs5AIMJ9tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxQNHn585qmpsVAA--.63416S3;
	Wed, 14 Oct 2026 10:24:39 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs_f585qZwwsAA--.26964S2;
	Wed, 14 Oct 2026 10:24:33 +0800 (CST)
Subject: Re: [PATCH v2 2/2] LoongArch: BPF: Optimize 32-bit operations using
 native instructions
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
References: <20261013121005.626-3-yangtiezhu@loongson.cn>
 <ab9326a4770f9d1ac812e55feb39e34341d84951f3b5d276dee18d5471d8353e@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d5f6eb99-faf5-1aa7-1f1c-f216611d8082@loongson.cn>
Date: Wed, 14 Oct 2026 10:24:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ab9326a4770f9d1ac812e55feb39e34341d84951f3b5d276dee18d5471d8353e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs_f585qZwwsAA--.26964S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4DGw47CrWUJFyfuFy3trc_yoW7JrWUpF
	ZrKF4Fkr4UJFy7ta48J39rXr42yw4akayrXF1UJrWkC39Iqr1fKF13Kr4S9asxArs3ZF92
	qF1qvwnxXFWUK3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

On 2026/10/13 下午8:55, bot+bpf-ci@kernel.org wrote:
>> LoongArch: BPF: Optimize 32-bit operations using native instructions
> 
> TL;DR: LoongArch BPF JIT now feeds non-sign-extended operands to 32-bit
> div/mod; on cores without DIV32 (e.g. 3A5000) results may be wrong, possibly
> breaking verifier-proven bounds.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
> 
> [ ... ]
> 
>> @@ -752,212 +741,232 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>>
>>   	/* dst = imm */
>>   	case BPF_ALU | BPF_MOV | BPF_K:
>> +		move_imm(ctx, dst, (u32)imm);
>> +		return 0;
> 
> [ ... ]
> 
>>   	/* dst = dst / src */
>>   	case BPF_ALU | BPF_DIV | BPF_X:
>> +		if (!off)
>> +			emit_insn(ctx, divwu, dst, dst, src);
>> +		else
>> +			emit_insn(ctx, divw, dst, dst, src);
>> +		break;
>>   	case BPF_ALU64 | BPF_DIV | BPF_X:
>> -		if (!off) {
>> -			emit_zext_32(ctx, dst, is32);
>> -			move_reg(ctx, t1, src);
>> -			emit_zext_32(ctx, t1, is32);
>> -			emit_insn(ctx, divdu, dst, dst, t1);
>> -			emit_zext_32(ctx, dst, is32);
>> -		} else {
>> -			emit_sext_32(ctx, dst, is32);
>> -			move_reg(ctx, t1, src);
>> -			emit_sext_32(ctx, t1, is32);
>> -			emit_insn(ctx, divd, dst, dst, t1);
>> -			emit_zext_32(ctx, dst, is32);
>> -		}
>> +		if (!off)
>> +			emit_insn(ctx, divdu, dst, dst, src);
>> +		else
>> +			emit_insn(ctx, divd, dst, dst, src);
>>   		break;
> 
> Can divw/divwu be used directly on dst and src here?
> 
> The LoongArch ISA only defines the result of div.w, div.wu, mod.w and
> mod.wu on LA64 when both rj and rk hold sign-extended 32-bit values.  The
> exception is a core that reports CPUCFG2_DIV32 (BIT(26) in
> arch/loongarch/include/asm/loongarch.h), where the upper 32 bits of the
> inputs are ignored.  Cores without that bit, such as the LA464 in the
> 3A5000, may return any value otherwise.  Nothing in the JIT checks for
> CPUCFG2_DIV32.
> 
> The operands here are often not sign-extended.  Every ALU32 result is now
> zero-extended at the common exit of build_insn():
> 
>> +	if (is32)
>> +		emit_insn(ctx, bstrpickd, dst, dst, 31, 0);
>> +
>>   	return 0;
> 
> so any 32-bit value with bit 31 set is left in the register as
> 0x00000000xxxxxxxx.  A BPF_LDX | BPF_W load (ldwu) is zero-extended in the
> same way, and src can hold arbitrary upper bits coming from ALU64 ops or
> pointers, since ALU32 only consumes the low 32 bits.
> 
> For example, with w0 = -6 followed by w0 s/= 3, rj is 0x00000000fffffffa
> when divw executes, so the quotient is not guaranteed to be -2 on a core
> without DIV32.  Likewise, a ldwu of 0xffffffff followed by w1 %= 16 gives
> modwu a rj that is not a sign-extended value.
> 
> The old code widened both operands (zext for unsigned, sext for signed)
> and then used the 64-bit divdu/divd/moddu/modd, which are well defined on
> every LA64 core.  The MIPS64 JIT, which has the same ISA restriction,
> still sign-extends the operands before its 32-bit div/mod.
> 
> [ ... ]
> 
>>   	/* dst = dst / imm */
>>   	case BPF_ALU | BPF_DIV | BPF_K:
>> +		move_imm(ctx, t1, (u32)imm);
>> +		if (!off)
>> +			emit_insn(ctx, divwu, dst, dst, t1);
>> +		else
>> +			emit_insn(ctx, divw, dst, dst, t1);
>> +		break;
> 
> In the K forms the divisor is built with move_imm(ctx, t1, (u32)imm), so a
> negative signed divisor, or an unsigned divisor of 0x80000000 or above,
> also ends up in t1 as a zero-extended value rather than a sign-extended
> one.
> 
> [ ... ]
> 
>>   	/* dst = dst % src */
>>   	case BPF_ALU | BPF_MOD | BPF_X:
>> +		if (!off)
>> +			emit_insn(ctx, modwu, dst, dst, src);
>> +		else
>> +			emit_insn(ctx, modw, dst, dst, src);
>> +		break;
> 
> [ ... ]
> 
>>   	/* dst = dst % imm */
>>   	case BPF_ALU | BPF_MOD | BPF_K:
>> +		move_imm(ctx, t1, (u32)imm);
>> +		if (!off)
>> +			emit_insn(ctx, modwu, dst, dst, t1);
>> +		else
>> +			emit_insn(ctx, modw, dst, dst, t1);
>> +		break;
> 
> The same question applies to the modwu/modw uses in these two cases.
> 
> The verifier narrows 32-bit div/mod results, for example
> scalar32_min_max_umod() bounds the result of w1 %= 16 to [0, 15].  If the
> JITed code returns a different value on a core without DIV32, can the
> program end up with a value outside the range the verifier proved, for
> instance when it is used as a map value offset?
> 
> The commit message reports test_bpf, test_verifier and test_progs passing,
> but does not say which CPU was used.  Would those results be reproducible
> on a core without CPUCFG2_DIV32?
> 
> Would it be better to sign-extend both operands into temporaries (for
> example addw t, reg, $zero) before divw/divwu/modw/modwu, to gate the
> native 32-bit forms on CPUCFG2_DIV32, or to keep the previous 64-bit
> sequence for these four opcodes?

I will modify the code to adapt to the actual CPU hardware capabilities
dynamically. After testing the patch on CPU cores both with and without
CPUCFG2_DIV32, I will send out the v3 series.

Thanks,
Tiezhu

