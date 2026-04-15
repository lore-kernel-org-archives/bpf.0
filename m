Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF03314D9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776226215; cv=none; b=HstGnEbcRNk1Bi935aN48yzaoyqxlch+N6oXXtKMpVxonJDwEnfRUMv+R6Yc2IYHhlYp/gXDuxJSyLBswLgybTtA5UzyoksTrOahg5+FiHrR1ebBwi3ads+OscqnhIPtdPqTBNeVPOOqv9JMGAQiAwaw046yT2U7vGOvQmqvh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776226215; c=relaxed/simple;
	bh=zkApGiSInqzXbB26x7CUMq4yRKV2lt6LCi0JnsfcxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOwoQVtSe1TBURPqkoqIorRiOT6WuzpcPWUIZcfBm8YOfi4bzAamhsgHWdszKHg3i+eGrvl2jGqqoNIhp/DdlB9OAavFqUhJVHoZPcDpekjP5RgN6betBbPdln5tY81p666iAReVidt1kFsuQCJLY3T1LFhsLUhbOc8vHOcG39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6PrEiwy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6PrEiwy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so3663778a91.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776226212; x=1776831012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o49lAbSkVPQfOGvZ59d8lsdkqFWXCoqrf4wAVQyoM3M=;
        b=H6PrEiwyOvCWV0iWkf3U3JsNaoDUu2u5mt5qkJ+GwKaTCcx7WY2sCOoSn8Gq1qu4fx
         fveHRUOqEvnLEH6vqvgWsr5AIzzLGmZNgca7CdiYHvHma3zJs4TNHVkl/wk2Z7ajHzco
         VRqhRLkYA2v7zAx0CsYDEKt/IdJBLqZCwQpg9KAHdZeAeSPeCJts/OWVvwGAh4rMo1oE
         jfC+d2jDQJB9E70vSA39PEmrehJu8jPtHmauK/ulsYbP3qWibSHMZPt9kZCi5OcI2gzV
         pnbNPcOtK7NPbAbJj4ieJ4OQgiRGLNWaM6Ct8xjZ9qXlEYC9txX0g1x0NwDoZCT3/wDC
         ndUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776226212; x=1776831012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o49lAbSkVPQfOGvZ59d8lsdkqFWXCoqrf4wAVQyoM3M=;
        b=rZPRFxlS3sR68oJVN2xXU/dS1h/4o0H5yowWSKVw3nPMth8V9RLGaZWUGryiYufVsF
         01GExcKdVf17Ohjxqu7kF/zvUBNlRIzCGb1p5s2VWpj9lQ6Uhik0c0KFKTqkzrXpZ+t9
         x5C7O1mTpvkJFKRL8E/t0fRYaItSzeEG6b2SPzUp5wH6x8PT8aM4+DD6gkK1Cn5ll4go
         r7FQ0BosFGEhkrdOq819D+ahpv8F9aTBKn6ijsmXz9TdM6Npy+jPnFNF0o6zzanP/0Aj
         GwG2iDHwXWXO5Zsl+g+VUA+JDnsC1HSlRn3M2dlZeCiw7Y8A1ZD1/POtekh2H645z2T1
         Ynsg==
X-Forwarded-Encrypted: i=1; AFNElJ/FKWwACNobaCQsvX6X6w4sZPtwoTB5oq6gdZUe9UKEhy7pq8SZbefK6h+OcVhkFvi549w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgGDwIKw6GC9WSAmnlMM0kn4ZNVsEQrKlFc+8ixluVzLd8Xto
	0soj+3SBCX1dCRBj2t918WC7tX4RFy8wsivD561W+803OI9NpdWQCpkm
X-Gm-Gg: AeBDietDFqfOUhvnvFJtUje6HEoD7Qy+ScX5FRBPu79po01EAhjl1xJ+L4+X3b1OhJR
	zmq3bl6a6WsOX42QWbBUy8Lc9CPIlYDLxoZispiTZhf+J3PRW1BKN9wvWRP8JA0ZDBLmaw22uAu
	TKD4fGgwlygfDNRtRRdmqixIG+6Ik8keslOXPouctZsLpW6LxfzZXwQi4EQsmiWskuhqNCOP7y5
	hLAicyzfhl7ZYL8TeehK7vzr88yzD2D5bQksFM3pZM/XkhBZ8lMdR8U4LwzqxZljv3paxgLw4Wu
	GgfJZb4ZBk7yBiGHogLAYBymAEmmV7ga6L5DleF2KqIlR/R9mgQ6UmLC3sx0JCfzwY02Qyyc7iU
	HRxh7/RQsJ/r3Pja7uba7OAHiOJylrEI4hEICCHj3lTNnGqdx4NRmU3QbM6Nif42Szc7oPUNEeB
	p2EuvwAIESD6rDesAnFU2S28h7aqGxCA0D13TavQ7qBr1OJJV2ZZUmQMFvZLu5FRivrNnZTxasx
	0zMd5cZSAKUuCjENwgDkv50f1Apn3NgBLtM7tBWrzX9i/J4DPGXp759VJfdygBe/FzC4W0=
X-Received: by 2002:a17:90b:48c6:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-35fb714ed7bmr9126467a91.16.1776226212115;
        Tue, 14 Apr 2026 21:10:12 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd0a07ad9sm305071a91.10.2026.04.14.21.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 21:10:11 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:10:10 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org
Subject: Re: [GIT pull] timers/core for v7.1-rc1
Message-ID: <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177601564263.7932.2238613098642404049.tglx@xen13>

On Sun, Apr 12, 2026 at 07:46:25PM -0800, Thomas Gleixner wrote:
> Linus,
> 
> please pull the latest timers/core branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2026-04-12
> 
> up to:  ff1c0c5d0702: Merge branch 'timers/urgent' into timers/core
> 
> Updates for the timer/timekeeping core:

Looks like it breaks the boot for me.
It hangs at
[    1.036914] cfg80211: failed to load regulatory.db
[    1.037396] clk: Disabling unused clocks

if I wait few minutes and then Ctrl-C then I see:

^C[  190.319574] ata6: SATA link down (SStatus 0 SControl 300)
[  190.320442] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  190.320869] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[  190.321168] ata3.00: applying bridge limits

but it still hangs later.

Reverting the whole pull fixes the issue.

The boot is standard qemu-system-x86_64 --enable-kvm -machine q35 -smp 8 -s -cpu host
