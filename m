Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369CE37FF79
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611634; cv=none; b=YkByyhukjgQ2ZRyYu9vir2C36ZkS1TSE4NGVJ/W3NcCglkfRm0jBbjrCx+Kq0m41JR1dxbyXVXEJD4PL2KuVd4eFPxgJOKnWOnhgQD6PGjBj9LInT4fA38GtSe2g0Fb7JCpuLsVGc6DKNX2/evMMdYnP3Dk5bYXKe0Bjl2H3dcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611634; c=relaxed/simple;
	bh=Zf1yhcieIXEXMulBajrZMfUiePBDXxg6KJNRK9lGeHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2Gq4zMskoLoR5ayua5q/kmIb92kLqGBlx5Nb+9b7qwT9MZ2bGf+m3OUKBayEDMRJOc9D4FIp4bDb5Q8+lW55mBZ77HUbca5+vGxK44JPfirvarVniyYFUhEe5x10GzIHBGwdKXP/fV6VJY9ows39mJVG/gDg7Ku2ywlq9QFcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [122.224.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnOOAI6KdpWZMEAQ--.15328S3;
	Wed, 04 Mar 2026 16:06:33 +0800 (CST)
Received: from [0.0.0.0] (unknown [122.224.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBXrNcF6KdpfLV2Bg--.202S3;
	Wed, 04 Mar 2026 16:06:29 +0800 (CST)
Message-ID: <44c58906-e537-400f-b360-01a915e05275@zju.edu.cn>
Date: Wed, 4 Mar 2026 16:06:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Reset register ID for BPF_END value tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 glapt.pro@outlook.com
References: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
 <20260303093956.395076-2-tangyazhou@zju.edu.cn>
 <a4c1da47af29c3930a025217f25d169da48ed2a1.camel@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <a4c1da47af29c3930a025217f25d169da48ed2a1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgBXrNcF6KdpfLV2Bg--.202S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQACmmnOYkbZwAAsK
X-CM-DELIVERINFO: =?B?hGTpWQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9H+6e/0XdEnku/cOG5HghNi58xKsYpGoUd9Rvrf54waB6dKt08ePEsCBjYGcbzhyWgqU
	gO3h4fP+W/NQJnRsZaUtHJ2CBxes0Cj2YkVXpbcsRZ9UoT8PGGNHLwwloQjsJw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw45Zr4DWr48GryrKw47ZFc_yoW3KrX_Gr
	4rZ348Gw1qvF1avF13AF47ZryUKw4kKF4rAw47XFWDZFWUX398C34Fya4Fvas8G3y2krZF
	yrn09r9IyFn5uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PU
	UUUU=

Hi Eduard,

Thanks for the review and the Ack!

On 3/4/26 02:25, Eduard Zingerman wrote:
> On Tue, 2026-03-03 at 17:39 +0800, Yazhou Tang wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 401d6c4960ec..366ba4757135 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16121,6 +16121,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   			scalar_min_max_arsh(dst_reg, &src_reg);
>>   		break;
>>   	case BPF_END:
>> +		/* manually reset register's id here to avoid mistaken register links */
>> +		dst_reg->id = 0;
>>   		scalar_byte_swap(dst_reg, insn);
> 
> Nit: I'd push this inside scalar_byte_swap() and maybe do it conditionally.

Makes sense. I will move it inside scalar_byte_swap() and handle it 
conditionally in v2.

Best,

Yazhou

