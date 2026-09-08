Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234B478859
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856377; cv=none; b=uhh5r+1Me1rjpQO98wJnBCgVBE1yFC7MEiaB2zFqqtapV5cyPCTBCtYDKO7H5m6YSJHdWfSlDd2T3prvi+H/7QOquZ2amA4veuAImoszbIllRYs+nk+gYx4syMFuybo5NcqMu/2NbHVNjHxAJE2vHuKPWsJCeWxnlJ2+c7WWj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856377; c=relaxed/simple;
	bh=rHm0HvWZiKqD7qErL8YVw7awc9OrPTvWRJaM82ce0ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3ojYTsuoqEBKlg/TjysFPcOHMBpdvcZAqzgryZoxsKroujpS4/zQWz11rI9SYRh6pr8wIXatKyPws0vtCtNdL8XzjY2ZFT5MIRsr8Em7yUE70YjBwGv+Tqgohdr2Hjh2A08/MUbvDy+fw/dInFTGXXP+wTJQnVPnpGAMY17pYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBXUH8SyJ9q_yb+AA--.24361S3;
	Tue, 08 Sep 2026 16:32:18 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app3 (Coremail) with SMTP id zS_KCgAXUXQRyJ9qFHoDBQ--.4125S3;
	Tue, 08 Sep 2026 16:32:17 +0800 (CST)
Message-ID: <c466dfd7-0f94-4ff7-bc10-83fa30402708@zju.edu.cn>
Date: Tue, 8 Sep 2026 16:32:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 3/6] bpf: Reject UHMUL/SHMUL in unsupported
 JITs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, eddyz87@gmail.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
 <DL9CIMDBZWIQ.2EXQYQI34DDCX@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DL9CIMDBZWIQ.2EXQYQI34DDCX@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgAXUXQRyJ9qFHoDBQ--.4125S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgUICmqfE5onkgAAsM
X-CM-DELIVERINFO: =?B?stViDAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9P2rgh2U/xFW9zvd3L3RnW5Rf1zHf0b0ozxR25lJ4tbEQN4/ZNYbAV3RmMmuuKY3U7ju
	5cLDQ+J5XD9VZZf3n7wl+UF/knAL2XtgbKqcPkbBTBVsP+qJGYeN7JWi6Et5lg==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr1kAF1UuF4rGFWrWr1xWFX_yoW3Wrg_tw
	4YyayIkwnYyF1avF1Yk3WUGr9F9r4DWF1xJF1kWF9rA3sxXry5CrZ5A34xK3yUKrWqkrZ7
	Wr93ta42yw4Y9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWwZcU
	UUUU=



On 9/8/26 3:53 AM, Alexei Starovoitov wrote:
> On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 3aa3ea0bc30b..dc60a931c364 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1325,6 +1325,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>>   	int ret;
>>   	bool sign_extend;
>>   
>> +	if (bpf_insn_is_hmul(insn))
>> +		return -EOPNOTSUPP;
>> +
> 
> Please add arm64 support in this patch set and may be one more like riscv.
> Just x86 is not enough to see whether new insns map cleanly on other archs.
Sounds good. I'll try to add both arm64 and RISC-V support in the respin.

