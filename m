Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8930C161
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691487; cv=pass; b=HkHHw700s5a04qxQqUitfKOT5Sjy652XR1A9+ni/AZiYy8VIe+DnQvSN9rbkXWZ1NAFv2eN41Yy4LSGX5GLGqGsaOroF4+Ozoa2pwmvh4FmFcfM/CWRpvOZfVYRzn+GyPBNM/lpRt3GUIW5k3FClxqAIySvW4eVCb0dx25lNsK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691487; c=relaxed/simple;
	bh=62wtTovHiueYQ9NH1Smsv23tVsNU365MRTK5PZgQJ8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYpqwv4UIirZzaTxAkyHVDgpe40u8KDAgtSNFiJ2sk8M12Z2VmmyxHP3a8MSs541AeVNLhHDnZPhHBi1xpMeBeU7rNt5qNvajs84ouZeOnnB/uc60uH7Q6ssnNBPr0TdEjO8X9gxie5iKpNiXsCrWXawCtH7VOwTuBKw2A2HCEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKKEB7n+; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKKEB7n+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-498012a61f6so39375e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789691483; cv=none;
        d=google.com; s=arc-20260327;
        b=DYJyXqnYCxEmo63zROyF8rAx5VmtGI01kWI/xthjF/OXPmCTK/+Hnwq3WE3gi0Y7AO
         P6mPBFY2d9sPxAyJPNvE2dA9HSG7xkbyeDYMQGOVPPeA5xPZtue8VhhcWAXfBzKx1eap
         eYxwJnfbtk6EnpKxtRq4H1jnT1kFvu8qW7+IVbs7nPT8WiC4cTEd4zRyImY0SsWjueUF
         /hOZmu0iZKqbIGDN0SRkxmQYqybofOq8dw+H6Xx80hCAAdUaIZAIOaL5GvBtCdHz0/9j
         J2R8EGcS5qcCohSBGOBtW8lZ96DxjaZGBYS8tLL8tzQ25tNSfTDAHhVRAEteat4iI6qn
         F1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aHzYQ7ZJCwWv6Ck4SmCFKGjT5hrZXZJe2/FnZIthYyw=;
        fh=OIdTDiYXifqCKY3g1f9KwwYxadLHH3EqU/xmXzkeIPY=;
        b=WNRIUcyUKJMCvRDzvwUGk3lOjYgpLIlxftT+XH//XWLc6ZiH7TQr+MreHHDvVmDSJ5
         pIao2NEE+GYpS0h469mKimsgqnfNGEUycP1TyYbj+UKIfydGkNs+tqy4mJDQhctFEaHM
         xZdAcXu764LcBCdk7kL3lQog2FxOFBucd1xn7O/pPL13QTat5yrwDJ6UtVJb+btzeUyY
         /mPzLJbcrh9llVv7k27ViiVN6UWnb1wbYKmMniDgANqF1rC2KL/kiGx7bQfG1EF+qMsU
         r1IomPMVMIiW0NYW8khpJ4YkfAT3sy2qgJoQrBqDjb16W/pFStU2o4D+iBsYXUC9Cyen
         rV6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789691483; x=1790296283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHzYQ7ZJCwWv6Ck4SmCFKGjT5hrZXZJe2/FnZIthYyw=;
        b=hKKEB7n+giNlrbNc10+CHkJmlf2Zx/vJoLmbbrM6Mu03oXxqeRYWjT76O3C3d+kpWV
         52gJWqf11fl1x4qLtTs5aDmgNH4hdjXgXtajzVo+5OUWB190DQeVz3IhqguFKFKuCOlV
         l3paSo0O0P0vpJITJrCxgdAgHr3+iui/MCMIZPev1N8QHbt/vO7qu80hw+h0H7S/OvnR
         rCLX0YUWdi2cgH5k8jA66A+nyl5jyOmdldT+oSRO6sQG/KobbZ/rVmDaCyROaKP0Txrv
         sahKa9TDTnXni6wXFnYzPqs2sYPMx7Q27ifbNhWPmiakuThvAIU3JTgRnCQuC4eKR/Ie
         UTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789691483; x=1790296283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHzYQ7ZJCwWv6Ck4SmCFKGjT5hrZXZJe2/FnZIthYyw=;
        b=bc37fVHycaLZeX+KLcZDFq8nvNZjQvPgAmcB2V+Ojk3Gaqna4ruh9Y+8IJvfzPwuF4
         7GkuU7UFjpU1Xp6evW1DC+8Y5Vb+Pmt4m3WqH4Jizyxx6Hj67aKlcCSrCn7MYTXUk74C
         fdSAOgauQ6gBT2mqJag1IttEbVOo7LJPiYpztJvhcCoQ7L1bmARVv+xgmF/saxd+4do6
         ZAxF15Mi5+ltkFM6KugUS1mk7EwhVebwL+ThX1QFc3kJoP4l7wW1JceI9IKeWYiXh652
         Ks4tjK9ZL+ZktF9Gif2wTIezv7i02p0yUP+ZbF51gd/ex93b3PK8HOy+MT2CGf4oXO0a
         v88A==
X-Forwarded-Encrypted: i=1; AKwUvBwpwd8srnHpR5nfjJARXijbgh9dPYeMmLq7hpIqk4Xhe3rBXn526p7qPnLGCixu9XU2V38=@vger.kernel.org
X-Gm-Message-State: AFuF++lD6MfkspRzGW2Vz8xFtRi202JmEKrhkO8Bvgj/F9fdX2jhRMtq
	cX5D1X0vmLBO0tIAK2q/2YcNl0up53h1RrSrlPuFOojugZP1N8HirCLzo8l1ZIT0oc2/kyTRhX5
	gPXjR6n6SOcr/t2xLLWbEpw4yLuWrp7+KH5Frl1uB
X-Gm-Gg: AYBFou1fslcKqPDX5thp7BUqppiB82B7hjFUUfgqWVuszk/oXhSRItuX8q6txz9RY6u
	GTiphLW3GqSZYPBwT2DNpXskCFnYWPeaxY0grD3yQIwK21o8sRafGOWgYR8/eAulrPTeTXY4a/Y
	6lWjpJAh2enm91D0Tj13G5MEatbJlOB7/BqVfllgicSDYOTwse7fGeyp6QBiL27VxOB78HmIVTl
	rekPdiFA7El4gvXCDe1IakCMSMeD2c1+qhL3nWYuA+2wPbU2c55SOteiECbsmg14u1etryeEwUB
	n1eF48cRq7hGajcdGjarua1Jh9UVaQI+QO8dm8gCe5kXagSqKD4akUMFbkW37O9QR2RZgdtrIJK
	44MyOCl0acb8=
X-Received: by 2002:a05:600d:6501:10b0:499:fa56:f542 with SMTP id
 5b1f17b1804b1-49fc4949b4fmr320535e9.8.1789691482464; Thu, 17 Sep 2026
 17:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812231905.2956588-1-tjmercier@google.com>
 <15342d9c-d823-427d-9ce8-04cf48c6854b@gmail.com> <CABdmKX1kM+ZRoj6R9R61kQv3dGQ=5ar8YPX=YdqtdJ1DO_-ZOQ@mail.gmail.com>
 <CAEf4BzbWRBDF8XaV-TAwyWFyko6JuquSbEJfztE_1sRKauXBqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbWRBDF8XaV-TAwyWFyko6JuquSbEJfztE_1sRKauXBqQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 17 Sep 2026 17:31:10 -0700
X-Gm-Features: AcwNN1UaUqRlAC75yFCE-OsogF-1f8zPvdFLJSVysDHZNKz42uwuh-8kPqrvLlA
Message-ID: <CABdmKX1MgFbADOsVTHPCAnnfOX3mQS50pLA6mWDg19UV8X+pOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: htab: Reduce memory use of hash maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 17, 2026 at 9:31=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Thu, Sep 17, 2026 at 9:10=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > On 8/13/26 12:19 AM, T.J. Mercier wrote:
> > > > Memory is expensive and scarce these days. This series reduces the
> > > > memory use of BPF hash maps by eliminating the per-element overhead=
s
> > > > below. This saves up to 50% of per-element memory use for standard =
and
> > > > PCPU hash maps. The memory use of LRU hash maps is unaffected.
> > > >
> > > > Map Type & Configuration            | Old size | New size | Savings
> > > > ------------------------------------|----------|----------|--------
> > > > Standard (key <=3D 8 B, val <=3D 8 B)   |   64 B   |   32 B   | 50.=
0%
> > > > Per-CPU (prealloc) (key <=3D 8 B)     |   64 B   |   32 B   | 50.0%
> > > > Per-CPU (non-prealloc) (key <=3D 8 B) |   64 B   |   40 B   | 37.5%
> > > > LRU (Any key/value size)            |    -     |    -     | 00.0%
> > > >
> > >
> > > T.J. are you still interested landing this? Maybe respin the series?
> > > Alexei was away back when you sent this.
> >
> > Hi Mykyta, thanks for following up. Yes, I'd still like to land it. I
> > took a break during the merge window which coincided with a vacation,
> > where I broke my collarbone on a mountain bike jump gone wrong. Then
> > surgery and recovery, and I'm still catching up on everything from
>
> oh, wow, hope you'll heal fast and well!

Thanks! The surgery already made a huge difference, so now I'm waiting
for bone to grow and it'll be a few months before I'm back on a bike.

> > while I was out. I plan to rebase this and send it out again before I
> > head out for pre-LPC travel next week.
>
> have you considered splitting lru and non-lru flavors of hashtable
> before doing this optimization? I'm wondering if it will allow to
> clean up some parts of it, while also making map struct itself smaller
> for non-lru map (there is that LRU-specific piece in the union which
> artificially blows up the size of any hash map).
>
> I am a bit concerned about that key offset, even if the microbenchmark
> doesn't show much difference. What if we put hash itself before
> per-element header, so that key/value are always at the same offset.
> For cases where key size > 8 we'll just access hash at
> addrof(htab_elem) - 8, while smaller key sizes will just directly
> compare keys.

This is an interesting idea and I think it will work. Let me try this
first, and then I will take a look at splitting out LRU hashtables
aftewards.

> Just some high level thoughts, haven't really coded any of that, so
> hard to tell upfront if it's worth doing.
>
> >
> >
> > > > 1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1=
)
> > > > struct htab_elem is used for all hash map types, and includes field=
s
> > > > that are not always used (bpf_lru_node, ptr_to_pptr). For standard
> > > > (non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (un=
ion)
> > > > are entirely overhead and can be eliminated. Non-preallocated PCPU =
maps
> > > > only need the 8 byte ptr_to_pptr which is currently unioned with th=
e
> > > > unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
> > > > eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 by=
tes
> > > > of overhead can be saved.
> > > >
> > > > 2) Hash caching for small keys (patch 2)
> > > > For hash maps with small key sizes (<=3D word size), comparing keys=
 only
> > > > requires a single instruction. Currently the 4 byte hash value (8 b=
yte
> > > > aligned and padded) is used for this, but offers no performance
> > > > advantage in this case and can be eliminated.
> > > >
> > > > The implementation splits htab_elem into dedicated structures for t=
he
> > > > different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) whic=
h
> > > > share a common initial sequence (struct htab_node), but contain
> > > > additional map-type specific fields where necessary. This means the
> > > > placement of the key for each element varies with the map type, and
> > > > key_offset is added to bpf_htab for this purpose.
> > > >
> > > > While using key_offset and conditional hash checks adds new pointer
> > > > dereferences and branching during element traversal,
> > > > run_bench_htab_mem.sh shows no significant performance regression a=
cross
> > > > 10 runs on my 3995WX.
> > > >
> > > > Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | S=
tDev
> > > > -----------------------------|-------------|-------|------------|--=
----
> > > > prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5=
.24
> > > > prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2=
.32
> > > > prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1=
.60
> > > > normal overwrite             | 78.52       | 3.05  | 80.40      | 3=
.25
> > > > normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0=
.66
> > > > normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0=
.70
> > > >
> > > > ---
> > > > Changes in v4:
> > > > Removed inline from new functions per BPF CI (netdev/source_inline)=
.
> > > >
> > > > From Mykyta Yatsenko:
> > > > Factor out duplicate lookup_elem code into __lookup_elem_raw.
> > > > Use offsetof instead of sizeof for key_offset assignments in
> > > > htab_map_alloc (patch 1).
> > > > Eliminate branching and htab_elem casting in htab_elem_hash /
> > > > htab_elem_set_hash.
> > > >
> > > > Changes in v3:
> > > > From Sashiko on torn reads/writes:
> > > > Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of mem=
cmp /
> > > > memcpy for atomic key comparisons for hashless elements.
> > > >
> > > > Changes in v2:
> > > > Make maximum key_size for !has_hash depend on word size for atomici=
ty
> > > > on 32-bit.
> > > >
> > > > From Mykyta Yatsenko:
> > > > Put the htab_elem* common initial sequence in its own struct (htab_=
node)
> > > > and reuse it across all element types that share it. Eliminate
> > > > associated BUILD_BUG_ON additions.
> > > > Replace both the hash and key fields with data[].
> > > > Store has_hash in struct bpf_htab, and avoid per-element reads of i=
t.# Please edit the description for the branch
> > > >
> > > > T.J. Mercier (2):
> > > >   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_ele=
m
> > > >   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> > > >
> > > >  kernel/bpf/hashtab.c                          | 418 ++++++++++++--=
----
> > > >  kernel/bpf/map_in_map.c                       |  13 +
> > > >  kernel/bpf/map_in_map.h                       |   2 +
> > > >  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
> > > >  4 files changed, 289 insertions(+), 146 deletions(-)
> > > >
> > > >
> > > > base-commit: cfce77b63375dac81d53f2f85593c548415206b7
> > >
