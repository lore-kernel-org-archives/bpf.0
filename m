Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26422A4EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538661; cv=none; b=lKkLAuuy102hVWsolmVYsVpx8B07auSJ8GxICK7iGap8Uz6+7UJ/Pt4uHOkwr2ErCQXUmDy3B0xTNh5hC9XpimFitFIlOi1CymOwDuGYQoqjG3l7QcGVXUAuRZMHjzih4TKxxFKxg3vQ8m44CB4b+ZFCTQ2+BbiUm+S3D2JGGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538661; c=relaxed/simple;
	bh=TLR+Msr9G5s8DBlo7kC6Nq9guSNhZagcUgnASVVCbUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XyKq5XDdIFDgwDoEvw4mmWtp02W3DOO++T6m3y9rbG9nVob3XYtoe0Po4e7qvciCaH7ZMoAyTnIahE3MPu7ZbhLan+VT0vQcAdFSvr2S5bKP49iAkBRHUgT2p3gI+9iSnWV7VW7PWc4EWaC3b0vp3ze/ywEe3b2xMEuAwimFCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZnnA9Oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZnnA9Oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2D31F000FF;
	Sun, 27 Sep 2026 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538660;
	bh=WTqDAnadZH6vQXA+0rlKQHnGqCl6NoM4YKX0ARJnEeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZnnA9OasNL4IqLGaYGRrgQS6UpCexO+jQgOJExMQp4gpzWeYBiaPNsTlYixA/HJN
	 9fVZ+HvrnPwJTO3OPE656uvI8OiYXxLTq6WHMb84kEavHM6pAdetcmbXHMKObUgGi7
	 iY1fZ6/YGBYoo0OxcEPI+KBK9NgL6BXW8vfkeZyEo9tcKkdUnlhuTXzJz66HDpHUko
	 LA9y4i/r2LSll7DcvLTh/OdOiSLh7yhDFTan/j+glwfSAmk3oUwn4IhXwb3RxbzNTF
	 ioTHAqzMcoO3qgd4jpbP4bx7nOQCXJUYuRpHUqDek8TBZr5h2UAYEcEftxhync8k9a
	 yRN8BpoNkF08Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: add diagnostics for rejected memory and map
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260927194205.125086-1-suchitkarunakaran@gmail.com>
References: <20260927194205.125086-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 19:50:59 +0000
Message-Id: <20260927195100.6F2D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing diagnostics for some read-only memory writes
--

commit 184c7fe51457fa3d0ba8959d5aae6f21fcf5effc
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

bpf: add diagnostics for rejected memory and map accesses

Emit structured verifier diagnostics when BPF programs are rejected for
unsupported or prohibited memory operations. Cover sign-extending arena
loads without JIT support, read/write access restrictions on maps, writes
through read-only pointers, direct packet writes, and modifying helpers
used with BPF_F_RDONLY_PROG.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6449,6 +6459,10 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
>  		if (t =3D=3D BPF_WRITE && rdonly_mem) {
>  			verbose(env, "%s cannot write into %s\n",
>  				reg_arg_name(env, argno), reg_type_str(env, reg->type));
> +			bpf_diag_policy(env, insn_idx, "memory write",
> +					bpf_diag_fmt(env, "%s points to read-only memory",
> +						reg_arg_name(env, argno)),
> +					"Use a writable destination, or copy the data into a writable buffe=
r before modifying it.");
>  			return -EACCES;
>  		}

[ ... ]

>  	} else if (type_is_sk_pointer(reg->type)) {
>  		if (t =3D=3D BPF_WRITE) {
>  			verbose(env, "%s cannot write into %s\n",
>  				reg_arg_name(env, argno), reg_type_str(env, reg->type));
>  			return -EACCES;
>  		}

[Severity: Medium]
Since the commit message mentions adding diagnostics for writes through
read-only pointers, should bpf_diag_policy() also be called here for
direct writes to read-only socket pointers in check_mem_access()?

[ ... ]

>  	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF &&
>  		   !type_may_be_null(reg->type)) {
>  		bool rdonly_mem =3D type_is_rdonly_mem(reg->type);
>  		u32 *max_access;
> =20
>  		if (rdonly_mem) {
>  			if (t =3D=3D BPF_WRITE) {
>  				verbose(env, "%s cannot write into %s\n",
>  					reg_arg_name(env, argno), reg_type_str(env, reg->type));
>  				return -EACCES;
>  			}

[Severity: Medium]
Does this direct write to a read-only PTR_TO_BUF also need the new
bpf_diag_policy() diagnostic, similar to how it was added for
PTR_TO_MEM earlier in check_mem_access()?

[ ... ]

> @@ -7061,6 +7061,15 @@ static int check_helper_mem_access(struct bpf_veri=
fier_env *env, int regno,
[ ... ]
>  	case PTR_TO_MEM:
>  		if (type_is_rdonly_mem(reg->type)) {
>  			if (access_type =3D=3D BPF_WRITE) {
>  				verbose(env, "%s cannot write into %s\n",
>  					reg_arg_name(env, argno), reg_type_str(env, reg->type));
>  				return -EACCES;
>  			}
>  		}

[Severity: Medium]
If a BPF program passes a read-only PTR_TO_MEM to a helper function that
expects a writable buffer, the access is rejected here in
check_helper_mem_access(). Should this path also emit the structured
diagnostic?

>  		return check_mem_region_access(env, reg, argno, 0,
>  					       access_size, reg->mem_size,
>  					       zero_size_allowed);
>  	case PTR_TO_BUF:
>  		if (type_is_rdonly_mem(reg->type)) {
>  			if (access_type =3D=3D BPF_WRITE) {
>  				verbose(env, "%s cannot write into %s\n",
>  					reg_arg_name(env, argno), reg_type_str(env, reg->type));
>  				return -EACCES;
>  			}

[Severity: Medium]
Similarly, does the rejection of helper function writes to read-only
PTR_TO_BUF pointers in check_helper_mem_access() need a
bpf_diag_policy() call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927194205.1250=
86-1-suchitkarunakaran@gmail.com?part=3D1
