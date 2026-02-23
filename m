Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9E288C3D
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857569; cv=none; b=dcmvRh3b82Oe7EZb/8DDj4LQYWBSbrC6t5VQC1PirBgpZU0UBx+wXCK71ayE9xrAqpX9shV9gupmgFeNdu03+DQp0KedY9Dk564qb9tu9I6ufHL1PITcYNWIKMdwyu+ED9t1ITDPh41YszyXiH7F29tmNG2ANtFb/Jm66yLPHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857569; c=relaxed/simple;
	bh=n1/9s6DtSYcJy/UIt9UlZ8z+Vd1Ss6EwqYKjwqJpEyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP7iH8HgahyT6mgQIsasy54VN6t+fcOmHmbZ+YzeY1LUD7qoUUP72HzFrhZCc9SS3wNI6IU5O19RiNkinTMrYNg+nMTOflkuwehiyNpr2Q8/xgyqA8AFdfu9CYwRZEAAIZZt1gGlQnfSI8XI8cwm2rZTiO9XUeC264QaZPhDrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YruVImNw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YruVImNw"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4cb7e10efso3730748a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771857565; x=1772462365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPdrQ0UNYgw0k0lMo87j2lc39zDlBO0R2EUnBXNHeKI=;
        b=YruVImNw5d8NJzPZmdecH55fP2SiBgIfwd2X/9LTIme6AHro7Hna1ITDAm1c2XiD0Z
         F/PyY0CHsF1i5xjA5f4HOVUcEkhiYeHe0c/T/wpD9Fw447/+FEkeGJ5lJP6dZlDEPsq4
         Mf+V/vEgdb2ISr8Jmn433KLvuZqBcwd0lJbxEC49xzIu+3+IQNI4AgBtrsReWXOwlwCT
         03uuGaoZS02j24rGvPbHd+SG/vZJzheMsYtifbck2gZXZMwehCZ+ezWgPVEW9bm48iKS
         3w4dB7CtQdTIj6cwBIDa1wWqK9eiBVc/zPeGDWMyB2pFDLsXvKiTb6pCC6bnDIOwdtkR
         0IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857565; x=1772462365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPdrQ0UNYgw0k0lMo87j2lc39zDlBO0R2EUnBXNHeKI=;
        b=lZsr624mhyuvDUGCD/SA/sdulrXr6NZzzOGhv8GT5L9emMXA38Um6BnwhCD7NRLaKV
         e6eb48tDgs0Cr9hhxet7xhsqHW5TklreevPrJ5PD5d21ESyB5FmBys9cquhbHzLohLAA
         cFofComYWsqkp6O8AmhHNQEiVivxNKLkYrd+4s5r6Gs6qHHrorIVWTucIxVYaZUZxELX
         O2jIZBwaqDit9VyGmVJ17iORGq8kiOlzHzYN2At2q8UAU5SQ2Urs+5XBBRSulfi40Lwp
         3xQdvKcBh1W9/8r6bRy3+GnIIOSr35l+n2uU2SkJUzXs55mkI/WXOq6BV8Ag/dVsmtle
         4a2Q==
X-Gm-Message-State: AOJu0YyEsCGna7aFxpmX8sycPldURYfKJ26sFSfOCYz8oIrUTqwbngn4
	iKopRoiCTNnd0zH2fRU6z4AcH5cDqj7F6JhmO3oEr2AzKR1FPQOxFtk4Z/cBscFR+vw=
X-Gm-Gg: AZuq6aLEWF9wV7YiQO8NiRICe1/9nelKgwQQqMHw349/Q2czwdrhUfXY4J8zqq6SBW5
	LUA9Po584rMwtFq/3o6n1ZgAdCfYP1dDXPzsf2X1E92YgNulmcykliMNldnH9H3vMnQC8chRNLC
	yh70WxNi3Whea4QvkAc+K7Z/aM8tiMYRuz0xknoQlkHsDxn/RG+KvnJeQGXbzMq+DEgRjI9v/+n
	SIb0f0HCMae/bDUBppISx6wyiTyyhcpjW05RA1E9FehNbM1y3vm1w5lIWh1N76wM7vRceU0Dm6+
	2k4Nn9e8OLD6X6q2YTEseWmXGaSPNOfRV3C6jrPThD4yKSZlL4g1gq4H+er2U7+DbuC/kZPOkpH
	ckCdEvaIvFZlUjszL1pHEyPYFb3SYuafGiPkk77bf8mihiZF4Z+fy6EhjH1x8HHb6pxJtEfnjAg
	1uU+6cp34d5w4x9QI/BtBCSAGzFzEp4NjZ67U1c0a5JqA8Y7hDT1T0vv8pAVAWbi+JnmHvgwQVx
	PzZMf3XHg==
X-Received: by 2002:a05:6820:2d0b:b0:679:a617:ed0b with SMTP id 006d021491bc7-679c446e96dmr5207128eaf.27.1771857564992;
        Mon, 23 Feb 2026 06:39:24 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c5644224sm6188499eaf.6.2026.02.23.06.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:39:24 -0800 (PST)
Message-ID: <a7e1f667-04ba-4fe5-b21e-8c47e68213d3@kernel.dk>
Date: Mon, 23 Feb 2026 07:39:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] extra io_uring BPF examples
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1771850496.git.asml.silence@gmail.com>
 <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
 <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 7:32 AM, Pavel Begunkov wrote:
> On 2/23/26 14:14, Jens Axboe wrote:
>> On 2/23/26 7:11 AM, Pavel Begunkov wrote:
>>> NOT FOR INCLUSION
>>>
>>> Alexei asked for extra more realistic examples. This this series is
>>> based on top of v9 of the io_uring BPF series and implemented as
>>> selftests. There could be more, but I stopped with 3 that should
>>> give an idea how it'll be used:
>>>
>>> 1. A QD=1 file copy program that show cases state machine handling.
>>>
>>> 2. A BPF program rate-limiting the number of inflight io_uring request.
>>>     That's a good example of what users asked for before but seemed to
>>>     be too niche to be plumbed into the main io_uring path.
>>>
>>> 3. A toy example of how BPF can interact with registered buffers.
>>
>> Let's please keep examples in the liburing side, where they can be
>> with the documentation too.
> 
> I got you a liburing example
> 
> https://github.com/isilence/liburing/tree/bpf-ops-example

Right, but that's just the nop thing, which isn't really interesting
outside of doing basic verification of yes indeed the kernel side works.

> but need to sync with the selftest. I think I'll rather keep the rest
> into a separate repository instead of adding all helpers to liburing,
> which will inevitably do similar things but deviating in API and
> internal details. And it's simpler on dependency management instead
> of requiring libbpf / etc. for liburing. I wanted a space for
> misc io_uring bits that doesn't make sense to keep as core liburing
> anyway.

liburing should have support and documentation. It's not that hard to
check for libbpf in configure and either build the support or not. Once
various feature support ends up being fragmented in the ecosystem THAT
is a mess for users, I'd much rather have it consolidated and deal with
it on the liburing side.

-- 
Jens Axboe
