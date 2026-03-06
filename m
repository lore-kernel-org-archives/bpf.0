Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDC366811
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778237; cv=none; b=F3towbVip6Gg3fwJlZuNLi8ISVuhafaxcfc724nguRcJJa2qesa5WteUKhPKPnTMoLzBFroH9+rZNkHUu+7dl+gQKb2rcfAl+bhpQXBGiWlfSEAX5PNQG9zCmW6NScvj9U1oZpZ/QknCAjHMHHfbWZYJRQ9jQ4uWreCYHeLDBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778237; c=relaxed/simple;
	bh=EKsN+yX+yi+ftieFrU3o3RX1+H9rpw8vqp1ZoriJSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y41CAdrvv2hH56gXhPCdFi6qs0ts0UrYMhENX7g41tCVC9w9VPBt7FpYIZ7y9hjZuZx/+v8Xg+k+v8uv7GOt5oAj8Y1fa03oui3zLi2YAZ+fnAliqh8vnalvYdz9pNTCqhPYQo4rguhI8pnIKUWvvFTzivuxiEbk9I/NB3e+zkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHszZhmO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5CgHuyE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHszZhmO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5CgHuyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772778234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDRt8/EK4ZknH0taR3rYFQKjDxoY12NnJkd2SmGA52Y=;
	b=LHszZhmO7wazAck/dp2IrFtgDOurHZ5YOZ56Lr6VW8VnkCoZkG/OyQgFtIEuODqcUnGYj0
	LwXMa7LKhcadokZ0BauRGbenZhLaI+aL/XNf0ALf/Ssnpgd2DNE6m+T5imDtDAXEHPe/xK
	Yaf+LTOKNHelU4TkFhx7m5McAQHfo1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-sKUIeBJzOVKR05ApbKkFPQ-1; Fri, 06 Mar 2026 01:23:52 -0500
X-MC-Unique: sKUIeBJzOVKR05ApbKkFPQ-1
X-Mimecast-MFC-AGG-ID: sKUIeBJzOVKR05ApbKkFPQ_1772778232
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439ab866bc1so6994146f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772778231; x=1773383031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDRt8/EK4ZknH0taR3rYFQKjDxoY12NnJkd2SmGA52Y=;
        b=L5CgHuyEvY6g7+GAqpUXGR18j7fMllpq9DgwaSeOZmd/bgX5/Kb3GkuJUBT1/sDpOf
         K83mLX/6WcQxtvYjkfxConc7rDYxif5bNeKydSNNkZI6G2VYxEY1T96DMRP/OOBwQqSH
         olkvTSXUocpjULWRtV6GjEE8m2TbmZV6yVtaA90kLessKr1/pTlwvNrhQJtK+BHeoVc0
         +GibbMtOZuZJ8XvHg4O7VWqaePCEltsBmWxdALfpfA3e1I7d6aVqP8O2ppof108kzIZ6
         ODiMzCcuFzmsqSLL0ozmDj2VK4V19KwvFHM2bQeEKENDffQIW2RSfTyUIuyaYYPvebQB
         nRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778231; x=1773383031;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDRt8/EK4ZknH0taR3rYFQKjDxoY12NnJkd2SmGA52Y=;
        b=cE+K2PccD/cvCOavJdi3zsQ+R6MR+l3uOG01YN1sbpchRcZxumTjjtfhPLDFwZd5Yw
         xqgleGW7HLO5KAYL9gn3OhO2oz96TnpXwzi/yMLqDAi1yaHPi1RvbzquQ4NZOZIHyP2E
         gSb0lCXJ1YVl8WH88SUpQtnAPG1DZujbjB4tUDy3fMPr2HdvF3pAtrGMuX/cFi4K4MwL
         vHt9qkfALo9FYtzPrfC87pmIJ7q9Br5hoGf+lmEV7l0Syb0Mt8y8JdGeVMq6umcr4d2+
         JPWuPa3P4jRPuxa9ymuzcPlSZeblywJfnUdZ4UdTOFrEZW6g015cjAmhS0WeG4eiHSyx
         R7pQ==
X-Gm-Message-State: AOJu0YzVT4YJYehZQdYny4DVsgTxEgT7KJz71KaouW31+UhFr/oT+FSL
	WI4XDNyi50eDk5fJ2RsHMe7BJLJUt3b+ztLl1kf3rjCk5oj0C+CIrBoX/ofgHzuG4X7UqER6ULX
	k0o8kDG7sKP2ggKlOImtzQZNdty+MyQ1mo6VTFGV6rtAkqyDJZh0dcTXfu5OfnUA=
X-Gm-Gg: ATEYQzw3AQv8tmLv1jELUU4K1ZBRYosx32LKz3AESGIHzaI3qZl7Om1XLG4LSyTBVZI
	vCDVpEa12a8nHZAeuiBnQ9zOC98KZQw1irT8sk0L5JkwFrSiW/V8I9R8CopKuTcG2x4rPe3fBiS
	8RgZ/Tf59YmXqC1WBrpODfw5FhkMvnbxiIWrYBVfSInERIc5OEEBFl1mHjJhTaSWDZYdGpjlFeF
	Zmmuc4VsWpBB5rz0o4Rux3EOlupM60F8fUcovQNm3R5LBg7SREAR3DCjAWy1YxGQ6r1ycD0D87t
	cfm1v5ayaogy0F+RuqmpJjwGDvnc6xFsKsMRO33SXJJTfypnWMlwEcExzQqpxCYamSPrVVl2Yxc
	st6kv7gb9Jdp9Y2kkGwmdPqk+/4OywsJbCc+Y2guxpysJbxTuD1t3c7tV
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id ffacd0b85a97d-439da656affmr1473078f8f.16.1772778231412;
        Thu, 05 Mar 2026 22:23:51 -0800 (PST)
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id ffacd0b85a97d-439da656affmr1473043f8f.16.1772778230881;
        Thu, 05 Mar 2026 22:23:50 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm1467585f8f.21.2026.03.05.22.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 22:23:50 -0800 (PST)
Message-ID: <064f9d6b-827f-4de2-827c-60841db0e2b5@redhat.com>
Date: Fri, 6 Mar 2026 07:23:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf: Always allow sleepable programs on
 syscalls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 shuah@kernel.org, leon.hwang@linux.dev, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <0715e86d7461c20d318594c770b6fa4c71f299c5.1772721009.git.vmalik@redhat.com>
 <e21c875dcc2ec41524707acee1fd07bcd9dd3868cd6cdd63a9d7625c764271f3@mail.kernel.org>
 <CAP01T77_E7rJPEykxbZ2dx0aFBk+N+pFae3r37wrzoFcUBa_OQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAP01T77_E7rJPEykxbZ2dx0aFBk+N+pFae3r37wrzoFcUBa_OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 03:02, Kumar Kartikeya Dwivedi wrote:
> On Thu, 5 Mar 2026 at 17:08, <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index d92cf2821657..cb80a3ddb7a4 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>
>> [ ... ]
>>
>>> +#else
>>> +
>>> +static bool has_arch_syscall_prefix(const char *func_name)
>>> +{
>>> +#if defined(__x86_64__)
>>> +     return !strncmp(func_name, "__x64_", 6);
>>> +#elif defined(__i386__)
>>> +     return !strncmp(func_name, "__ia32_", 7);
>>> +#elif defined(__s390x__)
>>> +     return !strncmp(func_name, "__s390x_", 8);
>>> +#elif defined(__aarch64__)
>>> +     return !strncmp(func_name, "__arm64_", 8);
>>> +#elif defined(__riscv)
>>> +     return !strncmp(func_name, "__riscv_", 8);
>>> +#elif defined(__powerpc__) || defined(__powerpc64__)
>>> +     return !strncmp(func_name, "sys", 3);
>>                                     ^^^^^
>>
>> The other architectures use prefixes that uniquely identify syscall
>> wrappers (__x64_sys_*, __arm64_sys_*, etc.), but "sys" with length 3
>> would also match sysfs_*, sysctl_*, sysrq_*, and other non-syscall
>> kernel functions.
>>
>> Looking at arch/powerpc/include/asm/syscall_wrapper.h, __SYSCALL_DEFINEx
>> generates names like sys_read and SYSCALL_DEFINE0 generates sys_fork, so
>> the actual common prefix for powerpc syscalls is "sys_" (4 characters
>> with the underscore).
>>
>> Should this be "sys_" with length 4 instead?
> 
> I think the bot is right, we should match sys_, that is less likely to
> include other non-syscall kernel functions.
> It only affects powerpc with error injection disabled.

Yeah, agreed, will update to sys_ in v2.

> 
> Other than that, the set looks good to me. I tested it by disabling
> error injection and things fail before your fix is applied.
> 
>>
>>> +#else
>>> +     return false;
>>> +#endif
>>> +}
>>
>> [ ... ]
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22725431483
> 

