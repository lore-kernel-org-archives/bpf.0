Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5A307494
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863989; cv=none; b=JTzA3n+L0Wwr7nfQSAaapoMiSvzqAE57QhPVI0973BarqiP85Esc6+ggmyciSqFOX1R3/SwudiFtv5Wutmkd8+YKMwq1LZXessbrZPemLQUOBlU+p39QYuaNXcmlYqZIba6aLNMwZ+72HHLJqPHhecu5nG1aWI9hfZb95t+7blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863989; c=relaxed/simple;
	bh=lIGmXa8myVtUxsOqfYxqVtmc4Q2dqXBBcBxArxi9V7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRlwqWZP/5aleNrAeGuLUvtb48I5SCjlOp1RUW046AF6dKUpThBLICktND3Gb8NFLbCjO/wvTRPe0cVyBmBxhXs5Jb0WnENVHW34WHxUdk5i0inAknOwMtIx9K6OAVm9WbCaB45tt96MDsNJI8oQTJBeffByqqwjDXbrgovIrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljno1fDh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljno1fDh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4833115090dso43419235e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771863986; x=1772468786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rqe7eP2/t2WLWow5bcQFLzacPy8f6F76CKBflwV7ZMs=;
        b=ljno1fDht8S0v6YCBP+ONKsEb1s/7D0fUKv1irj4DxfiYaph8zuw2tkkq9z+pd9AL3
         +4a880wWeWsOq4m2fvxx5rMOrR71jG8G/+ZKo2nt3pyGe+OMqW1e4qTq5w0cJ2JcL59e
         fI73Uvdj/Z65/G8z/uxOayUGHtmhdMxeVOQmAL9DX/v3YI9d9LFgTzX/mX//nRSzn/vW
         7hhDHi0x+jq1LsTPZdrCFU7jV1nCeMtj9+mIYPk/aoefDPkBtGwjsxA5dS2F0j0nhUar
         KOYlcR1QguspTHCsKUUclp8eRGyD+leQ7bhNeoo55S5QbHhc6xc5YiDLqNuy++VSR1Tu
         xtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863986; x=1772468786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rqe7eP2/t2WLWow5bcQFLzacPy8f6F76CKBflwV7ZMs=;
        b=hhj2ZEhfYi5tjip3+cQRSak4ErI9j+QF8wO3kFFXtr0YuzucjjPV54GYoAQD9GzqiJ
         DaosZOtltbwuUI17qmdejwYtZImK5epa26ovELsnAmU9l+f7HVWsKAO97grn1FEQmHgc
         ESyciYSlTqa8XZ6Uaaqdh0IOK8Hwlkc+qVxsnIxoDtLES+cIh05vbMzpfe/y81q2mpnd
         BlfL4/3I7RZFwF7gkhXWhHqiyFCn16fm5BpwMjx0ftKBmx5xwFMOcAChvgLOqNIMCvRW
         aRmOC2qPnw19CxCklr3zE0C6K3s3OYr6OGq3+SSqRdwbJyB4YfNk+rcWUd9t7xsDKCPh
         6LXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMe83UC4AP9plbi4qocrM5ef90T4Y2qS4gvjMpTrv0lr0Ncn0Me/bX02E8O8eF990DYYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYMxcHDfc+XnGkq6IT5qLwkBIWwANF9hSw1E0nZcltLZkgPao
	O/HQjCpGuZX7lyN24m+YQ94GCMAeIMiHCTsWcENY/tlr+zK2xPaUbeoT
X-Gm-Gg: AZuq6aLrXp+ih7sV0SFKzvZpJ3YSf5SA8UJX1YImuAiNEjNexL/clsvkGXwD3NihONV
	xMOj6GoEJG9hUx+LvMf4G+jnpMIoRUmuJMLdjgALlkjcKUlDRwZquDXdtTfzHnNYr0IizbFuiyh
	S0uwsQ7tyHoCc1XIAtU1dldv2OS2p/77UdKOjMY9HIsl3r67x5PhOVNnFqf3ztvjHljXGARfyEB
	dE5u+E/4UKWyiA/o6714dkH7hIk4YwTo3ccvkeCpapDpaw4HUCO9oGdauUEGolIMHr6Lr5nwnj+
	H1srAwsK2ixNMBMys+scMVRolCfj3RH5tLTi5/uT974D2LVd/AlsLDfqxpv1uFhVaQ8cIpuChmH
	NSWrrka2D4HWDcPvPKIGHMB0HvUw1b2U8QI/XTmSGq9XaXHvjKHvnMcx/Rkvs6MX0z18XeoNm/N
	aflOajd2BJCtyooNLagJU/dQT7v/37DAl1Auxo2PCnZXoBwrGpRMC7Ihw3ezwZ4LokwENXwFMc3
	fPozpr8pJUAZkfg/Oatx1qLJgh+poWpwUjGee5xy2bHNq71XiWr4UStZeYnXZ6dn9nO5IIV+IfU
	0Q==
X-Received: by 2002:a05:600c:4e45:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-483a95e957bmr187456755e9.16.1771863986095;
        Mon, 23 Feb 2026 08:26:26 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a429e49csm142919405e9.4.2026.02.23.08.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:26:25 -0800 (PST)
Message-ID: <ed7b85d0-38d0-413c-a28a-f3b0d1a72a13@gmail.com>
Date: Mon, 23 Feb 2026 16:26:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1771327059.git.asml.silence@gmail.com>
 <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
 <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
 <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com>
 <CACVXFVPx5AcC9y9xVPCaahDeumNGm4TSkkfhsJ8w+wmW52JQ4w@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACVXFVPx5AcC9y9xVPCaahDeumNGm4TSkkfhsJ8w+wmW52JQ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/26 15:23, Ming Lei wrote:
> On Sat, Feb 21, 2026 at 6:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/20/26 17:45, Alexei Starovoitov wrote:
>>> On Fri, Feb 20, 2026 at 3:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> I had such examples, but selftests is not the best place for that.
>>>> It can use abstractions, and I want to make them reusable instead
>>>> of people copy-pasting from selftests.
>>>
>>> Sure, but please still post them as extra patches so it's easier
>>> to see what's the end result.
>>>
>>> Also please reply to that thread:
>>> https://lore.kernel.org/bpf/CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com/
>>>
>>> It's not clear to me whether your io_uring+bpf setup will work
>>> for Xiao's use case.
>>> I don't think we need 2 ways of doing it.
>>
>> We discussed this with Ming on the list before, that's one of the use
>> cases I target as well, there is no reason why it shouldn't work. The
>> difference is that this approach gives a flexible framework for
>> extensibility and covers a good bunch of other needs, which is exactly
>> the reason I moved from a BPF opcode approach, while Ming's proposal is
>> more specific but argued to be a way easier to plug into ublk servers.
>> If you ask me, we need a solution that covers a broader spectrum of
>> use cases, but I guess it all can be argued in either way.
> 
> One big drawback of  Pavel's approach is that it needs a totally
> different userspace
> implementation for using BPF, which is just hard to use in existing
> io_uring applications.

Not really, it depends on how you write it. If you need to rewrite CQ
handling in BPF, e.g. parsing CQEs and stopping at interesting completions
to calculate checksums / etc. with BPF, then I get it, it's more involved.
It could be useful for other reasons as well, but that's beside the point.
But you can do that without ever touching CQ/SQ in BPF, for example,
execute all your BPF work at the beginning of a syscall and indicate
about this work via user-BPF shared memory.

The downside is breaking links in two if you use those, but perhaps
you remember my opinion on io_uring links, with the amount of uAPI
side effects and locking complexity it adds to io_uring while not
being too flexible, I'd rather replace them with something more
generic, like this BPF struct_ops.

In either case, I need it for a broader set of issues. It should
work for things like checksumming / other manipulations of
internally installed registered buffers, but even without it,
there are enough use cases to justify that.

> But BPF opcode approach is seamless with existing io_uring applications, because
> it simply uses existing io_uring interface.
-- 
Pavel Begunkov

