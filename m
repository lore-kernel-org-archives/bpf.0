Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA3D811E
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169559; cv=none; b=Gdw3ujvXH3Lp6rn3J0BTTi3+O4n/siQh4qdBke/IHgkf3TmtJt6Vbbqxfb7RSjK3GZOvlSLOGpZ9avQBlzEX2C/On/K/hBLQHfCk/tUjS8gb4uje0w5y99fmXTpp+4pXbH+RxV0I/NF4FRl+xbRvoHWDahqI/BeWW0PLXAde+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169559; c=relaxed/simple;
	bh=7L4NgTE6Jqz8ArqJMIVgftQ7jd9GEI5yFDch3FyHj7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject; b=r8PqtzxXrQugRUgK/51peVgCHiFh4M2x1EirEmrE0VsR/HZANroZvBOzEMB9vfhP1ki76p/G3PWA+MG+bR50YlN1XvZDDjsCJxPJtogb19BnZ/a4SfDTUiZ2skN3a41fuZEDhHnbNly2KeDHkrqcE72Ab9Oo+JlXOhlgodS4KWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i/ERBYjg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i/ERBYjg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 913E51A1716
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:59:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 524F05FF42;
	Wed, 19 Aug 2026 19:59:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 455E111C75B2C;
	Wed, 19 Aug 2026 21:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787169548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7L4NgTE6Jqz8ArqJMIVgftQ7jd9GEI5yFDch3FyHj7I=;
	b=i/ERBYjgxpV9/kDRuk4FQJNj+R6EvSRHDZoDvSCbkOoe6+/HEQ4rDbBfEgKjX1Uj2T1ybe
	xtFhas/YnAcKiegPPTgCqbAijGFla+UZgqeKna7aFiv8eqMQ3l2kxSVGUzvuWyOfCGAaPz
	JGyRzcYTQ2iXXGmC4EWjalqZUJE5nDtm2wY1RPu87WQst3B/2IroO/wdT0E+pM4nh78UyU
	VRMI70zdxZiZKJLfZgvpMufMSRrHATJAyyOtsYsq39w4gTFWxbKN1FkIKHHCZPerngNrH0
	Ung4nD8caelXt4rMN/3peh1ffgVSfIzU7xzmsXzWvg1JaVe7uTy/qiUlqbcWMA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 21:59:06 +0200
Message-Id: <DKT6QBHWC8YM.4D90SOC807CW@bootlin.com>
Cc: "Quentin Monnet" <qmo@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Bastien Curutchet" <bastien.curutchet@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "bpf" <bpf@vger.kernel.org>
Subject: [RFC] running bpftool build tests in CI
X-Mailer: aerc 0.21.0-0-g5549850facc2
X-Last-TLS-Session-Version: TLSv1.3

Hi,
as part of the cleanup/automation effort in the BPF selfests directory,
I am now taking a look at test_bpftool_build.sh, which ensures that the
different supported ways of building bpftool work correctly. As this
script does not really exercize anything at runtime but rather at build
time, I'd like to propose to introduce a dedicated step in the CI
automation that already builds and run selftests. I have opened two PRs
in kernel-patches vmtest ([0]) and libbpf/ci ([1]), hoping I am not
confusing which code should go where between the different repositories
kept in sync with each other. I have also opened a dummy PR on
kernel-patches/bpf ([2], not to be merged) that shows how this test
would look like in CI.

This really is a RFC, as not all tests from test_bpftool_build.sh are
being executed: I suspect those based on .config to be currently broken,
but that can be handled as a second step, depending on the chosen
direction.

Any comment welcome !

Alexis

[0] https://github.com/kernel-patches/vmtest/pull/517
[1] https://github.com/libbpf/ci/pull/236
[2] https://github.com/kernel-patches/bpf/pull/13368

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
