Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937B439006
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530335; cv=pass; b=Kv+vioDZEgHV0umBaFeOhECFzGOCJKTc0/BBKh42q+gNDiIv0VO/ZJZsAB9qgBSjOB7SZX+0E7BHN3O/e65j5JzqdE9QE5dOxOM2qF/cLqW110eO80qPuNYK7b60QYkBLDZVZQ0PnK/WZILVL0EbjQa9W9wxEppWQ2vE7S12f8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530335; c=relaxed/simple;
	bh=ukEmX+T4FtTUtTZCL/lPwLl9iXp9MlnxJQR8kzn3ggo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enNNbgVSTHz5NUa1tJlSanm5FU8rzxxjlx1JmJq58xOutxLOKqjZ8JSXXryFWMk7muOHG1LGTcnZRbwQJlBkga8cRxcqat10wBvkzeGIQBB9dGwqKfcR59Lm0JI9JXQKRbioWQlhkZW9J6yYlMcEVgbIn2uYMp2VY+Jtf6ebQJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2vdA5x7; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2vdA5x7"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36c68964315so34083a91.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530333; cv=none;
        d=google.com; s=arc-20240605;
        b=FGNS7YmyFXyxGNnpM/bzoy8eof23vV5f22J9htFUqH77rRBHzS0DW90NUM3LCmwWIx
         7ltrdo8IlIdY3tS8HoP7zlAu12HsJri0ezSGkCfWtR05Uj623D66C3HVGqw0cC4dIMiC
         4WHOgswg/yw7X6MoXCeVXV+gm1Q/UKX0tBpOnypC3JfrcU2RI8vhLrZJrclKgikdDiD8
         OUXldTAAwAA9h8dgQWujWmpYxQjfe74MHrcCjocYt/5vkqhSMSkFPP+yVe4PkiJBe3mS
         jMsJVRfhXx72UvO287UQ0HbeVZ8xLLzTlmIHH/i1qzFs1qK8Om7rZlK7UK/cvVgMt9c6
         YUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=616jwIAoA5bGuvYScrJCMq4D/vbuwVet8wc8Km9Ju/0=;
        fh=KJy8miSm23OA3UK8clvExfxfFEYUIgrZC1x+Sqz0MWc=;
        b=OCokNPxUjcMu8ji/VCFhZZldNmuy9u2RVp4sEg+TJxC9Xt9s/1F0S299h9yxCf2m1V
         RLvAAgq4GfTA4o24wBfcRi6OU2clzulAkfuL2h70efOew9VWUt8eSxokOm+UZl6Pivoi
         A4dpMyAaYQgCGke82WU6/NFY6DnQJLO1ik9B317wJxPFdZDHwZifjcdbPGuU994fzsHJ
         mmhd/csvTztlnXi61rM1gzEKN4gpFBcnG+ABx9wGKz5Iy17T0oQuOvx5YYSYE3yjIj5a
         rG2YwRZPn1eFjFECvViuYTG3SylQLf9QpcOzO1HN7mE9wJilHgIuiIy/50bUiYXft298
         CGpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530333; x=1781135133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=616jwIAoA5bGuvYScrJCMq4D/vbuwVet8wc8Km9Ju/0=;
        b=l2vdA5x7/Zg4ivsLRfstUVFPTBI0PJC3tkvLaLkVmENcfMBb9rIdsk+2NBryhsroGg
         Utl3BRr1FfoDJEQNe7wLX1IC57BeoxoLcCm0NSUUKWoUNN1GPB8eWxuVRjvJlKZNjH8N
         Cedsu6dUpeTUxM3tAQWSF7iWmirQPJeHjIDbwsdF+FD+rZWlynKZt9JbVXz7F1+40LvS
         JAvci6w3qr5X+aPycSRsA361LevDUprTeOkByr53TBPfLu2Jcs4qJEEovgXfQBTKWkKw
         tRpRcafk/g1PB3G6vyAzUQSYcX/Ura4NEa/aylhdaMlGJ6lHmv5Pr747cmH8LbmcRkpR
         OD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530333; x=1781135133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=616jwIAoA5bGuvYScrJCMq4D/vbuwVet8wc8Km9Ju/0=;
        b=H7ywgdoMAVrVOB/lDAfVSci+WaLy5fbwKO8+1nT8SuhHsiOvzVGR9vvskcy6ANkhj9
         V2Zug7JAYQO7QgaFzqvv5hZaHOdcaKJ1wG5flWEZEfY0nTNHnXd0OTxgxZWpuyYqlQEG
         f5L/aniUbmpX1fdYpqrqwyhtUZU5uwNY35yItrbgB2R/hMdRlqMbO5AWCwi8eAdQ6rgB
         LF/bI3UfY8zfybqMhEBBtvaqWW9MZYMBvXtbyLW6OJcku8/PN6Y5IYof5UKtiWpc0ZLW
         pHYAcjHgnVQJqNXpTsgf3EBobUdsdWpHhObFUnJLtiI50FnLPT9luCVe76jTQg+iFeva
         4Kxw==
X-Forwarded-Encrypted: i=1; AFNElJ8r6LAwBNBCKqbQRaHUp9Rpprn3McWKI1B4DZ2ZkNkYdiJILwpbLnLxMD5Ri/QFa7RtplA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+6ik3/x1Brn/yzKYpeNML1Em+3ggmM+tcPKzFLSGxVIHYqCG
	Jla8kWlUjYxabzPJYutZZN4BA2jEW40CQWGmckuUlWC45Zc2Ej7dd/zwPwYDMBeOxXCbsoqhx6D
	qCZJTjYGannM47RyoBFWpz6KEqC+jGb0=
X-Gm-Gg: Acq92OEXqRGupIHeqS6ZJ5/DsXFhBJOfkb4W3us2GBP9uCE6Jdz7X+d/l/80gED/lOs
	8LaALkpE8YQScxtVvGGLCqw3+Ib2os0EolDL1wX1lROE16zkQJ0DvwSFjxKr2gOVMfa6Crjnail
	AGa4d2dL0nVJRB2Jf7ihdKfB1ogixXEw9Nevx+3XE8QiSo0EU+nEK6BKdt2WUzI7l6ON5ja5jlR
	LsKTGQ570ZrtljUkqDAckCYKeWkmFTA7yjxa0tgstCIaSoiMjd/YopmEO6BpEeBJpXmIoze4T7s
	/vVuIE/a7x71wknd0g==
X-Received: by 2002:a17:90a:e7cc:b0:36a:95c:7613 with SMTP id
 98e67ed59e1d1-36e32667b13mr4974479a91.10.1780530332953; Wed, 03 Jun 2026
 16:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:20 -0700
X-Gm-Features: AVHnY4INjDXF7hSJRIa00bIaxKi8FRuuo6Sgu8XFMwxGFLNxme-XDEiK8fAeB-U
Message-ID: <CAEf4Bzb-MuvFqsBdNCYyU=X7O+OXGK33TKA3GRe=P0gVFR=S2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] resolve_btfids: Implement BTF tags
 emission for kfuncs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:18=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> BTF data for the kernel is generated through the following pipeline:
>   * DWARF is emitted by the compiler
>   * pahole reads in DWARF and produces BTF
>   * resolve_btfids makes kernel-specific btf2btf transformation and
>     patches .BTF_ids section
>
> This is orchestrated by link-vmlinux.sh, gen-btf.sh and Makefile.btf
> in ./scripts directory.
>
> Historically kernel-specific BTF features were implemented in pahole,
> and controlled by the feature flags. This requires kernel build
> process to be aware of pahole version used for the build to set
> correct runtime arguments for BTF encoding [1].
>
> This is a burden which can be alleviated by splitting kernel/module
> BTF generation in two stages:
>   1. Generic BTF generation from the kernel source code.
>   2. Kernel-specific BTF modifications to support various BPF features.
>
> So far both stages were fused in pahole's BTF encoding. By moving
> stage (2) in-tree, the dependency of kernel build on pahole can become
> much more loose.
>
> Recent work [2] made it possible to do btf2btf transformations in
> resolve_btfids, and it is already responsible for a few important BTF
> modifications for the kernel:
>   * .BTF.base generation for modules [3]
>   * BTF sorting [4]
>   * KF_IMPLICIT_ARGS support [5]
>
> This series continues the migration of kernel-specific BTF
> transformations from pahole to resolve_btfids, implementing emission
> of decl/type tags for the kfuncs and handling of the KF_ARENA_* flags.
>
> The implementation is idempotent with respect to BTF modifications: if

This sounds like an unnecessary complication. Can't we just control
pahole through flags to guarantee there will be no kernel-specific
information emitted?


> input BTF already contains target tags, corresponding resolve_btfids
> transformation is a noop. This allows for more flexibility in terms of
> dependency on pahole. In particular, older pahole (without
> decl_tag_kfuncs support, for example) can now be used in kbuild and
> the resulting vmlinux BTF will contain properly tagged kfuncs
> anyways. Conversely, if for whatever reason pahole emitted the same
> tags, they will be properly skipped.
>
> The series consists of the following patches:
>
>   * patches #1-#4 refactor and fixup resolve_btfids selftest, adding
>     kfunc checks
>     * patch #3 is a fascinating rabbit hole with a two-line test fix
>   * patch #5 refactors resolve_btfids introducing an address to
>     elf-symbol index for efficient lookups
>   * patch #6 changes how resolve_btfids discovers kfuncs: instead of
>     relying on decl_tags emitted by pahole, identify kfuncs directly
>     from BTF ID sets
>   * patch #7 implements "bpf_kfunc" decl_tag emission, with the next
>     patch testing it
>   * patch #9 adds "bpf_fastcall" handling, with the next patch testing it
>   * patch #11 implements KF_ARENA_* flags handling in resolve_btfids,
>     with the next patch testing that
>   * finally, patch #13 drops now unnecessary pahole runtime flags from
>     the kbuild, and patch #14 adds a bit of documentation
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/Makefile.btf?h=3Dv7.1-rc5
> [2] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@li=
nux.dev/
> [3] https://docs.kernel.org/bpf/btf.html#btf-base-section
> [4] https://lore.kernel.org/bpf/20260109130003.3313716-4-dolinux.peng@gma=
il.com/
> [5] https://lore.kernel.org/bpf/20260120222638.3976562-1-ihor.solodrai@li=
nux.dev/
>
> ---
>
> Ihor Solodrai (14):
>   tools/bpf: Sync btf_ids.h to tools
>   selftests/bpf: Modernize resolve_btfids test scaffolding
>   selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE
>     builds
>   selftests/bpf: Add kfunc set test to resolve_btfids
>   resolve_btfids: Index BTF ID symbols by address
>   resolve_btfids: Discover kfuncs from BTF ID sets
>   resolve_btfids: Emit bpf_kfunc BTF decl tag for discovered kfuncs
>   selftests/bpf: Verify bpf_kfunc decl tag emission in resolve_btfids
>   resolve_btfids: Emit a decl tag for kfuncs with KF_FASTCALL
>   selftests/bpf: Verify bpf_fastcall decl tags in resolve_btfids test
>   resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
>   selftests/bpf: Verify arena type tags in resolve_btfids test
>   kbuild: Drop decl_tag_kfuncs and attributes from pahole flags
>   docs, resolve_btfids: Document kfunc BTF annotation emission
>
>  Documentation/bpf/kfuncs.rst                  |   8 +
>  scripts/Makefile.btf                          |   7 +-
>  tools/bpf/resolve_btfids/main.c               | 391 ++++++++++++++----
>  tools/include/linux/btf_ids.h                 |  78 +++-
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 218 ++++++++--
>  tools/testing/selftests/bpf/progs/btf_data.c  |  20 +
>  6 files changed, 602 insertions(+), 120 deletions(-)
>
> --
> 2.54.0
>
