Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917097;
	b=AgelUJ/MAFsMwqDmONiYqhfNSTU/zN0ANSaYe27p9kU+DpfthabJkYnrOoW6IiNxkGYw
	 UBVYfAE7jiwkdLURmOmi8BKDGJnJoazWt1fy0uZXOjS+2qnMrEyXn3MEPgmY/gVcwl0Nb
	 MU7sNAPl4m+pc9LzRDFamf+zXbQYiMCb5oMLSH7/XPAYNJKyUq4d32EY0mQqJxIc3KGVj
	 pXeDykOCp+2vA8iAmpqTjoG+XrXRHEFs2OByIpHlQzsuES5jSHFbqvflgIN3uPAwCoZGY
	 7dnjmQiXiNSOS/3MAOKM60Y4V8wG0EHaWA2ZtBu0c+PsdDCWlYUlHVyg0kwaScWEmng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fqGVZPaa7rOGThM2M7sm+fUU71jDaMCbeLhN4/WfcaI=;
	b=U2qiZGvGGwtUsUX9O3KP2n8o5MK4Hi/280NAz1Jq9JSW+QrKB1C9qFlPk6gCp+o2CMN+
	 GweoIkQrFhHN7rNr0AepP5xku1lFmpcc+WrIri75SNf0OpyNpRkCOy1t1er8h5ldBjzmB
	 44o3nBiJEqpFq1J23z1qeHunYc4CRHPZ3+Rrt7ZnxoMa/I8ciPjKHIPI3lQPHuvGm7K1T
	 ph2yf4cK8r9NYeENB6uG9O2j/adNhZsYXMgwRbVy0/MPd6IwSx6w8dXjSww+NFzj7vPZy
	 8oo/539IoBbjGT7jU5UeANC3uZQShkoSjH2OVgMO+iwyi7sZQ7CDlrNthbcLNoHPFQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKp3A2Od;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138DE606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 138DE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKp3A2Od
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d1114320so18885305ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793917096; cv=none;
        d=google.com; s=arc-20260327;
        b=kCQO9Xh/hHDj2/Ny9w3dglicNEJFiCZfo6YGv59KLdXMiXU1RGq+tJBzPJR/EgeGlD
         k7S53HhbIByYgeFnSyhjPrapscxnbdXhWcw02RBwfnub227ZHmU6ZFnITnyiZHRGDa+k
         nWG2B0e2DiSucF1M23LrSt512csRUn1yLZEen8FNoyV4Obt9/E0jnIIU/q4kqTLp4tNY
         SfuR0MGlk3eWQuozjR3DjRimm5oRPMyZz41lxW26RSpyYwYUXowu9I/wMVh8udqf5BHO
         WXx5TDzQ6tzJ+prSkzHV4fhpd/bPobyH29GNwwf+HKPOcqf6FFKJ0T/rDjH45DWEd+jY
         dm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqGVZPaa7rOGThM2M7sm+fUU71jDaMCbeLhN4/WfcaI=;
        fh=7MqQVrUscKVTetspwQFmqaom2jLxdB5WlrEowZ2WkoE=;
        b=eparmMqzSG1uBcltJUaxYwVljTwtygf9N6ZqkUu7ViTrt9RL+biCPb1jSXxJ1Ma7A6
         c0TTgW9pcBS9arstIAAG2pMEt1v+QJkmZa0kaPfp55PLpLrfqNEaQR07/MgcBDCelxKw
         qxAZ7eML1Kmmf+ZI5LMCvTRPHqQIyece0psmrGdw7B+0PanK3YOOHqtD0LC3iV4LBJJy
         R94qtjoRsRqajGGIZ6GP3z7c9QejxrsgKX3YSfFnasEybfdkl/t/g4RMUk/47GBLQVKs
         Lf8MO9GrhqfHH8NAR+XPNiGRYPhl/STYhJEanMFtwMYiEkhYwk5H782jyYQx66WuCCpq
         wf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917096; x=1794521896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fqGVZPaa7rOGThM2M7sm+fUU71jDaMCbeLhN4/WfcaI=;
        b=gKp3A2OdyUpr1iXmwvuJ2I9EuqFYLOqS2j7DQeAsRTzzvAH+XY6WgsVnEE/gdB9pN3
         t5sX1e5kUT91YUSzuJdqTs2fMBx7/Hng+qcBD2ciZMLVEdJwKMhQxb6VwOhdn7e6nRW5
         6jwg69YY6b+SNYBLO/eJXMepPYpc876dW6v3VRyiUve4KkCGsI/QyW2+a+i2uLlATGsj
         5gHUKpozkhbpl7iV/OHI25MpxIuZr5flRSeTrvZZzCDtn578uVn5RoVyJ+ez8wqeoKmR
         H6Me4PwMLSo5v4Wa3n8CDDCSM7iQHYKkZx49kpE8xH06oQStwJja6G6TmJG0QExJAHzV
         PL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917096; x=1794521896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqGVZPaa7rOGThM2M7sm+fUU71jDaMCbeLhN4/WfcaI=;
        b=LgpiVHNJ6FRLDaPoNVVOYkaqaPfp05Zn9QfoIKi4tXD683UjuFfjaLWcoRYBWq8/og
         1SXkbLNxBumWtdUkg+LLul7mxQri6RIXA9Ve+f2CaXxpujU4BEqyws2gAc2ynJpApFD1
         MI4c/Pfls91UvZec7BvmrZ/799GnvEa7C+agACbbzel0bNZFJvizE3arWlurYkqnGs3Q
         bWqHpTITZweva3ygY3nnEbba7aiprgZCQzP4PJWr5jOEC1sAfD7c4uliMj4hnDLe+VIe
         wa3beKOJ5zQxqJYSplmphnSRZOMCrqIivrrtC/0VWYqM3zoZE3JuZYJwurLzsql49WbU
         ynpQ==
X-Forwarded-Encrypted: i=1; AKwUvByC0USq2SIO+QTC1S0bIVSODlPS3+Exkc8LHAN/mazKwcZferwyKPLC/3R7owS9JS2u2VM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lk1wnpFYf5MCkQiIHzSE9XYy5nn/p1doIC2Xc31NwK3l8Pjkc
	6ESyn0KxxR9YSOTMrT7456VPJ5XL0lVoSbLPWP7sq3Mio7fH9tmVX/dJAlrupt89GVkSoc6xsWF
	odB7LhllUr0TRei5jJ6y3tLsjj7TZX7c=
X-Gm-Gg: AYBFou1csu/2YMafEauxeKunI0zpWAtZq9vzGMYzYB+yinVLZt/UmuNfgoaECDVXz/9
	Npu+xuQ5Yxo1xi1SE6D9PeCeUZzCdU9mN3Kqf8MTDWcd1o9MC5A0MoSmwqupFclImvTfoZ1Sczs
	CBfCXpvR/ucsrdKhCjh8S7ML2jf+yASphf/cPOebPP8efMEdk5DdlcdTs1fhzJ8b2WsiTknw2l+
	3Ct2ccQUUaKDX4kKNlU2INQd/sq65RGK+g3zyL5BabQYDu0+LxLyO8Cw5lVC9cUWST5x+NSke8b
	CSrSaBcou6NNw/c2BkxMTOw90VIJ69UGJWoPtaGvFTrilCUd/MwBLR95PJ6trp76gAEb11lJZQu
	ReozzpjMN1CMaLLn1BcCjRfTq7YpCNElglKNs0P28iS6Njd+lf0XP0V88OhEpqf04j+RZSj7php
	Y78lqYK6HYFtm9MHgQ4g8Pd4d8E9gKw1L6/Q==
X-Received: by 2002:a17:902:d2cd:b0:2e8:5202:aa8c with SMTP id
 d9443c01a7336-2ed41c447c2mr10044985ad.48.1793917096355; Thu, 05 Nov 2026
 14:18:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101103221.51534-1-dennylin0707@gmail.com> <20261101103221.51534-3-dennylin0707@gmail.com>
In-Reply-To: <20261101103221.51534-3-dennylin0707@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:18:03 -0800
X-Gm-Features: AclHuK_dLJPArclYNX3UADg6ClTszBmlVMJeiwepHsSAXolKV5xcFCTVjjhNWVg
Message-ID: <CAEf4BzaES0KDyhHhk7UguLmRKVWxGoiEXhNvp7QHpeJSZSjbYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Preserve unsigned enum values in
 data dumps
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, qmo@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, eddyz87@gmail.com, 
	ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:32=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com> =
wrote:
>
> btf_dumper_enum() loads ordinary enum data as signed and uses signed
> numeric output. Unsigned values with the high bit set can therefore be
> printed as negative numbers. Narrow unsigned values also fail to match
> their enumerators: an eight-bit 0xff is loaded as -1, while its named
> value is stored as 255.
>
> btf_dumper_enum64() likewise uses signed numeric output for unmatched
> values. For example, 0x8000000000000001 is printed as
> -9223372036854775807 instead of 9223372036854775809.
>
> Load the data according to the enum's signedness, use btf_enum_value()
> for name matching, and select the numeric writer according to kflag.
>
> Retain the original signed-width comparison and give it priority over
> new matches. This preserves names from older BTF without signedness,
> including eight-byte ordinary enums, and keeps the selected name when
> multiple enumerators could match. Remember the first normalized match
> while looking for an original match so only one scan is needed.
>
> For an eight-byte BTF_KIND_ENUM with kflag clear, a negative stored
> enumerator can therefore match both its sign- and zero-extended values.
> The record cannot distinguish legacy signed metadata from unsigned
> metadata with the same bits.
>
> Unmatched values are printed as unsigned when kflag is clear. This
> includes BTF read back from kernels without enum64 support, where libbpf
> clears kflag before loading. The original signedness cannot be recovered
> from that flag.
>
> Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
> Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c | 42 +++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 13 deletions(-)
>

how old by now are those btf produces that do not emit kflag=3D1 for
signed enums? should we even care at this point or just assume that
kflag is set correctly?

> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index 3267163119dc..792e210cb503 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -148,37 +148,50 @@ static int btf_dumper_enum(const struct btf_dumper =
*d,
>                             const struct btf_type *t,
>                             const void *data)
>  {
> -       const struct btf_enum *enums =3D btf_enum(t);
> -       __s64 value;
> +       const struct btf_enum *enums =3D btf_enum(t), *match =3D NULL;
> +       bool is_signed =3D btf_kflag(t);
> +       __s64 value, legacy_value;
>         __u32 i;
>
>         switch (t->size) {
>         case 8:
> -               value =3D *(__s64 *)data;
> +               legacy_value =3D *(__s64 *)data;
> +               value =3D legacy_value;
>                 break;
>         case 4:
> -               value =3D *(__s32 *)data;
> +               legacy_value =3D *(__s32 *)data;
> +               value =3D is_signed ? legacy_value : *(__u32 *)data;
>                 break;
>         case 2:
> -               value =3D *(__s16 *)data;
> +               legacy_value =3D *(__s16 *)data;
> +               value =3D is_signed ? legacy_value : *(__u16 *)data;
>                 break;
>         case 1:
> -               value =3D *(__s8 *)data;
> +               legacy_value =3D *(__s8 *)data;
> +               value =3D is_signed ? legacy_value : *(__u8 *)data;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
> +       /* Prefer existing name matches, including signed enums without k=
flag. */
>         for (i =3D 0; i < btf_vlen(t); i++) {
> -               if (value =3D=3D enums[i].val) {
> -                       jsonw_string(d->jw,
> -                                    btf__name_by_offset(d->btf,
> -                                                        enums[i].name_of=
f));
> -                       return 0;
> +               if (legacy_value =3D=3D enums[i].val) {
> +                       match =3D &enums[i];
> +                       break;
>                 }
> +               if (!match && value =3D=3D btf_enum_value(t, &enums[i]))
> +                       match =3D &enums[i];
> +       }
> +       if (match) {
> +               jsonw_string(d->jw, btf__name_by_offset(d->btf, match->na=
me_off));
> +               return 0;
>         }
>
> -       jsonw_int(d->jw, value);
> +       if (is_signed)
> +               jsonw_int(d->jw, value);
> +       else
> +               jsonw_uint(d->jw, value);
>         return 0;
>  }
>
> @@ -204,7 +217,10 @@ static int btf_dumper_enum64(const struct btf_dumper=
 *d,
>                 }
>         }
>
> -       jsonw_int(d->jw, value);
> +       if (btf_kflag(t))
> +               jsonw_int(d->jw, value);
> +       else
> +               jsonw_uint(d->jw, value);
>         return 0;
>  }
>
> --
> 2.43.0
>
