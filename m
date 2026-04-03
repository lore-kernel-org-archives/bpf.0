Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78361F8723;
	Fri,  3 Apr 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223332; cv=none; b=Fz3LGl3nIpGrDJQFkF/AJPvQQUeSZVS7iFLBfZ3VqQ6mM6hjYvYGkq3M43htAl9KyvRQf2+exK/mm1oGR87oSaX00nOY3pnTzhxfvp8KSkEq0861UoKOYDpRFZ2daBygkVwoZeN5LzIRF6dnZr3IJ2d3LEtr5DXBKVueb4eZfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223332; c=relaxed/simple;
	bh=+m61vviHi3znhV0+/7oXN95a2jWG5x88QLEM9IWK9Ho=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b7bR+llEOMfSnVSYW46gHNx1W0rz8xqwrwCsZqSGLUM5+gfDp8RfiHyv4nPWAgDM0/5GC2vlsGuFLG5nUpfRz/Ew9XlQmZ7X43kBHgfRTq8gL/knERekvc7vEUx0JfZ7XDNAuyGtfYqFpU9sAHAzcRoFWW66+C3EKYIoR9nkXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEW9Gv/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEW9Gv/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020DCC4CEF7;
	Fri,  3 Apr 2026 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223332;
	bh=+m61vviHi3znhV0+/7oXN95a2jWG5x88QLEM9IWK9Ho=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cEW9Gv/PaIM3DjTgaH4pyRzHdqjA+ROCetL6obsUVOqKvcLiIcEoPSkvpOycBPNbS
	 Ef6jf2Hl4tX3XjrcYG4fSdEu1gNSKaWFnrJR2tlTlNh6fChmE9Ihmm8QFbg/AF3eRc
	 yp2l2ns5ULbHIdwGRq5FE7apaLDopDap2JC8IiNplGnUg6a67UbVgowSu9KrSsWI5x
	 iDziF7VSEXGPHJwJLdfRVh68/rlN/w+SPxIhNPSvGD4M46rSxCFWyE91AZ7i3OocEJ
	 ssffdlmZ+si/5JMFUkRXCJOVD7b73U7ItoKdWW4SJ0lBMWveSPXar3zsg4ZKCQWX/V
	 Booy1pcz9VyCw==
Content-Type: multipart/mixed; boundary="===============5283873870887793644=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ceb1b1cdd7512c5d2bbcb01dd0699c261e077fc92c08c2319f4311f0a3012b63@mail.kernel.org>
In-Reply-To: <20260403124412.37449-4-varunrmallya@gmail.com>
References: <20260403124412.37449-4-varunrmallya@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 3/3] libbpf: Auto-upgrade kprobes to multi-kprobes when supported
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,bpf@vger.kernel.org,jolsa@kernel.org,leon.hwang@linux.dev,andrii@kernel.org,alan.maguire@oracle.com
Cc: ast@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,daniel@iogearbox.net,linux-kernel@vger.kernel.org,memxor@gmail.com,song@kernel.org,menglong8.dong@gmail.com,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 13:35:31 +0000 (UTC)

--===============5283873870887793644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bc749b9c291e..f566527d95f3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -11841,6 +11867,30 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	offset = OPTS_GET(opts, offset, 0);
>  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
>
> +	/* This provides backwards compatibility to programs using kprobe, but
> +	 * have been auto-upgraded to multi kprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> +	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {

[ ... ]

> +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI) {
> +		pr_warn("prog '%s': multi-kprobe upgrade failed (off=%lu, mode=%d); use SEC(\"kprobe.single\")\n",
> +			prog->name, offset, attach_mode);

Should this use %zu instead of %lu for offset?  It is declared as
size_t in this function, and the existing pr_warn() calls further
down use %zx for the same variable.

> +		return libbpf_err_ptr(-ENOTSUP);
> +	}

[ ... ]

> @@ -12297,14 +12347,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>  	*link = NULL;
>
>  	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> -	if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
> +	if (strcmp(prog->sec_name, "kprobe") == 0 ||
> +	    strcmp(prog->sec_name, "kretprobe") == 0 ||
> +	    strcmp(prog->sec_name, "kprobe.single") == 0 ||
> +	    strcmp(prog->sec_name, "kretprobe.single") == 0)
>  		return 0;

The comment above still only mentions SEC("kprobe") and
SEC("kretprobe").  Could it be updated to also mention the .single
variants that are now handled here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23947048141
--===============5283873870887793644==--
