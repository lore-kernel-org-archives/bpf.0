Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478735E946
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739032; cv=none; b=rimge+W8ASjehYZ/ebBsQ8G0KCHZqmFMTCfoiXqOJq4YCjXVTKOxeShpdcx0GGZwSWzZ2GR0eL8so7e+jfkBvQNynQe2oH3ooPV27h0gRUYsRB3lkTWLnQrElH1aIrQJ8b3Sf886Fhe1ysTt+WMiykf6ZfUjRz6QqdOaeYLQBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739032; c=relaxed/simple;
	bh=dtTlCI41aozPTprXi9NLFL5XTO3EzPdQWfOwuMTboPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiBLPWsJe8gHkk6opHc/6XcAukgVYLzBheS0r7UcE+eB5fHNSDQYxdsrrfcAmnIvNMRWgYXzCTrg2gAWJIKR+tLQepR5BhIxiJvMdZoPBLiVC/WnNHeF77Ez4J0O4bOD9EcBQ3J04JgENODbeKLYHSIThB3idBJ4Dx2xmKiNv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG2q/vtu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG2q/vtu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso5433125e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773739028; x=1774343828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M98aQTjWa8T+7ERPNFsSGl3sVEntJ3KUS4g5D7crqo=;
        b=fG2q/vtuNbzuklQBCk2lkDj0WVbhIZEBgPNCSNifvBQFx+XepfFhvU3S6Hw+SMsd+T
         ZvPleBcQ8goyWn52ywY8+Xn4wnaQ0aPqoJQbwSyChKxm30GW1zEAkFPRDUsSRjKemlIC
         CiwrE3HNmyCiEOvqwjXybVFxYyDPkCP81Fpc6dM/mYhDUgRx8lmFyo3X+3F52mSro0/2
         9QoivY6AcT1W6GtEugGJcPJHbOZkMH8dlotwx7lO9ZsPn/wh58IK1zRhuKDCcv10uQ+i
         xswq97GzXF0Pb7+PCRlEoqcD46RDvTQ3vphxeN5U2YMCl1JR/qYquwNwrjj/mDl9TDKw
         WJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739028; x=1774343828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6M98aQTjWa8T+7ERPNFsSGl3sVEntJ3KUS4g5D7crqo=;
        b=XibCm3kWYGo+OOrnhW+NXJt/L2Y+lmELdlZ0YkprwLQ5D9+FK3p/PbI5UeyQivespC
         xhM6UyFywWbsQfulYdGnDZIiRNmUvYGeLNGXowUzLH3+OzSrHzv9BgZT8d7FMRf2Qt7o
         1i5/CHx9bMPk4sWxg8bdc3RccE/JXvrwie81b70DvLqhhzZtPhIxL3YXIi+hM2lz1Byj
         JAvN5H/hEugq88inrICqhSuVk4b0HEBP27JfCIoF+lE7JhGVvXGt3eSkin2d+ShK+hPg
         OO4LrJAal+To3H90mRP2qMMs73AOiW4IOAYaspwEx/y0XyaP7HQ51XUwXj+2ESoq8bkD
         XcNg==
X-Forwarded-Encrypted: i=1; AJvYcCXbNqtbmhEMpnJmkWLG+GiGnDFjnyPVnqqaq1OeOGsQIrDNwAJRqKVXrcgImK4sagh00tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAEQcXQFgYAnh5Kz0tvq8rXn/62Pw+13CP9ISdcpdh6KoHjR9
	pMAgBKZXDZEnKBqWMFGRLDOfaBpmxGglUOQOfq7x6rx6IEbxzE4G6Bzo
X-Gm-Gg: ATEYQzyYPekcB5Sko01TDMMY16KM+A7Yo8oIbbQM4qwXjTzdlACqYx5Xf28GWXd0tHr
	QzK2q+kk1A4apDT+Ap0q/e2w/3XLrANEqqKFXCeQ5h7eustXSsqYqdIIBBTgLzstKycY7yv234Q
	8PBb8wLYSNS0/7FOg+ghKlPcaKPAoaxLBkhJMEse/NTtUwMV5tI0tgRGK7VlO+CaQ9/05sKqmhU
	K3lDneR3zc4eTEt+EQwuxKhnbAaumifeFh4W1GBAl7TP9mPK0MImK4jY4YyUhDLqW8IqGVHBMxH
	4TVQj6JLx6PYc4DLpHkAVWNkIR/+w88uhKd9BtTIbfl+9fo2l9x+GXjK3I5ILz4J8HhIc+MmveH
	4rLKVRBq8snwuvxsU9HA4jxwW75uUCKYeB68lAy3dyvoxY0O1efFuxZsDlDp3d5kZIXmLCfWa07
	2CVW8g/R+A2yxP1mEI5NRmrJPyiJNim9XBQmfDX1Z/wFL+yJ2q5sr3fygme1MsPbr0
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr44375555e9.7.1773739027522;
        Tue, 17 Mar 2026 02:17:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fb0dsm99153105e9.3.2026.03.17.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:17:07 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:17:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260317091705.5a64fc56@pumpkin>
In-Reply-To: <87ms07rlp9.fsf@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 23:53:22 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > 'sleeping' cpu; and you may not want the 'thundering herd'.  
> 
> Wouldn't we still have the same narrow window where the CPU disregards the IPI?

You need a 'sevl' in the interrupt exit path.
(Or, more specifically, the ISR needs to exit with the flag set.)
Actually I think you need one anyway, if the ISR clears the flag
then the existing code will sleep until the following IRQ if an
interrupt happens between the ldx and wfe.
I've not looked at the ISR exit code.

Ignoring the vcu check (which is fairly broken anyway), I think osq_lock()
would be ok if the 'osq node' were in the right cache line.
I've some patches pending (I need to sort out lots of comments) that reduce
the osq_node down to two cpu numbers; 8 bytes but possibly only 4
although that is harder without 16bit atomics.
That would work for arm32 (ldx uses a cache-line resolution) but I'm not
sure about similar functionality on other cpu.

	David

> 
> --
> ankur

