Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1147140F
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260278; cv=none; b=Zrwr19Se9s8jVLN0BeogPStJC6jCe2A9c1emSKYtsyr9KyjCWmtjfdF4tM6LbgqGFvCQRLoFm8Udj93tC0DTqyW56QMSQOanGWG14guNADMrSsmiWww6qboc6+zia10RYH3ZvTF9J5jwDHBnmSCsKxCFjtcDEsUnMB0D7xRWMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260278; c=relaxed/simple;
	bh=PK8u6chV/CcOoXmG9rKTnsQI+/ezsg24kBHwmL/MidI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sn8d/qhfpwQQFHDD9KuH13eFfiPxiREY7TlhIlj1Riir/ChXafH7AZcCMQlerbzEcGLYkZZZUvLDSMAh1hkPhXAB4I9Zz+0wRzg+/FgQp22AB0nLlHeCp40rW9kFkAHW4gd/A0UXY3cQt/1IFzberZE9kTjr8X/PN6Hx6j49xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aupzxlQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aupzxlQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D691F00A3A;
	Thu, 20 Aug 2026 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260277;
	bh=golhQ08a0mK70/6Oarn00Wsys6Kc8XjkmVMLVuVRUt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aupzxlQgn1kUV7YqF/vH/LDJdwn92eZLNMAJuiH4B4RPpfOi6EmXeOBaQLPfENo6S
	 aQRAgdvlbn+PGTt9no2mPiSYf0u5IKo48hhXuCPbivkFFdiVyMtqsArggYU4twWd0u
	 3G6D+F9Ngupc1OMeYifuco+yDmYQRjRZHL3+cUS7PMPpfZfsJ1pINRhA61LMkWoN3m
	 zs8CcjMALR9dsKo7LkXgfI3Hfyf5lf1KG92UkFy/VoytzOtgBIS0tItt8UDbLkOrSj
	 IsfIfHL1z6B0f+4HAEDeuxKTntsQzd979n2axZFw+6RdYBMEklA40H3saH1NEOxX1C
	 Hn4hJOxXq+hXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selftests/bpf: convert lirc_mode2 to prog_tests and
 extend coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820210156.50603-1-sean@mess.org>
References: <20260820210156.50603-1-sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:11:16 +0000
Message-Id: <20260820211117.26D691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] A stray `?` character before a closing brace causes a compilation e=
rror.
- [Low] Multi-line block comments use C++ style `//` instead of the require=
d kernel `/* ... */` style.
- [Low] The printed error message for missing rc devices incorrectly repeat=
s `CONFIG_RC_LOOPBACK`.
--

--- Patch [1]: [PATCH v2] selftests/bpf: convert lirc_mode2 to prog_tests a=
nd extend coverage ---
commit b838818703c3bdf7a467c66079361ca289b5a98e
Author: Sean Young <sean@mess.org>

selftests/bpf: convert lirc_mode2 to prog_tests and extend coverage

This patch ports the lirc_mode2 test to the prog_tests framework and extends
its coverage. It tests attaching, querying, and detaching BPF programs to
and from a lirc chardev.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lirc_mode2.c b/tools/=
testing/selftests/bpf/prog_tests/lirc_mode2.c
> new file mode 100644
> index 0000000000000..8e485db70b78a
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
> +//
> +// This test works by sending IR over rc-loopback, so the IR is processe=
d by
> +// BPF and then decoded into scancodes. The lirc chardev must be the one
> +// associated with rc-loopback, see the output of ir-keytable(1).
> +//
> +// The following CONFIG options must be enabled for the test to succeed:
> +// CONFIG_RC_CORE=3Dy
> +// CONFIG_BPF_RAWIR_EVENT=3Dy
> +// CONFIG_RC_LOOPBACK=3Dy
> +// CONFIG_LIRC=3Dy

[Severity: Low]
Is it possible to use standard C-style multi-line comments (/* ... */) here
instead of C++ style comments? The BPF subsystem guidelines prefer the stan=
dard
kernel multi-line comment style.

[ ... ]

> +out:
> +	if (!found) {
> +		fprintf(stderr, "No rc devices found\n");
> +		fprintf(stderr, "Enable CONFIG_RC_LOOPBACK, CONFIG_RC_LOOPBACK, and CO=
NFIG_LIRC\n");

[Severity: Low]
This isn't a bug, but there's a typo here where CONFIG_RC_LOOPBACK is listed
twice in the error message.

> +?	}

[Severity: Low]
Is this stray '?' character intended? It appears this will cause a compilat=
ion
error when building the selftests.

> +
> +	globfree(&gl);
> +	return found;
> +}

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
Similarly here, should this be converted to a standard C-style multi-line
comment block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820210156.5060=
3-1-sean@mess.org?part=3D1
