Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781F26ED45
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973746; cv=none; b=CFON8oflo1RmSvWAjWa3FkRJfuF2P5OJX55EY0QNQpTXD4u4CUg5pqSAgnbhLFUd5dH2sVH/h2ZmTH2MB2sxZS1FcMwinYqG4skRaeSo7Th8SSrtyIeTaDv1qGa2cukK2pC1q/Jz02tnTzv0p+N1hK5YL27V9pez7YztzNTCQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973746; c=relaxed/simple;
	bh=n/GAdE0zDLjGmHiMqwTR6RzDUf65ObE6jKUwwMbukJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RI2ZP2VN27z1ApDiF/Nmp14bNSLEmE32E7nc55zNM0Irw5o/XbTZsOrBQA9pgnMMu3IPYCMNuyw8SObsqbQgiJ75f9lF9uuWy2SIiwQ+GvPXFw96FR6fJQEpZnAeWswGBBXm03SifMXWbJyPU/APlcIZUoc72J2eMbe4mfx0mM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaWsYsqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaWsYsqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED89C2BCB4;
	Tue,  5 May 2026 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777973746;
	bh=n/GAdE0zDLjGmHiMqwTR6RzDUf65ObE6jKUwwMbukJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XaWsYsqugo14fw/2Kl8Vxuo+QmzLl+da70bZysAaN0wX8lX5283bhgE/st3uv5X5Z
	 Sv+9KZ2pGobzCYkCnLSzTTM2UxhCHXMYX1ab9lE5AhLwBDM8dSospFJBOazbPLT8gt
	 yGZ4W7GccQ9m/7MQw/APS6CddjkW0Th8Ywyx0nSTfdSMz4q6kZt9ivQtiB8qw7mVD9
	 a9jawGSiQZWRcnqZgjiJCzjA95PcX6ISHgS6J0B5ruvoEZWTYKO3/QtLxEnbRk+wbX
	 tRW+U+98llF3CXm+2xP6pQkVfhyc6W8m1eDihpq5bmD0qhFap9bqudgrQA2z+Ou4cW
	 lWQGE/6IqfUDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/14] kbuild: move handling of module stripping to
 Makefile.lib
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505-module-hashes-v5-13-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-13-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 09:35:45 +0000
Message-Id: <20260505093546.5ED89C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reusing `INSTALL_MOD_STRIP` in the build phase violates the separa=
tion of build and install phases, breaking standard user workflows and core=
 kernel packaging scripts.
--

commit 82e978c8789922dfed0ff25bf7970d67d952508d
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

kbuild: move handling of module stripping to Makefile.lib

This commit moves the INSTALL_MOD_STRIP logic to Makefile.lib so that it
can be reused by Makefile.modfinal, allowing CONFIG_MODULE_HASHES in
combination with module stripping.

> To allow CONFIG_MODULE_HASHES in combination with INSTALL_MOD_STRIP,
> this logc will also be used by Makefile.modfinal.

This isn't a bug, but there's a typo (logc) in the commit message.

More importantly, does evaluating INSTALL_MOD_STRIP during the build phase
(Makefile.modfinal) violate the separation of the build and install phases?

INSTALL_MOD_STRIP is traditionally an install-phase variable passed strictly
to make modules_install (e.g., make INSTALL_MOD_STRIP=3D1 modules_install).

Core kernel packaging scripts heavily rely on passing INSTALL_MOD_STRIP only
during the install phase. For example, scripts/package/builddeb executes:
make -f Makefile INSTALL_MOD_PATH=3D"..." INSTALL_MOD_STRIP=3D1 modules_ins=
tall
during debian/rules binary, while the build phase runs without this variabl=
e.
Similar logic exists in Arch PKGBUILD and RPM kernel.spec.

If build tools do not export INSTALL_MOD_STRIP during the build phase,
relying on it during Makefile.modfinal will mean the build phase and
install phase have different views of the variable. If a subsequent commit
enforces that the build-time and install-time values of INSTALL_MOD_STRIP
must match, wouldn't this break package build targets like make bindeb-pkg
or make rpm-pkg?

If build-phase module stripping is required to support hashes, should this
be governed by a dedicated build-time Kconfig option, rather than
repurposing an install-time Kbuild environment variable?

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib

[ ... ]

> +# Module Strip
> +# ----------------------------------------------------------------------=
-----
> +#
> +# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after=
 they
> +# are installed. If INSTALL_MOD_STRIP is '1', then the default option
> +# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be=
 used
> +# as the options to the strip command.
> +ifeq ($(INSTALL_MOD_STRIP),1)
> +mod-strip-option :=3D --strip-debug
> +else
> +mod-strip-option :=3D $(INSTALL_MOD_STRIP)
> +endif

Since this is now in Makefile.lib and evaluated during both build and insta=
ll,
can this cause inconsistencies if users run a standard workflow like:

make
sudo make INSTALL_MOD_STRIP=3D1 modules_install

Will the build phase have generated hashes based on unstripped modules,
rendering the hashes invalid when the modules are later stripped during
installation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-module-has=
hes-v5-0-e174a5a49fce@weissschuh.net?part=3D13
