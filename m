Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356230;
	b=J7OjpK57rUOtvRUVVyGe0FkG/1SYcLfPG0l8gXa7ahq8iwZR4CbBzxF+J+YpMTrAsOVu
	 qIgMwjbW3poLR3sU14Y+1652FiKvk2v4iaV9bDmRpRF8kkv/w/2fBuEB/ivuxXESzlbfZ
	 2maxlotDki0/6Sv+DJuEu9HBDRZTSAgx/Im1n/iLUW1jn5bCbeuTMMnkHqgsUbgPbcgQh
	 vKtouAKxjbBngnT9NhLMu26sZwrLqAwRjNyIRgLO9bh8xW4hvNDp8Wi56kD7Yhh+FxrVx
	 Q+c0LDgY4L8fGpKgZ/ROsjb9NyYX48nDMNgr8y3b9i5muRJAdr++H4rkexhb5g1BdJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QEI6RYweCWWhPP8RTmNYs5FMDGrfA765hw6LGUvJkJg=;
	b=f7N/A30+cMuUeqKUkKgtCOrqlmmP7khrn2TC56mUujTSZa000qwU5B4Ra6A1Mm8cZ2nM
	 ZPDnQ1QYV+FD55U2J9DFMdjWLppgTixc7oILRLLei1P6vugyIGXdghSfi2zM5xDvki6pZ
	 F0q+x1Nu6tbzB81KqV8I3O/lO6HPhLjETvLNl3xA8nY0OPeu9cm/PkS5AQITyCTTK3d64
	 BK1THrNH/bpAGthtOGrhAf2AEonmJapdwiGsyc5iq/gMAXGOwZ7D2VF4T0uZZEaX9pA1t
	 P2k4KE6nlUHESdlLFu+5wmr6phRgPG/NTQ4YsF8DOTeFRBekXalVuTXM53ZnkNU0/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXJl55ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9B606A31C;
	Wed, 11 Nov 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXJl55ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86801F0089F;
	Wed, 11 Nov 2026 00:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356230;
	bh=QEI6RYweCWWhPP8RTmNYs5FMDGrfA765hw6LGUvJkJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXJl55ngk6vOlBH5eB9ubvBmosURw6LVTXmhzKDZzSgrxhgt95Te8z6Kaf1HE1DbR
	 dVYaoUIXte9YEIsri3IhYCgaaOTBHi1UImc319PQnwHHaSW47y9XNs+jvqoqr8t0zA
	 kG6trCn2nQl+Bv1EK1qc96tGp9KTur0aJnRFeUzQTTa3uFaRfm280UBrlXCBk45tIT
	 PqpE2i4C9jKYBc2whd/MiFXkHg0rIrxqVBLldrvbTXR041CLzrSlPVy7rlFWvlr4yr
	 cKhwFHLcXO/nm/LwUuDUFRCHZfo0B9uPMueKR9EB0f0G5yhjklkplj+emJwILep9iq
	 8xViqcqsOqwzw==
Message-ID: <sashiko-outbox-208007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] x86/kprobes: Use kprobe iterator in
 arch_check_optimized_kprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261109195731.1091241-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195731.1091241-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:17:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] kprobes: sibling re-optimization failure in __disarm_kprobe()
  [1]
--

commit 8174a2b0aeefac5511bfa58a9428f79328aae112
Author: Jiri Olsa <jolsa@kernel.org>

x86/kprobes: Use kprobe iterator in arch_check_optimized_kprobe

This commit replaces the byte-by-byte get_kprobe() lookups in
arch_check_optimized_kprobe() with for_each_kprobe() over the optimized
instruction range.

> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 9da41424be777..cdf69c939631d 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -334,12 +334,13 @@ static int can_optimize(unsigned long paddr)
>  /* Check optimized_kprobe can actually be optimized. */
>  int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>  {
> -	int i;
> +	unsigned long start =3D (unsigned long)op->kp.addr;
> +	unsigned long end =3D start + op->optinsn.size - 1;
> +	struct kprobe_iter iter;
>  	struct kprobe *p;
> =20
> -	for (i =3D 1; i < op->optinsn.size; i++) {
> -		p =3D get_kprobe(op->kp.addr + i);
> -		if (p && !kprobe_disarmed(p))
> +	for_each_kprobe(iter, p, start + 1, end) {
> +		if (!kprobe_disarmed(p))
>  			return -EEXIST;
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can kprobe_disarmed(p)
here reject sibling re-optimization during __disable_kprobe() [1]?

In __disable_kprobe(), disarm_kprobe(orig_p, true) runs before
KPROBE_FLAG_DISABLED is set on orig_p->flags:

kernel/kprobes.c:__disable_kprobe() {
	...
		if (!kprobes_all_disarmed && !kprobe_disabled(orig_p)) {
			ret =3D disarm_kprobe(orig_p, true);
			if (ret) {
				p->flags &=3D ~KPROBE_FLAG_DISABLED;
				return ERR_PTR(ret);
			}
		}
		orig_p->flags |=3D KPROBE_FLAG_DISABLED;
	...
}

When __disarm_kprobe() disarms a probe that overlapped the jump range of a
sibling optprobe, it calls optimize_kprobe() -> arch_check_optimized_kprobe=
()
to re-optimize that sibling.  Because orig_p is still registered and lacks
KPROBE_FLAG_DISABLED at that point, kprobe_disarmed(orig_p) returns false
and arch_check_optimized_kprobe() fails with -EEXIST, leaving the sibling
probe permanently unoptimized.

[1] https://sashiko.dev/#/bug/linux-504cacc5-65e4-4f67-bdd9-fa0c7244bee6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109194916.1089=
703-1-jolsa@kernel.org?part=3D9
