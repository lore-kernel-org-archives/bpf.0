Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884733BBCF
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819495; cv=none; b=Q/EPYHoUD1GbEbJsJMz9syPdHztu2p33qlB6ryXIpel/meIfEfzap3qbivDwXEaZYnDKVTj6lJG6KNXf5mZVXQKq+pWlWPdjuJp0J+6RbteVdV2fqMJivsZOuJQS/MkDt9FA9+6RGzdZCRy6aniuat6Xd1B2ztvP+yDaNeZndrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819495; c=relaxed/simple;
	bh=C7MBiTG2wL0mOhw+7ldHD6yK8MgvGjlpsZtOnER8kMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+X/ElWvb1vjvsG6JmUt/OAxf4Jluwz0coxoOgo72G2sLoAtLR93gRMuw62EhYUUb24gzWE+rE14O74f6P6y+jit1/XSCgi36kSknoa2hsTWYUhsewbjarrouTsrQXMI1iIiIWfMWJtRiKDYFolYNnKTmPZF//mYqtnE9p4Q4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1HSjXsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1HSjXsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E361A1F000FF;
	Thu,  1 Oct 2026 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790819494;
	bh=yemv/x+oDWgtpO58lMEwXAByYMxVsBx8v645F8UyoIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1HSjXshuCswQAUPV/mBjHC2Z4q+fL9mr6MVwz/595ONxw7goRiPhK8/dZ8DI1WBN
	 bRwWEiuMCIANTV4OVaLzl97spDXqq1ShbBE0f3qsC9irUsyZ1zZHLu4HL7XaS0U9ow
	 95p47ONVcBcgbVq0NXPeMX6fjxakdakOTSLn3AvoqfyLItuJ6qZZIM9QIGkezN5PqU
	 Yz5lenXYWYHC46Epke6jHC+3jZh6nkJjoNRtefuq5aXXPCQw7/dSsm15uRUUa2qwkD
	 zpYoANcB8K/RqYYnRn3sysruU+leRbuCfKS6hgE37//HHJuLJwJCxxd3FuvInXgkJj
	 I5SbprHUL5jGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 6/6] netlink: specs: rt-route: describe
 seg6-local attrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930-ynl_rt_encap-v3-6-4106c21b9ee7@kylinos.cn>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
 <20260930-ynl_rt_encap-v3-6-4106c21b9ee7@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 01:51:33 +0000
Message-Id: <20261001015133.E361A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] netlink: incorrect type: flags causes uAPI mismatch for seg6-local=
-flv-ops
- [Low] netlink: yaml naming convention violation in seg6-local-flv-ops nam=
e-prefix
- [Low] netlink: missing doc properties on new major yaml spec additions
--

commit 1d8d137d71e90b2ea51b5a3ae23d03831ee06b0b
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe seg6-local attrs

This commit adds SEG6 local actions enums and seg6-local-flv-ops flags to t=
he
rt-route Netlink specification. It also replaces binary attributes with nes=
ted
seg6-local-bpf, seg6-local-cnt, and seg6-local-flv definitions.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index afec0375661f5..0260fca398d2c 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -116,6 +116,45 @@ definitions:
>        - rpl
>        - ioam6
>        - xfrm
> +  -
> +    name: seg6-local-actions
> +    type: enum

[Severity: Low]
Does this new major property need a doc field? The Netlink subsystem
guidelines recommend that each major property should carry a doc entry to
explain its purpose.

[ ... ]

> +  -
> +    name: seg6-local-flv-ops
> +    type: flags
> +    name-prefix: seg6_local_flv_op-

[Severity: High]
Can using type: flags here cause a uAPI mismatch with the kernel?

The kernel uAPI defines these operations as sequential values (for example,
SEG6_LOCAL_FLV_OP_USD is 3). When type: flags is used, the YNL code
generator will emit bitmasks (1, 2, 4, 8), resulting in
SEG6_LOCAL_FLV_OP_USD being incorrectly defined as 8 in the generated
headers.

Would it be safer to use type: enum to ensure the generated values match
the existing kernel constants?

[Severity: Low]
Also, could the name-prefix use dashes instead of underscores? The naming
convention for YAML specs specifies that names should contain dashes, as
the code generator handles converting them to underscores for the C code.

[Severity: Low]
Additionally, should seg6-local-flv-ops include a doc property?

[ ... ]

> @@ -634,6 +677,50 @@ attribute-sets:
>        -
>          name: name
>          type: string
> +  -
> +    name: seg6-local-bpf
> +    name-prefix: seg6-local-bpf-

[Severity: Low]
Would it be helpful to include a doc property for this attribute set? The
guidelines mention that new major properties, such as seg6-local-bpf,
seg6-local-cnt, and seg6-local-flv, should carry documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ynl_rt_enc=
ap-v3-0-4106c21b9ee7@kylinos.cn?part=3D6
