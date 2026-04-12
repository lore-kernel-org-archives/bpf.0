Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E7271464
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016232; cv=none; b=qJUe4Mi05n5oov40C6Q1KlzH/5MvCIMPg8U7DZ7r/AMZlPFW0BxF7xcaj/7XLiL+RHFskNIrMhDmny5hZcfWDM5QNi9UTRUHBkf5ot00OPflhGMS2e4/jgGMTFJdckipIogrz4cabBvkMp8Bdas3r9zMjkp1jTcI3M+khSDmOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016232; c=relaxed/simple;
	bh=MO5ChqIj6eBlsl1X/BErRE5/LMKk/u+r0pbAtFtjgxw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DjUpR5GaohcC7r2dbhNN/iukSTP6zQueFEFBDUo4woT52PfEEVnCCxYNzVCHSc694V3Pe8ZG/OQZU/XJxWHyZgQXieorbbtX4Jbbk9RyEMvNuGmyuAKSABFO7fV0TDyE4DJD/rnv/+zv5f3OiiL9a1RZ+KaH8egskAChV0Ecf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YZoVALDR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YZoVALDR"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so2540347a12.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776016231; x=1776621031; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkWEhd2EXU8hjRmcN+Lzt3xwwfOUcHUJdWDJ50ejHsY=;
        b=YZoVALDRBFgrsC/2LSFKwO2gDhEzjUGYbEThUaqW+fsqgZofVFMWdEAIEcWQuRQRVM
         Nzd4VjVBofapzJjr93LGHMla88FT/GzY6pXEFnUhrVZgZ5qZoZjKmjmODaaU9j9wZ7qk
         yRaSaR9/lF7QKN7PS6a+tqyCA3O/Y1+Rc/z7JdIIDO4YGzvAnTlHk/iXtyb8mbw6baLJ
         v9A+E4cynhjg1Dmc0mp3My2RFKzlW+itjXLLDXzR4fQQ/9neT5DPJnKV7sarRJ4pM6iS
         3A4OG2bQC8uNIbs7S7QO+9BApCTeR+WFyEb5083+jBxO18+A4HyDMY6KzaLBbI4QDvkI
         qeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776016231; x=1776621031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkWEhd2EXU8hjRmcN+Lzt3xwwfOUcHUJdWDJ50ejHsY=;
        b=WzVOlys9BmFOhSVQcCFhJY0vSSykSUOC57jPzHPdn3ApIW8ElmNz+sBdX5PlMzaoQ0
         oekIaQrSeU++aa/0k62L8TQpRYMoaG25PIi7honbZNVO/t30eoSRmJNtdGirvKVnLv1Y
         kxP60OoJ4efJRvJDH+LU9tahynIGDo+311+533l69SUgS4bX61ld76HksVeK35pomPOT
         jqV7byyU3uYhfdLgZms37TgZKy9r6fhpAeavMMH+3yPgiSOWaFQ+loQeeyu7zCiD44gv
         Wf06iOS5bqWBgmurJmIqmezGwTg2Al8ohuZtlmnksa+cCY7ZKQV0Nwdpg7a6Tow6M9BE
         4bjA==
X-Forwarded-Encrypted: i=1; AJvYcCWw3hJV94N1r+z902bqasx+X46K6AfDZtXT+y1QlR8N54gsP4JR4YlEJ5LCmlhXumWR+RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQX07VTPglo3zMOATsF9mNEbaHOTmvreqylvojtIxKMxj/xtr
	MdY3RybtEs06UDnwuzsokF1CmQgG2cM8TRTV/cVzJHqiBRblOV5z4TWEXHerKhwlez4=
X-Gm-Gg: AeBDiete2838PlUuDvJejOhuXpyR/tcAXcHIl/7dsHfNSA1lxSbgCZNO0DflC7W77D3
	APHDWxL2VYc+Tkn+mhhBRv5Hib0LM1q28KuA/ZRIEC9yt7i4khRlDoOCs1IRuFY1J4beHjNUBUv
	qgGxAquJ+kqV67fhkcNKNkJRaIaGkIl7TDyjwbAaMc/yWEK8MWFt4A3qxo+ooxIQV1bqAkFI0pV
	GFfBJBg++ZD2mCoAgRmv1wCsOlblmp+Ll6L0T7hBgG7x3L9xNaAJfvJMhOIyPN/iQVPcVv/k6fT
	CPKxBt/9lLIzZQXZLDUiUgM8aBb58bmLYYaoACstks+SF9hpu+xW13Y1ygKGF45lrhwNH/2h5hs
	ftZeVnfG4QqVKlV5RA9EBKOpx9+tIT35ZwREhAKEgKtB3CXg8+9yoLy8OADI+gXJ/ccZ7R7MkN9
	UIB8SHUTE/Qw14JI2pyg==
X-Received: by 2002:a05:6a20:258e:b0:3a0:200e:64b0 with SMTP id adf61e73a8af0-3a0200e6710mr2049519637.9.1776016230996;
        Sun, 12 Apr 2026 10:50:30 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc462sm8134650a12.8.2026.04.12.10.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 10:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 13:50:29 -0400
Message-Id: <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Barret Rhoden"
 <brho@google.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Xiang Mei"
 <xmei5@asu.edu>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412022714.1955495-2-bestswngs@gmail.com>
 <20260412022714.1955495-3-bestswngs@gmail.com>
In-Reply-To: <20260412022714.1955495-3-bestswngs@gmail.com>

On Sat Apr 11, 2026 at 10:27 PM EDT, Weiming Shi wrote:
> arena_vm_open() only increments a refcount on the shared vma_list entry
> but never registers the new VMA or updates the stored vma pointer. When
> the original VMA is unmapped while a forked copy still exists,
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
> Fix this by tracking each child VMA separately. arena_vm_open() now
> clears the inherited vm_private_data and calls remember_vma() to
> register a fresh vma_list entry for the new VMA. If remember_vma()
> fails due to OOM, vm_private_data stays NULL and arena_vm_close()
> skips the cleanup for that VMA. The shared refcount is no longer
> needed and is removed.
>
> Also add arena_vm_may_split() returning -EINVAL to prevent VMA
> splitting, so that arena_vm_open() only needs to handle fork and the
> vma_list tracking stays simple.
>
> Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/bpf/arena.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f355cf1c1a16..3462c4463617 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *=
map)
>  struct vma_list {
>  	struct vm_area_struct *vma;
>  	struct list_head head;
> -	refcount_t mmap_count;
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
> @@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, str=
uct vm_area_struct *vma)
> =20
>  static void arena_vm_open(struct vm_area_struct *vma)
>  {
> -	struct vma_list *vml =3D vma->vm_private_data;
> +	struct bpf_map *map =3D vma->vm_file->private_data;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> =20
> -	refcount_inc(&vml->mmap_count);
> +	/*
> +	 * vm_private_data points to the parent's vma_list entry after fork.
> +	 * Clear it and register this VMA separately.
> +	 */
> +	vma->vm_private_data =3D NULL;
> +	guard(mutex)(&arena->lock);
> +	/* OOM is silently ignored; arena_vm_close() handles NULL. */

I don't see any way this approach gonna work, and frankly makes no sense=20
to me. This patch doesn't take into account how the vma_list is actually
used. It frankly makes no sense, Please think through this: If we could
silently just not allocate the vml, why do we need it in the first place?

> +	remember_vma(arena, vma);
>  }
> =20
>  static void arena_vm_close(struct vm_area_struct *vma)
> @@ -347,10 +353,9 @@ static void arena_vm_close(struct vm_area_struct *vm=
a)
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>  	struct vma_list *vml =3D vma->vm_private_data;
> =20
> -	if (!refcount_dec_and_test(&vml->mmap_count))
> +	if (!vml)
>  		return;
>  	guard(mutex)(&arena->lock);
> -	/* update link list under lock */
>  	list_del(&vml->head);
>  	vma->vm_private_data =3D NULL;
>  	kfree(vml);
> @@ -415,9 +420,15 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>  	return VM_FAULT_SIGSEGV;
>  }
> =20
> +static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long =
addr)
> +{
> +	return -EINVAL;
> +}
> +
>  static const struct vm_operations_struct arena_vm_ops =3D {
>  	.open		=3D arena_vm_open,
>  	.close		=3D arena_vm_close,
> +	.may_split	=3D arena_vm_may_split,
>  	.fault          =3D arena_vm_fault,
>  };
> =20

