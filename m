Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AAD334688
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975477; cv=none; b=pXpvK7p4QfRK65COUrGql+NxbR+Hvq2eUlsT8pkowO9pLSulIvMmYjsbvoY+AOoP7t0nTcQBYl20E/huQz7usqfedy7xuMw219ujYJtRoZuVm9ZHl4NJcrc8Nia6Sa2sEMkYrczfvlGC+T5LThX8mJx+kLa+L5n/8IpmxzA103o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975477; c=relaxed/simple;
	bh=JDapasCD4yNPrs6WlyacY/Ut1sq/7GPVrcrQY0AimW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=favoXsUIY48EFkLshoJOUguc7rpyt8sS7yqnUGq3mlQRP0NIKQ5S1KyHhME/HcGcf2lIzeIF2y3v7GtzwJsBk1PlTEhpTNn2GF+xoHuUipIEhlBYYL3dwdlyZpo4Ftj0wtSeepZjurZ2cVejed4wK0kGMUOCaiDxADKkLL3ngi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp/n/mfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp/n/mfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF27CC2BCB4;
	Tue,  5 May 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777975477;
	bh=JDapasCD4yNPrs6WlyacY/Ut1sq/7GPVrcrQY0AimW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Xp/n/mfM5nWjq8VMqRrjE9CPHM7CGdI0tsnU5wzkdikWqzncQ0iEsFkgTS/bmBche
	 8MfLRKd1q4brQgiIB/3PdFNmCyBgOG/H4tLh+eQ36zfDT+KdYrqXcPqeo6CJN0pzLA
	 huriGtJ+0laoYg4WlHounanxndH5r8BGWPswcXfzwOjUWaHW+zGEs3cgzBnFQFz8Sk
	 Q5ZnQhXA1u+AZZ2RxPgiNv2lvvk5ntupYbBciJm/qLVeLpSHQFpTyUhJTsVgRZ2kfp
	 DC3eIRNV+KzEEWgWRCFmDlYSqV1BHBBf6I4pJCHFlj05Z747Hwed8sMGVNFI8NhiWA
	 Avo0k/q9mRRkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] kbuild: make CONFIG_MODULE_HASHES compatible
 with module stripping
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 10:04:36 +0000
Message-Id: <20260505100436.EF27CC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The string comparison in `scripts/Makefile.modinst` unconditionall=
y fails, completely breaking `make modules_install` when `CONFIG_MODULE_HAS=
HES` is enabled.
- [High] Module hashes are calculated on unstripped modules if `INSTALL_MOD=
_STRIP` is not explicitly passed during the build phase (`make modules`), l=
eading to unbootable modules.
- [Medium] The build system unconditionally generates redundant `.ko.stripp=
ed` files for every module, even if `CONFIG_MODULE_HASHES` is disabled or n=
o stripping is requested.
--

commit c60e91b7cfcdafd6de940881990bcbadd0ee0179
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

kbuild: make CONFIG_MODULE_HASHES compatible with module stripping

This commit aims to fix module loading when CONFIG_MODULE_HASHES is used
alongside module stripping. It records the INSTALL_MOD_STRIP value in Kconf=
ig
and validates consistency between build and install time. It also introduces
stripped module variants during compilation to ensure the generated hashes
match the final installed files.

> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 99482fac07018..a5b3807e2304d 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig

[ ... ]

> @@ -423,6 +423,11 @@ config MODULE_HASHES
> =20
>  	  Also see the warning in MODULE_SIG about stripping modules.
> =20
> +# To validate the consistency of INSTALL_MOD_STRIP for MODULE_HASHES
> +config MODULE_INSTALL_STRIP
> +	string
> +	default "$(INSTALL_MOD_STRIP)"
> +

Is it intended for config MODULE_INSTALL_STRIP to lack a depends on
MODULE_HASHES statement? Without it, the config appears to be evaluated
and saved as a quoted string even when hashes are not used.

[ ... ]

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 44a382689a5aa..9924a7bb73c5e 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal

[ ... ]

> +%.ko.stripped: %.ko $(wildcard include/config/MODULE_INSTALL_STRIP)
> +	$(call cmd,install_mod)
> +	$(call cmd,strip_mod)

Does cmd_strip_mod evaluate to a no-op during the build phase if
INSTALL_MOD_STRIP is not explicitly passed to the build command?

Since users typically pass INSTALL_MOD_STRIP=3D1 only during the module
installation step and not during compilation, this might cause hashes to be
calculated on unstripped modules during the build. If the modules are then
properly stripped during installation, could this result in a hash mismatch
that prevents module loading?

> +
> +ifneq ($(CONFIG_MODULE_INSTALL_STRIP),)
> +modules.order: $(modules:%.o=3D%.ko.stripped)
> +endif

Since Kconfig strings are exported to Make with quotes, won't this check
evaluate to true even if the string is empty, as the value will be "" rather
than completely empty?

This looks like it would force the generation of .ko.stripped targets for
all modules, adding unnecessary overhead to the build even if module hashes
are disabled or no stripping is requested.

[ ... ]

> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index b95f613e23c89..fd1fb89bb0bd7 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -68,8 +68,8 @@ __modinst: $(install-y)
> =20
>  ifdef CONFIG_MODULE_HASHES
>  ifeq ($(KBUILD_EXTMOD),)
> -ifdef INSTALL_MOD_STRIP
> -$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusiv=
e)
> +ifneq ($(INSTALL_MOD_STRIP),$(CONFIG_MODULE_INSTALL_STRIP))
> +$(error Inconsistent values for INSTALL_MOD_STRIP between build and inst=
allation)
>  endif

Kconfig string options are exported to Make with literal double quotes,
such as CONFIG_MODULE_INSTALL_STRIP=3D"1", while the INSTALL_MOD_STRIP
variable passed via the command line or environment is typically unquoted.

Will this literal comparison always evaluate as unequal, meaning 1 !=3D "1",
and therefore prevent module installation when CONFIG_MODULE_HASHES is enab=
led?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-module-has=
hes-v5-0-e174a5a49fce@weissschuh.net?part=3D14
