Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2B282F03
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388606; cv=none; b=X0FpO7v7n1hpsgxoc5qKR0bQJH8gA4jmlsDdxFD7awtbW3mEV7hPhjIrVyA95A/Bcp9Jqp65kKPAU7vSxfyWhXetWeH4MgGdNsGGZcPtvNXU/+sy+qNSRPwPPjGg3t/yLRstIFDU8q+kC+Nia/Fa7ZKT5ZRnHoRX01/SmJb1sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388606; c=relaxed/simple;
	bh=1KLDLn1/AV9Q0MmGNPPoIwUxq9gsKK4UK/Fj5QI7r8I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NDGl+9KQLPr6w3dX64GOPkQMqcF/Vl/wiRkJcSBqzm06YVrC6WyeSkc/rC6ms6GnNiBXkiO81o7SeU5wecevGwcJNSbbIoWMmQSDSQGC2hx/5Rc8584ny4UojBa+FIcIJkyR7H+dSjdidiZIHTN3jXonrdPsUIDiPs2/XGnBTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxaeu6WUxqpb4AAA--.3311S3;
	Tue, 07 Jul 2026 09:43:22 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxvMa2WUxqE1QDAA--.19908S3;
	Tue, 07 Jul 2026 09:43:19 +0800 (CST)
Subject: Re: [PATCH bpf-next v8 1/2] bpf: Introduce jit_required flag and
 remove bpf_prog_has_kfunc_call()
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
 <20260706040006.10331-2-yangtiezhu@loongson.cn>
 <dd75b7afbe2b5507ac818df14dd44aff32db1e18.camel@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <00c9880d-000b-d9a6-d981-b3033126cc16@loongson.cn>
Date: Tue, 7 Jul 2026 09:43:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dd75b7afbe2b5507ac818df14dd44aff32db1e18.camel@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvMa2WUxqE1QDAA--.19908S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw4xZr1rJF1fKr1fArWkGrX_yoW8Gryfpa
	yrZ34qkF1kKF4IyFnrJrsrAw12grWa9ry2yr1kGryIgr15ua1xXF1Fka4a9ayFgr18Ja12
	vayqva47J3WqkacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUU
	U==

On 2026/7/6 下午7:39, KaFai Wan wrote:
> On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
>> Introduce a 'jit_required' bitfield flag in struct bpf_prog. This bit
>> tracks whether a BPF program strictly requires the JIT compiler to run,
>> preventing dangerous runtime fallback to the interpreter for features
>> not implemented there.
>>
>> Set the flag 'jit_required' to 1 at the entry of bpf_add_kfunc_call()
>> right after the kfunc_tab allocation succeeds. This cleanly marks the
>> lifecycle of any program attempting to utilize kernel functions.
>>
>> Furthermore, completely remove the bpf_prog_has_kfunc_call() helper,
>> as its logic is now unified under the 'jit_required' flag.
>>
>> In bpf_fixup_call_args(), check with 'prog->jit_required' rather than
>> bpf_prog_has_kfunc_call(), and generalize the error message to generic
>> BPF JIT availability.
>>
>> In __bpf_prog_select_runtime(), check with 'fp->jit_required' rather
>> than bpf_prog_has_kfunc_call() to unify the logic.
>>
> 
> If you have a new version, I think we could simplify the description of the code details a bit.

OK, will do it in v9.

> The code is fine by me, others might have comments.

As suggested by Leon and you, I will modify the code to:
"fp->jit_required = IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)"
in v9.

Thanks,
Tiezhu

