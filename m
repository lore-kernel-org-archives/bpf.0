Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105534DCD9
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106430; cv=pass; b=DIhZV5eVGw+PRYtWoGlUxa9JmRZ140tDZNlW23xbkDwRQIt+ZE8ARSdq7CTuTV516+FX/e6T0COJsNCnp5JtZvYfDtNv7FpECFNGl5XEild7hRdUcIVxC5Jn52afCfZSmMM6eshk16pW9aporjFSL61iKARZzi13IBx+2lWBarY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106430; c=relaxed/simple;
	bh=iRaMeK4JhgvHiM/J3hdyo6IQijxuTpMUhCVy42mVQqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es7x//Wn0JnC+rsxmxF90C5FKxRQZCOoeKNeEOrWbJX7FIG035kF6cNlCJ+nyE7tgfdHdfoM1onHxGMJ2+uj+nLUp2HybwOWFArLcc8z12LQZNNL06I4TmYNS/RYknewJ4Ond4Ii0zZRCAmimagM8I/tUmOuIYgW59IBRbMwuBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKJacyM1; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKJacyM1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so63754995e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 11:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776106427; cv=none;
        d=google.com; s=arc-20240605;
        b=eWakmuzkWTp7fRKuQEBo6g6P4w7l8h4DPr7LFpVa2KrKv2YQcAT7T5oKVgDAEFfgOQ
         tzbavCDf3bWyDFLuIESnIVS6/W1Sf7ZfHinxRJmE62pdrCmv4qWGZLIzagWTN68nnzyk
         CDlpIcluEvycpo6BYgz/siqNzyMSNtvis1gan6pk+YnWZ+ueHqATPAuwwfKhKLTgRvof
         uRCMAhQhifyjXijDdrfUmChxHA+J/trf/s66GIp5k0ylMeL/asHVFg5hjDAiLNz8TyER
         2qARQK/iYEchOWlKk3wDvEen7DJ7kLumy4Om7UVzwQqPl4p7fvZ00Lk/mJUaiF0Kf0Pg
         WOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yw8Sc7Sdmmz9WVAmIiXHRX4MTWcNUZn7bCmbySdGTo=;
        fh=YNWt4Y0wqzitVpgmbcQBCiXmYTJYDAY+xbXi8GMD3D4=;
        b=KBIAZYlK2kQQC37ex9x0UHbUZUHGA2MIUROKn0epFO3eC0YUdLuCPDlcovX0l4wyLp
         WAo4wMWnjmV/AUk5D1PopIaGnmDfqhdcA4Yv5tacP2DkQpkc7kRe5lLyqY0F/1M84Qag
         wMCiuawfGFua9nuljCHEsqidshjI3IOP/hdY5hTILzcGANvy7ik72Cf8NgNdcSMqeliS
         p1uQ2INwkP2ovDWBmc/XqaPSzFpL28KuPnradECr5hMCPpvztqr5MHUZUfNkV3pQSQZS
         7nh3o32UISk37H5CMZIO9jMH7r3znVZUCW4ePpIILsGVb1OoknUzEFSi/RL/9THrnF9N
         bE0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106427; x=1776711227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yw8Sc7Sdmmz9WVAmIiXHRX4MTWcNUZn7bCmbySdGTo=;
        b=YKJacyM1PNRAXoDmBBfLGZdURx+AeE8PSNUwY89WkFNS4qe+puoXFnitFoRuF77+JW
         Iil7vfcl5ryQ37MbDQtveOd/Oz5Wd6rTArI0b6y9ug3uAbUGDeIOhSY7XdlnpB2A84vY
         oOrS5buVJpY54IgjzyxQgie5JsQcEf8FUgT2WOK7EUrlqeq9FPIqmLRwMWGXoIHRB2F2
         H3Rhu7oLQwXinknpLC8Zsd1fuxrcECs74u+q0s4HZnBwnH91gDPpeHC/60UECheeOYNM
         k8rnkwZSRi61UOMtHQsCJD4VZ3f4/+KfGxkA8rH1Aa3tVTjuj5dQ9PucPWxmPRc5b0SQ
         opaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106427; x=1776711227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yw8Sc7Sdmmz9WVAmIiXHRX4MTWcNUZn7bCmbySdGTo=;
        b=eliuIZ7cj5+xdpCzQVqwbdjfKqTZ519AjSQDHvalfEcbYNtamyILkeHa3pIzVIg1iZ
         HBl4+UATJc2oAhsVpb7C04Hz05TTIgn9dVqikT4uQfBEo7IsV/VhSvZvmuAR1ZgoFSKJ
         OLivCPhC7MXdzF7xiiDHNkIUH0p4XrBLJ45cpfCZagni1/okw71uns5jAF6iU/gnA+H0
         6+rTOB4p398G87Cp9r9ZI+bzce5Oe0aZ10z4UeJLLfBBYbGUJvXzy6g1CxJdLdZTX7+g
         X9f5sJ06Xd+y4TSWYv/q2VykDGc1dVbPaiQfqIy7MkEi5ay/RGoFdo2DihLH8Rz6KP+1
         +uxg==
X-Forwarded-Encrypted: i=1; AFNElJ8nyBBk9Fx/na2nkUO4/yH+PaieP0fT2ll5d/+/a7uh9LjN5qKrVEkGqrWz0FI64p14lJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUETEHfATV/ZGHicdqZJFSg45GI6Rq3fdy17VYRfmETprKTbR
	j3dHmjCz0oOFjd2mvM0RRsLM0MIS/QE0H5j5sgN5TwneCT2NxD6lojONOY1V1o5diVVmIURKP3J
	9LPIs3vFJMJpBq5osTEQJuTc0dG8HSxY=
X-Gm-Gg: AeBDiescU2EIGGY/QAtPzKtqGyHyx3lCwxHvQhydq8xecOuMXWv9gwBDnYoIcbjqHY3
	QuFJj52T+Mp7lV8g4E2Yod2a6cLN2twooLPS8usgLWMCqpCGYfnJahJBwWY6NzfiqMEuyEN30vF
	75YFUgicUNGNAlxjtF7oYk+2N27LSi2W1ZbdmnK8KSh9Rv7GGTDjScQmhYG8HzOyMwW0YTnxq24
	O1ldfFhXcBsKTUXgO5aIEpuOSnd8uksU97czABca2VqSx4W/2h9FRLzZ0X1t+Nk18SkJQ7BfcZi
	ACoN02yeT4wa5ZuIfP7BEPq6ra6TBtaibsQlXM2KLVE0e27kKrwF/MAMNyk8j+jLgCY8kYil6eK
	krXwYRzE64v+BKKAxYHrHeIr5Cw==
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-488d68af201mr215291025e9.31.1776106427352; Mon, 13 Apr 2026
 11:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412022714.1955495-2-bestswngs@gmail.com> <20260412022714.1955495-3-bestswngs@gmail.com>
 <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com> <CAADnVQLhnnt8uGoZk=38zH1jh_9Uy8ah=NdcoBE71qGkuH2O5g@mail.gmail.com>
 <adzBmOuXCZ0vHnbg@SLSGDTSWING002>
In-Reply-To: <adzBmOuXCZ0vHnbg@SLSGDTSWING002>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 11:53:34 -0700
X-Gm-Features: AQROBzAu4hxvmTGtVwVF6u1a3jFDsvQD0ZbaSyf7ca2eybMqvd_9Sa8KTcEqCYc
Message-ID: <CAADnVQLxJ4+uAEOLw4+w-aAsObaJFBLE4uppqAd5b06uAD=3Fw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
To: Weiming Shi <bestswngs@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Barret Rhoden <brho@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 3:12=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> On 26-04-12 14:30, Alexei Starovoitov wrote:
> > On Sun, Apr 12, 2026 at 10:50=E2=80=AFAM Emil Tsalapatis <emil@etsalapa=
tis.com> wrote:
> > >
> > > On Sat Apr 11, 2026 at 10:27 PM EDT, Weiming Shi wrote:
> > > > arena_vm_open() only increments a refcount on the shared vma_list e=
ntry
> > > > but never registers the new VMA or updates the stored vma pointer. =
When
> > > > the original VMA is unmapped while a forked copy still exists,
> > > > arena_vm_close() drops the refcount without freeing the vma_list en=
try.
> > > > The entry's vma pointer now refers to a freed vm_area_struct. A
> > > > subsequent bpf_arena_free_pages() call iterates vma_list and passes
> > > > the dangling pointer to zap_page_range_single(), causing a
> > > > use-after-free.
> > > >
> > > > The bug is reachable by any process with CAP_BPF and CAP_PERFMON th=
at
> > > > can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
> > > > deterministically -- no race condition is involved.
> > > >
> > > >  BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memor=
y.c:2234)
> > > >  Call Trace:
> > > >   <TASK>
> > > >   zap_page_range_single+0x101/0x110   mm/memory.c:2234
> > > >   zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
> > > >   arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
> > > >   bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
> > > >   __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
> > > >   __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
> > > >   do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:6=
3
> > > >   entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:13=
0
> > > >   </TASK>
> > > >
> > > > Fix this by tracking each child VMA separately. arena_vm_open() now
> > > > clears the inherited vm_private_data and calls remember_vma() to
> > > > register a fresh vma_list entry for the new VMA. If remember_vma()
> > > > fails due to OOM, vm_private_data stays NULL and arena_vm_close()
> > > > skips the cleanup for that VMA. The shared refcount is no longer
> > > > needed and is removed.
> > > >
> > > > Also add arena_vm_may_split() returning -EINVAL to prevent VMA
> > > > splitting, so that arena_vm_open() only needs to handle fork and th=
e
> > > > vma_list tracking stays simple.
> > > >
> > > > Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> > > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > > > ---
> > > >  kernel/bpf/arena.c | 23 +++++++++++++++++------
> > > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > > index f355cf1c1a16..3462c4463617 100644
> > > > --- a/kernel/bpf/arena.c
> > > > +++ b/kernel/bpf/arena.c
> > > > @@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf=
_map *map)
> > > >  struct vma_list {
> > > >       struct vm_area_struct *vma;
> > > >       struct list_head head;
> > > > -     refcount_t mmap_count;
> > > >  };
> > > >
> > > >  static int remember_vma(struct bpf_arena *arena, struct vm_area_st=
ruct *vma)
> > > > @@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena=
, struct vm_area_struct *vma)
> > > >       vml =3D kmalloc_obj(*vml);
> > > >       if (!vml)
> > > >               return -ENOMEM;
> > > > -     refcount_set(&vml->mmap_count, 1);
> > > >       vma->vm_private_data =3D vml;
> > > >       vml->vma =3D vma;
> > > >       list_add(&vml->head, &arena->vma_list);
> > > > @@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *aren=
a, struct vm_area_struct *vma)
> > > >
> > > >  static void arena_vm_open(struct vm_area_struct *vma)
> > > >  {
> > > > -     struct vma_list *vml =3D vma->vm_private_data;
> > > > +     struct bpf_map *map =3D vma->vm_file->private_data;
> > > > +     struct bpf_arena *arena =3D container_of(map, struct bpf_aren=
a, map);
> > > >
> > > > -     refcount_inc(&vml->mmap_count);
> > > > +     /*
> > > > +      * vm_private_data points to the parent's vma_list entry afte=
r fork.
> > > > +      * Clear it and register this VMA separately.
> > > > +      */
> > > > +     vma->vm_private_data =3D NULL;
> > > > +     guard(mutex)(&arena->lock);
> > > > +     /* OOM is silently ignored; arena_vm_close() handles NULL. */
> > >
> > > I don't see any way this approach gonna work, and frankly makes no se=
nse
> > > to me. This patch doesn't take into account how the vma_list is actua=
lly
> > > used. It frankly makes no sense, Please think through this: If we cou=
ld
> > > silently just not allocate the vml, why do we need it in the first pl=
ace?
> >
> > +1
> >
> > Weiming,
> >
> > you should stop trusting AI so blindly.
> > First, analyze the root cause (the first paragraph of the commit log).
> > Is this really the case?
> >
> > Second, I copy pasted it to claude and got the same "fix" back,
> > but implemented without your bug:
> > +       vml =3D kmalloc_obj(*vml);
> > +       if (!vml) {
> > +               vma->vm_private_data =3D NULL;
> > +               return;
> > +       }
> > +       vml->vma =3D vma;
> > +       vma->vm_private_data =3D vml;
> > +       guard(mutex)(&arena->lock);
> > +       list_add(&vml->head, &arena->vma_list);
> >
> > at least this part is kinda makes sense...
> >
> > and, of course, this part too:
> >
> > -       if (!refcount_dec_and_test(&vml->mmap_count))
> > +       if (!vml)
> >                 return;
> >
> > when you look at it you MUST ask AI back:
> > "Is this buggy?"
> >
> > and it will reply:
> > "
> > Right =E2=80=94 silently dropping the VMA from the list means zap_pages=
()
> > won't unmap pages from it, which is a correctness problem, not just
> > degraded behavior. Since vm_open can't fail, the allocation should use
> > __GFP_NOFAIL. The struct is tiny so that's fine.
> > "
> >
> > and it proceeded adding __GFP_NOFAIL.
> >
> > which is wrong too.
> >
> > So please don't just throw broken patches at maintainers.
> > Do your homework. Fixing one maybe-bug and introducing
> > more real bugs is not a step forward.
> >
> > pw-bot: cr
>
> Thanks for the detailed review, really appreciate it.
>
> I traced through it with GDB + KASAN in QEMU. Here's what happens:
>
>   1. mmap =E2=86=92 remember_vma()
>      vml->vma =3D 0xffff88800abfe700, mmap_count  =3D 1
>      now Parent VMA =3D 0xffff88800abfe700
>   2. fork =E2=86=92 arena_vm_open(child_vma)
>      vml->vma =3D 0xffff88800abfe700 (unchanged), mmap_count  =3D 2
>
>   3. parent munmap =E2=86=92 arena_vm_close(parent_vma)
>      mmap_count  =3D 1
>      vml->vma is now dangling
>
>   4. child bpf_arena_free_pages =E2=86=92 zap_pages()
>      reads vml->vma =3D 0xffff88800abfe700 =E2=86=92 UAF
>
> The core issue is that arena_vm_open() never registers the child
> VMA -- it only bumps the mmap_count . So vml->vma always points at
> the parent, and dangles once the parent unmaps.
>
> What approach would you suggest for fixing this?

I'm thinking to just do this:

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f355cf1c1a16..a4f1df1bf0f4 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -489,7 +489,7 @@ static int arena_map_mmap(struct bpf_map *map,
struct vm_area_struct *vma)
         * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
         * potential change of user_vm_start.
         */
-       vm_flags_set(vma, VM_DONTEXPAND);
+       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
        vma->vm_ops =3D &arena_vm_ops;
        return 0;
 }
