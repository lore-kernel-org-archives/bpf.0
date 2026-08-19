Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6973CFF4F
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120443; cv=none; b=PeRvj7QK1L6ZMdyUI/WREiGcrpy46Ts3AAhcHZWADmXfivZc7P/w5x1abGO+adiTxgxESnpBquXLnYAwgev6DRlK/OoRrT7GnLRPmzlBXfABO7Ly8O++P5QOQ7usJ5i+Db8YgcCSX268GEHlLQeRwRUs7d/ZF5btxA1xv7bWg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120443; c=relaxed/simple;
	bh=WrgcCsQMJvx8n3OBfWeDHIC+bQlZDRvBi9Q8u0PUb88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqhO/FLCyYho8FUL+yNVLS68BGNo2NUZtyTEyRcQngi4nP5qqIoSNSdTew28bumCxw9x/VNPNs4LTy84pEVRI9x5JcVCSl0feaICAEkjy/4+Kb/DTs/Y89u+t1fQKvuFPipK79Zao6A/1hzk8qmzrEnJNg5kfNkI1UqKf/ZiooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqdDB8d3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqdDB8d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D41F000E9;
	Wed, 19 Aug 2026 06:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787120441;
	bh=JQOjzCYs8dfH6whXCdOzI0KNQvZN188OJgPDAXfQPAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqdDB8d3qPN1nDFUSCQ4GblKavG0WKTBQPTjcBo0jce6xV3bJcdsEzKcZKBVHu1uR
	 b/foqos8zLCqg8jvLQMFiBX8lSpkqgmk91+Nt47G/zKomXo+oIQVfF4Z7AhNTBYVo4
	 b9Op+QPSZ7+bl+uiUWEqObWle5y7R3w/QrXjzYDts1RehwWtYRwamY9XgTL4/DDTBF
	 QcG66hyfVFfoXGpGQYQHyavSQnUaP8CgSooGCPOEcXpqxFWjfktFMW2/NB54QldHe8
	 oRMkm0Nxm/WUk9ZuPanMOrq1IWTlhyittOONb88GUmRXktR6K2VQjBWchJ8u74Dh0e
	 SUFG3TtGseewA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair
 returns in live register analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819055304.3296353-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055304.3296353-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:20:41 +0000
Message-Id: <20260819062041.B92D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The verifier fails to properly model execution for BPF subprograms=
 and kfuncs returning >8 bytes (register pairs), specifically by not restor=
ing R2 to the caller and not verifying R2 initialization.
--

--- Patch [5]: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair r=
eturns in live register analysis ---
commit 1cab80ee79c6b836ae7862851a98688dd786f8f2
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Account R2 of register-pair returns in live register analysis

This commit modifies live register analysis to mark R2 as read at BPF_EXIT
when a subprogram returns a register pair, such as an __int128. This
prevents a callee's R2 from being considered dead and incorrectly pruned
from checkpointed states.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 74fc4b3f80d6e..71f998c6eb888 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
>  			break;
>  		case BPF_EXIT:
>  			def =3D 0;
> -			use =3D r0;
> +			use =3D ret_reg_pair ? (r0 | r2) : r0;

[Severity: High]
Does the verifier also need to be updated to properly model execution for
BPF subprograms and kfuncs returning > 8 bytes?

While this patch handles the liveness side, it looks like
kernel/bpf/verifier.c only copies or initializes BPF_REG_0 (and not
BPF_REG_2) to the caller's state in several places.

In prepare_func_exit():

		/* return to the caller whatever r0 had in the callee */
		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
		caller->regs[BPF_REG_0] =3D *r0;

In check_func_call():

		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
		if (!returns_void) {
			mark_reg_unknown(env, caller->regs, BPF_REG_0);
			bpf_diag_mod_end(env);
		}

In check_kfunc_call():

	if (btf_type_is_scalar(t)) {
		mark_reg_unknown(env, regs, BPF_REG_0);

And in check_global_subprog_return_code():

	if (subprog_returns_void(env, subprog))
		return 0;

	return check_global_ret_scalar_reg(env, BPF_REG_0);

If a program attempts to read the upper half (R2) of a 16-byte return value,
will it be rejected by the verifier with an R2 !read_ok error?

Additionally, for global subprograms returning 16-byte types, could the lack
of R2 initialization checks allow uninitialized memory to be passed back to
the kernel?

>  			break;
>  		case BPF_CALL:
>  			def =3D ALL_CALLER_SAVED_REGS;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055239.3293=
449-1-yonghong.song@linux.dev?part=3D5
