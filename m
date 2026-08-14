Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2F7081E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668511; cv=none; b=n1nOn+KLRhDrsR1MN+FjNEX1O5dIY40G9lxaJ7T1MBaDnRPpiRxhpjabY+pY+2g3J52Uu7yG86N8Umt7piGwEx/MF1M9kSeWrM3ZQaE5/WJE/o+SlzM+nZ6m39P4RCzmYBAUVPSb9VwwPENEh/Y2i4mV0v83nRkbKxdyGT5u7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668511; c=relaxed/simple;
	bh=wucGsXbEIuj2lrK/n23T2UY7uO27CVFJcdK7dzalA7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b4dgwrmz07IgNC9Lq9YH1sGw1c0U59LUP5CP0A+4+b3nL3dymnIlXcjILqFyxk/iIiDfBiWc0xc18UcXOHta8Wwo7tz6MT1ods7XZFGmtVjrCyaT1qJZ4lg+CLHCzpAlsQLcnP9WiW3n72xPCeSGQTFfXV0BRsVfIjhK7UJRe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+PO1+N6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+PO1+N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D012E1F000E9;
	Fri, 14 Aug 2026 00:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668510;
	bh=R4/aofqPOmdaaL3CCxWisxnm1JUrzPa9sog7MPXBEcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+PO1+N61OnIpTTwPOdfOoa4o26I1h8+AEc8nTIfOfyXXMfpXSC9qf4wl2nmSoEie
	 mLqDY6ToVYPmO4nbLkeebMriopaOOKdQtDjZLPRsyH5F6apTez+vybD8cJaNYWSTkZ
	 KkEimdxZSY1g5FoMIEFFhs6QxGlQ9aDx/MovQBPHFqwovZ6K5I9ht8HZT68V2iimBn
	 zXOQir5htrqd0nXvhtXq2Yticq/s8btSF9T7igTn3h8XISjkWjm+et1CKiq2MgVeUW
	 NXivENET5w3yb3X5OZpBDSVSiM1MfNJNmEpjxxVFM+tc6kgdOMk0I2b7Nnr3J1+xpt
	 ZaTIFRd3vSxqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 05/13] bpf: 4-byte precise
 clean_verifier_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260410-patch-set-v3-5-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-5-1f5826dc0ef2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:48:24 +0000
Message-Id: <20260814004829.D012E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Verifier bypass leading to out-of-bounds memory access due to =
precision loss when 8-byte scalar spills are partially read.
--

--- Patch [5]: [PATCH bpf-next v3 05/13] bpf: 4-byte precise clean_verifier=
_state ---
commit 720b66feb217d6b05897c14d4beceb7ff588cf92
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: 4-byte precise clean_verifier_state

Migrate clean_verifier_state() and its liveness queries from 8-byte
SPI granularity to 4-byte half-slot granularity.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ee3945a919e3a..0731e99aa5412 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -20075,26 +20074,83 @@ static void clean_func_state(struct bpf_verifie=
r_env *env,
[ ... ]
> +			/*
> +			 * Only destroy spilled_ptr when hi half is dead.
> +			 * If hi half is still live with STACK_SPILL, the
> +			 * spilled_ptr metadata is needed for correct state
> +			 * comparison in stacksafe().
> +			 * is_spilled_reg() is using slot_type[7], but
> +			 * is_spilled_scalar_after() check either slot_type[0] or [4]
> +			 */
> +			if (!hi_live) {
> +				struct bpf_reg_state *spill =3D &st->stack[i].spilled_ptr;
> +
> +				if (lo_live && stype =3D=3D STACK_SPILL) {
> +					u8 val =3D STACK_MISC;
> +
> +					/*
> +					 * 8 byte spill of scalar 0 where half slot is dead
> +					 * should become STACK_ZERO in lo 4 bytes.
> +					 */
> +					if (register_is_null(spill))
> +						val =3D STACK_ZERO;
> +					for (j =3D 0; j < 4; j++) {
> +						u8 *t =3D &st->stack[i].slot_type[j];
> +
> +						if (*t =3D=3D STACK_SPILL)
> +							*t =3D val;
> +					}
> +				}
> +				__mark_reg_not_init(env, spill);
> +			}

[Severity: Critical]
Can this lead to a verifier bypass and out-of-bounds access due to precision
loss when 8-byte scalar spills are partially read?

If a code path spills a non-zero precise scalar (e.g., an array index) to t=
he
stack as an 8-byte write, and then reads only the upper 4 bytes, `lo_live`
would be true and `hi_live` would be false.

This code then destroys the `spilled_ptr` via `__mark_reg_not_init()`, which
loses the exact value and precision metadata. It downgrades the live half to
`STACK_MISC`, which represents an unbounded scalar.

If a different path reaches the same point with an out-of-bounds precise
scalar, wouldn't `stacksafe()` compare the new state against the cached sta=
te
containing `STACK_MISC`?

Since an imprecise unbounded scalar is evaluated as a superset of any preci=
se
scalar in `regsafe()`, wouldn't the out-of-bounds path be incorrectly prune=
d,
allowing an out-of-bounds memory access to execute at runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410-patch-set-=
v3-0-1f5826dc0ef2@gmail.com?part=3D5
