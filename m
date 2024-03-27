Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB42014A60E
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561292; cv=none; b=hxkzKAjVQlLHLGKEkqEDTEjwV1XBB8kxE/eXLvAyp+y/vWzfVYV6SpCTD2S8QfXbHHcrSXhVZJSU3VWif+nJk1ekpNADudYdW54YxAuMe5Y4OHONvlLFFTgph7axckZvqisOE2j12huvi+NfBlRKl54LRnwpyysZtDuj47l25fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561292; c=relaxed/simple;
	bh=qJTuKc4B4MsCS4yWq0BCAXUr0/tEXPi0FP0s+JMptOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsLjUufs+N9eNS3WhD6DJkjK9+/3OZCAI7jf9LjIXwELVG2C5HgOEKymxtjVlhi0wZ+w8TmvRysbL0pPjTVOY8UaF/ECkFg0URLyxPi/9uWPsEzCnyUzHP69gPTjxeuJRNyM07LOLST26CtKCGCAdQXaP8LvWobPHv59ZwzaQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao0uIcUG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao0uIcUG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so121494b3a.3
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711561290; x=1712166090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ocQEUs0U7mHmXPzlmwcnlIGySIDPkHCsGD2+1Wix0=;
        b=ao0uIcUGGNT+EX38mbWZlrE8ouLXKtaQ2mziJGiHlCpjqUxYa3J8pDMCu3nzekXAWh
         1rjhZINYbKo6DohHkLd2VMyj2tH29wK4rfmzphaD3pGSjm8GQQqA0UFru442Vc4NTFMH
         Sm+80m5gvgL94oAyUZOyxVXOvVVzZFSjieAv/8UyzXiNzDKBoLjJ1Bzb6AKVg15sRhuS
         EdcWjbkbmwAhwGBhEmdS4Gn1Rj1V0zUH+ykorYvY4m7m+g6j4QFcKuJeVGoHZzQrTKXz
         +wcC1vjwmv7RovZIX6dvYNlGrknYJPF2u3pDMj9vcZExts3IP4Tjlm45x4dSMWyqnyxB
         RzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711561290; x=1712166090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56ocQEUs0U7mHmXPzlmwcnlIGySIDPkHCsGD2+1Wix0=;
        b=Dgu1MPr/eFLNkLZp0MgdEqhVqpR7locp9XDTJ9Og9LjEjjrUaEVhLixnvzukXoZJ4v
         BzEvoCcmd8qxdaOUVRq3G4eMFYsRfHXuFt83NI+gAUBcslJIDwTr9gShT5yJ7ddO8R+C
         TPeoEJF0+humlN0I76HYs1o4JGwn5RuqCgiV10zonKOm2AdKxnLm0w1/XaNV6vk8XQ6y
         F+FRGZpuOp7zguhyTF5nxMOSqvbqZ8PKMwxOw89iKH8o0tR5WI5HEYuCfXn3fpGdvOsm
         //aIwBahTd4l+93Yyh/hlfJwEAmce1CLW9oOO1sp/GWSqPuOIhNvoURzJLijFp0srks3
         +BOA==
X-Forwarded-Encrypted: i=1; AJvYcCXsRJ+nOEeGcLptgQBUTOmyGRBXuRpmyZRUAIhEWfSxsHiRoJkrTxjrC/PxyzA/0hLVoGAhiNu2IyCLMEOzm7bLt6+E
X-Gm-Message-State: AOJu0YxFqD+AoqOeSZ6/RK/PnfMoAIJ6HxucRh98as0wU8r3RFpXgz5Q
	257Bi56mLu2ANle7PNDhPyt/yD8Mq+8MRoKW87mPz4easwDzNloiNhIHKLV1HNFFY+D/7KqkypP
	/8tuhdLrXD/FQ0+WZ3k5k19AN7t0=
X-Google-Smtp-Source: AGHT+IFFRI5ZQJbA36S88GcNfx/D8U67RpmEWelSH/t/zzDWMQj3TPyLRdsKfGhtkfcsRNcwB3dzWIwU6K2l04jnmxs=
X-Received: by 2002:a05:6a00:2306:b0:6e6:46f2:d4c8 with SMTP id
 h6-20020a056a00230600b006e646f2d4c8mr461396pfh.23.1711561290062; Wed, 27 Mar
 2024 10:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327115848.84695-1-laoar.shao@gmail.com> <20240327115848.84695-2-laoar.shao@gmail.com>
In-Reply-To: <20240327115848.84695-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 10:41:17 -0700
Message-ID: <CAEf4BzajiMZQx+zn1AMMwQr1Fa3S7jxwCHZoH3ZSfUt6qzwD9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add three new kfuncs for the bits iterator:
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits that can be iterated
>   over is limited to (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
>
> The bits iterator facilitates the iteration of the bits of a memory area,
> such as cpumask. It can be used in any context and on any address.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/helpers.c | 120 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9234174ccb21..35bd8dd08fb8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2549,6 +2549,123 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>         WARN(1, "A call to BPF exception callback should never return\n")=
;
>  }
>
> +struct bpf_iter_bits {
> +       __u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_bits_kern {
> +       union {
> +               unsigned long *bits;
> +               unsigned long bits_copy;
> +       };
> +       u32 nr_bits;
> +       int bit;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_bits_new() - Initialize a new bits iterator for a given memo=
ry area
> + * @it: The new bpf_iter_bits to be created
> + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated o=
ver
> + * @nr_bits: The number of bits to be iterated over. Due to the limitati=
on of
> + * memalloc, it can't greater than (4096 * 8).
> + *
> + * This function initializes a new bpf_iter_bits structure for iterating=
 over
> + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits=
. It
> + * copy the data of the memory area to the newly created bpf_iter_bits @=
it for
> + * subsequent iteration operations.
> + *
> + * On success, 0 is returned. On failure, ERR is returned.
> + */
> +__bpf_kfunc int
> +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,=
 u32 nr_bits)
> +{
> +       u32 size =3D BITS_TO_LONGS(nr_bits) * sizeof(unsigned long);
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       int err;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(struct=
 bpf_iter_bits));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> +                    __alignof__(struct bpf_iter_bits));
> +
> +       if (!unsafe_ptr__ign || !nr_bits) {
> +               kit->bits =3D NULL;
> +               return -EINVAL;
> +       }
> +
> +       kit->nr_bits =3D 0;
> +       kit->bits_copy =3D 0;
> +       /* Optimization for u64/u32 mask */
> +       if (nr_bits <=3D 64) {
> +               err =3D bpf_probe_read_kernel_common(&kit->bits_copy, siz=
e, unsafe_ptr__ign);
> +               if (err)
> +                       return -EFAULT;
> +
> +               kit->nr_bits =3D nr_bits;
> +               kit->bit =3D -1;
> +               return 0;
> +       }
> +
> +       /* Fallback to memalloc */
> +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> +       if (!kit->bits)
> +               return -ENOMEM;
> +
> +       err =3D bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr_=
_ign);
> +       if (err) {
> +               bpf_mem_free(&bpf_global_ma, kit->bits);
> +               return err;
> +       }
> +
> +       kit->nr_bits =3D nr_bits;
> +       kit->bit =3D -1;
> +       return 0;
> +}
> +
> +/**
> + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> + * @it: The bpf_iter_bits to be checked
> + *
> + * This function returns a pointer to a number representing the value of=
 the
> + * next bit in the bits.
> + *
> + * If there are no further bit available, it returns NULL.
> + */
> +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       u32 nr_bits =3D kit->nr_bits;
> +       const unsigned long *bits;
> +       int bit;
> +
> +       if (nr_bits =3D=3D 0)
> +               return NULL;
> +
> +       bits =3D nr_bits <=3D 64 ? &kit->bits_copy : kit->bits;
> +       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> +       if (bit >=3D nr_bits) {
> +               kit->nr_bits =3D 0;
> +               return NULL;
> +       }
> +
> +       kit->bit =3D bit;
> +       return &kit->bit;
> +}
> +
> +/**
> + * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
> + * @it: The bpf_iter_bits to be destroyed
> + *
> + * Destroy the resource associated with the bpf_iter_bits.
> + */
> +__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +
> +       if (kit->nr_bits <=3D 64)
> +               return;
> +       bpf_mem_free(&bpf_global_ma, kit->bits);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -2625,6 +2742,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.39.1
>
