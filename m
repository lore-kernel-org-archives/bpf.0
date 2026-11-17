Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945970;
	b=pbbif0xOLkWtcW4tfSPT2fZBK2EvQg0nQbkD3JPFtJSNxQO4EDq3bTAJJI6x8GTRKtsS
	 2bDHw9KtKyfpqWgoY+X2GlIIIBLVn9NIRjZON8EPB3EhXaI8Rqw430pi8WdmLLxH9PSCG
	 nB/x+m8Zn2KVnOboOMmb6XIvlsuyh5T1P/T/7a1mTmqXB1n47gp/YTrvhAHovbGFKOmky
	 tFbIFeGMEQMNrGdHSnFgldXjvXJBIBSb2RM60eGOMW2K/DJyELVXGnoM5bk43EeNiqgxI
	 RhcQyroNcJZmSv2wOWZ7mo3rjWfLlKtZLAE56ZAxWqZps9wkkXD8tDcVaTS6XAn+rKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=67wGsF4ISrAoWxs/G/NhN6CfJ7bQqn20NM5bdWlPinU=;
	b=Cga+TDB3mClcUcqAjDNqIw1/fh6EQFG2HK6DJUCoK246mXQa9nJCQdR1SpZGbyh+B7Q6
	 W6QctqMWvMng8ZPnERyFVr9hSqynWQbg/Em+GRXk8vGruKKXPY7vx5DOxKGrkG/fH+lp7
	 N6VqILljY6Qll9DCKbH+Fs1LW0wTqWG+Q/urLyAk7Xak7uzWlyCUjPiMUSmS0W8Xb5MGd
	 oMPWwbKHcEPmkepDdb7sHtx73RdOSG8lGBIHcgLi2zMX3ntziX3hbW1jDH8JW8yn1b4lP
	 WqJc1ZRCEP1mMPZzbN0xiQCKGMi9gQRHDrm/Y354px+lwk/BwL17LbImfm8oofJjX9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t6UGQIr/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF191606A8A9
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF191606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6UGQIr/
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4bb5b21feccso390775e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945968; cv=none;
        d=google.com; s=arc-20260327;
        b=T+o4khqETKV4VxA9hJblivTCqUfpcD+wUAYyt/iuqisyQogrudIjzu98vObdPQg1k8
         a9yCiXf/K2+UyUE8OJrAvESNXNthXYSAgGAkg9WMNEkJ76eojnJyzomT4l4MuNccWjD+
         nXr8mIeuAFeJAl1dnp7wbSmcnjlZutsSX4aMO9FAHhqwjfLClW6QEJhSCAj00VIlCd9H
         +JUhoGd5iPeC1MNwRymST+vSvBH/97Gy3vymrzLJTpXiLNVKr+Xgk5LQx77U8EGax+gw
         MBXhhjOmLsxbS7CFtPVwB8PQslZV/BMS+hk7wRG9NLfno9g/yYzXUPvAeiDq21YUvCI8
         YNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67wGsF4ISrAoWxs/G/NhN6CfJ7bQqn20NM5bdWlPinU=;
        fh=h1+4BZy/nT1xMqFWAoQ+9v1BbUFhvmMIKJGENaKLNgw=;
        b=KXjAKFdXIkM9lrdagaa7sEArZbrIrapG+7wtbtdh9H1HdXQ3sIOKOUwDmYfC//aff6
         E+dsHbkQ3vkn6IEg5Qa6N7TN9tdEGVuGU6QYfhNrmEw7JyM+IQjx0r3vnX53rBYaSZBv
         Kqi4TfqrvI5UUfOUbVnL26R4vxcXMm3aXKOiF/6U6j/yMyggmoPupkxr+zMBYNG82ALM
         33ID8xAdTciiT5Lap2zIrrYyJJCneebd1N2er2VzDwllKLqZnEm3XZHybGga+ctzWpCn
         dIO8oDFNQStJ96zGpV/nX6UMjkRd9COvwJzQt+xQzq5nofBqSDoroIXJlGj7HKLMHUU/
         oJ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945968; x=1795550768; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67wGsF4ISrAoWxs/G/NhN6CfJ7bQqn20NM5bdWlPinU=;
        b=t6UGQIr/YXcRF5kS1OgaI6Hxl2YTgzvzyigz6NkhJSyLSzuntou5Pg+eZMiNCA9FUH
         95TtKktP6HDts0Qfmr6BxVaUibIJGMaNRxomrkQu9NJfxWge46VaJyjFuN6iYlCCAqym
         3izStnjRMKoYhlwh45epX0d6IwhSgIxMglzN8inX4lHb6y8881DenCN084lVtu5SVUV+
         or1xPomqOckYS7d9DxIN7EO9UKtGCKcp3x9YxdpU0CRT+Jn05ETFEnOTwpo5jF5SSZQQ
         3x53kQF4o+XcPatx3gx0w35esQegu9V2TPsX/28K6H+Pbp7JX8yADRAuFjWCmxuP9oWY
         Za0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945968; x=1795550768;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67wGsF4ISrAoWxs/G/NhN6CfJ7bQqn20NM5bdWlPinU=;
        b=uiMKZTViRNTUyLEtF+8UjNiqkSl5zM8OIAi75rfJBlQpiaHN/q5rCpF39nKFHnll7K
         aZF/h1OkdbOUfqzSmjKwwwbpxS9cf8qkjGv35BjYmJ0JICnsF7wyJLPNS6aw+T1ANkm+
         bduR+GebwmJxK05lEK3d8I3ce5lPgOqLJp16N6x0DIIm/xkpdtZKhHUbewicvJglxPo8
         qnRR15zM0uKvzxxSzWwDavg/BdSCwgEsyWBV3WN1yPwBPs9V7+wbhsow2BBD7yAb9llA
         f7e+W9wObpw+DXlbWM3YGYQhgwv7LRMur97nCa2TUdi7BqHc0+mpw8tJb2PovRlVCPtD
         UYmA==
X-Gm-Message-State: APuU4Z+J0rt66KRbTp2IlF4Qm4OvtPqWyFxHWb3novWc+jVROnRDg9m/
	lN2Zft9lCGkZ133p5/dm73z6t1ejGa5xbuuSMGI+D5+b1U1ofgsz7eo6Ye9VzlPbC9NAESR+a9j
	MOCAHLmRNrr74FBEt2RFOvjUAZ9ItwG8=
X-Gm-Gg: AYBFou3haSVNl+K5Jdhtdyu5cwU7sMJflg4xNFKFrRX6BwYZCG+51gEasTQuNYfW0g5
	ejGOhHV2ADrAMt9Hsb92dT1Q9+7x1qKfpZkPBUOSWWfSOBQrJVRSzqCCszvYWtivXwmYrma3mIW
	1EdncXxeSP+FnHATh69ubNVlbImMAzLiiUPvq1KL2jfIUhp5ALnqCQa935K/sA/xK7uKeWP83iI
	mhbL239vunFTThfJkwtDGCxIuET5+zYb4JK6U2kd5V3JVWZY+cTh5mP9OkgiGBUF+qdfIk/JURD
	tLhxx1Va/P7VEeoSc/69SdCMNxjWt0/3ifyhk2hLYRCa7Y6rmIOipKov01n9cKG47iufD9bCacm
	oVeaX6rmsq2hGOf5QMvE4LTc0UQHjKi9ozeC+xgm9usW+/jGoCjOsFHNZdnDU14F/XAc0M/Xi31
	P4YFFQ9IGZHWY8A1hwHnrPbI3px1Cmje4qL5rFT7RTw27kQEOZ6vDPQesY
X-Received: by 2002:a05:600c:1d2a:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4bb7da34cc8mr5991235e9.23.1794945968103; Tue, 17 Nov 2026
 12:06:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPUfTJOD==vidMeytY5vo4h2qZPdM=n5CRUtJttZ5N4oD6Fo1A@mail.gmail.com>
 <CAP01T74NiVAzW_vczZaOSniFh+=ddta2ThbXM_NB+mtv82pGaQ@mail.gmail.com>
In-Reply-To: <CAP01T74NiVAzW_vczZaOSniFh+=ddta2ThbXM_NB+mtv82pGaQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Nov 2026 21:05:30 +0100
X-Gm-Features: Aa3M54pcB0Pagzxez90VZg6TwZtoBY_q-oPlKztn2vl-Hc-Ev3xIIWok-wR1mlQ
Message-ID: <CAP01T75djbZ4vzwbHMV3sfKa+tScqQqiOfAHDbRAaW48J7DMQg@mail.gmail.com>
Subject: Re: tracing progs can take a bpf_spin_lock in an inner map -> NMI deadlock
To: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Cc: bpf@vger.kernel.org, santosh.nagarakatte@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 21:02, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Tue, 17 Nov 2026 at 20:50, Yalu Cai <yc1795@scarletmail.rutgers.edu> wrote:
> >
> > Hi,
> >
> > As part of a research project, we have been trying to formally verify
> > parts of the eBPF verifier. We found a bug that deadlocks the machine.
> > Below is the concrete description of the bug:
> >
> > A perf_event program can take a bpf_spin_lock in a map-in-map's inner map,
> > even though the verifier rejects the same lock in a directly referenced map.
> > bpf_spin_lock disables IRQs but not NMIs (local_irq_save()). A cycles NMI can
> > interrupt the lock holder on the same CPU and spin forever.
> > Reproduced on 7.4-rc3 and bpf-next (ea80d2afd285), x86_64.
> >
> > check_map_prog_compatibility() rejects a bpf_spin_lock in a tracing program.
> >
> > if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> > if (is_tracing_prog_type(prog_type)) {
> > verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> > return -EINVAL;
> >
> > This check only sees maps referenced directly by the program. It runs from
> > __add_used_map() while resolving pseudo_ldimm64 references. The inner map of
> > an ARRAY_OF_MAPS or HASH_OF_MAPS is not on this path. A lookup through the
> > outer map gets the inner-map metadata from inner_map_meta, so the check never
> > examines the inner map. A perf_event program can therefore lock it.
> >
> > The reproducer has two programs sharing one inner map:
> >
> >   - hold_lock, SEC("tc"), takes inner0's lock directly in a loop under
> >     BPF_PROG_TEST_RUN.
> >   - lock_inner_nmi, SEC("perf_event") on PERF_COUNT_HW_CPU_CYCLES on every
> >     CPU, reaches the same lock through the ARRAY_OF_MAPS and takes it.
> >
> > With the lock in a plain array, the perf_event program is rejected. Through
> > the map-in-map, it is accepted. Either program runs alone, but together
> > they deadlock the machine.
> >
> > There is no console output. On a 4-CPU QEMU guest, the monitor shows all four
> > vCPUs stuck in the same lock path:
> >
> > __pv_queued_spin_lock_slowpath
> > __bpf_spin_lock_irqsave
> > bpf_spin_lock
> > bpf_prog_...lock_inner_nmi
> > __perf_event_overflow
> > perf_event_overflow
> > handle_pmi_common
> >
> > It needs a PMU that delivers cycles NMIs (kvm -cpu host here). Loading the
> > programs requires CAP_BPF and CAP_PERFMON.
> >
> > The inner-map lock was enabled by b7ff97925b55 ("bpf: Allow locking
> > bpf_spin_lock in inner map values", 2022), without carrying over the
> > program-type restriction.
> >
> > The program-type check needs to cover the inner map when a map-in-map is
> > used.
>
> Thanks for the report. We are planning to make some changes to allow
> aborting a program at any point. Once that is in, a follow up will be
> to rewrite bpf_spin_lock(...) as follows:
>
> unsigned flags; // extra 8 bytes on stack inserted by verifier
> if (bpf_res_spin_lock(&lock, &flags)) bpf_throw(...); // abort if
> deadlock is detected
>
> Then we can fix this and remove the restriction on calling
> bpf_spin_lock() from anywhere. If a user needs to handle AA deadlocks
> etc. they can use the kfunc that returns an error instead and handle
> it in the program.

In the mean time, it might still make sense to fix this, so like the
other one, it would be useful to send a fix + test, which passes in
absence of the fix and fails with the fix present.

>
> >
> > Thanks,
> > Yalu Cai
