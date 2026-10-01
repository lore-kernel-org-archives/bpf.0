Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AA33A700
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819496; cv=none; b=acryp4G4sS9zTU0sjpcf5YRjFfbWfD3Biv972fC4Ox/3SV1mFgNSBACBGYo7MuEvqc1yYo8lujiP0XFHLUEXab+IaTjBbwiF3Twpjf2Fu4CVUBgIbVAP/2wB8INqm47mPTIyhk9w3/rqYmmmj5+H1mb0i8VWfICYubZYiygffyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819496; c=relaxed/simple;
	bh=+ZTG9bHIhTaEowa7FuXsfvurN6AMObtrIin3+4ARnLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5Vqq8AF9AnZuXMyQyNcYaSNy0lpootJeqe7zrszIsFcjSRcFCPNdrLgAfKdOpptpUUW9H8nqkBouO6c5u9KaqKlPFyt9VvZUacagsTCwliDz0EelStjQv/VPiBuDodk57aChacj1AAT/BVor3bRKvs+zsM8ZZM6IosOZXeyoSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnyt7Z8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnyt7Z8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488BE1F00899;
	Thu,  1 Oct 2026 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790819495;
	bh=qZ7NP85/gD6hlpTvLg+wrXArnYwWT/NI7RAU40/EXXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cnyt7Z8k559jsYOu2AqPfUQz20KkIpB80KwebM4HnPy5D5XJntWWEJdzlgprvNP98
	 voOxubRB3DpA/OvpHpNyCkiP7KQ9l46gO6XNb1s2ko6nXQVzTFzyscnROtJun3dKe8
	 khf1UTbAU+4Gj9zM69p/hjWTLS69hmD8JphcXdqIsxnRm8MUBKEzRGqNXqZZVQ9+vw
	 PJ94pEAOQEP3TvSVBT4hdTmGy9rdirs5QxQabU3U590fYz0o5kmYxKR7R4Cb8XNZsl
	 pDxLAMR4wa5kpWsP5KD3+cpeUpM8kJp72NPy29QKR9YZgRxSdbR86NhuizIC3gc8Xr
	 XB+oZK6YPT0IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 5/6] netlink: specs: rt-route: describe lwt
 BPF program options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-ynl_rt_encap-v3-5-4106c21b9ee7@kylinos.cn>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-5-4106c21b9ee7@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 01:51:34 +0000
Message-Id: <20261001015135.488BE1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] netlink: missing max-len validation constraint for string attribute
--

commit f56da32d0f53d2458e2f20c65435e7f6e11b64a4
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwt BPF program options

This patch replaces binary BPF attributes with a nested lwt-bpf-prog to
support lwt bpf prog options in the rt-route netlink specification.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 7649797602eb7..afec0375661f5 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
[ ... ]
> @@ -621,6 +624,16 @@ attribute-sets:
>        -
>          name: hwid
>          type: u8
> +  -
> +    name: lwt-bpf-prog
> +    name-prefix: lwt-bpf-prog-
> +    attributes:
> +      -
> +        name: fd
> +        type: u32
> +      -
> +        name: name
> +        type: string

[Severity: Low]
Does this string attribute need a maximum length validation constraint?

The kernel's LWT_BPF_PROG_NAME policy restricts the length to MAX_PROG_NAME
(which is 256). For netlink string specifications, this usually means adding
a checks section with max-len: 255.

Without this declarative constraint, the generated userspace tooling will n=
ot
restrict the string length prior to constructing the netlink message, forci=
ng
the kernel to reject over-sized strings. This bypasses client-side validati=
on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ynl_rt_enc=
ap-v3-0-4106c21b9ee7@kylinos.cn?part=3D5
