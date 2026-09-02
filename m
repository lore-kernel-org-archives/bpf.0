Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B533FE09
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311616; cv=none; b=DdvfRUAk3KE6SPg6kIN0eFXoHwMPbZdDsohZ7ZHbAfxty/pBCgZY0QC1KaxxskUgZitLStwFJuQKl0qGdwtaVCuzu+kqHh9oLTFntd56o59i+kV9/uQ0MKtE1D1tAmIizmz5w1rvu5yIMuZrzexdoB4CLiHntTOAVEuf9pje1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311616; c=relaxed/simple;
	bh=mthsAuvC5kxwl9HoC2silixWp9Aei1Pp/kO4Vu2EIZk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UPdrJwwbgODhd9cMcBwc6zsVRKzdj9ykB9U3DMcl5ODvjYBKKa/DxJ3tNC+FKrc0oq7nRtLVen1S8Y8GmgjLUjZk0RlGhXL7O8+UyiXjsbBaSOdeaksSU+gSGoEfR1iWyZ0JB27642RR1MIfVT57S7Llqpyk74FX24JsPtpjNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHvh+gyz; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHvh+gyz"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f4e10aa28cso63677a34.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788311609; x=1788916409; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mqO5MLc175YVYlL4+Bawb4s5pN8s4dKpvKfmlQW7U1I=;
        b=FHvh+gyzwbb4MZVbfK/4AUjtIi3Az9Sp9fYyuWAJN0exymtGB8Y7OabApqI8WHpjdA
         SnTR3GlH4z96oxHr6b1T1qyEL2jzflqehvWnIzF7bMH8VTxVOyVDX8U4KqOu6m3lt4Mr
         Erfva5aWYlbrPw8hufbde4SwSSvQwTMV2+yGnrAsw0C21Nqt3RPDHaioQ7ubQUWlITS/
         wA4O7dX1g9ntSP2sFkLCYc1hbNn/C13LyZjdP8MPlDMX2/Mo7DuFGSRS8nFWwOqir8x7
         7XbtL/emtjWHluNGVSAHLcjuh0E+iE00OcXyvV54q6DIxVEuboFvhmIZWwNzde6V8NFT
         tAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788311609; x=1788916409;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqO5MLc175YVYlL4+Bawb4s5pN8s4dKpvKfmlQW7U1I=;
        b=O/hBWe+B51pFBnoFBMIeoSUDDGbFGRKqf3hXi/y6izB5BAs+ERV8YTN96j+lHkqKCN
         mX/FD8bLMyB0c5aNKs+5UwuMzHl6aP2C7IajeOpOyzo+qz/AjjaacYuom3HxK9WvE2qE
         LroZsi5m90vLBANGBx2db9DwYM5Sfpnus6H/INqDlWHYURd9V+9BBE5K5jIjubdYJVLh
         VG/JdQmjfCmpaJV3PlttKxe7CVj0vLuOP4w4bKriS7iYgyXPPA3FTJ9CAWZSETPHD9LF
         xarCpKFq3DuvtZDWYHvHmUKZFRVK0/3PRrOmqPFQJfqemqvjN+PfGBFWxuN4ba93ddUZ
         v+zw==
X-Forwarded-Encrypted: i=1; AHgh+Rofbya56CFUmKwWQ83FIWSE+EnA+3S7ZAXcy2UvfpwLLepJDQMKtZUzyFyJOTQs2jaBtf8=@vger.kernel.org
X-Gm-Message-State: AFuF++ku7oSdECbX64Rufs1skjbdOCIxCgbUInw/KqHNcZNs/BgCT6nI
	2bWlX5Yh6hWSkoXcT8OGww5/8Jm+5e2ZoZxOH6OI7pHgFw9fp7h7/QIGPb5Cu81omro=
X-Gm-Gg: AR+sD11m9b8p5NMi4Bn9pdtoDZQaKaW1d3TevyHccLuByHyheHOLWQfuPpeZ5ayZ7KN
	9h9jQ/CIWdT56rXn1U82UrzvFFp2W09FYlkY6oIzNQCmicYepBxYuTU/WZParuGfEh3ZnAmnNTv
	3YWaC8dw0gXLpd0KAVhFyQOF/gk4Ief124kx0+Un0dlbLk7eZQQ/n3i+wJh+GSVR5yfMlFuBlkM
	FSlH7wvKGOpNVUo5+0m5hqAdL3imcwILnovo6tsgBoprp2j6P9CW/zOo2zPTEVAcPUhkl1X7P+b
	RoIuchspV0A51jnTQl3N1rMGDeqjSctYRotSY0Z8rHky3E+WtzSiSWGoMEXoj/bIN8vAxT6cOkS
	616ecYhMfbYfuEdjO7orNkCtvaGHjzeRSVX26LDazUK3HPT56vhPUh4dw3g64UeVz8/4ASvpUCL
	iqsxzaSH8NKmOINHdRfMcVAiN2eP7QUlnETJKTUJK3XVO3OgP+o/cFQx3IWaB6DDXZxSDwvKzau
	qX2xBKfYgpWKK/krOpqXGbmM08Qy8UI6QkGp9nbLO+uRNicbG3OwxuPx7BDK4bqxGc1SqNOs+lT
	v7VJypE=
X-Received: by 2002:a4a:ec46:0:b0:6b1:4e37:41c0 with SMTP id 006d021491bc7-6b48103a707mr855739eaf.19.1788311608778;
        Tue, 01 Sep 2026 18:13:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74f9ec644sm1036500a34.24.2026.09.01.18.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 18:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 03:13:26 +0200
Message-Id: <DL4FK2P8LMEQ.216J5ZMX9B7VC@gmail.com>
Cc: <loongarch@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v1 RESEND] bpf: Fix timer_lockup deadlock using
 atomic_fetch_inc()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.22.0
References: <20260902005106.22187-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260902005106.22187-1-yangtiezhu@loongson.cn>

On Wed Sep 2, 2026 at 2:51 AM CEST, Tiezhu Yang wrote:
> When testing the BPF selftest "sudo ./test_progs -t timer_lockup", there
> is a kernel lockup and panic on LoongArch:
>
>   watchdog: BUG: soft lockup - CPU#1 stuck for 8s! [test_progs:39601]
>   Kernel panic - not syncing: softlockup: hung tasks
>   ...
>   Call Trace:
>   ...
>   [<9000000000c40e98>] panic+0x44/0x48
>   [<9000000000e8b000>] watchdog_timer_fn+0x500/0x520
>   [<9000000000dfd9a4>] __hrtimer_run_queues+0xc4/0x530
>   [<9000000000dffe90>] hrtimer_interrupt+0x140/0x320
>   ...
>   [<9000000002ad9e4c>] _raw_spin_unlock_irqrestore+0x8c/0xc0
>   [<9000000000dfe9e0>] hrtimer_try_to_cancel.part.0+0x70/0x350
>   [<9000000000dfed58>] hrtimer_cancel+0x38/0x80
>   [<9000000000f6d944>] bpf_timer_cancel+0x94/0x1e0
>   [<ffff80000200fad0>] bpf_prog_108ab87b32f22e44_timer_cb1+0xb0/0xfc
>   [<9000000000f6b838>] bpf_timer_cb+0x98/0x170
>   [<9000000000dfdaac>] __hrtimer_run_queues+0x1cc/0x530
>   [<9000000000dfde94>] hrtimer_run_softirq+0x84/0xd0
>   ...
>   [<900000000271d9e0>] bpf_test_run+0x1c0/0x5c0
>   [<900000000271f548>] bpf_prog_test_run_skb+0x6e8/0xe20
>   [<9000000000f39940>] __sys_bpf+0x1690/0x2c50
>   [<9000000000f3af28>] sys_bpf+0x28/0x40
>   [<9000000002ac2d68>] do_syscall+0x108/0x5e0
>   [<9000000000c6a850>] handle_syscall+0xd0/0x170
>
> In bpf_timer_cancel() of kernel/bpf/helpers.c, it explicitly notes that
> "Need full barrier after relaxed atomic_inc" to ensure global visibility
> of the cancelling state before performing the lockless dependency checks.
>
> However, on weakly-ordered architectures such as LoongArch, the current
> combination of a relaxed atomic_inc() followed by smp_mb__after_atomic()
> fails to guarantee the physical store-load ordering because the latter
> currently expands to an empty compiler barrier rather than a hardware
> data barrier on LoongArch.
>
> This allows a subsequent read to bypass the prior write due to store-load
> reordering, enabling concurrent CPUs to simultaneously bypass the softwar=
e
> deadlock detection, enter hrtimer_cancel(), and then trigger a severe ABB=
A
> deadlock in the hrtimer core.
>
> Instead of relying on arch-specific macro implementations which may vary
> in strictness, fix this issue directly in the BPF core helper by replacin=
g
> atomic_inc() and smp_mb__after_atomic() with a single atomic_fetch_inc()
> to provide full ordering natively.

This paragraph is completely bogus. LoongArch's smp_mb__after_atomic() had =
a
bug. The specification in LKMM for smp_mb__after_atomic() is that it should=
 be a
full barrier, which can be relaxed if the prior atomic operation already
provides the necessary ordering.

As I already said, there is no point in changing or "optimizing" this atomi=
c
inc. Just let it be. You will see no measurable difference for this functio=
n.

Just accept that it was a bug, and fix the lowering for your arch. Plenty o=
f
other logic in the kernel uses this primitive, so I think you folks were ju=
st
lucky this wasn't hit before by something else.

> [...]
