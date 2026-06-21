Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E89443
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063686; cv=none; b=kU0uZLzEV57tVAePth+juxeOc9ECFNEOi39mtMtJkTz+X9amZOo/bIpaqT8Hb7h89sKrK9WoDtKrb3NxfUirE8PHKckEHvtYCHUQJy73ssOWeCUPFCVY+fnEGpRbVaZPJJOEmeCAEU9+NvaGdU669UvO3VHakCCW0gffC4buaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063686; c=relaxed/simple;
	bh=VvrMhLAhlHPWZgzcEJUJAmtT1Ohsz0wRGFKn83ZLMtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEXkcAVtjJ+DxvOR5hL9KZG6PD0UvXER2RyTYYD9MGyPYuDc30hQxQNWjkBL80mfEBn79w+jK7mP0bSpiPqQgMPzkPNc/l7ndjEcJxVstBpwwtWaG40NhOGfzt8G4YXcM2Z+KTYqWxBnYHP46D9x620w/YRVyCPQpT0avTpLu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZVpu783; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZVpu783"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19421F000E9;
	Sun, 21 Jun 2026 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782063684;
	bh=eCEKllwfiA1QLd/GPHbZmPuwTZHSNuE6zvTkhDMmK/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZVpu783W78Br9gX8cNVJ16cQq+VDaZ0uCj1gC66xCLGlZOG5TrFOQBsW8KKlcVOY
	 UejdLwdEKd5llt8I+I9Y1vOlMETLDt5JBEfaz3IYcOIWJxxiZOaVxXAtVEm2beIqPm
	 /A14+V5II4GItZvLVJODoTmk4L+kXddkfCKJwErmcaxoAgrbE7X6xBtHIQ8eFEZEP6
	 BGAF200HD9qDIdLAmJgwEzYv2/HNueU+JIZ+IkC1LCouAwSDBgqlaQ5LYwOjljiD/D
	 yLGSqzcJg/5giciJ5hx8r3ROf0TGgR+wcqr4wBKBJ12bnpRsg5eBFcxaQfPmDF8IU7
	 GoEhaLBcWlulA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v4 2/4] bpf: Remove
 mark_precise_scalar_ids()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621172735.409355-3-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
 <20260621172735.409355-3-jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 17:41:24 +0000
Message-Id: <20260621174124.C19421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused `struct bpf_idset` and `idset_scratch` member left behind.
--

commit 2660918ad586a63f54484e899c7fa4fee0c90878
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: Remove mark_precise_scalar_ids()

This commit removes the mark_precise_scalar_ids() function, which is
superseded by bt_sync_linked_regs() and equal scalars tracking in jump
history. It also updates the progs/verifier_scalar_ids test cases to
reflect the new verifier behavior.

Link: https://lore.kernel.org/bpf/20240718202357.1746514-3-eddyz87@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2268f095203e2..f638b2d3a42fb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> -/* Collect a set of IDs for all registers currently marked as precise in=
 env->bt.
> - * Mark all registers with these IDs as precise.
> - */
> -static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct =
bpf_verifier_state *st)
> -{
> -	struct bpf_idset *precise_ids =3D &env->idset_scratch;

[Severity: Low]
Since mark_precise_scalar_ids() and its helper functions are being removed
here, are struct bpf_idset and the idset_scratch member in=20
struct bpf_verifier_env now unused dead code?

Looking at include/linux/bpf_verifier.h, idset_scratch is part of a union
with idmap_scratch, but the idset functionality itself appears to have
been orphaned by this patch.

Would it make sense to remove the struct bpf_idset definition and the
idset_scratch field as well to complete the cleanup?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621172735.4093=
55-1-jt26wzz@gmail.com?part=3D2
