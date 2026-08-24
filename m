Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967703515CF;
	Mon, 24 Aug 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582984; cv=none; b=hVa9VHzS1AsOWi1JQc9b0BszyoLks7P1GPqjzZzMvF0USQLJl3KCScNvwy+8f8yw8T97yIbVPD2F5d+zbX2tv9nb8QWc4QC2iqllSQAQpo5NTy+xeTOZyoYkJSS44UzuevyFh8QuEsOAQii7Yc9kYZcrSIWTE8tU6zIiL+TkeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582984; c=relaxed/simple;
	bh=IUNDJbRJ3ytVgLJU45Sbn73YjXlpx/zkd8eV3XNCX8I=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=lSJErYg3MDELTGq4zmOzIKFmwQB9Fj7BUPM8rJafOCrGxBTdtWf73lVF1z7acJPrxbTucO0eF/iWXxVv5TebziLAqy8nKhMyQIV8E8besWLteCugQqDMhDbGf8JZhZd/K+gKnr0bBcyiMUifdd3U/IXeLsErIxIudv3AHvuK2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QTbe3eWB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QTbe3eWB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E79351A17FD;
	Mon, 24 Aug 2026 14:49:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA8615FFC1;
	Mon, 24 Aug 2026 14:49:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19F6F11C795E6;
	Mon, 24 Aug 2026 16:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787582973; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yeBIfdmdHn6R0I399e2bf6QJ31j3oIPc40ro3PF2Hd0=;
	b=QTbe3eWB+/XxM2kh3DJ704mUmLWR6FTZWi6kd3wBXbef0KaFVl1uj0VvBfRVrz6I9hv00H
	OgIiJkZK55ZT9plzlIwQhiWt9fJR9Eqy8vidDip/q6CF5GajNEoDELazHm+MnTcpsAZpIt
	pZPITRA0PfqBFCBJgXjG5lVCsncGYFGfJf3JhPgEUUa09ijFqi2fofZ3Z0jl20VG/wN+Ys
	jA8k/FN/qb7NPNeg5Voc05WFJ0laVX3bIoZl/gMSiIpjE22dwLqBv2QQpFCe883pykIflv
	I4fI5GOujMQxFjjIX8NQEUA60PVtQ+FS0aibhjrPfKxdISTai3mbx4GFjNnZ8A==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 16:49:29 +0200
Message-Id: <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT
 processes
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <bochaolucky@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com> <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net>
In-Reply-To: <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net>
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel, thanks for the notification

On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
> [ Trimming the excessive Cc list, and adding Alexis ]
>
> On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
>> From: Bochao Cao <bochaolucky@gmail.com>
>>=20
>> test_xdp_features.sh waits for any xdp_features listener to appear and
>> uses pidof during cleanup. A concurrent test can therefore make another
>> test proceed before its own DUT is ready, and cleanup kills every
>> xdp_features process on the host. The readiness loop also has no timeout=
,
>> so a DUT that exits before listening leaves the test hung indefinitely.
>>=20
>> Track one active DUT at a time, wait for ss to report that exact PID wit=
h
>> a bounded retry loop, and reap it after each test. Consult the shell job
>> table before signaling the DUT so a stale PID cannot target an unrelated
>> process. On failure, terminate the shell job with SIGKILL and reap it so
>> blocked I/O cannot hang cleanup. Install an EXIT trap and signal handler=
s
>> so failure paths also remove network setup.
>>=20
>> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool"=
)
>> Closes: https://bugs.debian.org/1136522
>> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
>> ---
>> Tests:
>> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
>> - make -C tools/testing/selftests/bpf xdp_features
>> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
>> - verified cleanup terminates a blocked DUT without affecting an unrelat=
ed process
>> ---
>> Changes in v2:
>> - Clarify that avoiding name-wide process matching, rather than dropping=
 a dependency, is the motivation.
>> - Track and reap one active DUT at a time instead of retaining historica=
l PIDs.
>> - Address PID reuse by signaling only the current Bash job during cleanu=
p.
>> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang wait ind=
efinitely.
>> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-lifecycl=
e-gmail-v1-1-45984df8d295@gmail.com
>> ---
>>   tools/testing/selftests/bpf/test_xdp_features.sh | 82 ++++++++++++++++=
++------
>>   1 file changed, 62 insertions(+), 20 deletions(-)
>
> Sorry for the late reply. With regards to https://bugs.debian.org/1136522=
, src:linux deb
> does not have to depend on this at all, so the src:linux can just get rid=
 of procps in
> any case if this is indeed the last dependency. I'm not seeing the test b=
eing run in our
> BPF CI. I've Cc'ed Alexis as he's in the process of migrating and/or remo=
ving tests from
> tools/testing/selftests/bpf/ depending on how they fit into test_progs fr=
amework. I'll
> let him comment if there is already work in progress. It feels like this =
script could be
> reworked into tools/testing/selftests/drivers/net/hw/ tests and removed a=
ltogether from
> the tools/testing/selftests/bpf/ dir.

There has been an attempt to fully convert and get rid of
test_xdp_features.sh, but discussions around the corresponding series
highlighted the need for the script to remain available for testing on
real hardware.  Features covered by the test_xdp_features.sh that were
not covered yet by test_progs have been added to test_progs (in
xdp_cpumap_attach), see [1]. So there's currently no active effort on
this one on my side.

Alexis

[1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51cea913710=
c@bootlin.com/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

