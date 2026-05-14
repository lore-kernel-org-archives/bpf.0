Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BB2D061D
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799203; cv=none; b=Emgh5qmPKMpq2Esi2wvu6z+yAuGaSvDv+NKbp4lKg35OcnGUP/aq+0kURa9uQ+GYLr/HKGttmg1RioyR/dYqNSOsAol1Zp+qGZzBDA+9u7/+7zgxIwxKOZOI7UkwePAxeXZ41oDOA4iAU1EkjNm9TMUM50a05wMabBIgwUXc2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799203; c=relaxed/simple;
	bh=AFb4LkFUJ9e3I6QwaQDz6KsZV/WwydzmYHCagdYnq4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZxtJPZ12tPrrOY+Tj863MFUUl6lDKzNKxTsweBk3aTKQksgdH5qQaQ2miHeTE02Xo2zyEl2frx6R1X2oUJVBrGGpx3v1iW3pSxyC2zP5y4pBIuhQGFx+B0SSt9Df4ueoxo0uPwU/QPLnBYB2RqQhkpY8HGB14nKZkTUIkfjHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPDRZ+M3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPDRZ+M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0118C2BCB3;
	Thu, 14 May 2026 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799202;
	bh=AFb4LkFUJ9e3I6QwaQDz6KsZV/WwydzmYHCagdYnq4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fPDRZ+M3bx8lno3YUJPPNdqS9N2vP52w+MsXv7Gy8/RSoN7U7jZtFy4sOpCNc/IXU
	 EuUxpqRPtPCPk54QLUiPbiWGQHesS1VSo2zH5z54HxrNCQKJwbmQY5C3dKU3vr4qBo
	 7+N2lml+txWwAd0x9R9FHNiyc6+3wQbE0dogz6cWvNsox0yGjPG9BfIq4U0fNbc+Uz
	 siXlH21EupfKI43t+NdoDO2z2FkKqYkLPHUpmsaPjFVqEOhAgMpQ1F+3CAFnL2OAj5
	 FkNPliuGXr0PHFn9sWXXPazB0UPpOaOi+oAqjShXKIpy22eCaR501/1Zcl+TBntxkA
	 6xTr7GRQHa78Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 10/25] bpf: Extend liveness analysis to
 track stack argument slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045043.2389049-1-yonghong.song@linux.dev>
References: <20260513045043.2389049-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:53:22 +0000
Message-Id: <20260514225322.D0118C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect logging of stack argument slots in `arg_track_join`.
--

commit 5139934569dff44b05e1ee083e4eb084fdca15e3
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Extend liveness analysis to track stack argument slots

This commit extends the BPF verifier's liveness analysis to correctly track
stack argument slots. It expands tracking arrays to cover MAX_AT_TRACK_REGS
and propagates the tracked state through function calls to prevent incorrec=
tly
poisoning stack slots derived from frame pointers passed through stack
arguments. It also updates logging functions to expose these new stack
argument states.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 13dc5ae44d2b5..7f4a0e4c2c49d 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1630,7 +1705,7 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
>  				continue;
>  			ti =3D target - start;
> =20
> -			for (r =3D 0; r < MAX_BPF_REG; r++)
> +			for (r =3D 0; r < MAX_AT_TRACK_REGS; r++)
>  				changed |=3D arg_track_join(env, idx, target, r,
>  							  &at_in[ti][r], at_out[r]);

Is it possible this will misleadingly print stack argument slots as
non-existent registers?

Since compute_subprog_args() now iterates r up to MAX_AT_TRACK_REGS,
arg_track_join() will receive r >=3D MAX_BPF_REG.

Looking at arg_track_join():

kernel/bpf/liveness.c:arg_track_join() {
    ...
	if (r >=3D 0)
		verbose(env, "r%d: ", r);
	else
		verbose(env, "fp%+d: ", r * 8);
    ...
}

It seems this will log stack argument slots as r11, r12, etc., in the
BPF_LOG_LEVEL2 verifier log, rather than their proper designations (sa0 to
sa5) like arg_track_log() and print_subprog_arg_access() do.

Should arg_track_join() be updated to handle r >=3D MAX_BPF_REG to maintain
consistent formatting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D10
