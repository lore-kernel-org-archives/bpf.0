Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0A3559C4
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709019; cv=none; b=VO4o4BfFPYFDKUDkCy/KLagaaiMk7ulhtdTw+G+FP8+GgSB3Zn1rEaVM+0FBmrVdh5DWitCsoEYkW9wZnXC5JbecwSjJmziqLY86gXYuJ+yaQ/XhcLOlvfqQcWBRAB3l+r64koRE89bWTbHXFhxY63Ocff+/K9wvirRTKgYumDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709019; c=relaxed/simple;
	bh=0Hnduk/tYKW2zNuI2uxqb6mdMGHi3RqIpUeCjeuqzNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfWAKEzuu/QgEFg7xrZ9Og7BkkiXE8g5sdb7EJhc5Au+2RThG8lHxNk321Gqx1/RWpmxI+BXsSSZAxmc5HLm9oObkiYFpb4fEUitJtlLJ71JQyuvqDyBwmL2i/ucG4FJpedW206t4yFB1tsuT27W/v7wuNr9dj7G6yPqn9/mnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ4JctM/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ4JctM/"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b884a84e622so189819966b.1
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769709016; x=1770313816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Hnduk/tYKW2zNuI2uxqb6mdMGHi3RqIpUeCjeuqzNo=;
        b=dJ4JctM/tlsusYUNlD7RuivfbxqT+1/lQ0IW4AERpJcTAxZiyR+WgIzigVMF+Re3+A
         KxBFhQ8yZrYnrVRj2eDoKnei+cpPeGviFYpvVpWw6Wdrw4w+cZUn/O73rFvlPHOX+rkB
         CwwRwHA3tDduGHbymKioTUzUHNk7/LGErBEv1cnUtU+VLJz66aVbSvStdT/hr6NuS4HF
         6FmlkfAvw7XfWIhj71PPEHcIY28D2gNaWULvIzDN5oOP/Bd1asvSy2LpcwMGsPEvWtOc
         lWANxZY5nRMMdGlmncyQHql2Q+QS3A+8lI45hrMFHxk4HzUdtQMGD3GfqwKK0S7okFFU
         kHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769709016; x=1770313816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Hnduk/tYKW2zNuI2uxqb6mdMGHi3RqIpUeCjeuqzNo=;
        b=L0h107Uec2sYLs/xS0vxFdg/kgyN4qUzGRTnNk5S9N9Z/au/qW/6+nB6j/pReJGvLw
         BwUANsql5a+3x8JqCOdSm1Aq+WRLpMGdoQztALwUxjLIUMupg0WWCRQ4RaU7SFnc3vF7
         6mYeADQ95/Q3WzjfY2p/WbMSZMt+xKt6hfveSfKQ9girbVJR3lev1EmZ6W5R1YzoNpHw
         tdpz+6ock3cDVb/LvSxeyEOVJKlIb/wvw5VhX/ztXEBhZDGQfwZ1HO5DMu8gSlDiRQ06
         i23jiJbtdsBF0hl5yzGK14Jdvu1f1/Xpno0IwQ7Q2hh9lD1cNP0Usmo7fFXaHTChK/XK
         1xQg==
X-Forwarded-Encrypted: i=1; AJvYcCVxuqY5cxmiQrW2WNJ4vaR69gYWAWM1EqfNwgGHtHk9QMUbK4b3CDkpWRGXIXL0Ix+91Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KdJLVvcAN9k63n/6yMZltXBQdHtMe+sa3Ie4K8aeNH2Hu0Mk
	zFsd6i49vvFlMsGa9CvLid4SV8g1dlv1tjW6TA4o/nh+ErdyTgu6pMBm
X-Gm-Gg: AZuq6aKU/U/vhLuN8ym8x594KirYsBkg0N09jo5Ft7JIuw0GD5uAeEifSdXYrYKJGHk
	qb02uJNIpadhq7SpMO7mn237z3WDzmn8ZNaukrJiwuanbkH3KaoTvu0S1I/GB/w1xn53FpxhGCi
	MvczpvFV0D+a6EiBWrg2aTVjd8Fup0B8+m/baGYJ0fgUek9XHlJ73tQi/zuOp6d7rYLzGNxd9nB
	R8lODWo4BzgGGdWgXcuMzsA1XEbbsWiXJr4U1BHLT1TSoYEpDJncq9i1rL+0ZlWERwVMq6O79ef
	K1YZWaClgBYh5oUwKnFvHULBIFBd70UTdfJNN2LF8jufqV88IAzRYMiHu9yOJ6E/5oJgv68tbRr
	PJ3KS26/bKye3eTkV8YqRRTrYyV5jFM255HO9CosVNBZ31sYUJt08Sq/GjiSk5AIeD8sSIt+5XG
	JbgiydsiJpv5snisBlxRfgtF6ceyHh1znCz60ai7xyDRADi6i7HQ==
X-Received: by 2002:a17:906:c10d:b0:b87:15a7:8603 with SMTP id a640c23a62f3a-b8dab4410dbmr724170466b.43.1769709015881;
        Thu, 29 Jan 2026 09:50:15 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:57:5cbc:5f79:1d06? ([2620:10d:c092:500::7:48a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefdea77sm290916066b.26.2026.01.29.09.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 09:50:15 -0800 (PST)
Message-ID: <416c6ad9-152e-486c-b169-123c06d398e9@gmail.com>
Date: Thu, 29 Jan 2026 17:50:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm
 dependency
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
 <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/26 17:34, Quentin Monnet wrote:
> 2026-01-28 23:34 UTC+0000 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> BPF selftests depend on the bpftool. In some environments we may link
>> bpftool to llvm dynamically and then try to run somewhere where llvm
>> library is not available.
>> It's simpler to avoid llvm linking altogether in those cases, this
>> change allows to do it.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>
> Hi Mykyta, thanks for the patch. Do you have any other solution to make
> it work on your environment? We've been rejecting similar changes in the
> past, because we don't want to encourage people to strip away the
> disassembler when shipping bpftool [0], so I'd rather avoid adding this
> if you have another workaround available.
>
> [0] https://lore.kernel.org/bpf/9ffd4b6b-0073-cfef-5889-cb4d0b838f8e@iogearbox.net/
we have a workaround, a little ugly, but we can improve that,
anyways, I'm happy to abandon this change.
