Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317136920D
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010123; cv=pass; b=JpsIqygsFMnclGGSTUC8A2mU+RPgqPPBGrQdbNX3SzVRG8o4egB+eXJUNILmRAABT+ej2hjRiaqkLHCQIl+wycw0OpgeamDqOdWpJSo1uG+zp5b75OtTBHztL1kg7Ef3cbVKThABeS7sZ9ywRypiE/RUxMxSQBbBuOx+3hOjfmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010123; c=relaxed/simple;
	bh=HhiJsNw8Tg/fmiYQa8OT8z3WQuG6J3j5or6u/0F7c0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M74i7UGE3xksY5bmH3C4kTWxxUp1hcq5IRCPNcOSzIHGHGkVunSbckqetJWwkjMrvH4cGiSSqYrNdiE0QfIhwX4rTmo6TqzesRB2L1CJoVaa3dC35+NPNatGHM3iYBBExeGGHYCR6P2fa9guY4ZNp2KFB0DH3rMlOTGF2ZSPPFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYSQgwXZ; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYSQgwXZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so712767f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780010121; cv=none;
        d=google.com; s=arc-20240605;
        b=ezZc42A6XXv/6ZA3cK1X1Tje5fp6oaszWqMm974ZQD+Nb6mB2t4QAtwKqoj2l/VuCL
         3uzhiGerrnEOwqHHqqJowkZBB1vEhBDx2eaboaLPkdKNJ8zuqSPziZwhoEIiuPg/bFMw
         2ppEfVlhLceJDWiE5UAC1q5idaiy1xsDXndbUk8nZE9YTNnYdCtFMF8CydHvDkKRC6dC
         UtjaZ1yBioeIVtlJkxpExEm62NxeOrM1XJIhMQ1KdPWM6gvcX/fHGvO30DBrwcRs/3at
         jsCLSwF2zdfhR1j78vcQaXX9NwmuHqMc6pSYJaRVKswmEviTix32zCoPaShgbxcG25SH
         vpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DnjhO1WrJ4e/oacKLLvKINV2+Bru6BjXY46NXvZIVQ=;
        fh=6PQFRWLd/QrmVu5yLvO0f3Twx/3OnPEU9esnxEZ6q28=;
        b=cGCPXmvCZIX/bCggf4l0EIWZY5r1iXQLvn3GdthyTxox+evPnqPvFXvNcalbkjYtEv
         aoUm3vhdPrhd9RTgaLX+lakgOJnQ5p0jhIRjuHRnpmWoX/RD2O+FFv/JGj1IGXgaFLrh
         GKiFDuF38Nt6JUxUaRsiA49pcw6ZCg9MLa53m+wbG5pBaTsovFUBm2ewV9c0fvFSmoeG
         0WsdagATszraC/eob0K9gDhuIJBem0T6q0xhFEDusoR7AMYeQVCNLo5yN4YLzrUSHmdI
         CFzDdz07uoU6t7GOg7AVcNqpG3vpDvDc7T4syeeBWmc5oc9hXXbtzSw8wsC83E4Sr9j+
         2MiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780010121; x=1780614921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DnjhO1WrJ4e/oacKLLvKINV2+Bru6BjXY46NXvZIVQ=;
        b=GYSQgwXZGyNjxSbUbRUOa3ldDysmoLUkk08nNrgJF2Mbmgeb+fyYMcQ/eNBm52g1YQ
         mObjZQroD2qS68489sOf9iKlIv/8tuYTg/+fAOtXl92B7c4QuzXxPhOGir9LYCZ/8yfT
         zpQ+t8PNDLuQ/br5Q7oVM3ujfOANImHqtExbfIRptXsPIqJKr/envA6gviTDJdwpsB37
         27qlo5hA1Z+dthxmln79dPnh2fNcV71n3uda2yxd/fS24Wm0RVWZpO6KOPQ5sbjX3d0C
         WBzGiyGOs1RLLXRUFJEtX/b44nJ3Q5XA0H/2wpcHy8dF76s9ersu4UAS0M8kwyInpG79
         fBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780010121; x=1780614921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DnjhO1WrJ4e/oacKLLvKINV2+Bru6BjXY46NXvZIVQ=;
        b=bZcsmI3/Wtxm57GrfcTl71ijuO17/2tsfwZfAvFD4/P1vE7z57qsgrN7gtvQVaqY+a
         zbkxNGlUV+wbj+qLUon5mn5jW652FvnTaCtbgF59893l2u6mKFIuNVf0ga3Y9MaOg6uM
         pOPSPn155Zs/WvH/gvPtSisuVJdXXnnQ8QkAmcGGfg/+qanRcwDffbYWYo8be4dpeChx
         ezTHx04RpwEMoKIT8iOH+nZKAufLrXCjAhIbY9pm93rR8yUbcQQ7w7XSbjrTZKMT9A7A
         GzHcHhj29SIHuss1jlALD+AfFhdE+9rO4mu3SeXMSkG+FsyXWgC8HXYZcdPOzXmhMCNk
         5WCQ==
X-Gm-Message-State: AOJu0YwhVYZL/5rGdwx1VwI2rn7vOiiXPVDCy0ND52bjjGU5tRaA17Qb
	ry4cEimOz0qH5NOIBz/2+gaVgdM/fFcc0AJxldgAe3kkUyBkdcPuaH+i92PSIxnRAoC2cI2XViC
	Fu9xRVuMTYgIzJ/rHvPfaVmsuc8DhXSGqwg==
X-Gm-Gg: Acq92OEq2Lbxb+SPjY5ecUNIaN8ZO2OuibDnHLemK7951yDR1yJYoWwfwfZOcA4gZTA
	xMe3lYIGnyzqAYFg02rzeec7Tj1cuwXIgL/JERmzskfHbM07g24ilRuPJ+sb3bBvT5s6wn1tms8
	DDQTSvMmBLPr33363Med6byiAvYnxpceHLy0NkR+58jQxRoEFPU9h1JyXPafTXMfyrVY+7qcv3L
	/Wurx/+MP5H6Rn8g6oK/qr5hQ/H5FmKCvl2Y36quL4npkEQ1qRV4xpx4NOH14gL0NgkJ0FofzMn
	Xwkf/jfPcCjKH+2pqSKwmJqm/KAg6aZ8keZGIAwcP08JPFvz1LWU62dB4rm+kBrGKASivOaOULy
	1BuytEY9Om4wAisQrysabShb0ORRP4f+xKFAk
X-Received: by 2002:adf:fd85:0:b0:45e:a0ab:8bcb with SMTP id
 ffacd0b85a97d-45ef1413aa3mr441938f8f.15.1780010120552; Thu, 28 May 2026
 16:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com> <20260528231103.DEC921F000E9@smtp.kernel.org>
In-Reply-To: <20260528231103.DEC921F000E9@smtp.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 May 2026 16:15:08 -0700
X-Gm-Features: AVHnY4KKEn7Km14qgoNoivEwWCS96fFsKwers_Sh2Z0A-5YreWU2m-zEZ_aWNPk
Message-ID: <CAADnVQJMuaFYVkYEGnsR43Bp=J0yvkaz_pd8+tCG=-zgnqOiVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
To: sashiko-reviews@lists.linux.dev
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 4:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] zap_pages() can enter an infinite loop if userspace continuously=
 mmaps and munmaps the arena, stalling the thread indefinitely.
>
> Pre-existing issues:
> - [Critical] zap_pages() can pass an address range to zap_vma_range() tha=
t exceeds the boundaries of the VMA, causing the kernel to unmap memory bel=
onging to adjacent mappings.
> --
>
> commit 5e7dd96eaa4e65e290f989d52d5ebe8450def72a
> Author: Alexei Starovoitov <ast@kernel.org>
>
> bpf: Take mmap_lock in zap_pages()
>
> This commit addresses an AB-BA deadlock between arena->lock and mmap_lock
> in zap_pages() by dropping arena->lock before acquiring mmap_read_lock().
> It introduces a zap_gen counter and a zap_mutex to track processed VMAs a=
nd
> serialize callers while the lock is dropped.
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 1727503b25d84..9b2dea229b385 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
> > @@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *a=
rena, long uaddr, long page_cnt
> >  static void zap_pages(struct bpf_arena *arena, long uaddr, long page_c=
nt)
> >  {
>
> [ ... ]
>
> > +     mutex_lock(&arena->zap_mutex);
> > +     mutex_lock(&arena->lock);
> > +     my_gen =3D ++arena->zap_gen;
> > +     for (;;) {
> > +             mm =3D NULL;
> > +             list_for_each_entry(vml, &arena->vma_list, head) {
> > +                     if (vml->zap_gen >=3D my_gen)
> > +                             continue;
> > +                     vml->zap_gen =3D my_gen;
> > +                     if (!mmget_not_zero(vml->vma->vm_mm))
> > +                             continue;
> > +                     mm =3D vml->vma->vm_mm;
> > +                     vm_start =3D vml->vma->vm_start;
> > +                     break;
> > +             }
> > +             if (!mm)
> > +                     break;
> > +             mutex_unlock(&arena->lock);
>
> [Severity: High]
> Can this loop run indefinitely if userspace continuously mmaps and munmap=
s
> the arena?
>
> Since remember_vma() unconditionally sets vml->zap_gen =3D 0 and adds the=
 new
> VMA to the vma_list, concurrent mmap() and munmap() calls could repeatedl=
y
> inject new VMAs with a zap_gen of 0 while the lock is dropped. This might
> cause the loop to repeatedly process these new VMAs and stall the thread.

Nope. Cannot happen.

> > +
> > +             mmap_read_lock(mm);
> > +             /*
> > +              * Re-resolve: while we waited the VMA could have been un=
mapped
> > +              * and a different mapping installed at the same address.
> > +              */
> > +             vma =3D find_vma(mm, vm_start);
> > +             if (vma && vma->vm_start =3D=3D vm_start &&
> > +                 vma->vm_file && vma->vm_file->private_data =3D=3D &ar=
ena->map)
> > +                     zap_vma_range(vma, uaddr, size);
>
> [Severity: Critical]
> This is a pre-existing issue, but could this unmap memory belonging to
> adjacent mappings if the VMA was partially unmapped?
>
> The uaddr and size variables appear to be bounded by the global
> arena->user_vm_start and arena->user_vm_end. If userspace partially unmap=
s
> the arena using munmap(), the vma->vm_start or vma->vm_end shrinks, but t=
he
> global arena bounds remain unchanged.
>
> Since zap_vma_range() relies on the caller to provide a range fully
> contained within the VMA, passing an un-shrunk uaddr and size could excee=
d
> the current bounds of the VMA and inadvertently unmap adjacent userspace
> mappings.

Nope. Not an issue.
