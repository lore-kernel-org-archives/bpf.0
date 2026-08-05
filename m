Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F613A8737
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955581; cv=pass; b=Tei7RvfY1un2IATkz4/Ls2FdHBAhTuiXlfTQjc5eHZ4WWK1oy8MlSxqc02eKA2KBbGDMeS+/+E0F1ilANILHwJYCtrcqlvnGXb8cLn5x/GEW96ux/i6SRhO+lku79rgS4wArGxfsEULTk56O3GSVYvPVJFLaqzySFZifFn4Tn9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955581; c=relaxed/simple;
	bh=VHC/9TwijeBDOOisSoYmB168anR09Wauva2iRFh5CKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwQjx5HOuSFiq+gz35Jxuk9lF+8PFr32s4RNPCuhc2S/mHZfGDXs5GwQjd8234ZDrrRj68dYYV3Hu1ktJ39K2BE1/+2OfEYrr6LEx+tU76Mb2JZ4JQ7PhytO4TPKWV7QCq9OfzKxKDK2n9mCMVuYu8FyiYJbNInOlc42Kq6mXgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhMnK9JM; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhMnK9JM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso907960a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 11:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785955579; cv=none;
        d=google.com; s=arc-20260327;
        b=h924GMdM0oVkOENuQYJNuM9mPVRE1t7t5qigWrI9+9A2I9QVF4vKEJO0xYr7SAc/8x
         85sMPyUWx+fcIUGXyHlCdVrdFWyLlkMbQkb48Ax/WnXpmGbbzcbe7wozqtOuvTeTl59G
         gcb9a8AA+aeNa4ImhdAPKG3TqPQDgSpxTeXIo1GqUEjk4l8WAzfTDzraKTEaDAsF4XPt
         yTgtGvjEn74wF+E9DtyXJ4OZN5+eFQV9VCtZEh4RA81y3ypYDHr1jqXDwL3GqrqQ5rcI
         vlI2i4VCXLwGe2TtjMKPo1U3vcR2H1bdmFc6FngTzUU5aB0wYouWkRFmWRVaRY4L631k
         p7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        fh=We1BCyllFeLBuWIii9hq3iV8CktxjbXeV8bBVyjbOi0=;
        b=YaMMy7bL9cytyt3Pb0H/X9lUgtGgNOKa6hDwEKzltmEMNZk9knCKYViBRvtZwE0CvX
         7du5CVWOAScaecPYMdZo4oeL/Cje5GmfWBBXeDGDEMQT+9AI6yiMZhL/X0ITncOZeCin
         XJQBDBu53QHfx8Ln1Oz7O0pkJOffIum3cTwtHMXfbhpngTfe6yJNHG3jJhC0cExP9d0k
         AcRrPamULqb/jMQjVYBqrjmlmSvDKMi97kky329K4pLVceLTY2c3ALm/qw7hiihI5dKq
         2IING+JMpwJQ9a9A8mOJPEE44PIMM1bQkmVO8DMRJWT5RN+8/NYye/O702/0ajWSgn8i
         400w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955579; x=1786560379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        b=QhMnK9JMBm1Rj7sLNd56LORdJFkHPuNOeST/AnwwQpvMNaA7SUKENrd7kJ3AGscUSg
         To16P3g6vZoWXkPyhtMdyrTDsc3E/85AVOhrStiaLL0QkJxQWi1s42ZFV7E0B/dGR4F0
         02QUgqCUDxuMVqFUmcP6KCkycGp6GZWLZ330zDoB4KTNrSgd7e6tXHMIkgEjZzFGif3a
         9P/uJxndsj2D+2Aa+3sngV7kJ9XgKZs8FoOOZDtqlDB1U+AdecRmLDzWpvuBFXe+ZhWM
         2zu5Ny4ZaZwbSUelpARiQ6QGsWeBfQxB2khjm7WdYsakuEQrpHFNhsMbciuWnqpNDdyI
         DDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955579; x=1786560379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        b=EPeE91Bz7YEFetgjkEtEJ/HIKyQn+8E1Ctah6bTqaXht22YQrHl5ow+YsuLxMj+79s
         cys06SdcCtXerIyzHTFCx4maHQ4GV++rkqvUrOZqlCkYFLd33hC9XgthYGMqK8zbjBoA
         BwpSSFAi2tc7UNruFxD9Jdz5J3xMS5cloyGWRXtyme1OBW9ndcJtbHnsntr/tEf06Hil
         Ivlwnn7lozCy0XCbsW7fs1ZeursQ93VVyfd8EOCQZr3QtMfAdl9hY70qQI/j4cri+pH1
         6AWiLUiwYEZeC5SjGPthMC9qcZIrbqDMfgkoQ5I3r7zgNa7eG6mxD3MJ2IcvFdS1OXQ5
         sm7Q==
X-Gm-Message-State: AOJu0YycSbVQwfBhzMzJZX596T52pUcGScpQBF9et4YmVvYZ5s3KLWwP
	1wLuhHbTmvXpGk+PszeU47RtQTIoi8uXMeq7tbzJOjewPBnibaskaHrJ+H9yAZIlsD+QweJk/lX
	ZRWztjl//3NV7UXab4MA77a12Kv5uKII=
X-Gm-Gg: AR+sD10sx/eoiUBjsx57NcNsB6njx3m6p+WpcOIIl6aMGJKz//UPnGxlMvG0TzHQGe6
	Rx6GjUVtsqmMJfyKS64cnHDix1hIf7v8A63LByzVb1JFFujJ+WyVvBDh3tskINJlddcc2hqy6wv
	8rY6NFNqB7tnsQKA7xpapQXYjYd1cFsk/tzFKj2PMsIG/mTqYNRWhjBzVLbSvQ7tiSU4pKre7TQ
	uG0XHlIyLiWIwFmj8fbc/SPbWUVX6ZU+XH5zV96rg6Oc2c5bC1YutGVCbpOJUfNjfr0ZW7Cqx6u
	qNJI1kU4FgD1FI8+f2Xml8P7In8BI0/xPP524rzbnyIntH3raECRFgyECgOep7EO/zR6N6cHSck
	BR5HqSXprnWvLLV5WhhhiKnQwkg==
X-Received: by 2002:a05:6a00:9517:b0:84e:e809:dd49 with SMTP id
 d2e1a72fcca58-84f2e12d02bmr9403279b3a.36.1785955579296; Wed, 05 Aug 2026
 11:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805060228.2703051-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260805060228.2703051-1-Jeremy.Jean@oss.cyber.gouv.fr>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:46:06 -0700
X-Gm-Features: AUfX_mz14l4BoLCHjdW3KnF8TblLUAl2yEU1dQ_INvK4a0wgPeZvuMP7ST-djpU
Message-ID: <CAEf4BzbQ3qURHOpFL4feXqOpggJJupp7NzPMU1jeH_p4CuvLWg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf] bpf: harden bloom filter sizing and indexing on
 32-bit kernels
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:03=E2=80=AFPM J=C3=A9r=C3=A9my Jean
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
> Assisted-by: Codex:gpt-5
> ---
> v1: https://lore.kernel.org/bpf/20260731204917.3845309-1-Jeremy.Jean@oss.=
cyber.gouv.fr/
> v2: https://lore.kernel.org/bpf/20260801083436.4014218-1-Jeremy.Jean@oss.=
cyber.gouv.fr/
>
> Changes in v3:
> - Address change request simplification from Andrii
>
> Changes in v2:
> - Address AI reviews.
> - Split full-width hashes into a word pointer and an in-word bit number
>   before calling bitops, so upper-half u32 hashes cannot become negative
>   offsets on 32-bit kernels.
> - Drop the redundant final u64 add-overflow check; bitset_bytes is bounde=
d
>   at 512 MiB once it is computed from bitset_mask.
>
>  kernel/bpf/bloom_filter.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index b73336c..b63839d 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -41,7 +41,8 @@ static long bloom_map_peek_elem(struct bpf_map *map, vo=
id *value)
>
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               if (!test_bit(h, bloom->bitset))
> +               if (!test_bit(h % BITS_PER_LONG,
> +                             bloom->bitset + BIT_WORD(h)))

this fits on single line, fixed while applying, pushed to bpf-next, thanks

>                         return -ENOENT;
>         }
>
> @@ -57,9 +58,13 @@ static long bloom_map_push_elem(struct bpf_map *map, v=
oid *value, u64 flags)
>         if (flags !=3D BPF_ANY)
>                 return -EINVAL;
>
> +       /*
> +        * On 32-bit architectures, hashes larger than INT_MAX would be
> +        * treated as negative by set_bit().
> +        */
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               set_bit(h, bloom->bitset);
> +               set_bit(h % BITS_PER_LONG, bloom->bitset + BIT_WORD(h));
>         }
>
>         return 0;
> @@ -94,9 +99,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
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
> @@ -127,22 +133,16 @@ static struct bpf_map *bloom_map_alloc(union bpf_at=
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
> -       bitset_bytes =3D roundup(bitset_bytes, sizeof(unsigned long));
> +       bitset_bytes =3D BITS_TO_LONGS((u64)bitset_mask + 1) * sizeof(uns=
igned long);
>         bloom =3D bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_=
node);
>
>         if (!bloom)
> --
> 2.47.3
>
