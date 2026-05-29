Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029633A8FE6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050691; cv=pass; b=tdZx6OFPcTP94tHMA1C6HOFLASYIdunhLTdyKgVb2KibVcUBurgrOC7xe0DZU4MRLsiVoZ+58TG9JQxY4rO4jClRtw4o4//3Yhm0Zxl4LFZXUjN5FH0y55/y9b6pe5nvdkdEChFENOqwJi53T4+EXigu7JJArO713TcdDW42bAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050691; c=relaxed/simple;
	bh=XKM2wUdmD7u8A9Q4qTT5NS267XUvD0R9Sn0Yrvc8b1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXEmYB8PD3Hu9kZRwNkjNfv6Os5RgcDzqdDESrMlh0NvWKBfhUCNeHLB1dP5Ipqg9soWbFpcFDYIGrGBgtapG46jGriOerd1iTkT8bYn5pHFRm9uN2mBJWBgzqgmdEMc+k5GIdGECOD+Qw/E4utVooa8T0G+fLs3hDrumPLJZCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GmwwbhiY; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmwwbhiY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c307937816so131811317b3.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780050689; cv=none;
        d=google.com; s=arc-20240605;
        b=hPNqTMLgS1gfyCfxx9bRS0hYIaVZ5TuAcCK3i4J5pNJKY6xfRAN0FfqDnilmupDvGD
         T0FSTt80trCk76IEeDc/T/yE5+TyRWbh/xaDYCJxh/Sg/dhausBU/T+alz0k93UsexqW
         5r0DZMAlIYAD10FCalSGy2baErS668Ta6yqJoucHj5iap6z8vvvOD7UoW1lj3GWVSS6K
         uRUhAmkBzTLocTJyh5WbKFpgLoqyAQrMLVHjMKfzRZVFvXxZjh5IiP1KYq/RJ6D96bNl
         Pehf4Lq62mZ/eqbOoxc5MCeDHdsGxE2WaPEcWGt6hk4oC8Oja6Hnu23WBRxvFRlX0QHx
         7LWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmraoDaLwquanlKYKGbvUOzYXM43P9DHFtol6Bvpgiw=;
        fh=7dF7cJ9DEmXOChpGtDS0ToFkBcuJvpYWE+I2yuM/ZZQ=;
        b=I+/OCzYj0XrRyfazIjVwGKSXLQbv+dOJqRLCXpJans24imeoBb4i65ju6PXIRLH/iB
         kN4YMvIs3znB6KglqCX4EFkF8sz4gxwqHARC8RVnXll3vHxCmc3Y/UcPEuMPmf9JlWBh
         lZ+No/NGK8P9aBMi2BbA+xqugJW1jRrz9q7xtTSvkljDxb42X2P0cfO3+brPGKieBzb0
         3/INKhTGbObqSKJtOK3+apTsUlvDUuBcUi4pl1vgIsPekX2Al9+ZOarTge+nlHA8uFZw
         zeJuuHDRDPqEdgu4ZjXHO2dmqwpPVsDJSAi0eAY4Z/L+mGiXZMTIWHCgkeAS+Ll5sp/a
         Tgiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780050689; x=1780655489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmraoDaLwquanlKYKGbvUOzYXM43P9DHFtol6Bvpgiw=;
        b=GmwwbhiYfvBNNbARSp53Phzsd04Ph1wBev+chZW4UodFraELLiE1ObLZ9X22ZGSf1C
         iUxCgOLY2+vLEdzbm9sZzOR0TBL7XAnejJIusJlkKnLwOWZGze4Hm5efn7YSWzZnKTKk
         y/rdpOm7xIoYeN02CxEM9LTknGrcs3SSntY5CyOkAsgUTnyfoDnWRkbqCtB3wIEeXZAK
         vFwr5YXqO3iKL6BLC78feP4JXwOjjcNW3t34V3DCuEq8BIC9Ggy5czkUCgXtAXB22yop
         opHPDWRZ323OClysw30nA+0f+TLxmY1r7guKNNih1WE8OvjWl+z4LqMt3MbHgxzd7mZ1
         ZGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050689; x=1780655489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmraoDaLwquanlKYKGbvUOzYXM43P9DHFtol6Bvpgiw=;
        b=pc77gINc/CVKogyN2XV989Dz5SeyQPmUnL8DG/w9lPoZYEe/dt3dyog64mfEXYD9Sy
         1pw0DnDZ0z1iJSZD9CM2hJtVpG0WLqt1aztl1+qbInQMwLdJ3H56xsy9xfBffEg4NHT4
         sFoP7XKillAGy99L6bFgN7r3QXnab4BfjIfDD8e5PUnkadyzkZFhsujGC7+XmFFVX/WV
         j3+OxCv++O0lAkdAci2LS4lVUeTakJbx/Rj2dGjS2GXuHMVRJzajuudyT1D9O/Wh0dPt
         sGZqlysho2pDgjmkMCx+b+Ey24aVWHpE1csLhmoqODfaiM1CQcygK2C/1MKBfvWNf2ZX
         6rVg==
X-Forwarded-Encrypted: i=1; AFNElJ98/w9FtjJOlDpfNcOXnNnQixSeez4iLxEH3FzjN2nBXtAd/YyVzwCdSqU0sN0LTrhzkHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/Ghf4J+KZrajPw6fJsEQWrDhd2PuTys/uMIR8q/YVzFbXKpZ
	T+Vm4+mLFabUWKdpoSHQ046BpFF6qOnnx7QT6c0pQCQACjqgg0wwmmc/4GCEYTlRDPEXhwUkNlX
	yq+4j6Z0T8FmKk+cgRpTBgvW9XrSs5BswgkZsEyhs
X-Gm-Gg: Acq92OEko38+ksoUVrk0EIxdtZCUcEgmPvJGkfYKHKDG6nJ2QpVOtvLCX49QF/JcE/n
	yBKbsVwM8r1+eQhjRvH2kRKrQPBO3bjcl5Q+YR1reUFM38NDd8v3VAA/tnavGEZgxfnuXaE+5uR
	Eek5IICIUzMw7/GCa2yS89OCUbEPaJhLgxiQOnSdzcUqW0W1iIWx+8cpOfvlezPNhdqPF2aFeSM
	I1Mo+6dNub9fpvJNGhAy1g/5MfZ8MRY15+0St6nt4fJAubfNf7UrQyLTM4DitIBjcKNlQ4O+I2c
	a8T15bIzPQ6jCLjE3d2z+wNRlgcuTK+hQW3xORNPTiahyGx4
X-Received: by 2002:a05:690e:1183:b0:64e:e896:a86 with SMTP id
 956f58d0204a3-66052eecb8fmr1457017d50.36.1780050688456; Fri, 29 May 2026
 03:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
 <CAEf4BzbMk4wi1qQFKqO8LfRWLFi7+4p-uLwoHvEg-_YCgHJhyA@mail.gmail.com>
In-Reply-To: <CAEf4BzbMk4wi1qQFKqO8LfRWLFi7+4p-uLwoHvEg-_YCgHJhyA@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Fri, 29 May 2026 11:31:16 +0100
X-Gm-Features: AVHnY4IUcL3YhIIqaTww8MCXycIEmz1973_TA9ar824caiu7Z-0b4qvviBUs6Hw
Message-ID: <CA+OvW8ZU0dY1eOSVuthZnqLpt1uMq4u8aJBF5i6i9zQzSg68dw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] libbpf: support STRUCT_OPS in light skeletons
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gprocida@google.com, maennich@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 27, 2026 at 5:53=E2=80=AFAM Siddharth Nayyar <sidnayyar@googl=
e.com> wrote:
> >
> > This series enables support for BPF `STRUCT_OPS` maps (such as
> > `sched_ext_ops` used by sched_ext) when using light skeletons (i.e.
> > `gen_loader` mode).
> >
> > Previously, generating light skeletons for objects containing
> > `STRUCT_OPS` maps would fail or produce incomplete results because
> > `gen_loader` lacked support for several key features required by
> > `STRUCT_OPS` maps, specifically:
> >
> > 1. Loading `vmlinux` BTF to resolve kernel-side type information.
> > 2. Correctly plumbing `btf_vmlinux_value_type_id` into map creation
> >    attributes.
> > 3. Ensuring `btf_key_type_id` is zeroed out to satisfy kernel safety
> >    checks.
> > 4. Plumbing the userspace BTF FD (`btf_fd`) when
> >    `btf_vmlinux_value_type_id` is present but `btf_value_type_id` is
> >    zero (which is always the case for `STRUCT_OPS` maps).
> >
> > This series addresses these limitations by:
> >
> > - Loading `vmlinux` BTF in `gen_loader` mode when the BPF object
> >   contains `struct_ops` maps.
> > - Explicitly zeroing out `btf_key_type_id` for `STRUCT_OPS` maps to
> >   satisfy kernel validations.
> > - Plumbing `btf_vmlinux_value_type_id` during map creation in
> >   `gen_loader`.
>
> this type ID search has to happen on target kernel at runtime,
> otherwise your lskel will be bound to work only on exact kernel you
> used to run bpftool to generate lskel

Thank you for pointing this out. I realized the flaw in my approach
shortly after sending these patches. You're absolutely right,
performing the type ID search at generation time would incorrectly
bind the light skeleton to the specific kernel used during the bpftool
run.

I am currently working on a more robust solution that handles the
STRUCT_OPS type ID resolution on the target kernel at runtime. I=E2=80=99ll
follow up with a revised series once I have properly addressed this.

Regards,
Siddharth Nayyar
