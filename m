Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A663AC0D7
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699068; cv=pass; b=g8EQjgJaPPK2qqATpQecs/n18KoSsigpT/DnqUH7kVqHxCiJimxFurnwrNnDXua4zd/sGPFYWSAxLsdopKwjW+QW4jy/YLZDVagWsq8Z40wwSvxtw7u45iA/ZHPXdgbuAK0GukZEafRR7zeU+4ZmKnmYJUeZ1ZthgDQMUgL083k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699068; c=relaxed/simple;
	bh=BDGXWsEhgyjSIJMWbJkv5zZr6cmbxD8QsvMf8ntDbaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eajPjgC8wBLMAdyrtoiv13VPfn1yENUgDxsiQx2qtcCmWYL/fkeyPDRBCAnypp5RyPAojqxru4bSNOf3RY1YGVLz4+8VvZl7l+qtWcs+ZLr1htQku0VVjCiOxPgQTr6H7uzrQpLy2iy7tQWJg2mbwuQVwHUtevKkjr+db3/NqE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWLdjLcG; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWLdjLcG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44b052142e1so4048665f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778699066; cv=none;
        d=google.com; s=arc-20240605;
        b=FS6PBtRd4bvN95chMYcrjr7w14pAUA7VN8us8fzuuQllSJwpZfaeV4yFwRXW/KE+j0
         0nGA30pNEloD3PRtS5QaQ1RWuCnjW4XanMm+oaXpX8D5oRjS7onNq+KTzu0N4tUfVzGE
         8RBd/XQXt4c4ev5r7JJhCgZ7ULOzIsHBKQ4r7sz5ECQ3KifBXSv6ypH5tuBRRPGCc+UP
         kov+MTWDjX8StH129YPiaf+fKB4dcuXV+EPma0E3AOwHznq3GbPirwzxhhBESp6TChUb
         royh21mJ4MuPdnlp0KmXe6CRtfrhzWb0BjHnCKLxOP7yUmbgG/Tl6thO8Ea2PZevEu6p
         OrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YNq/o4IU8ikyfmt7nA2sK4MgLgtGuKDEcxYMsskEhxc=;
        fh=zk77WJdbLjl8oM4Qp7aUkotmtZ0eWSaTees+Vxnolt0=;
        b=a8z2EK28kqjqok7chlhiwK+P2G7E1Z5McTB67WXOmfmSO3ET4mmephWQRYIoHDRoV3
         HGoWwa3nPtLW4Md+4C7CH1upGT0av0D2qhODWGVu7WhIbKqIrMcE4N5RQuv4Jz61OgIs
         okTBVUGVnKuELCS3IqYNNkpF7wDxVH1iRAv6wnrossEiY25bKbtAA3CP9pitgn9HE0EX
         9rS0Qx/5F3Q//qJY3C7Brsa5n+2QTeK02EmTV0ArFiMujQBZpU23dIUJvCpR+Ppt6+hB
         aANd/oaNF/8mozTdG+wa7nNpSWXuq4gCZO8qSx7T9HECHz+rt2OiST8JGFN+Ut+VPX6l
         ZTdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778699066; x=1779303866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNq/o4IU8ikyfmt7nA2sK4MgLgtGuKDEcxYMsskEhxc=;
        b=nWLdjLcGWFsmAI7i4It1eVbrx0JFlxD392FKOxbQX7qC/7rC6MvuqqM8IUCZ7qHBHr
         4a9yNS3H6ouo3mfhAun5RrqTSM18Sj0olNAEdotVP0NfvQoHN4yUhDeIWA3C5/wntWKi
         782dweZBpZNNBs6iP8eibQcoRYT58iKgppZiaPHh2uywEA5UvH8x9075JTGnbRKFvKHK
         Ljx5Bo+Ps1ntJIj039s1xBt6OIec4XteaVEu1tomUuOgwjxhIVu4QxV0VuqtRTPME8Aq
         xwa/6VjDQya28VO09GP0SxLG1sfZ9G2cVWLpCPBe65lusZ53AIf6TdG4q7tgLabAvh7B
         vQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699066; x=1779303866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNq/o4IU8ikyfmt7nA2sK4MgLgtGuKDEcxYMsskEhxc=;
        b=SRGRI1hzmARGxfqpUNIb1CiXG5eGC61L7YQ0Fm7yJvn7I9dqC05fzKp8GMLIMGEy7w
         oF71bFraZSskn9iY+NEB0ONZV+QcnN/QPV6WXbI7tMHxCsE8Ne5cMDl/Ui8hhXaXX8N2
         ZU3bgoVfNJMfG+lP0YqadieYcUEiyULFujOYNqL0WOmCGGbRr0VbfNBOFa1rbVvkjHyZ
         fvAsrGXmjlVV2QZSaRaJqmDNUnrT9kiOtRQcE7WBFsCFU9oal1GDAs9nFjjBme9ecoBG
         16wcbaPyX4zMcWEoXI+43aB+XUB3VU5aTVzfNQhWWST7SNlDB5FGiz5tewLXnGwbdOCC
         /fMw==
X-Forwarded-Encrypted: i=1; AFNElJ9w4sgR9h4unDpGcAk+L1vnLwlzNRGW4MUXI/3xLw9F0Cv8swJOZaq1H7hd9PsP5Jxtjig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQNnVy/cmkP9nzFcce/PC5ZoUsMuJr28Pi+R8L3sGHAzod/k/
	5IUHeToAbPyfy2QJwTWl2fgtqC0tdAVmZB87hbI6EoPTQctoSuPkxMvmhmv9Fw4JaQKVn3Chf+q
	l5lqsZ8jZsLyEL6trmrMMNWIJSDoXpKY=
X-Gm-Gg: Acq92OG0nFq6PLxfYf4WpxT0tRAJjMa62OGog9AmxUJqTo7uRNDjsExaJVhO8a5VW1j
	RhlTv329p6QONKHK4SSxT9ZCHhLZnOw5Of+1vBketyxRGJdvLSBMzC6HH2CSbuwfpknyam9uKtB
	d9uY0nujj7NJGTm5fMPo+Zap2M0PzRJqYO5Nwesf5x/x8PelA5nI55wbDbp6N6QowEfBaMEPBpA
	HI10n2ZUyTa+qbzkv2TF04qHr/pTRyugeN6wBsCrfYQ7aZcvJ95EvIXQjcgQ70Jg4H1mPtr1Jcp
	BZFEgj/XsnqCe/5R2A1BexGwQiRPA4v8dAISmr/rtAOW94XslzHF6+MgE1k4UkPshG+z7fZYLN+
	IoXD89aNYgJz4kHLqRZi6E/2U7aghLE8os9Jd
X-Received: by 2002:a05:6000:25c4:b0:441:1fa5:4577 with SMTP id
 ffacd0b85a97d-45c59228f72mr7616112f8f.26.1778699065337; Wed, 13 May 2026
 12:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513180923.628644-1-hodgesd@meta.com>
In-Reply-To: <20260513180923.628644-1-hodgesd@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 12:04:14 -0700
X-Gm-Features: AVHnY4LfcVX8iBceeRYxIgtjYR67WpOHjfZTDthTIat8qiTykkQ3tQdztDwqcGI
Message-ID: <CAADnVQKgWUK+tEHrb+teNXTdpR-zfoKajcoGfivuYDM4yCb2Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: arena: fix use-after-free in VMA tracking on fork
To: Daniel Hodges <hodgesd@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Barret Rhoden <brho@google.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:30=E2=80=AFAM Daniel Hodges <hodgesd@meta.com> w=
rote:
>
> arena_vm_open() only increments a refcount on the existing vma_list
> entry without creating a new entry for the child's VMA. After fork,
> vml->vma still points to the parent's VMA. When the parent unmaps
> (arena_vm_close decrements refcount but doesn't remove the entry),
> vml->vma becomes a dangling pointer. A subsequent bpf_arena_free_pages
> call reaches zap_pages() which dereferences the freed VMA via
> zap_vma_range(vml->vma, ...), causing a use-after-free:
>
>   BUG: KASAN: slab-use-after-free in zap_vma_range+0xf2/0x100
>   Read of size 8 at addr ff11000113ec9b10 by task test_progs/198
>   Call Trace:
>    zap_vma_range+0xf2/0x100
>    arena_free_pages+0x6de/0x970
>    bpf_prog_a2b540a82b1066f3_arena_free+0x8b/0xb6
>    bpf_prog_test_run_syscall+0x3d3/0x8a0
>
> The same issue is triggered by __split_vma (partial munmap) and
> copy_vma (mremap), both of which call vm_ops->open.
>
> Fix this by giving each VMA its own vma_list entry instead of sharing
> one with a refcount. arena_vm_open now allocates a new entry for the
> new VMA, and arena_vm_close always removes and frees its own entry.
> If the allocation fails in arena_vm_open, vm_private_data is set to
> NULL and arena_vm_close handles this gracefully, meaning the VMA
> simply won't be zapped during arena page frees.
>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>
> Assisted-by: Claude-Code:claude-opus-4-6
> ---
>  kernel/bpf/arena.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..a3c46100dd12 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -310,64 +310,71 @@ static int arena_map_check_btf(struct bpf_map *map,=
 const struct btf *btf,
>  }
>
>  static u64 arena_map_mem_usage(const struct bpf_map *map)
>  {
>         return 0;
>  }
>
>  struct vma_list {
>         struct vm_area_struct *vma;
>         struct list_head head;
> -       refcount_t mmap_count;
>  };
>
>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *=
vma)
>  {
>         struct vma_list *vml;
>
>         vml =3D kmalloc_obj(*vml);
>         if (!vml)
>                 return -ENOMEM;
> -       refcount_set(&vml->mmap_count, 1);
>         vma->vm_private_data =3D vml;
>         vml->vma =3D vma;
>         list_add(&vml->head, &arena->vma_list);
>         return 0;
>  }
>
>  static void arena_vm_open(struct vm_area_struct *vma)
>  {
> -       struct vma_list *vml =3D vma->vm_private_data;
> +       struct bpf_map *map =3D vma->vm_file->private_data;
> +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +       struct vma_list *vml;
>
> -       refcount_inc(&vml->mmap_count);
> +       vml =3D kmalloc_obj(*vml);
> +       if (!vml) {
> +               vma->vm_private_data =3D NULL;
> +               return;
> +       }

I'm tired of seeing the same garbage patch from claude for the 3rd time.

Please make sure you use claude on the latest kernel.
The fix 4fddde2a732d ("bpf: Fix use-after-free in arena_vm_close on fork")
landed a month ago.

pw-bot: cr
