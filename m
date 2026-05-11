Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348E43CEE3
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518408; cv=pass; b=EOTaiXbOP+bi2VyJbyd62U/SZpv9yTNvB/hH3flBxDV+fj8emGWhMsW16uLttXPdsppsPq1Um5fgFte5Z9wj4Djhmx44Lt+0N23/1Rwo4apdf9+5KfgLZa7p+z8GJUVLdDq5BFQ42pcPOqAjcjmBpnCGinWGesKzWbllxFNtCBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518408; c=relaxed/simple;
	bh=WK5T5JfvYsoXwLxh3vVykUD2mRLGy3+mpvWaIBQy8/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/ww/bJi8bW4/4Ar2xgx19XQJRlZ+p4S2VvSN3qixY4QOQiAsKw71areqGdOEs0mq5UE/zkXOGqophCdnh1u2YVV3OkXLVkSMNjTsR8/roBzw+0Ug2szOOTZEvFvWpOg8HB470kdR57Ew4/slxCmRQkK33Tr52nUKCtz8FOYalE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFbPJWQs; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFbPJWQs"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso3011765a91.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518407; cv=none;
        d=google.com; s=arc-20240605;
        b=Tbn6H5ZxIazyiGlhaih10J2d/YVxVPZlLEM37FKRCUY0e/j0HjX5pbRQ7B1qTCpdTG
         L+K522GZYszG0lOgjhIIbajgQhjs9qRoW0OBoQv7Rd3qAFxM0728uFxJIHVse1aZ1N5g
         h6IOoahksRAS/dtthUk2u49Qf9usMAmJBOtDfdVagUP3cmDYlvfY40LKmOsaxqb8hqQ3
         13eKJCIOyIfjN5szvR5dH3PcAydhomtN9KgGkQm6WQi09H1StR9CSPn7GAAM475IVeAW
         G1+w0M0581wT9zRZvxKv14sTeb/k5vAJuSl98RyZSw43nCyrO8aZ8CgrSle4GHTIr/s3
         00cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pum98GMtwdOZuFVkPRuk8QjOK36LqVQS2DrUcasrMj0=;
        fh=WeaNIRDJTCNp6pe3IxIEcp7GLibgX6biTAFzx3y7Zbc=;
        b=WvdvbYmtCxjrrRuRuV10JiZDg/dSjmjhuOXfNdmYf/4lsGpURd231o4aVXBqiqHgXk
         05QNGFk4lvYS/2Esj2bxa1XCnH2LVCJhL34nFBNsJ+zfBCuGvlyib3ImhZtc5BIQAvIg
         F+PnaH2P0czof11+1K6cOcHugng7SAskb370z1Yv8NSMsk0MyLYdcrFQaBHrKnExaQOR
         IhLNki6IYSpMIBClFNQ7djYkCa8a1WdSsYCjFwn7I9QKlBtV23n7+5O4HBOKy64TJ7a2
         JPg/QrQn3zqLyMh1hQ6ed8oVyiXsxI/qjCotKNyp3OFmBZl1ngSb/R04mJNzL+E8EIbt
         Zgbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518407; x=1779123207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pum98GMtwdOZuFVkPRuk8QjOK36LqVQS2DrUcasrMj0=;
        b=NFbPJWQs60hn/YdSFhL8piqnhuXq6eBvGgBvGa831blaN2aAe91Wx8MCfl/3E8Q8II
         DCYhPbeXPZjF0+MvDkFfpWX1bEDwnFelUqZ2DzuUTD26TzvM4XIV7obpOqHbR7BM50ti
         3gQRnaIBpGPeo+R+Kh8ehjUtAY7aSVFtGkMh4ubHZZUKNAS3sADWEwOaw6VrD6PHCNtB
         HJimAJj9Nrs6ZUU+2iI4ykGzL6npkf9Rzd2BeEFJFfekK+sqfXxJRGW8MCFoNIz2sRVy
         kNq13FfD7j/JELl+Ab8SUsEgp/zYsc2bCLyAV0JKomUnt4ipZqegtk7X+FJUA3PvrB0Y
         ncIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518407; x=1779123207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pum98GMtwdOZuFVkPRuk8QjOK36LqVQS2DrUcasrMj0=;
        b=HZpPdcLZk/JJ+/BUh2Chn65KumOGUK5HgujDNx4JJ/ZuKjtSFjYiSTHfZIAIyCJEkU
         2/klbpr/cw6bXOb0Op+m2pj9c6D4XAMH+KIPWbw5OW1bCtjqWpvYfd/elsiGpvaKYewJ
         q3KViOnU1ZRbH0TDBYXbKpL4MqP9ZY+6w4nHAIsjhJM+RRlFk4WWiBydpQN0xr8IdIaQ
         Ep1od5JW8rIAVxCib2GyaIpWQ3lwOTUuedKgFB+9wj7F9l0L4z9Wpc6Sx4P6XBn770zU
         zXBhLqZNjpcG77ykExD02nXsB3DjhKpWkF9k7qBylD4L2IFD1HX/8RsFZ3YEOzjqliHV
         e6Mg==
X-Forwarded-Encrypted: i=1; AFNElJ8aSZcm6ZGyy8LkOqg4Y8Htun/t4F8yJjx92gOEULEflHuo72iSAWNtaNrdExd6gKi1op8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOLd4+bf0RaPuuydr+Zk7TJKEfzZr5G912dAsj+m1fBqpbILW
	JeULCAoBG6/7T9y8KmMaeC07YetqEYLw264tTDKiWRLxaKu8xUmh/MAlM9Df/RkTdBkckZmjY5l
	FGcSpRn1hIVV4lRpq1aLZfDbrnb1yCn8=
X-Gm-Gg: Acq92OHc1FKbpa47xRvISYgpHwls2XAzusu7+lCXykU0sZvJqls89vk47KbBggoiTOS
	I0i8ydxkvDEXQyb7LtLNhie8VG0aFlAegLVYDUnzerSV/8+gaZtD6J9fgGwrZSRyqwGyZ/GJXvJ
	2NPSvsTMwPnLhsgB36z4j+mUzEpzkezVZeUccaFSNzhtfg6sxa0bqc/49Sv+BZ3tGMoCGbfmThR
	H08MaG1up0eND7tWUuGy4qcSnfBGYu+KXmJJWMByaU9xE16BaDcgi/eEqU7W+H/Dk+x5dP6h1AO
	/IHUpAml+Nwnror1fazGLzQ=
X-Received: by 2002:a17:90b:590f:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-3685368061emr4750343a91.9.1778518406654; Mon, 11 May 2026
 09:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <20260509020243.223B1C2BCB0@smtp.kernel.org>
 <CAEf4BzbS0512oBcnPsPKrLiVWtDoevqS1Yvv-DHwCsDX0vANig@mail.gmail.com>
In-Reply-To: <CAEf4BzbS0512oBcnPsPKrLiVWtDoevqS1Yvv-DHwCsDX0vANig@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:53:14 +0200
X-Gm-Features: AVHnY4Lhchp7Sb50uPy0gGXFoX3gjQq3-1IcZFAkpdI-p4Og-OGlBKDCAI9-jP8
Message-ID: <CAEf4BzaLU_VaA7R3fUuPkk9QMF4rLYKKzrr8Z5F2MJJMPb+6qw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: sashiko@lists.linux.dev
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 9:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 8, 2026 at 7:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Critical] `resolve_uprobe_addr()` unconditionally uses `current->mm`=
, causing `is_optimized()` to fail when called from tracer context, which l=
eads to target instruction stream corruption and potential kernel panics.
> > - [High] Exhausting a process's trampoline page slots permanently disab=
les nop5 optimization for that uprobe across the entire system.
> > --
> >
> > commit 2c63c19710be8b050bc0e126d84e52c24209e062
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Sat May 9 00:30:56 2026 +0000
> >
> > uprobes/x86: Fix red zone clobbering in nop5 optimization
> >
> > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > probe site with a CALL into a uprobe trampoline. This commit changes th=
e
> > optimization to use JMP instead, introducing a trampoline page with slo=
ts
> > to handle register state saving and jumping to the syscall.
> >
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index ebb1baf1eb1d0..7e1f14200bbbf 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> >
> > [ ... ]
> >
> > > @@ -761,147 +785,153 @@ void arch_uprobe_clear_state(struct mm_struct=
 *mm)
> > [ ... ]
> > > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *pro=
be_addr)
> > >  {
> > > -     struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> > > +     struct uprobes_state *state =3D &current->mm->uprobes_state;
> >
> > Can this cause a NULL pointer dereference or instruction corruption whe=
n
> > executed outside the target task's context?
> >
>
> ...
>
> >
> > Could we pass the correct mm struct down from is_optimized() to
> > resolve_uprobe_addr() instead of relying on current->mm?
>
> yes, good observation, I'll change resolve_uprobe_addr() to accept
> mm_struct directly
>
> >
> > [ ... ]
> >
> > > @@ -1113,8 +1149,9 @@ static int __arch_uprobe_optimize(struct arch_u=
probe *auprobe, struct mm_struct
> > >  {
> > >       struct uprobe_trampoline *tramp;
> > >       struct vm_area_struct *vma;
> > > +     unsigned long slot_vaddr;
> > >       bool new =3D false;
> > > -     int err =3D 0;
> > > +     int slot, err;
> > >
> > >       vma =3D find_vma(mm, vaddr);
> > >       if (!vma)
> > > @@ -1122,8 +1159,17 @@ static int __arch_uprobe_optimize(struct arch_=
uprobe *auprobe, struct mm_struct
> > >       tramp =3D get_uprobe_trampoline(vaddr, &new);
> > >       if (!tramp)
> > >               return -EINVAL;
> > > -     err =3D swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> > > -     if (WARN_ON_ONCE(err) && new)
> > > +
> > > +     slot =3D tramp_alloc_slot(tramp, vaddr);
> > > +     if (slot < 0) {
> > > +             if (new)
> > > +                     destroy_uprobe_trampoline(tramp);
> > > +             return slot;
> > > +     }
> >
> > If a process exhausts its trampoline page slots, will this permanently
> > disable the nop5 optimization for this uprobe across the entire system?
> >
> > If get_uprobe_trampoline() returns a reachable trampoline that is compl=
etely
> > full (all 256 slots used), tramp_alloc_slot() returns -ENOSPC. This err=
or
> > propagates up to arch_uprobe_optimize(), which handles failures by sett=
ing
> > the ARCH_UPROBE_FLAG_OPTIMIZE_FAIL bit on auprobe->flags.
> >
> > Since struct arch_uprobe is shared across all processes tracing the sam=
e
> > inode and offset, hitting the 256-slot limit in any single process seem=
s
> > to permanently blacklist the probe from being optimized system-wide for
> > all other processes, even if those processes have completely empty
> > trampolines.
> >
> > Should get_uprobe_trampoline() also check if the trampoline has availab=
le
> > slots before returning it, or can the failure be handled without settin=
g
> > the global failure flag?
>
> It's a trade off. If we don't set ARCH_UPROBE_FLAG_OPTIMIZE_FAIL,
> we'll keep wasting time trying to find and use uprobe trampoline for
> each uprobe execution in that process, which is wasteful. So, given
> this is a performance optimization, I think we'll just live with this.
> The alternative would be a per-mm+per-uprobe extra information, which
> seems like an overkill, so probably a no-go.

We can have per-mm flag inside uprobes_state common to all uprobes,
but that will make reattachment to previously attached uprobe with
allocated slot not work, if I understand correctly.

Jiri, any thoughts or ideas?

>
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509003146.=
976844-1-andrii@kernel.org?part=3D1
