Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCD14AD2B
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074831; cv=none; b=NZEsvJN6hxmNsuQoFksQoqYodFLV/mHPdUq2kalrk/Mq13O4xNEGHmBTTfjZN8DkoaseEAAHXjGHIguFo0Yv2JHojtGF1T+ojGAuaLcnSty/Y3cL/mbXCFO/xVP33YJ/jddTD2QL8zMIpgm+u9mgOXMIprFsNNNr6eUyXPL2jUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074831; c=relaxed/simple;
	bh=z/KJVyiqAa9gIa2YhrrUbN4MxVqSjTh0Dx1IN0t9U4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELWB1RO311IOn4xz57s2A4JhwEndt66yYVncUQF1YjoGaCQz2bZ3BZhqBji3dvTAvzTH5rOMgzVaV4EGaSO2CDRHcng5xJBIOkbzGGZ2K85T2+W7N7Q/GXWIL7ykn2tIvI3PlQ6H7lAiZpr47lw9kp7b9w0lo/SoM//ZHEHo6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ7/5XV5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ7/5XV5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so4204797b3a.2
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712074829; x=1712679629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXVdm6NRIVL1Z5CaAdvokLibhdLOFBh1zceZB3bMrsI=;
        b=lJ7/5XV5uQIQYTUYU4O6/ocXYeK2g/q6dsyXwv5CKRLD1tEozmeJe3+uBbokB8kH52
         Rg31rk7Fcn+hIsbq5GC02zcqLPp3qC82ix+uiaj5iH3toZXk1zRiRmG+DDA/lb9U4gmx
         9cD6YxYz1ZhFRCpRZAxC8uhuKlQyoe/oHE9Zh5BXEiweCWbniAsxdyI+VAFU9SvAuzEV
         1JK8x2AxSfw4pkosJopFUTgUOpVDI+KJuXq6BngW8i+utQOG1oXCiHfxajG0IDkwn5fV
         J2iKdkjZFJKWe9ck7qVM02HMMIapOchJ6/KxI8k5DLUhN51swhtYTwG2b7nPr85DvBIN
         SRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074829; x=1712679629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXVdm6NRIVL1Z5CaAdvokLibhdLOFBh1zceZB3bMrsI=;
        b=eIocXcptyaUyWrSD2qT5F/LcU5Kd0FHOWp0FSWvESdR0ybdo8sygeDO3NIh1vDpdvP
         inUlLFXWKHRls/BVToJ01IFdgiBdEWjUtGbo9GbzdBuu0hJnkTBLObv6eP9qMWKHWLX0
         5BrnjHKaB0dyTm7gLnkLe/ogs5dZCKdpjv8XcgntIEpaL1s8IFgkJpGoCtejoj8MiMUk
         fABLJ/n0clZ1N3lGvdz3Pm7s1/EvChWgOq7Yq10MHU90M/5WV63PVHSXl6Vdt9Ut0ZDD
         6IkQcFcXPADmkGSu83kBWQ8X73VHBZJfTElQGexfeGZC5XHhuoSIMW5aqR7dgKFKR/um
         QbGA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjJaVlssAZQ/aacg4aHzZyf6pxbT3S4RGITjZaV2iqmi2/3N5uSB4LbFW5cbsLGTOm9tnhivzEm/HeWdBO/t7vkZn
X-Gm-Message-State: AOJu0Yziei0WfUeP9E0gTXTKUlxujoE9/fFBmO5kB878H/+5pNNQTIFh
	BBEbzYadUZbJ13QrOCvZw/PqOdhC4fAIDPkQHZA0QsLwxfXjRbHW/+oRLLhMwHIQxKsgsgnthPJ
	VRlwVLnHGWihm2FRFKU0PVqUnKaugRNuFbPs=
X-Google-Smtp-Source: AGHT+IHEVzUXMDBU29LZsVaMrW3BeBswBA7LD5ywSKh7dVTxkcbv6bO+9kHV6VUmIlAamqxjjSI3LrXAybv1MyDDvd0=
X-Received: by 2002:a05:6a20:1589:b0:1a3:15e8:7e93 with SMTP id
 h9-20020a056a20158900b001a315e87e93mr16162522pzj.56.1712074828712; Tue, 02
 Apr 2024 09:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <660b9038bde52_1af77208d3@john.notmuch>
In-Reply-To: <660b9038bde52_1af77208d3@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 09:20:16 -0700
Message-ID: <CAEf4BzaEJjosWJFVZw=vKy+rK2VxB6DsB2pHbsz-3ME7Gn0t2g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 9:57=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Andrii Nakryiko wrote:
> > Add a new BPF instruction for resolving per-CPU memory addresses.
> >
> > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per=
-CPU offset
> > to an absolute address where per-CPU data resides for "this" CPU.
> >
> > This patch set implements support for it in x86-64 BPF JIT only.
> >
> > Using the new instruction, we also implement inlining for three cases:
> >   - bpf_get_smp_processor_id(), which allows to avoid unnecessary trivi=
al
> >     function call, saving a bit of performance and also not polluting L=
BR
> >     records with unnecessary function call/return records;
> >   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bringin=
g its
> >     performance to implementing per-CPU data structures using global va=
riables
> >     in BPF (which is an awesome improvement, see benchmarks below);
> >   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just like=
 the
> >     same for non-PERCPU HASH map; this still saves a bit of overhead.
> >
> > To validate performance benefits, I hacked together a tiny benchmark do=
ing
> > only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU_A=
RRAY
> > (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) ma=
ps. To
> > establish a baseline, I also implemented logic similar to PERCPU_ARRAY =
based
> > on global variable array using bpf_get_smp_processor_id() to index arra=
y for
> > current CPU (glob-arr-inc benchmark below).
> >
> > BEFORE
> > =3D=3D=3D=3D=3D=3D
> > glob-arr-inc   :  163.685 =C2=B1 0.092M/s
> > arr-inc        :  138.096 =C2=B1 0.160M/s
> > hash-inc       :   66.855 =C2=B1 0.123M/s
> >
> > AFTER
> > =3D=3D=3D=3D=3D
> > glob-arr-inc   :  173.921 =C2=B1 0.039M/s (+6%)
> > arr-inc        :  170.729 =C2=B1 0.210M/s (+23.7%)
> > hash-inc       :   68.673 =C2=B1 0.070M/s (+2.7%)
> >
> > As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while glob=
al
> > array-based gets a nice +6% due to inlining of bpf_get_smp_processor_id=
().
> >
> > But what's really important is that arr-inc benchmark basically catches=
 up
> > with glob-arr-inc, resulting in +23.7% improvement. This means that in
> > practice it won't be necessary to avoid PERCPU_ARRAY anymore if perform=
ance is
> > critical (e.g., high-frequent stats collection, which is often a practi=
cal use
> > for PERCPU_ARRAY today).
>
> Out of curiousity did we consider exposing this instruction outside inter=
nal
> inlining? It seems it would help compiler some to not believe its doing a
> function call.

We decided to start as internal-only to try it out and get inlining
benefits, without being stuck in a longer discussion to define the
exact user-visible semantics, guarantees, etc. Given this instruction
calculates memory addresses that are meant to be dereferenced
directly, we'd need to be careful to make sure all the safety aspects
are carefully considered.

Though you reminded me that we should probably also implement inlining
of bpf_this_cpu_ptr() and maybe even bpf_per_cpu_ptr() (I'll need to
double-check how arbitrary CPU address is calculated). Maybe as a
follow up.

>
> We could do some runtime rewrites to find the address for global vars for
> example.
>
> FWIW I don't think one should block this necessarily perhaps as follow up=
?
> Or at least worth considering if I didn't miss some reason its not
> plausible.

No blocker in principle, but certainly we'd need to be more careful if
we expose the instruction to users.

>
> >
> > v1->v2:
> >   - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
> >   - dropped the direct per-CPU memory read instruction, it can always b=
e added
> >     back, if necessary;
> >   - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei);
> >   - switched all per-cpu addr casts to (unsigned long) to avoid sparse
> >     warnings.
> >
> > Andrii Nakryiko (4):
> >   bpf: add special internal-only MOV instruction to resolve per-CPU
> >     addrs
> >   bpf: inline bpf_get_smp_processor_id() helper
> >   bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
> >   bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
> >
> >  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
> >  include/linux/filter.h      | 20 ++++++++++++++++++++
> >  kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/core.c           |  5 +++++
> >  kernel/bpf/disasm.c         | 14 ++++++++++++++
> >  kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
> >  kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
> >  7 files changed, 133 insertions(+)
> >
> > --
> > 2.43.0
> >
> >
>
>
