Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5F30567B
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486461; cv=none; b=dT1JUo8J8IbDapVflnJR3JmgLLitj4xYV53OFWml3jwCqGA6hfna/hOtk21Ayo6WVvGf1EwlSZdSy/ks53eMV+BFzcR10/Ix48nsxJlPo7cpp9+4c+xD3bUrxuwXF78FD8CSo3bLZw/DQo984zP/ohLDhV1XzOhFgmltnuBJ/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486461; c=relaxed/simple;
	bh=QmrJEV6P5HPO7o0DXn+khEI3yOeXc4/HciP5rg3kaxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uky8GL/dhvTDfQNosPqNd1Ha/DOV7MNFWwcKUxFSbUYTGuUeEADyiIIJ1uve1buKFlv53QqO5tqhhg0pB32FOCLjtOeeFpfWURjNYtXgu3D8irgD5noX+UKlk9gbxo+ARFr7ZX5cKq4IKE7NJFNWKrc0Y+C27SlEwu2TmyzSHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+MzYvbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+MzYvbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D927B1F00893;
	Wed,  3 Jun 2026 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486460;
	bh=RPmR/PTdpKrtCEQ70poTLVWjCtBXLsJdpdDFDbcwsMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+MzYvbx4FE5dxR1Umb+BPYpteEBD0QQ23ptlm1N04OlaJ9opuMQm8p8gIEq3ZWO5
	 PwDV08Sz9juYeK29EZEt58gvH2ZrSrhxLNw6zsDkxE1cL1O8svTkk4YaJtdUi5HmPL
	 U7o7ajMo7CxaVwhRMYhObkQnru3A3pCXSOgf5YTZ/NuSiT/EQYZ+28riTtX0DTsm3/
	 HnUWEJT7hfLRahBQenyoaW3O3JZyV39Te3BSdEwyn5oC6Vnes8dLVc7KQ1yVQ2fLEP
	 08Q/FNR30OjYU+ALfy9Fs6nlt+BAtbdFSoH9Pyz62Uv7KFIjjdMNCHPPFiO/Gi8Qwm
	 e5OqcaEMBDPAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 18/29] libbpf: Add bpf_link_create support
 for tracing_multi link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-19-jolsa@kernel.org>
References: <20260603110554.29590-19-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:34:19 +0000
Message-Id: <20260603113419.D927B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references undefined UAPI constants and struct fields, ca=
using a build failure.
--

commit dfbf332632be62321ec615d0d0c35a8d46309172
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add bpf_link_create support for tracing_multi link

This commit adds support for the tracing_multi link in bpf_link_create().
It introduces the tracing_multi record to struct bpf_link_create_opts and
maps these new options to the bpf_attr union for the sys_bpf syscall.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index bc513aa8f4041..f37e3416f61a5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
[ ... ]
> @@ -845,6 +845,15 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;
> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attr.link_create.tracing_multi.ids =3D ptr_to_u64(OPTS_GET(opts, traci=
ng_multi.ids, 0));
> +		attr.link_create.tracing_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, t=
racing_multi.cookies, 0));
> +		attr.link_create.tracing_multi.cnt =3D OPTS_GET(opts, tracing_multi.cn=
t, 0);

[Severity: Low]
Are the UAPI constants (BPF_TRACE_FENTRY_MULTI, etc.) and the tracing_multi
struct within union bpf_attr defined at this point in the tree?

It appears this patch relies on UAPI additions to linux/bpf.h that are
missing from this specific commit. This causes a build failure in
tools/lib/bpf/bpf.c due to undeclared identifiers.

Should this commit include the UAPI header updates, or be reordered after
the corresponding kernel patch to prevent breaking git bisect?

> +		if (!OPTS_ZEROED(opts, tracing_multi))
> +			return libbpf_err(-EINVAL);
> +		break;
>  	case BPF_TRACE_RAW_TP:
>  	case BPF_TRACE_FENTRY:
>  	case BPF_TRACE_FEXIT:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-19-jolsa@kernel.org?part=3D1
