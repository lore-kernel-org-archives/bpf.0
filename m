Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887514293
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284498; cv=none; b=ZbT92uFHlcFINnK9QSqh9cQ7JZYbOV6UGGI+g5aBQ+MVn57fUyOYvdMbyovP4p4Hm0t9NCJE3cVC4asymqC7DAf1g7D5lXGc562E0Hh2UEyCEaslfvnDlF+VGGdecc92DG3PzrS7xw5TZtHx0abj3x3i3yVVnLQhP/0v586WMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284498; c=relaxed/simple;
	bh=93juWgUBC6a5CiJHDzOXom8ubeU6fMkrKzA5KcnXN9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NynW9EMNXynf1my5yWg9tPyYiWZiD+fFe4ANoM2liYHYnCNc2rd4iKbj4sadfOZY5P21PgJeTpMJzm8yITdwwo/TJs/49gd15Aa2it/Feh1UU5OARaVxCvQx3Sabgil/Aa018bkwPBVyuotYf+r3SP/wAmwuPCR1VizXUwNNAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg+lvlAM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg+lvlAM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso416321a12.3
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710284497; x=1710889297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Besnb0UsOcy1a1WgnUfrHvLMr5+pBKawdLdz3SKU/r8=;
        b=dg+lvlAMIAxEU0WqkUUb9ccMchP8JQvWJjl/xeI++6Wuz7ID3a4sadzOBYSW2eBfAC
         5j0yMpsaSWplc94MJyuJ0+MzbJ9yMj1BuI+BqOse5Wd0fITkH50nRlTbmGGD4v5+EZTD
         /GMlSjQ0mtwrBdFVS36JK8x3zc1EfVkz8/YK5M2cqUFookHzyjovNIyEfs6/6iR/77qu
         DMt76itYuet224cW/roQ18ZEcYabT19mtBjmQ5Wzhf9Ju8S06wyzV6Wj3MP3JDwR8JZW
         SnsVI7x/XtWrmjkyKlIL9mrwStRLRt9R0pccOMY8kDF6vCcYfDx4xjQ+mcDB1VFtvYt4
         DV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284497; x=1710889297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Besnb0UsOcy1a1WgnUfrHvLMr5+pBKawdLdz3SKU/r8=;
        b=r+JL47oLNIHTrgTKw9r7bVX9xm3zAAAqKIClXySS/7WwEIkxx78oFKaqHsEOdwF2Fc
         YCocTWD3MVkhZd/jX/T7yX5Lfr6VwZfvUjnv2m3mBQxaq2byO3tjV7gpY8hdQriQVLGk
         E3dJNqOr8drmIQZySi6vb5N+lW9BRZhW5h/AxkayWLokgYGEHzXP47PpO62CBME7UoIa
         Du1gawoimQ28eKIde0iNzPfTyaYsdFnMj+WKnnAeHMsfEz+SWt0t2aXrSxEPAHpIrl29
         Byqf4cH7ch/5p5AHzG38mwQzVE5oaNa+Ons9/0HduyobmPoFIS3abJBu5V/VY0JgjbOD
         wSSA==
X-Gm-Message-State: AOJu0YzqW0rpUnvue+fJ0z2B0bGZlfhdcs1x1Lk6he7SUhZTOZxe3jlQ
	y+Rx6jIY6W4WLPYBQY4fmtfitankdrOgPeVP9j/Ny22oIAyplN092JfpzCtPhV5ov1TU8zeEKb1
	an3Z1VNs/0YmzHEtMkE2EYuhYGLo=
X-Google-Smtp-Source: AGHT+IEbN8eRrcsULl0Ty/oD8+9VL4ip1oVeQunMQDjhx8+LocB1eDfcXjgWvD40PFc5cVDDBy58IDe8+CPfUZ5gmj4=
X-Received: by 2002:a17:90b:3c0c:b0:29b:b1b5:13f2 with SMTP id
 pb12-20020a17090b3c0c00b0029bb1b513f2mr4473897pjb.4.1710284496632; Tue, 12
 Mar 2024 16:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312183245.341141-1-thinker.li@gmail.com> <20240312183245.341141-2-thinker.li@gmail.com>
In-Reply-To: <20240312183245.341141-2-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 16:01:24 -0700
Message-ID: <CAEf4BzZMt+7AhY9aC7aTC=Fd_=10kFxNmRXuQMn_Lp2VNFRhBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Skip zeroed or null fields if not
 found in the kernel type.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:32=E2=80=AFAM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> Accept additional fields of a struct_ops type with all zero values even i=
f
> these fields are not in the corresponding type in the kernel. This provid=
es
> a way to be backward compatible. User space programs can use the same map
> on a machine running an old kernel by clearing fields that do not exist i=
n
> the kernel.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index efab29b8935b..715879796046 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1131,11 +1131,33 @@ static int bpf_map__init_kern_struct_ops(struct b=
pf_map *map)
>                 __u32 kern_member_idx;
>                 const char *mname;
>
> +               mtype =3D skip_mods_and_typedefs(btf, member->type, &mtyp=
e_id);

you don't need to move this up here, btf__resolve_size() can skip
modifiers and typedefs just fine, so let's keep this one below and
just pass member->type to btf__resolve_size()

>                 mname =3D btf__name_by_offset(btf, member->name_off);
> +               moff =3D member->offset / 8;
> +               mdata =3D data + moff;
> +               msize =3D btf__resolve_size(btf, mtype_id);
> +               if (msize < 0) {
> +                       pr_warn("struct_ops init_kern %s: fails to resolv=
e the size of member %s\n",

s/fails/failed/

> +                               map->name, mname);
> +                       return msize;
> +               }
> +
>                 kern_member =3D find_member_by_name(kern_btf, kern_type, =
mname);
>                 if (!kern_member) {
>                         pr_warn("struct_ops init_kern %s: Cannot find mem=
ber %s in kernel BTF\n",
>                                 map->name, mname);
> +
> +                       /* Skip all zeros or null fields if they are not
> +                        * presented in the kernel BTF.
> +                        */
> +                       if (btf_is_ptr(mtype)) {
> +                               if (!st_ops->progs[i])
> +                                       continue;

so, this is both unnecessary to check for NULL (libbpf_is_mem_zeroed
will do it just fine for pointers as well), but it's also wrong
because user could have set this program pointer through skeleton's
shadow type, while here you won't yet see. So let's drop this
btf_is_ptr() special case, and just do generic libbpf_is_mem_zeroed()
check

> +                       } else {
> +                               if (libbpf_is_mem_zeroed(mdata, msize))
> +                                       continue;

I think it's worth emitting informational message here, something like

pr_info("struct_ops %s: member %s not found in kernel, skipping it as
it's set to zero\n", ...")

?

and move that pr_warn("Cannot find member %s in kernel BTF") after
this check, so we don't have scary-looking error-level message

> +                       }
> +
>                         return -ENOTSUP;
>                 }
>
> @@ -1147,13 +1169,8 @@ static int bpf_map__init_kern_struct_ops(struct bp=
f_map *map)
>                         return -ENOTSUP;
>                 }
>
> -               moff =3D member->offset / 8;
>                 kern_moff =3D kern_member->offset / 8;
> -
> -               mdata =3D data + moff;
>                 kern_mdata =3D kern_data + kern_moff;
> -
> -               mtype =3D skip_mods_and_typedefs(btf, member->type, &mtyp=
e_id);
>                 kern_mtype =3D skip_mods_and_typedefs(kern_btf, kern_memb=
er->type,
>                                                     &kern_mtype_id);
>                 if (BTF_INFO_KIND(mtype->info) !=3D
> @@ -1230,9 +1247,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>                         continue;
>                 }
>
> -               msize =3D btf__resolve_size(btf, mtype_id);
>                 kern_msize =3D btf__resolve_size(kern_btf, kern_mtype_id)=
;
> -               if (msize < 0 || kern_msize < 0 || msize !=3D kern_msize)=
 {
> +               if (kern_msize < 0 || msize !=3D kern_msize) {
>                         pr_warn("struct_ops init_kern %s: Error in size o=
f member %s: %zd !=3D %zd(kernel)\n",
>                                 map->name, mname, (ssize_t)msize,
>                                 (ssize_t)kern_msize);
> --
> 2.34.1
>
