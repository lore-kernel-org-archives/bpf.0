Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B53914FA
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903672; cv=none; b=TXCXtwM5VKbMQXS1TVqPYyjgE62tdiV1IS1UzunnrIiKnZHWIjbvWmYpZyi1RdkwolhbKJwQD7wGuwK0e3gaed0uQPDve1RukWPO3JMlrkcAH6abaDm2xRbZ20n/c/unHxNNXXAHr0acCCJ75yLXuCPtJ4cw8u3O5WntMe4goB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903672; c=relaxed/simple;
	bh=GhLPPC6rKmK4VlnBR6QlkX+UcAj+GVuL9ZY8v2RLMPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bxb7Du945ScTS5RqJi1XHvRfHDIk/hWr1x6Vw9tdnpuovmLsIvso0tzT3fOYTjjSLROcY4ttnEMwwJnLo9bp++yU+0GjPo5/XTaDxPV7bpdZGcmT2qDOKNNap7TPdy2RkHpdCtakjaHhHo6YunrbAIfItuJZuUANVuN5uJYTcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6j8Wtzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6j8Wtzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EDA1F00A3A;
	Wed,  5 Aug 2026 04:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785903669;
	bh=DxPrFtf1X6i2/nzPtHf2qUtG8BC1z8/PvdZlUpmKkRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6j8WtzxCz9NOsJda4c2TqFNmh6Hso8Qs68vGN4iMR8ay4sVfgKnwmcBwCiqB2/Ij
	 a6t/Uh0x9UcyS6jmk4GZzKIQ/aTHGAQgYmmMyC8BFWzUe4ulr3pia47qZf/YuISa9g
	 kYSx9Rsb7YSOp4aGaVTcV3a+Mgd2en2BCSI83Wmi3UmC4DD0QyfBo+FVAj/V6kC1Pg
	 esU2In6kAvhErU4ScEMSeSVDpiBLzJDA9LQ3EWlKF+Z5SWM2ApTQ2qssYEOsOblQ8f
	 zIU1yidQlbD6OI59b2xnH40oOR2JvcMz2+opYCE2eYjt1tmdb5lVJDdMNgRpyjDwlR
	 LmYH8obdvnDIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Fix prog UAF in
 __bpf_trampoline_unlink_prog() on update failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <0e91fde8222bcfc0b318cfa2dcc3e06cc476c1a2.1785902527.git.zhuhui@kylinos.cn>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
 <0e91fde8222bcfc0b318cfa2dcc3e06cc476c1a2.1785902527.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 04:21:08 +0000
Message-Id: <20260805042109.53EDA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unaddressed Use-After-Free for BPF_TRAMP_REPLACE programs if b=
pf_arch_text_poke() fails in __bpf_trampoline_unlink_prog.
- [Medium] Dangling pointer and Denial of Service if bpf_arch_text_poke() f=
ails during BPF_TRAMP_REPLACE program attachment.
--

--- Patch [3]: [PATCH bpf-next v2 3/3] bpf: Fix prog UAF in __bpf_trampolin=
e_unlink_prog() on update failure ---
commit 58c3b5c6808d88a8686306a02c5a18f2f2dd6edf
Author: Hui Zhu <zhuhui@kylinos.cn>

bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failure

This commit fixes a use-after-free issue in __bpf_trampoline_unlink_prog()
by pinning the program to tr->cur_image when bpf_trampoline_update() fails.
This ensures the program outlives the link and prevents a use-after-free
when the image is executed.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 7fac27374ece1..6071261fd66b8 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -991,7 +991,25 @@ static int __bpf_trampoline_unlink_prog(struct bpf_t=
ramp_node *node,
>  		return err;
>  	}

[Severity: Critical]
This is a pre-existing issue, but does the BPF_TRAMP_REPLACE branch above
suffer from a similar Use-After-Free if bpf_arch_text_poke() fails?

If the text poke fails, this branch returns early and bypasses the newly
added UAF mitigation logic. Because the poke failed, the target function
still contains a live jump to the extension program's JITed code. The caller
(bpf_tracing_link_release) will log a warning and proceed to unconditionally
drop its reference to the bpf_prog, freeing it. Will this result in a
use-after-free the next time the target function is executed?

[Severity: Medium]
This is also a pre-existing issue, but is there a similar failure handling
problem during attachment in __bpf_trampoline_link_prog()?

kernel/bpf/trampoline.c:__bpf_trampoline_link_prog() {
    ...
		tr->extension_prog =3D node->link->prog;
		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
    ...
}

If bpf_arch_text_poke() fails here, tr->extension_prog remains non-NULL
but the program reference is eventually dropped, leaving a dangling pointer.
Any future attach attempts to this trampoline will hit the early
if (tr->extension_prog) check and permanently return -EBUSY. Could this lead
to a local denial of service for the affected tracing hook?

>  	bpf_trampoline_remove_prog(tr, node);
> -	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, dat=
a);
> +	err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, da=
ta);
> +	/*
> +	 * If the update above failed, tr->cur_image is unchanged, i.e. ftrace
> +	 * (or the direct jump, for the standard ops) is still actually
> +	 * calling into an image with node->link->prog's call baked into its
> +	 * machine code, even though this unlink is being reported as failed.
> +	 * Every caller of this function only WARN_ON_ONCE()'s a failure here
> +	 * and then unconditionally frees the underlying bpf_prog, which
> +	 * would be a use-after-free the next time that image is executed.
> +	 * Pin an extra reference on the prog onto tr->cur_image so it
> +	 * outlives this link, mirroring the fix applied to
> +	 * bpf_trampoline_multi_attach()/bpf_trampoline_multi_detach().
> +	 */
> +	if (err && tr->cur_image) {
> +		WARN_ON_ONCE(tr->cur_image->pinned_prog);
> +		bpf_prog_inc(node->link->prog);
> +		tr->cur_image->pinned_prog =3D node->link->prog;
> +	}
> +	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785902527.gi=
t.zhuhui@kylinos.cn?part=3D3
