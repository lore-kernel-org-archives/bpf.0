Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B043CA49A
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358776; cv=none; b=t6J1P1mH+q06DKZiTIPww6lEhG0MCt510g2TTcX2SLU8JRTdLMYeoQw4QOewRLgXw+srGaevV3HTSS3g9oWT6TG2nWC5Q1oUPaU0XfLg/OStD1iVF04IKUJXIc7rMHLrufvDxTHlccL/liPJHdKGHf+hZVf1NZHQg0fe9GdA3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358776; c=relaxed/simple;
	bh=OiUCqT9TfuS8sreN0O+0sD986/voez8T53VFEIBTYr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cS2Nm+kqM+AdMCKcDXKra70vq3wKBdFHv5IE/ynf47rXP/yOE3AunvzdGyZywYn/HN6MIIJWI6+ngO0zSBmcfXYjq9TAp3a0zFaibgvEJkJv8x0iQjoTbGeLHbcA0i6bXphyFiMKWhzgy84XNBttxXbK0gbsRCNCizCaHoNgwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oBfdJJmc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oBfdJJmc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=COCv4vGVKRZG9G21zdUQEx2aG6RpI5rbhrsohRYPjGo=; b=oBfdJJmcBHoNizm9dvcNRyIG2d
	JxIioeBAEmiD/2sJficpM6EO7ygQ2iKfQXfXRioJCb0oAJLjg2qkh5EZMfKgt3RSA+iw96899qOAx
	Mfu2v1vFKhiQpr7hil0civkzJecVWaveZzHnOJLuLlgJ3nLKFkqh8VVFx8DN8LV5NdUdmdfrG3xxx
	itFh+yxCb/RNdR+8NlZEi2os84Q2zekr9fIbv3CBsVymEAiYwY/XbWR4MyCRtB4qv+Eby+wL4+AH+
	6tv9lHkuSsKOnF1nZJci9r32kx63Y2RXEO6SnmKRbcTIP5j4aEvqKyfCpHrO0/w03YtZrD2tFkbA8
	S00FTJ2w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6G-000Jj5-2M;
	Fri, 25 Sep 2026 19:52:44 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 00/16] Misc BPF gotox fixes
Date: Fri, 25 Sep 2026 19:52:27 +0200
Message-ID: <20260925175244.1136329-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Address various open issues around gotox instruction, see individual
commits for details. Also BPF selftests are added to assert that these
are addressed.

v2 -> v3:
  - Rebased onto bpf-next given indirect call series landed
  - Split out the exit_idx sentinel as its own fix (Eduard)
  - Return early from visit_gotox_insn() on a revisited gotox (Eduard)
  - Check both ends of the target slice in check_indirect_jump() (Eduard)
  - Rewrite edge limit and nop target tests in inline asm (Eduard)
  - Name the patch modes BPF_PATCH_{KEEP,MOVE}_TARGET (Eduard)
  - Drop the insn array stale reuse test (Eduard)
  - Clear the insn array used flag with release semantics (sashiko)
  - Add fix for the exception callback index after dead subprog removal
  - Free the jump tables of removed subprogs and on a failed table build
  - Shift the poke descriptors along with the insn array slots
v1 -> v2:
  - Remove jt_spans_subprogs and reject right away (Eduard)
  - Rework jump table to no longer keep it in insn_aux_data (Eduard)
  - Fix up comments in bpf_compute_scc (Eduard)
  - Fix up commit message nit wrt signed_loader (Anton)
  - Added 3 more fixes related to gotox along with BPF selftests

Daniel Borkmann (16):
  bpf: Avoid quadratic successor rescan in bpf_compute_scc
  bpf: Bound the number of indirect jump edges in a program
  bpf: Rebase the exception callback subprog when dead subprogs are removed
  bpf: Leave out the hidden exit edge of a subprogram without an exit
  bpf: Cache the jump table of a subprogram during CFG discovery
  bpf: Reject indirect jumps that leave their subprogram
  bpf: Don't remove indirect jump targets in the nop removal pass
  bpf: Clear insn array jitted pointers on map reuse
  bpf: Clear the insn array used flag with release semantics
  bpf: Retarget indirect jump targets across prologue prepends
  selftests/bpf: Add tests for the indirect jump edge limit
  selftests/bpf: Add a test for a tail call in a subprogram without an exit
  selftests/bpf: Add tests for indirect jumps across subprograms
  selftests/bpf: Add a test for gotox nop targets
  selftests/bpf: Add tests for gotox targets across prologue prepends
  selftests/bpf: Add a test for an exception callback behind a dead subprog

 include/linux/bpf.h                           |   2 +-
 include/linux/bpf_verifier.h                  |  12 +-
 kernel/bpf/bpf_insn_array.c                   |  19 +-
 kernel/bpf/cfg.c                              | 241 ++++---
 kernel/bpf/fixups.c                           |  92 ++-
 kernel/bpf/liveness.c                         |  26 +-
 kernel/bpf/verifier.c                         |  37 +-
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 650 +++++++++++++++++-
 .../selftests/bpf/prog_tests/exceptions.c     |   7 +
 .../bpf/progs/exceptions_dead_subprog.c       |  40 ++
 .../selftests/bpf/progs/verifier_cfg.c        |  38 +
 .../selftests/bpf/progs/verifier_gotox.c      | 125 +++-
 12 files changed, 1115 insertions(+), 174 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c

-- 
2.43.0

