Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500343A5431;
	Mon, 27 Jul 2026 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120670; cv=none; b=kr3nHvoADqf6dJmsCLN3/BTEEoaZs9malqu998nmAhJU9JKwj5hwwJ0iPLkkRkiZJWT7wXsehbNTSmD1b4xM2w8vyk1gKm19oohARZrzpD9k7/I1FbbsF8rCpMkRA83CkLoXyC+09+gClzhB75M924Dq3sOL7fIfqggYWJzO21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120670; c=relaxed/simple;
	bh=OwPkACbEPQSVRVNRHcVlYm1f1y6ZvMPJGiWJUOg34iI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nwBviy9UYDuEPqqhJArLv9H8NsF/sw3RftqqbrGIODnhdOME7ZSBdp6Re+bwQI5XoRheihfqZH1TX1QXOTPQ1YfsBxY/XetNrcxkHirSvZanOeHK11iqAMW2k1QLqoGmmk1/dHYwON2MHhbUbc3j8Wxg6qCmJStpRg3+lUciqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuKAix2ZqtJoHAA--.3745S3;
	Mon, 27 Jul 2026 10:49:07 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxDcf5xmZqKxQaAA--.8355S2;
	Mon, 27 Jul 2026 10:48:26 +0800 (CST)
Subject: Re: [PATCH RFC 2/2] LoongArch: BPF: Eliminate zero/sign extensions
 for 32-bit operations
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260711101656.7415-1-yangtiezhu@loongson.cn>
 <20260711101656.7415-3-yangtiezhu@loongson.cn>
 <CAEyhmHRahSQeasoz2J1QTFcaNCtGPHdH7OT7VC3uKvTy61byfA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b20c7963-e1b8-cc37-b16b-52cced81316c@loongson.cn>
Date: Mon, 27 Jul 2026 10:48:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEyhmHRahSQeasoz2J1QTFcaNCtGPHdH7OT7VC3uKvTy61byfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDcf5xmZqKxQaAA--.8355S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1UXr47ur13try8uFWrtFc_yoW8Jw47pr
	s7KF4Ska1DJrn2vry8ArZrXr43Ar4Yga1kGr1qq3y8Z34a9r1SgFyjga12kFyxCr4xWr4v
	qF1qvr98ZF45GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=

On 2026/7/26 下午5:23, Hengqi Chen wrote:
> On Sat, Jul 11, 2026 at 6:17 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Eliminate frequent and redundant zero-extensions and sign-extensions
>> for 32-bit operations. This prevents potential functional bugs caused
>> by incorrect extension selections and reduces runtime overhead.

...

>> @@ -741,28 +725,32 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>>          switch (code) {
>>          /* dst = src */
>>          case BPF_ALU | BPF_MOV | BPF_X:
>> +               if (imm == 1) {
>> +                       emit_insn(ctx, lu32id, reg, 0);
> 
> reg ?
> 
>> +                       break;

...

>>          /* dst = dst & imm */
>>          case BPF_ALU | BPF_AND | BPF_K:
>> +               if (is_unsigned_imm12(imm)) {
>> +                       emit_insn(ctx, andi, dst, dst, imm);
>> +               } else {
>> +                       move_imm(ctx, t1, imm);
>> +                       emit_insn(ctx, and, dst, dst, t1);
>> +               }
>> +               emit_insn(ctx, addiw, dst, dst, 0);
> 
> break; ?

Thanks for your review.
As mentioned in the cover letter, this hasn't been tested.
I just want to confirm that this is the correct direction.

The long-term goal is to eliminate frequent and redundant
zero-extensions and sign-extensions, but there are still
some issues to sort out. I will send the formal patch once
all problems are fixed.

For now, I will send out the stable and verified patches
first this week.

Thanks,
Tiezhu

