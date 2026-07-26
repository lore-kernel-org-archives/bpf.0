Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB175B21A
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785034994; cv=none; b=nv4n3Wefmh4HauZCTQoo1WDqdzNOYaZXRqhFbH3z+U/oWFsJQ4KiaALgibSzXb2V6mULvYtuJ5mMcvWNWI5xhWSRiDi48sZrJlGm4Uxp9rPmB23uHLdSKwMWBjuzpDmI2tiPF1q0Ho9Kb8aoID09Q2T9osHpp1fsaymwQdGAWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785034994; c=relaxed/simple;
	bh=kQiZsTGyIPBMea7PDPbme3eR8QmPrXUT7ep+0gNS+Rk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWkQcugcEgGj7Cfl/yE0tJlwWWaWDMz0K0Tx15lRmyKSmVDL8EnoEerH5yFxK1UsoJKtaMYSVuGY2UOOjT07rwuMeA2s2oFqeXn0LRVl5voCNq7iKiZMU9mia6zJ7udNuY6tDruM8IZtA73TaMVq2CibpCV0OHfC6nuG4A/VfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQkhxUaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQkhxUaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6191F000E9;
	Sun, 26 Jul 2026 03:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785034993;
	bh=cfWq+S/dedp3uU1kZnPqpXRDroWRpa4U1zieCUwI+Wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQkhxUaC5NSdQvEuhEnmTn/AYPGWqZr8SX2EOaCjEb6UXaWrqx6u+FkSm9yMgfqvX
	 R8O5+BfLa9kgXnmAG+ab7KzWseX0I3DgeURMysPf4CurvIqCTqx1ezXig0MOiAFBUO
	 aTq3uLgF0tUh+RX/F3910DvmRrZ/N0gLlHwgyQlOG1Xoiz5mpXdlYiwLS61DyKs20A
	 iQ2How+nfilyA/uiczaWhx8jRuQnmy5MiAigw42NAkmeQbyVM7NHraLGwvYnQdha8T
	 DoXJNTS6q/flEl+aoWia3GUD4oJFQ7oTTvzDYHGIIf8ZpKx0RGD2GDcQmdVN0Ifm8B
	 lF0h82L/kHBrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726025242.42245-1-laoar.shao@gmail.com>
References: <20260726025242.42245-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 03:03:12 +0000
Message-Id: <20260726030312.DF6191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch preserves the `.BTF` section during debuginfo stripping =
but fails to also preserve the `.BTF.base` section, causing module BTF vali=
dation to fail.
--

--- Patch [1]: [PATCH v3] kbuild: rpm-pkg: Preserve .BTF section in kernel =
modules during debuginfo stripping ---
commit cd09ed46074d0224c00066939452278fca769e51
Author: Yafang Shao <laoar.shao@gmail.com>
kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo s=
tripping

This commit updates the RPM build scripts to pass --keep-section .BTF to
find-debuginfo.sh. This prevents eu-strip from dropping the .BTF section
from kernel modules during debuginfo extraction.

> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c732415662ef2..1032f337a71cd 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec

[ ... ]

> @@ -67,7 +67,17 @@ This package provides debug information for the kernel=
 image and modules from th
>  %undefine _unique_debug_srcs
>  %undefine _debugsource_packages
>  %undefine _debuginfo_subpackages
> +
> +# Preserve .BTF section in kernel modules during debuginfo stripping
> +# find-debuginfo.sh (from debugedit) uses eu-strip which removes
> +# non-allocated ELF sections like .BTF by default.
> +%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c ke=
ep-section)
> +%if %{with_keep_section}
> +%global _find_debuginfo_opts -r --keep-section .BTF

[Severity: High]
Does this also need to preserve the .BTF.base section?

When modules are built with BTF distillation (which is standard on recent
kernels), both .BTF and .BTF.base sections are generated. If .BTF.base is
stripped, btf_parse_module() in kernel/bpf/btf.c falls back to using the
vmlinux_btf.=20

This fallback causes type ID mismatches during btf_check_all_metas() because
the module's .BTF was built with distilled IDs, ultimately resulting in the
module's BTF being rejected entirely.

Could we add --keep-section .BTF.base here as well to ensure distilled BTF
validation succeeds?

> +%else
>  %global _find_debuginfo_opts -r
> +%endif
> +
>  %global _missing_build_ids_terminate_build 1
>  %global _no_recompute_build_ids 1
>  %{debug_package}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726025242.4224=
5-1-laoar.shao@gmail.com?part=3D1
