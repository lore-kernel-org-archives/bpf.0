Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDB3770B
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416397; cv=none; b=oJendLxukRJlgD16nv4vfxIhxRRJr3kRucR8OKL04rOeshnX4QM5E4hBhnBulGyWAT8/HRnNmxRPa+JZskZ4fQv74KC+ZyL2cAvbM0jutn28uYBGJUBJl0UzV/Uhvkzu1Z40/JAamGw4qvHxzQ5QaELpj/5OAxwwZZsjPpMiPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416397; c=relaxed/simple;
	bh=lgyb5xjoImkhI2zMoHI7I/ZsicZrDbBgtpI0ECKuQIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTo82wgzu744v+uJlrfn6Q62Wy9OvnHt6WWKkOmEhSE3fVNaswlCoKZIXfUaIPxn8F3xFD2MTRgIZqxNmIVU0bxfOpywPoHcV2mOtKpSggMCzJhkgccap+gvtYASyLrVN2ZuVLm2du/3UhZkerey/yzO6IlU9f9IPrjO/B+jNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWWzHruU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWWzHruU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09871F000E9;
	Sun, 14 Jun 2026 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781416395;
	bh=0X4z6vUg/KH/RWmdbqi80q210nI0u++wu2P0PBG+py0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aWWzHruU7UPR+PPgvp4weGrPFB6qQxzB/IX2rOdQvuiq6irki7P+qpbtsKGqpyRX/
	 iXIciabtOmmO3igBvymEYie9UyZUo3lQGCc23FUbJ3V6o9a4nLGvq3u48ps5bCNCMy
	 +M2QhL4A5x8TZiICBhAq//nkti1f2XLXfyA2iUKmtgUOedBB5otABOTNzUEVVg14Wy
	 myfNjKrjI8YSZ9AtvqT6tCGaHn76SCg3Kx81e2JncKotOzsTysUMUXSdbFq7oqoiim
	 nyPK+fYJkrtleg2/P1K4CdIz2NO/RRNVQvmC3bjOGnFUlcYyxX398lHbReJ7bpvh4T
	 XzPDdEqaFHs/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test linker rejects out-of-range
 relocation offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260614053927.160566-3-sammiee5311@gmail.com>
References: <20260614053927.160566-3-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 05:53:15 +0000
Message-Id: <20260614055315.A09871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The dynamically generated ELF file hardcodes little-endian byte =
order (`ELFDATA2LSB`), which breaks the test on big-endian architectures.
- [Low] Build failure due to undeclared `R_BPF_64_64` (and potentially `EM_=
BPF`) on systems with older standard headers.
--

commit ea0de1dc0625c22a9ceaf6b346bc7dcde8b649da
Author: HyeongJun An <sammiee5311@gmail.com>

selftests/bpf: Test linker rejects out-of-range relocation offset
   =20
Add regression coverage for libbpf static linker relocation offset checks.
Build a minimal ET_REL/EM_BPF object in memory with a 16-byte executable
section and one relocation against that section.

> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_linker.c b/too=
ls/testing/selftests/bpf/prog_tests/libbpf_linker.c
> new file mode 100644
> index 0000000000000..e7bec24343498
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_linker.c

[ ... ]

> +	ehdr =3D obj.buf;
> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> +	ehdr->e_ident[EI_CLASS] =3D ELFCLASS64;
> +	ehdr->e_ident[EI_DATA] =3D ELFDATA2LSB;

[Severity: Medium]
Does hardcoding ELFDATA2LSB here break the test on big-endian architectures?

Since the ELF header and structures are initialized using native host
byte-order C struct assignments (like ehdr->e_type =3D ET_REL), libelf
will see ELFDATA2LSB on big-endian systems (like s390x) and incorrectly
byte-swap the already native big-endian fields. This could cause the linker
to reject the ELF file with -EOPNOTSUPP.

Should EI_DATA be set dynamically to match the host's byte order?

> +	ehdr->e_ident[EI_VERSION] =3D EV_CURRENT;
> +	ehdr->e_type =3D ET_REL;
> +	ehdr->e_machine =3D EM_BPF;

[Severity: Low]
Could this cause a build failure on systems with older standard headers?
EM_BPF might be undeclared on extremely old systems.

> +	ehdr->e_version =3D EV_CURRENT;
> +	ehdr->e_ehsize =3D sizeof(*ehdr);
> +	ehdr->e_shoff =3D shdr_off;
> +	ehdr->e_shentsize =3D sizeof(*shdr);
> +	ehdr->e_shnum =3D SEC_CNT;
> +	ehdr->e_shstrndx =3D SEC_SHSTRTAB;
> +
> +	memcpy(obj.buf + text_off, insns, sizeof(insns));
> +
> +	rel =3D obj.buf + rel_off;
> +	rel->r_offset =3D relo_off;
> +	rel->r_info =3D ELF64_R_INFO(1, R_BPF_64_64);

[Severity: Low]
Will this fail to compile on systems with older standard headers?

R_BPF_64_64 was only added in glibc 2.32 (August 2020). On systems with old=
er
headers, such as Ubuntu 20.04 commonly used in CI environments, R_BPF_64_64
is undeclared.

libbpf works around this by providing fallback definitions in
libbpf_internal.h, but libbpf_linker.c doesn't include it. Could we add a
fallback definition for R_BPF_64_64 in this test to ensure it builds on old=
er
environments?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614053927.1605=
66-1-sammiee5311@gmail.com?part=3D2
