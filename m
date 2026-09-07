Received: from out-2z4y-a154.jellyfish.systems (out-2z4y-a154.jellyfish.systems [198.54.127.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AA392C27
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747329; cv=none; b=TbO4LY6YRVKSdJQAGkvGFI4uKpXM2cY72amO78zSJoR2a68RSylC1v/vgtWvJfxMnoauuJBHO9jzfoDwhh50KIORLCF/RjTrFxcFpwCdxQFAsbk7gUP8XN19vIiDT6jUSHjr7uyP1Lnw099F/SGJPoSz6YQ/xA1mdxlilD38TNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747329; c=relaxed/simple;
	bh=zUNzo1cXhD8Jt9G07GKDrjOkVF3Czr4zrrLNEtBYM1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyKAvXMge9jMG5ajbXlhOR6oPtbK2mAlNLzI+Iw/phHWXhn+QAYJkuGgjFeMjqq5zI0Yn+Nfrvo8wMGby8YyhlOfyV1sQmOvwk44aZ1MSSnmv0IFFN/PWl+OmKB+eut6nX9L4ymyjhBfJeCUIwEkZFfyiKR4h5WT+mhxyInGYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=ghev7x1L; arc=none smtp.client-ip=198.54.127.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="ghev7x1L"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdVyt55qzz2x9N;
	Mon, 07 Sep 2026 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788747319;
	bh=4t6hilzxJgaQIDPBpyQ3bFz1hIlxephx2X6S4Hufbxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghev7x1LZMw2EvQVRB+NA5nXeBVcUpoePLF48dpGf7DsWsQiRGfDzbIJN1t9rlxIS
	 SCzeGcuRjbYIXXMGCkYZCbnQNjHobIxXsLzjKTnHBcGaomm7wKucUy1sFqrKQ3hPzg
	 ABiZyHRxKuBTM3P9205uPHu+TeclexN73st+TAxoyDxgfxCzhvfNZb/Z4DSkay6kPJ
	 U1CyHK31jik4qcHD49lbh7V3EZIUzzxC41fegtuSfOEDhwPn+9O6ctOfGvkcCYJuhF
	 3a0PlNc2ii2PR4Hpv79EYtdE0LEonpWc13iw/ndRZjNOgpOoKZe6WGnxolw1tmM4oI
	 VUBFpn0EbGtog==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v3 0/2] bpftool: Support symbolic map creation flags
Date: Mon,  7 Sep 2026 10:15:14 +0800
Message-ID: <178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc>
References: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Add comma-separated BPF_F_* names to map create flags while retaining
base-0 numeric input, with matching documentation, completion and tests.

Changes in v3:
- Expose the parser's existing flag table through feature list_builtins
  map_create_flags, and use that command for Bash completion. Update the
  feature help, manual and group completion for the new group.
- Explain that when comma is not a word break, Readline replaces the whole
  word and completion must repeat the already-entered flag prefix.
- Give invalid_combination its own comment: the kernel validates
  combinations of known flags; the preceding all_bits case instead checks
  that unknown numeric bits are passed through to the kernel.

These address the v2 review comments:
https://lore.kernel.org/r/693f57c4fee08005c6e67811a2fbc497e95fbb7373154e9ecdb1f9a76afaba60@mail.kernel.org
https://lore.kernel.org/r/7dbfef853aacc32527a352d59861e86f00b7a1e4634c070e569aed415792b926@mail.kernel.org

Validation of v3:
- Built bpftool and the focused BPF selftest runner with LLVM 20, alongside
  the ring-buffer and batch v2 series and recursive dump v3.
- All 29 bpftool_map_flags subtests passed in an x86-64 KVM guest running
  Linux 7.3.0-rc1, with no skips or failures.
- Plain, JSON and pretty-JSON list_builtins output contains exactly the 19
  names in the parser table. The existing map shorthand still selects
  map_types.
- Real Bash Readline completion checked with default COMP_WORDBREAKS and
  with comma included: first and subsequent flags remain in one argument;
  after an explicit space, entries gets its normal trailing space. The new
  list_builtins group also completes correctly.
- Bash syntax, bpftool synchronization checks, diff checks and feature/map
  manual generation passed.

Changes in v2:
- Complete list elements without adding a trailing space, so the user
  can immediately append another comma-separated flag.

v2: https://lore.kernel.org/r/178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc
v1: https://lore.kernel.org/r/20260906170715.1212085-1-hi@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/57


Tianyi Chen (2):
  bpftool: Accept symbolic map creation flags
  selftests/bpf: Cover symbolic bpftool map creation flags

 .../bpftool/Documentation/bpftool-feature.rst |  10 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |  13 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  22 +++-
 tools/bpf/bpftool/feature.c                   |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       |  85 ++++++++++++++-
 .../bpf/prog_tests/bpftool_map_flags.c        | 100 ++++++++++++++++++
 7 files changed, 225 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c

-- 
2.55.0

