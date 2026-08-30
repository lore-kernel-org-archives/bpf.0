Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F63803E9
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075910; cv=none; b=bKyrQJMyjE1vf5Pz88GYJZ3tz496NqhJ/XLtnePlZwvG6ZqSiedROXBv6IuX5/gvl96/su6ojlxLNbGjrlzvrkGtIKxaeSvjrvEW+5ZzV2+/bDnRMactV/w9XdyGpaKwC9sFjcRGHWgL8fDzFha0z18KdXmOEkVYLoPFgOlyPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075910; c=relaxed/simple;
	bh=uUbBUYHl8V7UyF19XeJVmHGVH9bqyX9aFedG2C6O3eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHrZiuNZwkVgK7lXMYcAzeJ1bUJajXE5uYyWlXeeCyQKxtP0oO870tiqkzTPPLW8uiqSrGFZHYmEV8vlfB2MPJsc5rlqfMotfX+Z36iZ73iFs7xvkLMCCCX8hAF6QY7KExr8+LnMNbA3n9vVV+dD+miQNgi+YZVbviI5M5N0Ip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCzqKfTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCzqKfTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B11F00A3E;
	Sun, 30 Aug 2026 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788075907;
	bh=0PY1qdvEbCQfaR/oyHXW2Ik0+eAucOMbWFGIiW4K81E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCzqKfTrcDU82n/nWIdOtwU98vbsxEGsTDsYYjIgblXofeqRYR4Novvgf6VjvzCA6
	 AZzcWyob54bRk6ND9Fd2na1gAJt+8Ta591mako4cp1ZtADXzt6dJ1cw0RcnAecpdj8
	 CaYu4X6EHm/eZiyCFDPyshfPSGKqhrd9Rr5HrirRRGvHPr6Ea/rNjY/QM154YzLwyj
	 8Ydhn39QIRqkDlybTWuONZJx9+wPMLCE2i3CZwj4WR+Ls/WZCGvXMe+9LgTbzQQEd2
	 pwRIQHTUAwly4lTfIzvmxLLIyVg8nEJU7cY0BVrivWUhTpV5mt3L/CG2++E2gsahCI
	 OF+vBkdwKOSJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: allow terminal gotox instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260830073125.360934-1-sidchintamaneni@gmail.com>
References: <20260830073125.360934-1-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 07:45:07 +0000
Message-Id: <20260830074507.876B11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_throw kfunc is incorrectly rejected as the last instruction of=
 a subprogram.
--

commit 2856cb56c044a060705479701aa63316b773e7de
Author: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

bpf: allow terminal gotox instructions

This commit skips direct-offset validation for gotox instructions in
check_subprogs() and accepts them as non-fallthrough terminal instructions.
The actual targets are validated during CFG construction instead.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b9..44195ec1445d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -3106,7 +3108,8 @@ static int check_subprogs(struct bpf_verifier_env *=
env)
>  			 */
>  			if (code !=3D (BPF_JMP | BPF_EXIT) &&
>  			    code !=3D (BPF_JMP32 | BPF_JA) &&
> -			    code !=3D (BPF_JMP | BPF_JA)) {
> +			    code !=3D (BPF_JMP | BPF_JA) &&
> +			    !insn_is_gotox(&insn[i])) {

[Severity: High]
This isn't a bug introduced by this patch, but does check_subprogs()
incorrectly reject bpf_throw calls when they are used as terminal instructi=
ons?

The comment just above this block explicitly states that the last instructi=
on
of the subprogram can be a bpf_throw call.

However, the if condition only allows exits, unconditional jumps, and
gotox instructions.

Because there is no check allowing bpf_throw (like checking if the call is a
throw kfunc), will a valid BPF program ending with a bpf_throw instruction =
be
incorrectly rejected during load when it hits this validation?

>  				verbose(env, "last insn is not an exit or jmp\n");
>  				bpf_diag_program_structure(
>  					env, i, "subprogram can fall through",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830073125.3609=
34-1-sidchintamaneni@gmail.com?part=3D1
