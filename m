Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163101;
	b=fMf67ndHArJavPC5DeH1Bcd0qiBVC/A0IxflZ8tzIOoqt2ttZO9HaJX2bacTn98f34bp
	 nbs0w6a+tJCS/y25j+yRAAk6s1KVjV+mLfPdO0IEsOotNAQudoC9U51JP9nBWLW/Wie5R
	 tbQKL236A26qC2Kbij39yKKkBh4VSw/mSet/xsPhWKDCjaIHkfSZnccnto6IvXGHmD4y1
	 RE+HA+PTbXfB7D9XA8XTz1IOfxT3Rn2EPNBgN+QReTYsbFxaIPEWxrd5pAYJW4rIVmL3T
	 +KQslQcQw9W6LZz7QjBud7XLo6O3iMcI6RgYNkRgukpWOZGMO7Y3WO/kawZdDBy1UnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163101;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4+xFqpsKR4zwQZayVxxO2GHDFDCR+ThTFFBkFZxrhK8=;
	b=KwDYD4eGLdWIN27OTep+YpPSqmM29/nToyunmdGpCALHhyX3J/KKm/TN0sg/5cHFJlBr
	 NepeZsnQfm+vq7GTnfQnrtElvITlyxHSNWmRt22tlDC5ytrBec3efJLdR3h0nEj6klRwz
	 EgAtTSUptKffponQ+xy1vbv807lJ5AO/gYcfCzsWcpsj8IaGQu9IBTeC8/QrlMTm2J28l
	 J4IF3HcCT9fZXgWFrtat3FBxV4N5RWEDxhpnCH+Tnb+S2Vu1veFhJ3D2U6fi4Zsyu1p2/
	 9+wkVyLAGjv/r1h4gxlgp2tjhHEoNjQzwOlnFOVbDh2fMVrmtxwv6nF/fCofU6gXj/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cC27Fj7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0B606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cC27Fj7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF73A1F000C4;
	Fri, 20 Nov 2026 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163101;
	bh=4+xFqpsKR4zwQZayVxxO2GHDFDCR+ThTFFBkFZxrhK8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cC27Fj7DvrC2On1r9zDDYhTcbgUjrDRqCGgNmX11kihAbvxPmRZ5uDXvzTt4wXDXN
	 6xKlMmN1ql4a6kefM6bNJNlK5123CyORCJa1B6HLcQ0ou/rZE0q+imzHP9gPvB7xpL
	 2mu4lB1fFNMgKuuIRQq77i0vdz4DZhXmAJeDXk3581o++JUXb59Zm5xzPIDu4WtKob
	 aNMhIh2wb4twSOzd6a5eAdAZjTAJYGPAv5QVBHSu6BjmMMGTxUb6LzfkLyCuJTFQMo
	 1mMFoS6U9DVRVMPwC31xQWzunb8ZupQL9/OKH5pR1JoNYZO9/BXEkR7AiNVLdovHvM
	 yGqbGdePw3kSw==
Content-Type: multipart/mixed; boundary="===============2020791033116603703=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <591abddbb448d654d1abcbca51179f80204fb16ab365aa77823a8ffa7cc28d5a@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-17-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-17-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 16/49] bpf: Add equations and their arithmetic
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:24:59 +0000 (UTC)

--===============2020791033116603703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add equations and their arithmetic

TL;DR:
- Makefile lists equation_join.o but no such file exists in the series, so
  builds with BPF_SYSCALL may fail
- comments and needs_refine refer to missing code
- unused static helpers may warn under -Werror

> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
> +obj-$(CONFIG_BPF_SYSCALL) += equation.o equation_join.o

Is there a kernel/bpf/equation_join.c to go with this?  The commit adds only
equation.c and equation.h, so every build with CONFIG_BPF_SYSCALL=y should
stop with "No rule to make target 'kernel/bpf/equation_join.o'".

The file does not appear anywhere in the series.  A listing of kernel/bpf at
the last commit of the range (a50a112fb866) shows only equation.c and
equation.h, and the Makefile line is still there.  The header comment of
equation.c also refers to it:

>  *	join	guesses the equations, see equation_join.c

Was equation_join.c left out of the series, or should the object not be
listed until the patch that adds it?

[ ... ]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -535,6 +535,18 @@ struct bpf_func_state {
> +/* See equation.c */
> +struct bpf_equations {
[ ... ]
> +	bool normalized;	/* see normalize_equations() */
> +	bool infeasible;	/* the equations cannot hold: the program does not get here */
> +	bool needs_refine;	/* widened: the equations are not applied, see bpf_flow_next() */
> +};

The comments here point at functions that do not exist.  normalize_equations()
is added by a later commit, but bpf_flow_next() appears only in this comment
(flow.c has only bpf_flow_next_is_no_bound()), and check_equations(), named in
the equation.c header ("prune checks them, see check_equations()"), appears
only in comments.

Nothing in the series sets needs_refine to true either; the only store is
"st->equations.needs_refine = false;".  At the end of the range states.c
refers to equations only through bpf_equations_clean(), and states_equal()
calls nothing that compares them.

Should the comments and the needs_refine field match the code that exists, or
are the missing pieces meant to be part of this series?

[ ... ]

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
[ ... ]
> +static u64 low_bits(u32 bits)
[ ... ]
> +static void scalar_add_scaled(struct scalar *dst, const struct scalar *a,
> +			      const struct scalar *b, s64 coef)
[ ... ]
> +static void scalar_add_const(struct scalar *dst, u64 off)
[ ... ]
> +static void scalar_set_below(struct scalar *dst, u64 end)
[ ... ]
> +static bool refine_from_product(struct bpf_equations *eqs, struct scalar *s, s64 coef,
> +				const struct scalar *bounds)

This isn't a bug in the logic, but low_bits(), scalar_add_scaled(),
scalar_add_const(), scalar_set_below() and refine_from_product() have no
caller in this commit.  Will compiling equation.c give five "defined but not
used [-Wunused-function]" warnings, which become errors with CONFIG_WERROR=y?

The callers arrive later: scalar_add_scaled() and scalar_add_const() in
fe0262cce204 ("bpf: Keep a table of equations in each state"), low_bits()
and refine_from_product() in 969a062e4b35 ("bpf: Refine all related numbers
after a jump"), and scalar_set_below() in 0462c546cfe6 ("bpf: Make equations
from ALU, spill, fill and call insns").  Until then each intermediate commit
warns, which affects bisection under -Werror.  Could each helper be added in
the patch that first calls it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============2020791033116603703==--
