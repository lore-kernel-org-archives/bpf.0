Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822E226CFE
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821885; cv=none; b=dR8Bph00DrEUYe7fOXfoSiEN7ROs5bQmgpuzykG0Blrfj8ZzNt2pHXK9wIvMUHYFal0y/DDdYQ/WhPbe1C1HswiJkBx2dRsHDQOSJ7UmJGmy1UTtVv4DHnvDCpxa1zMHXKMm61pINmsS/099HrnDntSkiPeKAncziPrOqjptbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821885; c=relaxed/simple;
	bh=xobaJ9SWAk+kihLedQKH0ZlyvTgeKpY25z0SvgUy1oo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jipZaa9SgY6/GD/ygmw56OIvOjPNxGq6WAL2YML1ki60N0KBFwf/tOPVS+MIVTxrNv9khi5oQbmHN310+hTcDbtoqXXltA8WoXQauuCqQ4/wiDEYQ6RgX1RS7sc3e1u0+rN/RRi18jQKydllaecX38rWAQhqfE64MxKqBbcBVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI/wbCtX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI/wbCtX"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b613a17bso31395615e9.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780821883; x=1781426683; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7+ZiWaNPav1VWLwodt5w+X2OYlFouCP0YvxMscLZOw=;
        b=bI/wbCtXr0ZpYBjvRHNxy5Qyri4oCAROqzYU4UBcV9BDwSi5w9iDWrZEyAXHraA9zA
         qlxVEW9hJTS66Zh8+xyAan2rLaIPw3ojBWh9QCofPiSUqgf10MoxvIgIMUWdbR+yTAew
         3u8mDScMpgYYwaLB6eMU26xb9NuuYnXu51CckwnIGOghaMC245quVU/E4kZvRvW5ByL9
         Jk/BiKdJmdHSRnmQd4ntIC71fNAHFwN4mS8vROyb3e9HSSy4w6LQB2NV7YhsvXdn+YVd
         /1MocRhUW975INNzVjdWr0yp0b+5KClHG3XmIABq5cinvKwOMpnDXTJU8i/WhzCgRmr6
         e1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780821883; x=1781426683;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7+ZiWaNPav1VWLwodt5w+X2OYlFouCP0YvxMscLZOw=;
        b=h327BLWOUZI/q9qbO0STLtUSn7V5hNyUpR8riYQB6ed5pymzF2Ez2HWuPA0W/SE7lG
         q6mgcfR2TYtJiIfCad41htL5KR1lqMzevYUoUg/diiGsvwk3N4f9YhG+XQEtewXI0RPv
         hY3H+KpR1IdVppHYKBqCQ8KboCcif5nBRJ/TYtKZxgfT685YQfCpyfeegpzqkP9bKd8o
         vNWdlwz3Q4ea39rwe/QZ8c+97O/5mpx2k/ZFq8ZRgqOkf6xbATv7bJoBE9SRfY+AasL2
         PXKoLbpf4HPNQChKgFBEmvjuDWL4RP+Q2oce9niAQFFqdPzBEavltXaVaT3oVcqP69Xc
         MXIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sJcAB840ZI1jFDKqlXr7ov3nsgpWGE3k2mHewo7ycqWRX/yjkgzyn6TiPpW+VGzUvqYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xDVWnWk8sHZ1dgbrzI7OfnLCxpKhYjymI46M4aL42RF1JvoM
	o0ozAWwdOpLNGJ67R0bbE2cqdpda/ZE+O/yDycDaICb/u0pn20TjS6FQ
X-Gm-Gg: Acq92OFKdMTodygvpbCQTubpKB7PY0lilF3EEk6nTokTs+mw6oh3oaupJpEkzXb1m4z
	Vp5H4wDBH1ULjI8W7Bn2XYUcAwuKUmyEBdDu67keARMqYJR+d2dZltfU5cK/zJrfqtfqG92uOj3
	wggnbJZ47pfY5cUOTcnDrCE0chLFixXEr91+DkDKbyoqIfUkBG7SDTamHQaCbDazESbhnvWytd1
	3S4IeMusRt3v+JaD2HPWLjchq96lAzBNM8DWg67wkhSxAa4GTwu1v7XvRZSHhiknM+9PvSWYlLI
	kTjZSlUrY6OrwcIz5ThxL+Lk0BQDr72rvyxFT15QWQG91Nmcez5iNeXtqEJDhygd8Z3PuaDjDjA
	osRKCPthn1NEKGW1SSmoljomR3wV3N81ccS7SOcbkwRybKb9dEy+aPSuvVm696RPk4ermbmcH06
	6znNZScku7cQr53c0ZWVnATIq01X5jOd1esJMzQGAtEcn2rF/J8HHx22M4GUVOy/ktHQ3ZOjMXw
	JS6fZSs4hLxjXq8S8GiPqiPQXzu3Kc7ePxfJDb27S9TRjmR8sMawnux8tpO2Iv1RSCPrYbjN3SI
X-Received: by 2002:a05:600c:8216:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490c261ad21mr172906665e9.27.1780821882662;
        Sun, 07 Jun 2026 01:44:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm276651355e9.0.2026.06.07.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 10:44:41 +0200
Message-Id: <DJ2OO6CSLUR6.2AGL1QQ2QSSDR@gmail.com>
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Juntong Deng" <juntong.deng@outlook.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>

On Sat Jun 6, 2026 at 11:19 AM CEST, Sechang Lim wrote:
> bpf_task_from_vpid() looks up a task in the pid namespace of the
> current task, via find_task_by_vpid():
>
>   find_task_by_vpid(vpid)
>     find_task_by_pid_ns(vpid, task_active_pid_ns(current))
>       find_pid_ns(nr, ns) -> idr_find(&ns->idr, nr)
>
> cgroup_skb programs run in softirq, which may interrupt a task that is
> itself in do_exit(). Once that task has passed
> exit_notify() -> release_task() -> __unhash_process(), its thread_pid is
> cleared, so task_active_pid_ns(current) returns NULL and find_pid_ns()
> dereferences &NULL->idr:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000050
>   RIP: 0010:idr_find+0x11/0x30 lib/idr.c:176
>   Call Trace:
>    <IRQ>
>    find_pid_ns kernel/pid.c:370 [inline]
>    find_task_by_pid_ns+0x3b/0xe0 kernel/pid.c:485
>    bpf_task_from_vpid+0x5b/0x200 kernel/bpf/helpers.c:2916
>    bpf_prog_run_array_cg+0x17e/0x530 kernel/bpf/cgroup.c:81
>    __cgroup_bpf_run_filter_skb+0x12b/0x250 kernel/bpf/cgroup.c:1612
>    sk_filter_trim_cap+0x1dc/0x4c0 net/core/filter.c:148
>    tcp_v4_rcv+0x18d1/0x2200 net/ipv4/tcp_ipv4.c:2223
>    </IRQ>
>    <TASK>
>    do_exit+0xa63/0x1270 kernel/exit.c:1010
>    get_signal+0x141c/0x1530 kernel/signal.c:3037
>
> Return NULL when bpf_task_from_vpid() runs in interrupt
> context, or when current has no pid namespace.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v3:
>  - Also handle current with no pid namespace
>
> v2:
>  - Reject calls from interrupt context (Yonghong Song)
>  - https://lore.kernel.org/bpf/20260605200501.1619406-1-rhkrqnwk98@gmail.=
com/
>
> v1:
>  - https://lore.kernel.org/bpf/20260603204206.773482-1-rhkrqnwk98@gmail.c=
om/
>
>  kernel/bpf/helpers.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..226c31ccb5d6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid=
(s32 vpid)
>  {
>  	struct task_struct *p;
>
> +	if (in_interrupt())
> +		return NULL;
> +

This seems too broad, I would just drop this hunk. It seems unrelated to th=
e fix.
IIUC we only need the bit below to prevent the original NULL deref.

pw-bot: cr

>  	rcu_read_lock();
> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
>  	p =3D find_task_by_vpid(vpid);
>  	if (p)
>  		p =3D bpf_task_acquire(p);

