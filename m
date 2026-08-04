Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90531813A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862056; cv=none; b=dQXrR5oLoq2/QVCK9v5hlvnJsW71G/9bGawUN6dyQwlv1jRdnn54gENiVHtUPoVbXiNDejTUP10tSKUJjzH6qyMHa8k/KUuK3YfrJpecPQnk+jze4/ZZXnPGekxsqU/vHnFRIFHeUgSP7Ioqy242w/IRb1aoUFnLfX1/PaWdfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862056; c=relaxed/simple;
	bh=eek9IG+Bai7GTcqw2chitHR1uDwx5tASOpnUG0Wl0ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DlP/Z0rFoCQZkhaHn+Lb4/nW0RmDfRmdzIOm9Q3KKakv2vfKd4Cp10KTcFzist1kxFoAFhpwRT6aKKLCDylWYs+Cff2lrAGSzybngRQ/B8qD9RGi8t98VYVwj2sYZRyW7454QRu7kz9KpW33D2ZiGaCDzmjaPPe3/jTanxkBoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JznapSvR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JznapSvR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so1062025e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862026; x=1786466826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gObdtMIk+etzcDrMNS37rCpHYdRlnIlpC3JIoWVru4g=;
        b=JznapSvR6VlsShWcuUOoFj9LbJcz8aS9uA5UUyPRklWJXRUdorkuAQCrAfbbekxKcs
         J8PGtWpd4LWu2R8BBw47CVPqhZEgVe3XgZs0iqFpv3cjF+aEQtkf8QOW6OgCPdrik/y/
         OAOEH5GUWKSspCB4/P4hipgRlzMn4OO5Pc+03wKW9VRmqXfwCbhg+xF/0OrfTK6bAddJ
         cKTXc4jx003YLx09wpmPKTs29leimyU4Gqc5HiCsMoptQHq+MmHoEEa3a5Gt4StM3piP
         +IftAV1BWBOomiKg3qboVvbSl5+hf+3/JEaK4ZqroDtL9eZkM7mPkapKEYYd1SBC/gR5
         HY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862026; x=1786466826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gObdtMIk+etzcDrMNS37rCpHYdRlnIlpC3JIoWVru4g=;
        b=WUF+OelZM0s+3snHQa1BU81rRNMc96Jo2h5qy280dZrA4OwSZvM6ioo+RKSnMI9FTT
         q15O5QZuxllpilvvs6RxWwEMOyVqWEwbhzuUPo8KFor06NqGzGE8QgVN74ifz+uQZexE
         McXb1EyhdpvMYocsHN0UbHPBYEvmE7FCDvWHVsav3dCl2W5+czneFHFB+bGfaGQ67CMG
         dTZRMUV8toH+Mm3H2Q/1KTgkvd4G1rjdiNrLe52R0Zzy0eRMddVBnHh8e+2b3LprnMIN
         xSN4sDRVPrbjFd1IhegOFeJKD3P1CQFEt+bbeinXhOfR2oQjPAKe9Se5yR5xNvI40Sk9
         raEA==
X-Gm-Message-State: AOJu0YzMwVxmlWe3Z14U8Py1AXXXVi1EFcj2O3W03VuVbR7aYuLUG1qV
	v1xi4NKobSf9n2oQz0N9UIsP6dMGhHSsSz5qiBOnYVc7I1sN2kOSe84A8ln5cktfHUI=
X-Gm-Gg: AR+sD10dAxPgZraxAgXXwF3POBKMyJ2qxVluod7S2KrMKm9FcFX0XusRoWflXrpzHeM
	AU2k/+QANn8cczEsuqVV+2s2ejk6FS4cC1iK0d1R5RzqgmHZsyl2Tc4xwv+85Obwfn9bU5+a0VW
	FCD5DSRSuEo2pozFOL8GpshIZZi0d1Vwx/cYYYnyfEwiVIZYKeuIyu9vN8vttsOU/iv/fCouYBg
	o20YM0FsvQb4v8bjuJBxpPTHjvuNICbPa0aL5SOX2UQ43PHtURDdeTywWujOxJymiOJOJpjDZ/y
	5ePq9sdOfxkx+Y9F31uYkvhaLj5A4XpIR3v/vrWnBAX2gWtuPKMyC2jmyoMh6FXaPb121YWVi9S
	mBM9mM5HmXlLozDKB83F2t0Ty2cmBAKY5xy/1LMbW1bVAZ9U74tIKCmIuggEDhYsnXNdlkUbRdO
	RZMTG0tV7bMg8xz+kbYQULW70j0ndyKSEkw4K5cBPTNn6yk0/kanptnl0wYfEbSnYKv8CpIGoWM
	y8x/bi+Ym47uclPoim40KX0d3TcpEz6LQ==
X-Received: by 2002:a05:600c:1649:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4994e349da1mr6494525e9.3.1785862025473;
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
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
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 0/5] Introduce bpf_ksock
Date: Tue,  4 Aug 2026 16:46:47 +0000
Message-Id: <20260804164652.296919-1-mahe.tardy@gmail.com>
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

v3 updates:
Simplifies bpf_ksock_connect arg by using a union (union bpf_ksock_addr)
containing struct sockaddr_in and struct sockaddr_in6 to remove most of
bpf_ksock_parse_addr() code (Stanislav).

Note that I initially tried to put the union inside of struct
bpf_ksock_addr_opts but we ended up with too much struct nesting depth
from bpf, for example when trying to write the ipv4 address:

	addr_opts.addr.sin.sin_addr.s_addr = ipv4_remote;

It resulted in:

	max struct nesting depth exceeded
	R2 pointer type STRUCT bpf_ksock_addr_opts must point to void,
	scalar, or struct with scalar

v2 updates:
This second version simplifies the patch set by removing bind, keeping
connect + send for now (could be replaced per sendto if needed). It also
removes the sysctl limit and the whole hashtable ksock_send guard with a
single bit in task_struct.

- remove bind from the API (Stanislav, Amery, Kuniyuki)
- remove the bpf_ksock_max sysctl limit (Stanislav, Kuniyuki)
- replace ksock_send_guard with a bit in task_struct (Kuniyuki)
- remove unnecessary init struct sockaddr_storage addr = {}; (Kuniyuki)
- remove redundant ASSERT_OK_FD (sashiko)
- fix typos in ksock test patch commit log (bot+bpf-ci)
- fix return statement in kfunc registration (bot+bpf-ci)

v1 updates (from local sashiko iterations):
- do not bypass the LSM and thus add send re-enter protection;
- limit the number of socket creation through the kfunc per ns;
- copy the arg values to avoid TOCTOU race since kfunc can sleep;
- prevent calling bpf_ksock_create from workqueue with improper creds.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/
[^3]: https://lore.kernel.org/bpf/20260511182019.69ebc7c6@kernel.org/
[^4]: https://lore.kernel.org/bpf/CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com/

Link to v2: https://lore.kernel.org/bpf/20260722104454.165911-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  net: Add __sys_connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Add ksock LSM recursion test
  selftests/bpf: Add ksock test for async callback guard

 include/linux/bpf_ksock.h                     |  36 ++
 include/linux/sched.h                         |   4 +
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 329 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 231 ++++++++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../testing/selftests/bpf/progs/ksock_basic.c |  37 ++
 .../selftests/bpf/progs/ksock_common.h        |  99 ++++++
 .../selftests/bpf/progs/ksock_recursion.c     |  69 ++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 ++++
 13 files changed, 927 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

--
2.34.1

