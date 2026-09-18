Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3A1AA1D5
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723597; cv=none; b=r8Rtb+vVidnrFJ+Q6m4Y7I3eKulJJVTMdYckp797ozxGG061qrSxcKWg4isvUV8aRM5sI4x0cbTBQ7jk7Yv9o5bNgBpmvZAWJa/JFmnYEwX9glbEpYUrQnltvjqCCplG249JdhGYsMW11YLApVjTveK8C5INw9NRzsR2GVJJ7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723597; c=relaxed/simple;
	bh=NYQizzJl165HDc67fY5hjFoOL9FO8vxSoDA9qDGQ7Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXsBKYqz7fuk9kRKp5RtQcwkdauem9MeJr9ndMHR7a8jy9AP8XCSenVSCcRyXStNhz3IreA4psTR34zqkgoewjXZ5sVGMQ0EAXB2ikds2rhqAQvaEUL2ShUcerxaR2SYoNjqpFOrqjx225ZzRcOo/cqb0d/zT4ss9WLXqnH+deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.183.162.106])
	by mtasvr (Coremail) with SMTP id _____wBnfnywA61qmJQhAQ--.13990S3;
	Fri, 18 Sep 2026 17:26:09 +0800 (CST)
Received: from [10.183.162.106] (unknown [10.183.162.106])
	by mail-app3 (Coremail) with SMTP id zS_KCgBHMnewA61qdeY9BQ--.35454S3;
	Fri, 18 Sep 2026 17:26:08 +0800 (CST)
Message-ID: <4b6ddff3-a4f5-4360-88e9-78ec174dc82c@zju.edu.cn>
Date: Fri, 18 Sep 2026 17:26:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/8] bpf: Add UHMUL and SHMUL instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 eddyz87@gmail.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
 <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
 <DLHR6BTEODXE.2J7T8ZSDTAVNF@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DLHR6BTEODXE.2J7T8ZSDTAVNF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgBHMnewA61qdeY9BQ--.35454S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhMSCmqsQporrgAAsS
X-CM-DELIVERINFO: =?B?DtzGwAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9H/lUEOj5amTx6WMIgWPJ8u5FF/w0/cXFiebfTkOZoViz8493yPxhi/1Q3WZS4lexrMi
	69qXaJ5uUlkLRTzjrftDXTvWfct72IvMEq/SY/1krVxmj/ok/H+dT2M4lazyPQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7tF45WFWftF4DGw1xZw4xuFX_yoW8Gr1Dpr
	n5JFWxGFWDKFWUu3s7t397AF15tw42kF1UCas5Gw1qva4aq34kWrykXryfKFWftrs5ta4F
	q3sFvryF93yqqrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zu
	WJUUUUU==



On 9/18/26 01:04, Alexei Starovoitov wrote:
> On Thu, Sep 17, 2026 at 12:17 PM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 732b35cc08d1..845eee536198 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -34,6 +34,16 @@
>>   #define BPF_FROM_LE	BPF_TO_LE
>>   #define BPF_FROM_BE	BPF_TO_BE
>>
>> +/*
>> + * BPF_MUL variants selected by the off field.
>> + * UHMUL and SHMUL are only valid for BPF_ALU64.
>> + */
>> +enum bpf_mul_variant {
>> +	BPF_MUL_VARIANT_LO    = 0,
>> +	BPF_MUL_VARIANT_UHMUL = 1,
>> +	BPF_MUL_VARIANT_SHMUL = 2,
>> +};
> 
> Slept on it and imo it's too verbose for uapi.
> Maybe just BPF_UHMUL = 1, BPF_SHMUL = 2 ?
> No need to name zero, sdiv doesn't.
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 4e208cc94752..4f746973481b 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> 
> [...]
> 
>> +	ALU_MUL_X:
>> +		if (OFF != BPF_MUL_VARIANT_LO)
>> +			goto default_label;
>> +		DST = (u32) DST * (u32)
>   SRC;
>> +		CONT;
> 
> The verifier already rejected these. Interpreter doesn't
> need to re-validate.
> 
> pw-bot: cr

Thanks, agreed on all three points. I'll simplify the UAPI
definitions, fix the SRC typo, and drop the redundant
interpreter check in the next revision.

