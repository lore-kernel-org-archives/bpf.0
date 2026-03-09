Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DA3BED00
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062692; cv=none; b=T4JEmyciNlv5i61Mb+endIyDu4AGSgLXMn7iSG2oqO5maPfcaviyHIV2sMUdiNsVEJ7l01n4wWgCldCaxNF6/oKmOM6+yUWaE+SMSWBQQTISmWUfy6lVZCfFMTLtul6U59wU2keEzNtR78LQk4iNDdWyYg9/E3a4eyN1HAlOmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062692; c=relaxed/simple;
	bh=H1ooMesOsCfbxy1JEoKTVjQr5MpOiYSVF2li1xsXq0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzzO1BQJmaY7YsMwnXVAA49LrWi/p8D4C3dlh3LSrjyO5Krd+La1IeloHDi2ucdwDdHGRPtooDYPXUxKpSLZPQae073ctLBgVJPhXAn1GZEZ9FsFBwpmB0oYNLBoY0W8YuWerd8OToF/KsASa2W1TeBQQhCzunORSkHLZWiAXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYe7FFZM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYe7FFZM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so6599615e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062689; x=1773667489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NopvELTUWATJredMr0Zqp2HDVCba8weCOzzaoYoC+s0=;
        b=RYe7FFZMsfqpceSR9TNk99ORJHEryUyqXZTM3hDZXg5yuqDf3hyrwHKqada9m9jvD1
         73Pd2NFyAnaGtSPsmCcwOGr5emkhuyo+sGlG3wk22qoejULBtf0Lw/Y53ELMN6Hm5S0u
         +kXs3tZglTRbaPhl11x06tV6hH3iruZQVeT+nILQH5rOwbvM6NSfEyjW/PUiUxcCgr2C
         K70HDP0wvdUm/dTmniGzGRL+TCKou13Q6nlB8nplB9SQQf/iu843joJb+yIgDXr1EEVM
         hpc1RezO9z6Zh6fYC/28LgUZkjO9PjF5Abjmd2+1uz93l4rymMJ/WuBOvKkGOBe6QazN
         jr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062689; x=1773667489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NopvELTUWATJredMr0Zqp2HDVCba8weCOzzaoYoC+s0=;
        b=D+9EvXp5gFCpoI8UR98RIKWUYWJHBtYa7mW11SP0Bbo5weKISby9HpTgKyoFA5Feah
         Ue0vVUI82lq9bmzqbL5eehmsVgGaKU8Kgpy7h0OZIpbP17FuwQIrl/D+WKlIX+bWIXvH
         MA8xBDlUUKHAir3CBkZS3WbyfAldDeQkpztVpm8MkgFUPb3v5N1z7l4GCC/MAIwi0nid
         WZkjyUnqDoE0oY5KnMjdbl/AiVlLWdQQwaEJx+No4azJRp/HyTVImABCYmJfMO/caqrY
         E++r6Nou5UCLKfbqKPkttiZHCdm9V1gAlfNcMCLwRmEWf+3TvxmLsvtzQdcaeGyTXCVI
         vvPg==
X-Gm-Message-State: AOJu0YzbxUfKXxJREiioG9OoNQResXOFOc5w6PF+smDRBT5GepAh0tHc
	/cVczrXrSJCzCrRhsjEi6UQHZC+rf7h3XnqXciHb+CrN67MIR31V2eS597VGUw==
X-Gm-Gg: ATEYQzxeFXyf+DPE5FTe+IGWEDf8WMWTE4+DwstDAcGSxZJkDNUKGbcu4Pd1SZE0Ib3
	FcKKM8zIUkxvS5nRRmA2bUQ1vJb0A/azU2sQs59ckMgYAGD0Ie9ZCqV0fuju/d82NSZ+WenHwdu
	7xXw27cxC/sGbtGDEIC8/F3JmHOiBr6bna3+m2BJbW8n3okGAh+7uA06dTEt7jGjQGcFR8WNWOz
	QoHjncUwE9hZSh4L5tC7zvYN0xXfCFuREpsKn1dCVAl8cwpAS6gGxzgHklsvZn+4kNJHhrYceTn
	RUiHkF2ZVFQ8bOKURUAxleOhVVTlZBj8FzVTjvZGJbL0PFdxZ7qtNHmWLKlPjDennWg98eGoob/
	oCD6uSQdIJGYBYcGp5QCrG4VWGTWwAxSxmI2QhbOXEWsKfI9ecgcQMKEajDcLYBF9NF1xqqQpGN
	m0KeMGqkww2W8qeuToV4ly3L5EMTuiY7Tn69+NC6MiAhGb6rpEHz3xu9mCdbzz1d49p/g7f+0lg
	BZBGHYF342uUkh/DVoESvFgqnnZKUOaCn8rRs9NlRNpi7taDFJHGfs4yaXIpM2wgo7vb9VEYpTQ
	QA==
X-Received: by 2002:a05:600c:820c:b0:485:383b:d5bb with SMTP id 5b1f17b1804b1-485383bd752mr74888935e9.27.1773062688489;
        Mon, 09 Mar 2026 06:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485358cd26bsm78402855e9.8.2026.03.09.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 06:24:47 -0700 (PDT)
Message-ID: <d8c8748a-4b13-4097-bdeb-495e6410a0df@gmail.com>
Date: Mon, 9 Mar 2026 13:24:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] BPF controlled io_uring
To: io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, axboe@kernel.dk,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1772109579.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/26 12:48, Pavel Begunkov wrote:
> Introduces a way to override the standard io_uring_enter syscall
> execution with an extendible event loop, which can be controlled
> by BPF via new io_uring struct_ops or from within the kernel.
> 
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

Any comments for the patch set?

-- 
Pavel Begunkov

