Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C662BD11
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776484211; cv=none; b=ss2WFHHeSsSICQprMxptNjTKlkZHZYKldFpkDuOdtr5++/LHa6vvJr/NZOhX9yccrJQOHBxN6+eNC/9ybc1c0Sfbfiq3i5jLGYJoEe0bFK18lcIS7iAp4Y/PE4+Q66mX0QvVND95aLFbmFT/lRbn6b00yg313ERMZB5o457Lbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776484211; c=relaxed/simple;
	bh=8xPV5McpVxquorhvWCPgpNeCeQ6qGiPCzMcDT8TjsWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Twa5RN7gPEqoogX954RbFxXqPYzIbSs3IknCNgl14jK6JIsvc2iZhRXAzlEPATkqHmTFURAmAwUzZBfjEuxtCa/Pe6iou6tshxXAk6YuxJdFy8Ouc3SpaUkmyTO8vdorsxhy/bDcJJbiurOYy+6jHPauxgS5h3DdrdbrcBxuBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIUNwSuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIUNwSuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164BEC19424;
	Sat, 18 Apr 2026 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776484211;
	bh=8xPV5McpVxquorhvWCPgpNeCeQ6qGiPCzMcDT8TjsWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QIUNwSuYLFtTKZd4ajlYG0fcc1wDfqsPt2UKyOP5XHw26gv6GFJtfADluFE4VQU9f
	 TjoV2ehbUBZkwbx3aJBjptJyzhEsFfbX9fErZgxo+5z2v+elfd6YYt0aXoNsm8PN2w
	 AEmBUbg0mnmqdesriPt+uGs8+gbPWd01l/+Zv2Y/RtRGEtpCJJ5lwkv03XYlOPNxIn
	 UMym9Byp8DvLMMENs5X1h++pqKizu875jDLDyQGuIKYTzrc0f/9JnKbl/HzWP30RRj
	 1zshcNYg4vZMVDryDv9e97fSO1I587X5DfDtTHo5kpycnVNiT+r8pjzQBTrwcVGWXJ
	 cNlR8JWYUWnOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 18/28] libbpf: Add bpf_link_create support
 for tracing_multi link
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-19-jolsa@kernel.org>
References: <20260417192502.194548-19-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 03:50:10 +0000
Message-Id: <20260418035011.164BEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The patch relies on UAPI identifiers (`BPF_TRACE_FENTRY_MULTI`, `BP=
F_TRACE_FEXIT_MULTI`, `BPF_TRACE_FSESSION_MULTI` and `attr.link_create.trac=
ing_multi`) that are missing from the kernel's UAPI headers.
--

commit c0f93aeff516311471202b8e10f7e659acca62b7
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add bpf_link_create support for tracing_multi link

This commit adds bpf_link_create support for the tracing_multi link,
introducing a new tracing_multi record in struct bpf_link_create_opts.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5846de3642090..ad4c94b6758d3 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -790,6 +790,15 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;
> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attr.link_create.tracing_multi.ids =3D ptr_to_u64(OPTS_GET(opts, traci=
ng_multi.ids, 0));

Are BPF_TRACE_FENTRY_MULTI, BPF_TRACE_FEXIT_MULTI, BPF_TRACE_FSESSION_MULTI,
and attr.link_create.tracing_multi defined in the kernel's UAPI headers?

It looks like these enum variants and the tracing_multi structure within the
link_create union of union bpf_attr are missing from include/uapi/linux/bpf=
.h
and tools/include/uapi/linux/bpf.h. Attempting to use these undeclared
identifiers breaks compilation. Is there a missing patch in this series that
updates the UAPI headers?

> +		attr.link_create.tracing_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, t=
racing_multi.cookies, 0));
> +		attr.link_create.tracing_multi.cnt =3D OPTS_GET(opts, tracing_multi.cn=
t, 0);
> +		if (!OPTS_ZEROED(opts, tracing_multi))
> +			return libbpf_err(-EINVAL);
> +		break;
>  	case BPF_TRACE_RAW_TP:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-19-jolsa@kernel.org?part=3D1
