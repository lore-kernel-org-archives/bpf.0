Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945793;
	b=abV4JTmf3LOBniZb33aPoJGPzr7whPBw0V4EwivSaqRJSYPv2owOGq8xBXFdryczr6nj
	 LjMD+JwyAjzKVY+KkKQ0pHF1tZltrjczbAvpJ/UyFJuzMrmwhjQ2gpKf8eyHY64as1abD
	 IYoMJRjGj9kHBud2lF85RpjyqNGo1XkUnofcr33JxP50kjbFFYaotf1u+xOjvC3JV0sQL
	 YcZFiiCuYtVi8Ai1DBUCEdv5rkwBoLElWlWoFhHXEq3NgM2UVWyP7HyoJymU2fWnjI4Dm
	 hfHi3+iMitUY4pEdbC4jgxm666k4TdFIUuUiTo24r2otmxvio9V9DvWeN0Pzyr20UoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=XMmcubV/Xh6V68YkctEJnHn5BnOQfFlM7RtTyGkJh+4=;
	b=dCXEiUaFuuec4Sqo1qgTgso/n5//SWQVjaGMY9ljcFWoNm8raLkFgOkp591vwT8WoOzB
	 wVTgT+6Pxbh+HlpISG/qQWHY8mix2HRyj1+5xrjl3UKmimH2IAvcnRkM3YbhjnrpjmJxd
	 dld7HOjP9T6XMBOPzkMn5VOBqgsBG/uibZ43n5TW/6qU5LrMMXzgNtae47MEh7ppuAL+v
	 edZfkO/zfinGvjQqqncfbIiuT6j0tLOptgqBQ43e+t9bo6EDHYk53EQWP1H3QfGoj2sNm
	 Ye7ZPMNG0Ri7nKExiEJVjNfPKE9COsmvebiz1sotdIc4SM3nYlpWg3PO0UR45WeECvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwFWggd5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8444606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8444606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwFWggd5
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso353965e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945791; cv=none;
        d=google.com; s=arc-20260327;
        b=V8mZucWn9VsgItjr2MJYLlc+2JO5dDnIqiBOvt7mZvGEBneq/p6ATPyczkv2lMcBWV
         GZ1MliOggxbzptC/Tl8a3XeqhiBt+jp25AbXplj4u/eH5NJlBybn3byHBkHkJ4DNhI6W
         YjZXzzz4o3LaBXBilnm/3LzRNvZwv+axkhZPzPtk9c18qFp09nnLI50tlO4bv4GJFKVF
         Lmw1JqXlPjqRufTEPl8KEL69WcrNmLVjsF+ns1EtO8fOCJzMHlaBu1aFPOB0HwS36iUW
         yEwmm7G1x2NQEDYnvPzLCt0WpagFJwfpSYdDlvlFLrraaO7QydS8KiPVUUG3yq+r2u7u
         ZMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XMmcubV/Xh6V68YkctEJnHn5BnOQfFlM7RtTyGkJh+4=;
        fh=h1+4BZy/nT1xMqFWAoQ+9v1BbUFhvmMIKJGENaKLNgw=;
        b=c4vO6r0v4eOMBDuWfubnQ2KSNuAvMHjqkEcY+tj7iB7Y0TVbkMrgQhmh2Djo2qwGAj
         lJyCxQ9mjPovjspB7oBpqPvCWctQN64Kf8rBJGO07Inp+bbMBERjWVQaQlXsbzHh7Wyz
         aI/Mzybg7KVEIMRdGee+W6J8/lCYtC8RzSRDEgrIZB0aHU8eZgAKoAC5FLoBsiU3fPup
         kCd32HU+6pdqAiQC9Sp/v9SMc09wzRJzHa8CvvyUgtb1QGHa+q7bx6w3C+GdlWXX268t
         ObjidzWMn34AXW6b5buIuTWheAlmZ3ZXXyMUtkDtDNYSEwzH6pr/9X9zyk40Om2sDDQg
         /kig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945791; x=1795550591; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMmcubV/Xh6V68YkctEJnHn5BnOQfFlM7RtTyGkJh+4=;
        b=DwFWggd52CdNykCm9JsJOIHzkq+4IGQaeOlJuLEncBHmK/DKjk2M5JamcD3VFV4FSh
         wbrVl1wOfiEici3DaVuLbO1mUCcWuskr2SmvTyQ5UXm+1UrIO9Xplc+wELEOrrw8RUxI
         7lzq932BVi0jObCwm+QA6QttY81bZr1qJCgPrZLBGyyRLplHpeBS6DwWmSfd0/lSeCgq
         6QIR3OKfx2fDFxAVsiRkG0wn8/ZiSXG7+Hs/qJc3itVF0LPJCbGYsKBS6z1RboJ5hStU
         FzTk+6Ztb/bNrcYulDLSN39g9ATYS+F3fj4YoKxKNmwzWfqrIU7hDMS94S9/XTA1BGCi
         cJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945791; x=1795550591;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XMmcubV/Xh6V68YkctEJnHn5BnOQfFlM7RtTyGkJh+4=;
        b=UZ3E5sJe37a9U4GTwqzkMr405xsFf/j1gWSMHzBM/EBcj5K/MnewK8aUGaca9QHZyM
         iYpPOKYJJLu4vICqIwo132Cf+SsSBpEy2Ltg509x3RFyFyqApnI/28KW2TEcUQG6YKN4
         L1bm2y2lHnbNaxlUWF7jhGAzMwweM/jbSnsoupuBjMTFX9kVKNNhhf3fVTab5mQl9T5v
         wrc1BLMzrRUX8leVLCVEgU2EuY5cq2BAlqXtFf74X4sNRnpMj95mU+UzP06mISSztmJ1
         y+etb2gdz8eR9dQYlBiPoYSM6f7ZKudhdoUGQE/P0qbLrfVWPDZ+x733EJKVOZutzoaG
         uYQA==
X-Gm-Message-State: APuU4Z8mp83l6ibOjDPSGGeaKPwl9b+ikHmIU5TPtM8g5zMTDxhlnFiB
	rNP+bfXki5eh8KZCKMi5vb35c9AnXh0+laz8grYJjex7LgelV7Osvmee34W12JOFYeMLQqUqLsh
	g3CJ5EiqxGwank1D5SNOydSDhmW3Fe5g=
X-Gm-Gg: AZFdTZeyKMF/El02GecVV4R6EKCnEFrB5GIlyc+4bxAxP3EMJxkWV7h+lNdtAfhpDpl
	EUHG9IaZTWXoBdIXUHC5IV6BH4uttGj7z6TLKZ852hd4UlRua9s9tdYivAbXrs9OyA+Ktn9PQRK
	8m1t8GSE3T38aoBNN76T1cb15N76njEpDz6sLK3KM2WSkqlr6EumolYuZVtEz7qZLh8XfZAbmqa
	GJlJ/K7Au32K5upgUta6ragDsQhPnT/8H9Ft6AZuW45Chqkg0qBSBVTMTo+dEfs7tFzrJ4LQgBw
	YwXFD6cdOMLjC4oad8LGqZqybp/WTI+/PUbtnteYU06W1s2XobfXIKNtoow1rlDcUz6iWDIkT0w
	tiOAdYgotbmQi2BKQCD6PQGONzoT5Q58+fxPOkewa/WDBt3AV9RNoU9vm+m3UKJXHRHmzjDgE1V
	7NvvIQuc9AeMjutv1CkZMb/O6tS/ESlzVNQyPT4kO4oCQiyZuDzeutWPS0
X-Received: by 2002:a5d:64ed:0:b0:4a4:14db:233b with SMTP id
 ffacd0b85a97d-4a638ae26abmr1092371f8f.12.1794945790693; Tue, 17 Nov 2026
 12:03:10 -0800 (PST)
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
In-Reply-To: <CAPUfTJOD==vidMeytY5vo4h2qZPdM=n5CRUtJttZ5N4oD6Fo1A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Nov 2026 21:02:33 +0100
X-Gm-Features: Aa3M54pnScSruE_tkELDmz5eQmkwId0aqNkNfqIo8cqSdHL2DLynP40_zWegvvI
Message-ID: <CAP01T74NiVAzW_vczZaOSniFh+=ddta2ThbXM_NB+mtv82pGaQ@mail.gmail.com>
Subject: Re: tracing progs can take a bpf_spin_lock in an inner map -> NMI deadlock
To: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Cc: bpf@vger.kernel.org, santosh.nagarakatte@cs.rutgers.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 20:50, Yalu Cai <yc1795@scarletmail.rutgers.edu> wrote:
>
> Hi,
>
> As part of a research project, we have been trying to formally verify
> parts of the eBPF verifier. We found a bug that deadlocks the machine.
> Below is the concrete description of the bug:
>
> A perf_event program can take a bpf_spin_lock in a map-in-map's inner map,
> even though the verifier rejects the same lock in a directly referenced map.
> bpf_spin_lock disables IRQs but not NMIs (local_irq_save()). A cycles NMI can
> interrupt the lock holder on the same CPU and spin forever.
> Reproduced on 7.4-rc3 and bpf-next (ea80d2afd285), x86_64.
>
> check_map_prog_compatibility() rejects a bpf_spin_lock in a tracing program.
>
> if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> if (is_tracing_prog_type(prog_type)) {
> verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> return -EINVAL;
>
> This check only sees maps referenced directly by the program. It runs from
> __add_used_map() while resolving pseudo_ldimm64 references. The inner map of
> an ARRAY_OF_MAPS or HASH_OF_MAPS is not on this path. A lookup through the
> outer map gets the inner-map metadata from inner_map_meta, so the check never
> examines the inner map. A perf_event program can therefore lock it.
>
> The reproducer has two programs sharing one inner map:
>
>   - hold_lock, SEC("tc"), takes inner0's lock directly in a loop under
>     BPF_PROG_TEST_RUN.
>   - lock_inner_nmi, SEC("perf_event") on PERF_COUNT_HW_CPU_CYCLES on every
>     CPU, reaches the same lock through the ARRAY_OF_MAPS and takes it.
>
> With the lock in a plain array, the perf_event program is rejected. Through
> the map-in-map, it is accepted. Either program runs alone, but together
> they deadlock the machine.
>
> There is no console output. On a 4-CPU QEMU guest, the monitor shows all four
> vCPUs stuck in the same lock path:
>
> __pv_queued_spin_lock_slowpath
> __bpf_spin_lock_irqsave
> bpf_spin_lock
> bpf_prog_...lock_inner_nmi
> __perf_event_overflow
> perf_event_overflow
> handle_pmi_common
>
> It needs a PMU that delivers cycles NMIs (kvm -cpu host here). Loading the
> programs requires CAP_BPF and CAP_PERFMON.
>
> The inner-map lock was enabled by b7ff97925b55 ("bpf: Allow locking
> bpf_spin_lock in inner map values", 2022), without carrying over the
> program-type restriction.
>
> The program-type check needs to cover the inner map when a map-in-map is
> used.

Thanks for the report. We are planning to make some changes to allow
aborting a program at any point. Once that is in, a follow up will be
to rewrite bpf_spin_lock(...) as follows:

unsigned flags; // extra 8 bytes on stack inserted by verifier
if (bpf_res_spin_lock(&lock, &flags)) bpf_throw(...); // abort if
deadlock is detected

Then we can fix this and remove the restriction on calling
bpf_spin_lock() from anywhere. If a user needs to handle AA deadlocks
etc. they can use the kfunc that returns an error instead and handle
it in the program.

>
> Thanks,
> Yalu Cai
