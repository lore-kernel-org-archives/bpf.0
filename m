Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D534F479;
	Mon, 19 Oct 2026 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394313; cv=none; b=A2Oj/xm6IDJNeKvzawrU7VthELVk6evhaRkjVrQ4k33nl4Q7f2Q6EbqlS5fDQrdhs1Nncd1lWNSqe9QRLSNfFmDDYt3fFTlVislZ8FeGVk84S2ZRfmz4tbCzGe6yHEw1Ddzi/vP+Ghl2uO3KMuGqqjj8PnGa8VSLBPReu8q5Tog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394313; c=relaxed/simple;
	bh=9yKawQQoA//h0KHEdlu1uZglSjBRUM72WxHod0luenw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RgAS7eOS3L/btHM0wjyHnV0ymsfVYSHsIyg0MaRI6BOSl+8hAclXCnjjx2GuNI4xtgEl47yu4OpJN2+OBVbqp+qosbZ65zfHAaoOtLOQSmLbjn3SrD2DXuIOWRPMagFTwiL7H4uu1+dq5Y5LCbjDZ3RauxW1feUAPvFxI2i4X24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Ax39JFxNVqHzUXAA--.1364S3;
	Mon, 19 Oct 2026 15:18:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxtMxDxNVqp+wtAA--.4251S2;
	Mon, 19 Oct 2026 15:18:29 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use snake_case for subtest
 descriptions in jit_insns_arena.c
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019040106.27309-1-yangtiezhu@loongson.cn>
 <d13c66a3-0519-48c1-88fe-55bc755b79a2@iogearbox.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <84434f7a-1c38-03ea-3062-8e8cf364fd4e@loongson.cn>
Date: Mon, 19 Oct 2026 15:18:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d13c66a3-0519-48c1-88fe-55bc755b79a2@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMxDxNVqp+wtAA--.4251S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trW8XFWUGw4DCrWkurWDZFc_yoW8WF4fpa
	yDWrWaqrZ7A3WS9w4kZw18Ga40kFZ5J3WDKryrXr15Gry5G3WYg34UKrn0kFWvgFWxZryI
	kw42vF9FgFy7CFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I3
	8UUUUUU==

On 2026/10/19 下午2:47, Daniel Borkmann wrote:
> On 10/19/26 6:01 AM, Tiezhu Yang wrote:
>> Normalize two inline assembly test descriptions in jit_insns_arena.c
>> from space-separated strings to snake_case.
>>
>> It is done for consistency with other neighboring subtests registered
>> in test_jit_insns() (such as alu_imm, alu_reg, etc.). This also makes
>> it convenient to execute these subtests directly from the command line
>> without being forced to use shell quoting.
>>
>> Otherwise, unquoted shell word-splitting causes test_progs to reject
>> the extra arguments before the filter code runs:
>>
>> $ sudo ./test_progs -t jit_insns/arena access with zero offset
>> Usage: test_progs [OPTION...]
>> Try `test_progs --help' or `test_progs --usage' for more information.
>>
>> $ sudo ./test_progs -t jit_insns/cast to a user address
>> Usage: test_progs [OPTION...]
>> Try `test_progs --help' or `test_progs --usage' for more information.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Do these not work already?
> 
>    ./test_progs -t jit_insns/arena_zero_off
>    ./test_progs -t jit_insns/cast_to_user

Yes, they work.

I misunderstood that the name is "cast to a user address" in the output
rather than "cast_to_user" before, there is difference between the
description and the name.

Something like this:

$ sudo ./test_progs -t jit_insns/cast_to_user
#191/2   jit_insns/cast to a user address:OK
#191     jit_insns:OK
#192     jit_insns_blinded:OK
Summary: 2/1 PASSED, 0 SKIPPED, 0/0 FAILED

Anyway, if this patch is not necessary, please ignore it.

Thanks,
Tiezhu


