Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12A15099C
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181663; cv=none; b=lKBFVr04eUzYf76oCmufX9tmS7Wvyex/5MQPVVdSZ1tiWBIgZezY2OUSZzh9sF0SSHf4WthrJWB9Q69ITGnE1JABYWQesoJGECf4FwLQUa1eAG6kAFtJwgFJlfScpIBhORlyFudRUODVelFwYw+IgxxRh5GsIuNPjuLaKYFgExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181663; c=relaxed/simple;
	bh=pBj+vj0qe37L+5V1lxI3yUZXk/AGmqm3rAfrzBbYm80=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FQyqDxv7rU8tQzMoc4jmO/bFerH0r7RkEs40ZDrcnH9j6rokmH2/nC8027bujnyqUNUar7w98LDUmPQdpOjv1s9IIOCaelLqmEBkhdfUtPY0FjoeKbdGlJrucZ2LL/q5lzUXRUDPj53wWppfDWOOG1uqqzV3ZvR8mG53BAegTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyfOFHUC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyfOFHUC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e709e0c123so262367b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712181661; x=1712786461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFNgWJwm25apMH0YDKE2mUhHRmJOi59ALD4ncX3hvUo=;
        b=gyfOFHUCx440MqBa0ci83f6KqJ+YLYXpeurLhctS1MmFZGbOwIocSHzPHNvXJUDjCv
         ltieezd2MZL/cNIv3EMd1EsVUHWLQRNbXRhdCnwaOvGMUpswRStyChrhz9D3/HsQNF+3
         9WmVvT8SShTNucUKw7nRz5prRpBTKzxLfhQdA64zjqnYbcbEt5ETKwRb6w0hPLtE/M19
         IsO22YJyq5YlTKAqdJOBeqBulvdnbZW9KT0gYTc5XG6YxdZ1YaeGkp5L5lpFsZBfdNR1
         5Nu2AONl8UMXyLAahQ/Cr2jMXkOj49tFeC/Fy9esDq8j6EjSJBmWNlYqJ9Z4hKC/6RiX
         3vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181661; x=1712786461;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFNgWJwm25apMH0YDKE2mUhHRmJOi59ALD4ncX3hvUo=;
        b=IN+Fx4yGMfDSQJOalbB5OsCIhzz3euVKBg05t1M1AQ1X3PQC061gKkfLmO3f0OfQs6
         f01rsuAhan8pLmJI0bMXVuI98N8W8WtxSkzvg/TvNXw4QBGideSGFLpR/gqDmtOyHn19
         kzSX0xdNZd/h5NxgIKBKRNiFYv9ZVhp3zbs1hl1cmbNGlksDncGmQaA9PV+tWlHzzgBU
         pelBBNbLCKJopgxIrtIZaTsEjtTmZ1D/E+zyP06MtaQh28VdDZr4WY8hzDvHjrVKZ0z1
         uMsPJT1g0aOlkCd6FGWhv0F/ZGjTTfgApCMy5wEiwMjumc+qGge4gxGKNBMEqrPD+3eE
         e0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU0m77Ywsrbhk0BOHr03+JJWJKm4sznZI4KATzhmcEMryHS0rsH02IDRD4YC6XCB3Tftt7EeUybN2rVTY2UUOw66kAD
X-Gm-Message-State: AOJu0YyVSy8VjUOQB9DqtmPh0cUGPy5gMV4GpNBXuHp1Dct5eYx/DTdJ
	b78ir4V8ur02CwWU8SJXNbmvNjJANE70aC8kTJlwh0LJEEZC04b1
X-Google-Smtp-Source: AGHT+IG1EvvAhksLIQY0JOP7aUndFfk/j08xjf8P7P4BXXSvzWnsToziZy8oslsHwYMu+khPFtHF5g==
X-Received: by 2002:a05:6a00:2351:b0:6ea:c634:ca0f with SMTP id j17-20020a056a00235100b006eac634ca0fmr836256pfj.21.1712181661302;
        Wed, 03 Apr 2024 15:01:01 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b006e6c856c0f3sm12324621pfn.188.2024.04.03.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:01:00 -0700 (PDT)
Date: Wed, 03 Apr 2024 15:01:00 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org, 
 kernel-team@meta.com
Message-ID: <660dd19c1a43a_21448208d8@john.notmuch>
In-Reply-To: <CAEf4BzaEJjosWJFVZw=vKy+rK2VxB6DsB2pHbsz-3ME7Gn0t2g@mail.gmail.com>
References: <20240402021307.1012571-1-andrii@kernel.org>
 <660b9038bde52_1af77208d3@john.notmuch>
 <CAEf4BzaEJjosWJFVZw=vKy+rK2VxB6DsB2pHbsz-3ME7Gn0t2g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Mon, Apr 1, 2024 at 9:57=E2=80=AFPM John Fastabend <john.fastabend@g=
mail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > Add a new BPF instruction for resolving per-CPU memory addresses.
> > >
> > > New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, =
with
> > > insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided=
 per-CPU offset
> > > to an absolute address where per-CPU data resides for "this" CPU.
> > >
> > > This patch set implements support for it in x86-64 BPF JIT only.
> > >
> > > Using the new instruction, we also implement inlining for three cas=
es:
> > >   - bpf_get_smp_processor_id(), which allows to avoid unnecessary t=
rivial
> > >     function call, saving a bit of performance and also not polluti=
ng LBR
> > >     records with unnecessary function call/return records;
> > >   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bri=
nging its
> > >     performance to implementing per-CPU data structures using globa=
l variables
> > >     in BPF (which is an awesome improvement, see benchmarks below);=

> > >   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just =
like the
> > >     same for non-PERCPU HASH map; this still saves a bit of overhea=
d.
> > >
> > > To validate performance benefits, I hacked together a tiny benchmar=
k doing
> > > only bpf_map_lookup_elem() and incrementing the value by 1 for PERC=
PU_ARRAY
> > > (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below=
) maps. To
> > > establish a baseline, I also implemented logic similar to PERCPU_AR=
RAY based
> > > on global variable array using bpf_get_smp_processor_id() to index =
array for
> > > current CPU (glob-arr-inc benchmark below).
> > >
> > > BEFORE
> > > =3D=3D=3D=3D=3D=3D
> > > glob-arr-inc   :  163.685 =C2=B1 0.092M/s
> > > arr-inc        :  138.096 =C2=B1 0.160M/s
> > > hash-inc       :   66.855 =C2=B1 0.123M/s
> > >
> > > AFTER
> > > =3D=3D=3D=3D=3D
> > > glob-arr-inc   :  173.921 =C2=B1 0.039M/s (+6%)
> > > arr-inc        :  170.729 =C2=B1 0.210M/s (+23.7%)
> > > hash-inc       :   68.673 =C2=B1 0.070M/s (+2.7%)
> > >
> > > As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while =
global
> > > array-based gets a nice +6% due to inlining of bpf_get_smp_processo=
r_id().
> > >
> > > But what's really important is that arr-inc benchmark basically cat=
ches up
> > > with glob-arr-inc, resulting in +23.7% improvement. This means that=
 in
> > > practice it won't be necessary to avoid PERCPU_ARRAY anymore if per=
formance is
> > > critical (e.g., high-frequent stats collection, which is often a pr=
actical use
> > > for PERCPU_ARRAY today).
> >
> > Out of curiousity did we consider exposing this instruction outside i=
nternal
> > inlining? It seems it would help compiler some to not believe its doi=
ng a
> > function call.
> =

> We decided to start as internal-only to try it out and get inlining
> benefits, without being stuck in a longer discussion to define the
> exact user-visible semantics, guarantees, etc. Given this instruction
> calculates memory addresses that are meant to be dereferenced
> directly, we'd need to be careful to make sure all the safety aspects
> are carefully considered.
> =

> Though you reminded me that we should probably also implement inlining
> of bpf_this_cpu_ptr() and maybe even bpf_per_cpu_ptr() (I'll need to
> double-check how arbitrary CPU address is calculated). Maybe as a
> follow up.
> =

> >
> > We could do some runtime rewrites to find the address for global vars=
 for
> > example.
> >
> > FWIW I don't think one should block this necessarily perhaps as follo=
w up?
> > Or at least worth considering if I didn't miss some reason its not
> > plausible.
> =

> No blocker in principle, but certainly we'd need to be more careful if
> we expose the instruction to users.

All sounds good that was my understanding as well.

I see it got merged but for what its worth I went through and ran some
of this and rest of patches lgtm,

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Tested-by: John Fastabend <john.fastabend@gmail.com>

> =

> >
> > >
> > > v1->v2:
> > >   - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
> > >   - dropped the direct per-CPU memory read instruction, it can alwa=
ys be added
> > >     back, if necessary;
> > >   - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei)=
;
> > >   - switched all per-cpu addr casts to (unsigned long) to avoid spa=
rse
> > >     warnings.
> > >
> > > Andrii Nakryiko (4):
> > >   bpf: add special internal-only MOV instruction to resolve per-CPU=

> > >     addrs
> > >   bpf: inline bpf_get_smp_processor_id() helper
> > >   bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
> > >   bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
> > >
> > >  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
> > >  include/linux/filter.h      | 20 ++++++++++++++++++++
> > >  kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++=

> > >  kernel/bpf/core.c           |  5 +++++
> > >  kernel/bpf/disasm.c         | 14 ++++++++++++++
> > >  kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
> > >  kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
> > >  7 files changed, 133 insertions(+)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
> >


