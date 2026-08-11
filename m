Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5D367B84;
	Tue, 11 Aug 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458396; cv=none; b=mAKlczyTuv1KUDB1PNuT7jO/F9FA1ZfYDY18zOTkKdROtz8o1wpJQ4kd2LWBIaUaJKddyiiVCbOGkirqBQsiEjjGN60sBlzmaGOEcapFdOXp4s9JXIpXxgTURGwPAw49kNc3vXur/9Zrqv+O5H2S55GsWRVnNEWFCr65Fq+2H0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458396; c=relaxed/simple;
	bh=zXNrmr/h0+aN+aJKm6hUkbXp5UPtBJs2i/R7sTjzWHw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GjAkGzXTyE5Dltt/cLdDyTzG4phL4fP6+fxseeEmek3KCcuwK4hn7OoM8cKxr5Oc4i8Ye7Kh2nzIn4dK9pW2b8FelA0erZMntd6+HD/AHGj/EbKd9O8dncLkFuuYjUb8SHLEMjULI0YKQ5UV6+ytuFy5ApPGJiKa/zBvTkMatwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eVNOQGeu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eVNOQGeu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 387904E410F8;
	Tue, 11 Aug 2026 14:26:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A73E6033C;
	Tue, 11 Aug 2026 14:26:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1020311C48D19;
	Tue, 11 Aug 2026 16:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786458386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cXUxedOIBssKclFtEsdMAk4+uoxwahPc9iX1cU90uIw=;
	b=eVNOQGeuHl2w1zL8FbCDX2EQcr8K6irtZ2V3UoVcW7rQZEufxPvFAI7uLNdqGn4lSh8UeG
	I4ME/U8zJ9IVB7v0H8iAYiNzyxWNUHb1Lx0mYZ/KethPbDE1ILQsTwpdgLDSsy1+d+66Q8
	DwIoc4DiP/QhPWMxC3zhDNXcnRVF3dL08gz4iX8dRakkDB/vPU+7F4mQb+nIdkqBi7o9Ef
	+v68et7OybK/KTQ6USyip6ojuOjN1LBSf2QP2fcDbtEeoF/kCbYVpN9UisQ2C3gRRnDyvO
	fhWSV5fBaOCiBD9aMYzjhSYWN/dOwzmZ6ys/mASeuvctvsrzkiF7T4ookuLMWA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf v3 0/2] selftest/bpf: make test_tc_tunnel and
 test_tc_edt more robust to CI load
Date: Tue, 11 Aug 2026 16:26:11 +0200
Message-Id: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuYrq3pD1DqynsYQ1oYpIotoYVIC
 HcX6sIY4/JN3nxvRh56Ax4ddzPqYTTeOLsGvt+hslH2CthUa0aMsIwISnAoizBYC21Rt+o+YSZ
 AKiqprghH61fXQ22eUTwj3dXo8j76Qd+gDJu11Rrjg+unuDvSWP47MVJMccKU0imXUiXypJ0Lr
 bGH0j2iP7KPkBP+K7BVyFKhWS6qWon0W1iW5QVVEOHMCQEAAA==
X-Change-ID: 20260710-tc_tunnel_flaky-27e9a191bd03
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is the v3 of the series aiming to reduce the flakyness of
tc_tunnel/tc_edt tests in CI. This revision handles Ihor's feedback
about the need to conform to the timeout value passed in opts->timeout.
The first commit has been reorganized a bit more than what was needed
for this change, to make sure that the code can be followed easily.
There's also now a second commit to make sure that test_tc_edt benefits
from this new connect() handling.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- set errno before logging errors
- respect time budget set by
- respect opts->timeout_ms when polling: only poll for the remaining
  time not already consume by connect()
- keep polling if poll returns with EINTR
- reorder early returns and add intermediate variables to clarify code
  flow
- Link to v2: https://patch.msgid.link/20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com

Changes in v2:
- drop unneeded initialization
- add back error message for immediate connection failure, and slightly
  reword the async connection failure error message
- Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: keep polling connection that is still in progress
      selftests/bpf: add connect timeout to test_tc_edt

 tools/testing/selftests/bpf/network_helpers.c      | 70 ++++++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c |  2 +-
 tools/testing/selftests/bpf/testing_helpers.h      |  9 +++
 3 files changed, 75 insertions(+), 6 deletions(-)
---
base-commit: 53cc65185a51fa9dd288cd1137a21467eced2df4
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

