Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD87233149;
	Wed,  1 Jul 2026 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869186; cv=none; b=IU7HHqDTtg8HUdg7EXQTdmhUxPj7tcmthgjzoVxf0tCQZ2o0e2RGtzuxHNEH3E3gEWwZPstq170PGN9zeWhgQaiugSQCRjhm62WyIHsOoaAAwd0q8qP+om3PxeTzaRgut0IkUtqN69daVi8vBkq4DTaJILvC287CXTK7DFqHBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869186; c=relaxed/simple;
	bh=vOZvYU0esS1V5wkbMA84p3qKEBj4oZEgoABvRH4fKiM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pyq6HJ88ScE5W1DirjUQ8yY36jp63MjkEj5rUctDw6kq6M6EgTSdJBbSgafyRsz5VrxSIXMy3ywPK7UK9pLUd+gSIUgU8DHwxzgZ75EH7ttyXobpSAHH2kDzQbolpkOJyRYpBdqPVJFoprz0TzPnN1i9hxyLW5XfPLyXLLtLvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax+fC5bERqjUwAAA--.1871S3;
	Wed, 01 Jul 2026 09:26:17 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxHOGybERqHcq5AA--.24623S3;
	Wed, 01 Jul 2026 09:26:11 +0800 (CST)
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
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>
Date: Wed, 1 Jul 2026 09:26:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOGybERqHcq5AA--.24623S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW5tFWkAr18JFyrWFyDurX_yoW8WF4xpF
	4rAFyjkF4UXws7W347Kw1Y93W5t3y5W3y7G393Ga4FkFsIqrn3GF1jgrs09rs0kw4xCF12
	yr4avFW5CFyrKwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

On 2026/6/30 下午10:36, Leon Hwang wrote:
> On 2026/6/30 22:29, KaFai Wan wrote:
>> On Fri, 2026-06-26 at 23:43 +0800, Leon Hwang wrote:
> [...]
>>>   /* Fix up helper call offsets on JIT fallback path. */
>>> -static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
>>> +static int bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
>>>   {
>>>   	struct bpf_insn *insn = fp->insnsi;
>>>   	const struct bpf_func_proto *fn;
>>>   	int i;
>>>   
>>> -	if (!env || !env->ops->get_func_proto)
>>> -		return;
>>> +	if (!env)
>>> +		return 0;
>>>   
>>>   	for (i = 0; i < fp->len; i++, insn++) {
>>> -		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
>>> +		if (env->ops->get_func_proto && bpf_helper_call(insn) &&
>>> +		    bpf_jit_inlines_helper_call(insn->imm)) {
>>>   			fn = env->ops->get_func_proto(insn->imm, env->prog);
>>>   			if (fn && fn->func)
>>>   				insn->imm = fn->func - __bpf_call_base;
>> It might be better to use the BPF_CALL_IMM macro. insn->imm = BPF_CALL_IMM(fn->func);
> 
> 
> Makes sense.
> 
> This might be applied to Tiezhu's patch.

Hi all,

Alexei said in another thread like this:

```
 > [3] 
https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/

I don't think we need such fallback in patch [3].
```
https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/

Should I just drop my previous patch? To be honest, I'm not sure how to 
solve the issue mentioned in it. Is that a real problem, and does it 
need to be fixed? What is the next step?

Thanks,
Tiezhu

