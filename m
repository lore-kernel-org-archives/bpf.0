Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074230;
	b=h1O3gW0nrK+fN0J+Zk750B5XKZEYRLoYAsMG0ddUsBkunpnn9VM5OTkMbCH8xvxv5Q4U
	 iz/1PIXum5zUMKWpp5rWgBxbSJdQL2CWJVT4k90HkfjLlOazLtZBVLBbyrjHcltLNrty0
	 IoMgDTpZ6CONAuasFlr2F4NZfBFj6ZRkizohAwpckDbwwIbs6r0PXtx4h29I0AsGpop8E
	 F4e7xEiCpKvCw84xCgu34Xo9JYD9REfMWvZD+RT9D1rHHKjyyXJVkeOqckrNYPqfHhdLI
	 yj1HV7kDP/l8FGEnTg+bPdxqpGgFH8rYFWvcSfPOpCDJLZCKULM2NS5K1EsuY+0wQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074230;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=/8PAWzs/4v7CmdiFS6NRHGflhDZfELTmdZRWhE8jV00=;
	b=kz1xUDTSKn+tXEnMJb52UxTFnNHFHatouKEd2tr3e1DZxL6yhWHp37WCyDxdi4Z6Bju0
	 03P1/oiXZpyZ0+W3U1B2T2pjwuz4j4W971OQiCFy4GTMuP8RmvwtnYaRVhMPbmJ85LVwq
	 ZDRjb5vVskm4I3mx7kiNv/Eqx7dOUJQvR7igIgvvkm45jSMqyDIKXRq5ICa05EH1WbRxj
	 Qmc9kERz4/PVeJHYbuJDaI9yo8hnNRL5bjDEYq5K4t+fP6DqObVCjmOoQNLze1QIs5abv
	 zC3kj+tpfsGcSTpowRg/k54Pmo8ag7t7C33Htr0UyZAaj1czsDssa0NPMQas0k7mExw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8F606A31A;
	Tue, 27 Oct 2026 04:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A8F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxX9MxJOBqqrIZAA--.9148S3;
	Tue, 27 Oct 2026 12:10:25 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxlMwxJOBq+o0wAA--.8791S2;
	Tue, 27 Oct 2026 12:10:25 +0800 (CST)
Subject: Re: [PATCH v3 3/3] LoongArch: BPF: Optimize 32-bit operations using
 native instructions
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
 <20261016081006.26069-4-yangtiezhu@loongson.cn>
 <CAEyhmHQe5T6Ai0LXiJnwXzBgy_Xu5=upeqWHbMz7J3X6QntWBA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b5c793ec-c951-930f-fc9d-06de6f49ac9e@loongson.cn>
Date: Tue, 27 Oct 2026 12:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAEyhmHQe5T6Ai0LXiJnwXzBgy_Xu5=upeqWHbMz7J3X6QntWBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMwxJOBq+o0wAA--.8791S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4Utw47JF4fZF1UKF4Utrc_yoW8Wr4UpF
	sxWa9Iqa1DXa42kF12yF4DAFsxKwn5Way8Xr45A34vkF98J3Z8KayqgrsY9Fn5J3s5Ww4F
	vF17X34DZa1qg3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 2026/10/27 上午10:02, Hengqi Chen wrote:
> On Fri, Oct 16, 2026 at 4:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Currently, the LoongArch BPF JIT emits numerous redundant zero and sign
>> extensions across 32-bit operations, bloating the final JIT image size
>> and also leading to runtime overhead, particularly in the division and
>> modulo operations. Thus, it is necessary to optimize 32-bit operations
>> by emitting LoongArch native 32-bit word instructions.

...

>> +               if (cpu_has_div32) {
>> +                       if (!off)
>> +                               emit_insn(ctx, divwu, dst, dst, src);
>> +                       else
>> +                               emit_insn(ctx, divw, dst, dst, src);
> 
> For ALU32 SDIV, off != 0, it seems like there is a overflow in S32_MIN / -1.
> verifier_sdiv.c has related test cases but annotate with
> __arch_x86_64, so it is not run on LoongArch.

After enabling the signed division and modulo overflow tests for
LoongArch, here are the test results:

$ sudo ./test_progs -t verifier_sdiv | grep "MIN/-1"
#731/121 verifier_sdiv/SDIV64, overflow r/r, LLONG_MIN/-1:OK
#731/123 verifier_sdiv/SDIV64, overflow r/i, LLONG_MIN/-1:OK
#731/125 verifier_sdiv/SDIV32, overflow r/r, INT_MIN/-1:OK
#731/127 verifier_sdiv/SDIV32, overflow r/i, INT_MIN/-1:OK
#731/129 verifier_sdiv/SMOD64, overflow r/r, LLONG_MIN/-1:OK
#731/131 verifier_sdiv/SMOD64, overflow r/i, LLONG_MIN/-1:OK
#731/133 verifier_sdiv/SMOD32, overflow r/r, INT_MIN/-1:OK
#731/135 verifier_sdiv/SMOD32, overflow r/i, INT_MIN/-1:OK

That is to say, the current jit code is no problem.

Thanks,
Tiezhu

