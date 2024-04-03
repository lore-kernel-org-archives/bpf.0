Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CC154C03
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179685; cv=none; b=NqKdvgr/n+53hVRy7D5S1C9GG8El1+HkUdRkkuWrxGA4FXQzvaznydySWqTUqCmLqD+psdnJimAfqbzpDeOBb4pZqRHwEpQMmYlk2Xmhag0VBA9qZCHtrn/KQxVWLvRP1uTsIvySgjW20lptUn9QOMgrVGZIfTcj+cXPXqSDsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179685; c=relaxed/simple;
	bh=G/JVaVk8MjhRgBxcC777L7a0wwIDW3o/XjVGTX+YTYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uREDUgaxTF2Ba8ZJHjtJrcR1jvrb1kGIbBYlM6pAJn/5ussST9gpu9JizoSRPH7NVk8dYyQWzpOZN2xfgDylnNDzr6XfJ2Xd9jgKZo4alnaq43E43s92W/gphdgZOFve89ZGyOyoQom3UAxhXGXWWmhW/ZwjlzajeMYac63qMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuiP/la/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuiP/la/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61587aa9e8aso1196647b3.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712179683; x=1712784483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSBz2luO/vqw1syuKSVj/XXy9G5Z56OnQGgw5fjnJOk=;
        b=kuiP/la/dNJIxkkqIXfh7ol1EufSVXlFDSmRU/HWX9eT/EvYuWxnNmggDO9BJWgUpd
         afR8o+DhV4QZAXjwi4/tV24+Oib/awDhofe9qWhDklqaECqmnz3svxRGAA1YtGyEnm36
         DyBvUS7QZrGl12JuGz5U7CQ+jwQJTvbEDi03Qa9BwnGVmq1OQ8AueFx4FetnkuhYLdw3
         fyhPYHRWgS3LeegIWVZl8z5mhFB4l4TE/kcugYU3vISzdmnn2o6VKBsyVQv+K7XyG3dr
         eB04xngAHYvslvh3ulHThZzMQOinYlWZxaj6sNtqEAx62Uo98K17J1wzCtK9x5zMZD4w
         YiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179683; x=1712784483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSBz2luO/vqw1syuKSVj/XXy9G5Z56OnQGgw5fjnJOk=;
        b=CLfisRvj+clzQde6RPbZJT2J29BxhdGKzDnLpuG89sHwttyHlABbkHX2DTfwuhFNB5
         QW+rCQa+JAWFG3dnPh3gwFHB98LaMZYq3WvjPnIuVqTdWPUkNx9AhY//QuWt61M6gBp5
         /jVnMqcP4p6qG+GsZSX7GMpASohA/xg6mvTRDhHYzd/wyAyB7jN+PZIkNIb8bnJSNlRt
         xF0xJXlOodMlx1Sg4oh3OIUtftPBOTAAS0yaxqMYlLRNy2ea7pUSdv8iAfog/VdD/vnl
         dJknmJt/Cwkl9pWAGxotO/2+7T37sp25SXiQoO2lbRIX5dXfw8Bj08MtN4VD95k7uCmI
         4zSg==
X-Forwarded-Encrypted: i=1; AJvYcCUMnk40RLQLhsXA7l5gzN3whSn9Hpuy4kalOi0d6nMylxvTbgmgtPBl51U7+tCN36w2BuYWbo/XL6+ZsG0CqU0Br04v
X-Gm-Message-State: AOJu0Yzsiz3jzU4ipTBlDPfZlmDo2zTuAFCuedU2X+D6ImQYFS/R/gGo
	OrsUz4xkanFfObn0PKgU2lCf+381+OQZ+LIuR/xhCE5p4Yummjju
X-Google-Smtp-Source: AGHT+IG6tX5EcifQi4HyzY6LbZRTJNTrGAL6XJ5sfQCg7Hn3+1Mv4fWAVfMnWzkoAn9H1VOPcZ8rTw==
X-Received: by 2002:a25:e050:0:b0:dd0:c866:ec3a with SMTP id x77-20020a25e050000000b00dd0c866ec3amr770860ybg.22.1712179682699;
        Wed, 03 Apr 2024 14:28:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ea9b:8565:6861:e063? ([2600:1700:6cf8:1240:ea9b:8565:6861:e063])
        by smtp.gmail.com with ESMTPSA id a15-20020a25ae0f000000b00dc6d6dc9771sm3245378ybj.8.2024.04.03.14.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 14:28:02 -0700 (PDT)
Message-ID: <f501a1d9-e495-40bb-a7f8-d9a226cecb55@gmail.com>
Date: Wed, 3 Apr 2024 14:28:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuifeng@meta.com, John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240401223058.1503400-1-thinker.li@gmail.com>
 <660b62aed55f5_801520863@john.notmuch>
 <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
 <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/24 13:52, Martin KaFai Lau wrote:
> On 4/2/24 10:00 AM, Kui-Feng Lee wrote:
>>
>>
>>
>> On 4/1/24 18:43, John Fastabend wrote:
>>> Kui-Feng Lee wrote:
>>>> The verifier in the kernel checks the signatures of struct_ops
>>>> operators. Libbpf should not verify it in order to allow flexibility in
> 
> This description probably is not accurate. iirc, the verifier does not 
> check the function signature either. The verifier rejects only when the 
> struct_ops prog tries to access something invalid. e.g. reading a 
> function argument that does not exist in the running kernel.

Yes, kernel checks the behavior of programs. I will change the description.

> 
>>>> loading different implementations of an operator with different 
>>>> signatures
>>>> to try to comply with the kernel, even if the signature defined in 
>>>> the BPF
>>>> programs does not match with the implementations and the kernel.
> 
>>>> This feature enables user space applications to manage the variations
>>>> between different versions of the kernel by attempting various
>>>> implementations of an operator.
>>>
>>> What is the utility of this? I'm missing what difference it would be
>>> if libbpf rejected vs kernel rejecting it? For backwards compat the
>>> kernel will fail or libbpf might throw an error and user will have to
>>> fixup signature regardless right? Why not get the error as early as
>>> possible.
>>
>> The check described here is that libbpf compares BTF types of functions
>> and function pointers in struct_ops types in BPF programs, which may
>> differ from kernel definitions.
>>
>> A scenario here is a struct_ops type that includes an operator op_A with
>> different versions depending on the kernel. All other fields in the
>> struct_ops type have the same types. The application has only one
>> definition for this struct_ops type, but the implementation of op_A is
>> done separately for each version.
>>
>> The application can try variations by assigning implementations to the
>> op_A field until one is accepted by the kernel if libbpf doesn’t enforce
> 
> It probably would be clearer if the test actually does the retry. e.g. 
> Try to load a struct_ops prog which reads an extra arg that is not 
> supported by the running kernel and gets rejected by verifier. Then 
> assigns an older struct_ops prog to the skel->struct_ops...->fn and 
> loads successfully by the verifier.
> 
