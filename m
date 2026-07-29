Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580142047A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358166; cv=none; b=J0Rm+qaY7mD7btt+/XOXVoiKss9yGpvlYmtL1qdKjVJJw22Mh008TOzWX0mVYijCPOyd5yabChuCeM+EwRhYMVcmmqegX0LQhfGpu0Rwq91n0pwAzk7kFlwNYqEDxUvtsM4oBMqsDcTpLNB2BqHOV93stcs6PZZ1QBpAsKfgalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358166; c=relaxed/simple;
	bh=DUproMlTvI6slTjj9y6FX74f0H9pMVM2SpoJHeTfCDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l20RDGbpbOmvafeoUqcKdxQ3Bev6i0Yantem1uiPMuSvcyuWrwObMSXPws6J17o5GopE/gE4sqr9dultr3EObPbXh98TYDG4tS4FJhvc2naUv2n4ECQb8OgVo024xNdZOdszDH1cDG2exDAcnBepTyFbd9nszuB/o0xqFTLYMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODnz3KuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODnz3KuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14031F000E9;
	Wed, 29 Jul 2026 20:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785358163;
	bh=0tEwnuuvpVcOBhse9/jUjmtaDK/WTtzFPf9mPmfsD/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODnz3KuOPpgpbtQJA7eYswCxD2tYaFWzyL3FxaaHAQ/mjaaH3u4vv7++4I/A0vezx
	 P65VIapZq+MIc3y3vKGkvjlgpbYmrnh0x9NvSHGSjneTtmbmB4YyzCFKyALg2BaO4v
	 bbDTEd8HgDjgnmOL68XuiflIVnrv7shUdXImdMsoS+WIv4/5q+luUoAA44+oubE3Gb
	 of7herQDofjpru9hpjvOAoI5caaGRyv2VVQiwoXyZhD+FpguQL4VO8D6wKLiH9W/i0
	 bHhlab5FEmbbfWihRtRYhTg7K8aIsFdHdKG+TgaGvngDlEd7N9oDCHIXYddbiQaxBt
	 eQsxOEttE3VFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Correct the overflow check comment
 in bpf_iter_num_next()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729203633.213973-2-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
 <20260729203633.213973-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:49:22 +0000
Message-Id: <20260729204922.F14031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment in `bpf_iter_num_next()` does no=
t follow the required BPF subsystem comment style.
--

--- Patch [1]: [PATCH bpf-next v4 1/6] bpf: Correct the overflow check comm=
ent in bpf_iter_num_next() ---
commit 385d10f67ceb46ec31888afb23333c5f7645c9f6
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Correct the overflow check comment in bpf_iter_num_next()

This commit removes a redundant 64-bit cast in the bpf_iter_num_next()
iterator loop and rewrites the associated comment to correctly describe
that the 32-bit wraparound is intentional for handling starts at INT_MIN.

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index f5eaeb2493d4a..f190f2b250048 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -802,12 +802,14 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_=
num* it)
>  {
>  	struct bpf_iter_num_kern *s =3D (void *)it;
> =20
> -	/* check failed initialization or if we are done (same behavior);
> -	 * need to be careful about overflow, so convert to s64 for checks,
> -	 * e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't just do
> -	 * s->cur + 1 >=3D s->end
> +	/* Detect the end of the range, or a failed/empty iterator: all of these

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style?

The BPF guidelines specify that multi-line comments should have the opening
/* on its own line, with the text starting on the next line. Since this
comment block is being rewritten entirely, would it be better to update it
to match the modern multi-line comment format?

> +	 * leave s->cur + 1 >=3D s->end. bpf_iter_num_new() set s->cur to start=
 - 1
> +	 * (which wraps to INT_MAX when start =3D=3D INT_MIN), so the s->cur + =
1 below
> +	 * is a deliberate 32-bit wraparound that recovers start. As s->cur and
> +	 * s->end are int, this is an ordinary signed 32-bit compare, exactly w=
hat
> +	 * the inlined bpf_iter_num_next() emits.
>  	 */
> -	if ((s64)(s->cur + 1) >=3D s->end) {
> +	if (s->cur + 1 >=3D s->end) {
>  		s->cur =3D s->end =3D 0;
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729203633.2139=
73-1-puranjay@kernel.org?part=3D1
