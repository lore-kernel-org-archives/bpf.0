Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522203254BD
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769874840; cv=none; b=lUf+a7RI6Y18CZp2OVeGJvuZlIjO/THzSNAJGdEeL2zzFqTTw+33huU6PI1RjTLtFZY4UUWv7BC1DzFcgiVyEZVQ3wSmxTKLD6xWte7+gcppcI0c8bcj2ddoYEgugu76s/XQE1kxXJZn5Q53gXGBS1uYIH20+dCt+Kt/2GikOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769874840; c=relaxed/simple;
	bh=gPxfc1Or7MT2TMudnUd49s5dM7oxPJDUq2h82ELaFPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiXlbN/rerWgJcTZhh+Q0uqMZBdlRgErlUUZ4GjcVW3R6TLm8JVqUgCoCqRQBT1atz7+LV3lNeigKZIn9cIbkbvDEcwQsxzfi7O2MjuLV8dna7V5nnbwwfLcGwNpOP6mwYylXs/mDwOgdcqxUJR/Tmj+EOKQZg45hRnd6awBiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1/qmmZkQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1/qmmZkQ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f09874c4cso2132533b6e.3
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 07:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769874837; x=1770479637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=es4JeecL4qbaq7ZMUlzngsGo7GQdpeuMD9cshqCD5BM=;
        b=1/qmmZkQfk4elnkxUBpqoKRBAIivPPZdTNmiwiENMhuOS/QNdRTSkGOweWlC9X1KRI
         cRvXaAIDutBaTjj9p1e6bq24dcSaZWTUEAGKrkDnA9qmF12rg1AjbBar7lrHiWgnxcHo
         Yi8q3pGLIXW45c5VR53s4g8SyNM8e9IxlrUTed5w+lWMcpEgxWclCMLKyz9KVkTreuLN
         0Yh0NLzGV+ycaLPti7ydUniUYwde4pukoltkPUYFveJhVTLezSUwva0ZWtXF3B1REL8/
         BY16sbbnabFPkkF65EpRjccfNyYtrWtf88SZH4sbOvzC7WFsZNPaAZDimoFSsTpmuC5M
         PR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769874837; x=1770479637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=es4JeecL4qbaq7ZMUlzngsGo7GQdpeuMD9cshqCD5BM=;
        b=nqFw1SlNNM8PTItl7IIB1HkYRiIRHrgWKXn9kSezN413E3yUrSD7yIFrgLwjE5ybUS
         740JRjETh4qPW7YJNQKVugpmbyqwI9PxBE1Ssm09xUV7+vwPuEzwyHH7h0SVuak2Jm8a
         vSbk95H+MZDNPvdOtmlHxhbl0kC2zbgHsrdrC45tAlFtMbJjTxY6vg9MT7Ui4PolYXdN
         Mj7Gy5+T25yLfgrrkia88wR7Mw/7DYfqUTykZRu+xv/WsEzUkD9V6dbVgyXVgDwNvYdD
         aIGIi4DHgxxdp+ZgcZBEo2bNvr6vI3fvVmhenhskPrPt5Y5vEDZaY+hEGFI3GQdDPV28
         jLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JkBdPDYCPu2mJokrMJrSzk0DYrm5cHU8YKAOd3lNxSrpdHUN0xAy0h3I8QDGSPZIR94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0e5QFD7YOTdu9JZYaUiAHRFAdK266GeisoKWhIem4YWdZ7R0I
	RRFKmGPLhkXuekhFvgupeDU9COIN+M+y783s2hq3iHWkh+GpCQm0D52ErM80T29BrJk=
X-Gm-Gg: AZuq6aJNdJ+9g5QmpGUZOiJMX1pUxrj9kzeFR3gwxMT2Rga5i0PvimQotvRUptpuM8q
	RXgLUm3SmRoNj+nB0kCpbrcR/yNBj24w4HhTUoOBwRVEKJAqxRm5tkfKskdN9ZFXpH8cle/doHH
	fePl9deBKZCbqhXqKvrzw9RL012SJtYpVBQG7cBSEcAm27l6HVXKAeDiEdRyXWWasn1c78YGRTz
	HINUI0kYXaeGqd1QHQvKUHJ+UrWL1EtubH8VBQcj+gBKbwgb9MxVjaOYis7Vb9r95WdUjlty9gS
	rfwV/zfaVNaeDSpWAMG6PHGrB38sIFXOoMJI79mBbS9jxNvsO+ll3s4gcu4KJkgu4bFxzxn2Tpt
	MPttTOlQtFctKA7p8a5pyJL7+DAgIT53JQoxZWt77A+uVDgGh0rI852wDTBy++1S3OIKpSRk83S
	NKqd57vM26GACp8O2UewTy/W8nFCBDIyUlqSKtYiDTOFBmPP+lIbfApnj9U0M6prrWBKrkVQ==
X-Received: by 2002:a05:6808:4fcd:b0:44f:f747:f9f with SMTP id 5614622812f47-45f34cd0c5cmr3020550b6e.36.1769874837163;
        Sat, 31 Jan 2026 07:53:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08fb635csm6413741b6e.21.2026.01.31.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 07:53:56 -0800 (PST)
Message-ID: <c52642da-6938-41c6-814f-831f57ecaa8d@kernel.dk>
Date: Sat, 31 Jan 2026 08:53:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
To: David Laight <david.laight.linux@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, metze@samba.org,
 Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
 <20260130205227.6fb1d9ad@pumpkin>
 <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
 <20260131153735.3c9273a8@pumpkin>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260131153735.3c9273a8@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 8:37 AM, David Laight wrote:
> On Fri, 30 Jan 2026 17:19:55 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Fri, 30 Jan 2026 at 14:40, David Laight <david.laight.linux@gmail.com> wrote:
>>>
>>> There is not much point making the 'optval' parameter more than
>>> a structure of a user and kernel address - one of which will be NULL.  
>>
>> That's exactly what we do *NOT* want. Because people will get it
>> wrong, and then we're back to the bad old days where trivial bugs
>> result in security issues.
> 
> It can still be a (semi-)transparent structure that code isn't allowed
> to change. That is no different from using iov_iter.

Then why not just use iov_iter?! FWIW, I fully agree with Linus on this
one. We have an existing abstraction, we should use it. We've previously
optimized common cases, like ITER_UBUF, if that ended up being
important. We're better off using iov_iter and improving that, rather
than some new mixed pointer abomination.

>> Can you point to an actual case where setsockopt / getsockopt would be
>> performance-critical? Typically you do it once or twice.
> 
> IIRC a really horrid one - I think for async io.
> That is also one of the few where the supplied length is a lie.

Huh?

-- 
Jens Axboe
