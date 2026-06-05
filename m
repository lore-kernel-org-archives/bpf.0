Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76353368A9
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641995; cv=none; b=lMc4IeUL0tSqidG8ftWP7GaILu6elH4c3zUY2D5hHqCL7KhE46dpkgy0Jw5DoGTsVJ9gt7Tcrqb4ScyZ81BwsiyafvFp41oQEkGhhAfOj+KeN6XrT7QdN59aaALcfUAGYze2vkhteMJKoAJqkK5AobAcN32OYyLjcWl9a48WSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641995; c=relaxed/simple;
	bh=azi8JCK4j+mbUzEGBzE/9doUjkKeKjjPHbgvjHla9hM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ktJFKj9vUu/rTfA19OkzoGk9qJrb4y+PnKu51kB+xdvH+IQa2A/dZqU+SFUUbX1dkyJe5NZG1oDZFv8TZ+zowpJMjuMrYLYiuHTAFjVMYPWsYinTwH4ZL2CZq7GG0eiVud5vrDxzo+0VtrPVtH4rBgsjBFJx7qjAbzopDN6fzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l85lvHJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l85lvHJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694221F00893;
	Fri,  5 Jun 2026 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641994;
	bh=qThYI9heny0MYFDkM4BtiAwPsFRjtq1MdQjwWPsl8AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l85lvHJR2GT2eMo4w4Rf/Aod6h0mXJ6wYIH1Ef1xjxYqC2DiOF//8yUPE9tTxy9fC
	 Dwcn9/nx/Z35Hn4lSWWPZcM0M744akFDFj2EA7hJHz8ngE0fIJetnbRfIy8piNT3Bb
	 MW1DOog/tesgfxY7WlaYcdhZ0EZCn3xvoNFtH6gaDiYc3wqwmUjHw+kYKVyzA3rHLZ
	 smmYJShuFQHhlkVGWRDQVvRRb/Ux0TkRxbzOZxjo/cMRfbK928gTZkwutfIrfpGtvV
	 bwQyIGsdXkAjwKOMPhuwmCd2SOCOedPV08gxiYGNPPJAurtesupyXWDc3y1bp6nRWI
	 WU4pu9liFSGXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/17] bpf: Track verifier context
 diagnostic history
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-8-memxor@gmail.com>
References: <20260605063412.974640-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:46:34 +0000
Message-Id: <20260605064634.694221F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf_diag_history_start_idx anchors context diagnostic history at=
 the innermost `enter` for nested contexts.
- [Medium] bpf_diag_history_start_idx completely suppresses context diagnos=
tic history if the `enter` event is not found.
--

commit 6cd5658b83e6758ee70970a31217f30967606ec4
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier context diagnostic history

This commit records verifier context transitions in the diagnostic history.
Later reports can then anchor causal paths to the critical section that made
an operation invalid.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 56c1236ffe7ca..7a122c5025c27 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> @@ -893,8 +930,16 @@ static int bpf_diag_history_start_idx(const struct b=
pf_verifier_state *state,
>  		    event->kind =3D=3D BPF_DIAG_HISTORY_REF_ACQUIRE &&
>  		    event->ref.ref_id =3D=3D opts->ref_id)
>  			return i - 1;
> +		if (opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
> +		    event->kind =3D=3D BPF_DIAG_HISTORY_CONTEXT &&
> +		    event->ctx.enter &&
> +		    event->ctx.kind =3D=3D opts->ctx_kind)
> +			return i - 1;

[Severity: Medium]
When traversing backwards, this loop stops at the first enter event it
encounters. For nested contexts, wouldn't this anchor the causal path at the
innermost context entry instead of the outermost entry that actually initia=
ted
the restricted region? Is an event->ctx.depth =3D=3D 1 check needed here?

>  	}
> =20
> +	if (opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_CONTEXT)
> +		return state->diag_history_cnt;
> +

[Severity: Medium]
If the original enter event has been pushed out of the fixed-size history
buffer, returning state->diag_history_cnt skips the causal path rendering
entirely.

Looking at bpf_diag_print_history(), it will see start_idx equal to
state->diag_history_cnt and the loop will execute zero times. Furthermore,
because start_idx is not 0, it will bypass the omitted event warning:

	start_idx =3D bpf_diag_history_start_idx(state, opts);
	if (state->diag_history_omitted && start_idx =3D=3D 0)
		verbose(env, "  ... %u earlier diagnostic events omitted ...

Should this fall through and return 0 instead of state->diag_history_cnt, so
the remaining events are still printed and the omitted warning is triggered?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D7
