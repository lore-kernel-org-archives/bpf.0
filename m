Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572D3C1987
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906961; cv=none; b=AEHAqEAgtq/t3bPJPaqrYIJCDwdTvX67sx7zax8rUrqVC8/by1QmehKd9uMyEF3sN6wX8ihFJa1fN3ioBjdRvHsODtgHkYi4K77PlJN4iFcTlbskJR4PbukcpPd0huJyQ0LJfAfYU+8m7JYljmGHGCcfyalcnWf04JGDZS/rimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906961; c=relaxed/simple;
	bh=plKX4p9KeG1iuT2k8X+sCDF+j72GEKkfqGpYrzEza98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJqPzYU0wME8YGNdC/mJwajKcJnSZv8tY6FYyviT4CzyeK5b9LE7JjU0bvNCpIRWqd3ffcgtdRZqTlp3b2tR9yXLLYi+VSjHL5DVu+WFwBEipaU7H1h8M0HPzjJLrJiQLAK/7XlP9P8BBCJnLTKrEBNd4uXYjRdhWtiL0PQAvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcSFEnlY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcSFEnlY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso35200865e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768906958; x=1769511758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ii4yQG3O4tdjnWQ/9d1ajHt7losU6YVj3bqNkS06JC4=;
        b=kcSFEnlYagvisxrc7a+ilpU9S7ShPjZ4P+6SOeZ1rsbEFEiRg67DW6TH8QSSZFIqNA
         TTiG0Ir99P8CJsKRxmAZES5RL6F8vfuPdKAg/pKVTcAyLB7OBZkvPPyfUacMEpVrfHsN
         +xs15cDBtVXimVAOypqsfx/94Eglo7hSTVgE5SBxyGtdXMBLLv/Fz91lTAKLkoMoPPp+
         13SRuvuG3i1MVY9NJzBIvqNf76bjXxWM8Yf7RAgLmtJGJc3nnzsqkd1eiQ93PPhBgazx
         Qr5DHvXwdTA1JChZSAYXJXLpBDOkfeacX4R/SAHTMzIBKwp00nry8nxAhOrEoiye1zi1
         1yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906958; x=1769511758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ii4yQG3O4tdjnWQ/9d1ajHt7losU6YVj3bqNkS06JC4=;
        b=BpmahXtr+rbW9uotdlRpM7GiRXSq5CTOyTweaDGgCYQSbRJjAt9nioN5PySL5gfR4/
         1kIEqp3aKYeji92fkVH7YgmfBRprF8Gq3jAyxjHrLrt4X8FlFymI3bpRSNCLPyOpgz2A
         M1RaibtN9HfmGmIGQzXuCP/HQzienVzIPgaWG90q74Q/nI5Y/Tf2PGa7zesv8CDbAQJn
         Mjk2EYY26mL9uB0Fe0mGtgSGvmACshgzlMR8a5jQo9xFP8KY23fhmVzy3bF+9jUj/k6I
         5VKqwdfjZk1SJcAnf50HCOrPQ+ymPbrfvTnXoaRRVyLdNrdWlVcrdgvVM0gTdhTkvImT
         1/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVNfAcOFJQsXDrpijX8i7zSIrgO96zFDOXUffJ+XadRbxFZbTNeZ6fR2QZwwr7i67DrI28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9W4K3cxz6HhG/O7STip3S7vbJnwUWDcO84huFPdHnJxwOPAnZ
	jCABNLNt+MhZBhiLkqqXpd6525AaJ50J1ZmS9ZzSSFCtLw71yuP0qp7l
X-Gm-Gg: AY/fxX4Q46TsKlo75DXkEhwJcJ6jQv1eKCUC/qHodaShE3sIEf6oz43C2UHbTbIkDGk
	+lSdcDgV44V7GEFJ7/D1MYvnhypcG4BnqtrvLcldHYYky65A2f3cRpDxp11i6zk2os9B83Jz9Hx
	FDCmnWmAjQSjlV/7U2CpKpIFeQM73rxD5bz16EPWAS/ydD9lzNHGP3QP1GmU1prnulxPgjwf/MB
	IPRgFiG0h9+kNsp68noGDGYJ0dDG88NCmBFbGsLYwZgGmaUoIBRO1BoKvYl4t0uuYdqMIE13mVC
	ZHkVt2fADfsL/pIZQBR39g/3Ba0FpdnAntKQF4u9C8BGwXV1C1g1FJYdLzHoNJEMfFcxMPSvDan
	xwCPQv5uwk+U/i0A8gznXN8k45TAdZIr0c+zO6ZQCpUfszFkbdMec6Oor74qRtqLc5YNThYBv//
	+KT01O0n/qunasm8JgXwJ8vGLwLND3FKcRDfSvB8RojRlP8Ffj+bsIlvvB+Si9qqNvJrSf+no5C
	Ws=
X-Received: by 2002:a05:600c:1f86:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4801e53ca36mr218201745e9.5.1768906957459;
        Tue, 20 Jan 2026 03:02:37 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0475sm286630915e9.10.2026.01.20.03.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:02:37 -0800 (PST)
Message-ID: <6470f4f2-2d38-43e2-ae92-d6e4c9121eed@gmail.com>
Date: Tue, 20 Jan 2026 11:02:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
To: Viktor Malik <vmalik@redhat.com>, bot+bpf-ci@kernel.org,
 ishiyama@hpc.is.uec.ac.jp, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
 <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
 <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/26 09:29, Viktor Malik wrote:
> On 1/20/26 08:21, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 9eaa4185e0a7..753753f039ff 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>> [ ... ]
>>
>>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>>>   {
>>>   	char c1, c2;
>>> -	int i;
>>> +	int i, max_sz;
>>>
>>>   	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>>>   	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>>>   		return -ERANGE;
>>>   	}
>>>
>>> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
>>                     ^^^
>>
>> Can this truncation cause incorrect results when len > INT_MAX? The len
>> parameter is size_t, but min_t(int, ...) casts it to signed int before the
>> comparison. When len is larger than INT_MAX, the cast produces a negative
>> value, and min_t returns that negative value instead of XATTR_SIZE_MAX.
>>
>> For example, if a BPF program calls bpf_strncasecmp(s1, s2, SIZE_MAX):
>> - min_t(int, SIZE_MAX, 65536) evaluates to min_t(int, -1, 65536) = -1
>> - max_sz becomes -1
>> - The loop condition (i < max_sz) is (0 < -1), which is false
>> - The loop never executes, and the function returns 0 without comparing
>>
>> This would make bpf_strncasecmp("foo", "bar", SIZE_MAX) return 0 (equal)
>> when the strings are clearly different.
> This is a good point and we should IMO address it.
>
>> Would using min_t(size_t, len, XATTR_SIZE_MAX) avoid this issue?
> Other string kfuncs use `i < len && i < XATTR_SIZE_MAX` in the loop
> condition, I'd stick to that for consistency.
>
> Viktor
Why not just use proper type (size_t for max_sz), obviously truncation is a
problem there, so use the wider type?
>
>>> +
>>>   	guard(pagefault)();
>>> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>>> +	for (i = 0; i < max_sz; i++) {
>> [ ... ]
>>
>>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
>>> +{
>>> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>>>   }
>> The BPF verifier does not validate ranges for scalar kfunc parameters, so
>> BPF programs can pass arbitrary size_t values to len, triggering the
>> truncation issue described above.
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21162711653

