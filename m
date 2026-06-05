Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95E4DB572
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661636; cv=none; b=r8e6cu7042Qb2TU1SaGXops9fMV1bHJj9OHa4IX49ZCWSkJvU2JKzudyuu6NgXp3n2N6ii+Ic0CC2HXnacQLEUfyZh1z0h6CWz0oTA89mN725e5yQe9IMNUr6c1hGJRxb33tRatXmI9v+9yZlhsOKpg/WFSrXtwyTAgGBwThtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661636; c=relaxed/simple;
	bh=wlHppEGrDcqqI15yLTVFWLG9Z9sFKgVGnSvvxIomy4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GN9T+uJ9HtZRLVVwtIPeMIX6tfgMKbWfpLFPZs9/bXyhdZp6AYZ5fOy5IqdHhODQKuRXSN0Eg8e0Z+VsCL2FcSpCtQ+dB33qFoGyeWdlP3iVf+13kwyJgXNh5HKRhkfVdr9yIvT3Wecx4wJ27RLpzRYwkz6b0lXmW0BZA5kV4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQfTxszC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQfTxszC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61741F00893;
	Fri,  5 Jun 2026 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661634;
	bh=squm1f1OQzd6pPrFI8IwUn5K28zmdJEfklICpH//6FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQfTxszCab2aU/q7CSo+cFmeEw2gFYjonOZuX7u4CSYrjPVRguXDjmJywLEoUdODb
	 9acLXHa8LAsvAOI0PPbe4tY37E7eVR8T6hHhVNMex92sm7M11w9OPoMxP7gtcEYF6S
	 Fe6D4SIiQLzzqhmpRMbStk3ZqmBFAjHOe4c4vFrOy7fadIv8hWCVFoIGOX5Ks1LpBX
	 GpRMy1s8tqdE1BAyNDmFpyHK/HzDt1liykmnTUeiKtZb4Z9rhq7XxnyLaHyWL2G+OL
	 m57kbaMhuKeZJz59F3Q/JNvE3zXFhuPt5I5cWDdsZ7GSxZqb6nDxQ14DFtRtYHz/Ur
	 hJoo9gQuegaRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] bootconfig: render embedded bootconfig as a
 kernel cmdline at build time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-bootconfig_using_tools-v2-3-d309f544b5f7@debian.org>
References: <20260605-bootconfig_using_tools-v2-3-d309f544b5f7@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:13:54 +0000
Message-Id: <20260605121354.A61741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `$(CC)` with `$(HOSTCC)` in `tools/bootconfig/Makefile` =
breaks cross-compilation of the tool for the target architecture, and incor=
rectly passes target `CFLAGS` and `LDFLAGS` to the host compiler.
--

commit ea99f5270759e89336f3c07278a0b9ccf9b626a4
Author: Breno Leitao <leitao@debian.org>

bootconfig: render embedded bootconfig as a kernel cmdline at build time

This commit adds a build-time pipeline to render the "kernel" subtree of
CONFIG_BOOT_CONFIG_EMBED_FILE into a flat cmdline string. It also updates
tools/bootconfig/Makefile to use HOSTCC instead of CC so the tool can
execute on the build host during the kernel's prepare phase.

> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index 90eb47c9d8de6..aa75a7828685b 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
[ ... ]
> @@ -15,10 +15,14 @@ override CFLAGS +=3D -Wall -g -I$(CURDIR)/include
>  ALL_TARGETS :=3D bootconfig
>  ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> =20
> -all: $(ALL_PROGRAMS) test
> +all: $(ALL_PROGRAMS)
> =20
> +# bootconfig is a build host tool: Kbuild's prepare hook runs it on the
> +# build machine to render the embedded cmdline, so always compile it with
> +# $(HOSTCC). Using $(CC) would cross-compile it under ARCH=3D... builds =
and
> +# fail to exec on the host ("Exec format error").
>  $(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
> -	$(CC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@
> +	$(HOSTCC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@

[Severity: High]
Is it safe to pass $(CFLAGS) and $(LDFLAGS) to $(HOSTCC) here?

When cross-compiling, $(CFLAGS) and $(LDFLAGS) often contain target-specific
flags. Passing these target flags to the host compiler might cause it to fa=
il,
or incorrectly generate binaries for the target architecture that fail to
execute on the build host.

Additionally, since bootconfig is an administrative utility meant to be
deployed on the target system, will permanently hardcoding $(HOSTCC) prevent
users from cross-compiling it for their target devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-bootconfig=
_using_tools-v2-0-d309f544b5f7@debian.org?part=3D3
