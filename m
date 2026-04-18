Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26420468E
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776537306; cv=none; b=uOfIkcw8PMlpJhSBupqwX6ewM9laZXLpcVnVZRJphd1mXk6SkIQY4iWzyZ/eNtJZZm+KR3gPN6i8jH0CmEBwtHFrTuqr45VZsMDrWeX9oEAwOrctz7RdhxC5D8dtIOPoZS6NZDr31Ptxx7I4EVtHNSnPZdaVTBwW7PSzXQuCZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776537306; c=relaxed/simple;
	bh=I7fbFYeEuQ1J4OSHCoRfVvkQnW+mWyTix4J8mBzBvZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4gMEunDw7lXz7zqAC014DJefjNAGhT6qZiIm4mqC122M7xDF3pZIIuyXZRuSRWyjecjpRTBut/0LNu+9O4JPMiUgNLgpSvKE2bdszJ2RUYGVaGUzsHQWwJgYwcD/x2P5CpAZ/jHwpzTKJ9/F2rFbdEfL0sqyVulRwvQxNuwY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clZ+uB41; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clZ+uB41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C472CC19424;
	Sat, 18 Apr 2026 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776537305;
	bh=I7fbFYeEuQ1J4OSHCoRfVvkQnW+mWyTix4J8mBzBvZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=clZ+uB41wk/9dDCDnQ/swKMFZ0YynCxr7pKMQ6fXDA8fP/XPK53Vc8Tr0khMFuWY6
	 jxIakCIUCD7ZDL+lyFh6ASH9AxJARfiA32ot7HXBG+NK28bxYgHyKZ6qrDYFi0ct7O
	 QyoWkBUxiMGhtt4T76UBzBCApy9dTkmasBf71jpcyyqm+vavg81xscbEHOuFoGMUNq
	 U/shSNIPTwLJjETMIOBb2tHOGQEbE0kIoAl3C9S/z65Shle7JZ/i01aj7vhJtfrIx8
	 XvtlOHSsIvnf4tjYerpCxhqlri+kfN9WcPgqY6RDfB+zigaVn+3fYa4tAcWl2GQkVe
	 +DiCBZo8gk7Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for
 object loads
Reply-To: sashiko@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418171701.610025-4-memxor@gmail.com>
References: <20260418171701.610025-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 18:35:05 +0000
Message-Id: <20260418183505.C472CC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Valid BPF programs fail to load when a custom log buffer is too sm=
all to fit warnings.
- [High] Massive performance and memory regression for valid programs gener=
ating warnings.
- [Low] Empty debug logs are printed for every successful load without warn=
ings.
--

commit ba31f1c82128deb94a4d629517c67a68ad69c567
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

    libbpf: Request verifier warnings for object loads
   =20
    On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifier
    warnings for BPF object program loads by ORing in the warning bit.  This
    keeps the existing log_level=3D0 retry semantics for verbose logs, while
    still surfacing verifier warnings for successful loads.
   =20
    When libbpf owns the log buffer, use a small buffer for warning-only
    loads and flush captured warnings through the print callback. Detect
    support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_features,
    and document the updated kernel_log_level behavior.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d5..c7b00c0976983 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -7936,7 +7940,9 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>  			log_buf_size =3D obj->log_size;
>  			own_log_buf =3D false;
>  		} else {
> -			log_buf_size =3D max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
> +			log_buf_size =3D max(log_level =3D=3D 16 ? warn_log_buf_size :
> +					   (size_t)BPF_LOG_BUF_SIZE,
> +					   log_buf_size * 2);
>  			tmp =3D realloc(log_buf, log_buf_size);

If a valid program generates more than 4096 bytes (warn_log_buf_size) of
warnings, won't the kernel's bpf_vlog_finalize() detect the log truncation
and return -ENOSPC, causing bpf_prog_load() to fail?

[ ... ]

>  	ret =3D bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt,=
 &load_attr);
>  	if (ret >=3D 0) {
> -		if (log_level && own_log_buf) {
> +		if (log_level =3D=3D 16 && load_attr.log_true_size && own_log_buf) {
> +			pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOA=
D WARNINGS --\n",
> +				prog->name, log_buf);
> +		} else if (log_level && own_log_buf) {

If the program loads successfully and generates no warnings, load_attr.log_=
true_size
will be 0. Doesn't this skip the first check and fall through to the else-i=
f,
causing libbpf to unconditionally print an empty debug log for every succes=
sful load?

>  			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LO=
G --\n",
>  				 prog->name, log_buf);
>  		}

[ ... ]

> @@ -7981,8 +7990,8 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>  		goto out;
>  	}
> =20
> -	if (log_level =3D=3D 0) {
> -		log_level =3D 1;
> +	if (log_level =3D=3D (supports_verifier_warnings ? 16 : 0)) {
> +		log_level =3D 1 | (supports_verifier_warnings ? 16 : 0);
>  		goto retry_load;
>  	}

If the kernel returns -ENOSPC because the warnings did not fit in the buffe=
r,
we hit this retry logic and bump log_level to 17 (BPF_LOG_LEVEL1 | BPF_LOG_=
LEVEL_WARN).

If the user provided a custom log buffer (own_log_buf =3D=3D false), libbpf=
 will not
resize it before retrying. Won't the second attempt also fail with -ENOSPC,
causing a valid program to fail to load simply because its warnings didn't =
fit
the custom buffer?

Additionally, if own_log_buf =3D=3D true and we failed because the warnings=
 exceeded
the initial 4096-byte buffer, retrying with log_level =3D 17 will allocate =
a 16MB
buffer and trigger a full instruction-by-instruction verification trace. Wo=
n't
this cause a massive CPU and memory regression just to load a valid program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.6100=
25-1-memxor@gmail.com?part=3D3
