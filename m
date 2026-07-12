Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD253D994
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783838261; cv=none; b=J7y8ltSES+rhnOF5Gu/ZrmOnKXo5+JwSXmLDPSUxIKH51SJYCsBk34yuwcUDIIVxKVT4bIVKgYSPMpjLs3bmmU56Dwo5s/VohznznQkn7ht+6lr7BlYFKRTLZf5r0l1tH3b0EvDJjC9eTICDI4+Qma6mos3l634rpAQe1i0ecbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783838261; c=relaxed/simple;
	bh=d8KDJ50O2IjVvyULTa8N8H9FKZ8QY/yCbF+iE9pe9yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a88YvtLMJ7ddKroCIwFfU7xCqb1TlZLbqTUVgsNHvDVR6q3YfK4tsH/cwM7LIL45IcViM1S0weqQVuWWbBSTRvczOuNxhMvuYkABVXznoJ9jD+sIr35eu1LW6eLfnBONj5hxYX7/7UmhCRnPRivzXUWWJgyyZZEn3SKG+sfDCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFFZjZ7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFFZjZ7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5B1F000E9;
	Sun, 12 Jul 2026 06:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783838260;
	bh=lp+ioYsEpyChai4Uu6wekyYEsLRUaWU07HYBF+pfCgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BFFZjZ7+y90RpZzJMjdMmoUWOngPGVj+GUj7FjsOKpzmNHG9LnGeq4iXwrZyEe6ZH
	 reOltuPJCZrnW4slhlDJrWQy1XS8JDGvE4HI1HaEdzVKtyaRUiV3QrQaNOW9DVMVHA
	 HZ54YKYXwt0nIVvidnrv9WhADGesGGHkkdPla4QASIDP2Vl1GLeePf+yBKyuiWYAlW
	 1XVxgCJ3huYZJpZnrX9/tEbHEqAPZ0jl9iwL4uon2IZzULjWLbFhsqP3cJmuidMkjU
	 S29Z+ShxfXqpC4PGe0JngfrDRWwh9T9J5r9qNdMtPWi4p5xD1GdhK3b9NR4CVJlhy4
	 p/Usr+e7Wl6Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712062834.77872-1-laoar.shao@gmail.com>
References: <20260712062834.77872-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 06:37:39 +0000
Message-Id: <20260712063739.F1E5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditionally passing `--keep-section .BTF` to `find-debuginfo.sh=
` breaks RPM builds on older distributions.
--

--- Patch [1]: [PATCH] kbuild: rpm-pkg: Preserve .BTF section in kernel mod=
ules during debuginfo stripping ---
commit cf88f1e030f88c3862874c09c0ef198fa1f1e9ca
Author: Yafang Shao <laoar.shao@gmail.com>

kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo s=
tripping

This commit modifies the kernel RPM spec file to pass the --keep-section .B=
TF
flag to the find-debuginfo.sh script. This preserves the .BTF section during
debuginfo extraction, ensuring that BPF tools can successfully resolve kern=
el
types at runtime for modules.

> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index c732415662ef2..abc73de019e0c 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
[ ... ]
> @@ -67,7 +67,7 @@ This package provides debug information for the kernel =
image and modules from th
>  %undefine _unique_debug_srcs
>  %undefine _debugsource_packages
>  %undefine _debuginfo_subpackages
> -%global _find_debuginfo_opts -r
> +%global _find_debuginfo_opts -r --keep-section .BTF

[Severity: Low]
Will unconditionally passing --keep-section .BTF break the build on older
distributions?

Older versions of the find-debuginfo.sh script (such as those shipped with=
=20
RPM 4.14 on RHEL 8, CentOS 7, or Ubuntu 20.04) do not support the
--keep-section option.=20

Because those legacy scripts parse arguments strictly, they will exit with a
usage error when encountering an unrecognized flag, which completely breaks
the make rpm-pkg and make binrpm-pkg build targets on those systems.

Is there a way to verify feature support or utilize RPM conditionals before
applying this flag to the host script?

>  %global _missing_build_ids_terminate_build 1
>  %global _no_recompute_build_ids 1
>  %{debug_package}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712062834.7787=
2-1-laoar.shao@gmail.com?part=3D1
