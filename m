Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048D3624D4
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751992; cv=pass; b=uAOjNsYiqpKZGVqze1+xmQoB7iq2xMpHpnFd1cJVo8cWH8WzXqpvgEjiHn0lRSxSUN7xK3ySjtYCgY3uPZ5sMWGheIbzKmWOv3IqD4ch2IV/TVJo27T18PcQMrJAHzHz3zk3ArFJYibefdIK0VxPbJIk1aBf6LyfLofKm3yrIS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751992; c=relaxed/simple;
	bh=carEtSJxifw/gj6mv5bWjPH9Dl/Y4ww9N/LNzzuVDgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgGeM3xdcJzERmruJPBhWAebjqgpDlWLUUjhbJGcsM0yGamXpyH7Zom8lfnFXNClBod8rCiclxCMqIzpUedbMu9ZcKyjKmK6Uw0PJ39kc3rgjqZgTFfeRubr9/uPlUvP24aJ22EqR3pPtXw9X4Klu++XoOfMMmAvv4wmMwgiWOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHqhtKwO; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHqhtKwO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso3728176a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 15:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772751991; cv=none;
        d=google.com; s=arc-20240605;
        b=JW2F69UvtNaNIM4LIsEsNj4KuMU9grjfKfPFodsyob3oAfn3yfWrNLqKu84wLEXI1B
         sjw2/4ETL23749yl5R+1/xa/xXOMggj+9wtkoDi9QX5yxJX0LiiBhx6eEoc6LVLs76LD
         toNcrILmPtqS9HkDu5A1bm3CNglSBUE1S01z2waKVvrSQtni/mLbU9ntKKV0Mn/hml65
         bhkc+6a7MV3zlOAcxCn+6iyFgPY71+7fcMb/LG49gHdpwl3dBhy9Fi/AxNWBwDhSdE0C
         id9MSURUlV8UtC45o93M9BnKw0URK9Rp+23xR3LgGULL4auAog4lDArMG0Is+OVvFrrq
         gxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jTAkK2i3Yb+6JAX92q39PPrQNzI1fzMa8pnyYIiKS9g=;
        fh=JTlkmD1MYWXt1XMmJU9pKdqdO8edwx0mpL0T2uUqQCE=;
        b=bKGpWTDkArCeBxZyyPF0Zf6BuEvBq38Dq2vZYuDhkbkfjYUsuimiR4T+LS9FnaDeSt
         RhE/RXPWg8QNTAUwiQePDieRy8O5MEMS+ENO8Xiegy4byKLwXF1G93fekP9F/0oimQHp
         Pw3YM1x4MORXCAhHcc1Kue4XF3jQboZWUZXefUlF0tnBtdDyepCazkrHrxfdCK0d/dHz
         yvfrU9XLwPARvu4TfH78TycbepO4JlyUXXh8d2xwl8f96pR1IQqq06qf37ULpNkF6Ysk
         Y8F4Kwal3oZ8IY4qDjCORNCggoDpqF4uOSVMfcced4FDR9ir2qkM1gMTDAXnAw1eRs2+
         S7JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772751991; x=1773356791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTAkK2i3Yb+6JAX92q39PPrQNzI1fzMa8pnyYIiKS9g=;
        b=RHqhtKwOpmQZ7LTyKRjwdUcpITAkONd1iaWVn8E6h//BM0i08nJLR+L2xRe7VTKWTL
         HCq3HYd2nG+4yoReUlwtdGNA0W7EmbLyqeiMiEqw8Ai+G4sy5RcsKYWRSuBCBipki0Rd
         ZiA0+p1ZQPyXSDxnyYX3pwNhBlbxG3uiDQRmZ+D4/f1sD9TPKlRDI4KqmKMNBy9H4qT+
         MEzGO2vjsgSoa4zycmGHa3w+V4wGHzbdb8tTIuFpYmUGDTi6DlfnT2LwcotvXGkW3BCg
         qimftyJ/09+MFlZ0RopZ84kPwXC5su2G7Is2kId+/UoDCLpgl1KFzrOu7cjXJwtIj42D
         uG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772751991; x=1773356791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTAkK2i3Yb+6JAX92q39PPrQNzI1fzMa8pnyYIiKS9g=;
        b=es/ceeaQyx5017MDVEYV2XKTyJLTU4bYhLhvvS0EU270BvRNgO225/u/3MyhwqKRKY
         PkkFXw1QjbS7qqrXj4W7B6e/u6xFLxQPXRXdhma0+PrZGVNk/EnrYluygYvMZMFG13Y4
         X4GDw1ngt7A5ZsW/N4U7j2uklALTcfJmqDi993YlFvdg3sKNJPAgiMDViqU4TNlsnPLW
         vf9+q9dnyDba/6/xzT5Oxld79rApDnZf/bxZudNKTERMXo1u118zniNMXI84N1DJYKkm
         zCPh5AXWqDK+uXBm4URop7EG96iDRUFD6FJpSTEqhL6F1sOrPNyqyXfWF1n59D4sAsLM
         t1dA==
X-Gm-Message-State: AOJu0YzIu8I860OQenr0bdcvaD1XJwk1LU5FsihnF+qHTZQhSAUFS7vU
	OK3spRvNb5KrQwF1s8I8uw+iP2DlzD++DY2xVJ06F7pfj9v3khTeopab8ZlKsL/t+b4+Lg0pq1w
	OCsoz6fUTfQGZo720+p80xiZjLcmkZrc=
X-Gm-Gg: ATEYQzz+M1sVzjvcX73GnJ8X2+2t8U19UYAcW7dQsHzWg3AP5Nyn4CN8R7lFfRaXU8T
	uQFKDaY/86O2nnhacq6zcvkoEfJKQH8DuODRuEo9AdcbjVWxOg4A3q7jaE19Uctr5wkM6te7wFO
	ctEGtszSRpxcD1RISnqBxmWOmaimb5udTVDzqkh7elsZkmOBq+3yLoGTtot059NidyiIB3HlNR6
	y0TaWsSDTihk6azk7Lv1rsMckCIPk+hH2kHJICWTyhRz3cs4WGQ9o/drEJAIuf4v7YacU3rbupN
	DKmRzPk7CJqqiR5mor749x0=
X-Received: by 2002:a17:90b:1dc2:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-359be37201bmr34326a91.23.1772751991064; Thu, 05 Mar 2026
 15:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772657690.git.josef@toxicpanda.com> <c00216ed48cf7897078d9645679059d5ebf42738.1772657690.git.josef@toxicpanda.com>
In-Reply-To: <c00216ed48cf7897078d9645679059d5ebf42738.1772657690.git.josef@toxicpanda.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Mar 2026 15:06:16 -0800
X-Gm-Features: AaiRm53UPamdUKhoEcwSzy6TP_JuxHUrzqwXTFJYLzPh3afQRG386ul8olvbuOs
Message-ID: <CAEf4BzYkiwSSC5p6iEvObdKBLDW7_FGFt+Yv_vBm4RY+L7SxGg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] libbpf: support appending split BTF in btf__add_btf()
To: Josef Bacik <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:57=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
> This prevents merging types from multiple kernel module BTFs that
> are all split against the same vmlinux base.
>
> Extend btf__add_btf() to handle split BTF sources by:
>
> - Replacing the blanket -ENOTSUP with a validation that src and dst
>   share the same base BTF pointer when both are split, returning
>   -EOPNOTSUPP on mismatch.
>
> - Computing src_start_id from the source's base to distinguish base
>   type ID references (which must remain unchanged) from split type
>   IDs (which must be remapped to new positions in the destination).
>
> - Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
>   count, which is correct for both split and non-split sources.
>
> - Skipping base string offsets (< start_str_off) during the string
>   rewrite loop, mirroring the type ID skip pattern.  Since src and
>   dst share the same base BTF, base string offsets are already valid
>   and need no remapping.
>
> For non-split sources the behavior is identical: src_start_id is 1,
> the type_id < 1 guard is never true (VOID is already skipped), and
> the remapping formula reduces to the original.  start_str_off is 0
> so no string offsets are skipped.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tools/lib/bpf/btf.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..be8cc4ee83fe 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2004,12 +2004,18 @@ int btf__add_btf(struct btf *btf, const struct bt=
f *src_btf)
>  {
>         struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
>         int data_sz, sz, cnt, i, err, old_strs_len;
> +       __u32 src_start_id;
>         __u32 *off;
>         void *t;
>
> -       /* appending split BTF isn't supported yet */
> -       if (src_btf->base_btf)
> -               return libbpf_err(-ENOTSUP);
> +       /* When appending split BTF, the destination must share the same =
base
> +        * BTF so that base type ID references remain valid.
> +        */
> +       if (src_btf->base_btf &&
> +           src_btf->base_btf !=3D btf->base_btf)

only Claude could have formatted this in such a way, please ask it to
be more sensible with formatting next time (and it's still on human to
review Claude-generated code and make sure it follows the style,
besides correctness)

> +               return libbpf_err(-EOPNOTSUPP);
> +
> +       src_start_id =3D src_btf->base_btf ? btf__type_cnt(src_btf->base_=
btf) : 1;
>
>         /* deconstruct BTF, if necessary, and invalidate raw_data */
>         if (btf_ensure_modifiable(btf))
> @@ -2021,7 +2027,7 @@ int btf__add_btf(struct btf *btf, const struct btf =
*src_btf)
>         old_strs_len =3D btf->hdr->str_len;
>
>         data_sz =3D src_btf->hdr->type_len;
> -       cnt =3D btf__type_cnt(src_btf) - 1;
> +       cnt =3D src_btf->nr_types;
>
>         /* pre-allocate enough memory for new types */
>         t =3D btf_add_type_mem(btf, data_sz);
> @@ -2060,6 +2066,16 @@ int btf__add_btf(struct btf *btf, const struct btf=
 *src_btf)
>                 if (err)
>                         goto err_out;
>                 while ((str_off =3D btf_field_iter_next(&it))) {
> +                       /* For split BTF sources, string offsets referenc=
ing
> +                        * the base BTF (< start_str_off) remain unchange=
d
> +                        * since dst shares the same base.  Only remap
> +                        * strings in the split portion.  For non-split
> +                        * sources start_str_off is 0 so all offsets exce=
pt
> +                        * the empty string (handled inside btf_rewrite_s=
tr)
> +                        * are remapped as before.
> +                        */

humanspeak: "don't remap strings from shared base BTF"

> +                       if (*str_off < src_btf->start_str_off)
> +                               continue;
>                         err =3D btf_rewrite_str(&p, str_off);
>                         if (err)
>                                 goto err_out;
> @@ -2074,11 +2090,16 @@ int btf__add_btf(struct btf *btf, const struct bt=
f *src_btf)
>                         if (!*type_id) /* nothing to do for VOID referenc=
es */
>                                 continue;
>
> -                       /* we haven't updated btf's type count yet, so
> -                        * btf->start_id + btf->nr_types - 1 is the type =
ID offset we should
> -                        * add to all newly added BTF types
> +                       /* For split BTF sources, type IDs referencing th=
e
> +                        * base BTF (< src_start_id) remain unchanged sin=
ce
> +                        * dst shares the same base.  Only remap IDs in t=
he
> +                        * split portion.  For non-split sources src_star=
t_id
> +                        * is 1 so all IDs are remapped as before.
>                          */

humanspeak: "don't remap types from shared base BTF"


updated while applying

> -                       *type_id +=3D btf->start_id + btf->nr_types - 1;
> +                       if (*type_id < src_start_id)
> +                               continue;
> +
> +                       *type_id +=3D btf->start_id + btf->nr_types - src=
_start_id;
>                 }
>
>                 /* go to next type data and type offset index entry */
> --
> 2.53.0
>
>
