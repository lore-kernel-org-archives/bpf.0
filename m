Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631742189E
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907746; cv=none; b=oN6DLDiKqERqXN1Wr0zr+5iiOAwsCtqOJ9ytvqpCcKPcnbgXefLtdGdEcAGdAMqebZDbi2qNPJCUYtiMFKK5fqrR5OMdUvQFwxqEwi9+GfIPXUo8z4JB32rhzBOkfIJo8kUkq9hh6zNSfDReIzRnQHsNwBqJAyNpPZptXueB15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907746; c=relaxed/simple;
	bh=KFivMVURS/P4rdljNGTW2OzSO9AS6vyS8A+lATrzWUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPvfn3g0fZVj0/7zIq4aLU9jbzs9jG5N0lVCXi2AoYf7No1H/JB5t2iWIkSY8flb52vzoOOaKoNXwrsj8Wr51c+sYa6K4DFTICdOZkoYsrn03OuzjVg7u0aedJ8UERpPyHoqGS7Dpx87ETSiaZ9qe6/idpGqoXp8wXU4SOe4794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8n8c5S7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1Z6YGIR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8n8c5S7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1Z6YGIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768907743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+GMmJzGdHYdqJT1NjST6XtDIczt0rZ/LFLtfnWFVkg=;
	b=D8n8c5S7AqXKqqVCrtlslAKb8EMScVQGLoMECJ6uUaUrfQl06n5r5AWrkJA3QRzGO8uDZr
	byxR5tNbIkF+TRtsCWyhpVCv9KmEx0V78AqyF2c6iRLsTbW3sSnIortNaJK44LSxdCfZya
	KRLaLZEpaQS4nSruTvzRO51ftJSf8Qk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-hNpHEg4-Mk6oI6ICnk2vig-1; Tue, 20 Jan 2026 06:15:42 -0500
X-MC-Unique: hNpHEg4-Mk6oI6ICnk2vig-1
X-Mimecast-MFC-AGG-ID: hNpHEg4-Mk6oI6ICnk2vig_1768907741
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801bceb317so52281575e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768907741; x=1769512541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+GMmJzGdHYdqJT1NjST6XtDIczt0rZ/LFLtfnWFVkg=;
        b=g1Z6YGIRmMrcKVAUnLDsXePxaC0Fbw88i2iFKDmOdblNZlQzN+8y9bAoEygOWVx+yo
         nEtmntC5Iwhc+UOn+7vLMfHD4iBNS44TrzNGuKbvTeL5e+pavp5BSJ1T8JUuOdopZVQm
         f0deF02+W5f9ikr08Bw1gG+IxowWgLIwkNbKAd9C+fx/UIY2fwGBUXN5xuRgam51owFI
         hxJfn/HAwYms+B8WzvcT6GV2kq4ryEGPGmkLRNGUlWNyk8ysg3VKeHGQfwHHdcQFSuxg
         yTTf8OC1nxv+j2jZQrZPaddZ6wXKVd+0LBr6i6MR2zuHi5w+EI8SGsx5NbJKwBh+p1M6
         rRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907741; x=1769512541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+GMmJzGdHYdqJT1NjST6XtDIczt0rZ/LFLtfnWFVkg=;
        b=O2dSbAW4CuyFwqSUK0SzKfrYNiu6Xqhk+d17QDtVXYwiFVL1Rs0BuOCO4SMMlg8x41
         BBJdAx9gE5dppJa9JukD51zwcfcA2HXOrFuQPVAUWkW6+G5/C9bnE01qdlmfw52Q6NHJ
         4fNBCdtLeRQcXA8x0MXV63bgMd/YGBmGlqN0Eqec0h2vmEBVhi8Hbt0XI2/rdOO9ZIeP
         X0SQFbceu+ScZFCr4H6N0/fCcMyJhejC/GrFApTv6eupHbJiHc9KPaGohe61n+ZR6oxt
         g5iEvC1Si3CcqJCrybkMoELGUftD+4MGIUPV2mCL1r88QN99/8dcIdOuO2daOp7Mb8ok
         jRmg==
X-Forwarded-Encrypted: i=1; AJvYcCXeLcuWNzgG/OILSe3zXHLp3hqDZOGtvvj0n2UdX1iJepeKFviyYsQQGJ8YO15naPejDKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhA1XsCoF0IsaN02+qR6cQ/cpayuXwAeMeJhWpyMY6FoCP9Mz
	zvPNHGSZiwwzQKwejKWMRtCdA5hoIVIn3XjuJEex9Bhk4S74heBFihzunLaDFsmYYM7mGIsTF3E
	0zlJ30wYJ0ObWch+o1VcpWhVzN5U3wNh6MhYzTn+rbZFFlzI82MTn
X-Gm-Gg: AY/fxX5jCstBZemWUs0AudaAKQVoL050A/0xe1i+OtPqJgBsJlJrIIAHx1N2lKhfGm/
	gfDruRWSHWNEJPHA7KLD2F3YP9NwjnZyAnpgf4HHtYGs3WScV+iEJ9DbPlb9fkIJyD413bqgFCc
	/a+tsXbi7POqcNiyfoJ6+6X23fwP5NS4/TESXi+btEIXBFDtNLn6sh0arO40T2R+w5LeRzQX6e3
	JYB3xGL+745JfcQGRRj7CKY6QN1ofS4q3NGvMYKv6gesxtvH6B4KywcrD22WomGG+MuGAzwsaP2
	hMmADfcPVB6y+exRce7wHvQ7czbJUFXnFux/f/Zz6ZL7uiIx/cEO7J4ChjUrYgm4I9mt+aJN
X-Received: by 2002:a05:600c:4f8a:b0:480:3c28:838 with SMTP id 5b1f17b1804b1-4803e78ffbemr19193835e9.8.1768907740897;
        Tue, 20 Jan 2026 03:15:40 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:480:3c28:838 with SMTP id 5b1f17b1804b1-4803e78ffbemr19193295e9.8.1768907740401;
        Tue, 20 Jan 2026 03:15:40 -0800 (PST)
Received: from [10.43.17.17] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f138e26sm3584141f8f.17.2026.01.20.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:15:39 -0800 (PST)
Message-ID: <86605af8-89c6-4f7a-9b76-1fb8f3ea109e@redhat.com>
Date: Tue, 20 Jan 2026 12:15:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org,
 ishiyama@hpc.is.uec.ac.jp, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
 <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
 <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
 <6470f4f2-2d38-43e2-ae92-d6e4c9121eed@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <6470f4f2-2d38-43e2-ae92-d6e4c9121eed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 12:02, Mykyta Yatsenko wrote:
> On 1/20/26 09:29, Viktor Malik wrote:
>> On 1/20/26 08:21, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 9eaa4185e0a7..753753f039ff 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>> [ ... ]
>>>
>>>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>>>>   {
>>>>   	char c1, c2;
>>>> -	int i;
>>>> +	int i, max_sz;
>>>>
>>>>   	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>>>>   	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>>>>   		return -ERANGE;
>>>>   	}
>>>>
>>>> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
>>>                     ^^^
>>>
>>> Can this truncation cause incorrect results when len > INT_MAX? The len
>>> parameter is size_t, but min_t(int, ...) casts it to signed int before the
>>> comparison. When len is larger than INT_MAX, the cast produces a negative
>>> value, and min_t returns that negative value instead of XATTR_SIZE_MAX.
>>>
>>> For example, if a BPF program calls bpf_strncasecmp(s1, s2, SIZE_MAX):
>>> - min_t(int, SIZE_MAX, 65536) evaluates to min_t(int, -1, 65536) = -1
>>> - max_sz becomes -1
>>> - The loop condition (i < max_sz) is (0 < -1), which is false
>>> - The loop never executes, and the function returns 0 without comparing
>>>
>>> This would make bpf_strncasecmp("foo", "bar", SIZE_MAX) return 0 (equal)
>>> when the strings are clearly different.
>> This is a good point and we should IMO address it.
>>
>>> Would using min_t(size_t, len, XATTR_SIZE_MAX) avoid this issue?
>> Other string kfuncs use `i < len && i < XATTR_SIZE_MAX` in the loop
>> condition, I'd stick to that for consistency.
>>
>> Viktor
> Why not just use proper type (size_t for max_sz), obviously truncation is a
> problem there, so use the wider type?

No problem with that either. I slightly prefer consistency but using
min_t with size_t is a good solution, too (and slightly more efficient one).

>>
>>>> +
>>>>   	guard(pagefault)();
>>>> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>>>> +	for (i = 0; i < max_sz; i++) {
>>> [ ... ]
>>>
>>>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
>>>> +{
>>>> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>>>>   }
>>> The BPF verifier does not validate ranges for scalar kfunc parameters, so
>>> BPF programs can pass arbitrary size_t values to len, triggering the
>>> truncation issue described above.
>>>
>>>
>>> ---
>>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>>
>>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21162711653
> 

