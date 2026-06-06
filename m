Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456D23394D
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750369; cv=none; b=inujUm8vkJBQ/xFYsutpdGS2YOUa3+BtcAuMo7z0J1QCXVPsfEKd5r7EbLa0ueOEo8c8aUNqg9tBF7sarJ12MRe0LghADf4cMjeLgBxHH4eNJd6gYzyFxZhreNtCTmqtrOSk8WoDmsO8aaqFmDgkXlUp9bP1CCp77JCYfx4TaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750369; c=relaxed/simple;
	bh=hQEDiHwWBXyLNiR550MxwVul3zqxErG73AjIxGu5grM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gKdtZORrsiUW1VGAduYNA9PDTdVYqjq55Q3mpLkz3kTBIIS7s20Zg+2EvoyVtMuc2VT7OCVTecx/MrUJYPlEl8tYeHoQDSxtqyxocisP0Z+iKQ9nWHOjKtiqhIoPtzHjKI1qRyF6CPtL+QcuNQkOgfgUj/9dRlA9A87+Aunzneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+6QD+Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+6QD+Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95D31F00893;
	Sat,  6 Jun 2026 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780750368;
	bh=paSo0I9ygy5/xEv/qrZI+vDm8jzEtwQjcgjkxw6J1GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+6QD+SalRyyc9Sb0vCJcfsqD/ObeTNBiNfYqn+esBNSTewlR1y7ShQ+TPhtO2ag/
	 d01AJSJ9L9rj8AoR6j5GpOQ5O0+09JdNCzRm9eMv4T0bFQhP7uLwvLObFfaLOGt1+o
	 0/Qz29GCThpavosFpEsJOe2wEI9B4gCAEvKQejbRuGdrvGLyrypWJkjpQaKKoKxcDn
	 4kzpL0EpuPyoQF/jV7r+i+4hrSBAgirLsISP9h3eGcaG3yC+1m49D2zwgouM+a9I+n
	 FwNafE2fmRnjWnIyVdshLZCzd254T+9+HTiMhrms6HxEqlBZewFa7ZhzpeuyI7eypV
	 oUGfbgYfG/1Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv8 bpf-next 18/29] libbpf: Add bpf_link_create support
 for tracing_multi link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606123955.345967-19-jolsa@kernel.org>
References: <20260606123955.345967-19-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:52:47 +0000
Message-Id: <20260606125247.E95D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation Failure / Missing UAPI Dependency
--

commit a8f03a666e6225df801b64bd21fc01afe54bd463
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add bpf_link_create support for tracing_multi link
   =20
Adding bpf_link_create support for tracing_multi link with
new tracing_multi record in struct bpf_link_create_opts.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index bc513aa8f4041..f37e3416f61a5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -845,6 +845,15 @@ int bpf_link_create(int prog_fd, int target_fd,
>  		if (!OPTS_ZEROED(opts, uprobe_multi))
>  			return libbpf_err(-EINVAL);
>  		break;
> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attr.link_create.tracing_multi.ids =3D ptr_to_u64(OPTS_GET(opts, traci=
ng_multi.ids, 0));

[Severity: Low]
Are the UAPI definitions for BPF_TRACE_FENTRY_MULTI, BPF_TRACE_FEXIT_MULTI,
and BPF_TRACE_FSESSION_MULTI missing from this patch?

It looks like this code references these constants, as well as the
tracing_multi member in union bpf_attr, but they are not defined in the
corresponding UAPI header (tools/include/uapi/linux/bpf.h). Will this cause
an immediate compilation failure due to undeclared identifiers and missing
struct members?

> +		attr.link_create.tracing_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, t=
racing_multi.cookies, 0));
> +		attr.link_create.tracing_multi.cnt =3D OPTS_GET(opts, tracing_multi.cn=
t, 0);
> +		if (!OPTS_ZEROED(opts, tracing_multi))
> +			return libbpf_err(-EINVAL);
> +		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606123955.3459=
67-19-jolsa@kernel.org?part=3D1
