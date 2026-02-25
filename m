Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418983921D1
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040299; cv=none; b=MgRvonPV6nGJ6wuxKQDfzF1/rHxamk5iriYIxtLW87w+11f5rvU0GL0ZJ53GJpDp4afqpiG7mPcqmBjYUND7bXz3PwOzdGEjvM47Snhh9CLBA2GKvEePA80e/GEWNiiDwgUywg5lv4HZYWq61y1hhYMal4TG8Dfep4wi7NS6aJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040299; c=relaxed/simple;
	bh=g694C3z1mR/MPBvKZfa01B9hP5VXTQlzidWBQncEwtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiUOeMKXv5f621duHRojpgyd0KQpscBreCQ9eJSoKfIOxQZZ0tOcfBG+SxTFNyB7WWWIHZcab3VQ94Rgpv5GUScqRAMRSnprgizPBN+5a9LpWFlJdGYHHJRNFwsIgJokRw8bSp958JhW7OuAzpqslYrO/OQbekgzmuIRHHaaufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VePKlV0+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VePKlV0+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so71705e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772040296; x=1772645096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7U/idi/iRX4NdL63SBTaFSWz/IhDdcMvBGwU/EP3OcA=;
        b=VePKlV0+zgqjg6yPhFwoLomhZnimvPNMYc1Gh+MFT/TebIVnyOHM0Js7QxbUl5JpiX
         wUscQ77gvB3/bk3gm/4AVMnZrFDZsztsvR67ca6gfXU9QiXwBg9hgIemb4jWYWebdofq
         WC7H/ysGOW31Sc3rk0CKjfmcv3rasQnWdIp0tlprU+h2aRL1oFm0Zm89cOgMSOBCtOgc
         ErOfDZVuhbXIwkNSJ6BlcUyyoC+BNSsQcOWSrO8nU6MerY1obp/TiSaLGMSlkfYf7uvG
         Pb0DRBm7qPPndoahrPQNUepHeGqErZjCQ0ed1vtTJLxxpLuC9E4oqLTs+B/vKxYLqB9B
         cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040296; x=1772645096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7U/idi/iRX4NdL63SBTaFSWz/IhDdcMvBGwU/EP3OcA=;
        b=UKnvs8D1MZh7tYTXDULmBBYkTeDAg9MfX1Ocfjp2AiTV/rKjODyfcL6/vFQn29G356
         iDZYiE3UxlGUXk0tK0wV/WAhFldagaXuj/1jqN/Wl0rOsCh/VIB2qZoFpz8zdC030X5T
         2rgYAIAKl4MpK+G0tK+ClErSujqiIIebcmjB5e4FGPgNqU+Rqq2fgWHRl2vtLhTUhtkL
         WZIbut2zhcBYCa1XJYjA2PRc/+IRkCAyOnx666xMFYRT9ZGZCxEmVomffHbfIeBkN2pf
         e69YJvwzkCTTlvXd+BYHCIDBEU/X+uZcgyVebRz7rlD59l6kkWbJ+8nyN6vQegN2ohoS
         wH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVX3vlGRh/a6jb9lXyhslsu1lf53VkW0Ojpeh4ZXJcRNdusQf+IOBnmCmGWjNKNq/O51R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrpA7byIVL4/Zvp46h7Oagktq0wdrwMlDXXbmUmdzJCJyMyG+3
	xGnx5LtUXGZjXM3G+GqI1k+61veFW4iL/pTtdMRTfv79NQiJQShFzCl/
X-Gm-Gg: ATEYQzy8oHLdY80SC8TBVEjCA872r4puxb3Ia6XH0YkqBuPzme0wA7Zts5FF8JjlkO/
	5VV8gc7sJHEoHUQeNcX6fVznulhfQyfqp9meCoNUGOgteHb78MQg5iM1sph5xkLcIUTO5lZEVDj
	BOWv2xxVdQWn2CkhvZrNCTPZn1oREodG4boN9Cb+2ETB47RXM3OZ9GKPqEIyLBw7myMcc/rO4qo
	yXTYzcyWusKxneV3xwtWGYWUqKEIbK9+++T+XRN701t5POilTIf/8NIl8Fsd2c3r0UjMAUfTqRR
	FoSE95k4gHSZTp5QHsj6DNEhkgFN+XEBdScbovQQ8m/SxQF39V86ZkDl3y6cfQmGyMbwk5ByV04
	XVKJf4pitiiE+mZYLqgD4Q6UR1+6RjurhnnTzNSYiUf9HhQiuwwKDim/przb3cYgzPC3F63QTKW
	xPhJTNzZLlakr1+RFp6YzH0Zn8/UyWx5vQEgltUFn+N71WFf029YvGITjdcjCN6hzlsChvOg3Fx
	sZRJVc7oYDvFgggnhgRUD7SvNmZ0JOKd1BHWzdij/vOzbM37wTFVkjzH/LbLuGBG+7XZpIkOnV5
	tQ==
X-Received: by 2002:a05:600c:c3c1:10b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-483a9605cd5mr260176515e9.35.1772040296314;
        Wed, 25 Feb 2026 09:24:56 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm28613875e9.1.2026.02.25.09.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:24:55 -0800 (PST)
Message-ID: <74553709-23f6-4e7d-a7af-b2a9e509cf70@gmail.com>
Date: Wed, 25 Feb 2026 17:24:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] extra io_uring BPF examples
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <cover.1771850496.git.asml.silence@gmail.com>
 <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
 <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com>
 <a7e1f667-04ba-4fe5-b21e-8c47e68213d3@kernel.dk>
 <b22117fa-84ba-4f9d-982a-bbaaae35eebd@gmail.com>
 <CAADnVQ+8VM8-G3X1UT8_t1tt5=62fxqknHPND40JNsQ51P_XVw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQ+8VM8-G3X1UT8_t1tt5=62fxqknHPND40JNsQ51P_XVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/24/26 18:54, Alexei Starovoitov wrote:
> On Mon, Feb 23, 2026 at 7:06 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/23/26 14:39, Jens Axboe wrote:
>>> On 2/23/26 7:32 AM, Pavel Begunkov wrote:
>>>> On 2/23/26 14:14, Jens Axboe wrote:
>>>>> On 2/23/26 7:11 AM, Pavel Begunkov wrote:
>>>>>> NOT FOR INCLUSION
>>>>>>
>>>>>> Alexei asked for extra more realistic examples. This this series is
>>>>>> based on top of v9 of the io_uring BPF series and implemented as
>>>>>> selftests. There could be more, but I stopped with 3 that should
>>>>>> give an idea how it'll be used:
>>>>>>
>>>>>> 1. A QD=1 file copy program that show cases state machine handling.
>>>>>>
>>>>>> 2. A BPF program rate-limiting the number of inflight io_uring request.
>>>>>>       That's a good example of what users asked for before but seemed to
>>>>>>       be too niche to be plumbed into the main io_uring path.
>>>>>>
>>>>>> 3. A toy example of how BPF can interact with registered buffers.
>>>>>
>>>>> Let's please keep examples in the liburing side, where they can be
>>>>> with the documentation too.
>>>>
>>>> I got you a liburing example
>>>>
>>>> https://github.com/isilence/liburing/tree/bpf-ops-example
>>>
>>> Right, but that's just the nop thing, which isn't really interesting
>>> outside of doing basic verification of yes indeed the kernel side works.
>>>
>>>> but need to sync with the selftest. I think I'll rather keep the rest
>>>> into a separate repository instead of adding all helpers to liburing,
>>>> which will inevitably do similar things but deviating in API and
>>>> internal details. And it's simpler on dependency management instead
>>>> of requiring libbpf / etc. for liburing. I wanted a space for
>>>> misc io_uring bits that doesn't make sense to keep as core liburing
>>>> anyway.
>>>
>>> liburing should have support and documentation. It's not that hard to
>>> check for libbpf in configure and either build the support or not. Once
>>> various feature support ends up being fragmented in the ecosystem THAT
>>> is a mess for users, I'd much rather have it consolidated and deal with
>>> it on the liburing side.
>>
>> What kind of support do you mean? Installation, removal, other BPF
>> management is all on the libbpf side, e.g. skeleton open/load/etc.,
>> and with it generating new structures for each of them, I'm not sure
>> how to make it into some generic API whether it's liburing or not
>> instead of making users to fill in the gaps, nor I think we should.
>> As for figuring out right helpers and abstractions for BPF program
>> writing, it'll be a gradual process, and I'd rather have it
>> separately, it's not like I can reuse liburing for that.
> 
> The cp and ratelimiter examples make sense to me.
> The 3rd one with xor kfunc is a conversation starter.
> 
> Since liburing already has "cp" in examples/
> I have to agree with Jens that "cp" as bpf prog should be there as well.
> Spreading the examples across github and kernel tree won't work well.
> We learned this lesson with samples/bpf/ long ago.
Urgh, that's the reason why I don't want these 3 to be merged. Neither
I was excited about wiring any examples as selftests, but you asked for
something that can be posted together a while back, and I obliged. Maybe
there is some misunderstanding? and if nobody needs these selftests, I'd
rather drop them entirely.

Ok, I'll copy paste the cp example to liburing. And there is no BPF
support I can add to liburing as it's all mandated by libbpf. But I
hope nobody says that I can't use io_uring outside of liburing and
anything and everything should be shackled to liburing, there are
enough examples showing the opposite.

-- 
Pavel Begunkov

