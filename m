Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265CB35F165;
	Thu, 11 Jun 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167212; cv=none; b=GI+xLvpsgJICJ3YCxhBThr0uL7pmr4izEAcxEmaABZp1juszRZtK1c2YgFb5JoH1Rn1VWgvy+J7mgulqOGlxiDym5aBfjsvnw4P4fRTug0JEq3lnc0vl63jzyLZMb+JI05AKHE0+1Ujj/j8IDh9ngQUuiL22FkJCShk1UFcsC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167212; c=relaxed/simple;
	bh=6rH52f7mPeRjAgcKXhUl+7F2bjlYwn8Qjl9TnoFlsFY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MZCv8L5QvxQ1P/4L88QlVEXon0PYL68MZvcunSPVliRAbu5dmGVDiGLAgmj926nNtA8VcaCJ2vlRJ4Drh8tWPJdEOqnBt7Yf7mI+wnKL4iWg+Iy5NbfB1shskoNaj4PvjvrBW8HUIYA2ey1N5lsCsstqqIxTs8B4pD4kfS+CY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxBOlpdCpqRgMTAA--.44424S3;
	Thu, 11 Jun 2026 16:40:09 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxTMJodCpq0bqiAA--.44375S3;
	Thu, 11 Jun 2026 16:40:08 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] bpf: Fix unaligned interpreter panic on JIT
 fallback path
To: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611070009.26257-1-yangtiezhu@loongson.cn>
 <aaca5c93-3b03-4fa2-9653-87c396e5ec7e@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <af1920f1-5b8b-434e-c265-5d679af624b4@loongson.cn>
Date: Thu, 11 Jun 2026 16:40:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aaca5c93-3b03-4fa2-9653-87c396e5ec7e@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTMJodCpq0bqiAA--.44375S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1rKFy5uryrGw18Kr1kCrX_yoW8uw4fpF
	WDG342yF47JayIga9rJ3W3uw15K3yrKr4UG3yrtryDA3Z0vrn3GF15KrZY9FZ3Cr1xCw12
	vr4jvF17uF1kGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU

On 2026/6/11 下午3:37, Leon Hwang wrote:
> On 11/6/26 15:00, Tiezhu Yang wrote:
> [...]
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
>> +				fn = env->ops->get_func_proto(insn->imm, fp);
>> +				if (fn && fn->func)
>> +					insn->imm = fn->func - __bpf_call_base;
> 
> Might have pointer-to-integer warning?

Thanks for the review!

I followed the existing implementation patterns in bpf_do_misc_fixups(),
where it explicitly assigns the delta directly without an explicit cast:

   insn->imm = fn->func - __bpf_call_base;

Keeping it this way ensures maximum consistency with the native code
style in the BPF subsystem, and it does not trigger pointer-to-integer
conversion warnings during my compilation tests.

>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
>>   					   int *err)
>>   {
>> @@ -2639,6 +2663,15 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>   
>>   		fp = bpf_prog_jit_compile(env, fp);
>>   		bpf_prog_jit_attempt_done(fp);
>> +
>> +		/*
>> +		 * If JIT compilation failed or is disabled (!fp->jited), we are
>> +		 * about to fall back to the interpreter path. Fix up the call
>> +		 * offsets to prevent unaligned memory access panic.
>> +		 */
>> +		if (!fp->jited)
>> +			bpf_fixup_fallback_inline_helpers(env, fp);
>> +
> 
> Better to move it after (!fp->jited && jit_needed)?

This is a very sharp catch!

Moving it after (!fp->jited && jit_needed) avoids redundant instruction
traversal on mandatory JIT failure paths. I will update the placement
in the next vision.

Thanks,
Tiezhu

