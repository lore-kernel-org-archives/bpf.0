Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0919DF55;
	Mon, 13 Apr 2026 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052950; cv=none; b=JSJ06WgbDjhUtTcLhlWg28PZmlzX3lJiC++pYb0RtgmMuU1iT29/3kkP2aluIr8jiPDGV82/5+tYESQZYQuehCgDx1pbd799oi80cnaTSEQ6YBRHGCv3oHrzvGRBgAwDG6j8eJMoo6lRSLIA7iqXxB5b4XwiEh3Sn0sVxwRvRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052950; c=relaxed/simple;
	bh=QxWRHSMp1/Al5AZhtUT19IBqkpz5G5CLCcuYpkGa9CE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Il9NAazvbRHgpuzbX6wzcwcrFJ9DOVOOLoOVzXTMLyW/Q1IO4u3Abv2ysQlE8zYfAEOO2OwvIzxByl+8do5YDtcWJoc+6yI6dO6z2bHdDAd4qElGqVMhnT2OV0wAucozFuKnLdrfgBb9N4aK+ASuAxoYQnnVcNFgQKlLJ9nfWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxIuvTatxpXgIAAA--.61S3;
	Mon, 13 Apr 2026 12:02:27 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx2+DQatxpstxrAA--.8752S3;
	Mon, 13 Apr 2026 12:02:26 +0800 (CST)
Subject: Re: [PATCH v2 4/5] LoongArch: BPF: Support load-acquire and
 store-release instructions
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>,
 loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407062306.8915-1-yangtiezhu@loongson.cn>
 <20260407062306.8915-5-yangtiezhu@loongson.cn>
 <CAHirt9jnveJCgCt2TsuyQrJV0tCB+FJStgP6OaCiH8eJWLfpvw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fa0a3521-7373-70d8-e08a-d2059fc62265@loongson.cn>
Date: Mon, 13 Apr 2026 12:02:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHirt9jnveJCgCt2TsuyQrJV0tCB+FJStgP6OaCiH8eJWLfpvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx2+DQatxpstxrAA--.8752S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKry5Aw1UZFWrZw15JFy7Arc_yoW8Jr1UpF
	4DJw4rKF4rArykur98Gr42qw1fKF4fKF45Gw15J34fJFyqvrnxKFn8KF1YkFW3Cr18JFn7
	ZF1qv3srZ3W5CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==

On 2026/4/12 上午11:46, WANG Rui wrote:
> On Tue, Apr 7, 2026 at 2:23 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Use the LoongArch common memory access instructions with the barrier dbar
>> to support the BPF load-acquire and store-release instructions.

...
>> +static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
>> +{
>> +       const u8 t1 = LOONGARCH_GPR_T1;
>> +       const u8 src = regmap[insn->src_reg];
>> +       const u8 dst = regmap[insn->dst_reg];
>> +       const s16 off = insn->off;
>> +       const s32 imm = insn->imm;
>> +
>> +       switch (imm) {
>> +       /* dst_reg = load_acquire(src_reg + off16) */
>> +       case BPF_LOAD_ACQ:
>> +               switch (BPF_SIZE(insn->code)) {
>> +               case BPF_B:
>> +                       if (is_signed_imm12(off)) {
>> +                               emit_insn(ctx, ldb, dst, src, off);
>> +                       } else {
>> +                               move_imm(ctx, t1, off, false);
>> +                               emit_insn(ctx, ldxb, dst, src, t1);
>> +                       }
>> +                       emit_zext_8(ctx, dst);
> 
> Could we use ld[x].{bu,hu,wu} here to simplify this?

Yes, this is better, the instructions are zero extended, so no need
to use the bstrinsd instruction to clear the higher bits explicitly,
thanks for your suggestion.

I tested the changes, it works well, v3 is coming soon.

Thanks,
Tiezhu

