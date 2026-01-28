Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA7284890
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621637; cv=none; b=g377IU+wFDleJBV8Y9Kgee9wQqXbAQYKKXFpdSZwZ3rmwKybfVDhCwioOFLCUZFglWFHjGZq8Pmg5ikJq2NX7N3Vy1OEKiQ4yDTyQf44oA0ahtjV597idafzpLQB8UBggyP1QUxJXopfB8mh27YMk7AiM+PUSNxe80vLcPr9HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621637; c=relaxed/simple;
	bh=usdks5kHA0D2RdMzCUKsbX6aPhXCsRGACfktcEYQAoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz9VotrXlijSXPPxJzaLwh1ENrLSRSBmS9tKzx4lYJWxpeicuQ8NGZ6fqsMDQUcwVg5U2lbQ+P6Ho8U2FrohRRpLlSI23j1io4lRL0GU1XB0rMNmbvtPwSWsZ4d2AmnmemvZpuKkLlHmLZMKIJZs5xx+OpfmCWiYPVCtI+VAoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uY2/PtmT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uY2/PtmT"
Message-ID: <a10afa70-29b7-48ab-b241-8b0f602abe2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769621633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ozQXOHXvtQuF4Vzt0ntyV+NPGSwkEALzq+rw9H3FRc=;
	b=uY2/PtmTw/9BwPivyf1nZfOzbC8E99t8ADk6GgnTUqPT4lIwNKg2C75dwdIlsJLf40K3N8
	0BJrqxKHaAZV9d+NovCaCz8zMMVlVOnWArddOz7q6bpfj+ncxX+rhmlDQcpmxGFZ1nG4xi
	nsSt379RaIKWU4gIZN3fo3zz7630mto=
Date: Wed, 28 Jan 2026 09:33:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Chris Mason <clm@meta.com>, bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, menglong8.dong@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org
References: <20260128150112.8873-2-leon.hwang@linux.dev>
 <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
 <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/26 7:35 AM, Chris Mason wrote:
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

This is the email body pre-processing in KPD, yes.

At some point we decided to remove the commit message before sending
an email, but now that AI reviews the messages too, I think we should
just send the generated review-inline.txt as is.

Alexei, wdyt?

> 
> [...]
> 

