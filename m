Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6964339393
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717105; cv=none; b=IsDdW71Li+lWW5Ege1rNGp/gziO8svG4sx1YI5hHgLCEgmjJxRZ26CN4IxxGq9j3WuqH9AKTdF3c20VeL0DJ23HVK9bv3lHvbpGG9qYizJtsX/Sp8qo2VSv1X/dSyCA+nw699HJrqJJYcaUcndqWHC/1dwN5B2EBlmW47dIWYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717105; c=relaxed/simple;
	bh=HZiaMkhvaewjh9mMG1WWnzqYnEyxTvbtt2rBL431Sgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzhXJ/oKfCwuRgPNHl9Aw69puetuJvxb/ckwEHfA0uBVeoZLGlhve3f9S16iEhyayi0mwQ6Clyz8jCR4iPUsl5fXiGGzSMude4XerIO1liagBZQs2pQVx3zAzGFzJ6oufgIKKGdg5efjU3jrvG7x8pHLPly6TYu5OWZsvurTKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlPr/m5M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlPr/m5M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47362928f65so11243147f8f.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717102; x=1785321902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bvaobRro/sP8xxVynMtcLAURezBCr8SNVdV02NIAdE=;
        b=WlPr/m5M/yyv06b3fq/CoMMg2pErX1mZg6M0lVJx/YgZn/T9Qe9LBLmy4XLnY3FDwG
         rBWIJwymAvcebBM8WsgPxHEfzs7hPZDvCRnXW7xQ1Z3/AIVGyiYhEgy0JZ30sk1EbKSX
         6C72NeaAHWJmDSUqDfskTl/IA8S0MsGd1/1Tj0HGgRko07+tUm00+asWDTv5Akvx+7Os
         5wiCnpXdgp4VwabDOLJBKpf9k9NGP/A8z0SJDLq4238vlW9pF9QI0LdO0Uu4LJ/QtyQA
         Stkb9IwFLZpx08F2wLdyJbZkxZPTeNDjzG27P/VFg+0+4Efi2Jp0vxPRouTnAgc2r61/
         BRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717102; x=1785321902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bvaobRro/sP8xxVynMtcLAURezBCr8SNVdV02NIAdE=;
        b=K94AVY41BoVFRtoDQPHMkWRkwFk/f6iRjeWPhKadmDePRVsDD+YSXEXo/Ax8/jvUWf
         zaPbhPffbCoKMfMwNL1sR40dhxhnP9/kDgHlCOvLfBh20NkXXmlbI09Sbu7+RSs/TWui
         3s3OAseNeZVpK9Jqmz7iMprHYf4w+qE0fCv2f5Hz8Q8v46IJbDeZyGvbEYVUijh5q7ZO
         LpFxth4XhzFvkFhZ+/jRx085n7A4DoJ+pdmll+QfJ3ykFzvyUzbPDUsgXCTyKOykMhb0
         Jfn54zsqXdhd1hPDUHiMKFbY4Ht1NYz0B0tAWnTE2W74XC/ZYY7KY4MF4kGXTDmL0UkY
         qvRw==
X-Gm-Message-State: AOJu0YwuKynqgfixAkWUSkevrvYpATs2UvZAol2s0XDlnfdNoN8YG8Di
	buH4vjM7fuhlqE9cUDMy+TkDxK2USQ2Virjhzqbi04bDrMsS6rLbgWGUbl7qUooCglI=
X-Gm-Gg: AR+sD115ga+4CKOY15XLrOf0zwjbqfZ0/JDPSq+MekJxn2vD4xmuhn6ako5owCuf2WI
	bx0jSG9DOMZg3UUV7QAVMqnCtLtuLaudKzSWx6BLihS5Ynk2SvJz5FIg/x3B9pDjVYSWBeuJJw0
	IRPNqCvvICpoMrCNZ1UZeEwED+4pCrkTj3QfSTlua59ODWYW10zqX3AssKSIdPax87RZm/WZO2f
	yDzeWJ92lQjzP+c2RF5FnGC1nF63UNaE4pAhqBPtOC9v8qBHCdVIgK/lwGc5jlQrT3HS35AFybA
	xS0A+FSYwr5L+899YjB8zqffSljLqRtv3tgkXcMiieL3h4KYzaQBYFj7T0uOFZq4mZ4pW0KBVjq
	6OUhi7PEz3REcYevPFRwHd1WIcdVQW8rGnrkJZgVTncveTKyYol5K0umZsPEzTVHv+b60rgIsaZ
	wZIw5ZujvVvmZF50abxIuSDSQg2pwN5XnniaqIDJwXwgEHhfU=
X-Received: by 2002:a05:600c:4f44:b0:495:5b02:23a8 with SMTP id 5b1f17b1804b1-4955b022588mr154358575e9.34.1784717101492;
        Wed, 22 Jul 2026 03:45:01 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm111090575e9.8.2026.07.22.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:45:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/5] Introduce bpf_ksock
Date: Wed, 22 Jul 2026 10:44:49 +0000
Message-Id: <20260722104454.165911-1-mahe.tardy@gmail.com>
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

Mahe Tardy (5):
  net: Add __sys_connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Add ksock LSM recursion test
  selftests/bpf: Add ksock test for async callback guard

 include/linux/bpf_ksock.h                     |  46 +++
 include/linux/sched.h                         |   4 +
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 361 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 233 +++++++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../testing/selftests/bpf/progs/ksock_basic.c |  37 ++
 .../selftests/bpf/progs/ksock_common.h        |  99 +++++
 .../selftests/bpf/progs/ksock_recursion.c     |  69 ++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 +++
 13 files changed, 971 insertions(+), 14 deletions(-)
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

