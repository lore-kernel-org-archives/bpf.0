Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D4175A99
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744991; cv=none; b=mcfiqLAxjvzXHGN0QOLznvxdoVv/L7aybhHhuyNQVb4Z9eSekIeNg2ONA1Y3v3nOa3CN1ibBS0OrGRmYi3qpoawteI2HhfL8eXJyqbrqDmC74tdCSezAvYLRWQdxskQNsQjvmEjyIm+0e6F6Y7Hn5G74fwJIxoHygc1bNXVy73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744991; c=relaxed/simple;
	bh=niXznIYx7Ts92aVYTcheGCjl6YW3uqQ3GqUpecuO1p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRc5ASQTiJbWVd9G40gHpSlJ+hcjIDmgJEuZF0RX6JtlmAuNvveNDZoxtOpb47iqan2LVqQXPnhAHwQtb2mXnOonPYnYwuHuCreZ3TDtYDXeRak6ZDPuMv5NUcT7NDu3vuET/Zaa1KwFs8WaztRCdltIulpc8Dq3g1BoVYaLITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZ8GD0eW; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZ8GD0eW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=niXznIYx7Ts92aVYTcheGCjl6YW3uqQ3GqUpecuO1p4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786744986; v=1; x=1787349786;
 b=lZ8GD0eWM65GKwpi+M9URnHOehQF0K/N5pqJqmGE40HIM6HJpQTDjD38/FmUrbNYn3d0wqeN
 7LA7sBdcJJEGk73KDuvCnXZWNLqw1ChpPzdAl/PNlr7RiI9JADTJUFY2HTcySDmDnZjvfP4LaFW
 bVi3lhZ6gVtQH7tU3O/rmjsI=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id be81eacd4c78865e;
	Fri, 14 Aug 2026 22:03:06 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v3 0/2] bpf, x86: fix per-CPU address resolution into an extended register
Date: Fri, 14 Aug 2026 15:02:52 -0700
Message-ID: <20260814220254.3797467-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JIT resolves a per-CPU address with

  add <dst>, gs:[this_cpu_off]

but builds the REX prefix with add_1mod(), which sets REX.B. The
destination is encoded in ModRM.reg, which REX.R extends, and the memory
operand is disp32 with no base, so REX.B does nothing and the high
register bit is dropped. Every extended destination therefore resolves
into whichever register shares the low three bits:

  R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI

The address is left unadjusted and an unrelated register is clobbered.
Patch 1 switches to add_2mod() so the bit goes through REX.R.

Clang reloads the address into R1 before each per-CPU access, so the
destination is never an extended register and the bug has been dormant
since v6.10. GCC keeps several per-CPU addresses live at once, which is
how it turned up: test_progs-bpf_gcc panics the kernel in
global_percpu_data/init, with the address of a .percpu variable in R5.

Patch 2 covers every register. A functional test only catches this if
the address happens to land in an extended register, so the test matches
the JITed add instead.

Changes in v3:
- Fold the five per-register programs into one that loads every
  register, and drop the comment explaining the register choice
  (Eduard Zingerman).
- Move the percpu_data declaration inside the arch guard, so other
  targets no longer carry a .percpu section and an unused map (bpf-ci).
- Match the movabsq of each address as well as the add, so the matchers
  stay on consecutive lines and the pair is checked to use the same
  register.
- Restore the Reviewed-by on patch 1, dropped by mistake in v2.

Changes in v2:
- Add the selftest, patch 2/2 (Eduard Zingerman). It uses __jited()
  rather than __xlated(): the xlated stream is identical for every
  register, and the wrong prefix is only visible in the native encoding.
- No functional change to patch 1.

Vineet Gupta (2):
  bpf, x86: Fix per-CPU address resolution into an extended register
  selftests/bpf: Check per-CPU address resolution per register

 arch/x86/net/bpf_jit_comp.c                   |  2 +-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_percpu_addr.c          | 72 +++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c

-- 
2.53.0-Meta

