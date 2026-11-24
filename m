Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535178;
	b=SUYNDua/Gjy1Hx2E8GNn1sCD9VUq9RWVrOek2LCaAtLtiJs2TX/NzxHKr37aztj9zo1p
	 ZF2wcR5SaEqs7LunUSgGfsfyM0sIluyfY5I39JTAizz/YNFXNHHZv945dMc8ya1xsa2bQ
	 JM25aGqlEmET04vsel8SxCK5V959LlutfmK3myotvb9X95hrzjEgnfaXQV/wn78Ypzpj2
	 X8Uv21CHFjNghYmW6RLTQGLJKbX1GDseL9BNaALD7npffRgjLrrpeFd9LSoz45gQnTH3S
	 nVTVzMdf2+nlPwMdHS5hMm/ICQcASVtrCgBUnXH22oIUw5DhkkmIs3lWf5ryJFsRqHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
	b=Wydn/gx5iHPwy9EcSSqdmbfUQj8FH3vMNrLzILyC7GessebR4C+RgUhbmGo+lm3uK55l
	 +QS6c5JEePp/WcEF0JBXTRImPlbEMpJuGUVPun/pFwKG/1k0NcxMXe8t471/0knDtix/c
	 f3lj4d4FICU4BKeYT8oBTL0G7d2cIdzye9y7ZRiHZawTXdViLhQ8T57RkRzwKHIG6Hu7A
	 6KNwTs8IkPT9rDoqe94E4BG7MfUGYvUNYm1a4CzdDe0r/bDMf0tGIAOutkHzoP3SStFal
	 gwGVmjnxBKtdDtT5hVNRFVGgNYbGBgXth2BJl7AoAS51Gh+QOtN4RcpPhTenSXlV/2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=esU7yeLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FB606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611FB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=esU7yeLt
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55c7445cf85so842171cf.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535176; cv=none;
        d=google.com; s=arc-20260327;
        b=U0GBtuP0dV0c2QNGFMYSo4V7AuHkdRHKWohOpi7547hG8i0a7GYYrEPx9EooDnOWJL
         gPEk8LOdqzq7aBj2MHuOPB+0XumLrGlxxfNL78MCEUUqFcBujTA3bFqi9xjk6Jo7dv0+
         pOPJ0dI/pbj8DhTkBChwDDPyAZgvlVBr0T+udRx/8cUDP+6i8EkljpkSDGeEL66R2s+C
         fX5lsDmpJaT2sRyylOupnaQ31Yb4vrTszVEBiwg9jfoxLntoG7wNI6gp9Hex2hmiShXe
         BkQhrQ16BZZR6RMzHtDKXEhaqp8mkqfbrFSl0iO7Am3YwsuhsUIIJOucGdMufQ7y88lr
         WaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        fh=mJUo3+ziKhytYNeVPoa2SGj5P0hYy8+XgzS4nGl+IVI=;
        b=gNIqa1ZrFwr4oTS11WVQoY+ZoLCUOC7GkO7yYYU4qIcEqmwZCYTxGm8CfrMfVdxcwP
         jemVEcY+A9052z8GbL4VyPmHdPAw79EfQ+EFzYNcqM2pZHdf1OAbzGsbK9uf2Yldhsvb
         D03uaE+3xcsClSpUIw4Gojtik6XY/+Z8XbM6IIL5OOuAklSrWZ4z13tEQHghz2fzkHJM
         //Dwf6TKXFIcX1PdBoIOCs0i3TngCTfrUXSaohwgP2XLnq6poCCowdK9CaSnEP3GEI8b
         gQyGC0znhcyZRJdi95yrwKpNXcwFp/fBS/1JypPQqgkGON8yF3Vo4Uzu6SfyC++DLiGx
         +1RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795535176; x=1796139976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        b=esU7yeLt0A3qCM3mlu0xOTw9SC/PfBCz4ES1uqtiBgcLCvu8EPdvhhtkENZswX2dBI
         27GCY8pkJKMRd0c5rHWF/Ly2PldBkEJbr2gcWMljLkNqA8b1hmoK+PHKq7XHF+9mhMPB
         H8gh5cDxN/lslmNEGaOlJTY3QXCtheFFH6zeB7MsY+gU7FvozzGXEjtZGdD6/xodTAWt
         vjIBiKTI4wrMjNx8VUdzjJFyi6wV2w/wIRgNaZpMBUH9d/se0fv/7uS8CBIsjfl6MDyl
         qefokasVhLMvvDvqh4fXI/Ucp+TWswTqzpRDvje8XylCUqIC568nsIlArQ+mQXOxJwXK
         gIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535176; x=1796139976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOapY5CEQdlHxqSl9JrLPR3I2czhVi36uOATqS9W/YU=;
        b=oTa2Ay51BwhqPGMqK+NFXLEAQWQLuaprp8shM8LT9Ms5vvx+i0c/Od3oicsJzDp7RR
         eOTI2HbS1N8xh5AX0Lt7oovLHJ/MkObuoURUmCQBjUbGU2WY04gvR8ADZIlrZVW2cW3g
         h1lfWePNQ09FYKfNuHvDuX5hyPgI4JoJ5y3j2So4yEkaUmCshFyFjxK1qE9z9QuyTL9F
         d62Cet0oB2Sh4YRUEVA61a2qrFHFFiTbwBJJ4u+h1KnKwy+7SbjqH4PakLITPibjX0Cf
         kLWKK/wUaU9zccvTiuhaRvouE2fmgMCFqPXBGfa35KUO18a46i8F2NvWsKB69IwqCrCJ
         3CIA==
X-Forwarded-Encrypted: i=1; AL+hErE16/LBp6Ut3++DYkrewthr9B1wu3XZ9j5l76t6RtILMuNR5f9PxEsWctYho5TqEFwxQYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vW7ImfFFLtTEJel2dM8JAJW70b2k6ORUvBfdpKaJA4cbeyDhN
	UHZSia1LfroYJlh2xUyIfEBmUkYSsU8mgeoFodwl0v3AaDRr/8GXDPPJxEWNVLgHHybWn9WINFI
	go/Ir0FTBvBUQCUC/ItAMZV9GsR7w3JsxyyvbMAcc
X-Gm-Gg: AZFdTZf8lL4Of69E7Zpg9F1HRVPceXwLHfH0w66kuVDP6I2HHpo81nSN19AJRWhBLSY
	piVrzBIT161Ab7wvpLUmNAFQzbJ1OYz2v2Af+sS/Q/DcSobwmFmvDy2tA5nkgMsmey4en3JLUKR
	uBkOyDL4pCYjBuMUgwYxujz0vH7o1ZT1q2i4GS6TDooSm6KpQ8ZpCCE++bS36ld3cT3rivReZMr
	wym3jFdI3/Yt8pSqieouWoAfcHYXzsXdsNqqUDc9pMe0JE0sYSWzZegWmpmaCfm07rIPwBP3tJb
	cOgJXwM8wfxrxu9F7e9mAK50vwjT/n7WvHayOVkj5OT+ivN0nJQwBEvwojGmlo4bgJ37JcpYLpS
	dYIsiHZb0ipmx+N+OmTR5Y7rdA4iaWWl6gv0OLKnI3dS6UAvU41psvJINchse8/9hbJezX18Dud
	Cr+mG0hZkPlsOkFR4w0BIlygC4c4c=
X-Received: by 2002:a05:622a:1dc9:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-55d87fe2e61mr49432961cf.1.1795535175538; Tue, 24 Nov 2026
 07:46:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org> <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
In-Reply-To: <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 07:46:04 -0800
X-Gm-Features: Aa3M54rJps960eQ4ANiw2FEhSY-XIlXfbwKX87yDblku-U5-CQ5DzHJjVlODTLI
Message-ID: <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:04=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Tue, Nov 24, 2026 at 12:26:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> > Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> > per-VMA locks") open-codes a lock_next_vma() implementation that does
> > roughly the same thing in bpf_iter_task_vma_find_next(), only without
> > fallback to an mmap_lock.
> >
> > This is because bpf_iter_task_vma_find_next() can be called from
> > non-sleepable contexts.
> >
> > However, lock_vma_under_rcu() gave no guarantee as to which contexts it=
 is
> > safe to be called from, and indeed it turns out this assumption is unsa=
fe.
> >
> > Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> > vma->vm_refcnt got dropped"), this call chain is possible on x86:
> >
> > lock_vma_under_rcu()
> >   -> vma_start_read()
> >     -> mmdrop()
> >       -> __mmdrop()
> >         -> mm_free_pgd()
> >           -> pgd_free()
> >             -> pgd_dtor()
> >               -> spin_lock(&pgd_lock)
> >
> > Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> > called. Since bpf_iter_task_vma_find_next() can be called in softirq
> > context, this can deadlock, for example:
> >
> > pgd_alloc()
> >   -> spin_lock(&pgd_lock)
> >     <softirq>
> >     bpf_iter_task_vma_next()
> >       -> lock_vma_under_rcu()
> >         ...
> >         -> spin_lock(&pgd_lock) [ DEADLOCK ]
> >
> > Alexei Starovoitov also pointed out that a BPF program attached to
> > trace_contention_end() can similarly cause a deadlock:
> >
> >   pgd_alloc()
> >     spin_lock(&pgd_lock)
> >       queued_spin_lock_slowpath()
> >         trace_contention_end()          <- pgd_lock is held
> >           tp_btf/contention_end prog
> >             bpf_iter_task_vma_next()
> >               lock_vma_under_rcu()
> >                 vma_start_read()
> >                   mmdrop(other_mm)      <- last put takes pgd_lock agai=
n
> >
> > Resolve the issue by having vma_start_read() use mmdrop_async() instead=
 of
> > mmdrop() so the work is deferred to a work queue.
> >
> > Make mmdrop_async() an internal mm function, defined in mm/internal.h, =
to
> > avoid abuse elsewhere (kernel/fork.c includes this header, so still ret=
ains
> > access).
> >
> > Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> > failure") accounted for the fact that the RCU lock had to be dropped fo=
r
> > this operation, which is no longer applicable.
> >
> > For the sake of a backported fix, retain this behaviour, however drop t=
he
> > RCU lock last and remove the now irrelevant comment.
>
> Is there any particular reason for unlocking the RCU comment last? after =
the mmdrop_async().

Yeah, I think moving the RCU unlocking was unnecessary (unlock as soon
as possible is in general advisable) and we could just remove the
comment. Both versions however seem correct to me.

>
> >
> > Reported-by: Chris Mason <mason@kernel.org>
> > Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to p=
er-VMA locks")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Acked-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Pedro
