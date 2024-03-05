Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75512C544
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676250; cv=none; b=gT1ctcqc+2DCd/IMxFde6dHtkBiZbsZG/EiN17kZOB3tBst/5hhYE9ZQ4BHaY3kJWLt+Q6DD770Bslzd5xFkm9Kr2muAw9FV1fDd7sAxt3CWAcdih/H148W/IxkdNrXHga0S4m7b5hT8UMskQ+dx5ZvHtPI6VvrKhIwYHFYvs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676250; c=relaxed/simple;
	bh=89jwn6PFp0PpI46/tGmHy6pQJp7cZUBiaZlhwizq2eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdpIWD/46hZmS+xGZ4e7kDbPaOoM0saRiKOKw7gyQ/XEuXumqRTuFkHoczgWDvQIxc/9mDUbzBsFrL2ZngutOINayRO3WKfbMeIH8R+L/jxtwkAA+ZTC1mmqTJKcRO/X0mYsPhZsENiCDJ9mXa03cgEcOVn+4wHBTn5M1RDayZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhPgtM84; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhPgtM84"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso4365439a12.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709676248; x=1710281048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4yalxVcAvaHX+nFj9FfXGmzR72yE+9/wbKhSszxdzo=;
        b=JhPgtM84q4aFbP1kdhW4aHFzuY3aNSfqOz0u/TRh1XgjeOKJRMPocD7kJL6pcprFr5
         in8b/KfwqXYVnTqF7uOq/iKCHEdOMdn0nwdjyLhzP7/VSuqLk6xp3cUBKS3CNvHaOuA3
         VUDUhISqCzFheZmG+5GYIjcxNx8IiUxwc7NxSMRvHsqMHY1okHUhngbhWNQ88In2grME
         k1c5OxNWDax9ysG1uoJM0ypDxb+CpJlX29E9fAjyzL4U9TKVOmI2E3xsqCXoV93S7ZVV
         mOXGRR9NKGBp9yR6M2NTMFn2tQiPMzELstiSwK2NFUi7BkLcmif9OBxgwSGHnuMcxM/p
         OeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676248; x=1710281048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4yalxVcAvaHX+nFj9FfXGmzR72yE+9/wbKhSszxdzo=;
        b=j3yp7dbchoCXUIZ5M4XA5iHGcQiEATlBzXJVK+ASepPbdsu2VjmqkPd3k/ej3l4vuK
         NsOPk/eFWPCVu5Wmoqkjgn+2v3SjF61l4pcCpp6qnsmeVNcDQX566m2JIIumMzfCqC1s
         ID6iXjjVbufu8N2ZvJ0qu7qdtuLxHHp8yE1eManeOeucCMzhQrk6OpR7L5/zKp2z9rU4
         eBp/flnJEF7FlgeglBvqttWdyO6QyXTmhnX+ol/uAsJ70n6xhvS1uXDKmSqMl1hvMZj4
         jZX1HkmK5UEptYIdMk67ggofzLmorwQ95hEfCREQ2klfzvyH89LKkQfNsAk6ipvWOQMB
         t94A==
X-Forwarded-Encrypted: i=1; AJvYcCWHPoEecS6SCPK6sChKOjl2hBy202oWFKtU63RbUeMaHVAu4U7jVam7/CJZ4paSsseG3XL8kOuX78WbeJtCLJG6PSIJ
X-Gm-Message-State: AOJu0YyvBfS9JRiXu9QM2C7vHLV5am3I19+FzNzvD47xCGXOZuJdewCD
	2IvqgRsRZJwHktWDbfDeLtHjngJfCZZRit03NJRapWVWJW8v+2rZ3YNDy0rGXFEp7EId6ck9+uV
	AxiihvnUx5FSn/XCG0ZfpBHYFzq8=
X-Google-Smtp-Source: AGHT+IHmxusDwKv+wDBebvW/8b9224FyWwpheI0pnJUxpCbWOYUDPkVo7tlJgP4GDzc4AZe/SKvzdE/ImY/eu2+q+eA=
X-Received: by 2002:a17:90a:4296:b0:299:5b95:cd7d with SMTP id
 p22-20020a17090a429600b002995b95cd7dmr9192116pjg.45.1709676248107; Tue, 05
 Mar 2024 14:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305064353.69734-1-laoar.shao@gmail.com>
In-Reply-To: <20240305064353.69734-1-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 14:03:55 -0800
Message-ID: <CAEf4BzZ93VRvb9Js8gMDaGOe_vZcFmQBChEd42S=9T0D++FBeA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
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
>  kernel/bpf/helpers.c | 117 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..a769561b65ae 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2545,6 +2545,120 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       u32 size =3D BITS_TO_BYTES(nr_bits);
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
> +       /* Optimization for u64/u32 mask */
> +       if (nr_bits <=3D 64) {
> +               err =3D bpf_probe_read_kernel_common(&kit->bits_copy, siz=
e, unsafe_ptr__ign);

it probably would be better to zero-initialize kit->bits_copy?

but also, please check that this works on big-endian right

> +               if (unlikely(err))
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
> +       bit =3D find_next_bit(bits, kit->nr_bits, kit->bit + 1);
> +       if (bit >=3D kit->nr_bits)

zero out nr_bits so subsequent next() calls keep returning NULL
(sticky iterator behavior)

> +               return NULL;
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
> @@ -2621,6 +2735,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
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
