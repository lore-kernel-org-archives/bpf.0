Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AB3F4DD0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641941; cv=none; b=rit9TI+6KVqDLZxqz3TnKSJ6Ds651KW4HB+RKr45gxgSFph7ia/QeACEa+BcSsSNpR+LvBBpq5zGljUPqDI/pu7jBL6dP93E02XSJfe5zeZC9isOAI/Ct29YXVCETO3xKP4fxhPUNxBfMJp5eGJEkRlf1wSAz0p5XOkUemvMee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641941; c=relaxed/simple;
	bh=YWxjsoHIxax3hfzSBFpyrigcbibKtsdTb/2OwdZ3BTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKKs7FGR9/py8KceyfYhqtewAgEL/5FtYOgTRbfXzARE8uFnlpWPhJTPRIPTMrRAbEf86eNhNjNMeDRrOz1jatU8HdRJB3YTiZ1F0QTU/EoF9jVVgRFGIJGTJyXEz3+D5I74s4iyoNqor5uYH/y+CG/BpUKwzJ00segixqkpy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/s1oRW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/s1oRW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F51F00893;
	Fri,  5 Jun 2026 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641937;
	bh=qiTlsLc1uOKMzttCe0vei+03rg0Z57WJ7Nr4gHM4eM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/s1oRW4SMkrgfGEYXqtwCM2eDlvcdTkzZ7ymgfy1gDE0DSMC0u6XfsMJUPQkgyhy
	 /svg/D17ci2AbHjA00ic6yCC0lx/tTvQ/zwR6y94k3XaqEVNfkNFtcRd6N4FX8fujt
	 UUtNsxnSD6Yw0jNGrPH/8ZC55HXZq9GsNfV6EgfGz1rFvo6mDf2U8Kn4ZF6Lh/iepy
	 pOCtf4TmrgWY3WvtvRH3dB7OaHEvLegI2uzbh9mkcK9yZN/Q617WeX3DEvx33j8p3P
	 zxp+QwzJ2+8uFFYGpsKG2zVMZfe3r8FAMmrdTvWJJMyQXaxvXYNv9Po2XmmZqpJvUa
	 ZPk2tOPuO4npw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 10/17] bpf: Report Resource Lifetime
 reference leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-11-memxor@gmail.com>
References: <20260605063412.974640-11-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:45:36 +0000
Message-Id: <20260605064536.DE3F51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect indentation of `bpf_diag_report_resource_state` calls ins=
ide `process_irq_flag`.
--

commit 55651d7f9fb67183b2ac504e84a853783f31d0f3
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Resource Lifetime reference leaks

This commit augments the verifier's reference leak detection by adding a
Resource Lifetime Safety report when a reference is still live at program
exit or throw time. It also adds detailed diagnostic reporting for invalid
resource states involving dynptrs, IRQ flags, spin locks, and iterators.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e9c121892b7e5..1c26614bec2b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11576,6 +11665,11 @@ static int process_irq_flag(struct bpf_verifier_=
env *env, struct bpf_reg_state *
>  		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
>  			verbose(env, "expected uninitialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> +				bpf_diag_report_resource_state(env, env->insn_idx,
> +							       "IRQ flag is already initialized",
> +							       "Saving IRQ state requires an uninitialized stack slot for=
 the IRQ flag, but this slot already contains tracked IRQ flag "
> +							       "state.",
> +							       "Use a fresh stack slot for this save operation, or restor=
e the existing IRQ flag before reusing the slot.");

[Severity: Low]
This isn't a bug, but it looks like there's an extra level of indentation
added to the bpf_diag_report_resource_state() call here. Should this be
adjusted to align with the verbose() call above it?

>  			return -EINVAL;
>  		}
> =20
> @@ -11592,6 +11686,10 @@ static int process_irq_flag(struct bpf_verifier_=
env *env, struct bpf_reg_state *
>  		if (err) {
>  			verbose(env, "expected an initialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> +				bpf_diag_report_resource_state(env, env->insn_idx,
> +							       "uninitialized IRQ flag restore",
> +							       "Restoring IRQ state requires a stack slot that was initia=
lized by a matching IRQ save operation on this path.",
> +							       "Pass the same stack slot that was previously initialized =
by the matching IRQ save kfunc.");

[Severity: Low]
This isn't a bug, but this call also appears to have an extra level of
indentation.

>  			return err;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D10
