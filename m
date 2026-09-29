Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107131D47AC
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641857; cv=none; b=hMgHFrndju/OgP5UQdQoSWA9aed23XNbKd61kvL7BSepOVja4BMgpATUUeFgBKBNJt06+8IRkyZXwajTc7fsBHbxzH1XYKhRi3JgBJNN9XUOhGu0itx4vBcaOsvuo22txTC8OJbMnhVwbVNaU7P7J2XumuwXRTQtdJ/y9/YIGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641857; c=relaxed/simple;
	bh=qYekCy5qs6e0hnBfphgfljJAilanwL3o4/7yenx77EM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zt4aYwMG/1dOqWXkxbGF/+XLabQ37n+MVyEuyerFPVoV/BFFWIkwvjajmkmwi4PMiLupfDJKnV9hCCqkaWAnnv1sc5fsbVChUVYk4znQ6Snf5K+qXjp/d8BTbiiC1i9By5KAk+JpusreyCCXoXefL91sCzv6QfKlvoIFeXylB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctybmzzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctybmzzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812791F000FF;
	Tue, 29 Sep 2026 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641855;
	bh=Z1YwHccLHJNai+oEnS9re5bxgGBP6B0SQieUS/kPNsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctybmzzsHss+DXPKB2Tk9ixai1nKw2dOjBv1QNmW8txgafju9mm0k4KwXvDPYp3j6
	 xekW9jBzDWeH5i/el0kkd9ZzmIq6f8nQeu6GGrceeh+WYLnVHMHtKDhMP/eJKq8MjW
	 Fhlt01mRXN3cos4F/IPFUEDuIy2v+XnET8YVxS3HGO32t6r5jlhxtBniqVEdFcu5HP
	 Wm0aKZZt41ezG8KBNhyHalL4YKXTeZ5agWBGaf+3KGnsc07DcfwWiodLmjMuMnveg1
	 ShQECCHLIobRg2Gv162zE24fpEz3jJ0hKWIvF3llEfN3ECZgYaiVi6bwF4meoka9tt
	 wPAUz+yuf/GWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 12/22] bpf, x86: Dispatch exception cleanup
 pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929001704.3251543-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001704.3251543-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 00:30:55 +0000
Message-Id: <20260929003055.812791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: exception unwinding aborted when bpf_unwind is traced via kre=
tprobe
--

commit f3ba2238caee72a50c097a775a0290b3b66ab98b
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Dispatch exception cleanup pads at run time

This commit updates the BPF JIT on x86 to dispatch exception cleanup pads at
run time by writing directly to the return-address slot. It introduces
arch_bpf_stack_walk_ra() to support unwinding alongside the ORC unwinder.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 6c7a0578760e7..d4feade5b5c72 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -4614,6 +4628,34 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *=
cookie, u64 ip, u64 sp, u64 bp
>  #endif
>  }
> =20
> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64=
 sp, u64 bp, u64 *ra),
> +			    void *cookie)
> +{
> +#if defined(CONFIG_UNWINDER_ORC)
> +	struct unwind_state state;
> +	unsigned long addr, *ra;
> +
> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> +	     unwind_next_frame(&state)) {
> +		addr =3D unwind_get_return_address(&state);
> +		ra =3D unwind_get_return_address_ptr(&state);
> +		if (!addr || !ra)
> +			break;
> +		/*
> +		 * A traced return: the unwinder recovered @addr from under a
> +		 * function graph or kretprobe trampoline, which is what the
> +		 * slot itself still holds. Writing there would skip the
> +		 * trampoline and leave its entry for the next hooked return
> +		 * to pop.
> +		 */
> +		if (READ_ONCE_NOCHECK(*ra) !=3D addr)
> +			break;

[Severity: High]
Will this unconditionally abort the unwinder if a kernel function like
bpf_unwind() is traced via a kretprobe or function graph tracer?

When a BPF program triggers an exception, bpf_unwind() invokes
arch_bpf_stack_walk_ra(). The unwinder processes kernel frames first. If
a user has legitimately attached a tracer to bpf_unwind(), the stack return
address slot (*ra) for that frame will hold the tracer's trampoline, while
the unwinder recovers the real return address (addr).

Because this evaluates to true and breaks the loop, it seems the walk stops
completely before it even reaches the BPF frames. Could this result in a
silent failure of BPF exception handling and resource leaks (e.g., unreleas=
ed
spinlocks or memory) since the cleanup pads are never executed?

> +		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 =
*)ra))
> +			break;
> +	}
> +#endif
> +}
> +
>  void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>  			       struct bpf_prog *new, struct bpf_prog *old)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929001601.3242=
665-1-yonghong.song@linux.dev?part=3D12
