Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9C38DC56
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724271; cv=none; b=YTNoOdISDcc7BCeGEBMD+DoTM8lyqsoM75hJiSS5O4m6asBrRdzfCHaB0I+vaiQSbQeV7RWRaMvDNokQgMEQLwdSRpE38nUAjvRiQi0wrj/iqpc4RxP+fBXFwjhy6NjdI0nMQXXJTplfUkHjD8P/v3xl3ByDbj/kjNVTwqmmWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724271; c=relaxed/simple;
	bh=WydNLni8HoKtKLfphcI8NZ1uZMwj4Wx+5ZDx3C8BA0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ0Z0Sbi/jwr3HK6TFkFEJtJqOkcqffYMm7NQE3+KgKIDxlf+P9TfyBBYn1zlRu69IxOjz5s5kO0Xv6wvNnB3amlueMdGa2iCNZ0c7h/OTnTDCZiaYhy8TM95i+JlxuGF9vuesdqpF/lcTiLkzi4+D6m5avgzldi4ERmKtyhKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.183.162.106])
	by mtasvr (Coremail) with SMTP id _____wDnoj1PBq1qa5whAQ--.13728S3;
	Fri, 18 Sep 2026 17:37:20 +0800 (CST)
Received: from [10.183.162.106] (unknown [10.183.162.106])
	by mail-app1 (Coremail) with SMTP id yy_KCgCHRJxPBq1qYeaOBA--.7169S3;
	Fri, 18 Sep 2026 17:37:19 +0800 (CST)
Message-ID: <811e59e4-df78-4cce-a504-6c089b68e29c@zju.edu.cn>
Date: Fri, 18 Sep 2026 17:37:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/8] bpf: Add UHMUL and SHMUL instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 eddyz87@gmail.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
 <DLHSD07GRG0W.16CFRV44ZE1DD@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DLHSD07GRG0W.16CFRV44ZE1DD@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgCHRJxPBq1qYeaOBA--.7169S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQSCmqsQposUgAAs6
X-CM-DELIVERINFO: =?B?LdSUZAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ne4ztDGUKJpDiizdoftpEvq4yyAXyQRPEAOHM6yl9jOlsmYk6Af2oobIgdNboutwo41
	W0pfb0Rc1EKSUPbUAjcE6yoL907Svs67svpDWc8bSL5KKFMoY371lOym77Dj1Q==
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw47Xr4UCr1kWr4DGr47WrX_yoW8CF4fpr
	45CF9akw4vgry8Zry0qa1xWF1Yvr48Way3CF1DWrWft3ZIqryxZr4Sg34ruFy3Zr40gay0
	qFWY9rnYk3s5ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPE
	f5UUUUU==



On 9/18/26 02:00, Alexei Starovoitov wrote:
> On Thu, Sep 17, 2026 at 12:17 PM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>> Patch 8/8 uses raw bytecode for UHMUL and SHMUL because LLVM support has
>> not been merged yet. Once it is available, the raw encodings can be
>> replaced with the uh*= and sh*= mnemonics. A draft LLVM implementation
>> is available at:
>>
>>    https://github.com/ADSWT518/llvm-project/tree/bpf-hmul-insn
>>
>> We plan to finalize and submit it as an LLVM pull request after the
>> kernel-side ISA changes are merged.
> 
> Pls send the LLVM PR now. It needs to be reviewed together
> with kernel side.
> 
> I think it enables ISD::MULHU/MULHS legal under -mcpu=v4.
> Does it mean that existing programs might generate new instructions
> and stop loading on current kernels?
> If so, we'd have to introduce -mcpu=v5 for that
> and extra flag like we did for other insns.

Thanks for pointing this out. Enabling HMUL under -mcpu=v4
would change code generation for existing programs and
could make them fail to load on older kernels.

I'll move HMUL to -mcpu=v5, keep a separate disable flag,
and send the LLVM PR for joint review with the kernel series.

> 
>>   arch/arm64/include/asm/insn.h                 |   4 +
>>   arch/arm64/lib/insn.c                         |   6 +
>>   arch/arm64/net/bpf_jit.h
>           |   6 +
>>   arch/arm64/net/bpf_jit_comp.c                 |  15 +-
>>   arch/loongarch/net/bpf_jit.c                  |   3 +
>>   arch/mips/net/bpf_jit_comp32.c                |   3 +
>>   arch/mips/net/bpf_jit_comp64.c                |   3 +
>>   arch/parisc/net/bpf_jit_comp32.c              |   3 +
>>   arch/parisc/net/bpf_jit_comp64.c              |   3 +
>>   arch/powerpc/net/bpf_jit_comp32.c             |   3 +
>>   arch/powerpc/net/bpf_jit_comp64.c             |   3 +
>>   arch/riscv/net/bpf_jit.h                      |   5 +
>>   arch/riscv/net/bpf_jit_comp32.c               |   3 +
>>   arch/riscv/net/bpf_jit_comp64.c               |  18 +-
> 
> Pls cc arm64, riscv or other arch JIT maintainers on respin.
> We need acks from them.

Ok, I'll cc them on respin.

