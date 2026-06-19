Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B8346AED
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903634; cv=none; b=Bl6MvYGeHx6sud63PmzQSkyVqNSFXyeeF62knQrpY5z9C86HEKAj7LidJCSaGIZxj/O0C7U/p4Hr0i7HoK1+7mQZQWsLues0rZatk05BU3tlu3kn4S3JLjioFz8hkWAslq8Ael1k2Jqy/2J1N210zLRjoi7FVIebDEJ5yhR5NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903634; c=relaxed/simple;
	bh=miUiEu2ppJlhGZRtfjQkOFyk6pVhTQG0IkPAmRUo3aA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VRXKEegjMmmGrCqRt59MSCUQ9dL2D0jXfX35oCc39QRLiXh/LPe5vOJEWm6UIjkObknV47Kw5UJHRpY9qvWMc8IZqd2DgqOXN/WJXoCs28zeIZmNlTW8DVHpHrUGIhXGPb63Yx8/3YgSNU6Lob+z4AO4wE7XUyNSa2jfo+PHsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9vUbHjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9vUbHjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4201F000E9;
	Fri, 19 Jun 2026 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903633;
	bh=5Rmw4jKjPpz7Zb01woxBO6RjZxIEeb8jjozlrfgmCZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f9vUbHjRDCmM7lVfLUrDyJW8fbPssQNkKdmhqI0Led9RogiFFikaHySIROPARFuim
	 lSUSXA5CLFNoxdDNQWJvqf2ieZFJoOr9bQwpiyNaUaq8RmXWEIGiQzLksorwA0HRWB
	 ST0mUalQlWyBQsL7QsgNHoSH3Yfmb2IXsvkuCE7zMUGGn6szvdcGCdKN97Sy2egfz0
	 Ha791CpCkmSo2QIg3gcpiYByjoNmt6tvQnKYe9otIkK9QzILcIkjNoIAYUigzMKOMM
	 CYbEMCjKg7gaQCsVs9KuT6eBVt41KKWHDAfNiJt6owvjzvFbf2Iax+Gwh8NeOqqMqK
	 9BTgx/1hLzuAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/17] bpf: Track verifier context
 diagnostic events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619205934.1312876-8-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:13:52 +0000
Message-Id: <20260619211353.0B4201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded depth for IRQ contexts breaks nested diagnostic histor=
y anchoring.
--

commit 86418a115dc1ef24cac1a623674bfd700c69c32e
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier context diagnostic events

Record verifier context transitions in the diagnostic history to anchor
causal paths for lock, IRQ, RCU, and preempt regions. The depth of the
context is used to ensure nested regions correctly anchor at the outermost
active region.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93941deb2cd8c..e584dec04b34d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1473,6 +1475,7 @@ static int acquire_irq_state(struct bpf_verifier_en=
v *env, int insn_idx)
>  	s->id =3D ++env->id_gen;
> =20
>  	state->active_irq_id =3D s->id;
> +	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true, 1);

[Severity: Medium]
The commit message mentions using context depth to anchor nested regions at
the outer active region. Since BPF allows nested IRQ disables (for example,
via multiple bpf_local_irq_save calls), does hardcoding the depth to 1 here
break that behavior?

If a program nests IRQ contexts, multiple enter events will be recorded with
a depth of 1. When bpf_diag_history_context_start_idx() searches backwards
for an event with a depth of 1, won't it stop at the innermost IRQ enter
event rather than the outermost one?

>  	return s->id;
>  }

[ ... ]
> @@ -1552,6 +1561,9 @@ static int release_irq_state(struct bpf_verifier_st=
ate *state, int id)
>  		if (state->refs[i].id =3D=3D id) {
>  			release_reference_state(state, i);
>  			state->active_irq_id =3D prev_id;
> +			bpf_diag_record_context(env, env->insn_idx,
> +						BPF_DIAG_CONTEXT_IRQ, false,
> +						state->active_irq_id ? 1 : 0);

[Severity: Medium]
Similarly, won't this hardcode the exit depth to 1 if there are still outer
nested IRQ contexts active? Should this calculate the actual number of
nested IRQ contexts instead?

>  			return 0;
>  		} else {
>  			prev_id =3D state->refs[i].id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205934.1312=
876-1-memxor@gmail.com?part=3D7
