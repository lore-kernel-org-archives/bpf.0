Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCB2EBB99
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883747; cv=none; b=pjF7ZyAYjLsvCIMZ8M5YisvUEUhUWkcepv081klhvUEtz3zKWObXt1j/iGjKyVGuL7hyyZmrb59pvwT0EHkxZP4ikTkzcFTXrTB/tQ+aJAxD7ZjjefBdqU2l94X9l/tW5YslHi+OyanuHccxZzltiacswJtc7HYneKhjUy3hf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883747; c=relaxed/simple;
	bh=O8412TnJGmcUXIoNHTgTpDWwrJUy2/i49jvjkJkcieA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9IVpjdSFCDGXq/BDyKzvrgv6zJACSQNSRL89n6QFhbZ07mEa6fMpLGz0KZyPN2uodH1mU4Ux/R5bASIsEtc4DwAjC4uY6vGp/u/2Q8sijG+oO1rJlcgWy7xpiui7qdOBNckoQONtDTYai00h+6xLvaCIawf47kn6V5Az+A2GXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpreNErL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpreNErL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFB61F000E9;
	Wed, 27 May 2026 12:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883746;
	bh=+fHcIV0YXTei3+bEeh+i1JeHY9I78GjTSchfbss2hrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpreNErLh5ugpty9GZvsFpjJJk391kcMaZlfjHah4ZtU2aExz9g7XbBlGQDmjtdKY
	 rAR1oZSvUpWI/617uZmJt+Srhl1917twkXNWTtErTYDXLqF2ojGTs0txbtASPxCm0i
	 GRdz3T6Oc+QNGgDZuxAqVPU2vfXn+ZpDPueoNrkoNAdqyz2wcnj6Fathb/cgIJoHrd
	 /F9rMPfTyMtC14F5TyRzKCyleG7qqmR2PK+Ggy3ZyIg7dREDV0ZnAEhQexjDssaBJy
	 uyctU63b3RglmWO75juRC4p/snkt5lazQh7+MTF3ZUBsgasRnAKZQNWEX+Q4YaAlq1
	 rzTw6viyo6jlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 bpf-next 18/29] libbpf: Add bpf_link_create support
 for tracing_multi link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527113951.46265-19-jolsa@kernel.org>
References: <20260527113951.46265-19-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:09:05 +0000
Message-Id: <20260527120906.1EFB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references new UAPI constants and struct members that are=
 not defined in the corresponding UAPI headers.
--

commit 950db3ba53901f76f22567de80577ef3f82cd57b
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add bpf_link_create support for tracing_multi link

This commit adds bpf_link_create support for the tracing_multi link by hand=
ling
the new attach types and extracting the tracing_multi options from the user
provided bpf_link_create_opts struct.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 3cd7058023304..ff342972ca4a4 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -843,6 +843,15 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;
> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attr.link_create.tracing_multi.ids =3D ptr_to_u64(OPTS_GET(opts, traci=
ng_multi.ids, 0));

[Severity: Low]
Will this compile without the corresponding UAPI header updates?

It appears the constants BPF_TRACE_FENTRY_MULTI, BPF_TRACE_FEXIT_MULTI, and
BPF_TRACE_FSESSION_MULTI, as well as the tracing_multi struct in union
bpf_attr, are not defined in the UAPI headers included in this patch.

> +		attr.link_create.tracing_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, t=
racing_multi.cookies, 0));
> +		attr.link_create.tracing_multi.cnt =3D OPTS_GET(opts, tracing_multi.cn=
t, 0);
> +		if (!OPTS_ZEROED(opts, tracing_multi))
> +			return libbpf_err(-EINVAL);
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527113951.4626=
5-19-jolsa@kernel.org?part=3D1
