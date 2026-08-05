Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEF3D3302
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961351; cv=none; b=eenba+OP2AzOKKYLu11VRhxEtVY09ZYYBcNjaUpzAAzFsVObbzallaQGkWr+bmhIYYAKBbG09BSOqixT4RGMXgWkAJtUjTNLtHRxdQ/H6lXyx+B317BliNMJMJVNoG4wvKaJFQX0vrJerAzagmCX2sM2UyEWBM1Vwwxn5DFULSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961351; c=relaxed/simple;
	bh=HM+7iJnN8iRiRqVkCJLjL2htMNInB7YCL0krgHecWCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjT+FFSTxTNvics4UuRZ0XwgjtfA3ByE/xZGzlEUwFUPQOIGApAlBSx0t7evUMjDvMFbzJOgfRGviTBtvfoDy7M75lt18NI/kQXWjTq8x+TzpDGqoJ6E6bTPYMfFwc+kkqQp40lgwcHEikrlmfXLsrd3lEgF6qJI9Dn8cd2m7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np2Aokkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np2Aokkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7571F000E9;
	Wed,  5 Aug 2026 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785961347;
	bh=Yfu3cfYp/4rJxAWF7SrBXIpwqw5VO6WRwRQduios0IE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=np2Aokkp7R4QnnZrgyFwpFtZXRSpWpuVOjuIZwXhCOcyRw65JjlMIoEXfI0y3wvHs
	 bY6SwHZl+b5VG1HjTeZbrJwVJt45lacXHG/BQKnFFC8paW3+KmIZOlUWbUCtrwZ0CC
	 c5en5m5ITBSBnTi/gGZZqzBds/AMizYzMl/DONUmNA6/IP2DpfH3EIYQHxS06frUiL
	 ERKwu5SIYUZ/U90/gGNwSr3absLaSP+mBAcWS6Beb7+wnL6d6X2Yph27mfcTgWR+Lh
	 SdbdtMmF80y/ecZHa9vtBu81xHU5lHmzhfuyNZw2f7JgNoqjb/nvkYR9oXKq4OmTp0
	 RzllrHvZG2E2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf: Mark pending sub-register zero
 extension before pruning a state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805184444.292828-1-daniel@iogearbox.net>
References: <20260805184444.292828-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:22:26 +0000
Message-Id: <20260805202227.7B7571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf_mark_live_subregs_zext() fails to mark pending zero-extens=
ions for registers of type PTR_TO_ARENA on pruned paths.
--

--- Patch [1]: [PATCH bpf-next 1/4] bpf: Mark pending sub-register zero ext=
ension before pruning a state ---
commit 59834505da01b398ada03dbde42eaf69952c910a
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Mark pending sub-register zero extension before pruning a state

This commit ensures that 32-bit sub-register definitions maintain their
zero-extension marks even on pruned verification paths. It achieves this
by marking live sub-registers for zero extension when the verifier stops
its walk at an equivalent state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d925197c2e5f7..addcfd1319c5c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -3161,6 +3161,44 @@ static void mark_insn_zext(struct bpf_verifier_env=
 *env,
[ ... ]
> +void bpf_mark_live_subregs_zext(struct bpf_verifier_env *env,
> +				struct bpf_verifier_state *vstate)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	struct bpf_func_state *func;
> +	u16 live_regs;
> +	int i, j;
> +
> +	for (i =3D vstate->curframe; i >=3D 0; i--) {
> +		live_regs =3D aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
> +		func =3D vstate->frame[i];
> +		for (j =3D 0; j < BPF_REG_FP; j++) {
> +			if (!(live_regs & BIT(j)))
> +				continue;
> +			if (func->regs[j].type !=3D SCALAR_VALUE)
> +				continue;

[Severity: Critical]
Does this check inadvertently skip PTR_TO_ARENA registers?

PTR_TO_ARENA is also a 32-bit register type that relies on subreg_def for
zero extension. If a BPF program casts a 64-bit value to a 32-bit
PTR_TO_ARENA, branches, and gets pruned, skipping PTR_TO_ARENA here
would leave its subreg_def unmarked.

Could this lead to missing zero-extensions in the JIT, leaving garbage in
the upper 32 bits and potentially causing out-of-bounds memory accesses
outside the arena boundaries?

> +			mark_insn_zext(env, &func->regs[j]);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805184444.2928=
28-1-daniel@iogearbox.net?part=3D1
