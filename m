Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489E37A831;
	Thu,  2 Jul 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020522; cv=none; b=XZ8hE9GE+fxHQRHvy6hcs7nVBCkFPWq3gkPSjLZ/kifNyAXAfegeNiU20KVuYeU49E8fj6/QYN0eA7WPVebnl7hciIEwfGjvNz7pc+I7xNoO/sRkLIAGakpo2KCpnSEXLjACcK8exMNLmXae9pl/2qh1gFAegaKORM7/H4JWJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020522; c=relaxed/simple;
	bh=ZBYMbbcikO3o8DkjVV5xZrgHhG76OW4qLeSlyGNGGJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spFMuvLZJjnMfchQAx6lbdVSDlYBrnkXVJMq3/AiazyLYhBtFchX7yRmsDC0xHz4b2oQ8OR+wj7qGTiAYXPkochyVLTYep2msj461x2k1KNrSGA+XoOi3pH3QYKBJUHm65WDnqGZv5kIuWh4Hekhd8iVO4NZTbx0dUMGuTHTHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BSI71FEr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BSI71FEr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=VV5ifilyYe3Y2EuLX/U3iWS4Zj3m0/qaJG7pGs4/iEQ=; b=BSI71FEra66CBqMTmkux93Opd1
	lI9LY00sFJvd1M3jyBhm+bXKEpdTPA3+IeeE8VB6vevyyI0sHTgkwVHEbt5CP2qJhFV/3Q1qZNvr9
	M5Qb8jzBAPbrRM/KwE16yxizLe6FqYweclgB/iizQn4uhvmoCi3b8RMQoPTrMTQsm2IeNZazb9LTz
	npdkohrxji9tGgtznJAwu0JqqBYIit7emosSdgmzducbzHJLPmuPXF8LX62ehRrLQq6rpUAgRlE3H
	fUrqpwR4hdfhoROFhnU85nMMBogmEx0rPDOHv53yIaTnn/vAqXDhJA6dLWC4oJUvCG7VIkdqmTP0H
	CH/jwzkw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfN5R-000HJT-0A;
	Thu, 02 Jul 2026 21:28:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] BPF fixes for 7.2-rc2
Date: Thu,  2 Jul 2026 21:28:36 +0200
Message-ID: <20260702192836.260994-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28048/Thu Jul  2 08:25:04 2026)

Hi Linus,

The following changes since commit 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-06-25 14:09:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to b72e29e0f7ee329d89f86db8700c8ea99b4a370a:

  bpf: Prefer dirty packs for eBPF allocations (2026-07-01 10:34:41 +0200)

----------------------------------------------------------------
BPF fixes:

- Initialize task local storage before fork bails out to
  free the task (Jann Horn)

- Fix insn_aux_data leak on verifier error path (KaFai Wan)

- Reject BPF inode storage map creation when BPF LSM is
  uninitialized (Matt Bobrowski)

- Mask pseudo pointer values in verifier logs when pointer
  leaks are not allowed (Nuoqi Gui)

- Harden BPF JIT against spraying via IBPB flush (Pawan Gupta)

- Reject a skb-modifying SK_SKB stream parser since the latter
  is only meant to measure the next message (Sechang Lim)

- Fix bpf_refcount_acquire to reject refcounted allocation
  arguments with a non-zero fixed offset (Yiyang Chen)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-sockmap-reject-a-packet-modifying-sk_skb-stream-parser'
      Merge branch 'bpf-reject-offset-refcount-acquire-arguments'
      Merge branch 'bpf-mask-pseudo-pointer-values-in-verifier-logs'

Jann Horn (1):
      bpf,fork: wipe ->bpf_storage before bailouts that access it

KaFai Wan (1):
      bpf: Fix insn_aux_data leak on verifier err_free_env path

Matt Bobrowski (1):
      bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF LSM is uninitialized

Nuoqi Gui (2):
      bpf: Mask pseudo pointer values in verifier logs
      selftests/bpf: Cover pseudo-BTF ksym log masking

Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

Sechang Lim (3):
      selftests/bpf: don't modify the skb in the strparser parser prog
      bpf, sockmap: reject a packet-modifying SK_SKB stream parser
      selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser

Yiyang Chen (2):
      bpf: Reject offset refcount acquire arguments
      selftests/bpf: Cover refcount acquire node offsets

 arch/arm64/net/bpf_jit_comp.c                      |  4 +-
 arch/loongarch/net/bpf_jit.c                       |  5 +-
 arch/powerpc/net/bpf_jit_comp.c                    |  4 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  2 +-
 arch/riscv/net/bpf_jit_core.c                      |  3 +-
 arch/x86/include/asm/nospec-branch.h               |  4 ++
 arch/x86/kernel/cpu/bugs.c                         | 50 ++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                        |  5 +-
 include/linux/bpf_lsm.h                            |  4 ++
 include/linux/filter.h                             | 15 ++++-
 kernel/bpf/bpf_inode_storage.c                     |  9 +++
 kernel/bpf/core.c                                  | 68 ++++++++++++++++++++--
 kernel/bpf/disasm.c                                |  5 +-
 kernel/bpf/dispatcher.c                            |  2 +-
 kernel/bpf/verifier.c                              | 34 +++++++----
 kernel/fork.c                                      |  9 +--
 net/core/sock_map.c                                | 20 +++++++
 security/bpf/hooks.c                               |  3 +
 .../selftests/bpf/prog_tests/sockmap_strp.c        | 31 ++++++++++
 .../selftests/bpf/progs/refcounted_kptr_fail.c     | 34 +++++++++++
 .../selftests/bpf/progs/sockmap_parse_prog.c       | 22 -------
 .../selftests/bpf/progs/test_sockmap_strp.c        |  7 +++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 19 ++++++
 23 files changed, 297 insertions(+), 62 deletions(-)
