Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4892836AF
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786295; cv=none; b=ki2MNehtt6mtYn0P/GRwLUN0c5hdl5jkqc2BeJ5Kzg7ttKpoEWn58mUpDzs5UE4QBdVyqQZC3r+Z1ozUvqEj4ZNPXRc9ohJwX98Gurql+anT6nMVZVKyCZp6tjk2uaF0+/CoT7M45+QmPukDrAuvE6bVc292xJadyoHuxxciZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786295; c=relaxed/simple;
	bh=jFrmwmzXzxNPU+hHqB6RRamYbKEmhbE8XbE8pAnvVxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JX2na6dayaVD/Mgm42SP4CFebVzRqhsp7RtBnRekfl98f+5ZHWK9TDqNJ8m8LtGSkWlSiTs8mUMM/GAFXPlD1Ub0+T5kIaLmv17ygzhZkJ5HNXK6DW/oFquQY6YoIgcGBB4UE8+xMwcIG3TMjZ3eROPkiNvWrG3xUS2tMXTxvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/ADDq/k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPxDUx7A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/ADDq/k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPxDUx7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772786293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P86pZu/1CyRXliceQ+LY5dZ1MCBLm/RN74G5dcWmpEo=;
	b=G/ADDq/kvcryx6eeZrurxx+o6agiWPCIDFZJpr3NUJHTJrgl6Pc3UfrhfiasjoFixrZiB2
	iBSzIMnV/oB/i7pqkUWeTPqQEPMaguXwi/C9KMnBGU8bVC0J2rzRtfC/tRxhbJLQUC423/
	e1H4XzC1TK8i/H/dwgqWVxaDnIqS1LU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-OWD-F0fJO4Oun8U5hKc24g-1; Fri, 06 Mar 2026 03:38:11 -0500
X-MC-Unique: OWD-F0fJO4Oun8U5hKc24g-1
X-Mimecast-MFC-AGG-ID: OWD-F0fJO4Oun8U5hKc24g_1772786291
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso71430225e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772786291; x=1773391091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P86pZu/1CyRXliceQ+LY5dZ1MCBLm/RN74G5dcWmpEo=;
        b=tPxDUx7Ax9v4XRRMuqaN4m+Wwo9QhAEUHyYS96o/QAsyd9Wb8a/WBA3fupoY87t/7P
         LZ+GeCaVqaPJhY6U1yPklnqWrQn1BO60dPv1sbGm5przwb8Y8eTQFWxnzxTFo1TvotjP
         z/B1qr2y/PGQkciq+z7emGjEOcQ0QjFIzFFttOyHh/+ll67fWolSflCm24zBCxneqhw9
         bq5Cld1kb5mdG0l2toy3pOsyqnjHBGJz50bk1xy12f/7IgO+QeJBP5NH5e67IgR1XQTq
         4rlIrxPSKVI4+MZaamsed6JbnK26acRaqgy6o6CrCH4VdaYxedRH0vUGPXHs6fbx+Y4X
         71sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772786291; x=1773391091;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P86pZu/1CyRXliceQ+LY5dZ1MCBLm/RN74G5dcWmpEo=;
        b=TvwzqN+kJBW7NyyXL9v/9u38e5rX5f1FehdARsGw4g+moMKSTln9qjshiPHehbPy96
         Cw5bt7nOPgpFGWUgyGaGfXf/ZjnMlk/XTos8lFIyJQv3chtWjadWhFJxmkjyVn9qu3EH
         r8LMIO8Qig0Pk7smA51FR+nybfpI6b2uEdyupc65INb+J0J4jSk4ZYwPI1D7Bj/VyDO6
         Z8tZvBmOnCMlQQSPSI66z8Hz6Cgl73vOQUasrlOh2F64HdyhQ8d3htpnciSnwLMEDao8
         U6lHj+/5QqBztKP+tZQLX4SoTk2yFHANKOwVkgySBsVvd9p1lVMrFYw9+ClnspJd/RD6
         EVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBpECYTf9/kQBH5KaF1GlI3Hmc9iZwvYSyWEz1eepXdZ6vJl3KBWv//5mOu6A3M2Uc6LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzeelPUu1E8u4UnO7vNzz8IKOisEAgyHA9dnTFEVT6qXZFXKz
	7egWqOizmJNfBUxEAk/Xh19cJaG8AOa+/oLtHr2FbzfWLUNtXW2iDWk3dcJRpL2U5kR883dSlRl
	w8rWlANa8ihsNGDfgiDfvs+9PesuyjK5rf76ICXgKgC0g+/xV+oVE
X-Gm-Gg: ATEYQzz0voPm2rXwSOhOwl2cLVYd2Hei8LHaUSMZlJzZSK+tdOWSHebITmXrkuI67VE
	t85D1gONE6EYGygyp+s3CWVEOF6H5jaaz6kE8xkKT4oUhz1G5q4eqixJNjIGjwtct4TAqseAR/7
	SB1Rx+OykYZkHGUXS3XyEze7J3D5g+0BNXyrIEsuTI8X9LffY9U1cLV4eTHaElbVm2Id7Z5xPTn
	d9HdcMCcFa+ZmzfEL7Qr8V1O/GHoFPVu9S1QyB+F6MC0QCWAz+P0lPlr0AkHq6aKSBzPSNS+0ns
	UIM0ZFHZJ0FJG5HPFZ93xtWYWhkpYdMMXsfEeHC09lzOQyX7keldr6yBThL5TMY5EeT4optkjvN
	Ho2BB6l6Wbqfcd1+95bPBV4JI5NV2/lM+fzjZ5k4qvtTmxeDhRZuntqhi
X-Received: by 2002:a05:600c:34d2:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-485269305b2mr18032685e9.12.1772786290600;
        Fri, 06 Mar 2026 00:38:10 -0800 (PST)
X-Received: by 2002:a05:600c:34d2:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-485269305b2mr18032255e9.12.1772786290140;
        Fri, 06 Mar 2026 00:38:10 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527648a19sm19608235e9.0.2026.03.06.00.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 00:38:09 -0800 (PST)
Message-ID: <042df233-2d0c-46e2-9928-aaa249e52bac@redhat.com>
Date: Fri, 6 Mar 2026 09:38:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on
 syscalls
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772721009.git.vmalik@redhat.com>
 <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
 <69b41a54-fb91-4924-999a-06ba94edf72a@linux.dev>
 <862423cd-ee96-478a-a13f-cd4ab5f4ba7a@redhat.com>
 <b5a0099c-6f28-4a54-ba0a-5d3f878cc495@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <b5a0099c-6f28-4a54-ba0a-5d3f878cc495@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 08:41, Leon Hwang wrote:
> On 6/3/26 15:09, Viktor Malik wrote:
>> On 3/6/26 03:05, Leon Hwang wrote:
>>> On 5/3/26 23:25, Viktor Malik wrote:
>>>> Sleepable BPF programs can only be attached to selected functions. For
>>>> convenience, the error injection list was originally used, which
>>>> contains syscalls and several other functions.
>>>>
>>>> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
>>>> that list is empty and sleepable tracing programs are effectively
>>>> unavailable. In such a case, at least enable sleepable programs on
>>>> syscalls.
>>>>
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> ---
>>>>  kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 48 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index d92cf2821657..cb80a3ddb7a4 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -24930,6 +24930,8 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>>>  	return -EINVAL;
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
>>>> +
>>>>  /* list of non-sleepable functions that are otherwise on
>>>>   * ALLOW_ERROR_INJECTION list
>>>>   */
>>>> @@ -24951,6 +24953,51 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>>>>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>>>>  }
>>>>  
>>>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>>>> +{
>>>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
>>>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>>> +	 */
>>>> +	if (!check_non_sleepable_error_inject(btf_id) &&
>>>> +	    within_error_injection_list(addr))
>>>> +		return 0;
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +#else
>>>> +
>>>> +static bool has_arch_syscall_prefix(const char *func_name)
>>>> +{
>>>> +#if defined(__x86_64__)
>>>> +	return !strncmp(func_name, "__x64_", 6);
>>>> +#elif defined(__i386__)
>>>> +	return !strncmp(func_name, "__ia32_", 7);
>>>> +#elif defined(__s390x__)
>>>> +	return !strncmp(func_name, "__s390x_", 8);
>>>> +#elif defined(__aarch64__)
>>>> +	return !strncmp(func_name, "__arm64_", 8);
>>>> +#elif defined(__riscv)
>>>> +	return !strncmp(func_name, "__riscv_", 8);
>>>> +#elif defined(__powerpc__) || defined(__powerpc64__)
>>>> +	return !strncmp(func_name, "sys", 3);
>>>> +#else
>>>> +	return false;
>>>> +#endif
>>>> +}
>>>
>>> At first glance, it is not a good taste to hard code these prefixes here.
>>>
>>> Furthermore, the arch_syscall_match_sym_name() of ftrace does the same
>>> thing. Consider it instead.
>>
>> I did consider it but arch_syscall_match_sym_name() matches two strings
>> (the arch-specific syscall function and the generic "sys_<name>") while
>> we need to just check the prefix (we don't have the other string).
>>
>> Another generic option is to implement has_arch_syscall_prefix() in arch
>> code, next to arch_syscall_match_sym_name(). But that seems like too big
>> of a change in ftrace for a small use-case such as this one.
>>
>> That's why I ended up with the current form. In addition, arches
>> hard-code the prefixes in their syscall code so we'll have to hard-code
>> them anyways, no matter the solution we end up with.
>>
> Hmm, I don't have a strong preference.
> 
> However, it is worth adding some explanation in the commit log and code
> comment.

Ok, I'll add an explanation.

Thanks,
Viktor

> 
> Thanks,
> Leon
> 
> [...]
> 

