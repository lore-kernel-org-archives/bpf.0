Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CE4315F
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198072; cv=none; b=IjmmE6hxsvau28zTfEuBLmpIG6u0x9Zvd40cIocTcfjVCNOF5kgEOp7+J0rKq3J76QH2PN2V5z/M5t269hT9l5UoR5juCNs92V0yG/xjaVN9ehnPrydj8vgqoTkEXH3PCgPXbvvVekK5WqzdDjUbPIsKiOV4JBosjGkMN9j0NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198072; c=relaxed/simple;
	bh=G4wI50MxwcEwBbqhQ4VBkQAoNnp5wzN6QoFZ4Au2s28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyN32aAW9RYHKYREHWKW+/8FP7h02rFedg2XgFFAPJnt1rc9Gb7LxflyQCzdHj0/wjUd1Royvo1FBLlbeb6C2kPI0XrYLT9Z3cc48+edcYtRtw7KzB8j+upnNgWtMp8lmLJRqL9yEpzFIlj5H+Lp0flZwGat+VO6+TesxXbFZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXb4P0TJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXb4P0TJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46881F00AC4
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198070;
	bh=gA9Uxo4FTIPAXruUU/SoYpSuu3RRcvWsq2XkIG+8V/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UXb4P0TJ2jeQdNITMYOBfLvrFy6mLbzEOvGJRvzJYqwnIeFXk58Ux8L8crc+Ejili
	 mhYs5YIvs98kKKHqDXkhcrwu7ofCE17EkiFgEkjk/N3UA9TD7WmMdrv2UCPpFeIyQp
	 Ff+qt+Ei1omploL9aowEBd6TV2J+1tQ+fpCrpdYxOIreLMIypMfPljWzFY+fy/CNQv
	 lJyN/tjMcKitG6yxd0J31f7lLbuH+N8DS/GhpoOico5PYt4szvoTsnNBJw1mDvxBhk
	 sY9gVdnrb81ZD5nx1Ct3kpU8DzB7VHrTqPcGvsMvotDVKh2+calfjRwBl1Qcjf/JkE
	 YtRMH9GG3oI9g==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9063b380982so32993996d6.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:21:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfSmDaYyXSFFmaimTc4Tp0XAE/vB1vdN8bblv/Zraldrma3isj
	ZlRTsLHBDLdeyi+DY15S+jmWDuAAlKfTti5YrXABuUaP5um4IHHJzAzGloDUV0XH3Zc4vATRgfI
	vxTaWJdTB7vd0yTXD5pfACO0cQ6b6Bpg=
X-Received: by 2002:a05:6214:598a:b0:8fd:6e22:c7ed with SMTP id
 6a1803df08f44-9081736d74fmr1293306d6.62.1785198070171; Mon, 27 Jul 2026
 17:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205032.1245094-1-song@kernel.org> <20260722205032.1245094-2-song@kernel.org>
 <CAEf4BzZmStZdra-mf9taSQ2=9ghSJaV_KS-MdsBCGE7upzFmrg@mail.gmail.com>
In-Reply-To: <CAEf4BzZmStZdra-mf9taSQ2=9ghSJaV_KS-MdsBCGE7upzFmrg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Jul 2026 17:20:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5o0_8Dbox1_u_OEcE-VTbzmkPZch5eawO_GD7h1+ub4Q@mail.gmail.com>
X-Gm-Features: AUfX_mx8_r4zuMP_JjW5Yh9Q9IvShcSCNB6kYCzM_oCQ1dGzSkFB07fkuDbwPSQ
Message-ID: <CAPhsuW5o0_8Dbox1_u_OEcE-VTbzmkPZch5eawO_GD7h1+ub4Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Populate mmap-able array map memory lazily
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 1:50=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
> > vmalloc'ed up front at map creation time. array_map_mmap() then wired u=
p
> > the whole mapping eagerly via remap_vmalloc_range(), which calls
> > vm_insert_page() for every page of the map. For large maps this makes
> > every mmap() O(number of pages): an 8MiB map inserts 2048 PTEs per
> > mmap() and tears them all down again on munmap(), even when user space
> > only touches a few pages (or none at all).
> >
> > Populate the mapping lazily instead, the same way the arena map already
> > does. array_map_mmap() now only performs the bounds check and returns,
> > leaving the PTEs unpopulated; the pages are inserted on demand by a new
> > array_map_mmap_fault() handler. Because the memory is already resident,
> > the fault handler simply resolves the vmalloc page and hands it to the
> > fault path.
> >
> > To keep the existing VMA open/close accounting (VM_MAYWRITE write-activ=
e
> > tracking, freeze handling) centralized, the fault handler is reached
> > through a new optional ->map_mmap_fault callback dispatched from the
> > shared bpf_map_default_vmops, rather than each map installing its own
> > vm_operations_struct.
> >
> > remap_vmalloc_range() previously guarded against offset overflow; since
> > it is no longer used, array_map_mmap() and the fault handler compute th=
e
> > mapping offset with 64-bit arithmetic so that a large vm_pgoff cannot
> > overflow the bounds check on 32-bit architectures.
> >
> > This turns mmap()/munmap() of an mmap-able array from O(map size) into
> > O(1). Callers that want the pages populated up front can still request
> > that explicitly with MAP_POPULATE, matching regular file semantics.
> > Kernel-side access to the map (via the vmalloc address) is unaffected.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > Assisted-by: Claude:claude-opus-4-8
> > ---
> >  include/linux/bpf.h   |  1 +
> >  kernel/bpf/arraymap.c | 43 +++++++++++++++++++++++++++++++++++++++----
> >  kernel/bpf/syscall.c  | 17 +++++++++++++++++
> >  3 files changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e066f44a9c05..b536f3c9e103 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -145,6 +145,7 @@ struct bpf_map_ops {
> >         int (*map_direct_value_meta)(const struct bpf_map *map,
> >                                      u64 imm, u32 *off);
> >         int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma=
);
> > +       vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fau=
lt *vmf);
> >         __poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
> >                              struct poll_table_struct *pts);
> >         unsigned long (*map_get_unmapped_area)(struct file *filep, unsi=
gned long addr,
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 248b4818178c..59fda56062a9 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -576,17 +576,51 @@ static int array_map_check_btf(struct bpf_map *ma=
p,
> >  static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *=
vma)
> >  {
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> > -       pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> >
> >         if (!(map->map_flags & BPF_F_MMAPABLE))
> >                 return -EINVAL;
> >
> > -       if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
> > +       /* use u64 math so the offset cannot overflow on 32-bit archs *=
/
> > +       if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_sta=
rt) >
> >             PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
> >                 return -EINVAL;
> >
> > -       return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> > -                                  vma->vm_pgoff + pgoff);
> > +       /*
> > +        * The backing memory is vmalloc'ed up front, so instead of wir=
ing up
> > +        * every PTE here we let array_map_mmap_fault() insert pages on=
 demand.
> > +        * remap_vmalloc_range_partial() used to set these flags for us=
; keep
> > +        * them to preserve behavior (no VMA expansion, excluded from c=
oredump).
> > +        */
> > +       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> > +
> > +       return 0;
> > +}
> > +
> > +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> > +                                      struct vm_fault *vmf)
> > +{
> > +       struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> > +       pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> > +       struct page *page;
> > +       void *kaddr;
> > +
> > +       /*
> > +        * vmf->pgoff is the page offset within the mapping (vma->vm_pg=
off plus
> > +        * the offset of the faulting address). The data pages start af=
ter the
> > +        * bpf_array header, hence the extra pgoff. This mirrors the of=
fset that
> > +        * remap_vmalloc_range(vma, ..., vma->vm_pgoff + pgoff) used to=
 apply.
> > +        */
> > +       kaddr =3D array_map_vmalloc_addr(array) +
> > +               (((u64)vmf->pgoff + pgoff) << PAGE_SHIFT);
> > +
>
> remap_vmalloc_range() uses careful check_shl_overflow() and
> check_add_overflow() checks, while we just (u64) cast and go... should
> we be more careful and avoid some weird edge cases. Not sure if that's
> possible, but maybe better safe than sorry?

Good catch! Let me add the check in v3.

Thanks,
Song
