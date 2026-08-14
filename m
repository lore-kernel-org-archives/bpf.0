Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994421FFC48
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668764; cv=none; b=hXKN6U4iOf8z/FxxwrwsXoVKGEjBFnLsefV5L9ZcXjzJgZuS6VWbPAtFmO0VrH37aSC0UOK3dWiJEFWkm+J6gfhXySxbtJWP+EIdKq89s/2RKiuUs1MJsPrHkk/VTy4i9fDP4Zxc6+UL0AQY6gl0GsIQCVT0DFaSplaNpPSq2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668764; c=relaxed/simple;
	bh=bwhxbY6ZL6wBz3mcdu4XDlN/0VH5M8mop5uy1jxTiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kigJ0LXRb3+R9tnOLtQ4iW67s8NnNLGLL1AJg4IMJrpmYce/8zc0bSIznmf/iF5o/6fUpTtLUCGV7pjvpMk7deeq84/ThPbZp1AVC9IAGGw+UMElXimBnWjjbQTO0g9YMXKyYiUsG0Cdu36k4uHSzhGWma22iwFZRac5hp0ZPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAxF1MZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAxF1MZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537FE1F00A3A
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668763;
	bh=ZN0AsNJS3aORrQWgKiMI3G3Tez0uHG0+X1FtcQ6s3Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DAxF1MZdvTqdfx1RnNQ9WHC7cBqR437hIyCmjMCamSTYBHLLpuR3EiJ3lBtM2HO9B
	 3bnw3fgrt9/snN8Bw2UbYk30bWwTf6RTdVVEOulLV5iH60AraRYSh58ZCKZEDk2p7Y
	 YAN/+De0ndowVdTc563mtbwvC0jBWGS4LQF98MWbWAE2dz9EIJ6oIrJoTfEbr2pI03
	 4czgIZVoyFou4QGJ9ZKwpc2xZqrXbz1CusTG186Tnasb2NTE/PWFYf0DuSFxaWD/KF
	 Aa4UqHfoAKN/IKBfvtcr2Opn5UjKrMcPlztlxqn2At3wDLK06bBSnGpKu6KmzHAxat
	 AYX56lNTE3zuA==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e6391b114so37302285a.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:52:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoutByzZHBrAsghErCYfaZgEZAwNOTTx9+zFqKD7Mc8fIm9gZG
	Bd/+CULx6X6otWN9vmpKhnbie97ylZsL/hwPtorHHikIRNJ7c5mPXd2NB6H5eA36B83v/55jXuA
	TbuAJlbpAgKCpDknx3UywIS5fDZlJ3wM=
X-Received: by 2002:a05:6214:29e6:b0:8ec:a010:9af5 with SMTP id
 6a1803df08f44-90a91cd810bmr21941826d6.10.1786668762412; Thu, 13 Aug 2026
 17:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813224853.1436734-1-song@kernel.org> <dbe52cb393027ac53874b2b54bcddc6fd5687be01895e678261c45a1b76f9a8e@mail.kernel.org>
In-Reply-To: <dbe52cb393027ac53874b2b54bcddc6fd5687be01895e678261c45a1b76f9a8e@mail.kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 13 Aug 2026 17:52:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7otRv+xvJ9f8tstH4Mwp3FrkT1Qgbnvzun-39_D35K4Q@mail.gmail.com>
X-Gm-Features: AUfX_myb_XWZQpW3j7TxyipyHGCI4BEPQ6gZgFcbQ9J1Ba36XE4WPK7bfS8uLD8
Message-ID: <CAPhsuW7otRv+xvJ9f8tstH4Mwp3FrkT1Qgbnvzun-39_D35K4Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next] bpf: Populate mmap-able array map memory lazily
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:06=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
[...]
>
> > diff --git kernel/bpf/syscall.c kernel/bpf/syscall.c
> > index 7d8c3e8e6d62e..9e5e65e73dfa4 100644
> > --- kernel/bpf/syscall.c
> > +++ kernel/bpf/syscall.c
> > @@ -1076,9 +1076,21 @@ static void bpf_map_mmap_close(struct vm_area_st=
ruct *vma)
> >               bpf_map_write_active_dec(map);
> >  }
> >
> > +/* Called for maps that populate their memory-mapped region lazily. */
> > +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> > +{
> > +     struct bpf_map *map =3D vmf->vma->vm_private_data;
> > +
> > +     if (!map->ops->map_mmap_fault)
> > +             return VM_FAULT_SIGBUS;
> > +
> > +     return map->ops->map_mmap_fault(map, vmf);
> > +}
> > +
> >  static const struct vm_operations_struct bpf_map_default_vmops =3D {
> >       .open           =3D bpf_map_mmap_open,
> >       .close          =3D bpf_map_mmap_close,
> > +     .fault          =3D bpf_map_mmap_fault,
> >  };
>
> Can this affect ringbuf maps? Both ringbuf_map_ops and user_ringbuf_map_o=
ps
> provide .map_mmap but not .map_mmap_fault, and neither overrides vm_ops, =
so
> they now use bpf_map_default_vmops.fault. Before this patch a fault on
> their VMAs had no .fault handler, which let do_fault() take the path that
> re-checks the PTE under the PTL:
>
> mm/memory.c:do_fault() {
>     if (!vma->vm_ops->fault) {
>             vmf->pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>                                            vmf->address, &vmf->ptl);
>             ...
>             if (unlikely(pte_none(ptep_get(vmf->pte))))
>                     ret =3D VM_FAULT_SIGBUS;
>             else
>                     ret =3D VM_FAULT_NOPAGE;
>     ...
> }
>
> That re-check exists so a fault racing the zero-PTE window of a
> read/modify/write update (like change_pte_range() for mprotect() or
> clear_soft_dirty() for /proc/pid/clear_refs) sees the updated entry and
> returns VM_FAULT_NOPAGE instead of SIGBUS.
>
> After this patch bpf_map_mmap_fault() returns VM_FAULT_SIGBUS immediately
> when map_mmap_fault is NULL, so the PTL re-check never happens. Could thi=
s
> send SIGBUS to a userspace thread reading a ring buffer while another
> thread calls mprotect() on the same mapping?
>
> The comment says the handler is "Called for maps that populate their
> memory-mapped region lazily," but it is installed on the shared vm_ops an=
d
> actually called for all mmap-able maps, including the eagerly-populated
> ringbufs.

Both comments appears to be valid. I incorporated the feedbacks in v7.

Thanks,
Song
