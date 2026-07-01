Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D03B19D4;
	Wed,  1 Jul 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890979; cv=none; b=mu+3ZXYkVKhyTjfsh5ccXJwpiVkVXCIUamhwcqWRSt1K0jO/OFwplGjwya5FVLN2i6kOJWMahv+1BJIErpaBAV3wsl5Y8jcgrgdhSVGBp9XvsdXPxZbvu+k4yiAnkjm05zi/17XKrawgpWh84+OPTXVbl4Vr6Bp4TKLG5NIjYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890979; c=relaxed/simple;
	bh=8+RfCRlbq6ZsembJaCyFQ89yuFcyl3EwhjDVzCRsEd8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=klLKfjrTaW/wLERvz6Xpda/Qb4ZTsej0tUXC72WJERrs3beS5lkaARmx9FRu5cNNDNdFqNvWba9h/d9lvQ40zYOSbj/QQORmspnQh8ea7CSSxcrkq+Rqk4C6TT8uqhJrDSfCjx/RMJWmL/v5oDByU+dI3kTqxl9cYSKj0WPI2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxCfHdwURqbGIAAA--.2324S3;
	Wed, 01 Jul 2026 15:29:33 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxTMLYwURqXSK6AA--.22818S3;
	Wed, 01 Jul 2026 15:29:29 +0800 (CST)
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
To: Leon Hwang <leon.hwang@linux.dev>, KaFai Wan <kafai.wan@linux.dev>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <20260626154330.33619-2-leon.hwang@linux.dev>
 <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
 <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
 <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>
 <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>
 <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
 <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7438f087-7fb4-4991-a095-1d24d6d09895@loongson.cn>
Date: Wed, 1 Jul 2026 15:29:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTMLYwURqXSK6AA--.22818S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWUtr47uF1DZw15AF4UKFX_yoW8Gr4xpF
	W8Gay7tr4DAa4xJasFkw4ruF42g3yrJr48Ww18WrZ5urn8Wr1fuFy5Kw43uFy3ury09ryS
	vrsIqw1xuFy0kagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=

On 2026/7/1 下午3:02, Leon Hwang wrote:
> On 1/7/26 14:49, Tiezhu Yang wrote:
> [...]
>>>
>>> It is a real issue.
>>>
>>> Instead of fixing up helper calls, it seems better to prevent
>>> interpreter fallback if the prog has any JIT-inlineable helper call.
>>
>> Hi Alexei and Leon,
>>
>> What about the following: (not tested yet, if it is good, I can test it)
>>
>> [...]
>>
>> If you are OK with the above changes, I will test it again and send
>> a new version later.
>>
> 
> If you don't mind, I think I can disallow the interpreter fallback by
> the below diff in the next revision of this series.
> 
> The 'aux->jit_required' is introduced by following Alexei's suggestion.

I am not sure if introducing a new aux->jit_required member is necessary,
as we already have a local jit_needed flag in the current logic.

Additionally, the issue reported in my patch [1] is fundamentally tied
to bpf_jit_inlines_helper_call(). Maybe we can simply reuse jit_needed
by checking bpf_prog_has_inline_helpers() right before JITing, and then
reject fallback with -ENOTSUPP if JIT compilation fails.

Let us wait for Alexei's comments on the overall direction before
respinning.

[1] bpf: Fix unaligned interpreter panic on JIT fallback path
https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

