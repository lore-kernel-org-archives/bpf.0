Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F43E51CC
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905166; cv=none; b=XBLodDF0y+Bch3pqVUO6u92VsWR59M4ahGmV58cdQbszb4mrvF1gncO8/utw4m0JBBkw2OD8SXExDDZ645Kd/Yqew4C0NdvLPFJOQjNQ6fIXKmAqiuESkbxn6wPDRhYsJmb4+N9TzH43d202k78d0vxWmZzPeF4EJ1D5bVpfCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905166; c=relaxed/simple;
	bh=sAAOf9l2yen40I/84kDEWjMAPALrtQfcjP/trd6bySA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i0CotLrJsX4GIUZisje0WIbtbn+QrFG6y/kQPO46pDqWWflQ621PPPd7AJiTGeJH/j79R7YWqPhh9dOT+HpgQILBAcEy2nm0d37StbJtjaAD378KAxu6cSqny7VfD4ebzrE1r/+aAtvdQmoKd5aW8I3yzxxncAXCEpHxkYH/Glk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTNKJRJFqNwkGAA--.16935S3;
	Fri, 28 Aug 2026 16:19:21 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5cyGRJFqEEQVAA--.15044S2;
	Fri, 28 Aug 2026 16:19:19 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 07/14] bpf, loongarch: Fix stack arguments for
 indirect trampolines
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 kkd@meta.com, kernel-team@meta.com, loongarch@lists.linux.dev,
 Hengqi Chen <hengqi.chen@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-8-memxor@gmail.com>
 <a5d4c26c-6735-8af1-1d3f-fe7f1898b285@loongson.cn>
 <DL0B54EEQXAL.FL6Z0UXMR3SX@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2bc45d20-d08f-e5c1-9da3-699d22959f98@loongson.cn>
Date: Fri, 28 Aug 2026 16:19:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DL0B54EEQXAL.FL6Z0UXMR3SX@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5cyGRJFqEEQVAA--.15044S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW7XFWfGFWkCr1rKF15GFX_yoW8JF4kpF
	40va1YkF48JF4UZaykG34vqF10qry3CrZYganxtryFkrn8Xw1akr4IgF4qgF95Wa1FkF1F
	vw10yayrJFy5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
	UUU

On 2026/8/28 下午12:55, Kumar Kartikeya Dwivedi wrote:
> On Fri Aug 28, 2026 at 6:33 AM CEST, Tiezhu Yang wrote:

...

>> With this patch:
>>
>>     $ sudo ./test_progs -t struct_ops_trampoline
>>     #471     struct_ops_trampoline:OK
>>     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Thanks a lot for the test. Please also take a look at the argument rebase
> patches once you folks have more cycles. Will definitely need your help and
> reviews since they are mostly vibe coded.

Hi Kumar,

I have sent a standalone prerequisite fix for the pre-existing
issue:

LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
https://lore.kernel.org/loongarch/20260828075100.24776-1-yangtiezhu@loongson.cn/

IMO, when you respin, please rebase your patches 07, 08, and 09
on top of this fix for your v2 series.

Additionally, please send the v2 as a standalone series to the
loongarch mailing list loongarch@lists.linux.dev and the reviewer
Hengqi Chen <hengqi.chen@gmail.com> too, as the LoongArch BPF JIT
patches are typically routed through the loongarch-next tree.

https://lore.kernel.org/loongarch/CAAhV-H55YcyXRewC+0YzTHXb1jab0GkAV13EF9nFbTx=UkX4ww@mail.gmail.com/

Thanks,
Tiezhu

