Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D021638D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339498; cv=none; b=skRTyHPXfNmmwPYtJqYBEqu00B40TmwsgTzyxrkiS7L0Ua/AafzCMebQKiZW+27GSnvk4PEuOUPMXRiq8CelyQZyDxRBwUKiHt79lS8hIsGQoA8r7UZ1vD9FAPuTvz96Wf3HOt1dzlIcTHKiDH/JESvhnOsjf3lVn5IDuzmuEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339498; c=relaxed/simple;
	bh=+n08tj1EOwrvRXhAdjTQyU8ESor+gSj0Ef3eitEyJk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puPO7OhXLoHxlNbqzbnO1HFzzn33f3KRF7itLAdUKQzm7Sp05jeK2sNh64VUvHQF5elejrF2MCBHg6WOzLS2gXNW8TtgxxA/HefhiZoad6tSVmdWWUSyv5fTZOwjyarOI0MM6mjMF0a+GSyWrNZBE3NFRyUAm28gFczXPO1w/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.124.104])
	by gateway (Coremail) with SMTP id _____8CxCHmkVzxqxpMXAA--.36116S3;
	Thu, 25 Jun 2026 06:18:12 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.124.104])
	by front1 (Coremail) with SMTP id qMiowJCxPMKhVzxq_xCyAA--.8437S3;
	Thu, 25 Jun 2026 06:18:10 +0800 (CST)
Message-ID: <8afb0401-9c53-f469-30d7-8e97e63c0189@loongson.cn>
Date: Thu, 25 Jun 2026 06:18:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: Add some tests for
 LoongArch
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org
References: <20260615100506.19558-1-yangtiezhu@loongson.cn>
 <DJ9QMPLAXOGG.2PDC3A2MUENPC@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <DJ9QMPLAXOGG.2PDC3A2MUENPC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCxPMKhVzxq_xCyAA--.8437S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Gw48Xr47CF1rKF4kXF4rCrX_yoW8Jr1kp3
	9a9F97Kr1kWryUAFsIgw1xuF17Xw13ur97G3WkGr1Yyr9I9F1Fqr97uFW5XFnrCryFk3W2
	vr4vg34DKa4UtagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
	U

On 6/15/26 23:45, Alexei Starovoitov wrote:
> On Mon Jun 15, 2026 at 3:05 AM PDT, Tiezhu Yang wrote:
>> This series is based on the latest master branch of bpf-next tree.
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>>
>> Dependency Note:
>> ================
>> This series strictly depends on the following LoongArch core series,
>> which moves thread_info into task_struct:
>>
>> "Move thread_info into task_struct for LoongArch"
>> https://lore.kernel.org/loongarch/20260612011616.27771-1-yangtiezhu@loongson.cn/
> 
> Pls repost when this patch appears in bpf-next.

OK, this is reasonable. I agree with you and plan to do this.

But I noticed that this series has already been merged into
the loongarch-next [1] tree, and there is something wrong
between the code and commit message in the first patch [2].

I think this is not proper. I suggest to drop them from the
loongarch-next tree.

Just FYI.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?h=loongarch-next&id=8796e11abddf

Thanks,
Tiezhu

