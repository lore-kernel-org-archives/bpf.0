Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B2352026
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292902; cv=none; b=ukYjThmfQCO4dfC4e1ONQ/QeEdYMA1PlsZ1fbYZt11HpO363lAh/LYdmuDpi8OqpA0TC/EvpVcTeKVsc1PAsgKNeYkrg/M4mASerNAPnoAVmNqVOjDmQEpfUF25XmiyKrytt09wTcylQYcH4HabCurH+NbjwqSNGBwTOqtSI6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292902; c=relaxed/simple;
	bh=/fhFfwU4E9D3ERbz6a03Xh8GMG/Pm8KlK+l/18jTEfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnmW9k37eGU5RmBMG94ALwEflCsNLc304P1CaT+iDpqfUUR1yKgsxIzsyp5fRUHV5zvSVAYjlSNUemtPDwnuubP2mLfaIZBNhAC/CwjzNAvAHjQn7Qvx0vKQO31I4b2wSZvaDGf47PfpgDMoXuEYkqJm0J+lb2Ozd9R/Bo9+qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrFv3RLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrFv3RLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FB1F000E9;
	Wed, 20 May 2026 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779292900;
	bh=240shqyEhRMaIEl/T5z3sv1NNei0H7foMx4SWXfvvlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IrFv3RLlWor2Klzfh2gY7vmMQlicHCxT1KdYC1SIrsJVYhizsd75k/a0KA7WWnq/l
	 MbB8wKphhtGg0En34uoPy7+dxKSs19RYhwumMGXeYoMEl+bUSZO/EElJYz0DGvf6pg
	 aBkllWW8ymh7YHbe35A6a+qfpuw6kEkoXCvlzR3Y4iuIOeCwGXn8j7PJToUWe1X3BK
	 P6KHwWHWHXXKujXE/zcNo1N9gPVS707DRG+uVFKUo/P2eJerQO8CDZcJ+XUDJQFj5Z
	 rJXy0KLzTPfjpwSJrQh7S50GVNSolqeFR4BqMq8WmGQ9C7i/k9/m3IiTWL0lVYJB7R
	 O0drNNLNvQNww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/20] unwind_user: Stop when reaching an outermost
 frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-9-jremus@linux.ibm.com>
References: <20260520154004.3845823-9-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:01:39 +0000
Message-Id: <20260520160140.8B7FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized stack variable read of `outermost` field causes pr=
emature termination of user space stack unwinding.
--

commit 6e5baf1a7025f1ab5a73320fe2e522b5d83d132d
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Stop when reaching an outermost frame

This commit adds an outermost frame indication to the user space unwind
frame structure. It checks this flag during the unwind process to stop
unwinding when an outermost frame is reached.

[ ... ]

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 1fb2724197332..fdb1001e37505 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -32,6 +32,12 @@ static int unwind_user_next_common(struct unwind_user_=
state *state,
>  {
>  	unsigned long cfa, fp, ra;
> =20
> +	/* Stop unwinding when reaching an outermost frame. */
> +	if (frame->outermost) {

[Severity: Medium]
Will this read uninitialized stack memory during sframe unwinding?

Looking at unwind_user_next_sframe(), the frame structure is allocated on t=
he
stack without zero-initialization:

kernel/unwind/user.c:unwind_user_next_sframe() {
	struct unwind_user_frame frame;

	/* sframe expects the frame to be local storage */
	if (sframe_find(state->ip, &frame))
		return -ENOENT;
	return unwind_user_next_common(state, &frame);
}

Since the new outermost field isn't populated by sframe_find() until a later
commit ("unwind_user/sframe: Add support for outermost frame indication"),
could this uninitialized read evaluate to true and cause premature terminat=
ion
of user space stack unwinding?

This would break the bisectability of the patch series.

> +		state->done =3D true;
> +		return 0;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D8
