Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356F23BD05
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885134; cv=pass; b=SaAU5ZeXnL3Q0ROC6QevqJW7tSKVMqIvpm1mc/Q3Gb01vOpC6j8NP9v5SCHFPLnMhBZNDy0qzBdXC4fEwVFx1bHjsHoJqXGdG9bZcRX1n5NkcIhdD6+ENidDePj2tl7yR2FoUpKQ3eg70LlEjNrspH8zP5n+EM0kIG1FajErSPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885134; c=relaxed/simple;
	bh=hoRpF63IH51+VusGsd36WYxTW6PRkEAxAWYYcUYHL3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7AIL2fp/scyAFRN6Q5V6cYirFxMuBh2Iwg+ZsZ+CBTbCfvvNQ5MZ0wUnfkKifUBkD/eGu7ilKa7OyTev6B62ApYPaqhfGPMY4P1lU9unG8TaGbm6f2mzcs31Q13Ni6TYGR8wHmx+fQV9fa7yTjSVZ1JK/YPnXgUEJuxVbFsl5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOBVZcwj; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOBVZcwj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e507b079dso260749b3a.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 16:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785885132; cv=none;
        d=google.com; s=arc-20260327;
        b=HWyVFDB3AZUV2fadAoj+AvcmQ63Mkc/fFDO9ScjpqGlbNq46g1f3FvGXrKlnHZL2Co
         kf6NmRvnxFb5eRuW4Ym0dnceHtS5ydxcamJ+vp6PQevyDcxjISH3+9cyVRSjoKWCVbIz
         YHWd1VcmT1lN3zOIIbZy8FoqeJ2m/iNKktCPyOs8By44DJkTk7rWEc74HQ4KcEqEHGQP
         jK+fE0HhYG+YddhDfYnNep80ZEt1EaXUkeDjg+m2a+4b/XFGlWJaR6JtrWTsxg9sKmD/
         bDacgaEtNM/0j9zrWYAGLz3mEXid4GqX3DdgQFKEgJe59b/mvCS0BY/TbI25Mcht58FA
         46hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vdOjdf42mPSEdmWX1kA9Hk+o+EHrfcC0G5lGeWQMqUM=;
        fh=We1BCyllFeLBuWIii9hq3iV8CktxjbXeV8bBVyjbOi0=;
        b=N9T0Wgd12kt59I3ib93xDfczenjgLXcxqExcpxHRSQlN700DYymkDOfuSiMtbrhdSI
         9B3KKPyzO2XMGZlio+hrNZUaW4XklqBCDdhyJYWkT/2CQCy6avefcS2Pd+8atZ5uVk/1
         oDBpHoYiilJ6m+96ANpdDAczH2cXa9ER0eVN9239BwWzJW0RfQtUVIEhq2L4tN8yQook
         uEubS7HvAwUa0GgQtRgxdSKhfATQwXnjjmIGzsWT3y46UKyzuDKe44CYWjY9Ma74WlDP
         LH7zkJxyRpUC+HeAWnPyK/UM3FbQ9Fdzgl+Lkz8VZ5i9NcKZDuoxWlGD8wLFihZIGgwB
         XkOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785885132; x=1786489932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdOjdf42mPSEdmWX1kA9Hk+o+EHrfcC0G5lGeWQMqUM=;
        b=UOBVZcwjJnHqstJUAbK8ifEexx8ORymAwTPVzP9o7rpny1L6IiKwQQ9BbDK1pbcRkO
         xlN6HgmLJBz28TdB2DDETcToldZkhHwi1iheTrFZb231SP9rv1mhUdjj1FQaMdCwZFjo
         hrxY+EvRx5+NPs36/nEep+nB1iUhdEh9VShWetA13GgSYfCAZnHLnvVLK+lbuAoInlWt
         qBgP7qp+t9Lg3YhWYPivmIAOfHcZl9aG3qEu9ATzFcS9tDxD+QnTZEOPTlw5HKGprVG5
         f/Bg69bIheUUyt271IzvdVLO2gt9hfv6PwZYaiz7O7+ecB9vgQm8HQH3h3z4IJzirXjq
         YVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785885132; x=1786489932;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdOjdf42mPSEdmWX1kA9Hk+o+EHrfcC0G5lGeWQMqUM=;
        b=pNPwz/fG/RpKFgX5/qkDVlVVnE+OprL8Hs7teRxj2MQlk41cbfY9ZhLRk4iStRetbT
         gsE0DoZowmJRRhsBNmKx+I048hTlnpL5bwVvgJ4vhyVaA1TrAXTpZTq3ob8/sXsU5bMM
         DQoaWQADJhp8lMTc+irELyG2V+9zJxW8Yq3t2G/nX6M/mnp4eVhPH7JTI+/zgjHvXaaz
         F7PTck8KJNqT04/Uf9pzUvkqhm85gFjyYV1laYuJM6nxB6QFmSciRLci+UkzCiiLkpHT
         +PmSDH9CTQqnCQAd3KRYoWnBHIxixsQeyC/2MUgYnXyP+dwkAEBKA8q+QCrS9AYEcBr8
         vsnA==
X-Gm-Message-State: AOJu0YxQ88H9gvtVzQXamlPyyZNQudvCwHm1v8elWdV9WQXG3tFXrxGi
	aO+mzf3yJQt8XgmXDMiPmIMP4Y/t9+rw+IHCSR3QLOfhkACMZxlXUqjjd97sVPlEbv5A4qb3XLF
	TUMgkWbmSxu/PlSVkjGTUUDOhJpFN1Rc=
X-Gm-Gg: AR+sD12vixxNQISAM1pj9gOFnINBa/DfhdidE9zBxNAYLNsDYUZ6uf9kURcP0tPFd1+
	dakuhPMSR+IKpiw191mJ6Zuxk9o9hj7m6o8GZ6l/acbQcJarAqU/HJZOrLtQUz5c+QM+1MQ66A2
	ASAgPWiWsy1ubmdi+lpG4Bq53EuBXXc6xuxAXFQ4BHxL3wN44Zh1nwIgTh5msY84XW27YGb+RY+
	W5VbGaurOeFcN18qCeWkHRyM446tntOuTxaA1ARVXXotrDIz/endTn1lg845VBNmWJNQAk3b8J4
	RK+FD3ttV8nwYsv74i6MeGN4B1DqySAQ29qFkaWIfza0PM8/TvlZkG/ydVvqi+GEn6HuveUKlyV
	ApWjzOrASve0A955UagQB/qZzQaW+ZhFp1kBO/EI1A5rSHAHvTG4RsQ==
X-Received: by 2002:a05:6a00:4392:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-84f2e03173cmr2378156b3a.10.1785885132319; Tue, 04 Aug 2026
 16:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801083436.4014218-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260801083436.4014218-1-Jeremy.Jean@oss.cyber.gouv.fr>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 16:11:58 -0700
X-Gm-Features: AUfX_mxrOdNnG-Z15xiI4yYForjjn1meTs2Va9aw_71VCAZlUvSdDViS8I507I4
Message-ID: <CAEf4BzaVHh4NOYdA2NHAwZt=SCHGZgz6MCdEctYKi3JaRDB_Ug@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: harden bloom filter sizing and indexing on
 32-bit kernels
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 1:35=E2=80=AFAM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> bloom_map_alloc() has two 32-bit-specific problems when the computed
> bitmap reaches the U32_MAX fallback case.
>
> First, BITS_TO_BYTES(U32_MAX) is evaluated with 32-bit arithmetic. The
> addition performed by DIV_ROUND_UP wraps, so the map allocates only the
> fixed-size bloom filter object while keeping bitset_mask =3D=3D U32_MAX.
> Subsequent updates can then write past the allocated object.
>
> Second, fixing only the allocation size is not sufficient. The bloom hash
> is a u32, but set_bit() takes a signed long bit number and x86 test_bit()
> eventually feeds the index to variable_test_bit(long, ...). On 32-bit
> kernels, hashes in [0x80000000, U32_MAX] therefore become negative bit
> offsets. x86 bt/bts with a memory operand interpret those offsets relativ=
e
> to the supplied base, so a map with bitset_mask =3D=3D U32_MAX can read o=
r
> write before bloom->bitset even after allocating the full 512 MiB bitmap.
>
> Keep the U32_MAX fallback, but split each hash into a word pointer and an
> in-word bit number before calling test_bit() or set_bit(). The bitops
> argument is then always in [0, BITS_PER_LONG - 1], while BIT_WORD(h) stil=
l
> selects the intended word in the full bitmap.
>
> Compute the bitset size from (u64)bitset_mask + 1 before passing the fina=
l
> size to bpf_map_area_alloc(). This fixes the original under-allocation an=
d
> keeps the allocated storage consistent with the addressable bitset.
>
> Exploitation note: local privilege escalation is possible on a 32-bit x86
> kernel using the under-allocation bug from a binary with CAP_BPF.
>
> Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> Changes in v2:
> - Address AI reviews.
> - Split full-width hashes into a word pointer and an in-word bit number
>   before calling bitops, so upper-half u32 hashes cannot become negative
>   offsets on 32-bit kernels.
> - Drop the redundant final u64 add-overflow check; bitset_bytes is bounde=
d
>   at 512 MiB once it is computed from bitset_mask.
>
>  kernel/bpf/bloom_filter.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index b73336c..f111d26 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -33,6 +33,22 @@ static u32 hash(struct bpf_bloom_filter *bloom, void *=
value,
>         return h & bloom->bitset_mask;
>  }
>
> +/*
> + * Some 32-bit architectures take a signed long bit number in bitops. Sp=
lit
> + * the full u32 hash into a word pointer and an in-word bit number so up=
per
> + * half hashes cannot become negative offsets.
> + */
> +static bool bloom_test_bit(struct bpf_bloom_filter *bloom, u32 bit)
> +{
> +       return test_bit(bit % BITS_PER_LONG,
> +                       bloom->bitset + BIT_WORD(bit));
> +}
> +
> +static void bloom_set_bit(struct bpf_bloom_filter *bloom, u32 bit)
> +{
> +       set_bit(bit % BITS_PER_LONG, bloom->bitset + BIT_WORD(bit));
> +}
> +

these helper functions are used in exactly one place each, just inline
the right there in peek/push elem, leaving brief note that hashes
larger than INT_MAX would be treated as negative by set_bit()

pw-bot: cr


>  static long bloom_map_peek_elem(struct bpf_map *map, void *value)
>  {
>         struct bpf_bloom_filter *bloom =3D
> @@ -41,7 +57,7 @@ static long bloom_map_peek_elem(struct bpf_map *map, vo=
id *value)
>
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               if (!test_bit(h, bloom->bitset))
> +               if (!bloom_test_bit(bloom, h))
>                         return -ENOENT;
>         }
>
> @@ -59,7 +75,7 @@ static long bloom_map_push_elem(struct bpf_map *map, vo=
id *value, u64 flags)
>
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               set_bit(h, bloom->bitset);
> +               bloom_set_bit(bloom, h);
>         }
>
>         return 0;
> @@ -94,9 +110,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr=
)
>
>  static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>  {
> -       u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> +       u32 bitset_mask, nr_hash_funcs, nr_bits;
>         int numa_node =3D bpf_map_attr_numa_node(attr);
>         struct bpf_bloom_filter *bloom;
> +       u64 bitset_bytes;
>
>         if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 ||
>             attr->max_entries =3D=3D 0 ||
> @@ -127,21 +144,16 @@ static struct bpf_map *bloom_map_alloc(union bpf_at=
tr *attr)
>         if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits=
) ||
>             check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
>             nr_bits > (1UL << 31)) {
> -               /* The bit array size is 2^32 bits but to avoid overflowi=
ng the
> -                * u32, we use U32_MAX, which will round up to the equiva=
lent
> -                * number of bytes
> -                */
> -               bitset_bytes =3D BITS_TO_BYTES(U32_MAX);
>                 bitset_mask =3D U32_MAX;
>         } else {
>                 if (nr_bits <=3D BITS_PER_LONG)
>                         nr_bits =3D BITS_PER_LONG;
>                 else
>                         nr_bits =3D roundup_pow_of_two(nr_bits);
> -               bitset_bytes =3D BITS_TO_BYTES(nr_bits);
>                 bitset_mask =3D nr_bits - 1;
>         }
>
> +       bitset_bytes =3D BITS_TO_BYTES((u64)bitset_mask + 1);
>         bitset_bytes =3D roundup(bitset_bytes, sizeof(unsigned long));

should we do just

bitset_bytes =3D BITS_TO_LONGS((u64)bitset_mask + 1) * sizeof(unsigned long=
);



>         bloom =3D bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_=
node);
>
> --
> 2.47.3
>
