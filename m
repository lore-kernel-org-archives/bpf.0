Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE243DEA9
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122575; cv=none; b=NlwrV2b8LSD1Pte007ydwm47BTrEQ+h8gDFIDx5VNGXNEJIcvTTg7Tz1J82mB3PZRGDgE3sp8E5sewzeX6jZ2Z5AteRczjIyj8MSjz41N52pAxUZ/V9zyXZKOZgB6umjLPh6tft2GvYHePEx4TgsRyImbzDjUiZHbRQCijIZP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122575; c=relaxed/simple;
	bh=dRJPXHmQIpqnXE2lMS1vaoTqRb4mhAwq99gChMQQCSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fru2gn+Lk5Dra58L6Ml1Ega6e0gNz/4IczlEezL0U6QK24BGY1tvCKMsF6Ix/6PLnQhV591lrv9GgKbo83pvdCz3YPwrHquRT3Wakyz5UHnD6lkTfmNde4yR/gwa205X1d/4srcxvMBt0SuwazR+n9TgHRVsZIESTwSWDMOBjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5L0Gzwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5L0Gzwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D06B1F00893;
	Sun,  4 Oct 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122574;
	bh=A/fZigUkoqZgQ5dDw8iJCQJ2oPeEve2U+Nn2FqBO8Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5L0GzwfKfNIKLxN87LFmeMZaPjtPXNyVGXJPrfmr2Mo3qcGvbxSe7N1RY1I8ix75
	 p9brrB+xUOOMSp4u9Yh5zPongiUnycwGTcf9nUXgd0XJcbY1wUkPAtTUIGvI1ymotU
	 HJozi7oVVVmxNLssYYA7Mmk6KnoLxTNWa51LdQ95obL4wvp+i+fPktuho7u9Cwq8TD
	 B6Pl+WK8JYhhQ3alqwLXVfMSugBwd+LuvM0+lPMpjvHyfVhRMGstmcLFwbSgZoJaHW
	 KWC9yjRRFePv/bFzIKiHyjcbuiWYo4ITNonhJ/Y/jXzElOFJf44seMiOL7SXdp34Ir
	 m7BbefLB/JI7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 14/43] bpf: representation for intervals
 with steps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-14-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-14-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 14:02:53 +0000
Message-Id: <20261004140254.0D06B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: unsound scalar pruning in explore_alu_limits due to ignored s=
tride
--

commit d4d6630f513d526c40cb9f5ea524c5bd6dd31948
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: representation for intervals with steps

Extends scalar register tracking with base and step fields to represent
strided values (base + step * k). Updates verifier ALU operations to
propagate these bounds.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4371fb3405acb..05914fcbe77cd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -178,6 +178,13 @@ struct bpf_reg_state {
>  	 * during state comparisons.
>  	 */
>  	u32 map_uid;
> +	/*
> +	 * The value described by this register, interpreted as s64, lies on
> +	 * a line described by a linear equation base + step * k.
> +	 * Invariant: base < step.
> +	 */
> +	u16 base;
> +	u16 step;

[Severity: High]
Does adding these fields after the id field bypass the exact state comparis=
on
checks?

Functions like regs_exact() and scalars_exact_for_widen() use
offsetof(struct bpf_reg_state, id) for their memcmp() limit. Because
base and step are positioned after id in the struct, they are excluded from
the memcmp().

For example, in kernel/bpf/states.c:regsafe():

    if (env->explore_alu_limits) {
        return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=
=3D 0 &&
               check_scalar_ids(rold->id, rcur->id, idmap);
    }

When explore_alu_limits is enabled, could the verifier incorrectly prune
an unsafe execution branch (e.g. one with an unaligned scalar step) using
a cached safe branch that had an aligned step? This might allow unaligned
scalar offsets to bypass BTF array bounds alignment checks.

A similar omission occurs in regs_exact() which could cause false-positive
infinite loop detections, and in scalars_exact_for_widen() which might break
loop convergence expectations. Should these exact-match functions be updated
to explicitly compare the base and step fields?

>  	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>  	bool precise;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D14
