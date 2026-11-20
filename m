Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205394;
	b=sk/XqUrC+psYNdFnJz93pW9Ie+1a8nEDNmelpQmGWvRj7wVfGCBiK+rQQtgBMwEfk0Ii
	 dB5xMlZB4eIAxThMNGxi+7IQ9Z49dcjv/d4m2WuuB/eguSNQtWmqdb0kS45Gx12bu9OKj
	 2roixXC6D1m0jZeCVHs8izejTIwEluwNbc7ul6/ySq5nyE0ARMO38VfftNr0XXjst25As
	 MzZwILfRHZsruyQPHDmGhqbOoDt5VLzGbNWHXEBAADhpbkif3Thnr487Q7pTMj+VIvM42
	 SzJj9XFiIlVeZ2+zCF7kOuAeBAdn44r0vpXKblDDPFtMWFYsKra+/OFZlWyKj+Rk79A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=c35PJTeSYiVsf0pQVCxlayaLjsxVp20LqdRT+1ySae4=;
	b=KnJc4MRUoGm+X1876ai9WuM75r6aCHEK9nF2BdefuMpFsU0MgZz5Q87ja8OlU0Z8Cpm/
	 2lnB6MnVsONZqbqzFhmU0PCozCljT8K1oguCMfqDWQrRN/IgGzVz6lrsvkbDPdexGHM6r
	 XpMAKd+0U0pyBCER4DIsVp9bnP6hANmpuvrWnG8WfbscCr67XJAKzMxq++ArmxklFruBH
	 hRcm4gkOWNmlHMqy6Nofv2nlN2QBvEbmHlpzECXXp5gCCbE/5R2f4xiN51K9IGOFhQL+w
	 6O3nhQs+BK1NcmWFvnyC4d22BON1RGG+n0QCNW1ljo66GIR8CFzzpH+FGqFssYw2FSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vGkqyCIu;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D8606A6E1
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453D8606A6E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vGkqyCIu
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso616952a12.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795205390; x=1795810190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c35PJTeSYiVsf0pQVCxlayaLjsxVp20LqdRT+1ySae4=;
        b=vGkqyCIugVhSpgorlRGUJgneDtdCUMbD4YCTqHDE+WhtwuFvLLQ83XAy//5oQ6/sVw
         urGWZiexa/5Ez8qS3ghoHdMsv3vONELqLwzxCjQ7nDhhBsgS+ohv1pVCuPRfzamQWVSW
         46yZJGCDIaD0YIF8xLJD/0vzWUfh6qsKAnqEtFYdjnjxRw7qPtcUznIddj6AMa70tp7a
         gseaeJMuLW35kS2UXt16qYa0QV25vHrYhv1uTKM5s/msUWzoeYmJx1KXzRuuqWRtRgcC
         M3OFLIsGk+q/OupdmjwaELtcuy0IytALjJKTBX8Mnhtb8H67FjdTGsi2DnCqTIiYLGBC
         XrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205390; x=1795810190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c35PJTeSYiVsf0pQVCxlayaLjsxVp20LqdRT+1ySae4=;
        b=Sez4Wf+PTWWbxtp0iwCyQL0rtZlBUI6cyvag+XxU7xeOHRi/UZKguNx/KYSKUiyYLM
         QPR6hiUDUbN2XCIImhjqZL/Ft7D5ES2QVhy4eapZVyHNMwXvbar6MPBLiB5f+nMJ61Hv
         1bYToPTPNkTHARPQdFCk0dt716go3H6dEZpwT6FM+6WBRbAdmz75Is952a0u0ZLndGAy
         klv2FV2lUDiNeLuk2YTmdPTz7iLkFlvXqb/kwHtlFYofK4mNu4sVsU4HOMbHwyKbDrHA
         KLTaRjaTh8j0YN5wZsEwRrxvH+c23odiW+G4ah/SbkCcpHhH7XwFoXHY4UYmcsEGOtmj
         1Eug==
X-Gm-Message-State: APuU4Z/XKK4CnrYs5l0taHMvQz6CmBjBVp9DLb8xzIdw3qN9xj26yt3N
	8z2Q5WAxWaOIqNwChp+Qx2tmNe/uAtR+gTyciGcrMqCTqjaHEBiRocMM
X-Gm-Gg: AYBFou28UEbbdvoIS4UDumvlYymrqNb1vgh68LPZW2Tri8dut2+vOieB5bWHxZE7+nq
	dirdwx2SgFbigHZuvE5U68h4E8u2oflBDHD30fZMN53iz3EZ1gcaQBnU42dv8cyXp8skYiFd6Mj
	iSW0mtNGE9LmDyVBpI5a1Yk+JYBufD1tpPvMb8vh7T+5AQcsn3DNURfUeFiaf7YQUXXEwoNWwaZ
	Tbc9NsMHgExkduu2NquM51xS1ZeV57v8nk4GBJSq2pzKXkCD3+a3FDvP+ZIEG4/EKnZHmwPTJVo
	KlRCSC0xBUffJ9DVQtfopXzcpTAT4fB/Dg5Mxri+LLmwYdDSjxiF/ZGzE0Y62N5ty9OASsHuwfA
	+l2cqBfazdOIACMojpNft/HNBi0SsBoGdnyLSSZYX/cOgWib49PR6AVW1aEzbYdZbf+tU1QWoBm
	fxo5YX0wczkA7pklLUUkMrk8Bp5QRpY7ibDwDd+x0ehHVVDEYiv3Vx5rIkva9pC51FrX7ykQHQm
	ErjiCvUepAlBvnXZZm0Poykc597oGNJalQc0wJZTBLy6uT2Y++L/T3UZBZJxWvXRBceO8yC/GPL
	85SOlCn6NcE1rQtC3QggOj7eosKSTgE8oSXt/ANNOicQBFbXNH4H+of5rey7DAgw19IwjjIstLL
	FlG6rWVs8YTS0kC5an7onjwMh9jCz/9crbkmF2H70wSxyhR0ImqZ+ErdTS164vImHHXMtVHf0/Q
	==
X-Received: by 2002:a05:6a21:46c5:b0:3fb:4a1e:2f84 with SMTP id adf61e73a8af0-4014d25ed8dmr3443268637.40.1795205390330;
        Fri, 20 Nov 2026 12:09:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6c9c7dcbsm1828322a12.0.2026.11.20.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:09:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [GIT PULL] BPF fixes for 7.4-rc4
Date: Fri, 20 Nov 2026 20:09:48 +0000
Message-ID: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 05441d697f7f9a927264f4058cbbc6a03dfcac9d:

  Merge tag 'cocci-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2026-11-03 08:36:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to d5ba86298b45e1a81c578c499e9a222a3b734d5d:

  Merge branch 'bpf-limit-writable-registers-in-uprobe-context' (2026-11-20 02:31:05 +0000)

There is one trivial conflict with your current tree, in kernel/bpf/bpf_lsm.c,
between commit
  ea8c4b37b880 ("bpf: don't mark namespace_init and namespace_free arguments as trusted")
from vfs tree and commit
  ab86b62012b9 ("bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted")
from bpf. Both add two lines at the same place in untrusted_lsm_hooks.
Keep all four.

That's what Mark reported:
https://lore.kernel.org/linux-next/avsfpHqbu_rdmOrf@sirena.org.uk/

----------------------------------------------------------------
Mostly sockmap fixes that the previous PR promised, plus
uprobe ctx rewrite via bpf and cgroup-bpf fixes.

- Reject writable map iterators on read-only maps
  (Adethya Srinivasan)

- Various sockmap fixes (Alexei Starovoitov):
    - Clear the redirect target before the sk_msg prog runs
    - Check that the redirected message is the cork
    - Leave sk_stream_wait_memory() once the socket is dead
    - Keep the rest of the cork after a redirect
    - Don't let an SK_PASS verdict cover the next message
    - Subtract all dropped bytes from the return value of sendmsg()
    - Clear the end mark of elements added by bpf_msg_push_data() and
      bpf_msg_pop_data()

- Fix ring capacity invariant break in bpf_msg_push_data() (Bo Cao)

- Report RCU-tasks quiescent states in do_check() to fix rcu_tasks
  stalls during a long verification (Breno Leitao)

- Various sockmap fixes (Chris Mason):
    - Give no progs to a TCP listener
    - Check the target of an egress redirect before each send
    - Check the TCP state in recvmsg()
    - Reset the copy position when corking
    - Don't copy 0 bytes into a full cork

- Use a dedicated workqueue for freeing BPF programs to fix a deadlock
  between pack_mutex waiters and the vmalloc purge work
  (Emil Tsalapatis)

- Fix verifier model mismatch on a narrow read of
  __sk_buff.remote_port (Henry Martin)

- Fix bpf-gcc CO-RE relocation in verifier_sockmap_mutate selftest
  (Jiayuan Chen)

- Restrict uprobe ctx writes to the registers that ptrace can set
  (Jiri Olsa)

- Various sockmap fixes (Josef Bacik):
    - Write sg.start when recvmsg() faults
    - Don't let an SK_DROP verdict stick
    - Clear the resume state of a stopped psock

- Various fixes (Michal Luczaj):
    - Fix "unresolved symbol tcp_request_sock" build error with
      CONFIG_INET=n
    - Restrict iter-context sockmap updates to iter/sockmap
    - Restrict bpf_sock_destroy() to iter/{tcp,udp}
    - Mark bpf_iter__sockmap::sk as PTR_TRUSTED

- Mark backing_file_alloc/free LSM hooks as untrusted
  (Sergei Nizovtsev)

- Various cgroup-bpf fixes (Shakeel Butt):
    - Don't read freed effective arrays in BPF_PROG_QUERY
    - Don't attach to a removed cgroup
    - Protect cgroup_bpf state with its own mutex, so that queries
      and the release work don't wait for cgroup_mutex
    - Don't lose errors in effective BPF_LSM_CGROUP queries

- Check variable-offset accesses against special fields
  (Shihuang Liu)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Adethya Srinivasan (2):
      bpf: Reject writable map iterators on read-only maps
      selftests/bpf: Check writable iterator attach to a read-only array

Alexei Starovoitov (12):
      bpf, sockmap: Don't let an SK_PASS verdict cover the next message
      bpf, sockmap: Subtract all dropped bytes from the return value
      net: Leave sk_stream_wait_memory() once the socket is dead
      bpf, sockmap: Clear the redirect target before the sk_msg prog runs
      bpf, sockmap: Check that the redirected message is the cork
      bpf, sockmap: Keep the rest of the cork after a redirect
      bpf, sockmap: Clear the end mark of elements added by push and pop
      Merge branch 'bpf-sockmap-fixes-for-verdicts-redirects-corks-and-recvmsg'
      Merge branch 'reject-writable-map-iterators-on-read-only-maps'
      Merge branch 'bpf-sockmap-restrict-iter-context-sockmap-updates-to-sockmap-iterators'
      Merge branch 'bpf-cgroup-don-t-wait-for-cgroup_mutex-to-read-or-free-cgroup-bpf-state'
      Merge branch 'bpf-limit-writable-registers-in-uprobe-context'

Bo Cao (1):
      bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()

Breno Leitao (1):
      bpf: Report RCU-tasks quiescent states in do_check()

Chris Mason (5):
      bpf, sockmap: Give no progs to a TCP listener
      bpf, sockmap: Check the target of an egress redirect before each send
      bpf, sockmap: Check the TCP state in recvmsg()
      bpf, sockmap: Reset the copy position when corking
      bpf, sockmap: Don't copy 0 bytes into a full cork

Emil Tsalapatis (1):
      bpf: Use dedicated workqueue for freeing BPF programs

Henry Martin (1):
      bpf: Fix verifier model mismatch on __sk_buff.remote_port narrow read

Jiayuan Chen (1):
      selftests/bpf: Fix bpf-gcc CO-RE relocation in verifier_sockmap_mutate

Jiri Olsa (2):
      bpf: Restrict uprobe ctx writes to the registers ptrace can set
      selftests/bpf: Test which ctx registers a uprobe prog can write

Josef Bacik (3):
      bpf, sockmap: Write sg.start when recvmsg() faults
      bpf, sockmap: Don't let an SK_DROP verdict stick
      bpf, sockmap: Clear the resume state of a stopped psock

Michal Luczaj (8):
      selftests/bpf: Remove sockmap update from bpf_iter_unix
      bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
      selftests/bpf: Add negative test for sockmap update from non-sockmap iter
      bpf, docs: Document BPF_ITER_NOSLEEP
      bpf: Restrict bpf_sock_destroy() to iter/{tcp,udp}
      bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED
      selftests/bpf: Add iter/sockmap bpf_sock_destroy() negative test
      bpf: Fix "unresolved symbol tcp_request_sock" build error

Sergei Nizovtsev (1):
      bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted

Shakeel Butt (4):
      bpf, cgroup: Don't read freed effective arrays in BPF_PROG_QUERY
      bpf, cgroup: Don't attach to a removed cgroup
      bpf, cgroup: Protect cgroup_bpf state with its own mutex
      bpf, cgroup: Don't lose errors in effective BPF_LSM_CGROUP queries

Shihuang Liu (1):
      bpf: Check variable-offset accesses against special fields

 Documentation/bpf/bpf_iterators.rst                |  12 +-
 Documentation/bpf/map_sockmap.rst                  |   4 +-
 arch/arm64/kernel/probes/uprobes.c                 |   6 +
 arch/riscv/kernel/probes/uprobes.c                 |   6 +
 arch/x86/kernel/uprobes.c                          |  15 ++
 include/linux/bpf-cgroup-defs.h                    |   1 +
 include/linux/bpf-cgroup.h                         |   3 +
 include/linux/bpf.h                                |   1 +
 include/linux/skmsg.h                              |  19 ++
 include/linux/uprobes.h                            |   5 +
 include/net/tcp.h                                  |   6 +
 kernel/bpf/bpf_lsm.c                               |   2 +
 kernel/bpf/btf.c                                   |   7 +-
 kernel/bpf/cgroup.c                                | 163 ++++++++++++-----
 kernel/bpf/core.c                                  |  20 ++-
 kernel/bpf/local_storage.c                         |   8 +-
 kernel/bpf/map_iter.c                              |  12 +-
 kernel/bpf/trampoline.c                            |   2 +-
 kernel/bpf/verifier.c                              |   7 +-
 kernel/events/uprobes.c                            |   9 +
 kernel/trace/bpf_trace.c                           |  10 +-
 net/core/filter.c                                  |  54 +++---
 net/core/skmsg.c                                   |  13 +-
 net/core/sock_map.c                                |  11 +-
 net/core/stream.c                                  |   6 +-
 net/ipv4/tcp_bpf.c                                 |  93 +++++++++-
 net/mptcp/protocol.c                               |   6 -
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  35 ++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c  |  10 --
 .../selftests/bpf/progs/sock_destroy_prog_fail.c   |  11 ++
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  |  17 +-
 .../bpf/progs/verifier_uprobe_write_ctx.c          | 196 +++++++++++++++++++++
 33 files changed, 652 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c
