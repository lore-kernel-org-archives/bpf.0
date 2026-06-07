Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4C27FB37
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852950; cv=none; b=g4fHcPFvNE3ziHyvgOehckUYBlnSjjxfcqOZNaH5NS62YMRSSbQc/MhyRvoC7HYLMza1s6HyEgCSRGIf+248gJTRBqUHEd3Pe34Rh50V8Az/JaPXAwK9E11pltu0Kn/vriELGNvIylfj/aYB+IiMszf7D9IkOf+c3NVYTuayN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852950; c=relaxed/simple;
	bh=q1toRgBUB/2mV2wMBxnfBMxAbQyIjW4bARwedrFx+WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDUDqUs+nVs7zWzAa5LpayZjuIiKhQs6kiJA6p7avaKDS4wgjouB6umPzteMP3kVqV9WRWcNmHY+YQbh07hFP773f9LgcQsFE2iSshkLcM2/z2CTtimjIiZrGf6/RwTMcDTgzHxYR9dvida6wqsAgJdOA4MFxczHSd9v6MzWxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnRVfuPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnRVfuPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C0E1F00893;
	Sun,  7 Jun 2026 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780852949;
	bh=pqFm/oOZZnvxEbKs+bzdKp/pN2DgF3ms0Gza9EIsbto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnRVfuPVWN6Q6Y8Nsbsv278Brij8DEvqNqvNqWmajqUyN2te27YWm3PrXjjDnJC73
	 D48d2kSHPjLLJ82Jzb5/e9Kv5z76Fa/JRgLDtpiXKExDJkla6cFW+LI42/jCRlHZfP
	 gdEvOpFO0aJ1nKlkaHaGPKdlg5cbKdd26DtXfRa9ZmFJpr2mKzcL7IJMNqlIrnhElW
	 GEKtMVhTTUkGk23niycLhbkwz4/8e64RcsBX5Eem/u8FMx+Eb6RCPMlYOST/PpiRYV
	 tsMN9/BXA8jgjpq92MK13Zhcxm95IsvZMZFFVXyuXm7DpOQe7f27QAPEvNDmH1g9lt
	 96P9ur/U8zlKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v2 1/3] bpf: drop knowledge-losing
 __reg_combine_{32,64}_into_{64,32} logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260607170959.823755-2-jt26wzz@gmail.com>
References: <20260607170959.823755-2-jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 17:22:28 +0000
Message-Id: <20260607172228.E5C0E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Loss of bounds precision causing false-positive rejections of vali=
d BPF programs due to an incomplete backport.
--

commit 759dc64a1dfbfd0437d50a8eab924162772ab60c
Author: Andrii Nakryiko <andrii@kernel.org>

bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic

This commit replaces __reg_combine_32_into_64() and __reg_combine_64_into_3=
2()
with reg_bounds_sync() in the BPF verifier. It aims to prevent information =
loss
during register boundary synchronization after conditional jumps.

Link: https://lore.kernel.org/r/20231102033759.2541186-10-andrii@kernel.org

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d90236d0ad94..5f94bff12aa08 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14329,13 +14285,13 @@ static void reg_set_min_max(struct bpf_reg_stat=
e *true_reg,
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
Does this backport drop bounds precision by relying on an older version of
reg_bounds_sync()?

Upstream, this change seems safe because reg_bounds_sync() was rewritten to
perform exact algebraic bounds derivation as part of a larger patch series.
However, in this 6.6.y backport, that bounds derivation engine appears to be
missing.

Without the updated bounds derivation, reg_bounds_sync() still uses the old=
er,
lossy logic that synchronizes 32-bit and 64-bit bounds by intersecting tnum
bitwise masks. For example, a tightly bounded 64-bit range of [6, 10]
translates to a tnum bitmask of 0xF (15). When reg_bounds_sync() derives the
32-bit bound from this tnum, the bound expands to [0, 15]. Before this patc=
h,
__reg_combine_64_into_32() would precisely copy [6, 10].

Could this loss of precision expand the tracked bounds after conditional ju=
mps
and register coercion, causing the verifier to falsely reject valid BPF
programs that rely on tight bounds for safety?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607170959.8237=
55-1-jt26wzz@gmail.com?part=3D1
