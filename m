Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1912F583
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558129; cv=none; b=LPI+WgOebmQpCfAvHi2s8QCfhKtw3bAOrJQSTcQ1TausnfrEmj9PBttEqL2RcwxN+fojsSagXI5SKbgXucMobG+kIsReFPXiToXxC7iGWrOkhYaxSLgrk8T5EMGLIPhYZIaxPFAqSNrijwflCGucd0Crh+eXs70gpPfu5zM+Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558129; c=relaxed/simple;
	bh=V/zLWfvI4P1mx8m/9QBcHK4yQiJNznAew6zB4pr1ahU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4f3cfKCLelc37IneqxzbXiIQ9bQfw+f06p5n8nWVv+0uf6yKpBM9ZEP/QGhusK/qov85lwe2K/CIZK40HUA/ZivxDeCM1mOzrquL/dfF+/uhx94B865ohY8RY+x6ENIMZAt7k1+uP90lkVB+7IKvzKEZUnOmlWzutH6JgEIRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gah7sPUO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gah7sPUO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a0292c4df5so69696a91.0
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558128; x=1712162928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6/Wxq8dHUkPfBGU4xb9AgYp+4TZDW5Et/kuCc1ZMS0=;
        b=gah7sPUOf5v8zxrOQr/W0wTchoQVWk/0zb2tl3EEjP7b3j7+eqMUQdJPgzgQxl+W8C
         ybAw2KyVzFPZf3hcxBbGNNI2ey7/UlsDygAHAdlzUeBs+UDkohEEflHCUiuQd1uYPmlF
         O8F4fPZvq3tuXLVQAW13fuCFZ8zB2lPC2UOInXgQeLzEVtf5oAUCwCZj71J9QktuaArv
         VbxBuZwC+vxSVGwrtR2wbb1gUFPCPrx/P2OBK4vndvh0MIk+iGflZMlnHWlisyvDGNR1
         Ga6uZLi2jDW9n8Hd46AKFoTsr+i3xnxxSBdvfhpI32D+3XJRJTLcpZiZTL5Fzd4RW5ns
         YM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558128; x=1712162928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6/Wxq8dHUkPfBGU4xb9AgYp+4TZDW5Et/kuCc1ZMS0=;
        b=f801jMbU1qkyLYpNtowT5q2/iC5f0VEVPsw7h9DknxZMakwXJhfowJJEyd/UjuSfYt
         yFWHV1ZlSaH8sAyBEEC8U56qY7iZu8MXT6ODz33UKHqj5obEbPNStZNwYki6iBMV/gCK
         Y9+tzotvhLHOzasHIpv/hupvU1GCGbRQ0jZ9mCFAoDovfnL5Jxp4bFQ5Fn5EMKXPPgQ7
         AeE47r+enhpreSdMFbzqy9BCuvPe5RfUU16vG762ksugNZjdfeiUyrHahtfW6S8vu5oX
         X+X2WyjQPyQL/oZDygoDLbjV9kxu5VIJwa/KpXBCCliweiqcnfVfJtY9LFuBgq6YjtwY
         bqsQ==
X-Gm-Message-State: AOJu0YyO7Kaa5u8PRdHMwMI4UCRe1cs350FIRcMB6cuzVa1YSWXKO/1u
	XuwwNrn+3UV6GGxsos4+UW6ZBMT9w1/OdSWb6hAaZAblGnhZlv5Xkyed72yU1jNXnUs5tDxfg3A
	rJIZ9gK774knLdxOndjzC0fb2LbIigBxlRwE=
X-Google-Smtp-Source: AGHT+IGVlc/P293x1X9Uh0Kv7Sz2pXY0jOHVylTpvbp+KOPO3hy42FQ69riblAW+h1IHLzSEAxIQWoDweSHIRgZdoK4=
X-Received: by 2002:a17:90b:3586:b0:29d:f086:9e44 with SMTP id
 mm6-20020a17090b358600b0029df0869e44mr173339pjb.46.1711558127712; Wed, 27 Mar
 2024 09:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327024245.318299-1-andreimatei1@gmail.com> <20240327024245.318299-2-andreimatei1@gmail.com>
In-Reply-To: <20240327024245.318299-2-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 09:48:35 -0700
Message-ID: <CAEf4BzZTWX6Xo6yq=9nzCv4evbPcoOr95+5PMmcskTsaB6rxSg@mail.gmail.com>
Subject: Re: [PATCH V2 bpf 1/2] bpf: Check bloom filter map value size
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:43=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> This patch adds a missing check to bloom filter creating, rejecting
> values above KMALLOC_MAX_SIZE. This brings the bloom map in line with
> many other map types.
>
> The lack of this protection can cause kernel crashes for value sizes
> that overflow int's. Such a crash was caught by syzkaller. The next
> patch adds more guard-rails at a lower level.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/bloom_filter.c                           | 13 +++++++++++++
>  .../selftests/bpf/prog_tests/bloom_filter_map.c     |  6 ++++++
>  2 files changed, 19 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index addf3dd57b59..35e1ddca74d2 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -80,6 +80,18 @@ static int bloom_map_get_next_key(struct bpf_map *map,=
 void *key, void *next_key
>         return -EOPNOTSUPP;
>  }
>
> +/* Called from syscall */
> +static int bloom_map_alloc_check(union bpf_attr *attr)
> +{
> +       if (attr->value_size > KMALLOC_MAX_SIZE)
> +               /* if value_size is bigger, the user space won't be able =
to
> +                * access the elements.
> +                */
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +
>  static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>  {
>         u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> @@ -191,6 +203,7 @@ static u64 bloom_map_mem_usage(const struct bpf_map *=
map)
>  BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
>  const struct bpf_map_ops bloom_filter_map_ops =3D {
>         .map_meta_equal =3D bpf_map_meta_equal,
> +       .map_alloc_check =3D bloom_map_alloc_check,
>         .map_alloc =3D bloom_map_alloc,
>         .map_free =3D bloom_map_free,
>         .map_get_next_key =3D bloom_map_get_next_key,
> diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/=
tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> index 053f4d6da77a..cc184e4420f6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2021 Facebook */
>
>  #include <sys/syscall.h>
> +#include <limits.h>
>  #include <test_progs.h>
>  #include "bloom_filter_map.skel.h"
>
> @@ -21,6 +22,11 @@ static void test_fail_cases(void)
>         if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value =
size 0"))
>                 close(fd);
>
> +       /* Invalid value size: too big */
> +       fd =3D bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, INT32_M=
AX, 100, NULL);
> +       if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value =
too large"))
> +               close(fd);
> +
>         /* Invalid max entries size */
>         fd =3D bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(=
value), 0, NULL);
>         if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max en=
tries size"))
> --
> 2.40.1
>
>
