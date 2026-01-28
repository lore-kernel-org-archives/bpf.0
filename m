Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDD2DF138
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614844; cv=none; b=fAy31GjGjKWhMdEPIYi9W5zecqgHBlQb/q9J9Q9Nl9XjlM3awdatG/rVL4gRojJj2vMn9D6lzVaD2v/NrCKB798TQAeCX664uItHKWIP+5PsCcLuDoNehQZWVqbMGNELqC1mHBoP2OFiB8UBA9df3rqguXcGDjJL1wWfJ5Ky1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614844; c=relaxed/simple;
	bh=Lju/VwNeuA9xp6N8Mhps4bZ2ZQFAbfvsMoO/Ntp4miM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXxaoYJK2G69U0elNvHVvnCAPcmDiYVv3imadqdS7kMo5eWXJ1SfFHbhzRw1MxnQwAcqju8/ji3cqsz4yCIa2M2xrSMslUI45el66qITFc+epotjvjqqoU9E76oVHpo9FEJOfaS8RdnEBptEXVFlV7BEO/gADT07Ok9T+S3feGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cLTbqYFH; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cLTbqYFH"
Message-ID: <4295e99d-8638-4cff-90e2-e1f5c2452b52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769614838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvHp944RWMNX+8EeKBPahp8VEBI2KMU61Tq8S7dUKfk=;
	b=cLTbqYFHNWr961NzRQkS2qZQ9ohdj1jjpAhTS7j0cMoFziLInVkfwJmBovx9p2C4bZ9BEV
	pTfwcm6C4EV3mxEhL4WCPuRj3d1pWYxfyIX1cxbTemfS4zqjYbdm0fIWQ+xF7QOZt5+cQd
	FIzrAdNaMqhcx1gt1UZAv2lpc727g08=
Date: Wed, 28 Jan 2026 23:40:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Chris Mason <clm@meta.com>, bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, menglong8.dong@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, ihor.solodrai@linux.dev
References: <20260128150112.8873-2-leon.hwang@linux.dev>
 <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
 <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/28 23:35, Chris Mason wrote:
> 
> 
> On 1/28/26 10:26 AM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index 5a075e06cf..070ba80e39 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>>>  {
>>>  	return true;
>>>  }
>>> +
>>> +bool bpf_jit_supports_fsession(void)
>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This is the actual function name in the code.
> 
> Ihor, I think the script parsing review-inline.txt chopped off the
> part of the review where AI was complaining about the commit message?
> 
> commit f636685cc0b05bb758bb58729cc65dde79ac7108
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpf: Add bpf_arch_supports_fsession()
> 
> This commit adds architecture-specific gating for fsession programs,
> returning -EOPNOTSUPP when the architecture does not implement fsession
> support, instead of failing at runtime with -EFAULT.
> 
>>     bpf: Add bpf_arch_supports_fsession()
> 
> The commit subject references bpf_arch_supports_fsession(), but the
> actual function implemented is named bpf_jit_supports_fsession().
> 
>>     Introduce bpf_arch_supports_fsession() to explicitly gate fsession usage
>>     based on architecture support.
> 
> Similarly, the commit body describes bpf_arch_supports_fsession(), while
> the code uses bpf_jit_supports_fsession().
> 
> Should the commit message be updated to match the actual function name?
> The function follows the existing bpf_jit_supports_*() naming convention
> used by similar functions in the codebase.
> 

Correct, in commit message, the function should be
bpf_jit_supports_fsession(), too.

Thanks,
Leon


