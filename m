Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED243E4BE
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302671; cv=none; b=i1mrws9LH5jnBb7NzrfKu/Eoh6cL2eP/gVEBeq9avaKkx/PsQbqyKwco9UtIo5Lj40ushO49cG9re3vbw6S9MiGpL13GEG5qPebjG6rJA0sW6tz0K1eeogSDfG9TpbomQHRpo0MQ+8lj5P8GzVaDMkP6rup3YGiJSzXIOS58hRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302671; c=relaxed/simple;
	bh=39sCdTLBS+NGUH23r/6FOOSOK109UKMg2+jxBj0tAtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pgSxOPPXPoEZmg1OR0egORkazlND6stZrQvhr0gmxkWPr2Ws+aYaL8e3ft+97Z7jsIC3DNznRfSz1IidgYkPZf6kAIVcyQJZpI1dGynSdHVwnAs3i8ZbV0TtCgAGr+xNf0kZnOod2e+wyenFK73h2nRAhLBmAaMjmrr44NOnXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6ScLCir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6ScLCir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08B21F00A3D;
	Fri, 21 Aug 2026 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302667;
	bh=ktw8BEl4D+3EXseb6UE2q7LoRNcsVuRFjYU4TwsqGe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6ScLCirbGP378fPXbE9crn+W7ITHm219iFjYK3liEPyVCa7WbCSoJ+2UKeyfKSE1
	 sufJgSP8il+KP/38z0ZNjT8IBz/A2WQgZIfLmAGYi4zP9bM4liMU2IYWzw05NKxyAc
	 sYBT4LZINxxayYn9FCQA93bLSm8uiOiBS1DLQjzPWwiWzCwrdL9W49i+SGuR8o1Xw1
	 wjsH4U7G01oBivRa98xd21tEv5HLhY0CO0HBqHp2ZLao3q9gsoNGzhFLZTMTeBOiAc
	 aY/P4uLoHSQ6dR/p3/uy3v4EEP4ob7MBlF+ciqeFoqFFH1tlRBShHs+i8yIg7xcpJx
	 E+Exi/7FAvBkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in
 cgroup link update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:57:46 +0000
Message-Id: <20260821085746.D08B21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] A multi-line comment violates the mandatory BPF subsystem comment s=
tyle.
--

--- Patch [1]: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cg=
roup link update ---
commit 3542a649528edfe00a99f7439585e0f6e14c0cc5
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>

bpf: Fix stack out-of-bounds write in cgroup link update

This commit validates replacement programs against the link attach type dur=
ing
cgroup link updates to prevent out-of-bounds writes on the stack. It restri=
cts
replacements between incompatible BPF program types that share the same main
type but have different context or return semantics. A new helper function =
is
introduced to factor out the capability checks for CGROUP_SKB programs.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..dfea337ff25ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -4542,6 +4536,19 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>  	}
>  }
> =20
> +static int bpf_prog_attach_check(const struct bpf_prog *prog,
> +				 enum bpf_attach_type attach_type)
> +{
> +	if (prog->type =3D=3D BPF_PROG_TYPE_CGROUP_SKB &&
> +	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> +		/* cg-skb progs can be loaded by unpriv user.
> +		 * check permissions at attach time.
> +		 */

[Severity: Low]
This isn't a bug, but does this violate the modern BPF multi-line comment
style? The BPF subsystem guidelines prefer having the opening /* on its
own line.

> +		return -EPERM;
> +
> +	return bpf_prog_attach_check_attach_type(prog, attach_type);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084726.3769=
957-2-sanghyun.park.cnu@gmail.com?part=3D1
