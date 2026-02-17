Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A202332EC7
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327805; cv=none; b=DFlLUEwHhgYNsx1AzYnDODsSX5jrYO7chX2j1aqfq7kvRvwpBMaQrXZtz2FfJHX8ffSBVd6Bc5DYMgKcwXgdUrEq98k6v4kyD+zyld5NiXT/SIGss6ogSL/5NQx9SyibV4XXuaXyTzHBnY4s8FPa+LEg14sZpO63GAJdaXW2o4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327805; c=relaxed/simple;
	bh=v8SjMTwLcBZJzVfReFV56hWL5F5UajY4TMlFqNjPxP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo5Bz+jgOFTCWxOyQKZL44c/08gAef92WV/XyIJXcYy0E2kNop5VROC5m8EZaCDvaUcSpA89gAPCZJ0+2Oso1nq1hAutg3jHhH9Y9uh8yQ1LfjYH8tuSqn6ELpEkd2l9ah7RSfeAb53jjVues5jypBgRUmfo7oJdgehyfAtFOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsMrkazs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsMrkazs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48375f1defeso31961475e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771327803; x=1771932603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0+Q06IjqCZ+6T72QS3e3RaNmdECxYnd2ULwCEntpf4=;
        b=fsMrkazs4S+ywWW426JgyhIDDZPGKunXbMPXGjyP9qWhJqzgXsS2RQCzb8ai+TWmwY
         ZlcqSGq+G0g1S1ISvE1I75jKrWMuoW98SeatHWkGHvDoj5PT20EpXKugagoR+vnNnZQ6
         JGRMKQ725MVRLpuRaznwTT6AyNjZtz49LFXgpJdhRjSZd0zA1+yq6CS4AcdGNkTFkBCl
         YrQPlEbZfPGFyBbyAMoBQWbv/UwmY/YmzffhjMbasCsT36HdsAy4YWon94MzhYrnOMsE
         PdJo8K9KgBOWumZ/AF0WQStIbHksqvullu3NL8K2dRhGx9p1B/DHwaeCIMtTOxVqNoC2
         rSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327803; x=1771932603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0+Q06IjqCZ+6T72QS3e3RaNmdECxYnd2ULwCEntpf4=;
        b=sXQGGqV657r0fyrVuypbjk6yhZaIGjN8mdN45eRPEIrkLE0fy1In7Jc0QHLt8bjUwU
         Eqo8GINkxRtwd9MSiD0cloMoUaU5TLl/jBHuNLEshWT0cOdEPs0f7/jG1st7X0fRfRj5
         qKCgPTvdWikUqoxYo4k2OKFf4TRcwlFrJ33fqBTyxUPqUEz7aVui1xqf35nRwb/JDMvm
         dyDQBIkHzRBm/8sH0XNeRWww2j+apmAWlSPo3TKCYpFiyqrzkFg0OXr7t0cx97IyN72L
         ICZrTlzZT/PQKi1EaFYG9tAcQQ2lFZANJTWImVjJ4f0PK+KedilKO9HPSEyYOtvIlwaf
         nwSg==
X-Gm-Message-State: AOJu0YxftCUKcW+RvP9jpy05+6ZDDkKEBajU6UBFZMhUAGw5n0uNAwQk
	tYvAAtcS+q3NfQ3defTX6YHA1PGw5nFVQySHQQvVfynep3Whf1XyAd/c38SVnQ==
X-Gm-Gg: AZuq6aIHY51+y8F8lmMXRCsTZXLVI5KLC7Iz77hLGoVYrb0AJifMeKFAPI07F+bndyi
	sNg8SiXgqYAQhBvqdB0UOXXx+fo2JZKommOw0lLb4tf6ZJnDB9SbtNhDfb3qY21FCS4ZVGEfFyQ
	yccoaLVyVOsxhtnWDpN6aNZM2XQt8xpd3TjMP5NcYtWRkMERRmg5OvGi0n+Jz86qv2GEgxeFkdk
	boaVOzYYopsTZBI7gKYuDKgH8FzjgqpMJU6Ulj5rmj/+0chDIRhLBgmOFuxKUUlV//tj+HJVu0G
	RBWtw0Mm6RnzzuR1BBVcI0g0MOuLzOJPrAkGTTlFEKiq9w9X1iwL/G82a9HuIRbJMS2EFVW4Ucw
	WCxZR5ldFOShyaSq4oX2KfWVKsB2nXB1ZHkapgUXgY1wvhqttHOuHvy3KnBpKAH0Fkxk2UlM1Ca
	w6zxwZnlvD9cCdbWoAThwplhTTDfr1aGbk9Wyl1p+7c8SOMMUBVR9cz3sCg0HsSjI0T2ZxecFIx
	p+wkgBfIOHBrzdEJKFf7iWctZYGku7tLoBoHzk72AQj1+HYUu2MV17S3asEvkGHkG3+vLry0DsV
	KQ==
X-Received: by 2002:a05:600c:c8d:b0:480:699c:abe9 with SMTP id 5b1f17b1804b1-48373a7b3f1mr202735645e9.37.1771327802456;
        Tue, 17 Feb 2026 03:30:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d99e194sm388582305e9.8.2026.02.17.03.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:30:01 -0800 (PST)
Message-ID: <1985145e-7181-40c6-821d-239f62410618@gmail.com>
Date: Tue, 17 Feb 2026 11:29:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v6 0/5] BPF controlled io_uring
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
 <d56b5f70-382e-4017-81f4-c9ae7a6c1b56@gmail.com>
 <ab4c6ffd-d7d2-45fc-bbd5-b6663d5c41e2@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ab4c6ffd-d7d2-45fc-bbd5-b6663d5c41e2@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/26 15:18, Jens Axboe wrote:
> On 2/16/26 7:23 AM, Pavel Begunkov wrote:
>> On 2/11/26 19:04, Pavel Begunkov wrote:
>>> This series introduces a way to override the standard io_uring_enter
>>> syscall execution with an extendible event loop, which can be controlled
>>> by BPF via new io_uring struct_ops or from within the kernel.
>>
>> Let me know if there are any concerns or comments. There are some
>> parts that I'll need to add like timeouts for waiting, but those
>> will be natural extensions, and this feels like a good base to
>> move forward in general.
> 
> I don't have any complaints on it, but would be good to hear from the
> BPF folks.

I assumed Alexei has nothing against it in general since he didn't
mention, and his last review was quite straightforward, I just applied
all changes. But I'm not sure if he wants to take a another look.

I'll send out v8 to silence smatch, and let's see if BPF folks have
time for it.

-- 
Pavel Begunkov

