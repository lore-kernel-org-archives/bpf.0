Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C229DB86
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029471; cv=pass; b=QHmFMJDrs/h35uEjZignceqcimPZUUCCF/ES9BwcvcfKrQgh6WBBgIzPgyCACwoAeXsRqu9kp/oNBkD8zRBDbPRoDM7GYcmrdGi4POpOoxy+du4zm8c0PSCbsQTt1kYV+BJKidIK9+61l4FcHUN0tlkBxorrQCB7fWvme4OWth0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029471; c=relaxed/simple;
	bh=oX1CbE28lxDAIihZErj/SQQxAv/YdTeOHxmzeIhBeSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmkvXJukbAuhZ/f+FP1nNZuDLfy2zNHqOt2xnuQfZjVYEFYZge7yyguH1cZrNS6RzqGxXmddi5p2NdDGCXuGnu3y/3RAdXJomZgBWkiBjdJ2jIoLDcKl25yVWKUKrWX2Fw4oZr6LTY6NXKl//skShxLsIrOuhCVc+Aac2dVnWbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxQukoJJ; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxQukoJJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8efed61so34854115e9.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776029468; cv=none;
        d=google.com; s=arc-20240605;
        b=RlMcrOK03e4sIVrjFL1WhSK0j6oH5hIWj0mtF6KVeqloJyB25p77AnefFR5dW38tsn
         sO6uClBU3hecOGAEWbkJzMATf0bfuu0ZZbB9fvk3BDpuW5kPlMV6f5CfHhz+5THgnlpd
         BmMivbJM9not4G3vc3fKWj/+cQPTkJ4caLwGHlZIWeK0ndk8v0+3LC2JD6iTMTsBTyVv
         w+845fs10t9CbYc3cjLW20ejfARSE6OVuewnNENzjnIPz1ZqseCtJbZURSw/nauq+zyH
         Njvh+4ZrUo4k2rDcZdx9BnGjjPY0w2thfD5O/l/vtcU4L6KhNsTjJvcXIWBlaYB6Fo8Q
         dTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/59mymj48hq/Uh2yed5w//Zm/ed8snS6+Lm0thX0iBA=;
        fh=q4vOy6vIMDUhs6LPDyj6NrVJVX93ItAYP0moB+eE8b4=;
        b=kbSkDN2TGuiAXNCN4Qj5RbCzCyPQmHSTHO/BcbCxs1x+S5eb/5mI3HbgUYvl0t14Wd
         cydqr8UdGD5P22yGJZSEapChhuUK7/LONOjXt6RL+wpNDYN15pWqDtztskdJzckBTxGW
         RwxnCj/K/NCdZkxT188fE6lO1EMLucatrTszB985Vsjn7ySBSlYj1cwBxv5TVl44judi
         40M1gTeg1qFa6ZPoJ/H2biLIelFOLPl8nNhIUzY45lYcx1pylec58eWFbXYpGstWYXJw
         m6H0Zw9pQrV+2Rp87DXxNeD3hM4MiLSY6n1V3mfr+L8YtXVEAAUwQhPS3wHe59P6jJGn
         AQIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776029468; x=1776634268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/59mymj48hq/Uh2yed5w//Zm/ed8snS6+Lm0thX0iBA=;
        b=bxQukoJJE/uCjXhKVP+6d7XQ1gmwo9hyFBNy7lQYffd4HjqAQYRJ3DcE2+K3Gmh+4k
         PPkPFfBE2xSKWrD6sbJjbhA2Pf7Ln83uNiScU2SMXrQTDDHvDZGX8mlvGXBYOFaLRcDk
         MvkpjaKnmY9B8ZO0COHZsp08sQ45oujw3yAK766iz5UDZeXnCCAtDZ4m0rx8KCUuQtkt
         /ihz1Olt9kcNpRGtY/YIn4sbKBOIIEivbZGTFLE8i0QeOhfyN+KBZCq3hdVHfZXfK8WL
         Ui2sghJK3hRG9vrxGwFcpQ5dUVUj/kOx+iNWlZgW5KfYfFC5L8LzYHP9AfqaE9VLf9O8
         Lneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776029468; x=1776634268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/59mymj48hq/Uh2yed5w//Zm/ed8snS6+Lm0thX0iBA=;
        b=pLVGiZZAh7hDPJsunTYkekjop3mq/ZLUe1mPpuc7i0MohuxUsvGn0CV5mp/N6+kkdY
         S/W6gJ2KAAGb8vm5UAdWQvoddIm1oCbDyO/yjt4D5hsGv3CyEyVln0JeiAJTa4bxTRkz
         ZS1ci0KDTsHmFuORw/CqslLFZExpCbtPhaCDFt4mSl2gfHX9pwuHHgkCKdpOEx72qtqN
         pRS5VLJrjb5Aynw4qFkdURUVhVh7re9Jt9JhJI0m1KF3oDwCTC6hsIihjWUmSmAV1xpm
         aocXqMawTMTso3N6pAuoA9EsU03Se/dcqNNu5u+IgeUtc6xlPiLxtMPBF/CTTqk7phB8
         B+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMLrNGUCZr4rUO39Yg+i+J2v8xsCalmc5oVMuI/7BHEC6Q/k4uoEH969/zHJpEfslMaKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdvp3a1sX3ajM3NL9h1kf5J1zJer37FrwIOImSbZ4S0EXJuH+
	L2Byzor0BaLBIBId7WGOp0vUKWTo2eBlyfsuHpZIcSev+rO8Vnl4RhEbx1RYfNnPZYb5LB7Dg3c
	b9Of9e2Zc5QI8WOdbn6x15NH/kMPBhoE=
X-Gm-Gg: AeBDievVXjHwUzpeK6UD8q5P6ZVSe++pvwfPQXeVGHM/kzNsoBtzNWIDoLodNuu6CGd
	QS7eHaZZ63d3Th5SUvl++kTJH2mt7s+dB+xrf3RcOD2Ov4n09sqz+KuzWIf8UOyChdPIGa6DoFd
	ftD47ocyrfTsOlB/AbsuNvWaX+a0+gEMDhF9qW0uWJUaQvzjOo6iGyzwO3Z7yNPaCGnMMAN51J9
	bV6PcQrbe0Bmb4keGJCeQ/DNr3hNiHeCX7RicB4U1fURG80vSCxeSWuxQ9sl5B3qRVuH6sNqnqt
	tA+cFKKnn5wOFcsIJhcBVsh4ya+Lmvo/psK9G64CzenjHwam5ynEsSUtVgREJKoIBF4/TGT0EE3
	BEIuJwek33nDK0fr97KzhVpy+UQ==
X-Received: by 2002:a05:600c:49a1:b0:488:a502:8955 with SMTP id
 5b1f17b1804b1-488cd4f4a9bmr142300465e9.4.1776029467808; Sun, 12 Apr 2026
 14:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412022714.1955495-2-bestswngs@gmail.com> <20260412022714.1955495-3-bestswngs@gmail.com>
 <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com>
In-Reply-To: <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 14:30:55 -0700
X-Gm-Features: AQROBzDg1gwvzZRDdzXAoeKYCiOI6eZV4PzptYRCN0xWys737Lk8xAXDTJmlTbg
Message-ID: <CAADnVQLhnnt8uGoZk=38zH1jh_9Uy8ah=NdcoBE71qGkuH2O5g@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Weiming Shi <bestswngs@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Barret Rhoden <brho@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 10:50=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Sat Apr 11, 2026 at 10:27 PM EDT, Weiming Shi wrote:
> > arena_vm_open() only increments a refcount on the shared vma_list entry
> > but never registers the new VMA or updates the stored vma pointer. When
> > the original VMA is unmapped while a forked copy still exists,
> > arena_vm_close() drops the refcount without freeing the vma_list entry.
> > The entry's vma pointer now refers to a freed vm_area_struct. A
> > subsequent bpf_arena_free_pages() call iterates vma_list and passes
> > the dangling pointer to zap_page_range_single(), causing a
> > use-after-free.
> >
> > The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
> > can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
> > deterministically -- no race condition is involved.
> >
> >  BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:=
2234)
> >  Call Trace:
> >   <TASK>
> >   zap_page_range_single+0x101/0x110   mm/memory.c:2234
> >   zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
> >   arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
> >   bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
> >   __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
> >   __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
> >   do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
> >   entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
> >   </TASK>
> >
> > Fix this by tracking each child VMA separately. arena_vm_open() now
> > clears the inherited vm_private_data and calls remember_vma() to
> > register a fresh vma_list entry for the new VMA. If remember_vma()
> > fails due to OOM, vm_private_data stays NULL and arena_vm_close()
> > skips the cleanup for that VMA. The shared refcount is no longer
> > needed and is removed.
> >
> > Also add arena_vm_may_split() returning -EINVAL to prevent VMA
> > splitting, so that arena_vm_open() only needs to handle fork and the
> > vma_list tracking stays simple.
> >
> > Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/bpf/arena.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index f355cf1c1a16..3462c4463617 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map=
 *map)
> >  struct vma_list {
> >       struct vm_area_struct *vma;
> >       struct list_head head;
> > -     refcount_t mmap_count;
> >  };
> >
> >  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct=
 *vma)
> > @@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, st=
ruct vm_area_struct *vma)
> >       vml =3D kmalloc_obj(*vml);
> >       if (!vml)
> >               return -ENOMEM;
> > -     refcount_set(&vml->mmap_count, 1);
> >       vma->vm_private_data =3D vml;
> >       vml->vma =3D vma;
> >       list_add(&vml->head, &arena->vma_list);
> > @@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, s=
truct vm_area_struct *vma)
> >
> >  static void arena_vm_open(struct vm_area_struct *vma)
> >  {
> > -     struct vma_list *vml =3D vma->vm_private_data;
> > +     struct bpf_map *map =3D vma->vm_file->private_data;
> > +     struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> >
> > -     refcount_inc(&vml->mmap_count);
> > +     /*
> > +      * vm_private_data points to the parent's vma_list entry after fo=
rk.
> > +      * Clear it and register this VMA separately.
> > +      */
> > +     vma->vm_private_data =3D NULL;
> > +     guard(mutex)(&arena->lock);
> > +     /* OOM is silently ignored; arena_vm_close() handles NULL. */
>
> I don't see any way this approach gonna work, and frankly makes no sense
> to me. This patch doesn't take into account how the vma_list is actually
> used. It frankly makes no sense, Please think through this: If we could
> silently just not allocate the vml, why do we need it in the first place?

+1

Weiming,

you should stop trusting AI so blindly.
First, analyze the root cause (the first paragraph of the commit log).
Is this really the case?

Second, I copy pasted it to claude and got the same "fix" back,
but implemented without your bug:
+       vml =3D kmalloc_obj(*vml);
+       if (!vml) {
+               vma->vm_private_data =3D NULL;
+               return;
+       }
+       vml->vma =3D vma;
+       vma->vm_private_data =3D vml;
+       guard(mutex)(&arena->lock);
+       list_add(&vml->head, &arena->vma_list);

at least this part is kinda makes sense...

and, of course, this part too:

-       if (!refcount_dec_and_test(&vml->mmap_count))
+       if (!vml)
                return;

when you look at it you MUST ask AI back:
"Is this buggy?"

and it will reply:
"
Right =E2=80=94 silently dropping the VMA from the list means zap_pages()
won't unmap pages from it, which is a correctness problem, not just
degraded behavior. Since vm_open can't fail, the allocation should use
__GFP_NOFAIL. The struct is tiny so that's fine.
"

and it proceeded adding __GFP_NOFAIL.

which is wrong too.

So please don't just throw broken patches at maintainers.
Do your homework. Fixing one maybe-bug and introducing
more real bugs is not a step forward.

pw-bot: cr
