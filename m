Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088D37206B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573756; cv=none; b=fB6M1/VF7FyiOYXqH5rlFDg22XTqxl8qy2GjI76EivLm83Ir8sp2UErPE0cHkOd95I313WMD0I2p139GzPugtF8VQkwhwj2mGNxMjRHH9MDmHjuTN2vkE6bObjaK31ztarKyLpOULiqQKIobTM3K6sNk2XwjRyH5n/mpygMQc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573756; c=relaxed/simple;
	bh=W+Ty2jr8ZdMamaTelkwneyK1xn3cjklCFGP8xZ8PNt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJrO7pHUHUkt39wGbjgoVWv/MEgxePGW/Pj6IiGNdDx3HCcRBwkAowEOaMA7FSP6HXziEZ1BcllW9s0kKJMl6OV+Z9QFd1b21/jQOEeXVjj/DRPa3qLv1O47n0x1ynHRTo0AeOeOtX2Zh+1QDXveRefp1m8o8CwlosrFwmt3pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVjKt2R0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVjKt2R0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA441F000E9;
	Wed, 12 Aug 2026 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786573751;
	bh=+DSByM12zVR4dG8duXS8tU3tgm+Rf0yvSa3WbxYvS64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVjKt2R0KXfkWEIVPDpDFmnN7YSoaeRGlmKtlAz9WiVb+iu5PZyPpvrEfZ2+kzC/9
	 HbxRIJBOvxufmDeKFKB+KHpeluQVbAqsIauE1f99Q45EsEqvYKCCjzd1z3VPuSqJOY
	 X0WMM1rlYDBtDDnVIvKpKfoWie8ZEULYlqOc4LNM2Pa7NXjBtdHYSG9+eawVWnGdo/
	 Ws+cQFfykXbMKPbBdnjll6IsGFx/LOMzhZTDZGuqKvuQxHuheEDWMQIN6+fQer5VcT
	 iKmj9Mte4Sb0QYjFZtyzwPtfMwvs4qLRzUBqewSR/MrcnstTfIw6Bo0CgN3y8ZLwJG
	 Gcj+VKxNWDUHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/6] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812221925.3358041-4-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
 <20260812221925.3358041-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 22:29:10 +0000
Message-Id: <20260812222911.3BA441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch breaks `veristat`'s ability to parse and track the BPF=
 verifier's stack depth statistics (both STACK and MAX_STACK metrics).
--

--- Patch [3]: [PATCH bpf-next v8 3/6] bpf: Show more useful info in stack =
depth stats ---
commit de454cf9ad70eafec58298c609cb8cd8aea82368
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit updates the BPF verifier statistics to report stack depth and
instruction counts separately per subprogram. It changes the log output for=
mat
to display subprogram-specific metrics more clearly, rather than appending
depths in a single line.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fced21ec23040..73d6cd563cdf8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18693,15 +18693,20 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> -		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			if (bpf_subprog_is_global(env, i))
> -				verbose(env, "+%d", env->subprog_info[i].insns_total);
> -		verbose(env, "\n");
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);

[Severity: Medium]
Does this change in output format break the veristat tool's parsing logic?

Looking at tools/testing/selftests/bpf/veristat.c:parse_verif_log():

	if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX=
_STACK])) {
		...
	}

Because the output format changed from "stack depth %d+%d... max %d\n" to
"stack depth max %d\n", sscanf() will match "%511s" to the literal string
"max". The expected literal " max " then fails to match the remainder of the
string.

This causes sscanf to return 1, leaving s->stats[MAX_STACK] untouched and
breaking the stack calculator which tries to parse "max" for integers. Shou=
ld
veristat be updated alongside this change to parse the new output format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812221925.3358=
041-1-memxor@gmail.com?part=3D3
