Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203618A6A8
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771271551; cv=none; b=fcdPPc50X14FC1XshIaVTQwNb8bDP2HwK3NG3q3jxdejVzJJsb+7PWOF72y45srryWYuknXqt0yjQ3Z+orL4UIArjJCp0QeRnLywLqnGaqtcqkL50o0onEbifTvrP6qwW0G1sGwkiX/prQ0dlC0Vrcu87YqJy4bEhZ5RIyEBEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771271551; c=relaxed/simple;
	bh=x7dfMa5GA1Xbf8In5ap4vWWRLrqqTKxFj9yKN/wOiPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc; b=fZD1xZdENbuvw2ktia5oqnexqwIFlVPn+lmQr0Ozho1BEl+ti/NJSbuQM9aMMz1TGMA6OEgQwYmntBe2Rn4wbD+i8bf0bLALk2RFi4v9V1C3KZEGncF+34lW1Q+VubTYytn9d1/MRnOoFep7B3ioKMRsOHh9ms0MlZ8/mjJQsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qf/v5nJG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qf/v5nJG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8BE251A0FEC;
	Mon, 16 Feb 2026 19:52:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 52CF5606CF;
	Mon, 16 Feb 2026 19:52:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC96110368507;
	Mon, 16 Feb 2026 20:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771271545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XYXHtfbo0pH7wO+3dSnUy3BZQ4ZuVKeBp9cprBfjDQo=;
	b=Qf/v5nJG8QJ4GCvYcSvmqjKtRGBP9EuSB9O+pMChLj6StEFOqzFvyd4xiOE6L2YDNsQlhk
	ucTbN7fi/mqFZ/8F/7ZXa5kju7lqxs0OIE9xbDy6ybzEMmHPTchLBwFd6TiofKtvZGqlVm
	IRpOVMbu+0nWZ6qbVdhePBK4A8IhpG6KvccNojQv+J3xdZdCm3shTgNvOLvxwNs9ECwQyE
	nlduPpa6WGHV31TsjRpjd/dLlYws8F5DVi5YfUDOCIgIUFyOqjKt0ayo9igzU6V5xsuPKM
	6Qt9ZTKIKQrGJxiPFQEE8cZkwZDvU+QSD+pPnPVGyfOQxUHYrHu+DvxTO30ShA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 20:52:24 +0100
Message-Id: <DGGNCXX79H8O.2P6K8L1QW1M8K@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <lsf-pc@lists.linux-foundation.org>, "bpf" <bpf@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] adding KASAN support to JIted programs
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,
I'd like to submit a topic for LSF/MM/BPF 2026, about the on-going work
to implement KASAN support for eBPF JITed programs.

The verifier gives strong guarantees that any inserted eBPF program is
safe for the rest of the system. However, this safety relies on the
assumption that any kernel interface on which ebpf programs rely is sane
as well. If a bug exists in the kernel (at different possible levels:
JIT compiler, bpf helpers, kfuncs...), a valid program can still perform
invalid memory accesses, triggering a wide variety of bugs. To help
kernel developers detect and fix those bugs as early as possible, KASAN
support is being added to the eBPF subsystem to instrument JITed
programs.

KASAN is an in-kernel memory error detector. By tracking each "granule"
of allocated memory thanks to a dedicated shadow area, it is able to
check any memory address being accessed (load or store), and to emit a
report of any invalid access (mostly use-after-free and out-of-bounds).
This instrumentation relies on both compiler instrumentation and shadow
memory updates on any block of (de)allocated memory. The goal of this
KASAN-for-eBPF work is to replicate the build time instrumentation but
for the instructions that are JITed at program load time.

The work on this feature has started at the beginning of 2026. A RFC is
being discussed on eBPF ML (see [1]) to validate the general approach. The
goal is to at least get a working prototype for LSF/MM/BPF, and then to:
- showcase the prototype and its architecture
- discuss the kind of bugs covered by this implementation, and those
  missing
- discuss the design and any potential roadblock
- the possible interactions, overlaps or gaps to bridge with other
  memory sanityzing solutions being implemented in the kernel (see [2],
  [3])

Thanks,

Alexis

[1] https://lore.kernel.org/bpf/DG7UG112AVBC.JKYISDTAM30T@bootlin.com/
[2] https://lore.kernel.org/bpf/20260212011356.3266753-1-ihor.solodrai@linu=
x.dev/
[3] https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com=
/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
