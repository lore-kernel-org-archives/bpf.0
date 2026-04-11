Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEB271468
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930268; cv=none; b=nz/aE3J22Ua/Gdurvw3nwlRaHkkpeRh5L91alD0ogWI0aDKZeen8DST/Mu8+thSId+omUY75v3NVhJEh3KmiEVyzGV79EHoMbRqZvrTP0qaDeFB6wcFzL+uINekKyHz3ejR+Em3TD1AugAeBdg+N3J65JewHaLN4k5EtkmC2dDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930268; c=relaxed/simple;
	bh=E/oCcltPyzlPnCkL55rjOxGmdoQRnDYMKn4gBhhUPf4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=sKiTvZBIO3O/Qv9i6u4bBbhzd7Ee/jIHy95Zb+YD1aFDppiXNjoTSgnC/gDniFxNjPQBylIBwSRakF5Oleli4g/YJfDzLt8FHZL3YjaBjBjrAuov5dCOCSLIA0+h+zkf5uk1A5O+j1ya9IBdfT+f7shXQbVH2TMoxZvfnpWP7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=S1rKNtzQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="S1rKNtzQ"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b2503753efso25876045ad.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775930266; x=1776535066; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X51QS7PASdXj1x6AvsFaKG/XafN68EBd8f1SSAhlh8E=;
        b=S1rKNtzQxmrqIzSFG4qvllUXxfXoDzxMvbDdR15xFffohvqK03YyL8q7+sdLBFyTjH
         sl2Z0Y+Pi0+Tlh6CHIpaFs/fvP9resdjFf/+0+ZA7PNZHSN7JN2ANhLxWm6W++ff+In9
         RzEDWQpJBUmQyhPzyn7hr31sPOWfa5CuSA6qRQKFfqSjh26p+XaCry6YLQ5KcQL35J4L
         wuTmELDqfEBeTJd4AxdCZoC90+Ejs15Sj25qSp2ktW2fbFEfN/oQbkgh4nRl7Eg3l8Hb
         e9BDkx0sRFHQ3CDeHjrvlMnEbJEIlA5ae9p3B2vAYP+VbTlXKNCE99uTvribgqigu8IV
         HfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775930266; x=1776535066;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X51QS7PASdXj1x6AvsFaKG/XafN68EBd8f1SSAhlh8E=;
        b=LULi8M3f8uM3D1kAvWCREWVJY8EEcvyCcNG8XY7N1fTsCKJvoKw9ImvGuMplLEzhjU
         cQqRIfcMvaFk+lZvHUFnLowGJIF95++cjH0s5NnmiWZQZK9By9EFdGL9riFnDVC5oJbc
         Vo9rxt+sGeLqup+GQ9n0C540x60Hsoir3Zu8KFDmjQX5i84QN8U9XB/uXMhD1Px0bgsb
         GHsqqUjUvjaEAJJSkFjWr+//cRD3NREGpDSjPl0cUMZiBs0gV4x0hvVIfVtgIW5hUjdI
         eSyKozM29ZkxbSHfNRoWHLNo9baKGPOHmiCOvMcEakrKKp1Wz0Y1++dy8yQd2fIKbex+
         yJ0g==
X-Forwarded-Encrypted: i=1; AFNElJ9Mv3+rd0en/vdT1zmi2BvomoQcyutwK2oQlb0MvGhBxZuG28qPRXenIK3ht/MEdPhnmMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvLc8JS953YYW6cEc064iCKTFmZI2pGNNhmbpfdHscoSBEeti
	RdbAosOmvAULDUhesDzv3tMoxyE+fILIo0yIekGn4C9dtWV1iHC7DKfBJbeHvrhpTWw=
X-Gm-Gg: AeBDieuxUz4XqVgu176qUKe9PHZmuqkdN8KZHVQotqnQok29enuHw3HmYOVk6pGG5GF
	rnpJmTlCNK7kNAZVCz7idalwZ9+NKLEIUEW3qbGngDJZyishuZlImp1huBPXyhNYOtdgyzkVIaJ
	Zd1FApziOflxPzR/wZbRXEKkQhuLZuO7FZ0uV4vEdWZ92x7ME3L0exWI/LUxIALrrhePoxvl934
	sMIbZx973HZharl9kyEwALj3QPfwTxjzmH/NM72gK5U9KY67mE95qcUDsJ1RWkS+wdRJVQ5gOn0
	mbw8VNgrxwoyHbBcL38Os99/cNeAMxXchbHy9U2m+Q2j9r3vMraUm+YbsMEtEgdiP8uBS2/TMtL
	JHMvZSDym7mRI/WfiB3IucXhJvlI2oU6ADxl41CHZ3OqFaEnR0bopzUbpAnF37GB5+3uJwrejen
	uZivm32/Y=
X-Received: by 2002:a17:902:8348:b0:2b0:c59f:3b58 with SMTP id d9443c01a7336-2b2d5944c41mr56964315ad.9.1775930265731;
        Sat, 11 Apr 2026 10:57:45 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f43994sm66371055ad.80.2026.04.11.10.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 10:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Apr 2026 13:57:44 -0400
Message-Id: <DHQIQKIK31IE.3E7LKEGIMP33M@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Barret Rhoden"
 <brho@google.com>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix use-after-free of arena VMA on fork
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260411112944.1455470-1-bestswngs@gmail.com>
 <20260411112944.1455470-2-bestswngs@gmail.com>
In-Reply-To: <20260411112944.1455470-2-bestswngs@gmail.com>

On Sat Apr 11, 2026 at 7:29 AM EDT, Weiming Shi wrote:
> arena_vm_open() only increments a refcount on the shared vma_list entry
> but never registers the new VMA or updates the stored vma pointer. When
> the original VMA is unmapped while a forked/split copy still exists,
> arena_vm_close() drops the refcount without freeing the vma_list entry.
> The entry's vma pointer now refers to a freed vm_area_struct. A
> subsequent bpf_arena_free_pages() call iterates vma_list and passes
> the dangling pointer to zap_page_range_single(), causing a
> use-after-free.
>
> The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
> can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
> deterministically -- no race condition is involved.
>
>  BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:22=
34)
>  Call Trace:
>   <TASK>
>   zap_page_range_single+0x101/0x110   mm/memory.c:2234
>   zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
>   arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
>   bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
>   __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
>   __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
>   do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
>   entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
>   </TASK>
>
> Fix this by giving each VMA its own vma_list entry, following the
> HugeTLB vma_lock pattern (hugetlb_vm_op_open). arena_vm_open() now

I'm not a fan of this framing. We're not "following the HugeTLB vma_lock
pattern", we're (reasonably) tracking the VMA of the child separately by
registering it when arena_vm_open is called for it during fork().

> detects an inherited vm_private_data pointer via the vma_lock->vma !=3D
> vma check, clears it, and allocates a fresh entry for the new VMA.
> arena_vm_close() unconditionally removes and frees the entry. The
> shared refcount is no longer needed and is removed.
>
> Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes since v1:
> - Added missing Reported-by tag
>
>  kernel/bpf/arena.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f355cf1c1a16..3a156ec473a8 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *=
map)
>  struct vma_list {
>  	struct vm_area_struct *vma;
>  	struct list_head head;
> -	refcount_t mmap_count;

This is reasonable for arenas if we track each VMA separately.=20

>  };
> =20
>  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *=
vma)
> @@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, stru=
ct vm_area_struct *vma)
>  	vml =3D kmalloc_obj(*vml);
>  	if (!vml)
>  		return -ENOMEM;
> -	refcount_set(&vml->mmap_count, 1);
>  	vma->vm_private_data =3D vml;
>  	vml->vma =3D vma;
>  	list_add(&vml->head, &arena->vma_list);
> @@ -336,9 +334,28 @@ static int remember_vma(struct bpf_arena *arena, str=
uct vm_area_struct *vma)
> =20
>  static void arena_vm_open(struct vm_area_struct *vma)
>  {
> +	struct bpf_map *map =3D vma->vm_file->private_data;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>  	struct vma_list *vml =3D vma->vm_private_data;
> =20
> -	refcount_inc(&vml->mmap_count);
> +	/*
> +	 * If vm_private_data points to a vma_list for a different VMA, it was
> +	 * inherited via vm_area_dup (fork or split). Clear it and allocate a

Arena mappings should never be split because that throws all the
arithmetic in arena_vm_fault() off (the pgoff for the mapping to
the right is now counted from the split point). We need to implement
may_split() for the vma struct ops and just return -EINVAL to prevent it.

> +	 * fresh entry for this VMA, following the HugeTLB vma_lock pattern.

Remove references to the "HugeTLB pattern".

> +	 */
> +	if (vml && vml->vma !=3D vma)
> +		vma->vm_private_data =3D NULL;
> +
> +	if (vma->vm_private_data)
> +		return;
> +
> +	vml =3D kmalloc_obj(*vml);
> +	if (!vml)
> +		return;

The following is exactly remember_vma()'s code, reuse it.

> +	vml->vma =3D vma;
> +	vma->vm_private_data =3D vml;
> +	guard(mutex)(&arena->lock);
> +	list_add(&vml->head, &arena->vma_list);
>  }
> =20

> [snip]


Also go to sashiko.dev and address/explain the feedback from there, it
seems valid.=20
