Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D4349CEF
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472042; cv=pass; b=NP4EKdCp2T4kzI0OpTG7bQyPwTFLY2KtPwQxRC4s1L2L0UsC8REjTjZyoAHgvCQNlLk4KK7pRfwcG3fy7+EyCGaromn+ww9LCE1keHH5tVqwEytVoTzAUyb7eQ1Wg90c9MC0ju2V8RHA45ipjnwVeBSPEZCRdgU10FbdOxAi25M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472042; c=relaxed/simple;
	bh=kQFTiQ2Ko7qf4EROdt4vhzcX5q+eYJHsO66IeM5vBlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuPLpw0tYksvzMAZi23xcJ5b/uP7614L7ibXJ7mtLoXKbScX6nWyUkvJeJCHTQchJzvT9wgF1KuMzllsnzux9AqgJozM+C7G4Qo3wukEDLVKPuK9LdN9T82xB4bZD4QishVrRNs/bplU+U8loFNVSTYYNzRZtZJS36cF5tprubM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLmXxAQ3; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLmXxAQ3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bdd1986cc86so232777566b.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472038; cv=none;
        d=google.com; s=arc-20240605;
        b=BeUEl3Db5WnKKZj/BhFf9necz4KHBcocNXUdlVLaaUQs7v2GbXxN+kZiR1colmRWAt
         ExD2Pj9T/LcnSX5sGf8X49jFZf1h/Wi3cgTFjI0uXzIuAStSO73rgHdRvzrdqK95hou4
         qfCnk14VIlfbjoCmU/RYFPBh/yohF70ModS8D63onWvVksVvtkkFEjk9O4f2/w++/99G
         hYsLSgvi6yOVhCe6CM5Tn5Z22y/A0+Yytw+QVcHJ8q4gH8SN4VROUs4kCRsDLKqYWMZm
         hlMyACADz0UB0hWd68aTrPEuRP2CNn1yMR+6IJfxh5XqKVDd9gjyMNtxJNoKuDiWqTF8
         9+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eSv5svL3SrYXxFAbVBnG85/RTCR72NDcGNi6SJgMYZQ=;
        fh=u2qw3vr2yxsN1wkR8udm+Bo2z51j+GYucF+5dyxHMio=;
        b=g+TKT4mYn3RMOhoFvWXSriu6hIFcILlsqedtjtMMTsS5QFO5Rh2xB5IZ3kwR0e6NAB
         gCDeixcDw5zt66talhsL2V2hvIE9/znubhL0ee2BYe8mEo5STFXC8MuewLJg0cIxmx0+
         OKpNv6IdB1PxH1Al73xumBp6z69bLMgYHoQQPq6jYrdG348hiBgZ0HPCIIJSego7p7RS
         HDSQ3CaWQLukWH3BGpSZJVUAvSOREvaAl1IMgTY04K6LJUyVuCS6+O6nd/dg48zepIkT
         oWisYKRd8tC29DxPUSxXjvkHXXrtZK6IvNXQqW8Mqp9K6wiHxX4vVsMLx9y2HE9rUYPB
         eEng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779472038; x=1780076838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSv5svL3SrYXxFAbVBnG85/RTCR72NDcGNi6SJgMYZQ=;
        b=WLmXxAQ31+QCYyMjCGPfr6Qu6298sHcpNB157QaRC+4DKVPpMYtvDbR2OVehSAaorS
         5TfcW0nsQQmg6G7o/pk+E2IFteU6983V9szjQTPX0y7/+WfL6zm5et5Ctrucx8smfDrA
         4T2dykaKirNAnirbbX3YyQPLyKkhNoJuBPyX4FsyGaiD56VyWUs4040KRDvMEP+8sryd
         OM0kUfDu6mzN6yxmmBn+iYYUzsmiCzzf/uoABWk/3geKJvLKieJ1YZBC7dKI6PPeuWXg
         2kGHcS1DSgQHXcTjJhljkH4RGWK2Vqbn+T8vXysjFdgBkCV7yLo8jTLfY+rfAwKdwwex
         zN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472038; x=1780076838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSv5svL3SrYXxFAbVBnG85/RTCR72NDcGNi6SJgMYZQ=;
        b=XPN5AaaODdP6dS3ppXK95Q1+CpEfdNyK/bUD3xE/K1TYTnGUOE0gB6+nXrhbkdENhi
         s6+GmgrvJw0I6z1qsFzEGOXa1df42y10WTckMIRqZ118MucxP9r+oTVkr7WHIVemL/kt
         Qw+yqyEquZ7bOaT3pOWjwi+ujEZOhC02gsf9Olv53v2/XtUoJEsBJu6QvpeOal5O1QN1
         xp+IGJFR/6oeOD3b4UiGVdiBr7CE4jXjSXq9tXOsPEO7OD1gTnP6drr7rvsrHx2Ks/9O
         NBQLdcHFMnNerZkVp0VPqC7/HOF1tq1Z+DWTZhS5fauPLTSIAR2Rdyka+Pk2IiZpp+bw
         fi3w==
X-Forwarded-Encrypted: i=1; AFNElJ9aieb8tJm6cizGCofaWk7G+Ky3rrRP7t5Bl6jWe2eqZfQSEGqwj0ux6KbaU8imw5xyU6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0ibrqENsVDX8x2p2NDOZbGwkn7o4iFjk3qK4ChANrtotEAtX
	eScN7TffxMm1OVpWd85z0RXQBvDT5vA8WB2nUKBQN66A+DRjf5e0RshahBUOnc5UIi1GxJ1zlwg
	DGgPn/MHwgjRYnp6aQQ/NQI29Lb5vNa4=
X-Gm-Gg: Acq92OFTdivS+dTLxc5ocbN3qnWiRu1YaQJQNg2xPyKlvdGRtvV0ObjVm7E/4AwMEgW
	tiagoyZ5bk8q80Kc52Yt6KCLev5Q5B+gWlhQiKof00/dl7/dEM7eFxhiplAz0PfZOMu1wcUChNc
	KEDLSClTTzWXfPLgO/EDkjNAR2O8ShOd4amVgyYe0h/Ce+Xiq6AfpdyOo3FbIckGBhgDL4mUync
	HRHxze8XZoPnsZknnJWJ8TO27GKrqxl15Nm1Niz1TSPRIqcIfnpuQU4vYHZ41jJnh5CMks1b8CT
	+RJxXk91I5ddl7r1qq9IN4Y=
X-Received: by 2002:a17:907:c081:b0:bdc:8cab:e250 with SMTP id
 a640c23a62f3a-bdd25aee915mr319191766b.11.1779472038173; Fri, 22 May 2026
 10:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev> <20260521225022.2695755-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260521225022.2695755-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 10:46:57 -0700
X-Gm-Features: AVHnY4LFL7pCthGYFRm7KbfPy43pdksd3OG3lU2vdvL503zTQ0tJ0S_Qf6jk_O0
Message-ID: <CAEf4BzZU8-jy8MLZYEOnoYwp0BD-8=-7nOE+Lbktw_+G3K3TUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] bpf: Cache build IDs in sleepable
 stackmap path
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:51=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
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
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 52 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
>

LGTM, one nit below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 95336c0e8b56..0d641ac39227 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -245,6 +245,14 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
>                 .vma =3D NULL,
>                 .mm =3D mm,
>         };
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
> @@ -253,6 +261,17 @@ static void stack_map_get_build_id_offset_sleepable(=
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
>                 vma =3D stack_map_lock_vma(&lock, ip);
>                 if (!vma || !vma->vm_file) {
>                         stack_map_build_id_set_ip(&id_offs[i]);
> @@ -260,8 +279,26 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
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
> +               if (file =3D=3D cache.file) {
> +                       /*
> +                        * Same backing file as previous (e.g. different =
VMAs
> +                        * of the same ELF binary). Reuse the cache build=
_id.
> +                        */

nit, for fast path comment you put it before if() condition, while
here you put it inside, I'd move this one outside as well

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
> @@ -270,10 +307,19 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
>                         fput(file);
>                         continue;
>                 }
> -               fput(file);
>
>                 stack_map_build_id_set_valid(&id_offs[i], offset, id_offs=
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
