Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315B4657DD
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074235; cv=pass; b=HJ7sEMelHlNrVFbJCve+XDXr4eJUsBPMXT2UPJWjq9tnKq9dDsYx/9I/7oA7e31QVz5+fxv4RlpjYL36ASt9MkMuWTUvirsDeozBuIRpuQ0UhtfU/Lue7PpIVgqTetUv2iA8mjB7k/O8QSkdjuz5rBN3wLqgtkpImOXj3EeWc50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074235; c=relaxed/simple;
	bh=DQGFFoiJU2K9izdQcUie2/5EAXfsMBq2jClS/CVRmtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHtRBLtpci8ZmsByIUmodI2QAgFnB+tElQgHFqC+uY4i8Gvbol5ikKE7g5kkxbKBRO6g7OAux922ysN54fmReEXPV9DwJYeazC5iBZwmI4JU1FyDqQSoAsqQqyP+cwnfsSNjTB+xvvszk1vm2TUxJPYA0f2oVP4HIEFH2CJqA2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt6eskqh; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt6eskqh"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a01c80c34so62693301fa.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074232; cv=none;
        d=google.com; s=arc-20240605;
        b=QT9XYo3sn5YXbHtui8INDewAg4jz3fMLmqXVj9UsTRkyM8STSIfyKS+DPR0jbboL3v
         zGnBXkXeWBngfMPdzx6dqnSYsfGwNecZz52HFtWyrP8bLpbGL9YVhGq/WjPyF46iKy6d
         THYi0iopSMht3Sm7qD5Mp3cJ2foZ2K5dXzdNwYUEpaUgoVri49z+V9jshENvVCgL8pRX
         UKv4/0X/B7YoBHaK4fjN39HHjGZnbsq/bZXclodnCl7VPX995LQMI4DbIAohcPt3Wff9
         ta5l/eZJNYCAJ0PKfcw2mBBm0MbRa3n2k0ozD/gfcgvrr0bTQUFuI/45ZIkui/C01R0k
         ISug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xriIljB3f3HwbzgR4DqwJHEbsPSrXHAu4RDpo4RPiXo=;
        fh=HrpXh9wkq9WGU+qkOK/whRNTox/f6EhQ6cTlX3T8GPI=;
        b=BqV2stQKiUdmELC15dDqxu4S/asRyBmoMynn9qWSXMmFywfqT57NV7VOJpQa+oRfif
         yCPLR2gHKhgu+bMxEkaXGIk8CdJHQeUEUHnm61EWinwwnc+X3wkLDQa2e1zjWbpCaokK
         5tAviCAmP0qvbcNMYmBMKuSJ7G0oxOiYnwNODsW3XpZSiZdQs/BBe/7xjY7LIxOPvYAK
         H1sTXmPCv6WlzW62WT0L/hPeG+XRBHcjwGyyOf5oz/whHgZn+67bUyFyxIH/OIv1qTAM
         7whorhtWIlpBT9S/0YUG1lKMjtP5criNwpU2ojzQHs7xWKS2PbTOg4dKLUDtqnGe7xSt
         xAqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074232; x=1778679032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xriIljB3f3HwbzgR4DqwJHEbsPSrXHAu4RDpo4RPiXo=;
        b=Xt6eskqhp/iJHMjgXSW6l8I792hpd0K/ftOplT3EZQMTqLtr6a998QpUWsDMwQbTbg
         gXh0IugPGX4qNz5Bp6j22cv2OMofhvRUDpDI/Q2fTZTUni6f9WmDvsLpfFyEpIPP06cj
         CslJsJoJtaoZcl5RBam0nKv8PvN0HKdwHvKZeADRU088niy7ny9WZ6VDhqBINsZx5X+4
         lflwZ9pk3WjqBbkssWVppUfBVrbHvHRIqgE7KXJUIKpKHXwcVwWl527mIEQow/9OOz62
         uTWGP+QwvA5jFeUoul3HleU/2xrRcaoebMsAxAE0ukOkv/oXpkvvmNJgdPT/2KJMKajM
         PUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074232; x=1778679032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xriIljB3f3HwbzgR4DqwJHEbsPSrXHAu4RDpo4RPiXo=;
        b=ObSB6MFw/19ftsvn58rdmsmS/gucze8DJ/dXEY/64tacUe1S9YWD7SD/FzQ9z3ME5m
         05GYLpjYKoEPrg9bT5cP/aRt+ImOXGswnZ3bNGksX1h6/4L1oSwiGHcaFbRKUKDK2ZSs
         Mt0PwNr7czimeXWC0tkXr3aLyz7U2UMrL1EsiekuVPSQKS1TdXg0lqTv8HU0AaePY7PF
         XAitmN5xNPzU2U6etsE4YWNQYuSGkQyOYcuafqvn4cdWyUOrvV5KdEJ/am8JJUQc34Wh
         5fm/cojJ1amkQPGhh6vo9qyy6WyHfK9Xgyx8ShyoKbu9ZojsBzbahjo9X9/jyNPi1EFw
         TbAw==
X-Forwarded-Encrypted: i=1; AFNElJ/PtbUvarFjwNvoMvQG90I1Na7gE9FOW4j7jQR4NEhe4NzoMdkZQbFiEn5PFbckK7cBj+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkP4LccnrylJhnLbmLF/sr4KYR6euuTyDv1en/z/C4YMIZtrz
	g1l6NNpEstHNcQT8Zz5flf7sXiMyOi/QFOf4Y0Dyj/zDRyS21Zt0QBr7vjXXh3hPaAbISghriRZ
	3hyX/Qb3tX93R/LlwbRt4bK3VV96xxuU=
X-Gm-Gg: AeBDievn1F0jgt3s9wChQ4Gdz/H61HFQnEOxM9zQP6pybO1CU6HmUosnmAmBoaFfZVF
	geDxpIjsBzdd+FKKIRf1uqSemJ806LTwT0fjIMEXzrVdaBcz2BkpR3S1KM6xTF3HuHM4inBkjIN
	d4sPRjVz10N82449YQczezUP8XoFeIHr096yKbDpNuP1G38L+AG2iNhL9h6L9+aR+M+uCHFrrVK
	PqTArJ6kqmfhHQ/9NbgYXaLb4PfV2BrxD+MxMCw0OENqtbJMWiNgM7rpqgFcO5VVvePjATLPKrf
	4Sd7xqhEmcvI/t3u
X-Received: by 2002:a05:651c:32e:b0:38e:a8ef:b61 with SMTP id
 38308e7fff4ca-393c4329231mr10333541fa.29.1778074231469; Wed, 06 May 2026
 06:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-5-vernon2gm@gmail.com> <c13f99d42c434ec73ec1e8cf1141047146ab359e60e56e78e1c32554d6e01e9b@mail.kernel.org>
In-Reply-To: <c13f99d42c434ec73ec1e8cf1141047146ab359e60e56e78e1c32554d6e01e9b@mail.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 21:30:18 +0800
X-Gm-Features: AVHnY4J-CoTLNdm_hcCx9sRfTfkhudhff53vbP0Y0iHDb1_fw8_5BpxVx-dB9-s
Message-ID: <CACZaFFPr+=2zJSMEkfSiYQ8NvEtc3tr4VWBoi5u0BST66E6E_w@mail.gmail.com>
Subject: Re: [PATCH 4/4] samples: bpf: add mthp_ext
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	yanglincheng@kylinos.cn, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:35=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
> > index 0002cd359fb1..2a73581876b4 100644
> > --- a/samples/bpf/.gitignore
> > +++ b/samples/bpf/.gitignore
>
> [ ... ]
>
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 95a4fa1f1e44..357c7d1c45ef 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
>
> [ ... ]
>
> > diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
> > new file mode 100644
> > index 000000000000..bbee3e9f679c
>
> [ ... ]
>
> > diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> > new file mode 100644
> > index 000000000000..0e064bad136f
> > --- /dev/null
> > +++ b/samples/bpf/mthp_ext.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> [ ... ]
>
> > +int main(int argc, char **argv)
> > +{
> > +     const char *root_path =3D DEFAULT_ROOT;
> > +     unsigned long threshold =3D DEFAULT_THRESHOLD_MS;
> > +     unsigned long interval =3D DEFAULT_INTERVAL_MS;
> > +     unsigned int init_order =3D DEFAULT_ORDER;
> > +     unsigned int min_mem =3D DEFAULT_MIN_MEM;
> > +     bool fixed =3D false;
> > +     bool debug =3D false;
> > +     struct mthp_ext *skel;
> > +     struct bpf_link *iter_link;
> > +     struct bpf_link *ops_link;
> > +     struct ring_buffer *rb;
> > +     int root_fd;
> > +     int psi_fd;
> > +     int err =3D 0;
> > +     int opt;
>
> [ ... ]
>
> > +     /* Attach struct_ops to root cgroup for mthp_choose */
> > +     DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
> > +     opts.flags =3D BPF_F_CGROUP_FD;
> > +     opts.target_fd =3D root_fd;
> > +     ops_link =3D bpf_map__attach_struct_ops_opts(skel->maps.mthp_ops,=
 &opts);
>                                                    ^^^^^^^^^^^^^^^^^^^^^^=
^^^^
> Will mthp_ext compile with these symbols? A tree-wide grep shows that
> bpf_struct_ops_opts, BPF_F_CGROUP_FD, and bpf_map__attach_struct_ops_opts=
()
> do not exist anywhere in the kernel source tree:
>
>   $ git grep -n "struct bpf_struct_ops_opts"
>   samples/bpf/mthp_ext.c:260:   DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, =
opts);
>
>   $ git grep -n "BPF_F_CGROUP_FD"
>   samples/bpf/mthp_ext.c:261:   opts.flags =3D BPF_F_CGROUP_FD;
>
>   $ git grep -n "bpf_map__attach_struct_ops_opts"
>   samples/bpf/mthp_ext.c:263:   ops_link =3D bpf_map__attach_struct_ops_o=
pts(skel->maps.mthp_ops, &opts);
>
> The struct bpf_struct_ops_opts type is not defined in tools/lib/bpf/libbp=
f.h.
> The BPF_F_CGROUP_FD flag does not appear in include/uapi/linux/bpf.h or a=
ny
> other header. The bpf_map__attach_struct_ops_opts() function is not decla=
red
> in libbpf.h or exported in tools/lib/bpf/libbpf.map.
>
> The only existing libbpf API for struct_ops attachment is:
>
>   tools/lib/bpf/libbpf.h:
>     LIBBPF_API struct bpf_link *
>     bpf_map__attach_struct_ops(const struct bpf_map *map);
>
> which takes no opts parameter and cannot attach to a specific cgroup fd.
>
> Samples/bpf/Makefile was modified earlier in this commit to add mthp_ext =
to
> tprogs-y, meaning the build system will attempt to compile mthp_ext.c dur=
ing
> make samples/bpf/. That compilation will fail with undefined type, undefi=
ned
> identifier, and implicit declaration errors.
>
> This looks like it depends on an out-of-tree libbpf extension that adds a
> per-cgroup struct_ops attachment API. Is that libbpf patch supposed to be
> included earlier in this series, or should the sample use a different att=
ach
> mechanism?

This series is based on linux v7.1-rc1 (26fd6bff2c05) + "mm: BPF OOM"[3]
first four patches.

All of the above definitions are in  "mm: BPF OOM" PATCH#2.

https://lore.kernel.org/linux-mm/20260127024421.494929-3-roman.gushchin@lin=
ux.dev/

> > +     err =3D libbpf_get_error(ops_link);
> > +     if (err) {
> > +             fprintf(stderr, "ERROR: attach struct_ops failed: %d\n", =
err);
> > +             ops_link =3D NULL;
> > +             goto attach_opts_fail;
> > +     }
>
> [ ... ]
>
> > diff --git a/samples/bpf/mthp_ext.h b/samples/bpf/mthp_ext.h
> > new file mode 100644
> > index 000000000000..33dc01bcebd3
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/252852=
79315
