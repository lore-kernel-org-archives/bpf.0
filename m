Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826825;
	b=WipHCmelcLS3mJQ8ooLFaTL4oC9QYAr68AyVhUOpT1xWYPsu7Z8cyLfJn9/oJHPBdEMf
	 D3aa7nXjCCSMwA9CcT49UmsOxcf9S6dAEvQtu47kAb37EhqUkhcgvKDuy0bP+vefv/bcE
	 luOkdojckHj6eXbxu3awQ/7t3AmMVN3lePBCTJd2eag9pGPaHS6oP3v5/1ghy86+LnQgW
	 Bry9DyJ4sOI4z673geI/baOJ5vSmt6OQxy06eberjghbkSoISoIBryWXkm4eaqFLLK4q0
	 3Ju7IVVJyyynQyYMH1C8V3ZxIsisHbnNX5RS/dLcS35RFukYLCdmA2DAoOjfUcF3LbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=gZdi2zUPdVC7tSoW/KR9ljEMmpMHwDaDJe/0ozkzl48=;
	b=AZyPTpvrZYKaLNvpyssRWJsZG6eq4pINNNUSqNfPAchXlt69TXQj19GjL72eZysVsJUR
	 LvnHeF/T+rF8e12pDDtjQmJevHD2SXaA6wcRrN+YLe1NnAyE05zrwqooRrB+LtA4uj6va
	 7S8Teh1+xdpnLK4wkbQta6eUdDmZlIzIeju97+8q2+qaqQBBc700Q6uLJXBQy0ieCGWyz
	 8XcPwwwbP09h2qp+ToHfXv/gJ9ovBGr55N2vMzI2yS7rTwZKuS52sQ5Bn25EgKheKlG8V
	 AN14rSeD0ACxpg+LrZfsvQqoId5kYmG3iJZUjzLwEK2fgnjBuDlQfXibxlR5oh2dAqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qtkTg22I;
	arc=none smtp.remote-ip=74.125.225.136
Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E27606A31E
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 00:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E27606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qtkTg22I
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4bb86801c8fso1582555e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795826823; x=1796431623; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gZdi2zUPdVC7tSoW/KR9ljEMmpMHwDaDJe/0ozkzl48=;
        b=qtkTg22ICMYp1SwJmvH3P9xPlRqFQ23Pqff5+EyZ5xtFUxeZqChQTu+l5H1iuIxFL5
         e2PMuxxM2jYzcmh+BkXL3InWtiyNmoVNWwV7ujwYH1s3NJCF/nOpcH4Odaa7V7ovDtLe
         aiVRdzuGGaH+hN09baBEC6e5E+j59Ud2Bzd8jvBf4KgvNlSmylA8Z7Pg9p7mb+DUQbvT
         agUTK9BgW4T8QeFsyX+ur1O0L8lwrvdMAI6mMMYROWOjIIcJYV9i5E3q88W7Q26w9jqa
         1yWXHj/dc0lXqVqUsLyhUGkOMNEMbOrpUykifVK7+BfSt73K8ey/l3SuZzlIwWlo1OfM
         DT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795826823; x=1796431623;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZdi2zUPdVC7tSoW/KR9ljEMmpMHwDaDJe/0ozkzl48=;
        b=aHznWUbw7opx+IOLMeBXXphgmWdl02i1a6JPSFk9w2YezWxNRcQUo1lA828GJigwGQ
         GUaKnKMdU0dsrvSYkfJ/yhYVCfOAP5wwu1Qwm+5ybE84IXsgORD07bn5HwtBytFTyu2O
         vY43V7aW09DO+RncIyIbu2Ot8gSI+aMktf7CEhc9sptKyocQA30l7SMKEwnDooiVwBM9
         GYn/A3eJ3NzWgq/fByjhuduELbyOc/+rLyVv6/YMwWtiORitXkshlO3ocOy+0sOyquCR
         wfyTW04k6FDysw9DyGfk14nivTTqkNsWoQ4tu0IoUEIgKr5jzFxBpWIF7+kxam5sfbOY
         wfug==
X-Forwarded-Encrypted: i=1; AL+hErFQWzpY2VBN44pwbeXeB5cVMd6zdd73niXfZJzIF51Gr2+DNTZsn57senSmZMAzN25DoA4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gg9n73gBGNjENZHNw0uDezxhYk+Hs99XH+wsIBfolejMZ+FBl
	FBJTndlV61vKEuf8HeoJkPM9TJVq3jt5FHFS4P7+xNltvrISEhDU+KZ5/3qhs8Px
X-Gm-Gg: AZFdTZc0U64DnAj0Con6GOGwgxAAZtSiWtT6VctRlPisnQ8Mn7WWXarvcEjjBO8/sw0
	VOZ9Ts/0wd77YdsxTf+lM5cwK9Y3NLKJvSTXLxjI8BpKfLaIi/T2/WtxT4J+BzIWF6MS2L7K9BH
	BUk6XJgwWxoiR3bDpAjE0Vupe6NwHw8B52LZxl+rqw0aLIibUcFxjPGXra3HlC2c1QL4bKLjawh
	9ZTGvL4FLDu33vmjCYbU9XEiVEStEdEqiecMrkV3xmGZvQiQA+7nSDP3iL0HzYm8Sln+XPuJqTP
	YVAFwUDxTYSdC+3vMJXXOnk2owDSa+e+xa8fk6O5Sgdmg2zDzmC0F3ZzebXzayJsgEJYYy+YTaS
	pM4HUUlTmvUkOR2JjtklnoJ+ZMOixG4LG5/kblcd1qv7hFQuDjeAC8XoqKykVITLhOFUjDuXht0
	Byvl/HySLzcORaix03kLI1piACicMy/hZR/6WNAtVJfZlBdrPADBmWEcxtaMmZ/Re+tgd3ghZ8s
	pdF8Bg+bsBG9IH1rt/ZRwDPU+ck/b+gTZoZB44oTJRmAbA6+6gU2zB7p2cpKnnVtten+WK2AReh
	FSlcOoBfsj926hvpqH0Wqsgo5iHOr8S0NC6Yu/SlsoidvwQ4UdOM+nlYYUTOCoM7ATVzxZtx/kw
	KAQe9IbVTFZ9m3H6LBPzXAoGk3QO+3HFOfZ2+lrQSeWEKq99NiUVx5lng+BA/0DmdDYYkp9sARQ
	vqLldH8aWFbBDIqg==
X-Received: by 2002:a05:600c:4e94:b0:4bb:b796:66f5 with SMTP id 5b1f17b1804b1-4bbb79667d8mr62178775e9.6.1795826823272;
        Fri, 27 Nov 2026 16:47:03 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm669627825e9.9.2026.11.27.16.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:47:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 01:47:02 +0100
Message-Id: <DN6FH90QBQNL.3TQOK2LID5S8D@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, <x86@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bpf: hard lockup with ringbuf used from NMI and
 sched_switch on hpet clocksource
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tom Roozen" <rzn.tom@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261128001825.38905-1-rzn.tom@gmail.com>
In-Reply-To: <20261128001825.38905-1-rzn.tom@gmail.com>

On Sat Nov 28, 2026 at 1:17 AM CET, Tom Roozen wrote:
> Hi,
>
> A BPF ring buffer written from a perf_event program (NMI context) and
> from a tp_btf/sched_switch program hard-locks my machine within about
> a second when the clocksource is hpet. On acpi_pm it doesn't hard-lock.
>
>
> Environment
> -----------
>
> - AMD Ryzen 7 7735HS, Lenovo ThinkBook 14 G7 ARP,
>   BIOS P6CN22WW
> - Kernel 7.3.3-1-default (openSUSE Tumbleweed), x86_64,
>   PREEMPT_DYNAMIC (full), HZ=3D1000
> - The TSC is marked unstable at every boot, so the kernel selects
>   hpet:
>
>     TSC synchronization [CPU#0 -> CPU#2]:
>     Measured 5354294254 cycles TSC warp between CPUs, turning off TSC clo=
ck.
>     tsc: Marking TSC unstable due to check_tsc_sync_source failed
>

This is a known limitation. In general, we rely on ktime_get_mono_fast_ns()=
 to
be safe in NMI context in a bunch of places, rqspinlock is just one instanc=
e of
this pattern. In case of hpet, we definitely have this problem of a deadloc=
k.

Maybe the documentation for ktime_get_mono_fast_ns() should be updated to s=
top
claiming it is NMI safe.

Technically, the lock only needs elapsed time on the local CPU, so I think =
the
simplest fix may be to stop reading the clocksource for the timeout on x86 =
and
use sched_clock() instead. It reads the TSC directly, also when the TSC is
marked unstable, never calls into the clocksource, and is already used from=
 NMI
(perf, printk).

That takes read_hpet() out of the waiter path, so the queue head or pending
waiter can no longer block on hpet.lock.

local_clock() does not work for this, since with an unstable TSC it is clam=
ped
to one tick past the last tick, so it stops advancing while IRQs are off. T=
he
clock ticking with IRQs off is mandatory.

Other architectures keep can ktime_get_mono_fast_ns(). x86 also keeps it wh=
en
the TSC frequency is unknown, because sched_clock() is then based on jiffie=
s,
and would stop advancing. I don't think we can do better than that, even if=
 that
still falls back to hpet.

Untested pseudocode:

/* arch/x86/include/asm/rqspinlock.h */
#define res_clock_ns() (__use_tsc ? sched_clock() : ktime_get_mono_fast_ns(=
))

/* kernel/bpf/rqspinlock.c */
#ifndef res_clock_ns
#define res_clock_ns()  ktime_get_mono_fast_ns()
#endif

with check_timeout() calling res_clock_ns().

> [...]
