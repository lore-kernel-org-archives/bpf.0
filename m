Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DC246783
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679399; cv=none; b=OHvTjiZhux0GMvmsrnuhDD+IAdVF+49j2Ex3j8raWLeSAtScnJObJFJvKwhm8vFKMc7DDpgFuNenqOMv84a7Gb3Nygse6kP2MsEC5oJ1jEKJymhfeLrhXBzhUSpRVb1j9Wg13+QOiTZn16zpmPt+uCVT67Fs2ROFg1Bhc1nAAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679399; c=relaxed/simple;
	bh=HC/vTj3+g+0iG2meZvzGQW4JyiwWbYj/n/SKBqKxltM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeD5XhMyYQoSigGrthmPLSK00hmL/au9/UyqxPbN4/mpgWBq2XWYV1T8alvqFrMC4XFi9fnR0d1fYKKAmI7DQJlmaOTqNjUNgtMwayE8vH1w5AM1ElTwHnA5oF4xgx3el5hBCML/yWzw+wTFUT6jx1eILQ5yUj/9om616A/Ku1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLpBq0xBvzYQtqn
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:49:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EA7D94056E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:49:46 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC38UBZkH5qrLT5CA--.39581S2;
	Fri, 14 Aug 2026 11:49:46 +0800 (CST)
Message-ID: <25fb9309-a1b4-4939-a03f-3d483f30de0d@huaweicloud.com>
Date: Fri, 14 Aug 2026 11:49:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/7] bpf, arm64: Convert struct_ops arena
 arguments in the trampoline
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-5-puranjay@kernel.org>
 <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
 <m2mrupzv2q.fsf@kernel.org>
 <a6dde22e-47d1-4f5d-9ab9-284e9beefd56@huaweicloud.com>
 <DKOCI4Z5JJC5.24Z0Q14YKRX60@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DKOCI4Z5JJC5.24Z0Q14YKRX60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC38UBZkH5qrLT5CA--.39581S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkWF48Xw17AF45CFy7Awb_yoW8GrWrpF
	Z5GayrArZ7tr17CF4qqw4UKws3t3sxJF47Xr15J34SyFn0qF1IkF4SkF4Uurn2kr4rXw4j
	gryjkrsrC3sYy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/14/2026 11:27 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri Aug 14, 2026 at 4:10 AM CEST, Xu Kuohai wrote:
>> On 8/14/2026 3:20 AM, Puranjay Mohan wrote:
>>
>> [...]
>>
>>>>> +static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullable, u8 base_lo)
>>>>> +{
>>>>> +	if (nullable) {
>>>>> +		if (dst != src)
>>>>> +			emit(A64_MOV(1, dst, src), ctx);
>>>>> +		/* skip the subtraction so that NULL stays NULL */
>>>>> +		emit(A64_CBZ(1, dst, 2), ctx);
>>>>> +		src = dst;
>>>>> +	}
>>>>> +	emit(A64_SUB(0, dst, src, base_lo), ctx);
>>>> Maybe I'm missing something, do we need to validate whether the
>>>> address in the src register is really inside the current bpf
>>>> prog's arena?
>>> The JIT can assume that it is a kernel address into the arena as it
>>> comes from struct ops.
>>
>> Thanks for the clarification, but I'm still confused. What makes the
>> assumption hold? How does struct_ops ensure the address passed is
>> inside the arena used by the current prog?
>>
> 
> I think we would expect the kernel caller passing the address to the struct_ops
> callback to have something that points into the arena region. If that
> expectation is broken it should be treated as a kernel bug and be dealt with
> accordingly.
> 
> Does that clarify your concern, or did I miss what confused you here?
>

Fair enough, I'm fine not checking the address in the JIT.

>> [...]

