Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4717745
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005480; cv=pass; b=CgXYFN6UXKdZPxVbBgPatRaUltRBstZoPG7cYaEVP2tLNccHy7Qk4KibFcTA/hKLob5MinO12se7tgU73zD6WoM2n5zYabAevRPKnN9WgNrTeLS28jrd+B79GuSJJgRW4Wdjq6Te9QahkNZu+3Iy7Wv21awUinguQqTWrzxSwU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005480; c=relaxed/simple;
	bh=cMnxzNRc/nYnU8pjDnCYUPvvm8NodtdVC/kYrBNsTzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxP6WSDh8PAicTgdUB3LrfibKs31gtcBND3s73BQJ8BABNi7j0y+3tz0fBANnE7BabpGSUK1sHYB/cnDXsxVqv1WlYM/S69xP+UkUGVgHItXJzdwTL3xaxbJdaGW7bAdTV/kO5FzUyM7qqKEW4RtcOc7q0dSviOZtm5DSz5JLMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV42txrE; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV42txrE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so3118855a91.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780005478; cv=none;
        d=google.com; s=arc-20240605;
        b=boZKpezpi35EbM8Npwc/1MBsGCpP0sBgOVEalIH34pMR4o9VTHO8xDygOf9KQNC9Qa
         IE0O330NH6MkjoM5GB+F9bFs1dfWweb65freD8y0E3NYLI6L2TY4FbnBaDa/t0+3fkSL
         aIhcD2nkXc/rbsBXLfTg/ouGSlFA/h7GetgzaFpoFrmGa/YFNq5w9y2UTAlkIdkaMKJC
         7ydRySmpsfgxrih3sYFfxFcyBYpQW9vunRHRH/LnIG2E2rboHmXYk4n/MQRoSd3Vavc4
         8zrI980Hre0i0iGrqkHv1hjmkGzLNt30zMMVPtgwoSG63Vae4E+tNzxtM4TFPgy0fqW3
         IMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FQ7atUyzA4JmqwVlklkZp5CptN+KhgqM9R0scGmVrtk=;
        fh=v5EywopDK2SLANr5ntZ12Q7SycREVsb1aUH7sVe3NZ4=;
        b=C83Gz3A5rCfjISwQ/Fab27bCJeq7w4YiaXly0tO82+pHZtMLwzDE2o6cSDPp2uAfnR
         UNuE9k6GJq2aEb8rVW90OGszSs5OMV9c6pfFpGNrk705AeOGd7uaSsN3GWKHZEBQOYDV
         /0KbvLxQqhC6CX/wIYzurEeaWHO4eZCCy5IqEOD0gKDh4rsQGpyPnrP/B9jk3oDTZz/t
         nj301JFnTThJV6ReelZw8fgeyb3wiYC67QtfMmzkANyznCmggdOqoPiWSHPB/hgXHo/V
         yrzSYSCpBEeGIq36JUX9vDs5A1NojJwbCaIfQugSlmWM68DYu+9XKJNu5CfU8ziupga8
         8bdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780005478; x=1780610278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ7atUyzA4JmqwVlklkZp5CptN+KhgqM9R0scGmVrtk=;
        b=lV42txrEXTGQdhKc9NW1ul1AYKKFgiXpFFn/Q+K1joC0eauXJ3HxAPqURoapDGeqNg
         3Fshxy65pVbPreVurpK9NkexwTam8Dxn98w6ctblNJrXDiyEHn5r2WmensEgAffsr8A8
         u/5z4j/fF7l4tHCH4c/qvTcGafllnv5Wmc2eQL+3VbNorl44xXW/VeO20/z8O4Fvrh2u
         B5lC+3naTqvhhn1NvElL9pSCP3fMM70nOx3JYp9DtX/wnE83xiwqow15GHfeWxdhcD/a
         pAOoT4Rz8vxF5ZhanaRCH1WotRKBZjZZh8GAkxbIdazGI5TTSiPMe1UjpFA7at1ahZOe
         uoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005478; x=1780610278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQ7atUyzA4JmqwVlklkZp5CptN+KhgqM9R0scGmVrtk=;
        b=ZqUrtmOgAPUjE83RsbygR7QLqX6ybys6haUK0Y9B6+HYZ0r73e0HTyfw2KpTbKO61Z
         m+QdwxA1YToAWN2w7o8cAmko3aEhvpZTcBO49X0AhgEgwbzGj5RYLwLMg4eYiOVR4NPO
         AEJhalSic5X7aE8xdwn+8FfERAOsBmr5xtbsPiBfP5csdVZDcxfeWAeHUfknP63pgB3k
         MkEvrpM9SU6fC3pJq1NH2zUegWwhmiNExJ0lb2jPDsXedC/3gW2nK7uto3PJAulLnjNI
         auHBIJjsiGb5EcHDCSae8lRp1uowNRmJYd7rQd1W9S+AqM1UTKZaoaaewnrxMFXPW6k5
         Trqw==
X-Forwarded-Encrypted: i=1; AFNElJ+mFbm2PJ5/p29qhHWr1yrRY/ww0f1tDdSJafnEeRHEBOtYzMmoQJ21UCP7+ureshBJwck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFj2J0GRJw3yRpAaaILgkom3pCjRBO/MXR+v4J4cmrsV5zeVR
	GOdhuv7/KGvjePU6lyZDi/5VReOcIBD99i68TS//ovzzuIk/IIj8map9azlSwaqwoXFDH1UC6sn
	jaEbS8umlqb4vK/h+Gzo+xjoXEbmUvMA=
X-Gm-Gg: Acq92OHYT8PA1DW3o0sMSeb0RoMtt3JFvSZrj+k5YrTyayksk6WPijEi3lQNEXszCtQ
	A69lPHwEmY2S/Js2t30bf8goPr/oMsqHFSIYB5PnsLJojlpzCJdxW0camw2nTvd93+aQepi9tky
	Da/Iolll27WdUrz7j2BwDpfBqq34sxiSOOclHS9+7l+w5ne74/L1xObGRf5xxhAibLw4ZQ6tZkm
	ypAZe/D+ACJzQpKffm5EqUlScnFWGN9ZuhIRHKs8y9oqEntH0uG13fm1QYkPTkt3j9LcjM7g+si
	ORJc2HXp+7+F3ZucGnfl8AiBSWQ+BXwFpw==
X-Received: by 2002:a17:90b:3b92:b0:368:147b:536a with SMTP id
 98e67ed59e1d1-36bbcd9183fmr374825a91.14.1780005478146; Thu, 28 May 2026
 14:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525223948.1920986-1-ihor.solodrai@linux.dev> <20260525223948.1920986-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260525223948.1920986-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 14:57:40 -0700
X-Gm-Features: AVHnY4JdWon6ARMGEhbhpJVtHz7xBKVSWDd3ly_ygj6xRfa0ix4yhS0InvmqA-M
Message-ID: <CAEf4BzZXJFr=1iiVx937ht=4PYQkQHg=eFk810zhMDzXQG3ihw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/3] bpf: Cache build IDs in sleepable
 stackmap path
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Stack traces often contain adjacent IPs from the same VMA or from
> different VMAs backed by the same ELF file. Cache the last successfully
> parsed build id together with the resolved VMA range and backing file
> so the sleepable build id path can avoid repeated VMA locking and file
> parsing in common cases.
>
> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 61 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c53cfd9a67cf..77ba03216c09 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -246,6 +246,14 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct stack_map_vma_lock lock =3D { .mm =3D mm };
> +       struct {
> +               struct file *file;
> +               const unsigned char *build_id;
> +               unsigned long vm_start;
> +               unsigned long vm_end;
> +               unsigned long vm_pgoff;
> +       } cache =3D {};
> +       unsigned long vm_pgoff, vm_start, vm_end;
>         struct vm_area_struct *vma;
>         struct file *file;
>         u64 offset;
> @@ -254,6 +262,17 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
>         for (u32 i =3D 0; i < trace_nr; i++) {
>                 ip =3D READ_ONCE(id_offs[i].ip);
>
> +               /*
> +                * Range cache fast path: if ip falls within the previous=
ly
> +                * resolved VMA range, reuse the cache build_id without
> +                * re-acquiring the VMA lock.
> +                */
> +               if (cache.build_id && ip >=3D cache.vm_start && ip < cach=
e.vm_end) {
> +                       offset =3D stack_map_build_id_offset(cache.vm_pgo=
ff, cache.vm_start, ip);
> +                       stack_map_build_id_set_valid(&id_offs[i], offset,=
 cache.build_id);
> +                       continue;
> +               }
> +

Same issue as with patch #1, this is a lost opportunity to avoid
unnecessary work if VMA has no matching build ID. We should do
negative caching (i.e., have build_id set to NULL, but use
vm_start/vm_end for subsequent ip matches) and avoid unnecessary vma
lookups. Let's treat it as optimization and address this in a follow
up patch.

>                 vma =3D stack_map_lock_vma(&lock, ip);
>                 if (!vma) {
>                         stack_map_build_id_set_ip(&id_offs[i]);
> @@ -265,17 +284,47 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
>                         continue;
>                 }
>
> -               file =3D get_file(vma->vm_file);
> -               offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->=
vm_start, ip);
> +               file =3D vma->vm_file;
> +               vm_pgoff =3D vma->vm_pgoff;
> +               vm_start =3D vma->vm_start;
> +               vm_end =3D vma->vm_end;
> +               offset =3D stack_map_build_id_offset(vm_pgoff, vm_start, =
ip);
> +
> +               /*
> +                * Same backing file as previous (e.g. different VMAs
> +                * of the same ELF binary). Reuse the cache build_id.
> +                */
> +               if (file =3D=3D cache.file) {
> +                       stack_map_unlock_vma(&lock);
> +                       stack_map_build_id_set_valid(&id_offs[i], offset,=
 cache.build_id);
> +                       cache.vm_start =3D vm_start;
> +                       cache.vm_end =3D vm_end;
> +                       cache.vm_pgoff =3D vm_pgoff;
> +                       continue;
> +               }
> +
> +               file =3D get_file(file);
>                 stack_map_unlock_vma(&lock);
>
>                 /* build_id_parse_file() may block on filesystem reads */
> -               if (build_id_parse_file(file, id_offs[i].build_id, NULL))
> +               if (build_id_parse_file(file, id_offs[i].build_id, NULL))=
 {
>                         stack_map_build_id_set_ip(&id_offs[i]);
> -               else
> -                       stack_map_build_id_set_valid(&id_offs[i], offset,=
 id_offs[i].build_id);
> -               fput(file);
> +                       fput(file);

we should probably negative-cache this lack of build ID and update
vm_start/vm_end here, in a follow up


> +                       continue;
> +               }
> +
> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_offs=
[i].build_id);
> +               if (cache.file)
> +                       fput(cache.file);
> +               cache.file =3D file;
> +               cache.build_id =3D id_offs[i].build_id;
> +               cache.vm_start =3D vm_start;
> +               cache.vm_end =3D vm_end;
> +               cache.vm_pgoff =3D vm_pgoff;
>         }
> +
> +       if (cache.file)
> +               fput(cache.file);
>  }
>
>  /*
> --
> 2.54.0
>
