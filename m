Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EC3CC7D8
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223520; cv=none; b=PtO2oE03C2t+ihuQ850tpAkJAi/52T7w/CGBefD4zzXZTY7M2fBJHE6dk2YFo95sSWNInDF/dxerRpT4bWrAnhwOzCThPclDDZ1P3SSTJCHIOvun642djfQaxTTsYuhrF1ChNVU/51u/BN62rd/j5VRlU//+3ctBaE2Dz/bv6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223520; c=relaxed/simple;
	bh=Lo9XjO3DU9UfMUQ1481XgkhhMQZJ6hWV5TCFqNss5nw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oBlV3U4oUwuFne7dSoHpjD5qZwoRmlTe+Aib+XBUlzFrInwb40O2Ujexgk4RtXELOD4McvGoVgAQHPtnSIjDYKQfFvI+JIpxB5qyuFe8KphizVZGV8XmnZD6zShZk0zpaHoKuGkC+pxyPdcjCEkDgd2n7gYBKHbxhqOn95X3eFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJHucTEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJHucTEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118D11F000E9;
	Tue, 28 Jul 2026 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223519;
	bh=VmoJjxPw0tgVnM0ctb80tj3GEAY5ICT3m4IDJ7kWAzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJHucTEOdD158jdxgSjw3nu6pg+/Gid0VJgv++bMo0T0d0/fx3im4VhzCIB3UwMr4
	 +53HF6pZmlsIr03NTLNYck9Ho3+/Fa4buRE5wH6XyQVio1eXmfsKMvzs2P+/OpWNKq
	 SJryHoFZj2NRtQVIhxhlDMi4OCjPLdQncbpZ1j3zH9M5FXOi8x0yTL3L56S0xYyN4D
	 2R/IZA70J+kJGxR+amOCGUOLI34wWjL9foii2+Vuxc657NTwSveTxdwHBMBG0NGnMf
	 NeDWJxRvMj/mSmwpni0Tip2a1sjZdTyKx/imzAL5mPSwl05Ce4IuRW/4TuUdxcfhFI
	 8vQOWCYxof2MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: don't preserve ownership during install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin Kaiser" <martin@kaiser.cx>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728071516.2706695-1-martin@kaiser.cx>
References: <20260728071516.2706695-1-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:25:17 +0000
Message-Id: <20260728072519.118D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of the GNU-specific `cp --preserve` extension breaks `ma=
ke install` on platforms with BSD or BusyBox `cp` implementations (e.g., ma=
cOS, FreeBSD, Alpine).
--

--- Patch [1]: [PATCH] libbpf: don't preserve ownership during install ---
commit 20b6f948388a1067581300a57d47fc33d1950c11
Author: Martin Kaiser <martin@kaiser.cx>

libbpf: don't preserve ownership during install

This commit modifies the libbpf install_lib target in the Makefile to
prevent leaking the source tree owner's UID into the root filesystem. It
replaces the cp -p flag with the --preserve=3Dmode,timestamps flag to only
preserve specific file attributes during installation.

> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -231,7 +231,7 @@ endef
>  install_lib: all_cmd
>  	$(call QUIET_INSTALL, $(LIB_TARGET)) \
>  		$(call do_install_mkdir,$(libdir_SQ)); \
> -		cp -fpR $(LIB_FILE) $(DESTDIR)$(libdir_SQ)
> +		cp -fR --preserve=3Dmode,timestamps $(LIB_FILE) $(DESTDIR)$(libdir_SQ)

[Severity: Medium]
Will this break the installation process on platforms that do not use GNU
coreutils?

The --preserve argument is a GNU-specific extension. It appears this might
cause the make install target to fail with an unrecognized option error on
systems relying on BSD or BusyBox implementations of cp, such as macOS,
FreeBSD, or Alpine Linux.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728071516.2706=
695-1-martin@kaiser.cx?part=3D1
