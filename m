Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25851C3318
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004135; cv=pass; b=FBfeLiD9UzizgT5gvQKWGo+y+4GUA09KBfbNio3qVp9rVEu3S5KptPyotS/RXZx3nvkJfzKZhgI7Sy+lKpDg+pN8M0I5acVB69hYTIatq+43Qv/agNC6Hrk5m8F55HdNvcQmJY+yCRlh/dZx2wzKS7KtTIUAYnwiJleLjPGXrfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004135; c=relaxed/simple;
	bh=JpRy1vnQD8a9/iG87bxDAUGVE59aR4OGNY+ECk5ffbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzw4nqV6CNP2m1rVjOvwcD+SnJgHp4NjRoWXCwJOyFHhB0VjCD/Co+PIrtn4BGyhPnqsFx4Ub9mJGp6mVw1vqnUUK0KW88IoitmXRXqeDg1/aWu0vfAHaZMiY/oAyPy36qERKPDDWs8ek5C42VsCew/PZ7/LR+sOUOcy0Dda8rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt8a8Pky; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt8a8Pky"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-369576666d5so6516837a91.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780004133; cv=none;
        d=google.com; s=arc-20240605;
        b=FirOhrfXdVAlcQOhgbNLtlFtEoPq7d2Ntoyt6qOrkiTKPSpMYHGFyH6OTwDZMUOVRS
         u+4jMJPr/enI1PoRSVS4ds/uMZjQDnKJ+rEtl0q6DZ6Pi8jWF8DfS3plRXxauc1YGBWI
         p9NwUTypeiH0kQhWfg9ytUIdeHRmdyCYWRXklcN/Rgrvt/dpJYqztPIJbyE58ATGqjiX
         kaS0HFHD7dkP0RrGPifxQjkgpMXW094bvsM4Y4CyxXclihE/B6ZrbQlN+pnkyFNdf1kb
         3VoybvQb30hWIDHpcy6hJuSDXZw9J5P/e/cQZoUGizyRoX3LB4lNDx7Zs8Ox3W70itIt
         3uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KctmpfYaWhddWX7BWymdRHmv85mi/lrrG3/J/baDtnU=;
        fh=mbsrezOx+JIVB0ciy8CNeVubXZiHKBYLAN3NElzrI+c=;
        b=SE66RmKknvNSub2qUbAUBAP1WP/YG6gct+poQdRTLteMhpDEdWDotFAoQPr9AZudvY
         eNLKSwWGEOulnuNE0C+uVGVZu6CD6SvesHh0CKXderoDet3HjBun/sM+jHq9KRA2odgB
         1Hn41UUM8vJEa6XwnsSG4Fj+59ZerNpOv1kVaadnToL0sd37KvmQZSGPq43Rdi4UWGdV
         6YXsz3PpgT4LFgMCzmvtRHcQ45L9HBB3wprsFZAuAUN902iKLQBdFEJzYMF1itnXjhz7
         ynQVR7fYZ1qGAmHQJex3D3o+Tgx2YxifEAwDw2OG31Lyac6oC1kUBCJGbkRWxQ2JGZyv
         EVmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780004133; x=1780608933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KctmpfYaWhddWX7BWymdRHmv85mi/lrrG3/J/baDtnU=;
        b=Mt8a8PkyEHgY+H5SX4cmqUi4CqERQYjgAFok+nW6WjasP/6z7LSkKAp/Oi8JDj0UzZ
         pMTWakpTBUQESh9o8ksJ056AVWHG5gpPgqeTsGmTQUciT+nKASNfAUgZqFxq5EAut5CM
         svaIRWRI/Lqi6irDmk3pHDPT//kWTkGqY3wPlV6XfNkibQQxu+MWQZMuUS2PqjECinu0
         w3S/eGGq3vCRXHTWx9y8pWXrjz8qjk0D8iUxFl+7YRrn3frGOEc8PvssrpjJs79yh88p
         xeY8XfsEdqbzkBfXZ0z5Xer6Deyg+uCeanlLH9Yp/Om36tD/JrlbFLB6oO8etnxp++za
         k/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004133; x=1780608933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KctmpfYaWhddWX7BWymdRHmv85mi/lrrG3/J/baDtnU=;
        b=j7xIR8CvAYObWdQLjPdJpCtpLUBLUuOyDeyaRjh+ig9SfQ1AAgdv047OtxK/I7QFIE
         PPyWe6nEXCD6Sj0e22Xx+baQ8nNu14+kPtkT+UXa7/Rg+emLHv1i3NoAXWX4lB62FAcG
         hILl0iUkNwyR9KsdReGxtEXVpOtQn3RiMN7f7pzfGSjEkCcIcZh3sAfFckURQCRFxu0U
         5BBcFXvLNssi9AHdNYRYaqQC3NmOB0J0ol8DvUVpWJNS74zfPVruoP7vVYbztjYjYPvJ
         61zV+bpBAutBAlqWAITuaLqP58CBJCXYblLDFOwfPN1+qyr+MDwf6BS4unIBNhsI4wbx
         2MRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CQzlYBxyewY722z78nQL1H8QgDo6D2xX3f5RYkqTKfuG6mmR1zofUfDqc/yaKUMgEnIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjwg+IRGQEaYzojggmcAOWm+YtN+bOBCC7b0iEqXQ5tzLa/w9
	4MH1E/N/Qt2mS9VbIPq40THdQJ3CE8MVYMOobHWjQi9V+hri42ex+HTp0+AUyWyKdH8fsxXvy/N
	BadSZ+BwQXvJiCxutoeDyeenSYTjD620=
X-Gm-Gg: Acq92OEAARyRQz33MrWjJdfVSamF2iX1ifVVtItNExxZYJ980mGaHzJdwOMsS/2j0no
	9r2mVw0KaZ5lnRwZFMrLJHkHwh2FxtQV8IW3IS/6HClocllNAL3RpSWapZmLFEn9TOCWlO3vnb3
	TYrLDjvuiVlAp9tIYrfXYlc++mce8nSLINGhLzs4Rdqg0/6FDJgv4N4CVKf7vJIFy6K/kuJVnb6
	y+BEVYp+czvCp/xeT2Gv8aVFV65voRQBi1FZTt4GqKmqfgkqxQki/lN/NRSaPupLifrj0NNANl6
	n9ay/ENrOSCWBNqyt9cI1a/kw4kRUMidGA==
X-Received: by 2002:a17:90b:2fcd:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-36bbc58b928mr392897a91.0.1780004133138; Thu, 28 May 2026
 14:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 14:35:17 -0700
X-Gm-Features: AVHnY4JzTPNQU0oc8s-JlXk-t109KtpbUg34BjTRIv-OXoUXQu6WDmbFV3Hr6Ak
Message-ID: <CAEf4BzbMk4wi1qQFKqO8LfRWLFi7+4p-uLwoHvEg-_YCgHJhyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] libbpf: support STRUCT_OPS in light skeletons
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gprocida@google.com, maennich@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Siddharth Nayyar <sidnayyar@google.=
com> wrote:
>
> This series enables support for BPF `STRUCT_OPS` maps (such as
> `sched_ext_ops` used by sched_ext) when using light skeletons (i.e.
> `gen_loader` mode).
>
> Previously, generating light skeletons for objects containing
> `STRUCT_OPS` maps would fail or produce incomplete results because
> `gen_loader` lacked support for several key features required by
> `STRUCT_OPS` maps, specifically:
>
> 1. Loading `vmlinux` BTF to resolve kernel-side type information.
> 2. Correctly plumbing `btf_vmlinux_value_type_id` into map creation
>    attributes.
> 3. Ensuring `btf_key_type_id` is zeroed out to satisfy kernel safety
>    checks.
> 4. Plumbing the userspace BTF FD (`btf_fd`) when
>    `btf_vmlinux_value_type_id` is present but `btf_value_type_id` is
>    zero (which is always the case for `STRUCT_OPS` maps).
>
> This series addresses these limitations by:
>
> - Loading `vmlinux` BTF in `gen_loader` mode when the BPF object
>   contains `struct_ops` maps.
> - Explicitly zeroing out `btf_key_type_id` for `STRUCT_OPS` maps to
>   satisfy kernel validations.
> - Plumbing `btf_vmlinux_value_type_id` during map creation in
>   `gen_loader`.

this type ID search has to happen on target kernel at runtime,
otherwise your lskel will be bound to work only on exact kernel you
used to run bpftool to generate lskel

> - Fixing `btf_fd` copying logic in `gen_loader` to populate it if either
>   `btf_value_type_id` or `btf_vmlinux_value_type_id` is set.
>
> With these changes, it is now possible to generate and use light
> skeletons for BPF programs utilizing `STRUCT_OPS`, such as custom
> sched_ext schedulers.
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> Changes in v4:
> - Load btf_vmlinux in gen_loader mode only when BPF object contains
>   STRUCT_OPS map.
> - Link to v3:
>   https://lore.kernel.org/r/20260526-libbpf-load-vmlinux-btf-in-gen_loade=
r-mode-v3-0-5b4fa2a5e1a4@google.com
>
> Changes in v3:
> - Remove erroneous change contracting map creation attribute size in
>   gen_loader.
> - Link to v2:
>   https://lore.kernel.org/r/20260526-libbpf-load-vmlinux-btf-in-gen_loade=
r-mode-v2-0-6750f5859bc6@google.com
>
> Changes in v2:
> - Expand the series to 3 patches to fully support STRUCT_OPS in
>   gen_loader.
> - Add a patch to explicitly zero out btf_key_type_id for STRUCT_OPS
>   maps.
> - Add a patch to plumb btf_vmlinux_value_type_id and btf_fd in
>   gen_loader.
> - Link to v1:
>   https://lore.kernel.org/r/20260524-libbpf-load-vmlinux-btf-in-gen_loade=
r-mode-v1-1-6f57f191a7ad@google.com
>
> ---
> Siddharth Nayyar (3):
>       libbpf: load vmlinux BTF in gen_loader mode for struct_ops
>       libbpf: zero out btf_key_type_id for STRUCT_OPS maps
>       libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
>
>  tools/lib/bpf/gen_loader.c |  3 ++-
>  tools/lib/bpf/libbpf.c     | 25 +++++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
> ---
> base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
> change-id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa4=
67
>
> Best regards,
> --
> Siddharth Nayyar <sidnayyar@google.com>
>
