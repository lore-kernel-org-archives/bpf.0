Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9B35A938
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007329; cv=none; b=mmccTsFuj9nYKLKh4LzXB2hoOGSmNMwDerKwSfge723+YDzfbnDRFczci1Gh6fvMCwsY1XR305YgLdEMcOKT8gkpqRcKvNS57JVmFplkdBKY/kLsNOKsPaqFPGat09EfcvPu4zOpYsvzYCrzWlNLeDY/X0cwuIumdXoAnHpC/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007329; c=relaxed/simple;
	bh=XZm2Ut+Ma2RKQq/L3l06yXGeXi21lkPdRM38IC2/grI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGpYzujffjhVBjjUnVV0/oCHPnCHr/nAd8Xu6gLorV4fet69bqd5vkU3rcxmEV+GfyvHJre1Pt5BAs9oho02iD9kJQQ//WTxLv7s6xGwwiP6ud3QL+tMuYNWcN0pLEURO0xES2uahZC7hBI/aIegRLQUINocvgSxqOG2NnKX1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGgPlcOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGgPlcOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E529C2BCB4;
	Tue,  5 May 2026 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007328;
	bh=XZm2Ut+Ma2RKQq/L3l06yXGeXi21lkPdRM38IC2/grI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aGgPlcOT9tIr5QltZxqCtxf5ib2j1gppbppzUUd+B9wy9n1vMTQdQmJLumhRSAagm
	 Mvr12O7+1GaB1zPW/3ZOo6S2YtrqtGFjkDS9YA73TaZgi8IrU0iJOOvxQ0iCPwBNWc
	 oc9zYFVCAwIjnEW0jblYJK520K5U7B9rka6eKqtGM80/u1M61SxNL6KTGt9SFMGu74
	 7LcZHJxxbKtg4KEDL3L/S6k6GjZxqyxLjeequ36OGhW9+K4FQ4ltv1LvQR2m+0nDrL
	 grtYI8MNKI69kZptdtFByrBhI/tvalcy8hgCrF+WSml/1RkM71i5jr1Vk3s9YVBaxT
	 1ckpLmlI3k3qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/19] unwind_user/sframe: Wire up unwind_user to
 sframe
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-8-jremus@linux.ibm.com>
References: <20260505121718.3572346-8-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:55:28 +0000
Message-Id: <20260505185528.8E529C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded linear scan of user-controlled sframe entries can cause =
a CPU hard lockup in NMI context.
- [Medium] The commit message claims to refactor `unwind_user_next_common()=
` by removing an unused `pt_regs` parameter, but this change is entirely ab=
sent from the code modifications.
--

commit 2e1e17bbaa1c0426d41d66ce7930a944f3e86ae7
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Wire up unwind_user to sframe

This commit hooks up the sframe infrastructure into the unwind_user interfa=
ce
to support user-space stack unwinding via sframe. It adds the
UNWIND_USER_TYPE_SFRAME type and updates the unwind_user_next() logic to
attempt sframe unwinding when available.

>     [ Jens Remus: Remove unused pt_regs from unwind_user_next_common() and
>     its callers.  Simplify unwind_user_next_sframe(). ]

This isn't a bug, but does this commit message match the changes?
Looking at the diff and the code, there are no modifications to
unwind_user_next_common() or its callers to remove a pt_regs parameter.

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 90ab3c1a205ef..1fb2724197332 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
[ ... ]
> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_stat=
e *state)
>  	return unwind_user_next_common(state, &fp_frame);
>  }
> =20
> +static int unwind_user_next_sframe(struct unwind_user_state *state)
> +{
> +	struct unwind_user_frame frame;
> +
> +	/* sframe expects the frame to be local storage */
> +	if (sframe_find(state->ip, &frame))

Can this sequence cause a hard lockup in NMI context?

Since this unwinder is often called from NMI context (like perf), sframe_fi=
nd()
eventually calls __find_fre() to search for Frame Row Entries. If __find_fr=
e()
performs a linear scan over an unbounded, user-controlled number of entries
(fde->fres_num), it could spin for a long time without yielding.

If a malicious userspace program maps a large VMA and provides hundreds of
millions of FREs, would this loop calling unsafe_get_user() on every
iteration tie up the CPU long enough in NMI context to trigger the hard
lockup detector?

> +		return -ENOENT;
> +	return unwind_user_next_common(state, &frame);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D7
