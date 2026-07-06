Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B943B6D8
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330549; cv=none; b=OsNADj3I93YKzSekxjNW11izEVzuVlC38CjmRfrlq/xxwgjl6IA6Mw72Df76zaIaxEI0hne+TFGeF03/N27lUtAwY9w/Gsvk+P/YlmkmhNPS+y+GgcDS9VcWbiDS/m4I6r25vjOPy95bGiSLzT0q8Rjf3fTw3GefoDOC04gm9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330549; c=relaxed/simple;
	bh=5A1aBFaM2hbpyB0BRTQF0LrTf8c2s3q3kcvapCMe3Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BX756wk1TJ9seZ7pqF+jNW+8Cc1A4yNrOqL3Exb2XVc9wy8ROVCSJDrJJopT0pvSr6Opnt3mWp9INYZ3TUOP8YTMvvHoybF4ZYBIgszxnlCRmsNURHlOlqy9kroz9FGV79N0TrnpzibdiB6WR8tiVq9D0pb4g27DAdA/bDJn1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7e4My/b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7e4My/b"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso17652135e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330542; x=1783935342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVSBxfRrkS7bnz+659UBlFEvEo0XugvpTzUH02aOh1I=;
        b=Z7e4My/byo2Y6e06DgJaXqkb7RKERqA//nE3IqFNp3oy0PxHuL1Sr3/BPqLk11Akf7
         jW76BHRrzTzEwX63rLorpgfbbRsbhLrkTxvPK5hJFCoDrWklzmsMFFvFk/99LuqKZRFD
         eN9uqmIx4b2g/FHsEPqayiQEyL1Dga3WDwgTcyBcy4YBVr9QkNsareMlYTCYsLG5kPbv
         QjnqVXDPcufFY87T/ElorewEGz7fkE830RKVzAD2tB6nUb1uOyla+cDmd2Nw3NkdU0Rq
         tOOViRX/svG56kV7vyitwlEcXJZoPa6Rjij3/7kwdA87M9KPmqAqjJLDpGMSjSjgHKN1
         /gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330542; x=1783935342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVSBxfRrkS7bnz+659UBlFEvEo0XugvpTzUH02aOh1I=;
        b=FIrn3fgxqqEgf1GpL7gCcYVlLJoVlgPCmf4L8joh46Z3agOvWpKMPPcgmU6HLo3hk9
         VjY9bYcVkHhTf28GgHKZ0UcfmmczzpChoBEQMnMB6wyJ/WYgQc0obIM/GVSwfCtcb5ik
         pddFkSdWNJxHKtt7anqGukU5FbRAoxtVJZ0e0bHXXVgmt1gRft7qFyAhAt6kCqfh9CVc
         aEYi2FLmIYYvMxRlHJvZTB0teaZuY7jxsgJh56HzaSjINWS1VJLk3xyhw6P4nBrG+gTN
         Lz9/eqlg7Zyjt0/P5ynrmtgU2vFib8aczWwuUUOnrPAOOCjCb8F0HZT2E0JUSrPpHe8h
         r1og==
X-Gm-Message-State: AOJu0Yx4I7EZ4Hd4Sruh1ycXurzk6V88LRJPia8ME0A8aOKQ5+QSciZ9
	5Fx8NfG9JLnA6KI8PyV/MkawhUTx6YrmWOMMy19H/osKyzETiXqgY1AhghnhFBdGEy4=
X-Gm-Gg: AfdE7cmm+RJ3PuLSoyn/ZVqjcni7+6G5zREkwnLAZslEqZMoqEnZpNsYBparpa5uRiY
	XLve17dxSCoRPoDyHTuX2d5OsTqUWdmQfS5PxP2sGDdh7gY3LjbUTwa/aLFUWE3P42wGX8pvPgd
	cgy1msQux+SXcCsZ4/CAa7mB/VGYA1mKa6J1aZOmBw1Pu2Cuf++YPBByBsrSlHam4Pbn4T2xNkt
	WFlI9Bk6hQnWv4jvDHW2F8Et/99Ib5b+am/+t5Z3Nr8vsf8EK5+R9Gmjfo7ifNCutFfJCLqd6IB
	b76FdlmECqQVC2xym/DXHuP4I0Yv6tC2FgHB8ALZ3HNhkK2UYtGAUYaUflMDLg9E6K9qxjjlMZV
	HzVNEwnOUJAQoCYClYFTM16+YA5ugOdCGw/3HI6rIPLaRBpBixp3Q6nA/JyO+OJo1OC3YGIQGAF
	vnHa5icbNCuspbIMAd
X-Received: by 2002:a05:600c:608f:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493d11d21b2mr109853165e9.2.1783330541907;
        Mon, 06 Jul 2026 02:35:41 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:41 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 0/6] Introduce bpf_ksock
Date: Mon,  6 Jul 2026 09:35:19 +0000
Message-Id: <20260706093525.13030-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces bpf_ksock, a set of BPF kfuncs to allow BPF
programs to create UDP sockets and send data. This provides a mechanism
for BPF LSM progs to emit telemetry over UDP independently of userspace.

The main use case is to be able to completely dispense with
agents/daemons for BPF programs after startup. In the case of
Isovalent's Tetragon, the idea would be to be able to emit security
alerts or export data from BPF even when the agent is down. For meta,
according to Liam presentation[^2], this could replace logging via
ringbuffers which created cross-binary versioning issues.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration), for example used by the network bpf_crypto kfuncs.

For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
during his presentation of BpfJailer[^2]. Then it was also discussed
during LSF/MM/BPF 2026 in Zagreb.

A first version of it, called bpf_netpoll was submitted to the mailing
list but eventually NACKED by Jakub Kicinski[^3]. The discussion
eventually reached an agreement that we should use regular kernel
sockets if we want to do network from BPF programs[^4]. This was
fundamentally more complex to implement but here is a first proposition
of how it could look like after several automated reviews using sashiko.

For more details, here are some of the main adjustements I had to make
during the preparation of these patches:

Initially, the goal was to register the ksock_kfunc_set with
BPF_PROG_TYPE_UNSPEC to allow send to be called from any programs. This
introduces significant challenges (but might be doable). The limitation
is still that the programs should be able to sleep but combining this
with bpf workqueue allows to send from virtually anywhere. However, not
by-passing LSM socket hooks make it impossible to be called from the
workqueue context as the credential of the initial caller would not be
preserved. Also, it would be easy for users to shoot themselves in the
foot and attach a program that sends asynchronously over the network on
a network hook. So the idea for now is to restrict the ksock_kfunc_set
(which is acquire, release and send) to SYSCALL and LSM to make it
simpler. Also to make the patch set easier to start with, the sockets
are restricted to UDP.

v0 updates (from local sashiko iterations):
- do not bypass the LSM and thus add send re-enter protection;
- limit the number of socket creation through the kfunc per ns;
- copy the arg values to avoid TOCTOU race since kfunc can sleep;
- prevent calling bpf_ksock_create from workqueue with improper creds.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/
[^3]: https://lore.kernel.org/bpf/20260511182019.69ebc7c6@kernel.org/
[^4]: https://lore.kernel.org/bpf/CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com/

Mahe Tardy (6):
  net: Add __sys_connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Add ksock LSM recursion test
  selftests/bpf: Add ksock net ns quota tests
  selftests/bpf: Add ksock test for async callback guard

 Documentation/admin-guide/sysctl/net.rst      |  12 +
 include/linux/bpf_ksock.h                     |  50 ++
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 516 ++++++++++++++++++
 net/core/sysctl_net_core.c                    |  11 +
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 239 ++++++++
 .../selftests/bpf/prog_tests/ksock_quota.c    | 139 +++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../testing/selftests/bpf/progs/ksock_basic.c |  37 ++
 .../selftests/bpf/progs/ksock_common.h        | 110 ++++
 .../testing/selftests/bpf/progs/ksock_quota.c | 167 ++++++
 .../selftests/bpf/progs/ksock_recursion.c     |  69 +++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 +++
 16 files changed, 1472 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_quota.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_quota.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

--
2.34.1

