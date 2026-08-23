Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E03361DBF
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477428; cv=none; b=YZoE2+4CanhL7sU4YlRpDAPDKfVxzmXYgEgIcIDyAx7AUVTRaL62LQSchwAcC9xmby/TPBYp4CNB36i/XKiFdhliPq5LQVXbfQNHTPRt4leRTJCoh7d9BvhfddYulbzuiY7+YZ4jrOU9lOt/V93KLCABYGw6cwHb3Jde7ekALLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477428; c=relaxed/simple;
	bh=Vt4q/92E4jRtS0Hi4rLiIfHNH5lFzDA87jVaXqMDxBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TkSKsOEfJQLzqumzxJ+PkONWBSsreF/nsO0j5XsqIhfq03B7UAeL3UgtL1/n2kU2sRsfPU0ye4iVlZ/XLNThJXe6j3+cK0/vGm8bHm2J4aOdn7xTO6ZqVSzI80BcBL1JDfSbfFOEmuH2ErXxTdtyGdLrwTraMJP1CnanC9EsAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBbwQXSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBbwQXSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF861F000E9;
	Sun, 23 Aug 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787477422;
	bh=RGGpA8865rGkM6leUEAJYSNa9ODjXWJ9v3wGlP0DddQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBbwQXSPNy2BVd2D1xCg7mNnIPeMvwPBt4TVPf6IPKlsafT9eFxtuARb2c79NhAeU
	 Cww70MOpSHozzmYXu/I3aYMdlyzUoYVbiOTok6McZj7whUcW/sCSr4NNlKYTLuJPW8
	 mmHBMo7g0uyotEiYM/Bt9A5DuXO+NEPlbXqDxLDlzO7Wa+7OfD+6I4rtQiPncWj9xW
	 R5TKmtTJZLCXiC5mIzCU+kWta/N/IOaZ9jefgUpuri8zmcKZf4X/P4B+ndpDRXvUnJ
	 /Hnp7favRFOFZAWLKfZpeAyIBMPQ0N/7xabS6hhUqNHQ7V6h/9uOaokCKx53OzBwxT
	 fu4yHxJTAW/tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: Ignore exception frame section
Reply-To: sashiko-reviews@lists.linux.dev
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823092057.82200-1-tw19881113@gmail.com>
References: <20260823092057.82200-1-tw19881113@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 09:30:21 +0000
Message-Id: <20260823093021.EBF861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete handling of exception frame sections by using exact s=
tring matching instead of prefix matching.
--

--- Patch [1]: [PATCH] libbpf: Ignore exception frame section ---
commit 7e5607d9374ac0c905a5c8970316c258ed4eb5cf
Author: Tw <tw19881113@gmail.com>

libbpf: Ignore exception frame section
   =20
This commit updates the ELF section filtering logic to ignore ".eh_frame"
sections during BPF object linking and loading. This resolves issues when
building BPF programs with compilers that emit exception handling frames,
as they are not needed by the kernel.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..05727c418c402 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3867,7 +3867,8 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, si=
ze_t idx)
>  static bool is_sec_name_dwarf(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return str_has_pfx(name, ".debug_");
> +	return str_has_pfx(name, ".debug_") ||
> +		   strcmp(name, ".eh_frame") =3D=3D 0;

[Severity: Medium]
Does this exact string match correctly handle variants like ".eh_frame_hdr"=
=20
or function-split ".eh_frame.*" sections?

If a compiler emits these variant sections, they would bypass this filter a=
nd
could potentially cause build-time link failures against STT_SECTION. Would
it be more robust to use a prefix match like str_has_pfx() here, similar to=
=20
how ".debug_" is handled?

>  }
> =20
>  static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)

[ ... ]

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290af..1fb0efdbfae7f 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -599,7 +599,8 @@ int bpf_linker__add_buf(struct bpf_linker *linker, vo=
id *buf, size_t buf_sz,
>  static bool is_dwarf_sec_name(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0;
> +	return strncmp(name, ".debug_", sizeof(".debug_") - 1) =3D=3D 0 ||
> +		   strcmp(name, ".eh_frame") =3D=3D 0;

[Severity: Medium]
Similarly, would it be beneficial to use a prefix match (e.g. strncmp) here
to ensure we also ignore related exception frame sections?

>  }
> =20
>  static bool is_ignored_sec(struct src_sec *sec)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823092057.8220=
0-1-tw19881113@gmail.com?part=3D1
