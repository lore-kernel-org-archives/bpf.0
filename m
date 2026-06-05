Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE1410D24
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642220; cv=none; b=rt6QAJ6HGi/I7+mNwLJi+3sPjF/MFJ5/cvTVprZLeYpoQzUctbYmJZ3Yy4MoLjbt1Z2+8mNP/6x8Dpw2vPFS8HPSnfFOt5cu57t1QlzQVbo2mG22ZQ+3JrQKBlZ4uEaMWRi06+vqFjDYAzuH32FH/kC7harBP6R1Wzs6XqKlaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642220; c=relaxed/simple;
	bh=phowzh72nQdSfJ/cpjpL2QvS+5NpcRuKDWIx8zJk3/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZSBGXkWHXIeZ8NSuJcGN19fVhsernstdqE2k59D6w/4zgdwdY6MacA/EYlt0OvNPhHI6UE09CY1ZGNgKBcmDksGeWGidXX49Ic1hvtwzly/MfYL71GyJYw8Ut4u+VOp+mInVdSjM7Pgh4B8ZQR5vfH/noc20R5KyTgPW+gF76+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8rX3+QO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8rX3+QO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F401F00893;
	Fri,  5 Jun 2026 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642218;
	bh=tVehC5b1g7LGmOAxPy2VA8X8gMTPhmkwJ6L4fbbkQ5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8rX3+QOvB90BFHsxJCdLKEF1cC1VaC5T8Uvre8IcZMEiy3RpKZxSVhGeAG7uBFOw
	 nanYz+v+mtazsRoSX9Aua8W4bhbHIbS0uguVaKHjbtPLFDMYnp9cDqjGzWpH9Ew8gx
	 9RizrlblEvsD66+weg3UQW/dvnBQY0hq+sB/68wxHWwLmMs/gwIerF07zoZp/tZJdT
	 vvhN9jZ3Wgsq9pI53W4H3TKSoJpQU+PWMhVTg0QHR1gdxqmCtOruPU755QfU3xaF5z
	 suKfA7DrAyIqLt3/eOXvJ1xfHoyAnF3JZWyeN1v+h+FA196uGb0u2Usg2b6fL4SsWW
	 hKBBN89cekSzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 04/17] bpf: Track verifier branch diagnostic
 history
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-5-memxor@gmail.com>
References: <20260605063412.974640-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:50:17 +0000
Message-Id: <20260605065017.D9F401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Massive memory bloat due to copying diag_history into cached explo=
red_states
--

commit 1c9483e0ca38f0733322ac30906596c49007b4eb
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier branch diagnostic history

This patch adds bounded diagnostic history to verifier states. It records
conditional branch outcomes to help show the causal path that reached a
verifier error when user-facing diagnostics are printed.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1624,6 +1626,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_sta=
te *dst_state,
>  	if (!dst_state->jmp_history)
>  		return -ENOMEM;
>  	dst_state->jmp_history_cnt =3D src->jmp_history_cnt;
> +	bpf_diag_copy_history(dst_state, src);
> =20
>  	/* if dst has more stack frames then src frame, free them, this is also
>  	 * necessary in case of exceptional exits using bpf_throw.

[Severity: High]
Does this cause massive memory bloat when verifier logging is enabled?

Because is_state_visited() caches states by calling bpf_copy_verifier_state=
()
and adding them to the explored_states list, the diagnostic history is copi=
ed=20
for every cached state.

Since the diagnostic history can grow up to 1024 entries per state, caching
this for tens of thousands of explored states could easily lead to gigabyte=
s=20
of wasted memory (hitting memcg limits via GFP_KERNEL_ACCOUNT or causing
-ENOMEM) specifically when a user enables logging to debug an issue.

Because cached states are only used for state equivalence checks and precis=
ion
propagation, neither of which use the diagnostic history, could we avoid=20
copying the diag_history into cached explored states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D4
