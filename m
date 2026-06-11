Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316B3DA7EC;
	Thu, 11 Jun 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177318; cv=none; b=VlQVJ7FhVdOO6XpWeLCAgOOAxj8Ob5EZasGaOJc6QmXBzUZztFCi7w2RLfdEOmmGv1ep2BHjrFXz/9OSUzErDJDt+8LIOs7JLXxY29hOhHtS2bgfVPacmiJyZjA6OBZ0qXCa+WfqomxPVMZXnaperJKo0RJYOC1NphkYSOY8CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177318; c=relaxed/simple;
	bh=+9wp5V6D5Bltd2jLQp5zJbp9nEjPhO/A6yZpBaLOOWw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SiAu19XG4ARn9/iV0cmA5+NKG80uiGwMyaXTVRCa2qyPhFcQNv7wmFuEjZ2pzUp/9yu/hbPdCeJ3/gV7dIy3cll9v8S49GUlUrHVFSYhjjJ5312DvwB0re/0UubEv1VzCjHkLDRQcgYHtBq+R0aLdUe31XIVNcbG0s+ly44W0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxf+vhmypq7g0TAA--.50069S3;
	Thu, 11 Jun 2026 19:28:33 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx6+Dfmypq8N+iAA--.48063S3;
	Thu, 11 Jun 2026 19:28:32 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: puranjay@kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
 <cc40d131145e6dee4d8b34b51a5612afa7286af59c44fa7710a512445a6078d6@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <26402a7d-994d-8738-b201-3cc149f1232c@loongson.cn>
Date: Thu, 11 Jun 2026 19:28:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cc40d131145e6dee4d8b34b51a5612afa7286af59c44fa7710a512445a6078d6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+Dfmypq8N+iAA--.48063S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKr1rWF15ZF1rJFW7KFWxuFX_yoW8Jr4DpF
	1kJw42ya1vqF47u3srXw4Iyas8K3yrKa43Ga4kKry3tF909r1kWF15Gr1Fgrs3urW0kF1I
	vr1I9Fy2kF9YgFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0pB
	-UUUUU=

On 2026/6/11 下午6:54, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f..5785c8cb4dbe 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2608,6 +2608,31 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>>   	return prog;
>>   }
>>
>> +/* Fix up helper call offsets for inlined helpers on JIT fallback path. */
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
> 
> Would it be cleaner to use bpf_helper_call(insn) here instead of the
> manual condition check?
> 
> The bpf_helper_call() helper from include/linux/bpf_verifier.h performs
> the same check and is used throughout the codebase for consistency. It
> improves readability and makes the intent more explicit.

OK, this is better.

I will send v3 after waiting for more review comments.

Thanks,
Tiezhu

