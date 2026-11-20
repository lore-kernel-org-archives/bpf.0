Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172625;
	b=f10tob63R5Bam4pKkzs6CbAHJ+lEhFs3sHeOL/UBlNEJqfZ3ozrR5DBqBXyBlVAQEfoj
	 OXll14PqwvZRPxoEyD5K8s/AHH6JJ6gXRuYPWUYnkIosQhG0swVmSUiopVe9/HGTLn94X
	 LiVyeS33KlA0IgEztOveU/uJnQxqrEQDZ7nGV0t14W48PVN7T3stEchdLqnvOP4toBBnq
	 4hNRqmZHv9Sk50Um2l7R53c/efCtyL48JcTXIZdNeuPWYP8jORWUUZUGsU2bM2WSGx+lg
	 EdjOMIBEj/ZcQG2FyHZP5mk51xrzXrSSXISpE+LIx3EI2gWwU+dMCPOCAy0FRXjq2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eH4WPqtMx1NQJ2v6I/NieOQ+s91ZaXVnqAbbCgMR+dU=;
	b=v94rtFBbhbwnsSNP+ZeIzgjM/UXT2CSJx0t0aNFLqwW2CsD23XNFRsUEL/Hm7VScsTV+
	 5lL6JCSmamfVXQ3dWTczsVWSeK1FmEaZFBhRzYACEHF6A3X2Y1y80rt69LI120QnIFdHJ
	 smIrxCDjOGRoU6JFCC7WHPJKYNF5Z4URHeCDTwOwtV59jzxS98dJ11xdUhzoQ5zbYbl9Y
	 xRQKSQJDeUkHgmt3WQIqDErTvulDBfIoxu0Gwea0Ot6ROGR5WIWMUfV89AWSbcDe76Xz7
	 4UlR1fXZbZcKVKZ3ADTZvTKfzp1QJTFinYyDL+ne7IJC/1sJs/fSjmsXzxkzBBk++vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ven0+b1Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F22606A326;
	Fri, 20 Nov 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ven0+b1Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCB1F000C6;
	Fri, 20 Nov 2026 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172625;
	bh=eH4WPqtMx1NQJ2v6I/NieOQ+s91ZaXVnqAbbCgMR+dU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ven0+b1Y6ibJZxRkD4j20hp5YTldV5G/UsoaTfkLy+4+1cckXeQLSHHTxMFRs4hGv
	 gnaVPeCL4UlIEHViLD0rlMDBQd9Tu2vCh9e/UcpcBIgAthoq++qRp8qr9phMVQ0tRi
	 Z4RqCThGG9YM+4l/zbdIQ4I9ApJWhv9OKbern4QAF11LqCyj87C418x05nbVYtSYct
	 6XweWmUvAB6NHSTlu/JfMmNfxylHO3PwyQCCZMwcHjxO9X8fInwD+pmQypwoqztFSe
	 ZCS421E6YatMxmi/lGr7zfF8/cVPRD1uUFwsLo4yYoWCpXd9KokKlw4MOrMyUqt12T
	 ZrgfpHdy+/toQ==
Message-ID: <sashiko-outbox-224980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Don't WARN when
 bpf_perf_event_output() nests too deep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Bazov" <mike.bazov@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261120-bpf-raw-tp-regs-preempt-v3-1-ec109009a5d2@gmail.com>
References: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
 <20261120-bpf-raw-tp-regs-preempt-v3-1-ec109009a5d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:03:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: missing Fixes: trailer for bpf_perf_event_output()
  WARN_ON_ONCE() fix
--

commit ae922aea5dc145502d3e9cea52835a863d8d8bb7
Author: Mike Bazov <mike.bazov@gmail.com>

> bpf: Don't WARN when bpf_perf_event_output() nests too deep
>
> bpf_perf_event_output() takes one of three per-CPU perf_sample_data
> slots per nesting level, and fails with -EBUSY and a WARN_ON_ONCE() when
> it is entered a fourth time on a CPU. Programs get there without any
> bug: a kprobe program calls it, and fentry programs on
> perf_event_output() call it again from inside. Each program's own
> recursion check lets it in once, so three of them reach the fourth
> level. With panic_on_warn, that takes the machine down.
>
> Keep the -EBUSY and drop the warning, as commit 3880cdbed1c4 ("bpf: Fix
> WARN() in get_bpf_raw_tp_regs") did for the raw tracepoint regs slots.
>
> Signed-off-by: Mike Bazov <mike.bazov@gmail.com>

[Severity: Low]
As with commit 3880cdbed1c4 ("bpf: Fix WARN() in get_bpf_raw_tp_regs"),
should this include a Fixes: tag for the commit that added the
WARN_ON_ONCE()?

  Fixes: 9594dc3c7e71 ("bpf: fix nested bpf tracepoints with per-cpu data")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-bpf-raw-tp=
-regs-preempt-v3-0-ec109009a5d2@gmail.com?part=3D1
