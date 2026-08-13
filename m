Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC02472A2
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591972; cv=none; b=Hp0kWCN1V/onstXzNpMxkZjtK1B+/lIE7787b/hBUh1YzlT8CtDOn26vWOdTItD2kvFy9reR4XPtLD63XjwRbAVrlPUlj7+HSMcoTJJZGrm1wxGtpWJFup/P6tCQWwxKrDi5C3Xzwx6ZbLlBEU/1ZWOyC4ltXQ4o6zDZPGLqqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591972; c=relaxed/simple;
	bh=uXAQk9C4Rf5tpC/B6BKrVxWR5SHAGdh4ObnYHK3uVz0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aXBtGjbqE86cMackGruLXC0AZN5lZjfei0KkIon8iObT6JJPzoUWr1JDvfQ7htKufG/zSGDS51fjMmotiRbLN8WR4QBQ4+M2Sv/2DVpiC49nXtXE0Bgdtw0/23KVtYpmJHkqUPP5a4iJH+V/tdZZq+W1bwDzVwRqucXmH6yIV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOec+HiC; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOec+HiC"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so3526915e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786591969; x=1787196769; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uXAQk9C4Rf5tpC/B6BKrVxWR5SHAGdh4ObnYHK3uVz0=;
        b=SOec+HiCrvtmE8uIaceck1fTisclDtcce67PimX+TZbR2tOa6Tv8cIuhgZvWUX7Ow6
         XMIJTBI764H8Fcd1sdLIFRm4VxD86tUSmS+vYrPRACLQhPRCyYHv65y3QWYfoeihkBPU
         lUVh+uz5ku5sp+6EFE7F/ebBjkOTxrUr6uJACFJ2gp8ryIFKEqRl9/UiGb2yTc1BDDT4
         KnRAFXJ8+gm+7SQZeKYn9URboVUdxV3L79XuX78RtgICz242T7GD3dG90vkM+Z5fTtEl
         3bLaKexMh859WpiQfzKeaQ/UXmR5obyeaBM4Zjck/L7T1H2Um35z/U3dEoaX/Abrtnbj
         1RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786591969; x=1787196769;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXAQk9C4Rf5tpC/B6BKrVxWR5SHAGdh4ObnYHK3uVz0=;
        b=l0VbU6XP4MXmMrTxyE7uG7NT9kvMf6UQipmO8XBvuXQBdc4mCxbO1DF+2upTRzFKh2
         iuCfdbyABjy0NPE+V3zoicA5gLZiUm/CupVY5BTmHDuCANvuEJ6h7fd3l5MM7c7Jh9ZT
         EOFbsDNtVC32Bqq1Z57fp/+gQvgZofEp5IqTtMMKlpJWTLqcnApIWiXMJ+Oyftq0v7rv
         EOTfvS03oRviVWxCEU/5qhJV+B5d17BP3dpNG4rtDSqEePHuMo0nAvGsPwlYlP/8j2mA
         b7LX8W68Mn0MRK3jPtvg2JOsgzBnDbyfPBmw1qX12yQdULMiIMfKEOQI6LV9c65OlCLm
         CyZA==
X-Forwarded-Encrypted: i=1; AHgh+RoyJU13gQdYoh7PakoxzneZX2BR+qiuFQBibaP8iROmgXx55lv+LKJF8Tk6eoUXNOodhqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSg7ik2t5mLXf+pD2dO2NuJZNJbFbFYgAC/a4iCQqIjmDr/Hw1
	hXRb2K53Z5wgHoM28i6duF3Rygv0uFSJmr6Fiwrg2h/sdNG9eWqdYiuC
X-Gm-Gg: AR+sD10hBh9HWzGvxPV9/o8TJu+A905wsxBEcQpimGYrESMBiiRCKg411q7CGU32egt
	kzCIjSPudZgeYda3GgsQB5crNnZ3UtiMARpDnkLyRHQAbRuNhQqtYlJ3rjVXvcH7FxZvFTMUcn6
	UTn6gLrMyJ7VIMaf3jWacLnRSuWAlMkAQ0QTCAGXbQvvSxoJst0SUR6OOmIEDalGmCl+mtwviFc
	EYjdiWXGjuwyDTguf0nX7OzsC29jjyFo3s5q2XodFOTS+ztrL8kpK9153LeXR/QdIXgP4NVnn3F
	u1yGCjdyDeDVogWyvtA/VLuLnbdT1VNiRfUDyeOA3q2oD7eRrzkQs6DkLqci8vM/LLQkRay2zhv
	B8v7kU8FIn5ru8kRElgTTEplQUsxdC0qZTkHTx4lr1V5ZjFwAgn1Jf3U8J4VPi/oPpz0UrG+KhR
	NlLy46nUGOqwuILGcvFBRKUHyIwh/bVu/z+qc7b0qZgnCY890HaZWY6Y2gkreRaxYBM0iyfieqJ
	PoqyAPBcaJ58VlX897AKBdL1KKjXpfRDACyJm9f8OHFc9UX81UvMIeq7GMifD3tj8dSzyX/ori5
	dhFdR0Rg/w02IXYNhFUjKdg+HBKT1+2Cp/2UWw==
X-Received: by 2002:a05:600c:4e56:b0:498:952:e276 with SMTP id 5b1f17b1804b1-499821ab06bmr24801125e9.8.1786591968992;
        Wed, 12 Aug 2026 20:32:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1bd61sm31275045e9.8.2026.08.12.20.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 20:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 05:32:47 +0200
Message-Id: <DKNHZVI7D0XJ.2TOW5U5GW5NLY@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [PATCH bpf-next 0/7] bpf, arm64: __arena kfunc and struct_ops
 arguments
X-Mailer: aerc 0.21.0
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <DKND9FBAR1JE.3713OP933LYT3@gmail.com>
 <953b1c77-01d0-4a8c-aecd-00df353c6222@huaweicloud.com>
In-Reply-To: <953b1c77-01d0-4a8c-aecd-00df353c6222@huaweicloud.com>

On Thu Aug 13, 2026 at 4:33 AM CEST, Xu Kuohai wrote:
> On 8/13/2026 7:50 AM, Kumar Kartikeya Dwivedi wrote:
>> On Mon Aug 10, 2026 at 9:09 PM CEST, Puranjay Mohan wrote:
>>> The x86-64 JIT recently gained support for the __arena and
>>> __arena__nullable argument suffixes on kfuncs and struct_ops stubs. Thi=
s
>>> adds the arm64 side and flips bpf_jit_supports_arena_args() on, so the
>>> verifier stops rejecting these programs on arm64.
>>>
>>
>> Hi Xu,
>>
>> If you have cycles this week, could you take a look at these changes and=
 let us
>> know they make sense?
>>
>> It would allow us to close both x86 support (already landed) and arm64 s=
upport
>> for arena arguments for next merge window (next week). No worries if you=
 need
>> more time to go through these though. Just bumping the thread.
>>
>
> OK, I'll take a look at it soon, thanks.
>

Thanks a lot, much appreciated.

>> Thanks!
>>
>>> [...]
>>

