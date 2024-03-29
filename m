Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB31C0DD1
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756337; cv=none; b=nigUitZi1Iw+5ZiQlF+2CeyKEXqZoelsnbymXy4k8G2Aj8bTzidSBNFXBQ9YOh0Yw7jEQTzEmB6uQT3lKJWSbIxZX5IzLeZqkkiy89JYsEJsp/BZmy/R1M1oLJ+C80jCfdOsxdo9veyx5Vcmpd5Na09vTHu6pICkDtIPNQWH950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756337; c=relaxed/simple;
	bh=opNDqohiZyOSBar9zUfFH7eJ2Y48L+BGW1jy1HhKDQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkoGNylWJqimbUm+ZJJKaGLLcbMuNdGk2OO+m1MTVyMLZauWXI3r1wtWyosN3n+/HgBM4EVICZdqL2daObshelXm3XrFAFJ2pW6agNYgaFfao8j+ucyE+jhquBsnh/4iSe+zyF8tX9KyOaWKu69NGhtbv8vg10vatu7hQgwhvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6VbaJ3n; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6VbaJ3n"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341d381d056so1498712f8f.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711756334; x=1712361134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGHmn4YDHNe/zdZGPGhSLI1JNnDUlgM3p7MoxS7TZ18=;
        b=L6VbaJ3nadcAuKQBE5jcFX3Q0JSwuEDw5vfvpHXhRE4NmR8lmWqKeSR9mpoaouiRiR
         laznH6HURvfaNKXBH39QpW4IcNub2S+EVQJNKEJrPb7OYO4Li49MC5evP08E8Zb7+cpw
         Cy79UXmoolUiVZkXNFJE8FNwg65FT3kJiny7ctWCGczMl4DVwDzP5fjb0rFaF2w7spc5
         +iU0QS7/UJzTfpIBjDCwDMly8zY7g8ODAle6MY6n+kcDHbNZ+2hwF/3E0nBK6gAjT349
         E+6gfe8oCFgkALIF1IRxJpH2Bb5wpLEr348qG1Ix6r3ik7UKf3r//u/Ba0b2G85yqZMp
         HJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711756334; x=1712361134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGHmn4YDHNe/zdZGPGhSLI1JNnDUlgM3p7MoxS7TZ18=;
        b=Pc1ki9kUmIIe6tDd565mjYx2Utp4pnh8qyyXFJL9PySqKw/tdsZVfraZho3FYUyUKZ
         +xfVeAlzxu1MXHQd1AIt8jBkKwZ3mGFvzDjG0IhBMnzzsz90kTBq7MrB99LUZMgOVPVi
         iU8SgMXtxOZrYudOlPtUNH31/zLj9Yg3q8+i8xKjXEhkz4g8AxYWRbSVgy6gW3eDVIJa
         ljwkS3wC04bNKKixW4CL18njUMw/MOUCtjCSkeZsuUO0d2Z1BqoXym98Gzww0ReuoXBW
         GftXi2rvH6j5wAo9UuO+QjWqbM7dWrjzRXhLi6qEPP8VbtrcXdPnEFmMgzP5eKK0fHF0
         mnGw==
X-Gm-Message-State: AOJu0YwSJBjjd1/hAJVB9/sX09kx1A3X7QX7O2Ii88ipyplp1WLprDc5
	MLNRXkdqkdG/vD1p5DdOPAClpoT0fg57ZQ7lHut046VjQCSbWp4JVXXAQPYVh9ATxRvZJkx6XnS
	cyIenl+6jJI6uryMNJnf32DMO/Bc=
X-Google-Smtp-Source: AGHT+IEklYfSS6q26YNZ7NyCLj5WAW++NUrChJm2Uv7q/G5cskzij542pnF0KPHopzPwSLZISmIov0/Ifj2kn1YJ8kw=
X-Received: by 2002:a05:6000:1745:b0:33e:8fd:1173 with SMTP id
 m5-20020a056000174500b0033e08fd1173mr2238995wrf.60.1711756334429; Fri, 29 Mar
 2024 16:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-5-andrii@kernel.org>
In-Reply-To: <20240329184740.4084786-5-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 16:52:03 -0700
Message-ID: <CAADnVQ+rs6+8P_-vjSJoUYworGJw8Mk9gUnZBb3PhF+WLw5USQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: inline bpf_map_lookup_elem() helper for
 PERCPU_HASH map
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Using new per-CPU BPF instruction, partially inline
> bpf_map_lookup_elem() helper for per-CPU hashmap BPF map. Just like for
> normal HASH map, we still generate a call into __htab_map_lookup_elem(),
> but after that we resolve per-CPU element address using a new
> instruction, saving on extra functions calls.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index e81059faae63..74950f373bab 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2308,6 +2308,26 @@ static void *htab_percpu_map_lookup_elem(struct bp=
f_map *map, void *key)
>                 return NULL;
>  }
>
> +/* inline bpf_map_lookup_elem() call for per-CPU hashmap */
> +static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_in=
sn *insn_buf)
> +{
> +       struct bpf_insn *insn =3D insn_buf;
> +
> +       if (!bpf_jit_supports_percpu_insns())
> +               return -EOPNOTSUPP;
> +
> +       BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
> +                    (void *(*)(struct bpf_map *map, void *key))NULL));
> +       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> +       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
> +       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
> +                               offsetof(struct htab_elem, key) + map->ke=
y_size);
> +       *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);

here and in the previous patch probably need to gate this by
sizeof(void *) =3D=3D 8
Just to prevent future bugs.

> +       *insn++ =3D BPF_LDX_ADDR_PERCPU(BPF_REG_0, BPF_REG_0, 0);

Overall it looks great!
