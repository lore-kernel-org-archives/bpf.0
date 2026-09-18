Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3337C908
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713418; cv=none; b=bZuT6pIHyehYKf7aAkuUKLy8Sc04dwSZUwF+u9gDMpgRGVD4pOj73IRuE+LqFHnWK3kCRxHlTaIWaAkl7S+QPpIo6rOCAQzUgFekqaR3GcFDl4QlB0CHSBFPM+/xqYGPaUiFWsdiQeB7rPMb+BWjHVDAE9lrUiuuoWYxxy2MEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713418; c=relaxed/simple;
	bh=XM0VxNTS4d1RsUnYH5LqSLp5E+AXeact4oTKOg906vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMDdFMm8qHk+Ii7JKl9xnl990AuDzqS+F/asLYlssc5mwtB4ErCVRd2eM/951ticpODLdezOKaArmyXqHamilefe4UxPnGwCzQ1xkJ/5o/GcV3meVBlK9uOT2LCNrpKcz9XjQtYvRt+8PrfSkJeIvbm7s0gckq3xLJfQjELI9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP4Iok7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP4Iok7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1DC1F00893;
	Fri, 18 Sep 2026 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713416;
	bh=+7yvLTM7O/GGIX195wi8x9xxSiQ+K6gKo/WtPNw+h1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AP4Iok7yo27ci2gP2vZW78kPp2t3RF5gg9ar/9OxMt3tvan8gBVZRERQADv/ocaLG
	 CslbbqzYeWIdppxUYxfojWWFLHjeaKJaXx6df0R7PV32+l/laHXnZP6dlMfNc66vaR
	 i1LLMN0f9+iDdJDNht75MtHV67ejWLzNUKVKVh77OxNqHszViDIYQcQuRslaxgcoEL
	 uCseTpvvyGBweRg6iT1WR8aK0xcGJULJapWJ1fe8gTjzZbM7NtSt5Pij294Gmwlpvu
	 gN4rO8Zl4Uvbm12kxJNBkEp1ioX909024U9PdoRegAEDO9/yfNl6pmhEcwK7Iaxugx
	 eXvWb2c7raxSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:55 +0000
Message-Id: <20260918063655.EA1DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] netlink: specs: build failure due to missing header in lwt-bpf-prog
--

commit 73e4e6736fda4554b1e22b6360a42d9d2e02b4dc
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwt BPF program options

This replaces binary BPF attributes with a nested lwt-bpf-prog attribute
to support lwt bpf prog options.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 6030d7cb8d0d1..5e9537f7dfad4 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml

[ ... ]

> @@ -610,6 +614,16 @@ attribute-sets:
>        -
>          name: hwid
>          type: u8
> +  -
> +    name: lwt-bpf-prog
> +    name-prefix: lwt-bpf-prog-
> +    attributes:

[Severity: Low]
Will this cause a build failure in the generated YNL tools due to a missing
header?

Because the header property is omitted for the lwt-bpf-prog attribute set,
the YNL code generator will automatically output the C enumerators
LWT_BPF_PROG_FD and LWT_BPF_PROG_NAME in its generated header.

Other attribute sets in this spec correctly specify header: linux/lwtunnel.=
h,
which causes the generated YNL header to globally include it. Since the
kernel header linux/lwtunnel.h already defines LWT_BPF_PROG_FD and
LWT_BPF_PROG_NAME, compiling the userspace YNL tools will result in a fatal
redefinition error.

Should a header property mapping to linux/lwtunnel.h be added here?

> +      -
> +        name: fd
> +        type: u32
> +      -
> +        name: name
> +        type: string

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-ynl_rt_enc=
ap-v1-0-fbbe6e680571@kylinos.cn?part=3D5
