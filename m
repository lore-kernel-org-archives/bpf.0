Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741831197B;
	Thu, 12 Mar 2026 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313616; cv=none; b=h6l+pLOmS1eud3L1W6bNotAl/lLWQCDNYA70TXpE2uSocP9t3ZcpzMlFqGjOqwR2UZQpli+1+pm9r0HLTEM++FhmBW24e6C/pNkjinS24o6nGxZnKDq1FMUtdgZDfEVicEPjTu8zLS92m4hDuec0aa32DckvjfUvkHJ2X3/o4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313616; c=relaxed/simple;
	bh=Ezfzk+y4Aajp92+VbSBmBGx8P8IjMipnXiYNleFbsIA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lT95XqQqYREUJ/o9pYefH3MLTRCUvsNhqnHH2eXbMBv9KeOP6iNKK5gpQSFrw1qSOPYKCle+UdfPljm/1+7g1imrS746vT0h7ES3v+kZQJVad1g2XvRaRRWlvJ8nEby+/D8o8ZWLA+BHNvh10/l2cQAlOJxd6CCxUwDH/NBhd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxQcBDnrJp8EwaAA--.17799S3;
	Thu, 12 Mar 2026 19:06:43 +0800 (CST)
Received: from [10.130.40.84] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcI+nrJpQdZTAA--.26265S3;
	Thu, 12 Mar 2026 19:06:39 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
To: Paul Chaignon <paul.chaignon@gmail.com>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
 <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
 <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>
 <abKHi9Pr5iUbIQZI@mail.gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>,
 loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7ea56716-fd5f-1740-e634-1dec4196dd2c@loongson.cn>
Date: Thu, 12 Mar 2026 19:06:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <abKHi9Pr5iUbIQZI@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxjcI+nrJpQdZTAA--.26265S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF43Jw4fAF4xXw4xtry3KFX_yoWDAwc_W3
	s5Cwn5uw1DAF45t3ZrtF1Fyr4YqrZIqF18Z3y7XrnFkFyrtF1DXrs3uryYqayrGa4avr4k
	CFnava1YvryUuosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=

On 03/12/2026 05:29 PM, Paul Chaignon wrote:
> On Thu, Mar 12, 2026 at 02:59:57PM +0800, Tiezhu Yang wrote:

...

>> For example, for the test_verifier 14,
>> verifier/atomic_cmpxchg.c:215
>> "Dest pointer in r0 - succeed, check 5",
>> if remove ".flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,",
>
> I think I'm missing something. Why would you remove this flag?
>
> Are you trying to illustrate that this is a program that could be
> rejected because of misaligned accesses?

Yes.

> I agree, but here the flag is
> set and this program is therefore rejected because of an invalid memory
> access; the misalgined access check is skipped in the verifier.

...

>> -#14/p Dest pointer in r0 - succeed, check 5 OK
>> +#14/p Dest pointer in r0 - succeed, check 5 OK (NOTE: not executed due to
>> unknown alignment)
>
> As stated in my previous answer, this note would be incorrect: the
> program was executed in test case #14 because it was rejected, not
> because of unknown alignment.

OK, please ignore this patch.

Thanks,
Tiezhu

