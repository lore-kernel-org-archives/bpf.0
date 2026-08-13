Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E4F40F741
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619161; cv=none; b=MkMJd0Gk1CxqlFkufXqDkEqn1Mxm1Nza5Q/7QQkJXR/gLFTJLgfeONRVB7kJWJFLzvvxrnRu+xHmlUdqR8NqMndwHBDpk5ctyCWWM+ujKpZvYy/e5HGrQHvpnSSw+TmzS1lYpH/UIR4ZwGXmZ2BZ4vhUjjna9cWj3u4opdWX8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619161; c=relaxed/simple;
	bh=1F+iT6VAmEd1niuAQA0ajpelPDcE2icXUsoZXuCC/hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPjXPIVSvgW3rXXxmJMsJEg5BNEMRLLAWxjqH9gJNgzzPjzYioiQRbFD1aihlNwK99ymyn/pvc/cVeSttrab93wCNVm2ZWHVWSmGAiJwOXCBiF0qfQMk+7EINmrcZfmUKfou847kYOnOG9iH2hSqJQCJHxjEg/riAPiFhCzfXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2wStxVk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2wStxVk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so7061225e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619156; x=1787223956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LyiUlUR6mRwMHfl2YtESa+rxw376zaVRZJsbH/Tj4Dk=;
        b=d2wStxVkcqaI+DJNKZkseOkCGbdrGtZ2DYSqivVwViihQjPI4WPC0Jzh6EhF3ZDJ7I
         deVuaIey8mgOTcojGZnmZAfBHZLeZmcXE3/iGokK+/mfV2wu8vviT8iTAewqljf3fmFj
         O82eyCPUJdv+8uyXq+JaCNB131rCjEHN9+UR5ASkpXH/VF38ySPC7oJXDITndeqILWds
         4WUV3YJGO1EIj3RbmGeJrt5NnMTf2hBivdJfwNoJFw1rFCjUaPzt0jc3btQCHBDnaU+6
         uZFt0heI+06JFAgaKDLp0nxAyF0OVuUnPhCSc3xd5Tpw1MG4kkjAfZFv70nWhDqTt8a2
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619156; x=1787223956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyiUlUR6mRwMHfl2YtESa+rxw376zaVRZJsbH/Tj4Dk=;
        b=q7z4MLDSig6hR4u/EkpNKCcraBux5dl9m3ekeYA3+xijl6AUC0QhzfVw+lFmrfG3MS
         ViAbeGceA4qIOcCYmq0N2fKB/aKNOpfU74t3CsTjw/QnXxOoXtaVn29XsXYJSHiM98P3
         SDQfXLjJfjq1claF7zdjyefxxQODqSOepNMnu5h3lIS92j9jNAsPHyzaXSErhOaNQ+hu
         UvR3mFA+lI4fCmKlIaixuTAZsDjGhVx4FUPMm6rRItBASlj8470XQyKtmpxxbN2AtnvJ
         QSRMwlL0S43bcWmdVeOdNm5vdmlS/YmKwQrrOJt0enr9GM4revtwAHW2kF9Ca8nCxdoj
         PwvQ==
X-Gm-Message-State: AOJu0Yzh4UZ9+96kP6u0i3zViADeIE1AUNLhPJfTBKfX9sXoUDFIIVh4
	uAbWqBsbzlEGNR4HKhxNu6cB1hSw+k6Dy4i8pUQtnN+vrWuhDYdPnnMUxAFellVbAnBHFw==
X-Gm-Gg: AR+sD105IlOc1U/dwMwHmUBWH0XtGKzA12Xz7zNsQIGIZ7aHWxX2/FouyjxSao3hmJn
	EN8rJ4bb+vRRphPipGv+5bmvL4e+KEHVa7bPHY5HhrJnZp9PdSOdgjk5YnLDnwDojKtwFyI65xv
	UgugMdeCiNOwF6WGUe+FDJUEzdUZ986Els65xEL6Kp8TPuNJALQQ2vpoLxDTrtsdV+FFy1cRaZt
	yaLBiMG+2fKRY9vfWajJR0tI4y1PtsZ3mUSgvdbExTjjR1BFbmCbqVk5DQSQQiTi8ST5DeXMtgW
	CPqxa1ey9hbuqQ0yzsyhMJNJwYm5F29noogJWZkqZgM1GwrwcKVi6TqT4Oyq4HAlxmn07JZ9YKl
	iLXVPJlkWMKPWwkHhcyEbIRUqqpz6MGURgzac0dS95ZXPbjSe5TE2RPrD7x7mfCiLLE72QUfWce
	8RZQYsgAWboRhzJfSKoGCuk8v6BkFkF6tTeYKF90nk5ITetzpQfhx9Eg81UmAzRjg9GoQ0b/7Dg
	+y+ea6jjwL53GJzvm3XorW0yDmnuVyjwg==
X-Received: by 2002:a05:600c:314f:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-499821fafebmr47982155e9.1.1786619155300;
        Thu, 13 Aug 2026 04:05:55 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:05:54 -0700 (PDT)
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
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 0/5] Introduce bpf_ksock
Date: Thu, 13 Aug 2026 11:05:35 +0000
Message-Id: <20260813110540.103550-1-mahe.tardy@gmail.com>
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

v7 updates:
- remove early size check in bpf_ksock_send() (bot+bpf-ci)
- cleanup some CONFIG_INET and CONFIG_IPV6 guards (bot+bpf-ci)
- clarify some commits changelog (bot+bpf-ci)
- reuse network_helpers.h functions in tests (bot+bpf-ci)
- add bounded iterations in test_ksock_wq() (bot+bpf-ci)
- add Song's acked-by.

v6 updates:
- add Stanislav, Jiayuan and Kuniyuki acked-by and reviewed-by tags.
- reformat some weird indents and nits (Kuniyuki)
- remove unused import in ksock_lsm_verifier.c (bot+bpf-ci)

v5 updates:
- add Song Liu ack on first patch (Song)
- guard BTF ID of bpf_lsm_socket_sendmsg on CONFIG_BPF_LSM (Jiayuan)
- fix checkpatch warnings on style (Jiayuan)
- encapsulate RCU dance in new ksock_ctx_get() selftest helper (Jiayuan)

v4 updates:
- drop the __sys_ prefix on connect_socket() (Song)
- replace recursion protection with a verifier filter on calling
  bpf_ksock_send() on a program attached to the security_socket_sendmsg()
  LSM hook (Song)

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

Link to v6: https://lore.kernel.org/bpf/20260812154328.72834-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  net: Add connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
  selftests/bpf: Add ksock test for async callback guard

 include/linux/bpf_ksock.h                     |  36 ++
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 328 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 130 +++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  45 +++
 .../selftests/bpf/progs/ksock_common.h        |  78 +++++
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  72 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  35 ++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 ++++
 12 files changed, 812 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

--
2.34.1

