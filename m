Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974E36197E
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711877; cv=none; b=paZSNwAnEfaQK6jSGVJwQYr+Rbx9r4X/I1+msOoJE/0k7b/f+kvpaijfL6CAWaHGM18vMyjBzvWwk4egK/1jkdapmO72kJurZn3MH5hSToRLN8Q6+Jje+Lxe3a3C66hHYsx9+tuwbEuxnU6qEMvxXv5RpN/AGi4QJQe4W32CGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711877; c=relaxed/simple;
	bh=eDqF/h53kRd+tZTGxiip0s+ptuZBdnje6CFk3nfee+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E3l1XNFW1UjqgD1Rb42O/CQRzrGdh1yFXtC173vB6VGdnQdeOUl5n/xiA9kc5675hyBHF/ZqDdOPmtRv3s+tqunG0OcwUihGnq2V8DbydCG8rQpTG1y7tSZD+6ZsNqRI1QbphV1xlQW0Y1Zq0FbGOwaD0/3Ew45EzFuR9FhNZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxgn2SCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxgn2SCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4331F000E9;
	Sun,  2 Aug 2026 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785711875;
	bh=+TIqK+g+Pze5fKGEm87ozbBUs5Jnka0E1HaKal91WsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hxgn2SCUuaEyu8RZnvY266VKUuzup9aNDQuhTDu8Vb4jsYiiYqXlKYNgi6g9iy7TE
	 XCeE2g2tHbj/T98KtVi+T7lEAJzy8CD61qBJrLVi7RPvzsELXP45jlpCIy4sRZM0Mr
	 qynOn/XsCG3EXJZm9x5EZ2j4IphxGmA8V0QF6IPaQKrNd5x5d0/XUs+5p2TpAO/v0J
	 GdDhfapNry7IWFcvCuNM7tRtuIKaLcImxtK5Fmg/N1Cul+GBGHVXXGoXVtQVpjngPw
	 rEF3GiMsvQn9DbT2Im6V0QvhAQbNmL8+wnp6UCWs2V4dO1zZzs8xklomxfj9EKtc4X
	 1xr7x1u8ytp2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260802225209.2511758-2-memxor@gmail.com>
References: <20260802225209.2511758-1-memxor@gmail.com>
 <20260802225209.2511758-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 23:04:34 +0000
Message-Id: <20260802230435.7F4331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit changes the verifier's 'stack depth' log format from =
a single-line format (`stack depth %d+%d...+%d max %d`) to a multi-line for=
mat (`stack depth max %d` followed by per-subprogram lines). However, it fa=
ils to update the `veristat` tool in the BPF selftests, which relies on par=
sing the old format to collect stack depth statistics. When `veristat` atte=
mpts to parse the new verifier log, the hardcoded `sscanf` string (`"stack =
depth %511s max %ld"`) matches only the first word (`"max"`) but fails on t=
he rest, leading to broken and unpopulated `STACK` and `MAX_STACK` metrics.
--

--- Patch [1]: [PATCH bpf-next v2 1/3] bpf: Show more useful info in stack =
depth stats ---
commit f4a761d5dad941fea12558fab4093ec6ef3e52da
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit updates the BPF verifier's stack depth statistics logging to pr=
int
the maximum stack depth and each subprogram's stack depth on separate lines.
It also updates various selftests to match the new output format.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e6f35f4e715b6..74a92036d84e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18703,10 +18703,15 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D env->subprog_info[i].name;
> +
> +			if (!name || !name[0])
> +				name =3D "<unknown>";
> +			verbose(env, "stack depth subprog %d %s %d\n", i, name,
> +				env->subprog_info[i].stack_depth);
> +		}

[Severity: Medium]
Will this break the veristat tool's ability to collect stack depth statisti=
cs?

Looking at parse_verif_log() in tools/testing/selftests/bpf/veristat.c, the=
=20
parser still expects the old single-line format:

    if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[=
MAX_STACK]))
        continue;
   =20
    while ((token =3D strtok_r(cnt++ ? NULL : stack, "+", &state))) {
        if (sscanf(token, "%d", &sub_stack) =3D=3D 0)
            break;
        s->stats[STACK] +=3D sub_stack;
    }

With the new multi-line format emitted here, it appears this parsing logic=
=20
will silently fail to extract the stack depth numbers, leaving the STACK an=
d=20
MAX_STACK metrics unpopulated when comparing regressions. Does veristat.c=20
need to be updated to match the new verifier output format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802225209.2511=
758-1-memxor@gmail.com?part=3D1
