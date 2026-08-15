Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254042773D8
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779515; cv=none; b=CHN20YhYhRox9rT73AhvTPtIlDHdSX4gmSjDgMpC3PJ5aj8svWcKgS17NqWDWYqIj6cmQo93mN7rQ5w4dwuUPtCqDHKwjUXo3JV2bk7MMz+kZS0TqVHX9sAq8H882nHnwnsabKDQT1Ke6IBEfhl215wwfkcJELcYn1Eb4b3eYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779515; c=relaxed/simple;
	bh=RaboHcegsPPZG48vqHHKT4ssJrRGZmoIDuvDdF1Xnvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xtnt2RG9+TYiqER1wv7gsqnMVW4Ly+v7J/GsHven3X/RS0eadlBwb0s1smOJlvyQiMzCkSdNAVNPyFvLAp2fOeLpziVn9jbAd6k58BELhZZuLXCq2ijyiUGVfCQekUsByK2v6T3SpjE1hqh+22pX0nVP2lMGw4BBoZVdjTVY6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYPIsM2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYPIsM2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A91F000E9;
	Sat, 15 Aug 2026 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779513;
	bh=h27WOXZcRAXa71ZNIUJp6wdsRn+Q5CAF05j9+6CHIRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lYPIsM2dwBawr3dJ/gV/BHpGXyvsDF4h17EJJZ+CyYptPRZiRqc4MPFFnPPKrohy5
	 gDxGyEsNtICOO34pI/5J+bc5lVbsFOr2wIlFg4X8SMqTIMCERnk56Ie/Wks6nRemrz
	 Iy/puxaRESosqOAbTiixGGm6Bhwiv6YpvrtYUQL14ctVDRJWF+6vPTekw7rmj15OjT
	 3iZ1yPHXeltVfk3dEVmN4O+WrIG8QJpryHdOfquV5zcLX06naX92UmUrIBgb2Y8pn6
	 6y42PK3B+IeUv56I72AhKCnZf4yEwNV+XEkojlv97BpeZedcyV5jdkXZyneyMFqR1Z
	 rcNipPpQQzaIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Track verifier register
 diagnostic events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260815064612.378577-6-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
 <20260815064612.378577-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 07:38:33 +0000
Message-Id: <20260815073833.A93A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The old state of BPF_REG_0 is incorrectly recorded as NOT_INIT f=
or helper calls, losing its lineage.
--

--- Patch [5]: [PATCH bpf-next v5 05/14] bpf: Track verifier register diagn=
ostic events ---
commit 3cbb3352506d462a8a06bc8434f061a5dc31d13d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: bpf: Track verifier register diagnostic events

This commit introduces verification diagnostic events to track material
register and outgoing stack argument changes. This allows diagnostics to
explain how a value reached its current state, type, or bounds.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db644690ac4bf..a5929e40f18d1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10518,12 +10594,14 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>  		return err;
> =20
>  	/* reset caller saved regs */
> +	bpf_diag_record_caller_saved(env, regs);
>  	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
>  		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
>  		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
>  	}
>  	invalidate_outgoing_stack_args(env, cur_func(env));
> =20
> +	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
[Severity: Medium]
Does this record the old state of BPF_REG_0 as NOT_INIT?

The loop just above this line in check_helper_call() scrubs all caller-saved
registers (which includes BPF_REG_0) by calling bpf_mark_reg_not_init().=20
Because the bpf_diag_mod_begin() snapshot is taken after this loop finishes,
it seems we might capture the already-scrubbed state instead of what R0
actually was before the helper call.

Could this break the diagnostic lineage tracking for the return register?
Perhaps the bpf_diag_mod_begin() snapshot should be taken before the
caller-saved registers are cleared?

>  	/* update return register (already marked as written above) */
>  	ret_type =3D fn->ret_type;
>  	ret_flag =3D type_flag(ret_type);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815064612.3785=
77-1-memxor@gmail.com?part=3D5
