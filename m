Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679E523781
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059671; cv=none; b=mQr6bKIAQAcMYriv4CfNdRJnPYQUufI/FUY+DD0ZzKmMnJjklaxa/VGsb6ylnLjJpt/gGXmQH2sxcBN4sIon0L+T1z3ar11Pn1SbiNLEuGvE5N/HOSXN84v5hA+pks19G5xXGQpNMKpsBXSH7JmJkZ0owJF+KDEm6iuDLxvzx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059671; c=relaxed/simple;
	bh=tBhpev6R9TXmvgxaPs/FJXBUyNHtyx9rVrATl1M38gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7FX0SZqop2QwsMQq8LHuwAuvDpgjIkZjBz+OzVl9KEQjZX/jLM7xf+4zP9+4cNQR6OmOriSmxRwolwiRH4HA6tj33JuN6h/PxB1SZASzyRKtJvfV5Fhw2Dx+BC8XclbhwrlVxgSUbuUh3BioMP0KD2ZDUF240pN91kxZanLTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHanlCME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHanlCME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B091F0089B;
	Thu, 10 Sep 2026 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059656;
	bh=TW2wE/0HYHnMU0WoESwR39Gq+JNMisVl4tyOgU/TdII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHanlCMEclZnwz4JisptX2oZlBaG6g1oyTrkyDSEpkbnHBwHoNr38mgSmjGazbvdb
	 kiMzREL/u7i3xY7WyXtaYPJPTJGyIAPlEdxCcoVGTk6QWxn1j8pBqS52qah5E+Po2D
	 1UvRDcwBs33OmpAeY7EIQEBsyv4Mor+eZQbgba1VP5DZtyn5RMAvg8ZgnIu7PThOGz
	 yw3t2gcWlC7kpAAIh3ntSGmBBP2jD20z8YkRBO8SrpJt6s9GKWHySr5JdbRwLzhDMH
	 NNVut1YPKqXR2t6YgIEh9DlzOpSXcmOnQsGrNFamKB8Ex7SZH09UGyiB0xd+t1t1UF
	 WGLX4JDyIrX3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910164635.459558-2-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:00:56 +0000
Message-Id: <20260910170056.87B091F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unintentional stricter pruning in explore_alu_limits mode causin=
g state explosion.
--

commit aa1d987a87f62f32dd84baa98f047ffd7635c40e
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: move linked-scalar flags out of bpf_reg_state->id [NFC]

This commit moves the linked-scalar flags (ADD_CONST32 and ADD_CONST64) out=
 of
the bpf_reg_state->id field and into a separate add_const bitfield. This
simplifies ID tracking by removing the need to mask the ID during checks.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a76..d974baad37ee2 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -542,8 +527,7 @@ static bool regsafe(struct bpf_verifier_env *env, str=
uct bpf_reg_state *rold,
>  			/* explore_alu_limits disables tnum_in() and range_within()
>  			 * logic and requires everything to be strict
>  			 */
> -			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D =
0 &&
> -			       check_scalar_ids(rold->id, rcur->id, idmap);
> +			return regs_exact(rold, rcur, idmap);
>  		}

[Severity: Medium]
Does this unintentionally introduce a stricter pruning check when
explore_alu_limits is active?

The commit message notes that using regs_exact() amounts to the same as the
open-coded memcmp plus check_scalar_ids() pair. However, check_scalar_ids()
allows old_id to be 0 by returning true immediately (ignoring cur_id):

	if (!old_id)
		return true;

On the other hand, regs_exact() calls check_ids(), which strictly enforces
that both IDs are either zero or non-zero, and fails if they differ:

	/* either both IDs should be set or both should be zero */
	if (!!old_id !=3D !!cur_id)
		return false;

When env->explore_alu_limits is true, comparing two equivalent scalar
registers where one is unlinked (ID =3D=3D 0) and the other is linked (ID !=
=3D 0)
would pass previously but fails now, potentially causing state explosion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910164635.4595=
58-1-vineet.gupta@linux.dev?part=3D1
