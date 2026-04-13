Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5331354F
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110121; cv=none; b=kE8z9k5/4kNWXP1nyjjSE9YB44orKulMBaBZRGgH2VE6fFS5Ajb0ASxYxL+wxPwhC/iqbCbholVM17lwURSbSMXWAuLUfWUxcnfk3SaVto6KZnxfdNgzKgiOnDmM4UgRY4IdvJsz5XvhB2MZLn2M5U6iRf532VfFysuGa0KFBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110121; c=relaxed/simple;
	bh=fFA0oPhJ1y6oKS/dQCscTzizZvxXcw4DwiIflgYKFNc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hUR6uSJUkyNnL8Trpk60bluVBv971vqdLvaA7HmhmF8N/9ztNDQsGVZuPWGaMn5YwMV/WM8sjf0nBvB2GVLV6kRk+vtL68MSl34z14KfRc4HRjOfhIolcO7YFpc6l9sd87XbUix/Pl+Kl0nBo7EoyZ7pcKV1qxx459YkFUVGg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=diKR7cIa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="diKR7cIa"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c79467f128cso254699a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776110119; x=1776714919; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVBfhPpb6T5B2cxV2U8qzqGuSimQj2eMSClLgFg4X7I=;
        b=diKR7cIaztKT6TFbult8CbKdHn8MA9tFDy01p4ZDcTR3pojEa6vdSTA8Vfz77L+72B
         Z9sMJBQB8+RKgTyAiMHlHXy9KUWhuakyiVUfl2QSGC9pN34uQYwjO3Wjd5masGnE0PqO
         Si8O+4R3qtJZ83n8Cgp8yenHD5iW9Si4rF1wHVXCPABgEUI1lFp8jbjHwmDUXiZC/47l
         QyhKj/Gv+fkcIt0ipwXHDTdXtotWONrjkBssQBxsOXzlsYbfw9dNzCVVo0NXTtzHYnML
         raE5xDMqzGtQ4wZDLg+gIdoL4jJbEK+SihGrwzjOAPS/tWMhdRPF2ZiChTz3fmQ/BJRx
         zWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110119; x=1776714919;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVBfhPpb6T5B2cxV2U8qzqGuSimQj2eMSClLgFg4X7I=;
        b=FVd0jSdR6gAYNO8UR+FodKl6gL9Ty+BioaGDPLbT7KncCnK+l2O5gfEBoPKAh8BEgW
         VVjyEb7Ep9kGCpqYDAfI6tvCDTWF76VAqO69Unw2KkO4XmFmsn9pLf4+UFdZTtZFPwN3
         gOo7eEVdxLux577Xca0j1IiMYlMEbn03CrdnwmYB5v3tEkMDkLTmiXpd5lKOa7RcGoX7
         TUo1/s6kffEaex1wSfr9o1czuBevx5mNHABrOfpmJbVDb8xkyjLPWJ+uqhDxejtHwtcC
         XoDVYFZoTYii3yW2k7ALx378bNxVFL4v2zLv3JXhYiSR7xbH8TmlBaB8n0pLp2sRlEO0
         it5A==
X-Forwarded-Encrypted: i=1; AFNElJ+wfWSi1PvXmLIiA6wosA1/CPzVQVP7FlaHIe27TkwFXKfjPp43L+m8K59hFdx8qAUB07k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGXKcf4cABkL+cK2aMBCzw8Q0T1Obn6E2RoW9JoLhFWenZyYM
	8/ebHWX2u3uxp9xzTyDVG5/YcpLH2cUMXP9xhWVcIN9osXRYAYBTq4z3DJBImGv0sRg=
X-Gm-Gg: AeBDietiRJyMbzJH6IDVrJbzPGUrwiZc6Z7sm97vVuMJtDQBEC1OgCqdbFN5ySR/z2b
	HbbbwCxupWSmgmdNwEwdta4Yu10CzpCXbidSiHihVhvGbXVhcbqW7l5uUAr5iKUA0Igm3DCeVtT
	gnbOpAeXLMxcsF9xLLpzf6tb540jZtvqyNxFyAwKJ073L+D/tCScNJtZlBFQoxiMN05ovhbLzSd
	7u8A5Vo+o6Q5+Bul1KXsMk7b1BU6tSLvNkJTP3vWwltiUUraAQjdVNgV0uaojEWGF7d0vG9gkpj
	wrK41qDdmVhFyMtg/aELf32YncrS3QK5cbMy1Fj/Yu1jhXK2kt5ngDc/6d8yCFGLH3BI8pbaope
	tgMmsPcs0M9f0xwxbOmfgC2wuQ8gNVIGKUy/SelmRRUw4gsPnld6pG0/B7vbGrbfQYSHh9Y3Q5+
	ppmOMtNIPfW5dglftnQw==
X-Received: by 2002:a17:903:27c5:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2d593e9a0mr93547265ad.11.1776110118875;
        Mon, 13 Apr 2026 12:55:18 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45e949464sm54659175ad.24.2026.04.13.12.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 15:55:17 -0400
Message-Id: <DHSAHO1WKLJ6.1G8DTJIDOKK32@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: Fix use-after-free in arena_vm_close on
 fork
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260413194245.21449-1-alexei.starovoitov@gmail.com>

On Mon Apr 13, 2026 at 3:42 PM EDT, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> arena_vm_open() only bumps vml->mmap_count but never registers the
> child VMA in arena->vma_list. The vml->vma always points at the
> parent VMA, so after parent munmap the pointer dangles. If the child
> then calls bpf_arena_free_pages(), zap_pages() reads the stale
> vml->vma triggering use-after-free.
>
> Fix this by preventing the arena VMA from being inherited across
> fork with VM_DONTCOPY, and preventing VMA splits via the may_split
> callback.
>
> Also reject mremap with a .mremap callback returning -EINVAL. A
> same-size mremap(MREMAP_FIXED) on the full arena VMA reaches
> copy_vma() through the following path:
>
>   check_prep_vma()       - returns 0 early: new_len =3D=3D old_len
>                            skips VM_DONTEXPAND check
>   prep_move_vma()        - vm_start =3D=3D old_addr and
>                            vm_end =3D=3D old_addr + old_len
>                            so may_split is never called
>   move_vma()
>     copy_vma_and_data()
>       copy_vma()
>         vm_area_dup()    - copies vm_private_data (vml pointer)
>         vm_ops->open()   - bumps vml->mmap_count
>       vm_ops->mremap()   - returns -EINVAL, rollback unmaps new VMA
>
> The refcount ensures the rollback's arena_vm_close does not free
> the vml shared with the original VMA.
>
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

With this fix we now properly use the refcnt to keep a single vml for
all users of an arena, since having a reference to the arena implies a
successful mmap() call.

> ---
>  kernel/bpf/arena.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f355cf1c1a16..9c68c9b0b24a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -341,6 +341,16 @@ static void arena_vm_open(struct vm_area_struct *vma=
)
>  	refcount_inc(&vml->mmap_count);
>  }
> =20
> +static int arena_vm_may_split(struct vm_area_struct *vma, unsigned long =
addr)
> +{
> +	return -EINVAL;
> +}
> +
> +static int arena_vm_mremap(struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +
>  static void arena_vm_close(struct vm_area_struct *vma)
>  {
>  	struct bpf_map *map =3D vma->vm_file->private_data;
> @@ -417,6 +427,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
> =20
>  static const struct vm_operations_struct arena_vm_ops =3D {
>  	.open		=3D arena_vm_open,
> +	.may_split	=3D arena_vm_may_split,
> +	.mremap		=3D arena_vm_mremap,
>  	.close		=3D arena_vm_close,
>  	.fault          =3D arena_vm_fault,
>  };
> @@ -486,10 +498,11 @@ static int arena_map_mmap(struct bpf_map *map, stru=
ct vm_area_struct *vma)
>  	arena->user_vm_end =3D vma->vm_end;
>  	/*
>  	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> -	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> -	 * potential change of user_vm_start.
> +	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
> +	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
> +	 * being copied into the child process on fork.
>  	 */
> -	vm_flags_set(vma, VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
>  	vma->vm_ops =3D &arena_vm_ops;
>  	return 0;
>  }

