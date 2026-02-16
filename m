Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4D1E32CF
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251812; cv=none; b=nezHVYh1aq/CQfu2W5TQJRn5507fIKek+MF1+KttJuN1NwzOvgbtRaKLBrzV3RyOTJUXQY6WiicDs5fovaK/Ml02RYjx6t7y1NpDIJuBgTsw3U1o0LK4NYZDf7hgLU1L/idw6oIE5zDIYuP/8KAsnKAsRf+QWIpPZHprrUv6s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251812; c=relaxed/simple;
	bh=mfggzwf4B24n5rxC+2Kqv+0KmscCssNKpMcRD6aHq6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAZKT6Ig40NdWi93DyBVrYc++379UqjjW2+jfRS+4mcXp1ARq7e5/F1FHZS3RuX8mCetGtYOvNB5ihZAuAOARXtxN6860YDFjbJo2qjl/l+VLCoCUYHn644upshebg2TfoK38b25WgMPZi4cvcRWgySkS9yjbom/xgjME/akIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itcbTZv4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itcbTZv4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f2599980so35626915e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771251809; x=1771856609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZfg1XdomPhbX+ZkmR1M/ky2W6FGRkuZqY2dALiobXg=;
        b=itcbTZv4gdVVHgjZ2caaTRvz8oUFs080vuvSjWimuxqZLDAQRiy+2y7ln8MEv5ppXR
         gacvBYKyZUGYinTQc8AEN04NPUn6fndlJ6XwnrY0uMQhKvHGgfNC+4ZS20N5DVMKYGVE
         1y0bUGh9BwPHYyGZx70yWpebzzEgKzwIxYowkEZLUw74yNsKCUUwCQRY1RW7dOy+IXUX
         lEgCyNSBzRRdBd2UZwjq8KWrSFDiD3tTgYHxAaULwt0Un0KpPhMDsn5GBNZbqpZ9Za4q
         xzrDk11nN2ICr6aOV1kAgyM6MgPj9qcX9UkDA+UZb4x6/B6iAJbBpRVZO8/HXWJYITEi
         5JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251809; x=1771856609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZfg1XdomPhbX+ZkmR1M/ky2W6FGRkuZqY2dALiobXg=;
        b=DfLfWbL/e+qK4fUHzAf5/Z9jU2M+uXpPBulmsRbEJSv/FISWMDdv0fl6NggwoTMjT4
         qfZsQB7EcRccQOs5xrKvi4xJc11yorjr0oH1CyihdpE/wxcshruMdbk52ytnTxviR3HO
         gMfTkKWusqjxGTzb4dcDUQFjqGMZ+DSPg2Os1R4J7CL0sbsfXbaT3zE62BwkGdMZH6Hr
         HCofBeZThh/JYrQG70mAUaDMTJj9ajTT9KUyTJCmKRuC9mHv4n0ksN2Tr1zJd+V8akMu
         wh8Xa7uFihzXcjkjPZuKMES4F+Oz/hErN2HLXIcoCFPKXp3jJriPZ3hHCMF6G8qOcByN
         PaDw==
X-Gm-Message-State: AOJu0Yz9KtH+2B0tS2bVLQPpdKxECDKOEbopENmAoNsjeN/6ucnbWwiW
	FEwg+e9E8jQuPW0fDW9bXuVK2NwLZKi0jqYgjhfEakDY/nGTqWkAbeuDx8GQjwxx
X-Gm-Gg: AZuq6aL4NRlMiDnfYcBAEWWoB48sp3rCAbJNIwp+RirIUHYZ3MPgsSVDOsR7zjeCbtz
	ygIx/HAZv6ufxbcJLxSvxDoQyIOmcdVBhd1Aep+7/Ilz8lZ18oMCTzPNCRnPogIeXt9hgMEe0bu
	Oa52kDt3OIk9UGOHcEYHiS5aV146a226nMVP0yIYDPKq8mTjZochSpTcrb2fqfhPRF7nY5ndQMW
	Y5AuvhGgDs0hXu5G7RYoPXx6vm4Mw/8rTvtP0+S43PlCyn5MkBEtByO+U4lvO/kfJ1gwi5AOfBH
	TaI0KLxOgX9la07SQ9GGrdNRfHbdfgyLD7tl3WzPCfB51/3TYwmMvGdE9o4bH1jtjqKr9thyt5o
	414fk3kbqnPZItcRXl5IeubMUvCNLkz0b99QNDxnqvmQPKvEp1S2dvx2h5cZ30uyr8YQYw5kyvE
	cuHWFV1QqJIa9r1e+w5CKJorg4QF9XP2YgMUAMvpSUWTa6ko25qB2SxDzFTNbDstD1/moh9uX2C
	A5BBDdCZMbx6gSqqB2IkBV3jIi8QC30O/sIXJKjvCDXvfYomS8am9EvAA==
X-Received: by 2002:a05:600c:34d4:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-48373a1611fmr180172595e9.6.1771251809077;
        Mon, 16 Feb 2026 06:23:29 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a3eb7asm130801345e9.1.2026.02.16.06.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:23:28 -0800 (PST)
Message-ID: <d56b5f70-382e-4017-81f4-c9ae7a6c1b56@gmail.com>
Date: Mon, 16 Feb 2026 14:23:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v6 0/5] BPF controlled io_uring
To: io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, axboe@kernel.dk,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1770836401.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 19:04, Pavel Begunkov wrote:
> This series introduces a way to override the standard io_uring_enter
> syscall execution with an extendible event loop, which can be controlled
> by BPF via new io_uring struct_ops or from within the kernel.

Let me know if there are any concerns or comments. There are some
parts that I'll need to add like timeouts for waiting, but those
will be natural extensions, and this feels like a good base to
move forward in general.

> There are multiple use cases I want to cover with this:
> 
> - Syscall avoidance. Instead of returning to the userspace for
>    CQE processing, a part of the logic can be moved into BPF to
>    avoid excessive number of syscalls.
> 
> - Access to in-kernel io_uring resources. For example, there are
>    registered buffers that can't be directly accessed by the userspace,
>    however we can give BPF the ability to peek at them. It can be used
>    to take a look at in-buffer app level headers to decide what to do
>    with data next and issuing IO using it.
> 
> - Smarter request ordering and linking. Request links are pretty
>    limited and inflexible as they can't pass information from one
>    request to another. With BPF we can peek at CQEs and memory and
>    compile a subsequent request.
> 
> - Feature semi-deprecation. It can be used to simplify handling
>    of deprecated features by moving it into the callback out core
>    io_uring. For example, it should be trivial to simulate
>    IOSQE_IO_DRAIN. Another target could be request linking logic.
> 
> - It can serve as a base for custom algorithms and fine tuning.
>    Often, it'd be impractical to introduce a generic feature because
>    it's either niche or requires a lot of configuration. For example,
>    there is support min-wait, however BPF can help to further fine tune
>    it by doing it in multiple steps with different number of CQEs /
>    timeouts. Another feature people were asking about is allowing
>    to over queue SQEs but make the kernel to maintain a given QD.
> 
> - Smarter polling. Napi polling is performed only once per syscall
>    and then it switches to waiting. We can do smarter and intermix
>    polling with waiting using the hook.
-- 
Pavel Begunkov

