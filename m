Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278437FF67
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781320172; cv=none; b=ME/TleuUeTFM3oxGDqELxzvT3VM/iLVjCadfrSZNZFaiAnJYk+EYWS3AkUyDIZU7upAQFTMFg8BbydZfvqHw7bKDQ5wmlTCrl95Ob00CXLyiVFVfZcmb500zsgtg8dJ7Ela0W24MMNqIqVuXBkPuRtZUfI92DIY9+XPkGQQymyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781320172; c=relaxed/simple;
	bh=HBb4UYXrfgCeUyPPzgEusyH309x00Z5wFgyiBQQs8/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMyfkoqzUA2K+89eFGTMVpRCJdfXUxG8qADu3cJXVIfNa9Q0Pbv8x9d6LECHFhrWxeIPrPbp2etOJnkceJ1hiyKLQUlaJTkH/WdudgvlbiGRYFCsnmZjhCmSNTUTCVgHZUdVwrR2HV91lTDf518GXmELaht172sixacMhPps8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o29cMITa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o29cMITa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB381F000E9
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 03:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781320166;
	bh=gxoKB2uWK+QQ3B6N3Q9fcz80qSN1v1nZkDnDdt5gB54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o29cMITaWHPTagfYA7LubU6ArEICi78QHdiU5JqXuqebbqT7CXcW9mdTJu0FErqap
	 c/w1/Q8y/gxLjIGdGFU4yXiIC90nFf7oUYOdUlnnQS2nF1Uz4L343ClwfXhkw3L6Tj
	 E7M2NgItR/j73wY9mKbPNNZK4lXRSAsKxeTBNYeYh+sma73Hq4QtjftgmkqoyQywEj
	 2XURNulgMD0eqn2YETgQvTChEmVKsND1Q3EFmZ5dHf8NHohbqG3FUNbtYIIkboRFFv
	 6e3uVyQLkrhIesmlnQIKYZiZ0ZTAhpeFiHANSNLGhZFKvTl632NgzcrzrbaQpheqxH
	 ZJqj5hstRAZmw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69170548d0eso2293789a12.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 20:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8/skR4kkXUKQa8dSmPrjvdQJ1w8Y5wf5mOSboPoyShT8GS8+6hXiYF0R5+0OcMG5abP9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DuCSdG+lkBvTNbbwVH8abZ6jmq/+OPLS4ulwu1DwPcUMG9BV
	gdf+l+hRQ1cNec7fSsQu9McZUNjYglk7YMXl0eTbo3hbRVFbifuwWjt1kyqmFQlzq2S0YWsdYDn
	wrRSrjY5mamNrPgYKC+VW19zOvMPy1HM=
X-Received: by 2002:a05:6402:5384:b0:691:9832:5055 with SMTP id
 4fb4d7f45d1cf-693c6bbe399mr604578a12.28.1781320165026; Fri, 12 Jun 2026
 20:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609041407.122384-1-dongtai.guo@linux.dev>
In-Reply-To: <20260609041407.122384-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 13 Jun 2026 11:09:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76pzANGo3kx7FNNRJu+9F8XFzZ7+Qu-WE3oXO=jM1=oA@mail.gmail.com>
X-Gm-Features: AVVi8CfUS1A9itaMh0NPx1l-dx88pXs6Dti2wPZ_FTDIwF2_p8hnrwVFiMDJ4Tw
Message-ID: <CAAhV-H76pzANGo3kx7FNNRJu+9F8XFzZ7+Qu-WE3oXO=jM1=oA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] LoongArch: BPF: per-CPU addr MOV and timed may_goto
To: George Guo <dongtai.guo@linux.dev>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	WANG Xuerui <kernel@xen0n.name>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, loongarch@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu and Hengqi,

Any comments about this series?

Huacai

On Tue, Jun 9, 2026 at 12:14=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> This series enables two independent BPF JIT features on LoongArch, each
> advertised to the verifier via the corresponding bpf_jit_supports_*()
> hook:
>
> Patch 1 implements the internal-only BPF_MOV that resolves a per-CPU
> address from its per-CPU offset. LoongArch keeps the current CPU's
> per-CPU offset in $r21 (__my_cpu_offset), so the resolution is a single
> add of $r21 to the source register. This is used by verifier/JIT
> inlining (e.g. bpf_get_smp_processor_id() and per-CPU map lookups) and
> is not exposed to BPF users.
>
> Patch 2 implements arch_bpf_timed_may_goto() (in a small assembly stub
> with a custom calling convention passing the count/timestamp slot offset
> in BPF_REG_AX) and advertises it, so the verifier lowers may_goto into
> the timed, wall-clock-bounded variant instead of a fixed iteration
> counter.
>
> Tested on a LoongArch (Loongson-3A5000) QEMU/KVM guest with
> CONFIG_PAGE_SIZE_16KB and CONFIG_UNWINDER_ORC:
>  - patch 1: test_progs cpumask and percpu map cases pass;
>  - patch 2: test_progs iters (incl. the cond_break / may_goto loop
>    cases) all pass.
>
> George Guo (2):
>   LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
>   LoongArch: BPF: Add timed may_goto support
>
>  arch/loongarch/include/asm/inst.h       |  1 +
>  arch/loongarch/net/Makefile             |  2 +-
>  arch/loongarch/net/bpf_jit.c            | 27 ++++++++++++++-
>  arch/loongarch/net/bpf_timed_may_goto.S | 44 +++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S
>
> --
> 2.25.1
>
