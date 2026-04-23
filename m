Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2F3191CA
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953957; cv=none; b=dItN/15fV9ms75CwXi5CUvEPXaPm74iWBL+vWs6ZEl7Lh29T2AxBgK3U1yCwEV94m9sIde2ZT57nJ15j0nLBEpZNmFk/j+9NHZMozeAFeKokvaH4TakGjsTB9gcPfd8iYiVjwKIDAOgTOP10IXmS7vDth8+wbeKhq6A7NhFJL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953957; c=relaxed/simple;
	bh=bo6YIgJvkDmK0vm9cqIM6C+pIOwOU31qxOPak5oOv1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ9wV3J+tdwYQbHJmP22RKj4gk9mEXAMgtyo70G7fRgcJld94t4vv+vAxULUbwDfgpJU+c6OpsmDPme4BhkGlbuZoiBFmBjl9b3yeo+08THFuonSXyMSR8RS8V4d0eLg1uNc4HLgI0GgMA+3QJLLSgsTGX6oeoaFWQY07OGZDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.196.137.6])
	by mtasvr (Coremail) with SMTP id _____wC3gUU1KuppYoavAA--.2261S3;
	Thu, 23 Apr 2026 22:18:31 +0800 (CST)
Received: from [10.196.137.6] (unknown [10.196.137.6])
	by mail-app4 (Coremail) with SMTP id zi_KCgAHOjE0KuppfTCAAA--.49223S3;
	Thu, 23 Apr 2026 22:18:28 +0800 (CST)
Message-ID: <3bf128ea-dd8a-48e1-8bcd-57a90422e257@zju.edu.cn>
Date: Thu, 23 Apr 2026 22:18:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
To: shenghao yuan <shenghaoyuan0928@163.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com, Tianci Cao <ziye@zju.edu.cn>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
 <f44bd13fc40718dfba7a4074a74fa94c4705672e.camel@gmail.com>
 <66f97339-5ad1-480d-a039-e719deca2611@163.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <66f97339-5ad1-480d-a039-e719deca2611@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zi_KCgAHOjE0KuppfTCAAA--.49223S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhAKCmnpJI4jEwACsO
X-CM-DELIVERINFO: =?B?/JJnewXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9K9dIo9myPKzHE+OjuovHYE2iDcwTeLAF0cM1yd/b85XNVbQKtxRt5iSWod5nW8ZEMbO
	n9pfPmZk6RGgu8aw6HgwmK0f46tYHg+8VMNTLrmiB2KxG2R7C8FfYbzDuD15pw==
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4UurW8ZF4DXrWfAFykXrc_yoW8uF1DpF
	48K3WUta1kJryUAa4vvan7ZF40vrWrJrZFyrs5Z340yws0q3s3Xr1SyFWFvFy7G3yfAry2
	vryaq34xZwnFvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zu
	WJUUUUU==



On 4/23/26 19:45, shenghao yuan wrote:
> Hello Eduard,
> 
> On 2026/4/23 3:05, Eduard Zingerman wrote:
>> On Wed, 2026-04-22 at 22:50 +0800, Yazhou Tang wrote:
[...]
>>>
>>> We noticed the discussion regarding the complexity of div/mod on cnum.
>>> We have previously implemented [1] the full suite of abstract operations
>>> for wint in Rust (including add/sub/mul/div/mod and bitwise ops).
>>> This was built for potential integration into Solana BPF and is
>>> heavily inspired by a recent paper [2].
>>>
>>> [1] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust
>>> [2] https://dl.acm.org/doi/pdf/10.1145/3728905
>>>
>>> The algorithms for div and mod are indeed complex but entirely viable.
>>> We are very interested in collaborating to port these extended ALU
>>> operations into the kernel C implementation.
>>
>> Could you please elaborate which algorithms you have in mind.
>> It appears that [2] is about sign-aware tnums not wrapped intervals.
>> The Rust code for [sdiv] looks similar to the algorithm described in
>> the TOPLAS'15 [1].
>>
>> [sdiv] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust/ 
>> blob/master/src/wrapped_interval.rs#L985
>>
>>
> 
> I think Yazhou meant that we could translate the Rust implementation 
> (reproducing
> the TOPLAS'15 algorithm) to C for the cnum domain. But we could try to 
> implement
> a simplified vesion of [sdiv] in the TOPLAS'15 paper to better suit the
> real-world production scenarios.
> 

Yes. That is exactly what I meant. Regarding the other ALU ops like div/mod
and some bitwise operations, I noticed they weren't included in this 
cnum RFC.
We would be happy to implement them (perhaps exploring more optimized
approaches) if the community finds them valuable.

To Eduard: Sorry for the confusion regarding the citations. Our 
implementation
is indeed based on the TOPLAS'15 paper. The paper I mentioned in [2] 
actually
relates to our ongoing work on the combined soundness of tnum and wrapped
intervals. Let's set that aside for now to stay focused on the core cnum 
logic.

[...]

