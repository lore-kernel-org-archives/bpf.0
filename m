Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFF3F58E9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884874; cv=pass; b=R4UlqOQ/h7SJ1i0wglCYDB9hvZPqb+DRJx21ja4xu1MSsVDbefe1Qxr7XZj7SQhdg8wEiwaRe2e2NrSF4eVjPWdEWl2LPTiDR2m519USqEp7k0Um1UyR3ko04hFipMGvQaZIVNIlKNU2FMMLU8KFFFRLr7QXOc+bUHSvx3ue1FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884874; c=relaxed/simple;
	bh=IMIINKyMFyc77B/DIzBeHolw/wbVTfQFAH7Ll2QqHps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0H4i+ijaltXzUyxWqhdpB1NsekXJpzUfNtj90U+Vx5WqaDFLCVx+iteJXtBGN4hRJNiR3cpaAI2+BK7KRnFwiw3rxNBmVf+SJ06i9T6WYj7kXP31B8iHy2LEjmeZq3O6k5VBWscLA6FiFjzuNL0WvgFagfAVhwyAZ2vgOplbDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM0+PQX7; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM0+PQX7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so160694b3a.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778884872; cv=none;
        d=google.com; s=arc-20240605;
        b=fWjejG78K30ok3IOyqmgTi2GrSOmMefy+BxDGAr+PXfaeyvi2ITB/Xxx9fam0QgEFZ
         6Lx5b3eoaaOeHIAgsD1dpD1083EYjsHT/O7XkfHQwtV06MmKg5V4IyUelouK2WsFT5pn
         09mSTIClFsKzF4FPRcJ4hnus/WjlF0g5v0Mgb5XQa2NhPEhCi+N7nPlMA7RPsP9DK9Db
         eKWZTT1tXyjchTi4f+5sfW/Xag44W+UAPOvvaSdjk5aiq2q5aZOYI1TOPCiZExqPu9+F
         rhj19+SmLhtklyGbkMucvKf2iDPHQtiNjPe2ciRsqoxuXQHPnFcybuIx2p0I2P52hW/B
         RJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7eQoLd7VYXSF8cinIyGl5Me+W6WmcmE0VDLaywIXjo=;
        fh=aCa8mS+Kf99v+GR4pMgyyPO1TzoLYDgp8e2mBEbEFxU=;
        b=dI9NpzQh+ybdvhcyGMMC7W2rYynaudHNFwSTaYRtocga8EoOkuJtnh32o7MCcnCQYo
         Gx0F78BSFmukGtXe3KlFpRo5pl1BpGM3cKqh4ATMeNey67XQ/2UhuIH6voMs10dChlU+
         as2pevX3pELwckbtPTsa4PKonHNitxLB14s9y5KjG1A1LIbO9KUL61FNHDFosXhYOQ/s
         id7YT5lmfCDUFdYquD3y72LH0YwUXSrlcUJjIo8J3nryhz6UXdtb0mSQhaN4DJWCz0iM
         mt5G7Haq+n6rleZyl0B71y6bRHwb4XgpEIu6RITN/oHa+ZMdmedCipxqfQXAelNN7BTs
         MqTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778884872; x=1779489672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7eQoLd7VYXSF8cinIyGl5Me+W6WmcmE0VDLaywIXjo=;
        b=nM0+PQX7goVXs0Uwov+hKVBN158AdM8T0XtfhZ2KttFevl/7x6vT7BvQGW8gHYhPe8
         63LO+rvuaggVk7lxQ5gtRh0HPPsn9Ax0o1Q5c7VX1oxu6Ws9FueBHoW9rQTLZwkgC/v7
         DIq1q/nN/q5lElKqVK+fjrmiETkw/P94NdUsy/6aI4LaOgsAyHJo4CSeDvCH3gHzVTGp
         3xPWJIwWuDfrTY60jMj/QcQiyzlnGxaTM5PdwMPbYTOFa6pv1MToBeXRjmr7ncisAqqU
         50zsXZoN8ObcDCvhFYReSBi9Tee2iWKJfbdwYzHWnHj/NG+F7RXTGq+fzyYJjp1w+RfO
         61Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884872; x=1779489672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7eQoLd7VYXSF8cinIyGl5Me+W6WmcmE0VDLaywIXjo=;
        b=eWBQcVBh2X2j4q5jgSlq9j9WlFc7o4aOUragkRnVja/ajk5wzXtIVQ1Q7764Mzc7fp
         3DLZIJhgqqiwANKUWPLHrujcZ1ykax+nKAhh/JOBwoAbDs53JXf/vJw9HTID0pwz3ltF
         TsINqSOZ4aULhCHB3P0j899Lkl9QFRJdfmoIkBz30b6dXRAWF2yIEgCuGQ+TOMZ2Knua
         l3F0kFzyDPswDgMtoN4nqoNsbGxaWlqcntsZfHeT3ZIWamIvtutGxjHnqKKf9X6nAFl6
         1nQSOlQseyw8Ux5sN04usaqQ1Muw8d20tQT3TIduRHrkd6tMA8YwzURdmaPsHfG+STvB
         /9Qg==
X-Forwarded-Encrypted: i=1; AFNElJ/avZfZHTLnGJ7OXp3Z4ypIvlBezztUjEIZG+9uNQtVMO3mfx5syEo406vHnjrkmCV6UD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0okriNUT11zhxHrtV7MRhGerGnylGZzTcn2FW71DuzW6i1aN
	6//iOYQZyAi2Gtf8HtHlS8mWlFVLTSffUx/8jFC6vjEvI0GkSSFBOHD0ywZ9+7oJHrLWY1cqO0g
	47RHjcVskDoAimDGhSIStZsefKA7WR9A=
X-Gm-Gg: Acq92OG0Hh3X3e8Mobgf0wXV0UiwXh8u9HA8+9bYZruz3HpnjB2ShwhksEGgVqZ6TPs
	5JRMFyHL+GlTtQQBwnRzw9M7Z1foYb+2nhZ4lnpISXcEsCZt9N4R7XxzWOWjGSk58rdsZp9jPW6
	Fm/Xd42i4PK9U+H+KkjzjpdTrnYCtoIbCEDSR5KDOFlDW9kGh0M14edTdFvPcOn9M0qT4jR5edg
	k0jhsC3L0iAznEhQXONJaTUnUe6g3Loz8Bv5nOpVvQJTsw2AnM/rqwCMFXCmVehYhxfFuuFFsom
	abor6fIhBuWL518A5a4ihk8DcMmU3wDDpQ==
X-Received: by 2002:a05:6a00:bc93:b0:82a:7893:e14b with SMTP id
 d2e1a72fcca58-83f33d98510mr6283480b3a.38.1778884871820; Fri, 15 May 2026
 15:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev> <20260515005244.1333013-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260515005244.1333013-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 15:40:54 -0700
X-Gm-Features: AVHnY4KCMHB5PJLYkiZrmTSk3e9FRt7Zx9WSCJjpsSYD9IDMroxByH95pIDdl08
Message-ID: <CAEf4BzYYmA7=pSe--McfQNP=SEkPnZyhBLb-_-eB8XS4Gtw2QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpf: Cache build IDs in sleepable
 stackmap path
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:53=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Stack traces often contain adjacent IPs from the same VMA or from
> different VMAs backed by the same ELF file. Cache the last successfully
> parsed build ID together with the resolved VMA range and backing file
> so the sleepable build-ID path can avoid repeated VMA locking and file
> parsing in common cases.
>
> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 56 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 08f7659505d1..7336fd55c856 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -230,13 +230,33 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
>                 .vma =3D NULL,
>                 .mm =3D mm,
>         };
> -       unsigned long vm_pgoff, vm_start;
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
>         u64 ip;
>
>         for (u32 i =3D 0; i < trace_nr; i++) {
>                 ip =3D READ_ONCE(id_offs[i].ip);
> +
> +               /*
> +                * Range cache fast path: if ip falls within the previous=
ly
> +                * resolved VMA range, reuse the cache build_id without
> +                * re-acquiring the VMA lock.
> +                */
> +               if (cache.build_id && ip >=3D cache.vm_start && ip < cach=
e.vm_end) {
> +                       vm_start =3D cache.vm_start;
> +                       vm_end =3D cache.vm_end;
> +                       vm_pgoff =3D cache.vm_pgoff;

isn't this unnecessarily convoluted way of doing things? If we are
here, we know for sure a) how to calculate offset and b) we need to
memcpy. So just do that here and just then maybe jump all the way to
id_offs[i].offset setting. Or just fill offset, status and memcpy
build id here and continue.

> +                       goto build_id_valid;
> +               }
> +
>                 vma =3D stack_map_lock_vma(&lock, ip);
>                 if (!vma || !vma->vm_file) {
>                         stack_map_build_id_set_ip(&id_offs[i]);
> @@ -244,9 +264,21 @@ static void stack_map_get_build_id_offset_sleepable(=
struct bpf_stack_build_id *i
>                         continue;
>                 }
>
> -               file =3D get_file(vma->vm_file);
> +               file =3D vma->vm_file;
>                 vm_pgoff =3D vma->vm_pgoff;
>                 vm_start =3D vma->vm_start;
> +               vm_end =3D vma->vm_end;
> +
> +               if (file =3D=3D cache.file) {
> +                       /*
> +                        * Same backing file as previous (e.g. different =
VMAs
> +                        * of the same ELF binary). Reuse the cache build=
_id.
> +                        */
> +                       stack_map_unlock_vma(&lock);
> +                       goto build_id_valid;
> +               }

same thing here, file matched, so memcpy(build_id), calculate correct
offset, set offset and status, unlock and continue. This logic is
pretty straightforward, IMO it's cleaner to copy-paste these 4 lines
than dealing with the goto maze...


> +
> +               file =3D get_file(file);
>                 stack_map_unlock_vma(&lock);
>
>                 /* build_id_parse_file() may block on filesystem reads */
> @@ -255,11 +287,29 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
>                         fput(file);
>                         continue;
>                 }
> -               fput(file);
>
> +               if (cache.file)
> +                       fput(cache.file);
> +               cache.file =3D file;
> +               cache.build_id =3D id_offs[i].build_id;
> +
> +build_id_valid:
> +               /*
> +                * In the slow path cache.build_id points to id_offs[i].b=
uild_id.
> +                * Cache hits leave cache.build_id pointing at a prior sl=
ot,
> +                * triggering the memcpy here.
> +                */
> +               if (cache.build_id !=3D id_offs[i].build_id)
> +                       memcpy(id_offs[i].build_id, cache.build_id, BUILD=
_ID_SIZE_MAX);
> +               cache.vm_start =3D vm_start;
> +               cache.vm_end =3D vm_end;
> +               cache.vm_pgoff =3D vm_pgoff;
>                 id_offs[i].offset =3D (vm_pgoff << PAGE_SHIFT) + ip - vm_=
start;
>                 id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
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
