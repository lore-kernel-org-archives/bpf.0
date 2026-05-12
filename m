Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955C34844C
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630190; cv=none; b=GfJAIHCdbbKM3hGrhvM62kFxjM2Hyy4JntPiPm5nqQ+t23xEscdvPjmdWDc/xiMq3/kMNt6WEXXBWXYD3ZJyhAz5ioUTwZXBbZRLs2srNb2Lwiww7vPH5k9hguJG7CS01a4CJXQFdRduQkjQR3eWsG8OgwSqdfvcsuBLbT05sX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630190; c=relaxed/simple;
	bh=3rBZsCNW6WA5CranJlSvJlDU06HdAhbuHIW62aWZx8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LVOthJYTCQX+ECIGFk4j59UGmAzfXrRwysPbqhfcjnoOHzrz/4/qLbsCcAEDNjyPxygFEWopSxeCMzO981MeFm7H8cPzMvzZGJprYs94hMBa/uUZpYk/wS3vrCRxfN8he1+4gVqklFxnoSH9DuEwlNP+k0s9tdR43YnKqV/8JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLjIzRiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLjIzRiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CABC2BCB0;
	Tue, 12 May 2026 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630189;
	bh=3rBZsCNW6WA5CranJlSvJlDU06HdAhbuHIW62aWZx8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OLjIzRiZiECalp3IbD53RP4j/brE8UAprvTuhPtj5SSuCHs55kikIidymXLU6pQfE
	 GlCt5ukgd1GiVJBoZiAN5FIllMj+R0Lcn881AAe/bhdll2m6miLbd2q62aaqyXwzlV
	 sFfb5aPUayrPjDpSAblYlpthgMNYQcQEW0oQHyysFoxkefVvmla8DR+TSfzcCnXSHa
	 Zf+Ja2G+Hqk2Vq4AW5iC1sJ/Ei5xYOPplLZEFVoc+Gx6+J9ygHvDf/hWbWuv7xaIs8
	 QZvjZM0bxNcHesVPDjhpcVkPRcsO42TsQZ8IWzoyvDl60ie3OEb1Pw4UmKp0v6dX+v
	 FelpTaGfhdKTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 7/8] libbpf: Add syscall common attributes
 support for map_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511152817.89191-8-leon.hwang@linux.dev>
References: <20260511152817.89191-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:56:29 +0000
Message-Id: <20260512235629.C5CABC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing OPTS_VALID() validation for the nested log_opts structure =
breaks forward compatibility.
--

commit 25b6e95560edf0a2b76e5b2fc840a6200407a730
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add syscall common attributes support for map_create

This commit introduces bpf_log_opts and extends bpf_map_create_opts to
allow users to capture detailed log messages during map creation failures.
It passes these common attributes via the extended sys_bpf_ext_fd() call.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
[ ... ]
> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>  	attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL)=
);
>  	attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, 0);
> =20
> -	fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +	log_opts =3D OPTS_GET(opts, log_opts, NULL);
> +	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {

Should there be an OPTS_VALID() check for the nested log_opts structure
before we start extracting its fields?

While the parent opts structure is correctly validated with OPTS_VALID()
at the start of bpf_map_create(), log_opts is a newly introduced option
structure with its own sz field for forward and backward compatibility.

If an application compiled against a future libbpf header passes a
bpf_log_opts struct with new, non-zero fields, wouldn't this silently
ignore those fields instead of returning -EINVAL?

> +		memset(&attr_common, 0, attr_common_sz);
> +		attr_common.log_buf =3D ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
> +		attr_common.log_size =3D OPTS_GET(log_opts, size, 0);
> +		attr_common.log_level =3D OPTS_GET(log_opts, level, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511152817.8919=
1-1-leon.hwang@linux.dev?part=3D7
