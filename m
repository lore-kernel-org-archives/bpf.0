Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7E3E6DD3
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407027; cv=none; b=SOAODADsaJgBnDvL8/xjsHCWOM20l3geXIW8j4Bv4Itqjxw/463qgFnfievsbcRwdruLrFy0Tdr+Wc8+phd8Ctw8C+/ypEuatlgrK/kZdiTeanOzEXFRV7afFVZOC6dZhS8AYH2zjURisZCfEHCxVaQMdGG1JCG0YFChxrDed2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407027; c=relaxed/simple;
	bh=SitCQ9zThQAtGcEa+tRdZdKq/jWeXPhLMXixdM3Cywg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMzbAIkKYWfsQ+V6p67xLoQ+sOa8K0azSCkPH7Fszs65sbqa5iuiqGft88q+ks5bLxK7vyVwrQCNdE7moE0kcjfqrnPox/DDEYMCU1ZN7DMBGBt8pqu3zz8ESMHg4PwmLEe5z74Hkv9grc8gYTJxjOpzu8z0+yPk/Z6XKD7EOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHKROyBb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHKROyBb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so13653905e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407025; x=1781011825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=px5683SUlyJ1WXtEe80xKFeQYckWTBD6LaRrb178pOo=;
        b=OHKROyBbgILPzC2Tk226dblWCwlfF4n0L2+taVutUo/TYOT7Non6/k2xHRq0e+pGBv
         aUEUlLlDKQzWwec7+OUyb3cJzDUh9QCQeaE2hPnk7/VZP3XZ86yhz/tAvXvCYAAaHDSD
         EYp0G3CJIrJopITGi3iT61Berozi8VsOxteBMiyPm84dOpO6n+HU9r9esz9LHcQF3s27
         ic9l0UhN0CGddz3CS0HYgRRZYAsD+1p0yZ1KYCUbpBR6j1vdvYrMgL4zHUjhenoklovz
         VOTJi0BuU9mTzM9qyw+S7jtzYsbRhsmX0F1cvzvUjgecJlxwRqfIpPos0LjfQSzXlMkQ
         UgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407025; x=1781011825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px5683SUlyJ1WXtEe80xKFeQYckWTBD6LaRrb178pOo=;
        b=YW2QOKI1GLYdNVQRD2MupPP6fihFNrcOtyA4InNwoh3LdtY1csYLasS7v9kvdRJow8
         bqIG0HPkHgA39yKhqJgomDFoeKNOyS+UA0W18B2h9gLG3R+aZXdwEELPx1cvzX8dTmUM
         ZDMmvhsZWNgW5GFeV5xCj4k7vIPwWCeAm4FzOfFNucL+pn7CpXwDeYAsoetXDx5ZGe6t
         /Cu10d5Oh/ZOfejaq4LiW/zdPg/G33Gac/jRIAvAcepDTBvMEBVDe2x0b1u6Hn5l1OMk
         fMvMWpaQm2jbbruLXvXgenPgoqifZZsPrddYX4vkW0zW4WZoqasV+rUrlsB2+sa96YMX
         MQnw==
X-Gm-Message-State: AOJu0YyeIJmMYA8bMqwVB3UNgafGxNtQHeTIcWNVhyl0Mx/htllcCQNQ
	Xo7i7kIeIVK4pV3Db5wGElohYE7tJ8kKiuA9FKYJJL45HqIwaJ7McvMT
X-Gm-Gg: Acq92OEBiEXsk9hRUNlIMLTyE/SfVYCxCzfaS/+2/DSNYRxBUdbotC5W+0heg15jFvN
	roKNVVC36Nk38pbl+pC/5c8fsdl1cU3dH0gBQNJaQ0YQP7vCLTG9soVKZr/EN6yOF6WGPIh1s0x
	nTbZk2LfbQxcBaQ8f3aifHNKt8dtEwS6eZVclaByVvXy6fznSTCAdIQXTZf+i5Kby4fDv8qhHSN
	EX4pNBcZI1MoQq+8AawIVSomyHTDiVIsqzXOzt6wyOq5d8a2CzFweIk/B3HRPiGSr0c8+fnF4ij
	2BxLbVgtsL9ohglwz4DtDHoLPHQro/6f27ArHTLDjTk7FInutCrTPvfPjlU3BKqWzpILhNCVl/8
	f9GeIxZNouisAEZq2zrU4e/HcjyEvrXhJI2IyrIMl2Ybujw5xR+vzdL0W0d5RXOo1k81oROpbI1
	DMBqG1Pqj0XFJ4Vngdp3+sB1xx8osfBWMNpHYA/CvutQ9jBG1aR73SII0kgCBBUWjiAH8veR2Zo
	YiGtx6zwc6eAwRsr5QuVA==
X-Received: by 2002:a05:600c:c108:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-490a290db4fmr248807115e9.6.1780407024589;
        Tue, 02 Jun 2026 06:30:24 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e0f343sm70579915e9.1.2026.06.02.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:30:23 -0700 (PDT)
Message-ID: <be8c41c9-17c7-4e1c-87f0-9036b0de4b58@gmail.com>
Date: Tue, 2 Jun 2026 14:30:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
To: Jerome Marchand <jmarchan@redhat.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420134637.2513867-1-jmarchan@redhat.com>
 <f02fd939-85f7-414a-8b03-a9ebe56c7660@gmail.com>
 <836b0ce8-f427-434f-984b-4fc60b02c810@redhat.com> <ah6g7JSYOWGp2oAG@u94a>
 <939aae44-5901-4f2d-99c8-ad9bd5173f0f@redhat.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <939aae44-5901-4f2d-99c8-ad9bd5173f0f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 10:51 AM, Jerome Marchand wrote:
> On 02/06/2026 11:26, Shung-Hsi Yu wrote:
>> On Tue, Apr 21, 2026 at 07:59:08AM +0200, Jerome Marchand wrote:
>>> On 4/20/26 6:52 PM, Mykyta Yatsenko wrote:
>>>> On 4/20/26 2:46 PM, Jerome Marchand wrote:
>>>>> The file_reader/on_open_expect_fault fails consistently on my system.
>>>>> It expects a page fault on first dynptr read of some range the exe
>>>>> file of the current process because it has paged out that page range
>>>>> earlier. However a lot can happen to that range (which depending on
>>>>> the actual memory layout could contain text section, data section,
>>>>> sections )related to dynamic linking...) between the moment it was
>>>>> paged out and the moment the bpf program expected to hit a pagefault
>>>>> actually run.
>>>>>
>>>>> A bit of instrumentation with mincore() shows that pages from that
>>>>> range were accessed several times before the program is run. In
>>>>> particular the call of file_reader__load() seems to fault all the
>>>>> range in.
>>>>>
>>>>> Move the call to madvise(MADV_PAGEOUT) to just before attaching the
>>>>> program to minimize the risk of having those page pulled back in from
>>>>> under our feet.
>>>>>
>>>>> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
>>>>> ---
>>>>
>>>> Thank you for the patch, the change looks good. Does it fail
>>>> consistently on 4K page size?
>>>
>>> It did when I ran the test manually. On our automated testing system, it
>>> failed intermittently.
>>
>> On my fork of BPF CI the test was failing[1] consistently, even when
>> this commit is applied. However I wasn't able to reproduce locally on my
>> laptop when I ran manually.
>>
>> Any hints regarding where to look and how to reproduce?
> 
> To investigate the failure I witnessed I instrumented the test with some calls to mincore(). You can do that to see whether madvise(PAGEOUT) didn't successfully paged out those pages, or if they were paged back in by the MM subsystem. I'm afraid that this test isn't very robust: the MM subsystem is the one that ultimately decides which pages are in or out and it might not work in the way that this test assumes.
> 

thanks for the reports, this test is indeed flaky.
I'll take a look if it's possible to fix it, or we
should just delete it.

> Thanks,
> Jerome
> 
>>
>> Thanks,
>> Shung-Hsi
>>
>> 1: https://github.com/shunghsiyu/libbpf/actions/runs/26807198259/job/79027625188
>>
>> ...
>>
> 

