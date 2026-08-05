Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765916A395
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967341; cv=none; b=aGHhnLTJ7evN/Xy6IBrPMlC+n/mgNzug3kxCI3lfz9LBLpf/mwRC9/4dB34GUzPF/kSD249glLD16n8rxp5eomtFmEIBa5a2mdXtTciRyJCrUoKzIsj9XOrLc971wIG29yp2cvnHehkgmpNu5hP+nl6kh0Xe7Kazyp4L8dACtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967341; c=relaxed/simple;
	bh=9LX11aEW7FrZiSkwPizC0ywQrdyT8K0CZe4jU+dkh5g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F5rqfqYOMB9nFJaxEiTJyA/stRA8WMV2+xn4p6/iENM2XWrhygL+qHXeqIYSK1mkRKZO4gNQX5FczpW4sy7pnYeBZPGdvQo8nKJcGaRxvGwUI1TOa5wWbwG+SJvifP6qtPFgbs0Iv12isBmrz0PL2huB67ERuT2ys7VUlS8MaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBO8Vp4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBO8Vp4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9F1F000E9;
	Wed,  5 Aug 2026 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785967339;
	bh=yRq1m59msdU0+fFXfEWiZfTMUce/Ltha9L4Y6KCLeD0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dBO8Vp4NqnKmqTXHnKZkTTn6YJUKqGlLwongRBAEXtYVsFQi/PpWmEWRTsE4OaLwV
	 lhdUa1qinTyIwO2XyVWI45dZJwsPk3SD+1ZdvAAnwRG93BvsZSNr7NRJpCs54PSBWK
	 R3DoTYKiB9FzwmQE8+78zH8VqJByV6w3DPCWvqqEfM4QYtf9+oe4EyTqW4Izw83+y3
	 187Fm1yuOggs16pCQ2z2TCae+Pdv59b7qqcnK0f1iUN/c6XDyYXomNb/demwu3bpfl
	 ni9jYiFBbYKPIQKr6LFKG67IckjBq8sEEXB5yllQk4zHfe4m+m/2TII0NibWQOkjum
	 1VEQgzOO2ncZg==
Content-Type: multipart/mixed; boundary="===============4083969541980771719=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fb28626096ad0832ea2d3fe647c527b1b0228e3d1fb9dafe4ca39b2c07c3625a@mail.kernel.org>
In-Reply-To: <20260805210427.3218326-14-memxor@gmail.com>
References: <20260805210427.3218326-14-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 13/13] bpf: Reject tracing progs for struct_ops with arena args
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 22:02:18 +0000 (UTC)

--===============4083969541980771719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 00aaa23b4f7e..68ff66787ae1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2367,6 +2367,7 @@ static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_nodes *nodes)
>
>  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
>  			       const struct bpf_ctx_arg_aux *info, u32 cnt);
> +bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog);
>
>  #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
>  int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index b349e0817184..e07af35ed040 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -529,16 +529,6 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
>  	return tnodes;
>  }
>
> -static bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
> -{
> -	int i;
> -
> -	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
> -		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
> -			return true;
> -	return false;
> -}
> -

Moving bpf_prog_has_arena_ctx_arg() from kernel/bpf/trampoline.c (where it
was static) to kernel/bpf/verifier.c creates a link-time undefined symbol
with CONFIG_BPF_JIT=y and CONFIG_BPF_SYSCALL=n?

The two objects have different Kconfig gates in kernel/bpf/Makefile:

  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o ...
  obj-$(CONFIG_BPF_JIT) += trampoline.o

So trampoline.o can be built without verifier.o. But the trampoline still
calls bpf_prog_has_arena_ctx_arg() here:

kernel/bpf/trampoline.c:__bpf_trampoline_link_prog() {
    kind = bpf_attach_type_to_tramp(node->link->prog);
    /*
     * Arena ctx args are converted only by struct_ops indirect
     * trampolines. They must never be attached to a generic trampoline.
     */
    if (WARN_ON_ONCE(bpf_prog_has_arena_ctx_arg(node->link->prog)))
        return -ENOTSUPP;

The call is not guarded by any conditional. The function that contains it
is also non-static and exported (bpf_trampoline_link_prog() calls it from
outside any Kconfig guard).

The new prototype in include/linux/bpf.h sits outside every Kconfig block
as well (just under the _LINUX_BPF_H include guard), and there is no stub
for the !CONFIG_BPF_SYSCALL case.

arch/powerpc/configs/mpc885_ads_defconfig sets CONFIG_BPF_JIT=y and
CONFIG_NET=y (which selects BPF) but never sets CONFIG_BPF_SYSCALL, and
nothing it enables selects BPF_SYSCALL either. CONFIG_BPF_JIT only depends
on BPF and HAVE_CBPF_JIT || HAVE_EBPF_JIT; PPC selects HAVE_EBPF_JIT
unconditionally so that config is reachable.

Other cross-object calls from trampoline.c follow one of two patterns. The
other verifier.c symbol, bpf_check_attach_btf_id_multi(), is called only
inside a block that explicitly includes defined(CONFIG_BPF_SYSCALL). And
bpf_prog_inc_misses_counter(), a syscall.c symbol, is declared inside
ifdef CONFIG_BPF_SYSCALL with a static inline stub in the else.

Would it work to either add the same stub pattern for
bpf_prog_has_arena_ctx_arg() in the header, or keep it static in
trampoline.c and give verifier.c its own copy?

>  /*
>   * The arena base against which save_args() converts the arguments marked
>   * with BTF_FMODEL_ARENA_ARG. Only the struct_ops indirect trampoline

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6897b08dd010..60d1ea9a094a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18868,6 +18868,16 @@ int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
>  	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
>  }
>
> +bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
> +{
> +	int i;
> +
> +	for (i = 0; i < prog->aux->ctx_arg_info_size; i++)
> +		if (base_type(prog->aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
> +			return true;
> +	return false;
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31047716344
--===============4083969541980771719==--
