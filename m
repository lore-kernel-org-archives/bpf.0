Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF412426D2E
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931156; cv=none; b=q4kT46lh3UFZokuSI1TUAQzefd/Z+y6Kf9M/Wbqc656D49DrcuIRb74OXMMB/UT5VGYZSaEbsdyGo2EZ7PuO5XYN2wimg82YH7rL/XUVJ9R4xqNtH+bYAF5004Xz8FSyU9jISBWyq2o5pCXQ2gz0rPQ+soipMXUDZiMsc3i14I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931156; c=relaxed/simple;
	bh=giMBXSpu2TrZ21RYh1ZDdnsYK46/SzxBVLGj7T+WXGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leZrYMmCm3liJ9pPa5ZkhrCM4GTE5gywWf8Mpxy2iMW4Ik8apb7EhgSnzO1tP8YsCBAJ1YkAZoyJfeE71ckAp86eOz0ogSDTfgpaSRVpsOMS7TWAu85u/oY8CPlu4YAPNPZeZsrCsZzs28qfJ39zmJqghUOlv/yzUIkXo0aSEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfQ0T+xS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfQ0T+xS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B02E1F00893;
	Mon,  8 Jun 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931154;
	bh=CJLXUnxbUAzRK8HQeywLWpyUF+lQrCr8vhh1T1V/yMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PfQ0T+xSfJOm7dUpojuMEc3Qs1yossIGNOpSoqSrbu+QTitKuE3v2XMy7pB4eE/85
	 agy0vZ+bxaUoh29hkVd9+NHkzMmSqav6arRbQr+rJe+q3z+jr1hqc96+MVvqnsIxHc
	 aTghAjXFywSI1Dg55NWPSMiHhYdRSFotBaW6ImAhfAayRoQclKDV6Ka1/Asc9EAAr2
	 IPDWzkuuz4ye6JyBpQOKFvwLKGCbcBoJySTrNL0G9iLV5Xr/DDr3WHLb8eON1sMk6S
	 W6W7p5s1Wc90MovFiSj53W7Obi+Xqk7MQB8Ast7/kgdHw2uLMDtlOFx7VRWN/FY+Cw
	 y4a+ZatWXFcmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/9] libbpf: Probe percpu data feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-4-leon.hwang@linux.dev>
References: <20260608145113.65857-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:05:53 +0000
Message-Id: <20260608150554.0B02E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The feature probe `probe_kern_percpu_data` unconditionally logs a w=
arning and returns a negative error code when `bpf_map_create` fails, leadi=
ng to duplicate spurious warnings on unprivileged or older kernels.
--

commit 18fee21f57e1b2a2407c8fad87c4a91712ba5351
Author: Leon Hwang <leon.hwang@linux.dev>
Subject: libbpf: Probe percpu data feature

This commit adds a dedicated feature probe to libbpf to reliably distinguish
kernels that support global percpu data from those that do not. This allows
libbpf to make capability decisions early.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..ef9581c113035 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -620,6 +620,38 @@ static int probe_bpf_syscall_common_attrs(int token_=
fd)
>  	return probe_sys_bpf_ext();
>  }
> =20
> +static int probe_kern_percpu_data(int token_fd)
> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +		.token_fd =3D token_fd,
> +		.map_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
> +		.token_fd =3D token_fd,
> +		.prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
> +	);
> +	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
> +
> +	map =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", size=
of(int), 8, 1,
> +			     &map_opts);
> +	if (map < 0) {
> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n=
",
> +			__func__, errstr(map));
> +		return map;
> +	}

[Severity: Low]
Does this unconditional warning and negative return value cause log spam on
older kernels or for unprivileged users?

When bpf_map_create() fails, returning the negative error code causes
feat_supported() to log a second "Detection of kernel ... support failed"
warning. Returning 0 instead would correctly signal that the feature is
missing without the additional log output, similar to how other probes
handle expected failures.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D3
