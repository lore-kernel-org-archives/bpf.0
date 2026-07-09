Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5463EF665;
	Thu,  9 Jul 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588562; cv=none; b=SqhmjYRqFY1GxmTsFcRc1sTpc7FOyTP29Vxz7Nhi/iCgPk+3Q4PTjcMlj/i5mjjJwMzc1IkrwcHOrZus3QLlpgD5eijvuGAmTsSo6as69nWFoT6FBTZ0i/lSpJpV3MI4RsL9Asvw/GBeKpeku3xN+Td/0UmNVHyAunEpqVM5RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588562; c=relaxed/simple;
	bh=95kto79XIg/fwnZy8w9ySlHeQVhkoETxSGtvTW7SOiU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gKgG9WzYceTZOXSOBzsq6ecb7AUkSl2Q/jTlB2Wb64Icd7B2sBMqDjiVMIUWWvvVypHHFYpFuAhb1gHlAdLsPPFNOch4ZmFPRCCoXw3NCJmJtbTNSAQdHI/bD6prtCYcYNQpm18cq+nH8ZzxzyFHXf0IPsmvEcNSyMnW2Y8wxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSevIZk9qCcsBAA--.7552S3;
	Thu, 09 Jul 2026 17:15:52 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxEuTBZk9qULEGAA--.13628S2;
	Thu, 09 Jul 2026 17:15:46 +0800 (CST)
Subject: Re: [PATCH v3 0/4] Fix and optimize BPF tailcall for LoongArch
To: Daniel Borkmann <daniel@iogearbox.net>,
 Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260707101508.32283-1-yangtiezhu@loongson.cn>
 <5c81752f-5c57-47c4-afad-7cef78729feb@iogearbox.net>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <054a69e5-c497-d8de-6acd-1625333d0ca8@loongson.cn>
Date: Thu, 9 Jul 2026 17:15:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c81752f-5c57-47c4-afad-7cef78729feb@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuTBZk9qULEGAA--.13628S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xw17Jr4rKry3ZF17Kr1rAFc_yoWkJFX_uw
	nFv3s7GrW8ua13AFn7trs5ZrZ3Zw1jyw1DJrWkXrnrCa47A3s5Wrs8Jry0v398W398Krnr
	Jw4DXF47ZF9IkosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=

On 2026/7/9 下午4:58, Daniel Borkmann wrote:
> On 7/7/26 12:15 PM, Tiezhu Yang wrote:
>> Based on 7.2-rc2, tested on a Loongson-3A6000 physical machine.
>>
>> Here are the test results:
>>
>>    $ sudo modprobe test_bpf test_suite=test_tail_calls
>>    $ dmesg -t | tail -1
>>    test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 
>> JIT'ed]
>>
>>    $ sudo ./test_progs -t tailcalls | tail -1
>>    Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED
>>
>> v2 -> v3:
>>    -- Patch 1: Add Fixes tag.
>>    -- Patch 2: Update the commit message and add Fixes tag.
>>    -- Patch 3: Update the commit message and add Fixes tag.
>>    -- Patch 4: Condense the code comments and update the commit message.
>>
>> No code changes.
> 
> Tiezhu/Huacai, do you want us to route these via bpf-next tree?

Hi Daniel,

Yes, routing via bpf-next looks better to me
because it is updated much more frequently,
allowing developers to rebase quickly.

However, Huacai usually takes LoongArch BPF
JIT patches into the loongarch-next tree.
Let's hear his thoughts on this.

Thanks,
Tiezhu

