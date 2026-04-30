Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C2436358
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560691; cv=none; b=oCQgMWe8tZ6/10UjIRDefqt3kqAUc6+uz8+hXrhZTvH6DARe2EWn8MVbU4B8bTFt4wFaF/kUvNIG/31MjcqriJGQrz43vZNfvr+j3DLYw0Gc2lGDCf3zyFWDcC/MXTO40n0FKt0sEufnax8xBWDCHrhbwZnqhUBzybFvpmWLHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560691; c=relaxed/simple;
	bh=rq/hnhVfRieJ7Dtk5tf1S+0drQEV569QQ4daZVRCVac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qjj9cfhqivuQC6y4I1cCGYCjqrE5bfDQtkKGd++GcLkRlwyVKY+38JSNE0BVEamv7Day1C1k/9o9X+WRCyG4GIVyBC9FtqI3DDSIzv9fGoBP3hdFP0ZhEFuf2rVMl1lzi+bkfkX0sJ/GtDWYOgDD0tQPW20I+a+0dK5eAptdtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.175.228])
	by mtasvr (Coremail) with SMTP id _____wC3gERRbPNphtXrAA--.9566S3;
	Thu, 30 Apr 2026 22:50:58 +0800 (CST)
Received: from [10.162.175.228] (unknown [10.162.175.228])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHnW9QbPNpAsvMAA--.51004S3;
	Thu, 30 Apr 2026 22:50:57 +0800 (CST)
Message-ID: <1b81fef5-2089-44cf-a486-0a7adf0cfdfd@zju.edu.cn>
Date: Thu, 30 Apr 2026 22:50:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/3] bpf: Fix out-of-bounds read in
 bpf_patch_call_args()
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 ast@kernel.org, eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-2-tangyazhou@zju.edu.cn>
 <2f4565e1-eb06-4f63-886b-8c74f10d4c8a@huaweicloud.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <2f4565e1-eb06-4f63-886b-8c74f10d4c8a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHnW9QbPNpAsvMAA--.51004S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhERCmnyXw43jwAAs6
X-CM-DELIVERINFO: =?B?2lXYrQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9K4D5m5xkNbmKU5GmkTqKUKAgCxH+bEkB+aNAJbTFlgp319YHg4ydR3ZTvS/UR2KCgHD
	BBtTB47gKcfqnC1SDqsph65GUnWNmu/P841wSCPuHiR5kuhfDQplXk9jsIO7Jw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr1UGrW8AF47AFy5Gw43XFc_yoWkurX_Gw
	4UZr1kXr1DJFsFyF15JF17ZryUGryjkr18CrW5ZF4DGF1UAFn5Jr98JFn5AryUGr4DJr1D
	Ars5XanxtF18WosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eH
	DUUUU

Hi Kuohai,

Thanks for your review and Acked-by tag.

On 4/30/26 11:29, Xu Kuohai wrote:
> On 4/30/2026 1:19 AM, Yazhou Tang wrote:
[...]>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index fba9e8c00878..300e4e251931 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1416,7 +1416,11 @@ int bpf_fixup_call_args(struct bpf_verifier_env 
>> *env)
>>           depth = get_callee_stack_depth(env, insn, i);
>>           if (depth < 0)
>>               return depth;
>> -        bpf_patch_call_args(insn, depth);
>> +        err = bpf_patch_call_args(insn, depth);
>> +        if (err) {
>> +            verbose(env, "interpreter stack depth %d is too large\n", 
>> depth);
> 
> Nit: the log is misleading, change it to "stack depth %d exceeds 
> interpreter
> stack depth limit"?

Make sense. I'll update it in v10.

> 
>> +            return err;
>> +        }
>>       }
>>       err = 0;
>>   #endif
> 
> Aside from the the log wording, it looks good to me.
> 
> Acked-by: Xu Kuohai <xukuohai@huawei.com>

