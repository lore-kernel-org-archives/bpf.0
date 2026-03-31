Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3453033E9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918582; cv=pass; b=NTr0jqj4R7P49lgv1b9p7oKRxrIuFzm8zF0r/Vl1ygXCh8mnvvvI3bNdGhODiYqtstPJugDP2Hp9Wtg/Rsv3PDQIlVywG6BVWP1I7OtxitCkL8sg7/B95K4t5rv7/M4LDlsU7npGP/9STsej+YDshDqJ/fU3/96tETerGvErYU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918582; c=relaxed/simple;
	bh=1dPjgL/3m/+9/M2H7r5h7SRWe0MM3sHlNK+uofzNJsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2GIkaSJnmsx0yQqk8of7M3oUzwvAo3M2kIK8IXZYHUrOMk/Lsprr0wEPUhmqyymfgeIxlGt45C5qQ28tGJdGMlnyZpBWCTh7w6jayoAy7wP5hljHzjkqTvZtwrG1B3BnOG10O3RFpr/xwAjl8bgU3tMz+fpsg/gJBjOjGcLpyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ8x4K8q; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ8x4K8q"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486ff201041so50282685e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918579; cv=none;
        d=google.com; s=arc-20240605;
        b=A9rD9fWhJmeYxANZhot5Pxf7W6j/TTesbCVM3hgCo86Ab/EGK2msBIu/JVKFoApT3F
         zoHtGD9kGgWiqLaQWpbzpOqme7+6lKjM+n0QquIQC82PuVJLnSKW2GYhxf/GInuTnjnO
         3Bz/DIceX8vfLFZficw31qIcFWFZS65IshbgcRPq9258IDUgiYWusewowlofXF54fPo9
         GkrsCOAwV+JW7vyJI5V1f/2xceKwy3lh5/zAHBi6knLnw16SywYqajxkfP9O0Skkk07h
         d/KZqwicFmMoKXmvr0KflT+nttTeCBgr8NggvPl82z9CuUpAuVqRIJTOqMaCUBYpqce8
         7qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1dPjgL/3m/+9/M2H7r5h7SRWe0MM3sHlNK+uofzNJsY=;
        fh=46pG/564TlRQQZcAZ+2qjvnKxnqsxlYpH2mtwzBpp2s=;
        b=U2P63rxLOqg7cRsd9pDrDPa/ZvKhf663QDowOLp68ypNtMt5pjH63b2FqAuU3Hjaj5
         qSmrdYLLLD2ABjxdPYx1hdFg5S+XoYrnc0SHDBfVdgjq+dcQw6n6lUJs+PpNMIOwLZIB
         3jXf0gefUyZk8Tqxsv4+qO1MHxSWOQXI5stT8nAHMMxH0MHc4LpqkfxgYGGgFgjUzs2i
         XW+p+uYSTIfDaS6kLHoPa8uhrSKBwxsv37DxUFK9rjtI06tlj1bvEWOwY1g8LkWH29yA
         T7aaPkBDe1Pg6EMf2fi86rTyZQK0YvjBsjZ5I7lfsfVL9Px8jaN38MFnqM0Zh6YZSZKb
         M7xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918579; x=1775523379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dPjgL/3m/+9/M2H7r5h7SRWe0MM3sHlNK+uofzNJsY=;
        b=SJ8x4K8qVARl3gzv0ZBNLFmSIbMCYiz+92jLbp926fljQ1EWNA2P9p8EzqOGHM9C0g
         +OKhIVTg/5vFINQ6OkRBil/Lkbmi/VCTy7O61hC3b7P8PwsXOtaHa2atsih8Z6DgYjBD
         wP8RTwVxZCeiQOeA8hQ1oD6e9RjGEk0DsLMRWiZTPF5tMycOBEP87OpZguxES7lC/6kd
         oe0W5U024kprQ3vpnydVT1412F/WJ0ZkiXorZd5uqdTgrtTlBTcLEmzbA2iOAmokQdid
         rBjPLWS9BdlZjDoIWTdSkeBXlmY8OWd0qGMtThlQQVEnFr66O6s8AxAGRRybkexeq3OW
         runQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918579; x=1775523379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dPjgL/3m/+9/M2H7r5h7SRWe0MM3sHlNK+uofzNJsY=;
        b=SaSk1Dqx6TtlFplj8j/K7RRwGuLFjsx6NCUZACo4qzrOItCJ+kEe+ej5I71gxQlYK5
         fRJRLXNTSu728T7ktxlLbeuBQsgE/psknv1bSKvPmdptE+Wx2pWZuhcK8kJ8l7W6vLo7
         yjftjsUkXu/s4AchP+Anp13RSSoI1CFYeqaZYl78P8yDIeY4YZeC6n4dAWkAoZvQAFBh
         QfHZpYW3IunTAcPByUPRHFUxJ20UhZgFTDhyHfMAPSG9slKT+iY03lwmT1i56WEOWL4r
         qoDImVtYeyBU77tpVV4t5F/YtpmvbnKr6RZabSoCA0Pi6P3QKRdXZAfHiyNrwuwul8K1
         bw1A==
X-Forwarded-Encrypted: i=1; AJvYcCUUsY8C/H7GOJmOWaUxQXuS1g3alD+DE0r//bI7c1PiYX9GEh0apVLD3OzhimUx6yv6kd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1mx3teQu4sPRsiJdNUicosRWHDHRay/KehJHOq0IZNoT9hOD
	i2ZISHqGhIPhXKo6vyFcLblZzPIti+d3udFl8DWMi7y1EzuyXNkiLlnTE+lw1kFTwjl4dEY7re7
	ImIMJtjspV0Ewlbf7BeMJWNF+lmAP9jE=
X-Gm-Gg: ATEYQzyE849ieWS+LvCbelj4zq2StVjTC3IVLBfJOeUazUShhWywtmoGx3a8iQKiauU
	nPN67g1f8o7Yw/zKSK9ux+Dx+ggaJ3lrq9fZjrKmbs6d6xSwK0Sbc3hMJAOXdOh5x/pLLDUoUwd
	K6U+djUUla7Gh96Q1h+nqGmogjLWAH/dT6FAnJ7WE05rE9R6HU1wKqlb8nA2hT+7ad9qNDxxUjS
	QrPyrAaf13+/LMMJ4jzNs8Oun8Q2x+SuRxGRT+5uh9q4FRDtAxLrE7gbMkYTIZ4wo1OZdfZ68ur
	kG5lIufNDon7pEdi8v5uhJrJGlXosASUscwM3RuGTyfLiFrcqLs3Rj0HereF
X-Received: by 2002:a05:600c:c4a7:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-48727ec3a93mr233183805e9.19.1774918579305; Mon, 30 Mar 2026
 17:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com> <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com> <87ldfeiodk.fsf@gmail.com> <CANk7y0iXJ1sTn5eMrUosvbwnLrSwGtxyirgTpFwdDVWN0tHb5Q@mail.gmail.com>
 <CADucPGTNHas6gJu=ybWyZ5X2s6bOO_ar2eg9PFv6TRv-=NA-Zw@mail.gmail.com>
 <CAP01T7712ZmLy2YaViHtZ=2RqtF4i_F49Vyb_UC8NgQcYX8j5g@mail.gmail.com> <87a4vti79o.fsf@gmail.com>
In-Reply-To: <87a4vti79o.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 31 Mar 2026 02:55:43 +0200
X-Gm-Features: AQROBzBWDwuDgGq1S-aYVgvQgVBiuPdIO5iQY7e19LktnTtKAeeojj2r1FoB9Vk
Message-ID: <CAP01T75bZRbgNXJa_rq_MX6AKm0XBTpOO6V-RSy35b+TFA_Hiw@mail.gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update path
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 17:09, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Fri, 27 Mar 2026 at 03:54, Aaron Esau <aaron1esau@gmail.com> wrote:
> >>
> >> Puranjay Mohan <puranjay12@gmail.com> writes:
> >>
> >> > Yes, if all the users have BPF_F_LOCK then it will work because the
> >> > re-used element will have the same lock and everything is serialized.
> >> > But this reproducer is trying to show that the elements are being
> >> > re-used, which they are.
> >>
> >> Updated reproducer attached. All operations now use BPF_F_LOCK (updates,
> >> re-add after delete, and lookups), so value access is serialized via the
> >> element's embedded spin_lock. The value size is ~4000 bytes. Torn writes
> >> are still observed (3 in 2.7M).
> >>
> >> With full spin_lock coverage, the only remaining unlocked write path is
> >> alloc_htab_elem() -> copy_map_value(), which copies into a newly
> >> allocated element prior to insertion. For this to race with a locked
> >> reader or writer, the reader must be dereferencing a stale pointer to
> >> memory that has been freed and reallocated -- a use-after-free.
> >>
> >> The root cause is bpf_mem_cache_free() in htab_elem_free(), which
> >> immediately returns memory to the per-CPU freelist rather than deferring
> >> via RCU. This allows reuse while the syscall path is still within an RCU
> >> read-side critical section. Preallocated maps do not have this problem
> >> because freed elements remain within a pool of valid htab_elems.
> >>
> >> Switching to bpf_mem_cache_free_rcu(), as Puranjay showed earlier in this
> >> thread, eliminates the corruption.
> >
> > As I said, the reuse is intended behavior. We won't be switching to
> > bpf_mem_cache_free_rcu().
> > This is mostly for performance reasons, in case you're perplexed as to why.
> > That said, we could do copy_map_value_locked() if map_flags &
> > BPF_F_LOCK to fix this particular case.
> > Such that if the value is being reused we will still have serialization.
> I think we should do copy_map_value_locked() on the reuse path.

Do you want to follow up on this? Otherwise I will get to it
eventually, either way is fine.
Thanks
