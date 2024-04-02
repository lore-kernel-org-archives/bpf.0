Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F114B067
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074870; cv=none; b=GJpS9jIYnOVf8aHQ4yC9rsNPBDUrHHUoDfcxQwiHvnwCZ/ObJsMqK1q+6PG27Eq8Bymhax5qmlKfGpvcTsjiHazOVazIWoZ/p0rRMKC+3uYMNq2YlvcpSMYOCEFFgeppXgWd1DrWz5jQHHomV5Zud96v+gPHjcRSBHRV3Esi1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074870; c=relaxed/simple;
	bh=Y95pK9qV2JSDh77hAOAlOkdnVVI/lagnzLTk0HYaizU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+0uRZUs9j/w4qw/vDG+b1nmiKMSP+m/Z00RBlmdlcKI1EbnFNgtI/zgMXUHHqFA4bR7+7I58EcmGfbzJz3Qgqvods1VdA1BbIujkRRneOcXSPmwuYGCYnnwNxaf9q+CBk9hJM7Dq9TappcjW9YHB83Ky56VXsEqqRk8NTRsgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUmAhYlC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUmAhYlC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2178b2cf2so40569165ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712074867; x=1712679667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrttjpGz76BDobKB6hjf1vzJAZvGOgYvZFmsD1wSPyo=;
        b=VUmAhYlCG/DxH19cNTtTD3a7AK6sN93xYp8BAiEQFTzEFl6gYqccTL8tifnAKvKFfg
         M+87BPfL0Fn8AkLXD4ENOPfmfIltSZS7oy76UYxVH5iTi84VnbPLVEqvgeWt1lcG5KYt
         PcJAp+oKi+YUDUJuWFt5QA1PnEFg5nVS0fxK75jmVcSw1+uj4YfIyTOednc+FUcxACNs
         Xv+644VNMDNvOH6k9d7qz71UJENGFtzF9CVUhBr3+cFwvizJiSGBnHZdOdarCu4it45z
         P1SFmJBXyrAWWaRly6VkN60DFdj9m7wSd599UfxA+jGpQf1InpvhedXgNhDx9IE86GWH
         4XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074867; x=1712679667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrttjpGz76BDobKB6hjf1vzJAZvGOgYvZFmsD1wSPyo=;
        b=hADsY2ZrDN2SmH1P5iXGYBOtS8gFTInsba1NP6lStdb/W8koQIWEbHl0+PDWQsSrVq
         cwkZg7fZ58qq1Q4XnR4y4ZnTOCOUmM4PLmbqEYSg4vPg/qrmWawKeiyzY+fh6+d0du/t
         W7CtdwZpt7psGPSIwXujNhTKoR6tyeOEq+Mk1QHRYJzQw1nV9aey+/xWzJHrm6hT0mFd
         6vH174NFzGkyDzWT3Mmz2zfdopoVoP38LhPGh+2eUFemqSAtIKppEoYZ3w3/FhKyeCAV
         0ThaqjL62y38VlyqcOMJ2t9EBc9M1m6To6l/Bzg2fmU5mVNxoIXz3A2s7ZR5Woh/AKez
         vsog==
X-Forwarded-Encrypted: i=1; AJvYcCWwNi+DtK8pLzF5cFIksXidaCI9+20oqATrzfdSazdRx2doh40DOugmdAa1h7jKjTNBWPnQMOQlqEQT5i3sVXoMVTph
X-Gm-Message-State: AOJu0YwR4BGHd9/2tIXxiRWepW74ztqWrfcLqpiPk2NvEXPU0AGuLPOD
	fy9VZsf8W9dEdedUu+yxYYKjVfQk8TZBKGGbwQvijwUaN214dJEKMKBS2F2udt1IBfhdQzIM/gh
	Oyd+UnLK0hcoj1r8k7MO01SHNnFI=
X-Google-Smtp-Source: AGHT+IGCkiNGa5xOZcaclkqXVXZAILtlugff68toB/aGwwekf5cR+7rUXS+bwPrUZvuuQJhBEkS7+clhBDCttDUM4Pk=
X-Received: by 2002:a17:902:da84:b0:1e2:26de:c5b6 with SMTP id
 j4-20020a170902da8400b001e226dec5b6mr15824253plx.54.1712074867561; Tue, 02
 Apr 2024 09:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <20240402021307.1012571-4-andrii@kernel.org>
 <660b9156d5c3f_1af77208ec@john.notmuch>
In-Reply-To: <660b9156d5c3f_1af77208ec@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 09:20:55 -0700
Message-ID: <CAEf4BzYG-7L5NBKEZtOq6Ba8hxuoxcGYrXK0DhT0ia+2QZMnng@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: inline bpf_map_lookup_elem() for
 PERCPU_ARRAY maps
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:02=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > Using new per-CPU BPF instruction implement inlining for per-CPU ARRAY
> > map lookup helper, if BPF JIT support is present.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/arraymap.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 13358675ff2e..8c1e6d7654bb 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -246,6 +246,38 @@ static void *percpu_array_map_lookup_elem(struct b=
pf_map *map, void *key)
> >       return this_cpu_ptr(array->pptrs[index & array->index_mask]);
> >  }
> >
> > +/* emit BPF instructions equivalent to C code of percpu_array_map_look=
up_elem() */
> > +static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf=
_insn *insn_buf)
> > +{
> > +     struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> > +     struct bpf_insn *insn =3D insn_buf;
>
> Nit, If you wanted to be consistent with array_*_map_gen_lookup,
>

I didn't in this case, I found these "aliases" more confusing than helpful.

>         const int ret =3D BPF_REG_0;
>         const int map_ptr =3D BPF_REG_1;
>         const int index =3D BPF_REG_2;
>
> But, I think its easier to read as is.
>

Yep, that's what I thought as well.


> > +
> > +     if (!bpf_jit_supports_percpu_insn())
> > +             return -EOPNOTSUPP;
> > +
> > +     if (map->map_flags & BPF_F_INNER_MAP)
> > +             return -EOPNOTSUPP;
> > +
> > +     BUILD_BUG_ON(offsetof(struct bpf_array, map) !=3D 0);
> > +     *insn++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct bpf=
_array, pptrs));
> > +
> > +     *insn++ =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0);
> > +     if (!map->bypass_spec_v1) {
> > +             *insn++ =3D BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entr=
ies, 6);
> > +             *insn++ =3D BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->inde=
x_mask);
> > +     } else {
> > +             *insn++ =3D BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entr=
ies, 5);
> > +     }
> > +
> > +     *insn++ =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > +     *insn++ =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
> > +     *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> > +     *insn++ =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> > +     *insn++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> > +     *insn++ =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> > +     return insn - insn_buf;
> > +}
> > +
> >  static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, =
void *key, u32 cpu)
> >  {
> >       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> > @@ -776,6 +808,7 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
> >       .map_free =3D array_map_free,
> >       .map_get_next_key =3D array_map_get_next_key,
> >       .map_lookup_elem =3D percpu_array_map_lookup_elem,
> > +     .map_gen_lookup =3D percpu_array_map_gen_lookup,
> >       .map_update_elem =3D array_map_update_elem,
> >       .map_delete_elem =3D array_map_delete_elem,
> >       .map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
