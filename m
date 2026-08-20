Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3001ACEDE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193759; cv=none; b=mXIRkI3myw684ejawwS8XUdJcmHNBG/U+XYx2RzRLpEVDiZjG8xWeFjrs4AYiWJiCcfZr2otag1+S+a1E9uKYFRHjLUqj3/R7URq9b/rRrtObz+OXxqc+fvcNlVJOEzxp7cVI48xRzeTYKAn0hAW6+RspJzyovTyNGzUU+6ZG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193759; c=relaxed/simple;
	bh=F6V+dTisQbLf+K72lqiXNub8OBb9Lh1CgranDjAH5Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jXewwO96EwwrGqeIQfNtzMFhsSLTjEJsCWoA+GjYgDWHFJWLqEtDLQ0AB96MCqKsRx/ARZDah/FYoKfLmzdhhoaULSXuFPvtQXF0K03cWeJx27jSPWE8TbRg0TlW+4BU2ImD2GawuXOqF7ILXEIm5Zlw6ZAKJY++PZNSofkhu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/SKQVyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/SKQVyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27A21F000E9;
	Thu, 20 Aug 2026 02:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787193757;
	bh=Psnb0W4LLWRuK99pCQp7wIOgzhhF0ShxX3aPRl74Yj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/SKQVynvafXeunWekcHvwO3ZKGUhCXKeIIF0tfW0yCzBDpHbw7xO0nvwVCCBIDCW
	 bf6lTJdgAYmRZoyNGbN/NuKUvq6Buz45ZFUu0ZpyCxATYtuWYm3OOwTYbqPzGsfYWz
	 U7eV+BptHi4sg/STkZGrSI0zCNqeuzIxYreAq1r2nPtWBLA+yjgpqfv49CCRpQR+1p
	 wCGxgbiTxLSEFSFFm6Z2w1gwt5/xfADx6xo1INamkbNDso68qmYqeanPf33SdXWj9v
	 DtQzIX0DgISUbTjV0RRI9kIgLszK4SDuAw+f2XaUtbI7nuKM4Cw6ba3eALnRXfMpMT
	 cCoXeKK19Y1WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: keep trampoline progs alive until image
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junseo Lim" <zirajs7@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820022831.18601-1-zirajs7@gmail.com>
References: <20260820022831.18601-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:42:37 +0000
Message-Id: <20260820024237.B27A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch restricts the `bpf_tramp_image` program reference counti=
ng fix to `CONFIG_PREEMPTION=3Dy`, leaving `CONFIG_PREEMPTION=3Dn` kernels =
vulnerable to a Use-After-Free if `bpf_trampoline_update()` fails during pr=
ogram unlinking.
--

--- Patch [1]: [PATCH bpf v2] bpf: keep trampoline progs alive until image =
release ---
commit e97f38fbbba7062b73e2785973928c70f36f1661
Author: Junseo Lim <zirajs7@gmail.com>

bpf: keep trampoline progs alive until image release

arch_prepare_bpf_trampoline() embeds program pointers in the generated
image. After bpf_trampoline_update() replaces the image,
bpf_tramp_image_put() can keep the old image executable past a normal RCU
grace period, allowing a detached non-sleepable prog to be freed before a
preempted task finishes, leading to a use-after-free. This patch keeps
image-local prog refs and drops them from bpf_tramp_image_free().

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1376,6 +1376,11 @@ struct bpf_tramp_image {
>  		struct rcu_head rcu;
>  		struct work_struct work;
>  	};
> +#ifdef CONFIG_PREEMPTION
> +	/* Programs called from this image must outlive deferred image freeing.=
 */
> +	struct bpf_prog *progs[BPF_MAX_TRAMP_LINKS];
> +	int nr_progs;
> +#endif
>  };

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -529,8 +529,36 @@ bpf_trampoline_get_progs(const struct bpf_trampoline=
 *tr, int *total, bool *ip_a
>  	return tnodes;
>  }
> =20
> +static void bpf_tramp_image_get_progs(struct bpf_tramp_image *im,
> +				      struct bpf_tramp_nodes *tnodes)
> +{
> +#ifdef CONFIG_PREEMPTION
        ^^^^

[Severity: High]
This is a pre-existing issue, but does restricting this reference counting =
to
CONFIG_PREEMPTION=3Dy leave CONFIG_PREEMPTION=3Dn kernels vulnerable to a
use-after-free if bpf_trampoline_update() fails during program unlinking?

If a user detaches a BPF tracing program, bpf_tracing_link_release() calls
__bpf_trampoline_unlink_prog(), which removes the program from the trampoli=
ne
list and calls bpf_trampoline_update().

If bpf_trampoline_update() fails (for example, due to -ENOMEM in
bpf_tramp_image_alloc()), the error is absorbed by a WARN_ON_ONCE. The link=
's
reference to the program is subsequently dropped, and the program is freed.

However, because the update failed, the old executable image remains active
and continues to execute the embedded pointers to the freed program memory.

Could the CONFIG_PREEMPTION ifdef guards be removed so that the image always
holds references to its programs, preventing the use-after-free for
CONFIG_PREEMPTION=3Dn kernels as well?

> +	int i, kind;
> +
> +	for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++)
> +		for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
> +			struct bpf_prog *prog =3D tnodes[kind].nodes[i]->link->prog;
> +
> +			bpf_prog_inc(prog);
> +			im->progs[im->nr_progs++] =3D prog;
> +		}
> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820022831.1860=
1-1-zirajs7@gmail.com?part=3D1
