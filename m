Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EC175A66
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184982; cv=none; b=hh3FI72WBNR0/MIkIYZubLJ1IOmUSiLYlvRQj/aPOPn4uFD6PIZhVppaUbY1b80sRIA4zIgn6vjPoOjanbtlVlbCAhqiur3xmDFhZ7ZSx5JBKVSeo/KTepah/AcKeNK1yrAG2/bNq4ZNfkm++Ta68FgNJqKnXfY9IGfnFREbdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184982; c=relaxed/simple;
	bh=BFSWzIoCxTp4QGGHIMgyWMxkkEXU5XWOI09Fv3dmwvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zsl7AQ9WORfP+48VQ/wi7+vrLARZdv0hZnh1V82ARaIDpGQJoiH0otDXbENuq+rQY0RgmhplwouxUW9UpN9vZusudsrwTQO1iNI31tVwi7EqXX+bMFlJO0qLS6DwKhvyuKCdJXcB5/LuUxn+p99XTafCviODgqts/bQ7aJacDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEIO54xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEIO54xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D581F000E9;
	Thu, 20 Aug 2026 00:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787184981;
	bh=6DYM8FxjvHZFM1GHvQJVFT63He3BjizYOpCkCuyrmdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEIO54xhDGsC4THthxGgCroEuyQlZb+10hOWphVB9nuo4WLiXN7q5gppQ+iedib4u
	 uyIzit+F6Xd6+qoR3qNANScOO/xSxXpc7qhXG/WrKetW/Et7d7QicXPL5tN9adOBy2
	 fg4fgk6Sh9i7Z+HWHSQDNImF/aGWQvFLJ3iBDPdv2UO1rCinQmGo5hCKIoPe3d8h3d
	 QRFGQKuU7H6LT25ErocY6NSADQnkLI6sDM/29DXOefRpJwwkXO+YxfAhY2fv3WU5QD
	 2XD8C5mnYOLRRffaG4r9qOFoCXI93HzH/9Vv3x2aLHGzrjErJDC4noc8vaCuuHawGM
	 5ABY1yi2C9avA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool
 btf dump format c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820000627.3826188-3-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
 <20260820000627.3826188-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 00:16:20 +0000
Message-Id: <20260820001620.E6D581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment describing the `holey` struct layout contradicts the ac=
tual code, creating a 64-bit hole instead of the documented 32-bit hole.
--

--- Patch [2]: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool=
 btf dump format c ---
commit 6c049c9e731fda95ed237645c2367be42ed67768
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

selftests/bpf: Add tests for bpftool btf dump format c

This commit adds a selftest for "bpftool btf dump format c" to ensure that
the generated vmlinux.h header contains the correct macros, pragmas, and
padding widths. It verifies these features across both sorted and unsorted
BTF output formats.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> new file mode 100644
> index 0000000000000..53bb7065b3cae
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c

[ ... ]

> +/*
> + * struct holey { int c; <32 bit hole> int tail; };
> + *
> + * One record with a hole, and a 4-byte long to pad it with. How records
> + * themselves are rendered is already covered by the build, so the fixtu=
re does
> + * not need to be more elaborate than that.
> + */
> +static struct btf *mk_btf(void)
> +{

[ ... ]

> +	id =3D btf__add_struct(btf, "holey", 16);
> +	if (!ASSERT_GT(id, 0, "struct_holey"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "c", 1, 0, 0);
> +	if (!ASSERT_OK(err, "holey_c"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "tail", 1, 96, 0);

[Severity: Low]
This isn't a bug, but does this create a 64-bit hole instead of the 32-bit =
hole
mentioned in the comment above?

Since "c" is a 32-bit integer ending at bit 32 and "tail" starts at bit off=
set
96, the gap between them appears to be 64 bits.

Could the comment be updated to accurately reflect the actual struct layout
generated here?

> +	if (!ASSERT_OK(err, "holey_tail"))
> +		goto err_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820000627.3826=
188-1-ihor.solodrai@linux.dev?part=3D2
