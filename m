Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EC28CF4A
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549424; cv=none; b=iawiOEXTz6uRPDa/2rSIj4QPP1Te94ucfWthrT7jAACaKlRoNhVR2JhBcrEtEEjHYyY6l/4qyde6FE6uAlubgo7nMix9LI0FWPtA6gAztPgbfCTLhHTid08Ob1rEaqLyxNPP2ApZZPcGfu//+6Wr4JmEBytGE6fG4HfTkw8W3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549424; c=relaxed/simple;
	bh=09P0LGiDtHUUcrWGphJtI40n+DT1EnOVvX6m3F40QnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YFliDbYUEzovsN6tegnbxZMYRTj0CgEXE7ac+HYppldw/htlgd1RO0eBgGmFm9MiTUFYXOBLdjIX5V+NaMe/osq+i3FRJUg+QEpBMFuA4dte0/wWlc+20YyMfSTEbeu7iAVQ8w15t0+mYVzClPxXxXaI/UvmFZG8w/dIbXj0A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTVfu6Sr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTVfu6Sr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso8268625e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549421; x=1787154221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xx7cbqFAKE5cv//XzL/zgP1yOczElqvVux9r6MtDA4=;
        b=VTVfu6Sr5/FvP4+1EPw51w7UwtU5qKEf8vOc7F6OTU8641oNSQLySSzc/jvtJb47qC
         Az/3fT4ZXhJhyKm4wSwU2TYoCESL2/3DWQxpnmCxLT6RlNzNKkgloRPiNYsxslS3WFTQ
         byyXuK2XlovNV4rB6zs0s5vkpH23qipm8UpDz4ZAaW94WCngFYLS+xHwKOPBf09Y8Gwl
         BFtYg9ZCZp13qPAKih/TK0bfw2GxDRMIyPpUwRI8KAON3mdWUva8MZ/NsczwjGBU5UDk
         iM5Q1omBZ/f7ptP/4e2LABCRm6pWJvg4w/WUyfDE7fnGC0JsYIZdGaS5jTs3GBUuGV0G
         xfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549421; x=1787154221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xx7cbqFAKE5cv//XzL/zgP1yOczElqvVux9r6MtDA4=;
        b=H4SSRCvHq/WHSnQq/luL/o14XKQ1Ez8NaLhPp+5Irye7UADrElZEMCMFXcyVttnOX0
         DRaSCea+4N/g4r7JX80hllWnfd2nW7KrCGadXhY9wBgRcZBap5DDeXt0LfTHaI/wK1PI
         avQdkb7XBuKmGXo/q+EnSFDlEh+4O4YRWNr6kNWxOaAUeQ7HNF2cWMakZHlFn2OAUoRF
         md64ZntwFBvoFIB/xcSu6G9EoxjHVjgEmYgtiOv9J7U/AcCYPLFsKCvbYWk0072rx9bL
         TnC1TT+Xyy9xdG0OVbGfviH2TGc5yC9MVydfGCvI3hvMUjbQ26xb+F0FAh1ADtDDhTGk
         5Lyg==
X-Gm-Message-State: AOJu0Yyhb4g7dTKIUdfMX0WlO4v02qxlYqza2/HQpBH/+yPCA6zqkIMn
	sai/Jj6P7Pr5x38RlXyWRUHBbRCCfqqo2qFkuGOP7JMiIJ+yWdh8HrEWyZXskVqRSE4=
X-Gm-Gg: AR+sD13HEQb1v8F/5ymRzz9HDP57JMJBRtXm6re8FLgkY6sgZg6DL6wMPcSBQhGfH/e
	flW3Y76ztN40BmaELtvdhLHf9I9/XKONRnupFsTwGXWstjzJ8SnJM/G5fgTFjhNqzlrQXkbu/L3
	C3F7wwRQurRGDcbvqi+SUsJojv68nEND8pZ3M5ZTPg0Maf+osL5p07K+ZYLsNMVs3vRCED4JoR5
	CtjJ9YpIb9edBk0mIhkzL4DuNP5Vw3eEb8eajkD++FOkjrraeNmW6Hk/mwhn1a60+y9LiKSNSyj
	EPAjVsulHA+M3215Tqfdtl5SKroPrHZfGbOdfLOEZCEITi8FWS/Vz1dLS0WCu3DixrTqJsbT8cN
	TNEjASvwaZnGGNJZy+Qcpl2AIcVH+xfPIfEKrde8+T1QGJysfEBX0D4UyMlwJDTMkXroe0gx7Zj
	9LBChtIRo8OHFRe+r319OTeHckn+v7mEV7qjNpyuP6+WDPiQgwpVsme0YBp6WfcSFob0/QupHAa
	vFWwU2glZuHyOwHTgiBGqJewSflvrvigW9mHhoi5wel
X-Received: by 2002:a05:600c:a41:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-4997c13be45mr80064395e9.19.1786549420534;
        Wed, 12 Aug 2026 08:43:40 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/5] Introduce bpf_ksock
Date: Wed, 12 Aug 2026 15:43:23 +0000
Message-Id: <20260812154328.72834-1-mahe.tardy@gmail.com>
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

Link to v5: https://lore.kernel.org/bpf/20260807171532.125149-1-mahe.tardy@gmail.com/

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
 net/core/bpf_ksock.c                          | 335 ++++++++++++++++++
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 133 +++++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../selftests/bpf/progs/ksock_common.h        |  78 ++++
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  72 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  |  35 ++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 ++++
 12 files changed, 811 insertions(+), 14 deletions(-)
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

