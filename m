Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544B355057
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472271; cv=pass; b=C38vEyQWceuMM3WPKqS+lp8WHoXLYDIU/pjOGpbPeJd6VrjersI4yntNPCb8JxYbTdxDrsqG2PLXCgN6OWs50T511UIe6mbDr8AXiUKVKlAg1Gdi+rRSziIaKcxdCcW5jMiCxPU/8p4Y33ScvIaW52dF4ZzNqq7BXk6zueVerAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472271; c=relaxed/simple;
	bh=D4X9JqIl9yM+wQh/UUHNu4fsa+grHfMjZeLtJgiIYME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAybTg0o//qI+yMi2o7dIgn86C+oyBCVhrLC1Hq3Ag1NxRFNgvsLUCex22fFU+dfVMoc6QDLc5cBF0QfxWUsJurmEriuM9v3tXCcXLMjs99i4WTvCPNV2LnsETiCv146CA7jCSxbMzZAMMcxB43BNpDf+eC1Ro2d8Wd95I73yKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvOUkSVZ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvOUkSVZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bdbac72ac1fso450534466b.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472268; cv=none;
        d=google.com; s=arc-20240605;
        b=MO6GXnkS+r5nxbmZCPR0LIgGAfxo37F+etnKWB1Vaqh/W4TXEj94prEZHSSa6nUnrj
         +Tq6Ija8iCI8ezqKWcQx+ebkNmnfxfCqt9Ip/TmveIlyNM/d7gkeX8g45yhrOojkEDnK
         i/rbqeP5Td/59+RXmELdd58NacbY0M6EYWUifshAE3Y0g6Px4Dl42pGz9jeuAhUY4o5O
         OcyMdr1D3wn4wOn+IedRaV4K98xn5qEZlzpGLS09hIZwJDTsKhCcLPcv9Xzjhynx7Akv
         y12c17tn7yYgThWKr1VgwhXDawCfOi240k/x4jtX6/GKeDj2DmPMtUllKDPuUV2cBn/R
         aZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ieO3ZF9y/Qw0rFDXiSUM+2kgBRGgpLsK1ca4Gwqd1jo=;
        fh=/lgagYiIqf84bAYS4t4Bu57AiBBTlQKWX0eFQqPjha4=;
        b=QsZxF/NK5CP6UYPmII1t5qAOuS3+QREm1tTYrz7vqp/L9y/f+IHTn+zkbDQdyjhU4+
         y80+fkHYveuKhwV6qNnpeJ8x4PG/PIPCNoFZ6hAcA5Dj6g9FFuuxW8OMijEgwAKi4QQb
         28MHq3xz3qtwsiKxJzgfK3k6o8ZBeNRz7egJYO3yfhuT0hkJpikB49KWuHuuN3KKt27L
         71VUgwVST23wSTZPlY2p5fAUgMiyBy2XEHk6Sp+rD5k/qkVkAaMaR5v0Do4gh1za7yRy
         e03YWmb8mPZIP+LuXhx2i5BfbZxm3c3UOeNnqSgYMmaGGTbrNg6hnh7SOAmhVvhSRVhQ
         bfDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779472268; x=1780077068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieO3ZF9y/Qw0rFDXiSUM+2kgBRGgpLsK1ca4Gwqd1jo=;
        b=RvOUkSVZ3kXLHSE+rUa2Xr4ZqGu2FaVNkC26fDx53ooD/LJNGhGUsKv+wOCSVpEKym
         zHkOFgVOb9T3vOZK/MHbHbUFAOp5DtJTVmuC7LEvogHBirLB1vmyvceqXNCp3nIiBbm+
         YUGgnVaQOleOgMJw7fvFkNCoOrEx/W7JjOgvr9E4qUDpf6Y1JytStpZ8+W6rlCIIEmt0
         UAvLdd5U36DNzwOTGOuJwwxWu0ziVVawCLWtbf1SmkkH8+Vma9mfmVhaNK8u1PfeNgsP
         icI5Gm0W25qIT3Hw3Wf1R8/Y/7BF3o3r5Qm+Yu9j3cw/nULH6OLmkZvyZyMeueFK6pnt
         yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472268; x=1780077068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieO3ZF9y/Qw0rFDXiSUM+2kgBRGgpLsK1ca4Gwqd1jo=;
        b=NH9Sx2MAZ/1c2MzVWLs0ZKcKvrwzfTEzQZjuxzDPD5jhUIm6eylXEhTWPEAOkJRn+3
         H9kwKDM5Xy3Vc047dgw91LXUlWRxgyvusEG9gGZNcwYgRHkd3VSJlwtjE0vu4Nu1iLGT
         YPwFhrz/jXbiIJ+1ncom99GyiQUBRIpmZexOGbAVR0p2wPVvAIDWz9+xlPIsYH82YYyU
         HJxxpvdJbH6wByWlVaNVK9dN9gCt5zvp0T9HKX65kFFUBO4VgkFspGgFuFrJPxVZah14
         GxTMh8gR1vRfJYYBxW5J9o5I4imQSkyYl+JCrU7YoYfupBaLknzdQP2UOWRc81jbIg52
         VT/w==
X-Forwarded-Encrypted: i=1; AFNElJ++UDbSB7Qe4DoEdkbTKW28Pjli/IZ0sySCFZ4564MY7M2dLVqT8af/sV7IhBAP//snb3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFk+Lgyac7isT012+l+TuPBZYeHqxHUx4UfudrAnXg/hluIcOC
	1YOCo/nwptxiEfvYYcEWTNbQuIkikdrJU2o2oKn92tbzImKxP/4AIGZZR+4mLLONuUQS4Z5oglk
	zvs+VihuB1WLyIxN0FGKKc61xF46yXrU=
X-Gm-Gg: Acq92OG1bZ5nJANoiqu9apNqkEqgv/gEiZYOcgG+vaxhIniVKfMznQMZh3LvTUiifml
	iBeNT2E3OuMrW859l3FI787dpv1WFvqSxlwxoQO8OvGKNWtT4ro68YmRMKkRcMdMrCWYQ/dreRD
	PrhVEdLx9ChuX0gDZj6yGqXDIA7EFX4+xpLxvNPfUTRE3ome61+hGRCc8E2CtSRYJ+wXRCUoN5P
	iWaeVI/KRe+R4ocrDlN6DmfuodvRumbs3n8DOsZOKJlm+PMLIlQWBJ9pF05XPaFBW2y2tZfY87z
	0d04KUHV/rmY2tQQnMxxOfM=
X-Received: by 2002:a17:907:1dec:b0:bdc:fafe:bf66 with SMTP id
 a640c23a62f3a-bdd263c9230mr248986366b.33.1779472267891; Fri, 22 May 2026
 10:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
 <20260521225022.2695755-2-ihor.solodrai@linux.dev> <CAEf4BzbjpeQd3A4CHSPO3o8PB2koGsUa2+ggWPjQqd8Ra+F2Bw@mail.gmail.com>
 <2f9d7a3f-2f60-4aed-8120-6d0bd292116a@linux.dev>
In-Reply-To: <2f9d7a3f-2f60-4aed-8120-6d0bd292116a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 10:50:50 -0700
X-Gm-Features: AVHnY4KqyvPGHTZ_Kl57oeTzyXNev9j5LvJ2Ml3dmxiHHi3YekZ2zDiNkjrzjRA
Message-ID: <CAEf4Bzac9uWWqBvzH0iFzKvJcq3vxscZ3pKm0sUHmN-F-z9wVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID helpers
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:33=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 5/22/26 10:16 AM, Andrii Nakryiko wrote:
> > On Thu, May 21, 2026 at 3:51=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Factor out helpers from stack_map_get_build_id_offset() in
> >> preparation for adding a sleepable build ID resolution path.
> >>
> >> No functional changes.
> >>
> >> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++------------=
-
> >>  1 file changed, 36 insertions(+), 15 deletions(-)
> >>
> >
> > [...]
> >
> >>  /*
> >>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
> >>   * They will be subsequently:
> >> @@ -165,44 +187,43 @@ static int fetch_build_id(struct vm_area_struct =
*vma, unsigned char *build_id, b
> >>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *=
id_offs,
> >>                                           u32 trace_nr, bool user, boo=
l may_fault)
> >>  {
> >> -       int i;
> >>         struct mmap_unlock_irq_work *work =3D NULL;
> >>         bool irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> >> +       bool has_user_ctx =3D user && current && current->mm;
> >>         struct vm_area_struct *vma, *prev_vma =3D NULL;
> >> -       const char *prev_build_id;
> >> +       const unsigned char *prev_build_id;
> >
> > =3D NULL ?
>
> Sure, why not.

so that compiler doesn't complain about potentially reading
uninitialized variable

>
> >
> >> +       int i;
> >>
> >>         /* If the irq_work is in use, fall back to report ips. Same
> >>          * fallback is used for kernel stack (!user) on a stackmap wit=
h
> >>          * build_id.
> >>          */
> >> -       if (!user || !current || !current->mm || irq_work_busy ||
> >> -           !mmap_read_trylock(current->mm)) {
> >> +       if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(curre=
nt->mm)) {
> >>                 /* cannot access current->mm, fall back to ips */
> >> -               for (i =3D 0; i < trace_nr; i++) {
> >> -                       id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> >> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_M=
AX);
> >> -               }
> >> +               for (i =3D 0; i < trace_nr; i++)
> >> +                       stack_map_build_id_set_ip(&id_offs[i]);
> >>                 return;
> >>         }
> >>
> >>         for (i =3D 0; i < trace_nr; i++) {
> >>                 u64 ip =3D READ_ONCE(id_offs[i].ip);
> >> +               u64 offset;
> >>
> >>                 if (range_in_vma(prev_vma, ip, ip)) {
> >>                         vma =3D prev_vma;
> >> -                       memcpy(id_offs[i].build_id, prev_build_id, BUI=
LD_ID_SIZE_MAX);
> >> -                       goto build_id_valid;
> >> +                       offset =3D stack_map_build_id_offset(vma->vm_p=
goff, vma->vm_start, ip);
> >> +                       stack_map_build_id_set_valid(&id_offs[i], offs=
et, prev_build_id);
> >> +                       prev_build_id =3D id_offs[i].build_id;
> >
> > you are not updating prev_vma, so why updating prev_build_id... it's
> > confusing because this serves no purpose, yet the code is there, so
> > whoever is reading this should be asking the question of "what am I
> > missing". Am I missing something?
>
> No, you're right, it doesn't look necessary.
>
> I think this is AI slop: it took too literally the "no functional
> changes" part and essentially copy-pasted a piece of code under
> build_id_valid label before continue. My oversight, will remove.
>
> >
> >> +                       continue;
> >>                 }
> >>                 vma =3D find_vma(current->mm, ip);
> >>                 if (!vma || fetch_build_id(vma, id_offs[i].build_id, m=
ay_fault)) {
> >>                         /* per entry fall back to ips */
> >> -                       id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> >> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_M=
AX);
> >> +                       stack_map_build_id_set_ip(&id_offs[i]);

you should probably set prev_vma =3D vma, prev_build_id =3D NULL here?
(give in all other case we try to point prev_vma to the actual vma
that we saw for the previous ip?)

> >>                         continue;
> >>                 }
> >> -build_id_valid:
> >> -               id_offs[i].offset =3D (vma->vm_pgoff << PAGE_SHIFT) + =
ip - vma->vm_start;
> >> -               id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> >> +               offset =3D stack_map_build_id_offset(vma->vm_pgoff, vm=
a->vm_start, ip);
> >> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_o=
ffs[i].build_id);
> >>                 prev_vma =3D vma;
> >>                 prev_build_id =3D id_offs[i].build_id;
> >>         }
> >> --
> >> 2.54.0
> >>
>
