Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264B3112BC
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338309; cv=none; b=dGUm9W7BBw3CzPeG1cJoUor349j2jcI4wr2hKpNaY0M17lhk6vdS3CMkAkqFR2gWed7Qr3CyNCF/tLFci9R0WKoBzZAkEq5mkVYk0l+hbc7yjTt5QEcHLQHgSAbWrqsuq8Uhf8Sqywq/NQjvWbGYzLNfL3ZuVOK4uP1vMRcfUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338309; c=relaxed/simple;
	bh=SFK5CMRpONDAKl3nwOzkXO548TE9OOA1Lf8g+KsuK2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NmIx1Mw2rkD5MrYIPUloXx3OH2bzbfYJk+ESHAGk2swRmiepqLWY7DY4SRvYY+Dl9OLzMQ6t8Md40sv9ViTJ6KuC65TM7+oe/c1EY2LAVKWvrEK5a4nNukuXa53fxP86xdXcHI+1/4I78J9kXhNwP4cHnfKMWhkQbEMpl58aH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw2b1yF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw2b1yF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C811F00893;
	Mon,  1 Jun 2026 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780338308;
	bh=hXnDXOhxZ4G0Qht0uixBuJowPUWOEysu7CkfwdNLg10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zw2b1yF6/4nuoJnwXphxyqqJOdcJLskXzWxidVyGIhW2fLg842e7j4JFzjoGt3BfV
	 7T9FGk+c736EDBrybHUbEDNVR6tuXYY+h3JVOQmgNcmlNvZbCQLVHiqiui7lItq5DC
	 5McYLWGauO//wzf+r23xPMNhoQ4LbnnCAk8w4TgN1JKRa8e/pytapc1CjsG68CFw/U
	 r/V0BIEV9SVX0o/c/1YsReC8cfxuVBAKDQbUrv7i4vTzZ7kPHbYgQX2zsFv8ElPCbV
	 EF8kKipNXsQu6G9FlkEtn5zpgikNTc0uykUoiaV/9mrcnbtmS8nVfPXhxWgf4BHjWV
	 2WD4W3mvYXsiQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.1.y 1/2] bpf: drop knowledge-losing
 __reg_combine_{32,64}_into_{64,32} logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601180400.1381736-2-jt26wzz@gmail.com>
References: <20260601180400.1381736-2-jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:25:07 +0000
Message-Id: <20260601182508.29C811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The removal of `__reg_combine_32_into_64()` and `__reg_combine_64_=
into_32()` drops critical precision-preserving fast paths, causing the veri=
fier to artificially widen bounds and incorrectly reject valid BPF programs.

In upstream Linux, this patch was part of a major 'BPF register bounds logi=
c rewrite' series, which completely overhauled `reg_bounds_sync()` to algeb=
raically deduce 64-bit bounds from 32-bit bounds (and vice versa) without l=
osing precision. However, in this isolated backport to 6.1.y, the rewritten=
 `reg_bounds_sync()` infrastructure was not included. The 6.1.y `reg_bounds=
_sync()` relies entirely on `var_off` (tnum) approximations.

Before this patch, `__reg_combine_32_into_64()` explicitly bypassed this tn=
um approximation when the upper 32 bits of a register were known to be zero=
, directly copying tight 32-bit bounds into the 64-bit bounds using `__reg_=
assign_32_into_64()`. Similarly, `__reg_combine_64_into_32()` copied tight =
64-bit bounds back to 32-bit bounds.

By dropping these helpers and falling back to the 6.1.y `reg_bounds_sync()`=
, a tight 32-bit bound like `[0, 5]` is converted to a tnum mask `7`, which=
 then widens the 64-bit `umax_value` to `7`. Because the verifier relies on=
 tight 64-bit bounds to enforce safe memory accesses, widening them artific=
ially will cause the verifier to incorrectly reject safe programs.
--

commit 276e00bfbaf18530ce686f7167a23c7b6257d77a
Author: Zhenzhong Wu <jt26wzz@gmail.com>

bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic

This commit removes __reg_combine_32_into_64() and __reg_combine_64_into_32=
()
and replaces them with reg_bounds_sync() calls. This was part of a larger
upstream series rewriting register bounds logic.

Link: https://lore.kernel.org/r/20231102033759.2541186-10-andrii@kernel.org

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 264b3dc714cc4..d9b027f3dd121 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -4443,9 +4398,10 @@ static void coerce_reg_to_size(struct bpf_reg_stat=
e *reg, int size)
>  	 * values are also truncated so we push 64-bit bounds into
>  	 * 32-bit bounds. Above were truncated < 32-bits already.
>  	 */
> -	if (size >=3D 4)
> -		return;
> -	__reg_combine_64_into_32(reg);
> +	if (size < 4) {
> +		__mark_reg32_unbounded(reg);
> +		reg_bounds_sync(reg);
> +	}
>  }

[Severity: High]
Does this replacement in coerce_reg_to_size() lose bounds precision on older
kernels like 6.1.y?

Before this patch, __reg_combine_64_into_32() explicitly copied tight 64-bit
bounds directly into the 32-bit bounds.

It looks like the 6.1.y version of reg_bounds_sync() relies entirely on
var_off (tnum) approximations, because it doesn't include the algebraic
deduction infrastructure that was added in the upstream rewrite series.

Could this mean tight bounds like [0, 5] might be converted to a tnum mask
of 7, artificially widening the bounds and potentially causing the verifier
to incorrectly reject safe programs?

[ ... ]
> @@ -9885,13 +9841,13 @@ static void reg_set_min_max(struct bpf_reg_state =
*true_reg,
>  					     tnum_subreg(false_32off));
>  		true_reg->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
>  					    tnum_subreg(true_32off));
> -		__reg_combine_32_into_64(false_reg);
> -		__reg_combine_32_into_64(true_reg);
> +		reg_bounds_sync(false_reg);
> +		reg_bounds_sync(true_reg);
>  	} else {
>  		false_reg->var_off =3D false_64off;
>  		true_reg->var_off =3D true_64off;
> -		__reg_combine_64_into_32(false_reg);
> -		__reg_combine_64_into_32(true_reg);
> +		reg_bounds_sync(false_reg);
> +		reg_bounds_sync(true_reg);
>  	}
>  }

[Severity: High]
Will replacing __reg_combine_32_into_64() with reg_bounds_sync() here in
reg_set_min_max() also suffer from the same precision loss?

Previously, when the upper 32 bits were known to be zero,
__reg_combine_32_into_64() used __reg_assign_32_into_64() to directly copy
tight 32-bit bounds to 64-bit bounds, bypassing the tnum approximation.

Without the upstream reg_bounds_sync() algebraic deduction logic, is it
possible this causes bounds widening that breaks existing userspace BPF
applications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601180400.1381=
736-1-jt26wzz@gmail.com?part=3D1
