Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46B348C7B
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788000528; cv=none; b=M4ORiAcicDr+E3L0aBhtLli3DOMCaqE/7MQZCqV0zOTpbUID4J9p50MTF2A19bASLZPgrOznqhcxu/L/OTgTc1fv7wGddl51jFPrQ05+pFoyl1eYfjmLczj1iL3xT4oGOhpUreVLQqc9kM1mh8fkt9uPO8vUaWx8fEpU/Uj85s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788000528; c=relaxed/simple;
	bh=d6RYr5Ex026nGa3wFTyqprrCQ03Re7dM1ToUIWa08Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smVhdlQ30nugtTkrSPv4XJrQhkP7tNIXLZlxURS2X/XFVb2cx2/uP6VR06oV+sMlw4hzWznFyWBEEO0wTNCTs7LIFxdy8y9Z1Amb9n2POCTEfDynzmKGgqERHWtUIFARfQHVZwTY4t/SXpBKJ1dt3PGKixuffOjYV/HyjIra21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQzLH0GG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQzLH0GG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F263B1F00A3E;
	Sat, 29 Aug 2026 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788000527;
	bh=s7cBIeBshojGlV7ibZVxGFHRetLnK2TsR+b5ull4ytI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQzLH0GGkSEqKS3Reipm+IyBi182miAk+CUF9DdK4X/TXK5YQvHPX7YhmOeNKT6B1
	 CpYH9JdL1xdXF6moWJz9zsafRuiIkLCyxWNaJPQoiSVx30IPPuhyWOr2RKfIVQAn+u
	 EioB+LkYXgb2D4hIF6uauFiExBEzwDMnEnDYxs9UTqYiYZI4edBys3uqsc8UCJC2Gd
	 owkYo4KtaKp9mENBbTKa4h3EbksEDhTHWoEdu55gtTFjPBXyRQG2RVLw6IIipC7611
	 D1LCyHdmPQHAQFKGAIyx8EQZuF9mvZrVrGIu9RW67Q6kLKLEi+5/o//2DUlogpTexs
	 ZA4geiKEsGi8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v3 2/3] bpf: Propagate referenced dynptr release
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829102638.105170-3-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
 <20260829102638.105170-1-xyx2021@mail.ustc.edu.cn>
 <20260829102638.105170-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 10:48:46 +0000
Message-Id: <20260829104846.F263B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch successfully fixes a kernel panic by propagating the err=
or from `release_reference()` for dynptrs, but leaves identical vulnerabili=
ties in `unmark_stack_slots_iter()` and `mark_ptr_or_null_regs()`, where `W=
ARN_ON_ONCE` is still used and will trigger panics when callbacks interact =
with caller references.
--

commit aa0864ea661b640ba7fd188bf0b1fcebb309d1b3
Author: Amery Hung <ameryhung@gmail.com>

bpf: Propagate referenced dynptr release errors

This commit propagates the error from release_reference() for dynptrs to
avoid a kernel panic when a BPF callback attempts to release a caller's
reference. It extracts the upstream behavior for the old stable verifier.

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dbc9cfcffcd60..65ee9afaa5ff0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -838,7 +838,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_re
>  	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
>  	 * slices by dynptr_id.
>  	 */
> -	WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +	err =3D release_reference(env, ref_obj_id);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but while this successfully fixes the
kernel panic for dynptrs, does it leave identical issues in
unmark_stack_slots_iter() and mark_ptr_or_null_regs()?

For iterators, if a BPF program acquires an iterator (e.g., bpf_iter_num_ne=
w) on
the caller's stack, passes it as the ctx argument to bpf_loop(), and calls
bpf_iter_num_destroy() on it from within the callback, unmark_stack_slots_i=
ter()
will still trigger a panic because of WARN_ON_ONCE:

kernel/bpf/verifier.c:unmark_stack_slots_iter() {
	...
	for (i =3D 0; i < nr_slots; i++) {
		...
		if (i =3D=3D 0)
			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
	...
}

Similarly, if a BPF program acquires a reference that can be NULL (e.g.,
bpf_sk_lookup_tcp()), spills it to the caller's stack, passes it as the ctx
argument to bpf_loop(), and performs a NULL check on it inside the callback,
mark_ptr_or_null_regs() also triggers a panic:

kernel/bpf/verifier.c:mark_ptr_or_null_regs() {
	...
	if (ref_obj_id && ref_obj_id =3D=3D id && is_null)
		/* regs[regno] is in the " =3D=3D NULL" branch.
		 * No one could have freed the reference state before
		 * doing the NULL check.
		 */
		WARN_ON_ONCE(release_reference_state(state, id));
	...
}

Should these two locations also have their errors correctly propagated inst=
ead
of triggering a warning?

>  	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
> =20
>  	/* Invalidate any dynptr clones */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829102638.1051=
70-1-xyx2021@mail.ustc.edu.cn?part=3D2
