Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC443F7E73
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357862; cv=none; b=KjGh1WP7apIlKdbE+L+VezYPaYQiW91ZX4I693ARGeFMx2vkk736lseEtakc2+1ThuI/k74UoAoL7JFlMMmH0V3avngysXzQM5WJukb7tRkL0PYlfuAvaa20akKiuiAh9WDlUuLSiKGC4ykjjjC5U+5A3BSL46XGzhWAnG+WL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357862; c=relaxed/simple;
	bh=YCVNfVgIpBzJm2Hd4TTEJx5VB5I3bYj3Ow25o7DzAgo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PJvkRImnKuROngz/3ysCysdPpmJsrbKza7O8f65T5lzGG7AcF+Vrh/aMYCQpgNeuGvImAyPxAt4FG0xS7Bon43vLUUrQ64E60y+UbVo1Zqy0cdxheGIUL6ZccSJFE2UpCD1qxSRpfKfk81Q+8WK85du2d3eWRyTRVN1J34qMWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxH6pdjcJpti8eAA--.27064S3;
	Tue, 24 Mar 2026 21:10:53 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx98BcjcJpajVcAA--.31199S3;
	Tue, 24 Mar 2026 21:10:52 +0800 (CST)
Subject: Re: [RFC PATCH 6/7] LoongArch: BPF: Add load-acquire and
 store-release instructions
To: bot+bpf-ci@kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev, WANG Rui <wangrui@loongson.cn>
References: <20260324090106.13527-7-yangtiezhu@loongson.cn>
 <5a2cfd2c3dddef83de46ea9b0f02bb5b90c29937c9b9d348542838fde1e29a93@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bbb797cd-c6ea-f61c-d99c-66908e4e5f68@loongson.cn>
Date: Tue, 24 Mar 2026 21:10:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a2cfd2c3dddef83de46ea9b0f02bb5b90c29937c9b9d348542838fde1e29a93@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx98BcjcJpajVcAA--.31199S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr48Kry5ZF1UAry7Gw1fKrX_yoW8Ar45pF
	ZFy3Z5CrWvgryDZF97Ja18ZFyxtF4fKF13WF1UJrWSgr15Wr1SqFn5K3WYva98Gw4kCr40
	9ryYywnIvFyDZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDU
	UUU

On 2026/3/24 下午5:42, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index c9a32f124f5e..d1e9866911dd 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
> 
> [ ... ]
> 
>> +	/* store_release(dst_reg + off16, src_reg) */
>> +	case BPF_STORE_REL:
>> +		switch (BPF_SIZE(insn->code)) {
> 
> [ ... ]
> 
>> +		case BPF_W:
>> +			if (cpu_has_llacq_screl) {
>> +				move_imm(ctx, t1, off, false);
>> +				emit_insn(ctx, addd, t2, dst, t1);
>> +				emit_insn(ctx, screlw, src, t2);
> 
> SCREL.W is a store-conditional instruction, not a plain store-release.
> It checks LLbit and then overwrites rd with the success indicator
> (1 or 0), which would clobber the BPF source register.
> 
> Looking at emit_atomic_rmw() in the same file for BPF_CMPXCHG, the
> existing LL/SC usage carefully avoids this:
> 
>      move_reg(ctx, t3, src);
>      emit_insn(ctx, scw, t3, t1, 0);
>      emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
> 
> Here SC.W is applied to the temp register t3 rather than the BPF
> register, and t3 is then checked for 0 to retry the loop. This
> confirms that SC-family instructions clobber their rd operand on
> LoongArch.
> 
> Is SCREL.W/D the right instruction for a standalone store-release?
> The other architectures use plain stores with ordering guarantees
> for BPF_STORE_REL:

Indeed, I misunderstood the instructions before, thanks Wang Rui and
bot+bpf-ci. I did some changes locally and tested again, the related
testcases passed.

I will use the common memory access instruction with the barrier dbar
to support load-acquire and store-release in the next version.

Thanks,
Tiezhu

