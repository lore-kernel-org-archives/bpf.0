Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535516;
	b=yV0V9KNJDRXtTBi/VH7KTZ6dDN0d0YeZ3JTAxf0MafPnA6bqGcuCQiRAjAH8ZTBmuqIm
	 2/XJ2Kv88IXyW3DTa+GosClFEUPUn+hKAbXWE0ZuZWat+vpGGpCMG8xoPs3Z8xIH3oV5F
	 ezeOC5txjtztN8F95yNUt+71t5STwLZfkho49aSgyp/aHsng1McXi5+GFBD4weuMjaqms
	 oBVJQ4QqayKQtplplVrT+Y/RJgIBIMaaH4wAmz0R4mJPAtUxzydtFMEc6R+1V7NTbGI12
	 mCcXdXLIEQ6IM362Bq/l3x3q3F6ZkHXSrY7eEWqCawXWTUhrqeAsExS9mjEtuEt7zxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
	b=a7fkwBgajPC8hottz1aLiqVmloOrosJQGy3C6kJKVf8ZaOYVM8g/J+fq+iHgacQPURYk
	 catOyfcMduikxr2egj7heLyYYH1GgNZzCtjkt/Aa5u4zvxS5xJAS/m5XQaXaIzhEZLUWN
	 pFu+NWj+bMgtHyk1Q7uBMR+hnLxgXKEW6gtXMe+GbozOwqCAhb5sBcVh1joaNxK34CzxG
	 STK/Ci6RCJqMD2hKQI0uZV9NX3GfzRx/CqYxCjHaaJQHM2KpdVzvDNZdw53GiQPbSivik
	 Lk2tfsLb4Pv5YM6kVm8bHB6bMpDr0yF727vEvVppTdd0ZNYNkzpAYxeNCl8AkVHtSoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gYnNBYPL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5774606A33F
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5774606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gYnNBYPL
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55c7445cf85so844531cf.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535515; cv=none;
        d=google.com; s=arc-20260327;
        b=JzB2heNdZD4d/DUFDnTenOfHauc87h19PiCRiDo7eO+WQTP9Cyr60pixVTn2gnpbcA
         kL2ppPX7XZolNvV/7/h7DTL5526KDM8W1/gCgSs5v0pYcLjO55wGuA3NHZBCHnEcWwK+
         C8VQS4B7rvW9PWfYowxyfcQOv9Ou0C2pcGEwU7avdbnKo12bH4YQRbHGkYIKxhyeOhAW
         XnshxQPV+TqxPXogjh8xX0JWa474aqfB5qdhW9XpYVGNEsBd2/CuHTFnQrX3xqlyG+DP
         irSRDvW7FuOGS+RaK0T680sHbXFm8rXuIPwEj2YOHz9g/2it3FHwyKd9vNsLr92uX/nW
         7xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        fh=WHdc3jo5t5xiVK8e0qbr8+qMYnZlD480JOuNmPpsiDk=;
        b=arlh1QhJ/6RtC1Kq8x3RSPRhWaoh0HR/kIz2yALee7OutrLshCn5NTd729O9f3nskq
         KNwUGzXx5g+9LxyyRU/1aEC8ygpohgzJH062ZwfgPy9QiNCri1U2cGIKbrRyap2wsWpQ
         PBzpv1EZPQXSqV/AFRg4usw4/eAAEhtKflEqWlSApnLjlEEPsONZCChPuq1NSljTCdt+
         r4C4oEQlIsZjN/T0s9eMKBDvNn8O6dXgYfRcffu/toEJ8hqWnVAFto+pHHqNEsdrt6T5
         Bsn7UPclrsmW+jWrM9vgd+4zOL7FNCgyhxl3JS/Bp73A96muMJpp0E7Jil8ervSdKhCp
         hFfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795535515; x=1796140315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        b=gYnNBYPL7+Vso9fth4O30mUOQnoyOn3TOxaH9pHwo3lJTeahoBTFFJ5Q4/9eecco3H
         Ei5saRYpH5syTy8Ucfen49s3IrZ6ufTDp7Jou0Th3k2HyFxIJKuquydsppJKH4SGMEjF
         HTZubH7A6s2bHrdMaC4HirlYiCHKQcI902r4H/ZRXJY6fz8xJvDKDtYJePSACZsBHv14
         bMjd8WVjudy7rk63YHILKKkSr7ncJl9G/Xme/p6omTSsGdT9GmVnoeXf25YlOiog8Woe
         rWBB4pd/bzw+HjhbkCcGqhITw0ZbFKeDkdfijEEYca3CYnWtfdJte6D3j1fC27fTgu9B
         zdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535515; x=1796140315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7151zgqNmppt1FWLTyRdRTu2s96pKFEly/RuS9gjWeY=;
        b=OYketgYu5cJeqyIulJfTpOHQuOeT1LlfDn5uxX4UP6f0JSnpUQgQHwI1DPMqir3hD4
         mxqZJvAWBd40SYkN89Oal+ckPB6J+jfSa987+UfZkYlz5HD4GYnLRp6qkqEmoyWDL7gT
         o70gak9ORS4ZxrzWx6Q6q7H1SVTfcZ9gJSwyBN6Uub+dVfAErH3QiwQP1S0Ie9SvWl8G
         XmCl2Jq+l1/p4dEbUv3SzKrIuiQkVSfbBrN0Vg/9EMuaUbShCQEWa+0tzzZX1ud6CPaf
         AXE9QcrrZOlEE0X0l/fFhgPB2Ai4Zg1gpnOkwP5yrS/B+VYiNm/S2ajdMA15e56DS/hf
         hpbw==
X-Forwarded-Encrypted: i=1; AL+hErHAMFssHRI+nwUam55ESy3EdMea0W4PmERQWWBr72g4ANyUAVfXj25n7bcKGdJE6vmLeR4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H5PM8BYg4RMx6ESqlggv5uNnSau/gn+1dYHen2xEh3eTAVz+4
	rWWvqtbE27Nml/X3ixNUss3Oe7qjKGeb2uglr7AAaXNBGV4E7G4BZHH8GJ6AB+8FfxOgXMG7IHx
	m8zI8RLv0EmrRNBefJGQmAD/A5aUOfZCteFMmRkTu
X-Gm-Gg: AZFdTZdk+zXCh21x+ojX8JD5ZgxwGumuUqcT7MVHS1RIBghKwMmQXo/ttfeMaDMCXKl
	a/XsFZKHmoZdRQg5bY74JbinOpLh4xexAHzZG14lSu4PJirsogyUAJ0HFzEeBXbotY5QsUpntjL
	gTF2Zd4VFVOmtyeR23/GV8qiewEk1VPm5/fsJ4F57R7sabEniC0LVfmljjtjPavTnc4rboeoryA
	uKoAj8WYqpT+WyTxalnOF8Wki/qopQegLBlPBvgnPEmyOAk2fkEcHvo17IfZX+eafghvGJRx+Qw
	3kAgE6rfR4vTQ4H8fOfjWLaASAfzTztcNAGfWzrxEKJd3XeOxhYjTNDW5/RC1RxJ0i9edbiFII0
	AN+ILakKHMLdZgxWyMVdd1qW2n4V/1sdmuYRpxa9sfpKvKRTPqGNbk7AqysP1Grk4nTkOUfWcNP
	omj7PqArEPhITDX9gs+/V/a6rKkOs=
X-Received: by 2002:a05:622a:4819:b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-55d8903863bmr55786151cf.11.1795535514050; Tue, 24 Nov 2026
 07:51:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
In-Reply-To: <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 07:51:42 -0800
X-Gm-Features: Aa3M54qQPEWg8Xv6M1FeAv2Yk0G2ClZoOWgLEIXc3iRWC6ZsNwo9TmRawceulIU
Message-ID: <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 7:46=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Nov 24, 2026 at 5:04=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> =
wrote:
> >
> > On Tue, Nov 24, 2026 at 12:26:19PM +0000, Lorenzo Stoakes (ARM) wrote:
> > > Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> > > per-VMA locks") open-codes a lock_next_vma() implementation that does
> > > roughly the same thing in bpf_iter_task_vma_find_next(), only without
> > > fallback to an mmap_lock.
> > >
> > > This is because bpf_iter_task_vma_find_next() can be called from
> > > non-sleepable contexts.
> > >
> > > However, lock_vma_under_rcu() gave no guarantee as to which contexts =
it is
> > > safe to be called from, and indeed it turns out this assumption is un=
safe.
> > >
> > > Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> > > vma->vm_refcnt got dropped"), this call chain is possible on x86:
> > >
> > > lock_vma_under_rcu()
> > >   -> vma_start_read()
> > >     -> mmdrop()
> > >       -> __mmdrop()
> > >         -> mm_free_pgd()
> > >           -> pgd_free()
> > >             -> pgd_dtor()
> > >               -> spin_lock(&pgd_lock)
> > >
> > > Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> > > called. Since bpf_iter_task_vma_find_next() can be called in softirq
> > > context, this can deadlock, for example:
> > >
> > > pgd_alloc()
> > >   -> spin_lock(&pgd_lock)
> > >     <softirq>
> > >     bpf_iter_task_vma_next()
> > >       -> lock_vma_under_rcu()
> > >         ...
> > >         -> spin_lock(&pgd_lock) [ DEADLOCK ]
> > >
> > > Alexei Starovoitov also pointed out that a BPF program attached to
> > > trace_contention_end() can similarly cause a deadlock:
> > >
> > >   pgd_alloc()
> > >     spin_lock(&pgd_lock)
> > >       queued_spin_lock_slowpath()
> > >         trace_contention_end()          <- pgd_lock is held
> > >           tp_btf/contention_end prog
> > >             bpf_iter_task_vma_next()
> > >               lock_vma_under_rcu()
> > >                 vma_start_read()
> > >                   mmdrop(other_mm)      <- last put takes pgd_lock ag=
ain
> > >
> > > Resolve the issue by having vma_start_read() use mmdrop_async() inste=
ad of
> > > mmdrop() so the work is deferred to a work queue.
> > >
> > > Make mmdrop_async() an internal mm function, defined in mm/internal.h=
, to
> > > avoid abuse elsewhere (kernel/fork.c includes this header, so still r=
etains
> > > access).
> > >
> > > Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> > > failure") accounted for the fact that the RCU lock had to be dropped =
for
> > > this operation, which is no longer applicable.
> > >
> > > For the sake of a backported fix, retain this behaviour, however drop=
 the
> > > RCU lock last and remove the now irrelevant comment.
> >
> > Is there any particular reason for unlocking the RCU comment last? afte=
r the mmdrop_async().
>
> Yeah, I think moving the RCU unlocking was unnecessary (unlock as soon
> as possible is in general advisable) and we could just remove the
> comment. Both versions however seem correct to me.

Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
that RCU unlocking move you don't need other_mm copy and the comment
that comes with it. VMA won't be freed until RCU lock is dropped.

>
> >
> > >
> > > Reported-by: Chris Mason <mason@kernel.org>
> > > Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to=
 per-VMA locks")
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.co=
m/
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > Acked-by: Pedro Falcato <pfalcato@suse.de>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> >
> > --
> > Pedro
