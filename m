Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C7175A6E
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543656; cv=none; b=tDL3fZm9u5bwEG/mh7/i7QtUuDxubBpQxxOTlAT1s+rq0BaRswXi1+4uIV4Gx9s6yn3CmUCujtKxG18Q2duYMM042zeDN20/DvBfKmVx31d2M/C4ctfLofDP1Qf7YZq1CNuasG0nf11qv/CsolGLSvBqrNKCGwGfv7OJeBw/5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543656; c=relaxed/simple;
	bh=6R+mNdRdQDwNdQL61vONWr/MZDU2YjM54LOOjAXswnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dGwFmop6Pm9HaUze9/qlRQkzctw6Tin04F5PJHmb43T3J8FuUFQl7Sj+lJB7GCd8IRaDRpEjui2peERzhTIKiSAyZnz0XNvbEPP7u+FszZ09Du6jKoXJ419ZsvYm40bbguy9w7gFhEdE7hIphDtzkTLPajoFgjaR/td9QEhSGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krHYWHA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krHYWHA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D01F00893;
	Thu,  4 Jun 2026 03:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780543655;
	bh=AbDDYl5nwg6L0GcrfGE9ddbp2QHJRRZfCUnwYK2G8es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krHYWHA5V8Rez/Kff3cDb9azGAH83IxNa5+CwpuV0bTlHId7SV/NCNYpGFIst3+wG
	 uQh+14qszMfB0jw//Pgs5G4c+16zQxkgXLEpw9gaPNiXOdUxqXBphk4W92wHwmVRps
	 AzB315FArxaDyhkmG88NEpAsGE1tnDPZS4kLPov28EceHJfx87bLeO09usLi5TbTkI
	 RSbNPMGjEfJAoxofmq4Q+D82Hh1aB8h2dw+E4DG/FvSZ4bY/jUZc2PuUeRak8tQbDW
	 IDPt7szQBIB3afpwEDv2bXHaJJqxH8JQJaB7/BqHYZaN5dPiyE28Jb1PcJY/5CuyMf
	 U2Q0UsxMlhidg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: fix feature probe failures for
 implicit BPF tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604031033.806727-4-chenyuan_fl@163.com>
References: <20260604031033.806727-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 03:27:34 +0000
Message-Id: <20260604032734.CE0D01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Modifying `probe_fd()` to return negative error codes breaks featu=
re sanitization by forcibly overriding missing features to `FEAT_SUPPORTED`=
 if a BPF token is present.
- [Medium] `probe_fd()` returns a literal `-1` from direct syscall wrappers=
, causing `feat_supported()` to always report `-EPERM` and mask the true er=
ror code.
- [Medium] Missing curly braces in the BPF token rescue logic causes uncond=
itional warning spam for all probe failures.
- [Medium] Several feature probes return `0` instead of propagating negativ=
e error codes on failure, silently bypassing the new BPF token rescue mecha=
nism.
--

commit 0eceda08312936da19e1be0b6d87937f64f2f067
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: libbpf: fix feature probe failures for implicit BPF tokens

This commit modifies probe_fd() to return negative values instead of 0 on
failure. It also updates feat_supported() to mark features as supported if a
BPF token is present and the probe returns a negative error.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..f934452e52f01 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -16,7 +16,14 @@ int probe_fd(int fd)
>  {
>  	if (fd >=3D 0)
>  		close(fd);
> -	return fd >=3D 0;
> +	/* Return 1 on success, negative error on failure, so
> +	 * feat_supported() can distinguish probe errors from
> +	 * genuine feature absence.  When a BPF token is present,
> +	 * a negative return triggers the rescue path that marks
> +	 * the feature as SUPPORTED (token creation itself proves
> +	 * the kernel BPF subsystem works).
> +	 */
> +	return fd >=3D 0 ? 1 : fd;

[Severity: Medium]
Does this return a literal -1 instead of the actual error code?

Several feature probes use internal direct syscall wrappers like
sys_bpf_prog_load() which return -1 on failure and leave the real error in
errno:

tools/lib/bpf/features.c:probe_kern_prog_name() {
    ...
	ret =3D sys_bpf_prog_load(&attr, attr_sz, PROG_LOAD_ATTEMPTS);
	return probe_fd(ret);
}

Since probe_fd() returns this -1 unmodified instead of -errno,
feat_supported() will pass -1 to errstr(). Because -1 equals -EPERM, does
this cause the error string to unconditionally resolve to "Operation not
permitted" and mask the true reason for the probe failure (like -EINVAL)?

[ ... ]

> @@ -725,9 +732,21 @@ bool feat_supported(struct kern_feature_cache *cache=
, enum kern_feature_id feat_
>  		} else if (ret =3D=3D 0) {
>  			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		} else {
> +			/*
> +			 * A BPF token may restrict which program/map types
> +			 * are permitted, causing the probe to fail even
> +			 * though the kernel supports the feature.  When a
> +			 * token is present the probe is best-effort: BPF
> +			 * token creation itself proves the kernel has a
> +			 * working BPF subsystem.  Real BPF issues will be
> +			 * caught during actual program/map loading.
> +			 */
> +			if (cache->token_fd)
> +				WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);

[Severity: High]
Will this forcefully override genuine missing features to FEAT_SUPPORTED if
a token is present?

By returning < 0 from probe_fd(), genuine feature absences now fall into th=
is
error-handling path. If a newer BPF feature is missing on an older kernel
that supports tokens, libbpf might incorrectly mark it as supported and skip
essential sanitizations (like stripping unsupported BTF tags). Does this
bypass the fallback logic and cause the final program load to fatally fail?

[Severity: Medium]
Are there existing probes that still return 0 on failure and bypass this
rescue mechanism?

For instance, probe_prog_bind_map() returns 0 if bpf_prog_load() fails:

tools/lib/bpf/features.c:probe_prog_bind_map() {
    ...
	prog =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,
                         insn_cnt, &prog_opts);
	if (prog < 0) {
		close(map);
		return 0;
	}
    ...
}

Since these functions were not updated to propagate negative error codes, t=
hey
evaluate via the else if (ret =3D=3D 0) branch and are immediately marked as
FEAT_MISSING. Does this leave unprivileged BPF token support broken for the=
se
specific features?

> +			else
> +				WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  			pr_warn("Detection of kernel %s support failed: %s\n",
>  				feat->desc, errstr(ret));

[Severity: Medium]
Is the else block missing curly braces?

Without curly braces around the else block, the pr_warn() call executes
unconditionally for any negative return value. Combined with probe_fd() now
returning < 0 for all missing features, will this loudly spam warnings to t=
he
console for normal feature absence checks?

> -			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604031033.8067=
27-1-chenyuan_fl@163.com?part=3D3
