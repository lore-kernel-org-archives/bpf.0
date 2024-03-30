Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8539881F
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711776135; cv=none; b=DoO5zIMaBZ8LYj4vYKwHxrrFx2XN0GiUrj7apaXgtw+aV62G35j2tZcV4jAfDaalHreWRakaHeDqj9197Y3UooK22dTegkCH0jDKHuLHRn0bB0xzr45r0S+e2OfDKo3koRfmMEHGDjRGA9TZI0rqhqp9BxyYNEKlwQK5juPAIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711776135; c=relaxed/simple;
	bh=mavB84/JS+NYFuMVnjzUqp+iW6kUsPG7gc2NuTkVxCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+a1T9ir1iVDkFcTxNK/rQaFaf9b75Bo+DOpKyDz/G3uZCSzM/ucT7iwerPYb60UmYmd0ZOT0eIa9yOh2FBVsFmxUOUPQZg+jXCryDMlQmBizsMmoe1Hgh1eaMgoENowZBgyX6Vptwr9Kze7oXkTVAHA20+fkZN1TukRbKR0tMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAtB4XPx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAtB4XPx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso1834775a91.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711776133; x=1712380933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E5BST3th2K33b00bMHty7+FBsMOQOw/J1XMR8Z6pi8=;
        b=VAtB4XPxN1NjvzQbpqdpfrfRjY590xIFqaNt5iADjG8GOEBEb5w8S0QqNfpR0PDTq9
         S43lup6jqJ2umOP0g1vxMU+77o0Pwp/4zA744SeLgV/OCe8VxJSJX6e/WB30myPySbxY
         qOqLszR1jmVlKt8m8BGd5AY4A+vFGotOLaxeyxtP/rFhlaxXyg5XsRF5Gt/j5QnYiQO6
         lkn9nP2M2srNfDi9K84YHVDB+sdWGGaQHDt0u+Nv3DACXBZQq4sWjQklgb7uQJAMhGeN
         XIkBW1ncJzqcDlo2yJNw8OO3duWGx2Aq4YKUNnbs4vXVQfwSFHfTF4MqkfkRF0+tkvXw
         J3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711776133; x=1712380933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E5BST3th2K33b00bMHty7+FBsMOQOw/J1XMR8Z6pi8=;
        b=WcCVTH8wLXulXvRhc4os7n8UIZI1uCjC/JTl0ijSKfiBrKuS6twSeZpRfk7AZ9PnpV
         vkDS1VErVhjIHbNeLHkJ0Pu7WGO/1UO3xIa/ydyZHsDaKmeOEWcUgGfnrl1LMHz+Hqno
         LZbH5Eo+WKspDjW3XlG6AlXys3IxLK2cnz7WTP/HbPRfmyHX0ESqe/++pc6Q5Bsy50Wk
         TcfJCpvCobRI//iYxQV2m8duKYux09e6QdV8gUEHYVw8nvEhTX5MalfsknnxU4MQ94KP
         XXMMpgxXq1Lp9MaARbA7VIPGMydDEgdeNCewJSvsNjHmsU0rMNypdPJAT0/fx0ec/+NC
         wVtw==
X-Forwarded-Encrypted: i=1; AJvYcCVtifNK/jIRnWBnKQNlQHbq6LZKJRk/7fnFf+t5knraAvmsWvdv3ZmkcKHMdZwfkqHpr+sLRp3ESzMfWHUJul5NN1Gl
X-Gm-Message-State: AOJu0Yzm1p6Hw3xo7z11jEYdM6bLXowM1jUm/H8+l1GJVoxRuZjrt8Yx
	6pQgM4G1It01o5KdR4TfJbYv1Er5yrRKGhqIRSQfOnaAY/pFyQUtnCJ4Gc3Y4fxswelzpJSm2FB
	toMVWS2sHke+HH22EW8Vf/+XXtBI=
X-Google-Smtp-Source: AGHT+IEJ8DzfmzeBK3zuL+1jfc30t27Ik6jEVX5Vyhtia9HWP5zTSkLZk2T9z0C8sddvKTrVRDBYhJbddKAgh5njcIM=
X-Received: by 2002:a17:90a:fb51:b0:2a2:a3d:44d1 with SMTP id
 iq17-20020a17090afb5100b002a20a3d44d1mr3532869pjb.2.1711776133011; Fri, 29
 Mar 2024 22:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-5-andrii@kernel.org>
 <CAADnVQ+rs6+8P_-vjSJoUYworGJw8Mk9gUnZBb3PhF+WLw5USQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+rs6+8P_-vjSJoUYworGJw8Mk9gUnZBb3PhF+WLw5USQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:22:01 -0700
Message-ID: <CAEf4BzYikBMoNU6myU_35d17uukW+gh1MWfQfQzbwxs-18ud_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: inline bpf_map_lookup_elem() helper for
 PERCPU_HASH map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Using new per-CPU BPF instruction, partially inline
> > bpf_map_lookup_elem() helper for per-CPU hashmap BPF map. Just like for
> > normal HASH map, we still generate a call into __htab_map_lookup_elem()=
,
> > but after that we resolve per-CPU element address using a new
> > instruction, saving on extra functions calls.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index e81059faae63..74950f373bab 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -2308,6 +2308,26 @@ static void *htab_percpu_map_lookup_elem(struct =
bpf_map *map, void *key)
> >                 return NULL;
> >  }
> >
> > +/* inline bpf_map_lookup_elem() call for per-CPU hashmap */
> > +static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_=
insn *insn_buf)
> > +{
> > +       struct bpf_insn *insn =3D insn_buf;
> > +
> > +       if (!bpf_jit_supports_percpu_insns())
> > +               return -EOPNOTSUPP;
> > +
> > +       BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
> > +                    (void *(*)(struct bpf_map *map, void *key))NULL));
> > +       *insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> > +       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
> > +       *insn++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
> > +                               offsetof(struct htab_elem, key) + map->=
key_size);
> > +       *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
>
> here and in the previous patch probably need to gate this by
> sizeof(void *) =3D=3D 8
> Just to prevent future bugs.

All the gen_lookup callbacks are called only if `prog->jit_requested
&& BITS_PER_LONG =3D=3D 64`, it's checked generically in do_misc_fixups().
And seems like other gen_lookup implementations don't check for
sizeof(void *) and assume 64-bits, so I decided to stay consistent (my
initial implementation actually worked for both x86 and x86-64, but
once I saw the BITS_PER_LONG =3D=3D 64 I simplified it to assume 8).

>
> > +       *insn++ =3D BPF_LDX_ADDR_PERCPU(BPF_REG_0, BPF_REG_0, 0);
>
> Overall it looks great!

thanks!
