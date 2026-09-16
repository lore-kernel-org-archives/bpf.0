Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCE477E2E
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545677; cv=none; b=SjvAm1jODcClTyE7FThe5zhVWDKJohLIcwW+6MW/Klf7vN/KT9famg48XFrNB+PkXsSsV8r4VDrTrZx72+qIFs+z4LlqjVcWJogGKdbTY4j7s0aWSuDM7wkHxrMNEBWIZZNoThek5RJsYqldDTvsQarZpOx0BFs5+Ch3qyspoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545677; c=relaxed/simple;
	bh=3q+KGIoRBI6laXGdJr0+HUNByVC7QYBswAMCdzCdrVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lp+WGfK6qFS9f6jKCHaHeb/M5+Q/75SFVr7eFHevltS9E+n8vBZDX3/6b3+FJbkPeh8x2SyT9daQdHkvRgpam9Wo1uPDE5ePR1xIeBQwuKXiV+f0kz3/JNwGn5sZZJqdavV8Pqkj+YmUdlKCpfO46/xnbVQIfzvs9T0V5XM3Byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6UuPWYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6UuPWYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87BE1F00899;
	Wed, 16 Sep 2026 08:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545671;
	bh=KxopHBr1wiOK3CpEJ9KyBcFzTgF3PR7koqDcrhq9O7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6UuPWYfrE3V6exTFWgiPpJN6twcL5wk1WcVuSiRrd657Km72HhoPPk1+sfkG06un
	 SOYIVIH1aDVfVKmciYUmxJoL0xkWpRCjczWpSO1UFbqHN6+EcCSg/jZ28khGY3KKaB
	 qYT2J3Y2yJM59yDpOJbZGSptpv03o/7NXsHSweEDmdNS9YXYY0NBpX6m75p4hdF5MA
	 eW/vytpASFkdB2dHxSKd4M8Kg41PPicuhJ5CWPbfOkR/Awq6xyNQiMIliFTm+fTAxb
	 n+dMC/HIhpTJ4cmRwgzVJzAug2dK6iDJgikR1xnO5Q+Wo2k3vlrjpJlHim9yrGfbgl
	 A3NLEaWsk6S2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 11/11] Documentation/bpf: Describe new
 location-related BTF kinds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916074118.1007116-12-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:01:10 +0000
Message-Id: <20260916080110.C87BE1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: BTF_KIND_LOCSEC offset definition is broken for kernel modu=
les
- [Medium] bpf: BTF_KIND_LOC_PARAM size restricts representing larger funct=
ion parameters
--

commit 2c604400821fbb8c84a44304f76a074c263fd25e
Author: Alan Maguire <alan.maguire@oracle.com>

Documentation/bpf: Describe new location-related BTF kinds

Update BTF specification to describe encoding schemes for
BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC.

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 004aa1058d857..70ab6ad608ae5 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst

[ ... ]

> @@ -563,6 +568,77 @@ The ``btf_enum64`` encoding:
>  If the original enum value is signed and the size is less than 8,
>  that value will be sign extended into 8 bytes.
> =20
> +2.2.20 BTF_KIND_LOC_PARAM
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> +  * ``name_off``: 0
> +  * ``info.kind_flag``: 0
> +  * ``info.kind``: BTF_KIND_LOC_PARAM
> +  * ``info.vlen``: number of 32-bit location value words
> +  * ``size``: size in bytes of the represented parameter: 1, 2, 4, 8 or =
16

[Severity: Medium]
Does this limitation restrict representing parameters larger than 16 bytes?

If the UAPI restricts the size to a maximum of 16 bytes, it prevents BPF fr=
om
accurately describing functions with large by-value parameters. For example,
structures passed by value on the stack, or ARM64 Homogeneous Floating-point
Aggregates that can be up to 64 bytes.

[ ... ]

> +2.2.22 BTF_KIND_LOCSEC
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> +  * ``name_off``: offset to a valid ELF section name
> +  * ``info.kind_flag``: 0
> +  * ``info.kind``: BTF_KIND_LOCSEC
> +  * ``info.vlen``: number of inline sites in the section
> +  * ``type``: 0
> +
> +``btf_type`` is followed by ``info.vlen`` number of ``struct btf_loc``.::
> +
> +    struct btf_loc {
> +        __u32 func;
> +        __u32 loc_proto;
> +        __u32 offset;
> +    };
> +
> +The ``func`` field is the non-zero type ID of the ``BTF_KIND_FUNC`` being
> +described. ``loc_proto`` is the non-zero type ID of the associated
> +``BTF_KIND_LOC_PROTO``. ``offset`` is the location address offset relati=
ve to
> +the kernel or module base address. A LOCSEC named ``inline.text``, for e=
xample,
> +contains inline-site records for the ``.text`` section.

[Severity: Medium]
Is this definition of the offset field correct for kernel modules?

Modern kernel module loading splits executable sections (e.g., .text,
.init.text) into independently allocated memory regions. An offset relative
to a single module base address cannot reliably resolve to the correct memo=
ry
address.

Should this be defined as an in-section offset instead? Tools relying on th=
is
documentation will calculate incorrect absolute addresses for inline sites =
in
loadable modules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074118.1007=
116-1-alan.maguire@oracle.com?part=3D11
