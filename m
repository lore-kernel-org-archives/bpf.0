Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6135AC33
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470217; cv=pass; b=oPARswMN/GrLvFOdDhQ6DpUiu55zbUEAYsA8b639x9uoGcshnBQhK3TEhwcVwPAPC6hQS8vPm58S1PCV3S1O3+6HIVLBXxjIC/vA494gZ5rsilpwLza78yrP6dow/QUeD0kULopPHFZEo0Q3iqmfay7UR/yF0bCfoVokYvfWKxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470217; c=relaxed/simple;
	bh=efVJkG0eJpwvXyufDhH2CmXyJXUPv6D9+b+1uZgEJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBQnEQOz2H+7MypnebETkQIxCS0z+MjFIzk4dN8XdHto1ux26zT8+XoRdwwcrVdHZkwibJ73GMpq+3HIqTU0hZ63V4PBLyzdvqFJ8IIadCWVRmlKnMBPPCHYklbarxzNhc+y1bOfMmHzFqSvtHHr/6NE+UgOovmmSluUWE7ueYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRBI8+m9; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRBI8+m9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7980c060cfso3346842a12.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 10:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779470215; cv=none;
        d=google.com; s=arc-20240605;
        b=SQ5knWPhjaqpMmKgQjKidffmfT47hxmbimjTE4eofT8uARZ9r6mfoKSOFaQEwNC3z/
         qXWobFEj1M3pY5OGMILqvYzTZ6s29jSVKqyMnzKu03nBj7uCZFXnSFiou5Wos2YNFYnO
         KE7Z/+UNFe27266xTgZudJU3QauXnqaOlHpEAnH2mrumgTsAuPV8wPzmCl09Ml2ehgcF
         n7Uzj7vamHPFMqRuwGKsC/pmNl47Q1Ylno93NqwowkM2tRSddJeYR3MD2xxHIqxpqiEg
         KEbSqPN/CSEQzHgljvbvsGtNOfjruzTSdlSgRCxQo5+J9mINenCcSqIfcbp8KsF7aOUO
         Q5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qLYY/rmi2IfqTQDB11qxbSq01DzC4y6qzC8T5Xy0XHU=;
        fh=gnvcvEDDq5p0J6o2sbOJxeHeidTk47RGrkLMTeRqQOk=;
        b=g5ukNlLAvbwwinInAYH5Oh5BGk4jULMwsZT1KRAhvyYnX//EveZguw87wXec7Sko/4
         3jg4CMqhvlEuJLoHSo4afb4zQ/FD0U1yVUKDYski8qdfAoizXYG9w8RcXzQDDWHtWPbL
         Vkcd4/w6f4kuPjGAEywMdGCYJyGtxnxthsQpvNv87Bay+34PQIQvS4Pm476ku/75shCi
         2InJrzSRw7f0jMuDljozF//tuGH28FIEZutOKYHovy+bgqzJHirAQS41UP7we19Vs7fX
         yW7KxrmjUbv93FtVhHmT2ZEvHV4Ie/ByDu+IdCDTXBPxqNgs99NclF3hr/bF6LElv+1T
         sCGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470215; x=1780075015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLYY/rmi2IfqTQDB11qxbSq01DzC4y6qzC8T5Xy0XHU=;
        b=hRBI8+m9A6j7jX1Kooljp3QN/qb6e7Mz0e5ovnsaqD3OcO4VfM73jCsM+f4ucccBZw
         v/saHfL3tyV8gqL4UDA0mVx2AVEKun1h/3Z/PSAxc+yfHrpivIZPSID3PYDQFEB9sRgT
         OH5SdDxVDgejA/foqMBabHQTHacpuq+axP86r1YNKBqkC8tBJIQkSPI9CcFCRbB+p5Zm
         n7uj9Hg4DU46ZLG288omdzbpyoi9KMW20WEzjQ5i1PmVvvwdca3sMvFhwg5yalEE2B6d
         LUXNNHn8amB8p1vd/HTh5SfBx+VWC6kQ9jXN/DTeKOwM+gWZn7HNW8iPRCsP4ijREKw3
         Ucbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470215; x=1780075015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLYY/rmi2IfqTQDB11qxbSq01DzC4y6qzC8T5Xy0XHU=;
        b=lm4LkCP7RZrMkdzQtq+3Nbs9KxHtnf2bajic7wtrRQyp5TikM/e00UwtP1ouu/Q9b+
         eJ3dSneb4MXKPyHVc21gLN8BKiGAN+7pjvolG+jKhflQQwXPbHq7eOqbwIT4YONEMIkt
         1RLdb23pxUpJMfXOAGSk4ju2KhTt3IRErwKlKqI+o7oAEeK/U+vrmTQ9UBS9vpPKrQQx
         clxvR8fqCklb0HwUvPUJoqEWyXNqO861Tst061ZCg4lr1BBZpyU07+CL7enwqhx2XLv8
         QzYjnAqUHxPlgkMBPTmwPUjxqUQd/9q97IcEqas1GsPUar4yMiRSTLzCONxi9GKTwBEb
         OtKA==
X-Forwarded-Encrypted: i=1; AFNElJ90uVhI6p+pm5+UhUL0fvdxHXgH+7hbimx2mqPJcHkttOuPuLOvYqeqfC39RLft5uj/Z4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZLpKZdMYQ+SH8Wx3Zri1Q1RjBQk8klF4ZS9K4lBErV2eWx3j
	WrEHafE+wWJs90a0M8yxgOe+QTU1kKs8JbpS0hm4HMQV9gu2s4xscpz/jMth4bdnsE0Tn6A2LSS
	S5LgtsKMvQ+wa/c7KYA4D6KznbyKxGZ4=
X-Gm-Gg: Acq92OGZeC9zy/4JmpPKt8s9ZYvgiHiExpjRJolTDlWnB9GQHYmGSNAbKnmRQ/Ifsjo
	S/E/z+vkit7gOazmjO8q4cEuSAjNZKOOM3te1xcZbha67C9/WiQxn6yoQpwWAddLG2nfzzgUAK4
	9Ry5eOI+pp2SZmmz503lOAYqRAa4QjQXrbXc/JCueEkbcmYtH6BXeQHh7uVXz+gvFtMmN7kXlcu
	NiZkJvU2ztD4xlGQjLEpMfiK1ov434vfDttLzWHDVUEAAHiN3+fFzZqTfHoJYbyP0I8CeGbMA21
	y1pnRSO8694c3+iC2jBGnu2MYovoyQ9OnA==
X-Received: by 2002:a17:90b:3511:b0:369:e1fa:962b with SMTP id
 98e67ed59e1d1-36a67896c7emr4444742a91.26.1779470214949; Fri, 22 May 2026
 10:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev> <20260521225022.2695755-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 10:16:40 -0700
X-Gm-Features: AVHnY4Jbua4gGnP_0ncnvO0QtXuEP4byVVWn4-w5s4tvVi8lvfZZHKIembiep0I
Message-ID: <CAEf4BzbjpeQd3A4CHSPO3o8PB2koGsUa2+ggWPjQqd8Ra+F2Bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID helpers
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
> Factor out helpers from stack_map_get_build_id_offset() in
> preparation for adding a sleepable build ID resolution path.
>
> No functional changes.
>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
>

[...]

>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -165,44 +187,43 @@ static int fetch_build_id(struct vm_area_struct *vm=
a, unsigned char *build_id, b
>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_=
offs,
>                                           u32 trace_nr, bool user, bool m=
ay_fault)
>  {
> -       int i;
>         struct mmap_unlock_irq_work *work =3D NULL;
>         bool irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
> +       bool has_user_ctx =3D user && current && current->mm;
>         struct vm_area_struct *vma, *prev_vma =3D NULL;
> -       const char *prev_build_id;
> +       const unsigned char *prev_build_id;

=3D NULL ?

> +       int i;
>
>         /* If the irq_work is in use, fall back to report ips. Same
>          * fallback is used for kernel stack (!user) on a stackmap with
>          * build_id.
>          */
> -       if (!user || !current || !current->mm || irq_work_busy ||
> -           !mmap_read_trylock(current->mm)) {
> +       if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current-=
>mm)) {
>                 /* cannot access current->mm, fall back to ips */
> -               for (i =3D 0; i < trace_nr; i++) {
> -                       id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX)=
;
> -               }
> +               for (i =3D 0; i < trace_nr; i++)
> +                       stack_map_build_id_set_ip(&id_offs[i]);
>                 return;
>         }
>
>         for (i =3D 0; i < trace_nr; i++) {
>                 u64 ip =3D READ_ONCE(id_offs[i].ip);
> +               u64 offset;
>
>                 if (range_in_vma(prev_vma, ip, ip)) {
>                         vma =3D prev_vma;
> -                       memcpy(id_offs[i].build_id, prev_build_id, BUILD_=
ID_SIZE_MAX);
> -                       goto build_id_valid;
> +                       offset =3D stack_map_build_id_offset(vma->vm_pgof=
f, vma->vm_start, ip);
> +                       stack_map_build_id_set_valid(&id_offs[i], offset,=
 prev_build_id);
> +                       prev_build_id =3D id_offs[i].build_id;

you are not updating prev_vma, so why updating prev_build_id... it's
confusing because this serves no purpose, yet the code is there, so
whoever is reading this should be asking the question of "what am I
missing". Am I missing something?

> +                       continue;
>                 }
>                 vma =3D find_vma(current->mm, ip);
>                 if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_=
fault)) {
>                         /* per entry fall back to ips */
> -                       id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX)=
;
> +                       stack_map_build_id_set_ip(&id_offs[i]);
>                         continue;
>                 }
> -build_id_valid:
> -               id_offs[i].offset =3D (vma->vm_pgoff << PAGE_SHIFT) + ip =
- vma->vm_start;
> -               id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> +               offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->=
vm_start, ip);
> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_offs=
[i].build_id);
>                 prev_vma =3D vma;
>                 prev_build_id =3D id_offs[i].build_id;
>         }
> --
> 2.54.0
>
