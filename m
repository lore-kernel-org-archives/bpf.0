Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E4402B96
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642712; cv=none; b=a2lim8LnXK8TAZjkYUxEyXae+kxb+VOfsCFYmeIJU9XwbfpJqxKGp4cf8CMUq4tS70uFUGCQwwoXJLp27c4WEs90y09pG1T0MZzpjVUSdNWA3jSnkH3/NbINC3n/s5YLklCIWhOMq36hG0zKJ0tutkADVOpjnDvDohIDnPvqQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642712; c=relaxed/simple;
	bh=1fKSoIOfGGjk1tII4gPpyEBBj+HMAjzHxZa4WH1eYx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQjbrYB3NyFuJZcx1UhcDPLtYlRAyA44aaDOIj+1Y5VzV/WL2ls9/fqeZgEWBnwoJi8W7EA80ctGFhgUHQdCXf6gfoveEda92gR6vwDT7lwiFCf4ofQhLlov3uYNVo+zdznYXVtBX2z/9XWniIZs1IhjMqvWIcu3CWOKfvxrtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT3IFdOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT3IFdOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27261F00893;
	Fri,  5 Jun 2026 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642710;
	bh=uLI7U41Bg1YIRpUGNOLeJXIRs77gt1LB3TkDo0IOwsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YT3IFdOjVztMhmJz4mm6z6ut2CRMxQ8VepnSUObNpVUj81DM/9PVOX+4YhBDWlCLY
	 ID7oRSnKxhHBQGZLBFlsZucHsUg2rpgyF0OygEYRgQFe8uEF0jaO5ALAvHbjiii8rI
	 6V/uE/nDAVspDhWcG9W6uj86VLFvwH0bOR4Xa+yk2+MTCQXFeCxo5mF9SWpH4iv8gB
	 6dgN82jt3+X5UTVjdWbWSR9mIQkjRsh3ufi1pHk6KMWdEnbjXkjPoe6LDeQrXOHP9W
	 NLZ1q99xf+InhgbLRdRIv6z2V2e76b0sFbmATgBOFv1bkVFK5jbXqjycmwNZ2lLm2+
	 gGQNR9fKito9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 17/17] bpf: Gate verifier diagnostics on log
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-18-memxor@gmail.com>
References: <20260605063412.974640-18-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:58:30 +0000
Message-Id: <20260605065830.C27261F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `push_async_cb()` function fails to initialize `elem->st.dia=
g_enabled`, inadvertently disabling verifier diagnostic history for asynchr=
onous callbacks.
--

commit a1006ba17aa95830cb0240bca35f5e001fb80ed7
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Gate verifier diagnostics on log level

This commit conditionally enables verifier diagnostic collection and
reporting based on the requested log level. It avoids collecting path
history for BPF_LOG_STATS-only loads, saving resources when diagnostics
are not requested.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3446ee9acaa1b..359c4f4c0d422 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19238,6 +19238,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>  	state->speculative =3D false;
>  	state->branches =3D 1;
>  	state->in_sleepable =3D env->prog->sleepable;
> +	state->diag_enabled =3D env->log.level & BPF_LOG_LEVEL;
>  	state->frame[0] =3D kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOU=
NT);

[Severity: Medium]
Since push_async_cb() also sets up a fresh verifier state without copying t=
he
caller's state, should it initialize elem->st.diag_enabled as well?

Currently, push_async_cb() initializes the state like this:

	/* Unlike push_stack() do not bpf_copy_verifier_state().
	 * The caller state doesn't matter.
	 * This is async callback. It starts in a fresh stack.
	 * Initialize it similar to do_check_common().
	 */
	elem->st.branches =3D 1;
	elem->st.in_sleepable =3D is_sleepable;
	frame =3D kzalloc_obj(*frame, GFP_KERNEL_ACCOUNT);

Because push_async_cb() leaves diag_enabled initialized to false, it seems
diagnostic tracking will be inadvertently disabled for asynchronous callbac=
ks.

If a verification error occurs there, will the verifier misleadingly print
"no recorded diagnostic events on this path"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D17
