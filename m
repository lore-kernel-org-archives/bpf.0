Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF648A8A4;
	Tue,  1 Sep 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283383; cv=none; b=A/bok89/kqCFmqhDW+AkU3QWCoskS0/Y7bIbpBbR9CrIQeOZS+hVfjyUQv/KBd//YctJISrE2go66aBqizscXBEHQOz1D0u6ZjapiGAAEuigkXRYNl0W6nxggeJoTDj1PGRrbzdrwfoJkRUzuuBsZJCWK8uAZaEzDHwuhlkat1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283383; c=relaxed/simple;
	bh=UYr4FgrOKQQU7IopkP5lwLpnKQYJ6WQWgBhcCpIh12I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gQtz1uSSfVBRPsrzLH2bonDsjskoRFneRen1b+qkZqqXlrDWpW5EM0hYjlI+siXUldVwZhXk9sn39qbEASHVpRC9/QawsrWGwCP/dPd2QyfylWp1Odu+ZtYCLUOzwHGbnNjQqhHuMEJExD2pRDn4ONGs9y1ud7m1SfKddi8XCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAyOOvS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAyOOvS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEBC1F000E9;
	Tue,  1 Sep 2026 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283382;
	bh=JL7hv6FEcf/sPTbzBqgzfpTUF8CpqaPYsWtSrHC4WSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAyOOvS5Xk5d/du/dhqcSe/Ez3wuULFEKyGBCFbDabEZBmi3YW2JI+EjnGgQ0LeSi
	 7NNzh4hMqQwIoxnI1e2+cSoRA/8/QcqEFGM5CTq170YF712JD/cmFYSyOCBNn/PPFR
	 VsN0euibl7lOPEfcyfDPlKyj/fnZJxaZYB76HDe61ZcrQ1Q51EMs86McZ5dNNsxlYM
	 oNycmPAfHvGqfD4hkXLNjddA3KcvelFmdxomEk/qJdZnLQFbLOKRMcycG2c4saOobZ
	 ZLWmwkanRbKxvw11gasOp7T2Almw/lr6nzLNsT8b1RRpRqEb88usOYq3LhD9NBE1GF
	 EiRe8zWp+wPcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 12/18] resolve_btfids: Extract inline BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-13-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-13-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:23:01 +0000
Message-Id: <20260901172301.CBEBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Division by zero when parsing ELF symbol table sections if `sh_e=
ntsize` is maliciously or erroneously set to 0.
--

commit df03e392d8f5364e6eef1e60fcadca00e2b031f8
Author: Alan Maguire <alan.maguire@oracle.com>

    resolve_btfids: Extract inline BTF
   =20
This commit adds an --inline option to extract LOC_PARAM, LOC_PROTO and
LOCSEC types to a new inline split .BTF.inline while sorting BTF.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 37d7e7224207d..20b228c4d6789 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
[ ... ]
> @@ -572,6 +578,58 @@ static const char *find_name_by_addr(struct object *=
obj, Elf64_Addr addr)
[ ... ]
> +static int collect_func_symbols(struct object *obj)
> +{
> +	Elf_Scn *scn;
> +	GElf_Shdr sh;
> +	int n, i;
> +
> +	if (obj->efile.symbols_shndx =3D=3D -1)
> +		return 0;
> +
> +	scn =3D elf_getscn(obj->efile.elf, obj->efile.symbols_shndx);
> +	if (!scn || gelf_getshdr(scn, &sh) !=3D &sh)
> +		return -EINVAL;
> +	n =3D sh.sh_size / sh.sh_entsize;

[Severity: Medium]
Could this result in a division by zero if a malformed ELF object is
provided to the build system?=20

If sh.sh_entsize is 0, this will trigger a SIGFPE and crash the resolve_btf=
ids
tool. While this vulnerable pattern already exists in symbols_collect(), it
appears to be newly introduced here in collect_func_symbols(). Should there=
 be
a check to ensure sh.sh_entsize is non-zero before performing the division?

> +
> +	for (i =3D 0; i < n; i++) {
> +		GElf_Sym sym;
> +		const char *name;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D12
