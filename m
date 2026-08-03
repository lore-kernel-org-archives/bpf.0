Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CE1946DA
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727513; cv=none; b=nZQcqE5hEcl/ZfUzD62xf0+nC/kari8OGlcSSNy6VeirseRm5kqOCgWZyEdKhR0cQttQYrY9irNIAJYWXqkzxTw2tvpt4JQWn3aMeJUkNhxcTCMPfmUWBxIcST80hEOQmj02d6SP+BZvPX0OKwdzPoOCNVNP8NYy95aJItmKnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727513; c=relaxed/simple;
	bh=pjRu2QByvJEmm/JOKvUZBjydoBgoNHwGHydFxfWIXIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qp66dnSF3NQxNcpcjgceE92efyxemu6//vKK4VOMgFI19Ra+0eDBHpEfRDUHpAQ6ep9T+WoM3x1zwnZXKdNW1taS/J5RnK6pORlMSAkdl36zNzYGHMrZ5BedgXpMVJCevSFNuSbI7Bt5P6lA8V29V5Lg040ZeIs2hcLwc8RhfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI/tJCFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI/tJCFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819A71F000E9;
	Mon,  3 Aug 2026 03:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727512;
	bh=6kWwWKTCYoQfO/QtVgNh/JPGu8QGKw7205akdILMRZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DI/tJCFmZGFCjj7gcnnU7j2K8EJvdeLrI9KHHaW0Uk774TEotW84BFxfmBkz+YOBg
	 2D2HWgAp7LVk/2OiAqhIaXCg9YxBXOZqoeaWQva/4XXvebIlvXRjw9FBytpnxniPRY
	 1ZwsHpHfi7Brgk3eWblNKlmNwjDZI9xZCybMsfYjiJZbVy4VQnKg4EBBNE/CFcCPk7
	 piTRRYwvq7Q1o07rpKFODlQrlcBtGNDT+pof9/Bl/4kTgFCgqB3uFVgJEZiAjwJuGC
	 ROdW4/MfH8FfpPfpTRGf90trl6idyFABCEgeqKKKP9J3eFZPes8C6594HCmAXhYIbI
	 WWH7d4ZZbZocA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803031457.3115812-2-memxor@gmail.com>
References: <20260803031457.3115812-1-memxor@gmail.com>
 <20260803031457.3115812-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:25:12 +0000
Message-Id: <20260803032512.819A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit changes the BPF verifier log format for stack depth b=
ut fails to update the parser in `veristat.c`, breaking its ability to pars=
e and report stack depth metrics.
--

--- Patch [1]: [PATCH bpf-next v3 1/3] bpf: Show more useful info in stack =
depth stats ---
commit f3bf67703c94a4f27f0bf29ae839e7887e984c06
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit updates the verifier log output format for stack depth statisti=
cs.
It prints the maximum stack depth and each subprogram's stack depth on
separate lines instead of a single concatenated string.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd9..cc2b4a8619ac7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);

[Severity: Medium]
Will this format change break the log parsing in veristat?

Looking at tools/testing/selftests/bpf/veristat.c:parse_verifier_log(), it
appears to still expect the old format to extract stack depth statistics:

    if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[=
MAX_STACK]))

Since the new log outputs "stack depth max %d\n", does veristat.c need to
be updated in this patch to prevent it from silently failing to extract the
metrics?

> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D subprog_name(env, i);
> +
> +			if (!name[0])
> +				name =3D "<unknown>";
> +			verbose(env, "stack depth subprog %d %s %d\n", i, name,
> +				env->subprog_info[i].stack_depth);
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803031457.3115=
812-1-memxor@gmail.com?part=3D1
