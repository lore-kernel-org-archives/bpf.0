Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892383CA5
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247417; cv=none; b=F7su+8DMRgkoNXOga9doUUZfZfkYghlzXlOneR+xy701YSDedrZZfTsdLbgQyBKEY9I/qIC4s6/d9mQPeGJSoDxlSQ91cddWgGaY7KDHjWy/rj3RVnyiJBPp3+fA9P778bF0ysZyWMD7q8UTqlbPVhD0W5uu9M+j4/o9WKWpz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247417; c=relaxed/simple;
	bh=PCddXXOy2HutqLm1qQwd4K9hUi9lzQ8yo7HSsQuO1g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khWoOaUEYnuhhMuPCgLZps7UBYCwQTv+OmlP5l2rh+01aaeeYOsqr25obF7H8+c+xYE5IfGyHknNMs6ROfnFcV7yntjtFquT6pYDvn4bzZv+Bhb5nQA3cDKLDO8gQQlxUKvOugsUAmunFOkOgRKf9ttLqOZpqoxofQZCj/HOSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9NzaY7W; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9NzaY7W"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d68651e253so15769621fa.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712247413; x=1712852213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQr6dq4DI3qJ1fZn2o9aYnTAk0j74/exWGSH84pdXLo=;
        b=J9NzaY7WQmq+ZlshYjbyu2vSqVEAQ3uUG3TpDKzUAr2z/PsCoHT5VRyO4cFKlwF5nI
         /Nt9GmzvDJBfJNH2/9zjBzH+Y0JG4XQXZGLm1It8336+8VZC8pX3arWaYWTe6TFBSFbu
         Qmjtv5FTzuP3d/Z0LK30R2N2pQBpWeSw520YvrIQ6Lx0S6JoyO9MhiOx9MAbBDmI+1Mr
         BOYr1Lr9DMdfsq2ZkJWXfpUGa+Eqg7c78SjFscTq/kYVs0/LLwjTtdixK6nAoURdw3Lp
         qrHPT4MZBd4tefYIE1fNrEM3O1A1nNptvgNH5EIG/lMueqbOs9bOrruhdUBL3ffWC2cV
         8QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247413; x=1712852213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQr6dq4DI3qJ1fZn2o9aYnTAk0j74/exWGSH84pdXLo=;
        b=ZxEgARPY7fgXraxTMmIiOHmQGtAEtY7QF1IbaVenuuf1j1f5RsduE28cP0nOfzWhCE
         XjbGwbnezDDkJ9qs5GrmMAfNBvuSV1/Dlsa1pay4qyt8F04SqMjJhNSEXhhjj0nfB1Iu
         adqXCS5buXTJxV80ZzQWBh1Opx/O7i76WWg9tSvqmT6+cQFmYnSRMJovIhc9e3/Muq1R
         b2SBCTdHJ58LKmJmGYZu3W7TCKq91G7FLRSLglBmo9RYKYTez+F2lmVLP32acCYnsLba
         TStEjtlr/oXvrtFTM25RN5DHKJPwWGfS1LCFzOqzUuGGKbqYm/gMnOLkaZ0POOm2W7Qm
         USXg==
X-Forwarded-Encrypted: i=1; AJvYcCWrfXSp0J8+MDBtxKdLqfHLZJTOUzQz69FHX61i1S6tENF1warXHVJwvcg6XkzF6WwBOopdfsiPyXPM22Dzc/EcN0Mv
X-Gm-Message-State: AOJu0Yx6jP9P2MkcdFfYSYF5imvw/ZZD8lbLkR8m27VhghQilm5D/7uj
	AU2ReMPkSpp4+I0qRiDcUal/Uxlk+PSjONfvVo4x0sPc3mSiO7iHXCCafwGe/vHQ1zFmllp8Xj4
	8NUDd2J/SgjlO0Vaj550ED/bN5nCdU0cq5xYdtg==
X-Google-Smtp-Source: AGHT+IGG9G68f7edJBGe7kPztanpzQATW2dRiGS+s/BBq/lnYr6kb4JiqekQkLkSk4ziz9hHUKgtqu7aYZEQT2N3ZZk=
X-Received: by 2002:a2e:7217:0:b0:2d8:4a22:7530 with SMTP id
 n23-20020a2e7217000000b002d84a227530mr2063963ljc.19.1712247413193; Thu, 04
 Apr 2024 09:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
In-Reply-To: <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 4 Apr 2024 18:16:41 +0200
Message-ID: <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
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
>
> Puranjay, Pu,
>
> Is this something you guys can help implement for ARM64 and RISC-V
> architectures as well? I'm lacking the knowledge of the specifics of
> this architecture to be able to do this by myself, but it is a nice
> improvement for BPF applications, so it would be nice to get wide
> architecture support.
>
> Thank you!

I have already started implementing this on ARM64,

Pu, can you do it for RISC-V? If you don't have cycles then I could do it a=
fter
finishing ARM64.

Thanks,
Puranjay
