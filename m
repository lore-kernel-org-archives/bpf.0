Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE23AB28C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561407; cv=none; b=M24MrIRzwHPND9fvAxKeApzI2VDKPBdwCtv+MgBH+fktO5suddV3fBXv2bYa5n82T+FBOwIb+VckxHfz6GpP0rvgw9oO4MIR19gYq3ZT765LesWWjCIUz9Pl8Zi2HeRI8pV7DBlbgA91FIYM7SK9BXUivpa8C1BGEohVyUrRDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561407; c=relaxed/simple;
	bh=PbK0mFFzXNuNKPf2KPYmqJT8MVWiELNVN3UpARkItPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K89btMP+Z8WemuL96DdQ1xYsEO+6Jh7aeTL8AtgiqFizjeyZQIiSKiHfKtI4iooyxJFIsbnbwzCtNvFkYp7ZC5Di3A0T54RNwIS6JKF7cQiixBEOj9hroyO26x1arTCWzZj4EcEkPSCk270J7EUGvzWXHqsUgfZyQbKPX46eNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ27uITM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ27uITM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A070B1F000E9;
	Mon, 15 Jun 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781561406;
	bh=2B8G7fpcuchTfNc5EzWuDZ47/ROqVrJ9GClgn5bfaqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQ27uITMD7f11Mc7VRTlwlpa8dTexorNT2uxlRT+S0XSa5t7Yn1TfX6Gm4DRlnvM1
	 4V0ElVYpfq/4ufuakVQdivNZCZ/Mtk+h2aPPlsCrtAr5U6AvkmUWlTtTWhxd3HYBk8
	 Yti/h88ghaTI0i1OCt7v0C4g7uqxOwIetuOxg9/0CI5qZPhEeK9MFt+dyuDDMKW9yh
	 sqsksCFAP0Y2kCNmawchtxZxoR1WFpF/Aq+L2VMnqjOgpKa06ttqSLLxuGVyg2eN1t
	 JJypn1VpExCM+HF6y1G5MUPxONb7Z3wMKCb7ZuitBXuujIyihnX+r1WchXDsUHq6PY
	 5lr43tRuv2CAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <fe46367f8e2c2ae81e626e71d200dbfc3e7d644f.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
References: <fe46367f8e2c2ae81e626e71d200dbfc3e7d644f.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:10:04 +0000
Message-Id: <20260615221005.A070B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free due to lost packet-ness for ARG_PTR_TO_MEM in g=
lobal subprograms
--

commit 92dda8a7f4645930c007cf11da0767480bfbc820
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Fix packet pointer invalidation for skb dynptr writes

This commit fixes a missing packet pointer invalidation bug for skb dynptrs.
It adds conservative static CFG predicates to track when global subprograms
might modify packet data through dynptrs, ensuring proper caller-side
invalidation.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -18763,6 +18875,7 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>  			} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
>  				/* assume unspecial LOCAL dynptr type */
>  				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
> +				reg->dynptr.may_be_pkt_data =3D true;
>  			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
>  				reg->type =3D PTR_TO_MEM;
>  				reg->type |=3D arg->arg_type &

[Severity: Critical]
This is a pre-existing issue, but does this generic memory pointer need
similar packet-ness tracking to prevent a use-after-free regression?

When a global subprogram expects a pointer to a sized type, it is
categorized as ARG_PTR_TO_MEM. The caller might pass a direct packet
pointer or a packet-backed dynptr slice, which is allowed if bounds checks
are satisfied.

Because the register state is zero-initialized and not explicitly updated
here, the dynptr_may_be_pkt_data flag remains false. If the subprogram
then calls a packet-reallocating helper like bpf_xdp_adjust_head(), the
clear_all_pkt_pointers() routine might fail to invalidate this register
since reg_is_dynptr_slice_pkt() would return false.

Can the subprogram then continue to access the reallocated and freed packet
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781539813.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
