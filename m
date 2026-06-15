Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67C25B0B1
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534103; cv=none; b=i19tn7s5Adoa2lWAvuLf9eMGosn/Kz22znCIt+qt4JhC5gVHa1WgmRDmA8xNT/paM/5nmpf+so26ywgFjB5xsrqaOg1wQo6grpb1evLjkqMsMbffmj0ix7tEb7lbZHs5RrUCWQhP3DsJC7kQZen3Vjqtf06NyhFouoIWNfUSwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534103; c=relaxed/simple;
	bh=O+LT05ZdO9/zSGq1UtRlCN+FK+oAUXgzJ4T5WS7aZnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XT1vwQ5g2+p3DBtC8mGepDtWeNiIDd0cVCx/+bbHM6lZBzR3GLxbgyKMRCCu36OlxHUL5T0y9THEtwg0U4ebs49DbKBuqzG9TFJb2AkW0NB6kdYXtYCXtlgPzajA/WqhAzmo3oAhG903Sp10hKtjl17lvAEV9A+yv2ogz1y3Q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI+4vCiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI+4vCiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837A01F000E9;
	Mon, 15 Jun 2026 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781534101;
	bh=KAXVAORW7Y2U8ZseOzzqeFknvAW0A+ham2L0g6fN2Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SI+4vCiVHyArIG+PpXTF65/a/aZUIT9EcjFoAns/gvfcnq7Ve5PxspxtiSeXYXodY
	 QOv7Fs65B8fxFqBS3MErvqM9y55yKhW/mJCY+al5Xt0dWMgbpDkSBfQq/2Aix5hMH9
	 0ybcBP8IrSjWMI6ikJGYELUh0Tlz2KtW85lz7r1R3tDGTOq0emVNIuxcwO9Nwz79Ld
	 8muamRCXAMZ2M5spyOi20uKOIm66GqjWByDFav0gKTtMX7vL7xr01sWPqIzzPic+3b
	 u7FLjeSiUxF6vWWCKMV8xFISgaca2uIP8+nzbTQYbbjagemh/ILYnsnyg8MC4A3TJR
	 2Wg2Fltou3btg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <baea5363a0e35d1dc16d41b972d9a9e89cc85b46.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
References: <baea5363a0e35d1dc16d41b972d9a9e89cc85b46.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 14:35:01 +0000
Message-Id: <20260615143501.837A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `bpf_dynptr_write` helper fails to invalidate packet point=
ers in global subprograms, leading to a Use-After-Free vulnerability.
--

commit a8b2f9ebe5479e8968087326226bb472f13ee1e0
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Fix packet pointer invalidation for skb dynptr writes

This patch ensures that skb-backed dynptr writer kfuncs invalidate checked
direct packet pointers, following the same rule as the bpf_dynptr_write()
helper. It updates the CFG analysis to mark these kfuncs as packet-changing
and invalidates packet pointers when the dynptr might be skb-backed.

[ ... ]

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 26d37066465f3..7ed6bdd986bc8 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -516,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
>  			 */
>  			if (ret =3D=3D 0 && bpf_is_kfunc_sleepable(&meta))
>  				mark_subprog_might_sleep(env, t);
> -			if (ret =3D=3D 0 && bpf_is_kfunc_pkt_changing(&meta))
> +			if (ret =3D=3D 0 && bpf_kfunc_may_change_pkt_data(&meta))
>  				mark_subprog_changes_pkt_data(env, t);

[Severity: Critical]
This is a pre-existing issue, but since this patch aims to make kfuncs
follow the same rule as the bpf_dynptr_write() helper, could there be a
similar regression with the helper itself?

When bpf_dynptr_write() is called within a global subprogram using an
unspecialized LOCAL dynptr argument that is actually backed by an skb,
does it fail to invalidate packet pointers?

In cfg.c:visit_insn(), CFG analysis appears to miss the side-effect of
bpf_dynptr_write() because the helper cannot be included in
bpf_helper_changes_pkt_data() without triggering a verifier bug in
check_helper_call() (due to its arg1_type being ARG_PTR_TO_DYNPTR
instead of ARG_PTR_TO_CTX).

Furthermore, during the normal verification path in verifier.c:
check_helper_call(), does the check:

	if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
	    dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META)
		changes_data =3D true;

fail to identify BPF_DYNPTR_TYPE_LOCAL arguments from global subprograms
that may be skb-backed?=20

If packet pointers are not invalidated, writing to the dynptr might pull
the skb and reallocate the packet buffer, leaving old packet pointers
pointing to freed memory and resulting in a use-after-free.

>  			if (ret =3D=3D 0 && bpf_is_throw_kfunc(insn))
>  				mark_subprog_might_throw(env, t);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781531784.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
