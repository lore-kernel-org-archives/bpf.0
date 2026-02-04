Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052430CDB6
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241954; cv=pass; b=bQdcYTqjOsJ/s8QJMBVGaUlwnrhvJADupPPz7bkh3nRgOWVglcoOJIX0UaUi+84s4KZKy1YUJWgA9PDc1TU/KXbkc5yxsLw/ReSs8SxTytgOwwLq6Sum5z+2u6N7fYZ6kYQYV6/98eATfDhATpByk/StHCVAIDPM5K+xpUQL3kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241954; c=relaxed/simple;
	bh=fWUlyRnf5vJxjwJev9GCSSp4pJJZ3JoOYTzzSqQ5mu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmRj3eU7ZUby450UjYwu9RLF05BeAyHYpesSq4XxhZuIHNBGGHHlHjOLKfSZAuoGEvvBfgH1lWA41Bo59G/+0/nx/ElsG30sPpE2OZg3My6sQR5y8jFJg7aUuq2ErHNyKnGwHe9dnLug703tSm7d1Fuo27QE+0c9a3u9jUrbCVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew2NN4lf; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew2NN4lf"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c626bd75628so63537a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 13:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241953; cv=none;
        d=google.com; s=arc-20240605;
        b=So7us2y7QATYBPckZv6jB7XIh69GKBXXbOA0qddMK5hHph8iOgUUFTxxhHH07T1xGe
         NTJktfEmig2pWi/mMNIfXQIwqH2OBVvmd/QV5bw4WKzeS7xARqAYPFYWWJGhalIGHy0P
         aLf4BDUSGt+LYCSs6anAM2SyZE0hshdMuBlNOjiLD9NCeffX2uGXQpuEx7hDTZwD/Vqa
         pWtrALZ9tC8q6D5wsALLQMQdfLFdy4v+ug32wka/DYiustYX1j7W6QGG2zhuBTtPDGjC
         a9nD1UocAV77qQl/K9srBxAyrKkkWFNuTvy+AyXT6V6bvienqwMm24lT6PLjl/ABU9EZ
         yvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKRufnWN18mAL6+NUDIjXJBXtcvH7MQKcxPmUAWIXYU=;
        fh=mZp6MSwpArXx2qgTF1hWc4n22NbjaVAq/RWolbmP1k0=;
        b=P8o0fsdXH7Fyb/KUk+wogmy7nvi1oB2/B7x2lwyOFSY2ecv4ymrXRkx01XL0+GZppY
         TKaaR327wo9yWnQ4VEeyVDk1aOBwQQ7TtoczV4CjdNp1Wk7++hInBUeiXH8lYFSiTBBH
         ZI0ayukrUQ065FzfgJ0DPd3VuDEOfBfKOyDBB+wOL6gVO9zswfVZ4pWeAphmMe/uZBYH
         rzLyH4HTRRqaMv4XLy7uD37tLalnnj7mzM58g3nfSRJR30v7twGbqqKdHpZeUw39Du2A
         fDlHkY7JfNsuWbSigp/avacSP9hCugolBWbM4W8z0ifLTsGx1SuE475HTBRJMseNSeiK
         XlJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241953; x=1770846753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKRufnWN18mAL6+NUDIjXJBXtcvH7MQKcxPmUAWIXYU=;
        b=Ew2NN4lfQCoX45Zi2PEeGfQy7/wvY10EYHZUGYOYcjHrbvdxaesPYvHI+oCGlRq8we
         yDEpcDThSwi+erkOU4DnXO/oJ0HurHglaEtV9OG5A7YSbVOqcSnMtqYYtpSWnI/8Ry9X
         odhiITtXY9Hm1r/MWWtVzvbo6EgyAKWaee86FaxmQoLW6SdFYNLNK3fcusaYiWxP+O22
         hDTlp3L02aJDr7p2vxlvGQMqCUJonm9whxSl3B5so3eeKjm7HppaX0pA9lBjRy4kCMH8
         UxoOXtH8KtylZVnBnAkP8jxi+1y/Wc8Ke7hiboqInyWhZGQdbLQ4ig77QeUVZsOpLnb7
         gKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241953; x=1770846753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dKRufnWN18mAL6+NUDIjXJBXtcvH7MQKcxPmUAWIXYU=;
        b=trHboA9XbPwB58gut5rk6eY5xLUUgA7cKZcGgH0Blj7rt+aTkQzggThOiuk/Rg5LCC
         glKrBdai7V9iukMOFGhZF9XpJPOnHPfPlBIk0ngu6/lScDllRbSodhRG+6VI4B41unA4
         4DbHKD2e/38gWfm4eYbcYhChof/QR+JJpwLQyMf9efQ1zgOw4bgGJjvcrZi1Q5tUv4xj
         HWOT5dJRZ3W7yoK5C5v+JJcl5BI/CN+xmhGFQL3YoIllgS+0uX97SLBbMOOcRJpAZ/Kx
         AEoDXhtaqSMcipHtPo/yfC3muPzqqqJxMTtoKHkq+qGRDJtSxiMYnxRyAHd3f7v+Z4pN
         J4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIENStVP7pCWlR40ECGI3ABN3NmGVNiCh82+cAFJ5gqa6dGB6/UBoPy/Nuxe7tWtcJtFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/5n6NSGhLyx//ZvSXDgjE4gNYpSVsGi5C6ZHIZSCYrILmFa1
	lH+M80Kqc/rbgXhE8+tDOegakLp6P4uTqShKKZmpgBbva7Rk/wFdVije4rg4P/8sHDn/lwyzPwK
	Fk5sjT4hBu4j2ilWFLSJlNpVcz5f4rSc=
X-Gm-Gg: AZuq6aIQbQXNRFfawYFJWSjw8Z6PJ1Ziv+UnHlZeqvs1DRyXu4ug4d8wKOYEMD9NBci
	btLnAHuFm+beb0jfcUzYZ3c5oA6ysaZAcOoknTwyYCsqJm3pu+BKuw/F/eZ+SM7OS11HjJEBNWm
	qkZSg/Z6TsQ+o+SNoiGcWl5OJkNwK2Nrn7Ob/xigAHNuUuIZrJDzBE9S7IAuX4JARW+b06XOoMy
	BVJije/Omm/qdRWdyA1J9Rqo6dCy9vJyuYG8bPVLmZA2v/3MF32QOT9qA/p5xLZSHsin9mQITmc
	4a07DZdSiYc=
X-Received: by 2002:a17:903:3d07:b0:2a0:b02b:210a with SMTP id
 d9443c01a7336-2a933e51a0amr39592945ad.37.1770241952772; Wed, 04 Feb 2026
 13:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202120114.3707141-1-dolinux.peng@gmail.com>
In-Reply-To: <20260202120114.3707141-1-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 13:52:20 -0800
X-Gm-Features: AZwV_QiZsWJ_rZuoVSLpNb84Co3RUhhMatnqnI5RJmjKRmp_wee-eFkccaFzoxk
Message-ID: <CAEf4Bzazjd_=Du7w74OkDs-cmN3HvKTm-L47RBY4T5+wtd-cUA@mail.gmail.com>
Subject: Re: [PATCH] resolve_btfids: Refactor the sort_btf_by_name function
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 4:01=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> Preserve original relative order of anonymous or same-named
> types to improve the consistency.
>
> No functional changes.
>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>

patchbot didn't notice this, but I've applied this to bpf-next, thanks

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index db8d1554bdcc..ca7fcd03efb6 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1226,22 +1226,26 @@ static int cmp_type_names(const void *a, const vo=
id *b, void *priv)
>         const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 *)a);
>         const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 *)b);
>         const char *na, *nb;
> +       int r;
>
>         na =3D btf__str_by_offset(btf, ta->name_off);
>         nb =3D btf__str_by_offset(btf, tb->name_off);
> -       return strcmp(na, nb);
> +       r =3D strcmp(na, nb);
> +       if (r !=3D 0)
> +               return r;
> +
> +       /* preserve original relative order of anonymous or same-named ty=
pes */
> +       return *(__u32 *)a < *(__u32 *)b ? -1 : 1;
>  }
>
>  static int sort_btf_by_name(struct btf *btf)
>  {
>         __u32 *permute_ids =3D NULL, *id_map =3D NULL;
>         int nr_types, i, err =3D 0;
> -       __u32 start_id =3D 0, start_offs =3D 1, id;
> +       __u32 start_id =3D 0, id;
>
> -       if (btf__base_btf(btf)) {
> +       if (btf__base_btf(btf))
>                 start_id =3D btf__type_cnt(btf__base_btf(btf));
> -               start_offs =3D 0;
> -       }
>         nr_types =3D btf__type_cnt(btf) - start_id;
>
>         permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> @@ -1259,8 +1263,8 @@ static int sort_btf_by_name(struct btf *btf)
>         for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
>                 permute_ids[i] =3D id;
>
> -       qsort_r(permute_ids + start_offs, nr_types - start_offs,
> -               sizeof(*permute_ids), cmp_type_names, btf);
> +       qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_nam=
es,
> +               btf);
>
>         for (i =3D 0; i < nr_types; i++) {
>                 id =3D permute_ids[i] - start_id;
> --
> 2.34.1
>
