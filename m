Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2E3E0096
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262887; cv=none; b=Y32SDdEp1uFpcOYdqYYALw1naTYF2pSh9DZytBkvza85te8wmPRvHh+WiBU8lAuBF82aVt3AWGDjDdcpYd6ZJuib7OEQmzr2C36A84dioMGEHMUgEm7w/FaLSQLzYY9LRKfriwwExSn/AR2H79SHC/CqIgg9fiSZEyso00R09SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262887; c=relaxed/simple;
	bh=UOIT9eWz9T21vmXCQo71TaG9cnonsGgS8BpzVT1JC7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eT3qFAFZ6WM3lLTWsgbR1R/YELrptau1FzlnDN1eMJtemYrPBAOl9yoyiZm3lJvK1GMIE7O88b0DnOKR5Ce24Kk0lEZ0fpuO5ASoHhorE2V7GWhNdsuAm2railc/kasqrrgWtSEU5ZLx2nwRMu900xPH/CU9E/A8yR04JwgHNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPBd9KH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPBd9KH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8131F000E9;
	Thu, 20 Aug 2026 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262886;
	bh=UOIT9eWz9T21vmXCQo71TaG9cnonsGgS8BpzVT1JC7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UPBd9KH0mmKXEqjz0YO75cMRfWzbf/VsyCEeDKxjUPXIpBOwTQxgO1/tHnyVFL7hk
	 q2Pe568BQjaTED4WHqGGw8pNPV+tYHKTcKILRlWi/YNfpHSyiNS5wuAbUfGleAcch0
	 4yDee2EXUPmVHwc0biKQZyxJ9c99iefMwKYC63ncQnYnkB5POzZK3KPDSPP9KBqqgb
	 V165g9W/nUZi9mzY40C5aqm61PqmlDXtj6IUzmKIKR0joe9jZZEas9yeQGQRWSBZeW
	 a0Nx2pGRQLd8iDsWUSYEzBcle7KxtLTXcoY6xZ7i3CcKWy6RDTVCFl4krzHV6m/Qwj
	 flS6MTWuQz42w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] selftests/bpf: convert lirc_mode2 to prog_tests and
 extend coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820214332.89030-1-sean@mess.org>
References: <20260820214332.89030-1-sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:54:45 +0000
Message-Id: <20260820215445.EE8131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments use C++ style `//` instead of the mandated kern=
el `/* ... */` format.
--

--- Patch [1]: [PATCH v3] selftests/bpf: convert lirc_mode2 to prog_tests a=
nd extend coverage ---
commit 5795d2e92debc935e217deb800d55dcb81234f7f
Author: Sean Young <sean@mess.org>

selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage

This commit ports the lirc_mode2 test to the prog_tests framework and
extends coverage of the BPF_LIRC_MODE2 attach/detach/query APIs. It also
removes the obsolete user and kernel test files alongside the shell script.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/=
testing/selftests/bpf/prog_tests/lirc_mode2.c
> new file mode 100644
> index 0000000000000..7b7352dbcd826
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// test ir decoder
> +//
> +// Copyright (C) 2018 Sean Young <sean@mess.org>
> +
> +// A lirc chardev is a device representing a consumer IR (cir) device wh=
ich
> +// can receive infrared signals from remote control and/or transmit IR.
> +//
> +// IR is sent as a series of pulses and space somewhat like morse code. =
The
> +// BPF program can decode this into scancodes so that rc-core can transl=
ate
> +// this into input key codes using the rc keymap.

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem comment style?
Multi-line comments under the BPF subsystem generally require the standard
kernel C-style block comment format, with the opening /* on its own line.

Should these be converted to the /* ... */ format?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/lirc_mode2.c b/tools/testi=
ng/selftests/bpf/progs/lirc_mode2.c
> new file mode 100644
> index 0000000000000..98137f3c5c03d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lirc_mode2.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// test ir decoder
> +//
> +// Copyright (C) 2018 Sean Young <sean@mess.org>

[Severity: Low]
This isn't a bug, but this file header also uses the C++ style multi-line
comments instead of the preferred kernel block comment format.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820214332.8903=
0-1-sean@mess.org?part=3D1
