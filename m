Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF73B8BCC
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393879; cv=none; b=Wauj0ZRKaAr2zlRQ9KrDNFqXHBilkN0TSdv7JvPrdtu6Z9bN9V9Cfrxb6fJdNBD+Y9SGNa6ZGmkAVo9fEBIBPW4Y3TYlJHrdVHdXZ/isUZhAtV55s84KrWI9R9Gl4EqOJt9JyZouSEp5RioPg63Hk/H+RKI4c8/tUdb6jlqKo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393879; c=relaxed/simple;
	bh=s90tIkVELqPNklaSpd1QLSvIpuysPB/xLBc1sF9f4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISid+2yxn+ex9njPDsfEqLR47bc24kDXyilDrifChRuZrXC6jxap1T56QsVfnE0ujh3aV3N+saniKjSpHBlk7qr5EA0jf+W1dcBnzmRusJ3DwX/lzT/YSSjiZ37afPFpymqjUKA9+xb3/L6XcvK40Mo4VpVVD797wdv4xNN21m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5c9sE/O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=muh7+qeS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5c9sE/O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="muh7+qeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780393876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FjL7duM8l41Z0v7GZVkKWyzIqulBaKY/N2An1qwlL4=;
	b=h5c9sE/OZjr/DwO/+Re7UZ8UeEhzp4iQsPZUG+kOkBSAtq3+3KwpYxHu7LMZ53m0XABiLv
	z25kkxDUj2UxQmN07eDdDlu8fQgse6CGwNBLuHMhpicBDS1KgOMxUtn1dWdsht9bWxTNgd
	hkECWOKdwVRLYL35rtu0BXXRCgEVgak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-4SHJ9eqvOfyB-zbUITNY0g-1; Tue, 02 Jun 2026 05:51:15 -0400
X-MC-Unique: 4SHJ9eqvOfyB-zbUITNY0g-1
X-Mimecast-MFC-AGG-ID: 4SHJ9eqvOfyB-zbUITNY0g_1780393874
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef55779d1so2234735f8f.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780393874; x=1780998674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FjL7duM8l41Z0v7GZVkKWyzIqulBaKY/N2An1qwlL4=;
        b=muh7+qeSE0WgYG9GrBXdkuBhOjHlmYS2Lanh/VEPft5eWUHlPtUcj8/7rXNQpk+N0F
         VZHSer7eIHOVdTXArcgzg4AJjGjB1mMT2dlT1omBF4by7T86R15afKzdLx/TyQh3mZHI
         dbARauwo4swRth2lXAxyugNz0wOTyPlLnnE9GWCyIdu1GYk+ctYYLsK63NX/6vxPY1/E
         W/T4hSZnxIzv03uk5dZM3V9DYsIWgQeqsE10tWY/twIOX33PyXMYWaeMYJDZjVIGjupY
         lr7tjK7QotsXg+VUMm3uZR+iBNvmEZRNYRqiZwHvln3ktNZbW4lC4iL5dTOy7H6ZzzMc
         b+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393874; x=1780998674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FjL7duM8l41Z0v7GZVkKWyzIqulBaKY/N2An1qwlL4=;
        b=bonlXjkPt80gPNR+c0n/BzkL+xV+VGniq//TDP0RPsHm0dI75H3RHK960a3sLkhe9z
         Hw/qFXhHY/JUg0s1ZWS5VrNaALGSU5Pwf/2q/k6C/HKnvzcjNevhht4s3rgqfxUSRWVx
         8hAD0WtxAAu8mZBKc5tb4LRYt6SqI3vGXpzNixCNMphXuBWSNOMkawsRWaOCfzVdSCLp
         IulOBOxsv/3M+KFVtG0RM6O6t8/BAZlkfT/tqVqyKrHryNsO1F79oUzGZsVFyFsYJrHY
         yPU3rUZOtb4Y1v7dIT1iVf6MRwvIgnK5b1aG7owgdvzwN8fe23g9EkhsiZXZ0JhCm/N8
         mF5w==
X-Forwarded-Encrypted: i=1; AFNElJ8T7sek3GzsI6F+eQxgClvBKH5xyj4/n1iAKVQIeIGIFNlVNplk4F0nVMXwrf05lD1IjWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzznojLEuq4dc+4+QlbA1dFY6ioS6wIs1HRZj8Tuo+iTK1GpVBo
	zSPXfkF24j3NRAOttTVu78ScZXanALJU10RT/kbZ0MPAGiTMjGEzAQsxSrAkzS/ZQtdvzIDuEyl
	Nao2ST9kYuh0WuQR1gdVeI712AlQxqA49RnMDfRe8GV+9ARs2VpvU/w==
X-Gm-Gg: Acq92OH14KBgXHfY6FgUC3gIhk4NZjYb3xvstkLG2F3pOxt0Z3jEuV1GnxBEhGENkeI
	mZIP1DXI9jCl1I0GRPvZ9omxb4reamaj4tKw3D3/LXhV7B3YQLIO/EuMXz6n5RBsGhjd61BlP2X
	lK1RjAHYW7mt0xZqqMFoMnG0orS9alKo2jCX++WTuzuKVUhzVcYgbykNLxpe/Rjsrqb3MtLYoJ2
	oOduJSlSYzAzpNhYOkjJAuSZlRivg6+8tlcladqkiGs8do59YzjeHwYcqXYqc/tDFSH7UQgPDdX
	pzdL1Sdqi6Hi3TgEy0ujPIxMcMQieedbH8ZnupJpZ3eXi4+0KG6Mf0UKw5KAJUiko96F839XqOt
	RpHFIA557NF3RQz2lj9luJXJqRdzIIqg1KGA5vw==
X-Received: by 2002:a05:600c:c098:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-490a2923cbbmr221352755e9.15.1780393873902;
        Tue, 02 Jun 2026 02:51:13 -0700 (PDT)
X-Received: by 2002:a05:600c:c098:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-490a2923cbbmr221352355e9.15.1780393873517;
        Tue, 02 Jun 2026 02:51:13 -0700 (PDT)
Received: from [10.202.148.228] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm53554265e9.6.2026.06.02.02.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 02:51:13 -0700 (PDT)
Message-ID: <939aae44-5901-4f2d-99c8-ad9bd5173f0f@redhat.com>
Date: Tue, 2 Jun 2026 11:51:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420134637.2513867-1-jmarchan@redhat.com>
 <f02fd939-85f7-414a-8b03-a9ebe56c7660@gmail.com>
 <836b0ce8-f427-434f-984b-4fc60b02c810@redhat.com> <ah6g7JSYOWGp2oAG@u94a>
Content-Language: en-US
From: Jerome Marchand <jmarchan@redhat.com>
In-Reply-To: <ah6g7JSYOWGp2oAG@u94a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 11:26, Shung-Hsi Yu wrote:
> On Tue, Apr 21, 2026 at 07:59:08AM +0200, Jerome Marchand wrote:
>> On 4/20/26 6:52 PM, Mykyta Yatsenko wrote:
>>> On 4/20/26 2:46 PM, Jerome Marchand wrote:
>>>> The file_reader/on_open_expect_fault fails consistently on my system.
>>>> It expects a page fault on first dynptr read of some range the exe
>>>> file of the current process because it has paged out that page range
>>>> earlier. However a lot can happen to that range (which depending on
>>>> the actual memory layout could contain text section, data section,
>>>> sections )related to dynamic linking...) between the moment it was
>>>> paged out and the moment the bpf program expected to hit a pagefault
>>>> actually run.
>>>>
>>>> A bit of instrumentation with mincore() shows that pages from that
>>>> range were accessed several times before the program is run. In
>>>> particular the call of file_reader__load() seems to fault all the
>>>> range in.
>>>>
>>>> Move the call to madvise(MADV_PAGEOUT) to just before attaching the
>>>> program to minimize the risk of having those page pulled back in from
>>>> under our feet.
>>>>
>>>> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
>>>> ---
>>>
>>> Thank you for the patch, the change looks good. Does it fail
>>> consistently on 4K page size?
>>
>> It did when I ran the test manually. On our automated testing system, it
>> failed intermittently.
> 
> On my fork of BPF CI the test was failing[1] consistently, even when
> this commit is applied. However I wasn't able to reproduce locally on my
> laptop when I ran manually.
> 
> Any hints regarding where to look and how to reproduce?

To investigate the failure I witnessed I instrumented the test with some 
calls to mincore(). You can do that to see whether madvise(PAGEOUT) 
didn't successfully paged out those pages, or if they were paged back in 
by the MM subsystem. I'm afraid that this test isn't very robust: the MM 
subsystem is the one that ultimately decides which pages are in or out 
and it might not work in the way that this test assumes.

Thanks,
Jerome

> 
> Thanks,
> Shung-Hsi
> 
> 1: https://github.com/shunghsiyu/libbpf/actions/runs/26807198259/job/79027625188
> 
> ...
> 

