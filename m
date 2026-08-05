Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5930D402
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893315; cv=none; b=FxO1vgBx+FlQfU3tcvbS5uE0vsucar1UNM7tUKi3W+k+ON2nQgBwf5QbkKS5JgQqumr0rhn96VlooNFBqXZDW9Z3py0wh+zH2h4V9gGqczVsvl+kJpBwHIlSLusuq5hmNdZizpxka4uT5OFFueQCj571iHSUmli68S7yhb6es2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893315; c=relaxed/simple;
	bh=daWObvfhs+luM1kdHIDTWClbVOGClrYyP5C8r2SjzpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LycxO0o7agOjvG7fEznTpvZHKdX0JM0s2F5XQB1hSslR2bo94HFPai1N9DflmDBO3XQ5OTGDu+Aaw9xYK3H7nWZJm4Ge9lL6DpUTGLustgwqZ303R4I2JxP4eOv/u0i6r1HzAtOhH4QLEgsPcBKTOZKKsE9E7CXL2Cdqs1SQpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEMH8qoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEMH8qoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F691F000E9;
	Wed,  5 Aug 2026 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785893313;
	bh=u6FApqjuYRUfCQIG8pZKUzV7gSIq9tMtKuDrfmb80Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEMH8qoDQE4dMuQBBWS9xNbm/EN0Zmn0vnaByBponvW1FGyMvke+fgJKg2ycKBgH/
	 4+DpD7HAg4JJl/NigvmKXu0i9zLNPrdOEfVkDgH00Nv8+W3TKNnQXSUNBnaUfpWNF9
	 0EN0q/ah2FaY+1/SSXSkuNpLX4PDwgFv5OgR8VP26Wr0mgtC+Btt5M+4zyu5PXkJ1j
	 y7Ncwo38HSPHi3uQu2ce8V87PPRe4udq8P+TrEJSSrn/3ehtgmh7buh7B+VtMDN4Ro
	 xDeNp0inOPkhkXlPD4LGETvORzPV7FY2L1+fpTo5Fw/chSl2x8/Pj29RKeY4hI8mU3
	 G7hiMj7bivR2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/6] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805011517.1717238-4-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
 <20260805011517.1717238-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:28:32 +0000
Message-Id: <20260805012833.78F691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The verifier log format change for stack depth breaks `veristat`=
's parsing of stack depth statistics.
--

--- Patch [3]: [PATCH bpf-next v6 3/6] bpf: Show more useful info in stack =
depth stats ---
commit 48703e00e6b412bacd50ea22b6dd5fcca0a7acb6
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit changes the verifier stack depth statistics format to keep
the combined maximum stack depth on its own line and print one uniform
record for each subprogram. This helps associate the statistics with
subprogram names and clarifies where verifier work is spent.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 47f3791530ded..a4ab7ee334c6b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18833,15 +18833,20 @@ static void print_verification_stats(struct bpf=
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
Does this format change break veristat's log parsing?

Looking at parse_verif_log() in tools/testing/selftests/bpf/veristat.c,
the tool relies on the older format to parse these stats:

    if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[=
MAX_STACK]))
        continue;

Because the new format is "stack depth max %d\n", the sscanf parser will
consume "max" into the %511s string buffer and fail to match the rest of
the string.

This causes the sscanf to return 1 instead of 2, and the subsequent
fallback tokenization loop fails as well. Will this cause veristat to
silently report 0 for both STACK and MAX_STACK metrics for all processed
BPF programs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805011517.1717=
238-1-memxor@gmail.com?part=3D3
