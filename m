Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BC47012F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576499; cv=none; b=TMY8KCaS3k1g+f39jPZEaDy+IQ61KivwvxB2PPeb0Y0bTSadQjH2FQB0LxHylSI28coUSfXwDEPefDAfG9QF6VMilNc9aeyKLksCWKAfUfIFg0N735YARQAhnY0Uw+1+8TCqWAQNOgEhjY/oN+JlV7gCCC+JdKb6uStEBO0PEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576499; c=relaxed/simple;
	bh=z2Z2WX+SFFt4qVFtaKGf39X3Ncb4z5uS6dVDXEJt7L8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EkCGGVka+dIFZI567ZbPrAJgL1I5Yekv5ygtXNiWvU4AS229ZMAhOp4aiQil8iMuUtkwnktHDJ+qtq+915H1aMF5r5ENFbsZYPWWPrxhfi6jfeZS6pFRzYwo8BqduQlXP48Mxsc5Q9pUe7FEzuO5Wyx2rJ/5A1aFPo1NK5oYPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/dC4zcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/dC4zcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881A71F00A3A;
	Wed, 12 Aug 2026 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576498;
	bh=yi7gaG6LP48JZLRBYsXbYi3flST5EOxDDsudMKlbtgg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T/dC4zcZKDVMmsNndUlIx4vI+inhGpTL41NrA3tkvzScd2dEY3Kr+BLJXBumy5doi
	 Jp88kHlJ2MVIXNjB6KydU0x13sYIA8YZmDNcLqwLW6TL0iNy+rz4LmlPah4OtDzchl
	 Gejg5gI1ZQlpTPDP1rHzcvtsl9PxDIqksfkUfCZxJn3XHVgvwQkF3x1dwDaEzBrXPn
	 blmozUScZbqdvAZX6Dx36YUM4TyZZDo+jH7MvTj73JyRcAeR/LAcx8hrOXN5CduE5c
	 9Ws1zGpTryGfEPOmW8hbu/HVYjg1Ic30cQ7AO2jKmJMOR/nN5Q7OpvOhxx1v6rRF7W
	 a2BlWb7wLi8nw==
Content-Type: multipart/mixed; boundary="===============0278925294878981673=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7ea8322f15904bbd6ba6d9bb900f3e0aa08346bd8b0f14d6910fd7059ad17c6b@mail.kernel.org>
In-Reply-To: <20260812221925.3358041-5-memxor@gmail.com>
References: <20260812221925.3358041-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v8 4/6] selftests/bpf: Adjust veristat stack depth parsing
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 23:14:57 +0000 (UTC)

--===============0278925294878981673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index c9c257784ee3d..5c0ec3edce720 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

[ ... ]

> @@ -1025,11 +1027,24 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
>  			&s->stats[MARK_READ_MAX_LEN]))
>  		continue;
>
> +	/*
> +	 * New kernels emit one "subprog <id> (<name>) <kind>" record
> +	 * per subprogram with the stack depth at the end, while old
> +	 * kernels emit a single "stack depth <a+...+n> max <max>"
> +	 * line. Match both formats so veristat works against either
> +	 * kernel.
> +	 */
> +	if (sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]) == 1)
> +		continue;
> +	if (sscanf(cur, "subprog %*d %*s %*s insns_self %*d insns_total %*d stack %ld", &sub_stack) == 1) {

This isn't a bug, but would it read better to keep the same N == sscanf(...)
form as the neighbouring checks in this loop, so the block stays consistent?

The pre-existing checks just above use:

   if (1 == sscanf(cur, "verification time %ld usec\n", ...))

   if (5 == sscanf(cur, "processed %ld insns (limit %*d) ...

and the legacy check just below uses:

   if (2 == sscanf(cur, "stack depth %511s max %ld", ...

so the new checks alternate the comparison direction within about fifteen
lines.

> +		s->stats[STACK] += sub_stack;
> +		continue;
> +	}
>  	if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
>  		continue;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31647029137
--===============0278925294878981673==--
