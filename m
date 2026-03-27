Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4B3CF664
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605370; cv=none; b=aitm4+Kw2HbO5xfg7/Nh/u1ycbr5JPKfV0uM+asnUjZoc0J3dOsO+2IhAePdSOBN0Tsg1lj05YEQg322CSGUXwCKw8Hy7Pf9ZY/0L8IZtwDq8ThR4ECbgMsgCvN0OTUyHI8jS6l+i3JmUqfjB+qvNUGJhFNwIw7faBtzwx7BNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605370; c=relaxed/simple;
	bh=Y8GmEgJhD6C3BDed9UAm7a4CzeRkvRkxMVaPGjQl+b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlLXRi1PbYnxhiOaeWW9Tf4FgVbnnsfCQwZ5Mt8XDyqHq/Es8yqE/Y0d3djusXBhIexJR6nvX8kRYcaWbDCcBVAfK43MudffyvE1PWME4q4IQ+KH1/dKRzJrLjnsbtlDdwwYrQ9PMJpRTyLMnkJMjvcaYeKK4Ju7EFaj1boTE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [122.224.66.110])
	by mtasvr (Coremail) with SMTP id _____wDnOKwPVMZpwEERAA--.287S3;
	Fri, 27 Mar 2026 17:55:28 +0800 (CST)
Received: from [0.0.0.0] (unknown [122.224.66.110])
	by mail-app2 (Coremail) with SMTP id zC_KCgBXyc4JVMZpKfQzAA--.13964S3;
	Fri, 27 Mar 2026 17:55:22 +0800 (CST)
Message-ID: <422fce2b-228d-40d0-8fbf-f295f2aac0db@zju.edu.cn>
Date: Fri, 27 Mar 2026 17:55:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Puranjay Mohan <puranjay12@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn>
 <e6b07a39-c2d6-4adc-bc6e-0d31472f9550@huaweicloud.com>
 <CANk7y0iUYYHTQLoS7uTj5+puP_p5QjqyTVkconV84VWYCwirQA@mail.gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CANk7y0iUYYHTQLoS7uTj5+puP_p5QjqyTVkconV84VWYCwirQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBXyc4JVMZpKfQzAA--.13964S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgADCmnFjAspIwABsr
X-CM-DELIVERINFO: =?B?yYkErwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9OBCyAu4//tBYspsrrrqb59rb97hZX+wIuR2tZTTtjhiQM0ByKZ1xFOlj/DwgwDqtzFQ
	SnxELX89NY88tlO/B5hrzu593QOkHqyJbwdm/D24M+/I6yXKWnHutBPDrMWITw==
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrW3tFW5XryUXFy7CryUurX_yoWfuFg_KF
	ZY9r9rXrnxWF13C3Z7KF4YyrWkua1Fq3WrGryjqw1UXryjyFykC3s5CrsYg3W7JFW7Jw1k
	uFn5Za4SkryrZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU

Hi Puranjay and Kuohai,

On 3/26/26 22:00, Puranjay Mohan wrote:
> On Thu, Mar 26, 2026 at 1:55 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>> On 3/26/2026 5:01 PM, Yazhou Tang wrote:
>>> +             /*
>>> +              * Note: If the original insn->imm is out of s16 bounds,
>>> +              * insn->off here will be a truncated value.
>>> +              */
>>>                insn->off = env->insn_aux_data[i].call_imm;
>>
>> seems we can just set insn->off to 0, right?
> 
> If the insn->off is valid (not truncated) then it is useful when
> dumping assembly using bpftool. But maybe we can set it to 0 rather
> than some random truncated value when it is out of bounds.

Thanks for the suggestions.

I agree with Puranjay's point. We should set insn->off to 0 only when 
call_imm is out of s16 bounds. This avoids exposing a confusing 
truncated value for large jumps,
while still assigning the correct offset for bpftool to use in normal cases.

I will include this change in v6.

Best,
Yazhou

