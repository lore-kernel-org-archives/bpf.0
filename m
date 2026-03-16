Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81015363C4B
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696194; cv=none; b=fvi9bX6VKgQLgWx7BbjTrJdd3nnZMfeMi8EHosdXDZuXD7n+kfCagYPWOKGkNP/vmEN9riy6hy5EIoB/np0cyJvAZxtZPdaaa3P8v9DuXE9du68CPHvXAHlmOUX1Yw2EuKxh6Grgqo5c5c99sjB/RGm4ge62gCdlo2clFUbm3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696194; c=relaxed/simple;
	bh=NdBgUGprYQaUY/YZh5NWpsDLxpAuPx8KwuGB2USKwAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wff4anMoDRIi63QGsMz10G7Tl8pzwkeCVDNVezSvX+m2nSpoimpjr0sY23ayEibKUbotCEAF2SKAb2Lqwv9x5RjhRV3adZRUCXoe3qbkORw4t+SVvnewSCnhWvpKYZMH9AJQWzquHRwoTRmErgNkQ9BEq2fcgj4JSVBsie0eAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A1Hi1qRc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A1Hi1qRc"
Message-ID: <1784ff89-96de-4b75-89c7-94c914326b93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773696180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjLOpRKxLRmCAQXyv57B3hAKgd1rZV03RAVS2ENsv58=;
	b=A1Hi1qRc0MCyNkVzzDKNkggeCRvJl7jGjpYVhtnQOgTW4p1J1/hxOfhzPEb2cWK7grVXJy
	AikGjTiJ6V/9dj7Jl9evnfCljdWECGLVsSafth6vFQBX2vhXfL+qQ1emJZhW2tZpq7c+yZ
	kH2DLqFov1LNS/34+TUNIAv2ASglrng=
Date: Mon, 16 Mar 2026 14:22:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
To: Martin KaFai Lau <martin.lau@linux.dev>, xulang <xulang@uniontech.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, dzm91@hust.edu.cn, eddyz87@gmail.com,
 haoluo@google.com, huyinhao@hust.edu.cn, john.fastabend@gmail.com,
 jolsa@kernel.org, kaiyanm@hust.edu.cn, kernel@uniontech.com,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, paul.chaignon@gmail.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
References: <db2e04a2-3cf4-40f3-85ef-14197148d027@linux.dev>
 <D3B60D7890B13875+reply-to-v1-review@uniontech.com>
 <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/16/26 1:50 PM, Martin KaFai Lau wrote:
> 
> 
> On 3/16/26 6:51 AM, xulang wrote:
>> From: Lang Xu <xulang@uniontech.com>
>>
>>> Please create a selftest for this.
>>
>> Going to do that. To stably reproduce this bug, I need the KASAN
>> config enabled, how do I ensure it's enabled during a selftest cycle,
>> by adding the line below to the 'config'? not quite sure.
>>
>> --- a/tools/testing/selftests/bpf/config
>> +++ b/tools/testing/selftests/bpf/config
>> @@ -46,6 +46,7 @@ CONFIG_IPV6_GRE=y
>>   CONFIG_IPV6_SEG6_BPF=y
>>   CONFIG_IPV6_SIT=y
>>   CONFIG_IPV6_TUNNEL=y
>> +CONFIG_KASAN=y
> 
> I would leave out this config change from this fix for now. cc: Ihor to consider enabling it for bpf-next.
> 
> It is still useful to have a selftest for this case. I always have KASAN turned on when running selftests.

Hi Martin. BPF CI has been running with KASAN since July 2025.
We only disabled it on s390x due to frequent OOMs, x86_64 and 
aarch64 are covered.

For BPF CI it's not important whether CONFIG_KASAN=y is enabled
in tools/testing/selftests/bpf/config, as long as it's not =n

> 
> 
>>> [...]

