Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBB409DEA
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079538; cv=none; b=Rjm1vKwoOWKGyQvLU9NOnq+Swmpsc98rhulWnR8WH6lYTSDfkCjLshcdW10lHZsq38pvMhD+7dpqftqJ8n2z/hBzrxvt23KglbPUL/GGKrKzgJOMfK2YNlWyYlpiAEBIhXSujzQtPwo0fkIhBtVpZN4DsG6YyJBGIZWjzEqSNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079538; c=relaxed/simple;
	bh=6yHLsugf4BPOmxRSjyZpXCuHAw5eHDwIXxO7BTIV5L0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZntDzJ7LWEbwjeKtmaaH31beaqOKNC68fDMMIVpYUptbN8No4UaLp/kRp7H9/6gbWsFHavCPrV/Vm94Jjbjq5W+gXpLO7VqXbIQQVUwl6kKD/gzZNYiXnT/EFsSE5seE0lZKQnkoIJORe8jHeCz0UFrGM7p+E9EstC4qL++5jY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E3io3lHQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E3io3lHQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf30d530bdso4801335ad.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780079532; x=1780684332; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEnMTwseifVQXNUosEX69rKGwnNEHNt0yT1IECK57+U=;
        b=E3io3lHQpO9Od7WH6oAfgQ0kETFkABhxLDhqvZsdnp48C5GncrtxPHpYSLkhBejYm1
         sy4er0wdj7Q71W5p+Mxb8gqQJTBQa3pg6F62OzkT4Eg6MvT/8COn8KDyDolXyZd9QUb9
         hJ2KFzvKnkOQ4+VATy+lmXToCx13VRxhrzDtOekOLsXSpNJP3r3h5ov+e7d1ViQW6mq4
         aAqW2HJL/xIIWw2JisJdLdKNnL2DUynUUY9A6vcnQNAnibuDOJ4EFQAj9MZoA5dhsyOX
         SoP42m1I0EYiEVOh08+9j5QhmCYfCL9zoeNQNBWAG81kkGyeCpXGMVoibFsDm9vjAifd
         RRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079532; x=1780684332;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEnMTwseifVQXNUosEX69rKGwnNEHNt0yT1IECK57+U=;
        b=H7MsiyZJ1FxqYv8sg8wQPx8nhq/wG38hWZiQqUAn1VB7ZXyzlLdNG9ocmC55bwUCUQ
         bzFdRvb8fh+HHRPFIieevptpASU2GdS1JvM1tT0g+tmd0neBRiuxEEJjs9a3c3KTc2ri
         tQQIWcTvxFjY0XruW1oec/kfG3Nod7wDCNcuwdpCgt8+YpfNKUAoeyiEFCYOwJM4kFGT
         nezVWpFJUpLOF87M18AwV3zj8ZB4stjqbSZcvedUs9o0Jjelluo0PSPbvFlfje7beNCL
         Uxc0gk2edlEKvkjrU/R88J0694KvDfVsMpqfFLBWnYcegjYDMsPi+oFuW+3ogD+8AOcR
         sLWw==
X-Gm-Message-State: AOJu0YzBm4UZHke1/Rdl7DpSMpeBvYq9EI3RSwOhob3nXCu/5LYfPF3n
	sJkQt5t1EbPf6n6WNwUwgldov/FNR9ReXyoT6MDXBxoex6AKgqvibcnwAQZ7M7Rl4mIzPakgyhy
	m+JtvWIIVm5xn
X-Gm-Gg: Acq92OG6AYe7Lap9J3w0eUUUkYHlQycXAKJcDWAgB/Par7i3lvwkaw52J7ahKS3Z8fb
	5UxH1qLy1Xw/1hp+iiQJ0j3gSxv8wBAaoAP66fCtzArlvdfphHw0+5VZU0KSVW9GXVT85NWjiv7
	qClpqGPJhbNWns6UrtCJMYalDX90E2KZOm/GjYRFSzuE1dflSpx3IYRxgzcpi/W7rjaVrBtPiz+
	MdVCN0+mFf4920a8bZkRCS9Px+a2cSD7r8BnEd5TyKY9z7AQdAqEennyW4eqAJho8CBd1T9XfAU
	oR5kASoHLj5dgfDXOm9rqUhCoxfo8V+WsvUnBJSF7K4YRh8e5UJwWQG3LtZ0opNDVbwl97qVwg+
	wBj7cGigo8jzm5Vm4Ftva9qzHEriVZZC9rwkCrmSZnoErmgcpSWxUa1lAZCW9hiHdE82oDuIvGY
	rfD3n9qlnRDOrA7Ozgjv2ogCHdKof5yPzovoU=
X-Received: by 2002:a17:902:ea11:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2bf36793349mr11574205ad.9.1780079531562;
        Fri, 29 May 2026 11:32:11 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e7019sm27795065ad.11.2026.05.29.11.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 14:32:09 -0400
Message-Id: <DIVDJ2NK7D7T.H674L5S9JWSJ@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard" <eddyz87@gmail.com>, "David Hildenbrand (Arm)"
 <david@kernel.org>, "Tejun Heo" <tj@kernel.org>, "linux-mm"
 <linux-mm@kvack.org>
Subject: Re: [PATCH bpf-next] bpf: Take mmap_lock in zap_pages()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528222014.38980-1-alexei.starovoitov@gmail.com>
 <DIUWW97NOAG2.N0U9S6VNDIQ7@etsalapatis.com>
 <CAADnVQJK2=VTU-spL0T+HxQSiJKg7XYtkqv5LgnQmsyFOgJcxw@mail.gmail.com>
In-Reply-To: <CAADnVQJK2=VTU-spL0T+HxQSiJKg7XYtkqv5LgnQmsyFOgJcxw@mail.gmail.com>

On Fri May 29, 2026 at 2:20 AM EDT, Alexei Starovoitov wrote:
> On Thu, May 28, 2026 at 10:30=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
>>
>> On Thu May 28, 2026 at 6:20 PM EDT, Alexei Starovoitov wrote:
>> > From: Alexei Starovoitov <ast@kernel.org>
>> >
>> > zap_vma_range() requires the owning mm's mmap_lock to be held.
>> >
>> > Taking mmap_read_lock under arena->lock would AB-BA against
>> > arena_vm_close() and arena_map_mmap(), both of which run with
>> > mmap_write_lock held and then acquire arena->lock. Instead drop
>> > arena->lock, mmget_not_zero() the vma's mm, take mmap_read_lock, and
>> > re-resolve the vma via find_vma() since it may have been unmapped or
>> > replaced while waiting.
>> >
>> > Track processed vmls with a per-call generation in vml->zap_gen and
>> > serialize zap_pages() callers with a new arena->zap_mutex so
>> > concurrent callers on different uaddr ranges do not mark each other's
>> > vmls processed before the zap is done.
>> >
>> > Reported-by: David Hildenbrand <david@kernel.org>
>> > Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> > ---
>> >  kernel/bpf/arena.c | 61 +++++++++++++++++++++++++++++++++++++++++++--=
-
>> >  1 file changed, 57 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> > index 1727503b25d8..9b2dea229b38 100644
>> > --- a/kernel/bpf/arena.c
>> > +++ b/kernel/bpf/arena.c
>> > @@ -60,6 +60,8 @@ struct bpf_arena {
>> >       struct list_head vma_list;
>> >       /* protects vma_list */
>> >       struct mutex lock;
>> > +     u64 zap_gen;
>> > +     struct mutex zap_mutex;
>> >       struct irq_work     free_irq;
>> >       struct work_struct  free_work;
>> >       struct llist_head   free_spans;
>> > @@ -289,6 +291,7 @@ static struct bpf_map *arena_map_alloc(union bpf_a=
ttr *attr)
>> >       if (err)
>> >               goto err_free_scratch;
>> >       mutex_init(&arena->lock);
>> > +     mutex_init(&arena->zap_mutex);
>> >       raw_res_spin_lock_init(&arena->spinlock);
>> >       err =3D populate_pgtable_except_pte(arena);
>> >       if (err)
>> > @@ -391,6 +394,7 @@ struct vma_list {
>> >       struct vm_area_struct *vma;
>> >       struct list_head head;
>> >       refcount_t mmap_count;
>> > +     u64 zap_gen;
>> >  };
>> >
>> >  static int remember_vma(struct bpf_arena *arena, struct vm_area_struc=
t *vma)
>> > @@ -403,6 +407,7 @@ static int remember_vma(struct bpf_arena *arena, s=
truct vm_area_struct *vma)
>> >       refcount_set(&vml->mmap_count, 1);
>> >       vma->vm_private_data =3D vml;
>> >       vml->vma =3D vma;
>> > +     vml->zap_gen =3D 0;
>> >       list_add(&vml->head, &arena->vma_list);
>> >       return 0;
>> >  }
>> > @@ -746,12 +751,60 @@ static long arena_alloc_pages(struct bpf_arena *=
arena, long uaddr, long page_cnt
>> >   */
>> >  static void zap_pages(struct bpf_arena *arena, long uaddr, long page_=
cnt)
>> >  {
>> > +     unsigned long size =3D (unsigned long)page_cnt << PAGE_SHIFT;
>> > +     struct vm_area_struct *vma;
>> > +     struct mm_struct *mm;
>> >       struct vma_list *vml;
>> > +     unsigned long vm_start;
>> > +     u64 my_gen;
>> >
>> > -     guard(mutex)(&arena->lock);
>> > -     /* iterate link list under lock */
>> > -     list_for_each_entry(vml, &arena->vma_list, head)
>> > -             zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
>> > +     /*
>> > +      * Taking mmap_read_lock() under arena->lock would deadlock agai=
nst
>> > +      * arena_vm_close(), which runs with mmap_write_lock held and th=
en
>> > +      * acquires arena->lock. Drop arena->lock for mmap_read_lock().
>> > +      *
>> > +      * Use per-call my_gen, recorded in vml->zap_gen, to remember wh=
ich
>> > +      * vmls this invocation has already processed across the lock dr=
op.
>> > +      * Hold zap_mutex around the whole walk so concurrent zap_pages(=
)
>> > +      * callers cannot overwrite each other's marks on shared vmls --
>> > +      * otherwise call B's mark would make call A skip a vml that A h=
as
>> > +      * not yet zapped for A's uaddr range.
>>
>> One thing I'm fuzzy on: If the vml gens are to mediate between zap_pages
>> calls on the same arena, doesn't the zap_mutex already serialize those
>> calls? In that case, since zap_gen is only used for zap_pages(), do we
>> actually need gen counting?
>
> hmm. Good question!
> That was an evolution of the patch over several revisions.
> The algorithm can be changed to:
>         mutex_lock(&arena->lock);
> -       my_gen =3D ++arena->zap_gen;
> +       list_for_each_entry(vml, &arena->vma_list, head)
> +               vml->zapped =3D false;
>         for (;;) {
>                 mm =3D NULL;
>                 list_for_each_entry(vml, &arena->vma_list, head) {
> -                       if (vml->zap_gen >=3D my_gen)
> +                       if (vml->zapped)
>                                 continue;
> -                       vml->zap_gen =3D my_gen;
> +                       vml->zapped =3D true;
>
> which I think is less pretty since an extra walk of the list is needed.
> We cannot remove zap_gen completely, since arena_vm_close() can list_del(=
) it.
> So vml->zapped or some kinda marker under arena->lock is still needed.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Right, the list may change out from under us while we've dropped the
arena lock so we are restarting from the very beginning each time.
In that case zap_gen is the best way to handle this.

I can't see any weird races/edge conditions otherwise. There's no race
between zappers because of the lock. So the only race is with calls that
modify the address space of the task. These are=20
- Process exit: Handled by the reference to the mm. If we grab a
  reference address space teardown can't start. If we don't, we do not
  need to do anything.
- munmap(): When we drop the lock, either=20
	a) the munmap will win the mmap lock race, take the arena lock,
	and take over zapping the entry (and calling arena_vm_close()),
	in which case the vma lookup fails, or
	b) We win the race and complete without issue - the unmap will
	just clean the VMA since there's no pages to zap
- mmap() on top of an arena mapping that causes implicit munmap():
	Same as case 2, zapping and unmapping is in the same critical
	section so if we can't find the mapping anymore the operation
	successfully zapped it.

> Another option would be to move processed vml-s into stack local link lis=
t:
> grab the element from arena->vma_list under arena->zap_mutex,
> processed it without holding arena->lock, and then at the end
> add it back to arena->vma_list.
> Feels more convoluted.

