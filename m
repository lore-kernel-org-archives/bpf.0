Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E03815EE
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640527; cv=none; b=RIWSayGZ41cQZiNz4LzOTKb9wTaaDEAIHGayO99Ha4FazsIh64H05OMspKtiMeeQNYflGV8uL3KTzc05PKVk2lfwcmptV8KqtrBafHTmerPrKraWXvrBWBm+lc8zudjbp7PbvAI5JWfBsLJxFsWbs19CnztbFRijFUAS/j4GRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640527; c=relaxed/simple;
	bh=kwvHXYWdKrz6L3EpUZixyAuZUc4wXpUgz8HQg5KU6Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7emNg4FjBQkxKSJmvuiO5/UIGAJssbITPV2xmuj/ZUdVO32xGOCvznXse3UHWjn1OZU3NzEX3oLH6MU9JpQfg+HwzlhQ7ZTYrxTbEpII215FcFGALyViXZLkyOEyt5HXBzAcDHRnJKGKpO0F2NzEH1b+Q6FZ5k2tvmFlzAbtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnMp0ZnE; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnMp0ZnE"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4e9697so229c88.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774640522; x=1775245322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndkuGOb0YWH+E7RSl7+mxGZiN0cs3hl0L5wXJYxmyz0=;
        b=MnMp0ZnEKuqXCPXEqC/7Pn9iLkfCsdKD7ayf1ChfS8RKNB9gI9oZpW87U8Pj5rKrp9
         8lCGPgt5FRtahvLI5uUh/G93jeo+qOpbXVgb1ZcgRtL8PRORcA6oOokMwFTE2KcqSeSu
         +tqkdubSvk7YFs9OHmXwU+8b7qzlbxWGGtNlo3WB8CGHbY6RLU0OYOrtOkik5d2ZQyV4
         iQLjeYu6CsfJaADIs9T6hNe5RFzrED+igKBWNWD6qyS/y1I4kj2TlIg0l2Sb+aOv+To6
         QLvCZsCsWV08jOk0BiYwk5CtB+bmf0BOV9eG+CMeaHQuQHfnJxYhqTLfBhgIjvIyOhtK
         nbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640522; x=1775245322;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndkuGOb0YWH+E7RSl7+mxGZiN0cs3hl0L5wXJYxmyz0=;
        b=X8iox/njZAboE93YmTpFpQubzJFNuKa0rBOHtH7wIG+OaYwHBvXTN09xcV4gmSpJl4
         WEaqDzCwc9vUuYHubfZ+E2akEjSzqx6ryakWg2965qbKyOARD0IaFNvQk9XfnhdQGOpP
         HGNVFoh4+6rzK+N5CVTaU4LGdseTPrvom307CXKEgvuTPUT/aFaTr7aZtlJoOyFWed5O
         2nYSCOaiVihyMMG7ymaDQpU7CVJO+qRN/f/iKac6r+70FvkJA2Dtq+a//k+p5/6Y1oUb
         tpCDp0n8PUu5VCc5ib1TYnURJUhb2FO5RPa5MJy0Hxq7sezYDbKT8KTUFDFyzZc73zv6
         UExw==
X-Forwarded-Encrypted: i=1; AJvYcCXA6k+YAZ1LONZ6tXgfL8+WQyabSO0NfnzzR/w4ZgQYpQZmJkobZGaKw/II7Cs1zGZyY9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNS5ymI987xaPv7PKkRog4A2dfG/XwooJIJaa/EvFPSdrU25JZ
	T3KE9lpfbVIcIBVA/fvA8lEG/y5sxb5vF0roW9Yvim1tD+Y37obebTsWm2FUnsmyCQ==
X-Gm-Gg: ATEYQzyit73vqGDzX+o2P3ikDjWr1VwUpldeA5uEy5fuaXwPgBPUyp8iFx/qeiL7itY
	SS0iCi0JGmfx2RzIqO2jD/uuvRj6nGzKCgJ0rN8qauoj4CMZKpAqk7HSMP2oFcueVlBxqDVUyCK
	5UMPPBT4LzH2VY6fK/2dD7LRl/fqdjACUfC9kL87kZyC30lMrUJR4Nrtvwh4Zk+32hQJg/l0AMn
	HmiYiTaLZ8ZIQJxSKScWwAGaGtV6eCWSZCYxb04fPG9UqG+1UlOuXH7xVEdVcmT5SG/HS9NfDwH
	QQvP3QeLb3Ffj/0Mx3wkvYrDvWT4NmYmtVPemT+E1KdzemAs6i650zZfVIlyZDFi5811rOVM51L
	PrQruLqA8z+p3DW5TJ8OE+XdGwn1sgK3J4Lc89Xzu1v+QmAHZtNNnnLrtklT1r2pr4erwMw3zIp
	ssr5qKs55osCGBMWQ3fAVTe4bbidOZlvsM4T7shxciCLzZsGpY/jOq+nPK
X-Received: by 2002:a05:7022:618d:b0:12a:8cf4:65d8 with SMTP id a92af1059eb24-12ab93aa42bmr30758c88.14.1774640521803;
        Fri, 27 Mar 2026 12:42:01 -0700 (PDT)
Received: from [100.72.9.77] (63-158-47-178.dia.static.qwest.net. [63.158.47.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97d88c0sm321576c88.5.2026.03.27.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 12:42:01 -0700 (PDT)
Message-ID: <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
Date: Fri, 27 Mar 2026 12:41:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Levi Zim <i@kxxt.dev>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev,
 Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi everyone -

On 3/6/26 3:27 AM, Eduard Zingerman wrote:
> On Fri, 2026-03-06 at 16:20 +0800, Levi Zim wrote:

...

>> I have a BPF program [1] that is badly affected by the patch that it no
>> longer loads on 6.19.5 due to
>> E2BIG error.
...

> 
> I'll take a detailed look tomorrow, but am curious if patch-set [1]
> helps with your program? As far as I understand it is not a part of
> 6.19, as it was not marked as "fixes".
> 
> [1] https://lore.kernel.org/bpf/20251230-loop-stack-misc-pruning-v1-0-585cfd6cec51@gmail.com/
> 
i'm in a similar situation - my scheduling program, which uses 
bpf_loop(), won't load with the dreaded E2BIG:

	processed 1000001 insns (limit 1000000) max_states_per_insn 76
	total_states 59608 peak_states 171016 mark_read 0

i tried the patch at [1], and no luck there either.

are there any tricks with this new SCC stuff to help with verification?

thanks,
barret



