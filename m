Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B822D73A7
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823456; cv=none; b=Hv3gh0GkGlk42irNfv3mnWaXNOmbq+gaXOA2cRieDaSUGGSEqihn/ST4PB82geAnXAkgIOWVqgcrO7xKDGJ6g6961KF6MbQd62hy7jEIGk2KSGXsasb/J1KqwI+50O74irwbxOQFLLi1JIjRC+iIRcmztTUxIfq7O7MJnO0w4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823456; c=relaxed/simple;
	bh=JS7ohpi1RwHa77bCw2mOVDcnTq8a7HMj063FECOPl98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq2xz2hJEnFALx+Rxs+8d8kfB1tu1qNOsbUy5iYOdt4UETgSa6sgvHthtVaQ+sv+uUBUNP7Sc1XoerrtumpdWmV1Efz8FMmr8GsZ/qpQVJpX9mwpbxSHj8pZ4cGIfl+FXaTeTl+oaOQC2wRyb0dJu3KeKccmI6AZzpJr7zOA31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FuAT9i56; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FuAT9i56"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c8e85deffso1890995b6e.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 07:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770823454; x=1771428254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbv7ZWpqWnVcv/zNcFe4HRudUWSEnWJCsMiCHlnLvJI=;
        b=FuAT9i56S5xeHocqQkvMqtjGAIypSmGTJqkdHs7FpCGoOQ2s9V9vX+Khz1ulf/4LVe
         BJdBrVepCvkL2Mgk8Q3b7OJ/v5L7lcpGprQMfVjRM9G1KPXtGTz9od43hAmDHNcMeLNS
         S08Uv5Dv/TAR+Mis4QPZEODnoo/AqrM1m0vIkLAH1zHQZjagaGRi3H8ahtFjpURuPnI6
         ILTv0hE0R2avMhzI8cbq14Xq1ChzBB77Y95D7nAYP7+Xlh5J+goQH1fQhOE6W435VMG1
         lMoLNNiRds1xvp/Sq4v0+5oseU8BWdbg47+fuwyNzXHsHnKOwNoip+gabmJ3PWh4//nU
         hh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770823454; x=1771428254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbv7ZWpqWnVcv/zNcFe4HRudUWSEnWJCsMiCHlnLvJI=;
        b=Re4JMYI2XQcW+3n32OIsta8ur6PN2OGokZUIn1dlv/Id1kTEDN+sPhGNoxHZwdHA09
         z+/VLKIBNT9XlQ5Dqa8qONrpthhXPQtf54e9iYLrrLUMb+ZyleQFdRBcLHjZMFXN81rx
         qOTA70YSD7MMkXZFUPbyDNYHVdZTt79jBfnCeEhXrD4dyEQqnDSAm+2lkLH3qh4ewZDU
         mlM7rH5xQzuymtL4NLbps7kPLAS70QbL8IWbmx/PJoVuS6A7SFXGnfXcendyTs2yEcOj
         mwt7Y8mYOWjELbrk/hAWuY3/MsrTRiZf4GxZlKSaGBn618Psmg2CEdpH7Ut0EVyhAkh5
         VFCw==
X-Gm-Message-State: AOJu0Ywa3/y31jdZYLR8hSMkZ7jAclw32tvGtznBSLgEnxkznG4EGjPR
	fK0VwdG/qEFKAfeeFzT0OAneoP+YDMpQ5weUWQH28W1O8n4gTLq5yK5tvLXdJUHMsKBfExNBrfk
	vpt94QNE=
X-Gm-Gg: AZuq6aKyB4tcBTzJstkSt8B1i5hx2E/nakEstTHwOZSfL2y7WDXA/wSNenWyNzbWYA8
	Kg5dmr6cN2S5fZGg96dnENY8nsN5vM+JObptiYk1+GlpmgQGyyueXrUV5Ce0pLR63CtimOMvQxY
	Eg8NfLTQFI7/eJWsJ5x7Zev16EndWYDVcJV2h6dXkQSCJa/uG/Yy0cx3rDgp+VTHSE826fXD+n5
	GGn3B+wfcEHJekbUO0QzTzASVO8LLqZGd3ejclg4iE7fhkgO+r3HlxOvsnmVYyaDKilnUfBHH7X
	Hw74TKIwF1p94RvNZ7sZhXtGps8Hheu4yiUWFDEcn96nq0toYSYt1OCi1b1KzrooyB+1PGm2TP1
	v/F2MpEli9QjRDPrsoyuFWPb5aDnUhQUQkFhK6OJOd9Nn9bt26OD/zvFmVTEz9RpRB4NkiR9332
	lWivGMSaQ2gKN/bG8boxQAk2juixuA85eU1LtEHTsaMSsxYa2hRKr5vCxwv/AmpXDzoY+jNILIV
	kQYrHsHvw==
X-Received: by 2002:a05:6820:1524:b0:662:b608:d5ae with SMTP id 006d021491bc7-6743daa47b0mr1243856eaf.57.1770823454131;
        Wed, 11 Feb 2026 07:24:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67475dc40d0sm1021335eaf.13.2026.02.11.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:24:13 -0800 (PST)
Message-ID: <90c1f09e-9334-4036-a6be-ad7d2f91bfc7@kernel.dk>
Date: Wed, 11 Feb 2026 08:24:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v5 0/5] BPF controlled io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1770818588.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 7:32 AM, Pavel Begunkov wrote:
> This series introduces a way to override the standard io_uring_enter
> syscall execution with an extendible event loop, which can be controlled
> by BPF via new io_uring struct_ops or from within the kernel.
> 
> There are multiple use cases I want to cover with this:
> 
> - Syscall avoidance. Instead of returning to the userspace for
>   CQE processing, a part of the logic can be moved into BPF to
>   avoid excessive number of syscalls.
> 
> - Access to in-kernel io_uring resources. For example, there are
>   registered buffers that can't be directly accessed by the userspace,
>   however we can give BPF the ability to peek at them. It can be used
>   to take a look at in-buffer app level headers to decide what to do
>   with data next and issuing IO using it.
> 
> - Smarter request ordering and linking. Request links are pretty
>   limited and inflexible as they can't pass information from one
>   request to another. With BPF we can peek at CQEs and memory and
>   compile a subsequent request.
> 
> - Feature semi-deprecation. It can be used to simplify handling
>   of deprecated features by moving it into the callback out core
>   io_uring. For example, it should be trivial to simulate
>   IOSQE_IO_DRAIN. Another target could be request linking logic.
> 
> - It can serve as a base for custom algorithms and fine tuning.
>   Often, it'd be impractical to introduce a generic feature because
>   it's either niche or requires a lot of configuration. For example,
>   there is support min-wait, however BPF can help to further fine tune
>   it by doing it in multiple steps with different number of CQEs /
>   timeouts. Another feature people were asking about is allowing
>   to over queue SQEs but make the kernel to maintain a given QD.
> 
> - Smarter polling. Napi polling is performed only once per syscall
>   and then it switches to waiting. We can do smarter and intermix
>   polling with waiting using the hook.
> 
> It might need more specialised kfuncs in the future, but the core
> functionality is implemented with just two simple functions. One
> returns region memory, which gives BPF access to CQ/SQ/etc. And
> the second is for submitting requests. It's also given a structure
> as an argument, which is used to pass waiting parameters.
> 
> It showed good numbers in a test that sequentially executes N nop
> requests, where BPF was more than twice as fast than a 2-nop
> request link implementation.
> 
> I've got ideas on how the user space part while writing toy programs,
> mostly about simplifying life to BPF writers, but I want to turn it
> into something more cohesive before posting.

This looks nifty. Do you have a repo on the liburing side with some
examples to play with?

Nit on some of the new files added, not all of them have SPDX headers.

-- 
Jens Axboe
