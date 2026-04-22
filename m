Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7C33688E
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824733; cv=none; b=scGbu8CXJz2ar24//pB43QSf0cAv3ngzE9+7gHccGR5HgjHRq8SSQP8cbX/mVfo3w/oVhuBqaRSt9iagmWLdJ8pxPHh7ue8KWCUzFxF3oVVavvoBgEIRQ4OsMwErt14AQDsToNXXfF5YVEL9/FCu23jWxhFUf+OZkBi+gSbN16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824733; c=relaxed/simple;
	bh=hNxnrjGfiv8PYZSG6bMkmzMfbbBFZ0pMMjOJNa/ntHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhsQ7f9vftuSEE69pECMgv1BJRybuJylQiOkCLEhLZTAoe4t3tpjAGEAWgRsFpBek6TwqSzLF2yVoFNk6iqxd0Ns+zfDx5R7ncXueS4dqr8zvMfH+cbH6XJSKqGEnaLHCWfsoolFcPdWLw7cOtAxcxsn2COO2DsPCFuoBn2uJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b63N7AgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b63N7AgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1664C2BCB0;
	Wed, 22 Apr 2026 02:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776824730;
	bh=hNxnrjGfiv8PYZSG6bMkmzMfbbBFZ0pMMjOJNa/ntHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b63N7AgPmwISoUmFOsXQ4HlRgNmCVde7qKWicEIDDAZcCEKSHjtYiG67Pnj1GRGPW
	 S9jYJ8yPmdCLrHeYqTXGWRUVqILBaNTcaHrO79CUfOPHp2LpvQ8EYRDR/5UxsAmaKk
	 O+JTVMLYYY/ouiz2TgA3gWWmoQrquQMcrMn3JOkA4q0j5hXcVt3HDiQMvZFEsQ/tFU
	 yQydh99zsUX3Pho83a+PhY4tofERIqt/hr26leS3bxIPFg53Xd0ugQQNzJ7LXmsgg/
	 p7or40R2lfA1EuEMhwgKz+w4Lw4KoF0XhDIXPGn2j26hRC5iB2huiec3rg5rENphwj
	 G2W1SLgJwLbeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] [v4, net-next] net: ethernet: ti-cpsw: fix linking
 built-in code to modules
Reply-To: sashiko@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260402184726.3746487-2-arnd@kernel.org>
References: <20260402184726.3746487-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 02:25:30 +0000
Message-Id: <20260422022530.C1664C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Shared global function pointer `cpsw_slave_index` causes use-a=
fter-free and out-of-bounds access across modules.
- [High] Shared global mutable array `ale_controls` causes hardware state c=
orruption across different devices.
- [High] Userspace ABI breakage due to silent module rename of `ti_davinci_=
emac.ko` to `davinci_emac.ko`.
- [Low] Swapped EXPORT_SYMBOL_GPL macros for `cpsw_hwtstamp_set` and `cpsw_=
hwtstamp_get` under `!CONFIG_TI_CPTS`.
--

Note: The format of this review is altered to provide a free-form summary
of findings due to quoting/recitation restrictions.

commit bddbb0ecb5a5bfa6e8eb526f950b6ccd9620d793
Author: Arnd Bergmann <arnd@arndb.de>
net: ethernet: ti-cpsw: fix linking built-in code to modules

This commit changes the build system to create separate standalone modules
for shared CPSW driver components. It aims to resolve Kbuild warnings about
objects being linked into multiple modules by exporting symbols and creating
shared modules like ti-cpsw-common.ko, ti-cpsw-priv.ko, and ti-cpsw-ale.ko.
Link: https://lore.kernel.org/lkml/20240417084400.3034104-1-arnd@kernel.org/

Looking at the extraction of cpsw_priv.c into the shared ti-cpsw-priv.ko
module, does this introduce a use-after-free regression on the global
cpsw_slave_index function pointer?

This pointer is now shared system-wide across multiple drivers. If both
the older and newer cpsw drivers initialize and overwrite this global
pointer with their own module-specific functions, will unloading the
last loaded module leave a dangling pointer?

If the remaining driver attempts to access it, could it lead to a panic
or an out-of-bounds array access on cpsw->slaves?

Similarly, in the new ti-cpsw-ale.ko module, can the shared ale_controls
global array cause state corruption across different devices?

The ale_controls array is mutated at runtime during cpsw_ale_create()
based on device-specific parameters. Since it is no longer isolated per
driver, if a device like the am65-cpsw-nuss probes and mutates the global
array offsets, do subsequent standard CPSW devices end up using these
incorrect offsets?

In the drivers/net/ethernet/ti/Makefile, does changing the module target
from ti_davinci_emac.o to davinci_emac.o cause a userspace ABI regression?

Because the object name changed, Kbuild will now produce davinci_emac.ko
instead of the historic ti_davinci_emac.ko. Could this break modprobe
configurations or initramfs scripts that expect the old module name?

Finally, in cpsw_priv.c under the !CONFIG_TI_CPTS block, this isn't a bug,
but are the export macros swapped?

The EXPORT_SYMBOL_GPL(cpsw_hwtstamp_set) macro is placed directly after
the cpsw_hwtstamp_get() stub, and EXPORT_SYMBOL_GPL(cpsw_hwtstamp_get)
is placed after the cpsw_hwtstamp_set() stub.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260402184726.3746=
487-1-arnd@kernel.org?part=3D2
