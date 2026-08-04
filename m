Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A2433BA2
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831767; cv=none; b=OB7V9XSekKiPG5c9M0nNEjSyPpBFDV5NXUuQ0WmJ16MQ6qrMVQGCuVenXSbBBdyH3Sr0aWwzd8tWadxtxPPAUAZV+HQZUGWYOiKkjP5XzJZ8Lec7wiXaVvmNS1/Wskw+5Du71aKMdoC2B/4EO0NkmgbKRkL2+QEgn1b2tKt6cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831767; c=relaxed/simple;
	bh=2nK249j90yTlRCzoj3LfedTAQUEUeYBu2aDXtwlG5ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rzncwGoO3ReskU39a97RAkkDkXGkZ9e6SS5PbOgE+Cm52XA68kgiKQ+LD6GeCu3PAnK/V5nUfC4Ly0faj1yQz71J4u38IzVK6qCzwO8Wc9fLTexsXGlX5gdjV8unI8I32ef74z1zoaTDR4dOe/AiVYbItoM/WEIOqeEhEV9r0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akH14ou1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akH14ou1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8951C1F000E9;
	Tue,  4 Aug 2026 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785831761;
	bh=3P+o8TWdxHytX9r05AL1pLjUzakA6D+p2HhPcuxbLLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akH14ou1v8xMkLngo7Y3lJSg2N1ePGgZ6JmkYKdnzUIiGh5aF84b5/XsU6H+nBDlf
	 4QkQaInqgLysP3nPvJek9fXrUT/vbF70GXwLlludX1zrlWtyIoHpxpOFxb/YiXeaRU
	 e89zmI+vXWZwbv10JcsLliHTS637AdeZIFpp53nRH3QlQNdLtzOzx7WqD5OU9Nk3o6
	 mMLlhTtvenqMCbaE5Qtk9PJ5hPihuvxnjYIo3x3Nc3pbwSX5NdgfrvEO4aIpKlgwh/
	 7Q5lKmmwu7TluEk2bdp7m68xEmwnoM3SVrz7t/ey0yDthd1KHBf+2AxILa0/L4VZhN
	 XuWcj201uUsIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804081114.3871564-2-memxor@gmail.com>
References: <20260804081114.3871564-1-memxor@gmail.com>
 <20260804081114.3871564-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:22:41 +0000
Message-Id: <20260804082241.8951C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditionally printing the instruction count for all subprogra=
ms outputs `insns 0` for all static (non-global) subprograms, defeating the=
 stated goal of showing "where verifier work is spent".
- [Medium] The new verifier stack depth log format silently breaks the `ver=
istat` tool, causing it to fail to parse both `MAX_STACK` and `STACK` stati=
stics.
--

--- Patch [1]: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack =
depth stats ---
commit a5f11407b8ca52d1698171e4ae37a0d5f859eb2f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats
   =20
This commit updates the verifier log to print stack depth statistics
in a new format, listing the main program and each subprogram on
separate lines with their name, instruction count, and stack depth.
It also updates the BPF selftests to match the new output format.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,15 +18777,21 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> -		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			if (bpf_subprog_is_global(env, i))
> -				verbose(env, "+%d", env->subprog_info[i].insn_processed);
> -		verbose(env, "\n");
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);

[Severity: Medium]
Does this new output format break the veristat tool?

In tools/testing/selftests/bpf/veristat.c:parse_verif_log(), the tool uses=
=20
sscanf to parse the legacy format:

    if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack,
                    &s->stats[MAX_STACK]))

When presented with the new format "stack depth max %d", the %511s token
greedily matches the string "max", causing the literal " max " check to fai=
l.
This would cause sscanf to return 1, silently leaving the MAX_STACK and STA=
CK
counters unpopulated (reporting 0) for all analyzed programs.

> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D env->subprog_info[i].name;
> +
> +			if (!name || !name[0])
> +				name =3D "<unknown>";
> +			if (i =3D=3D 0)
> +				verbose(env, "prog (%s) insns %d stack %d\n", name,
> +					env->subprog_info[i].insn_processed,
> +					env->subprog_info[i].stack_depth);
> +			else
> +				verbose(env, "subprog %d (%s) insns %d stack %d\n", i, name,
> +					env->subprog_info[i].insn_processed,
> +					env->subprog_info[i].stack_depth);

[Severity: Medium]
Since the bpf_subprog_is_global(env, i) check was removed here, does this
print misleading instruction counts for static subprograms?

The verifier only calculates insn_processed for global subprograms and the
main program, as static subprograms are verified inline and their cost is
attributed to their callers. By removing the bpf_subprog_is_global() check,
are we now unconditionally outputting "insns 0" for all static (non-global)
subprograms?

> +		}
>  	}
>  	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804081114.3871=
564-1-memxor@gmail.com?part=3D1
