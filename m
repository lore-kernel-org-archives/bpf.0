Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15A2BB02
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180050; cv=none; b=cMdkRBHAvOYQvQCHeBzsLc0w+6b/4T+I2u6FUzI8O6tiLaBzJs3DKiH80/kNmV3trcku/wo3M/aLpH+UHuGS42OPaaSCZ1Hekl2OrLMSbVMY4fldnMT/aQMxjD+/uH3qZPpPJ6Z+RTKJSnynk5XqvP1I16XUMwqNOdUEDSaMjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180050; c=relaxed/simple;
	bh=Vf1G1a80Lmu3aumwcutNHx1A9aMcPIeMg0AGsKfnbiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXTJRO+ArEDrVuggyl3Z2fnLVgpxYk4+wBJ2cPY0yGuN1IDA+qci1T0xW19CY7rrVZ180Kic4+agONzV7eEbZMLuCIBkzjkK9/GdVMpC/+yO+Xlopt/mSULQaTIQNGQRd/a07Mert4Nm6YWboPCBgDvK7eN4zS9vB3Z6AgLrr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg0wMlSN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg0wMlSN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61524d10f86so3956737b3.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712180048; x=1712784848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1c7bqMm/FAG6yB45RsDJmw7FJIXWGclel0Po/BAUPcA=;
        b=hg0wMlSNLCWB65Z5Awxs/KFT/Lup4bW1a73Mpddp/YF0zFFstByWFVKtPnBOxczWME
         mOqdrT6RnNDh+vRhtL3n1K7LjTugMLH+6SwPIbQL1m/JHwAg8cnZYNUguvOe2D5o+Zk7
         qwfw6CH0wH2eTwMrEOyHXzItPSdClNAHz0vxT8PG8ZHrGrcCtG5w1H8BQWskSAbMT2UU
         2/yk3QIl5Z0XI7Dopn4IoXN8/zWyTOOKiRKc7N0lhN23FYRb+n64QFPO4zSsup+evu5b
         vhDmEekcSDnIMAYfKSe5aFnygNnG4DLUd9KbCTxOOURbXf6fdtBSpmvy2oKnnctRwcbH
         dOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180048; x=1712784848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c7bqMm/FAG6yB45RsDJmw7FJIXWGclel0Po/BAUPcA=;
        b=eqHBeSP+9ChSK4H8Ftn7KEMuQWZkT03PsYa6++Ko60H6znhmsdNyMX1Rd8BlEEEjuG
         9qsaTm7TPg5kZjS1MA0S6ZT3VuwKuNeN+YTsLsVCA2HFkrukgkaBq4KDHGSvG0RyxBjP
         9CifPCc7nR5w5jVLLxkSPpFdwp9CIJAI76zjX1F62qKImqQ5bHbq2MOIb33c65dAqCiy
         fhGru0K8OTH+1LKVv2UepcPHdsg9of+1FMsVymJD19x/YcylAGGuLyiTWx3OsQqBfNFF
         TgS6mdC4y6AgLsm5xR3uGbaGv7Vaxfx3fAtrfwrtDpEYj89QiH8bZCorf14Wxbx0EOdj
         2sgA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+8ye6zf+t2LTaepfez+Ar51TBJm/xjqtrk0r1m7jSBPfncTHlr9XenKBl8H01VNmgcSHbNo/vFaqVhzR1tn5M7lG
X-Gm-Message-State: AOJu0YyF4wpr0Xc619l1ai92DFgeTkosOw7Ui1lati19zmLeBVjXTPso
	IVfL630VmcL8dYDokg0To88DIM9fdpA82lF3D4850ok4xn7YcATb166JQJla
X-Google-Smtp-Source: AGHT+IH171rlWVvVDb9woLJGoGnKChq//092dlqpGZxk8+EFule+qLdr0yhVr29mVyFdxlk+2OF4BQ==
X-Received: by 2002:a81:a24e:0:b0:615:9a1:602b with SMTP id z14-20020a81a24e000000b0061509a1602bmr527275ywg.44.1712180047935;
        Wed, 03 Apr 2024 14:34:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ea9b:8565:6861:e063? ([2600:1700:6cf8:1240:ea9b:8565:6861:e063])
        by smtp.gmail.com with ESMTPSA id y13-20020a81d30d000000b0060a0f62c589sm3524084ywi.137.2024.04.03.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 14:34:07 -0700 (PDT)
Message-ID: <50dda002-cb70-4383-a43b-5cc615aecec7@gmail.com>
Date: Wed, 3 Apr 2024 14:34:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuifeng@meta.com, John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240401223058.1503400-1-thinker.li@gmail.com>
 <660b62aed55f5_801520863@john.notmuch>
 <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
 <ed6929e4-cf8f-43cc-869a-d79b0158c9ea@linux.dev>
 <CAEf4BzbOBE0pdmdGeZKM2FVjZ5Rii=kjYNENzWDs8obGtLENuQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbOBE0pdmdGeZKM2FVjZ5Rii=kjYNENzWDs8obGtLENuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/24 14:15, Andrii Nakryiko wrote:
> On Wed, Apr 3, 2024 at 1:52 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/2/24 10:00 AM, Kui-Feng Lee wrote:
>>>
>>>
>>>
>>> On 4/1/24 18:43, John Fastabend wrote:
>>>> Kui-Feng Lee wrote:
>>>>> The verifier in the kernel checks the signatures of struct_ops
>>>>> operators. Libbpf should not verify it in order to allow flexibility in
>>
>> This description probably is not accurate. iirc, the verifier does not check the
>> function signature either. The verifier rejects only when the struct_ops prog
>> tries to access something invalid. e.g. reading a function argument that does
>> not exist in the running kernel.
>>
>>>>> loading different implementations of an operator with different signatures
>>>>> to try to comply with the kernel, even if the signature defined in the BPF
>>>>> programs does not match with the implementations and the kernel.
>>
>>>>> This feature enables user space applications to manage the variations
>>>>> between different versions of the kernel by attempting various
>>>>> implementations of an operator.
>>>>
>>>> What is the utility of this? I'm missing what difference it would be
>>>> if libbpf rejected vs kernel rejecting it? For backwards compat the
>>>> kernel will fail or libbpf might throw an error and user will have to
>>>> fixup signature regardless right? Why not get the error as early as
>>>> possible.
>>>
>>> The check described here is that libbpf compares BTF types of functions
>>> and function pointers in struct_ops types in BPF programs, which may
>>> differ from kernel definitions.
>>>
>>> A scenario here is a struct_ops type that includes an operator op_A with
>>> different versions depending on the kernel. All other fields in the
>>> struct_ops type have the same types. The application has only one
>>> definition for this struct_ops type, but the implementation of op_A is
>>> done separately for each version.
>>>
>>> The application can try variations by assigning implementations to the
>>> op_A field until one is accepted by the kernel if libbpf doesn’t enforce
>>
>> It probably would be clearer if the test actually does the retry. e.g. Try to
>> load a struct_ops prog which reads an extra arg that is not supported by the
>> running kernel and gets rejected by verifier. Then assigns an older struct_ops
>> prog to the skel->struct_ops...->fn and loads successfully by the verifier.
>>
> 
> This is actually a discouraged practice. In practice in production
> user-space logic does feature detection (using BTF or whatever else
> necessary) and then decides on specific BPF program implementation. So
> I wouldn't overstress this approach (trial-and-error one) in tests,
> it's a bad and sloppy practice.

It makes sense for me. I will rephrase this paragraph by using "feature
detection" to replace "Try variations...".

