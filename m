Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975591D9A70
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789714; cv=none; b=MpDHsUvn8gD9FdCITSOIlxAxZwY4Fp1fk1WZLsolI7zhH0wNkAyz5bjpHntXY6FbZHCKVFwhY5karT+OtvHilMaDEeqfjM8UQ70ewoOBnVQ1cTpppzilLDH8qLxNd3tM+qh93bk8AKq11iCLteG+lZTvVFLMe40eZwPDU9+Geuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789714; c=relaxed/simple;
	bh=V+CdI+DOh3PBvP2x5rdL2Kr1NseOS9hAxLDDqaQQzwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwEGigfBMRmagYZ5eCOGA63sEEHd5oKZPEOqYxu3yTrk1Bd3//BPYKFDRzuTMhnmQQTSWUNvdABtWBbcIjndOlofYCsgQxpRwtIz5gyHl80leg+gvIZy+e/a+hF9s6qePh0rlbIDYy7cQ0EjFVJjjLYGhCcQWzbFMVCYzD4Il8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leKJ/2xf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leKJ/2xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129011F000E9;
	Thu, 27 Aug 2026 00:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787789713;
	bh=ub9GRL0Zgvm+yRkFlZiNPgcifJVWKUqNULaMaQitXyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=leKJ/2xfC9c32RtO792tGGVIfcg82eSqcS1mptcNr1CjuT2FsJVAjwWbO4abGlYFR
	 U2NLGgkeukXKvm2dAjw7yEb8eJFOTwBjL0TQNPBjTgMsjJcCDBEeXnXpP1BAaXi/Js
	 LTcQIovOgY9FcTFWWZP09+nv0mLnZmrN8Vk1Zl6CYZA2kyjjKguCXfHeiEZ1xLhb/r
	 3wr3LPcHG43cS1yB/GjPxJWJaK/fJ0kgKNTXx5G64PKboPw98CPfYjbqA1uwVQJbBd
	 cyeP+deYvUGwHQ/JLiXPtMd2S7gelpOUZsWuB+OXCi8JLRvU0v0d2qIa5vHCY+B609
	 VbZDLjXPYNFsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] libpf: Fix for the potential undefined behavior due
 to shifting
Reply-To: sashiko-reviews@lists.linux.dev
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260827001007.1420507-1-tw19881113@gmail.com>
References: <20260827001007.1420507-1-tw19881113@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 00:15:12 +0000
Message-Id: <20260827001513.129011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch attempts to fix undefined behavior in `BTF_INFO_ENC` b=
ut places the cast incorrectly, leaving the undefined behavior unresolved. =
According to the C standard (C11 6.5.3.3), the logical negation operator `!=
` always yields a signed `int` (0 or 1), regardless of the operand's type. =
Thus, `!!((__u32)kind_flag)` evaluates to a signed `int`. Left-shifting thi=
s signed `int` by 31 places (`!!(...) << 31`) continues to trigger undefine=
d behavior by shifting a bit into the sign bit of a 32-bit signed integer. =
To correctly prevent the undefined behavior, the cast must be applied after=
 the logical negation, e.g., `((__u32)!!(kind_flag) << 31)`.
--

commit ce021dde7807eb8995ad265d12e0e7372294cfb7
Author: Tw <tw19881113@gmail.com>

libpf: Fix for the potential undefined behavior due to shifting

This patch aims to fix an undefined behavior issue reported by UBSAN in
libbpf ("left shift of 1 by 31 places cannot be represented in type 'int'")
by casting the operand to an unsigned type before shifting.

[ ... ]

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 4c46d34fc055d..2df1df3f3f22c 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -77,7 +77,7 @@
>  #define JUMPTABLES_SEC ".jumptables"
> =20
>  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> -	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> +	((!!((__u32)kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN=
))

[Severity: Medium]
Does this cast actually resolve the undefined behavior, or is the regressio=
n=20
still present?

According to C11 6.5.3.3, the logical negation operator (!) always yields a=
=20
signed int (0 or 1), regardless of the operand's type. This means=20
!!((__u32)kind_flag) evaluates to a signed int.

Left-shifting this signed int by 31 places continues to shift a bit into=20
the sign bit of a 32-bit signed integer.

Could the cast be applied after the logical negation instead, such as=20
((__u32)!!(kind_flag) << 31)?

>  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_=
type)
>  #define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
>  	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827001007.1420=
507-1-tw19881113@gmail.com?part=3D1
