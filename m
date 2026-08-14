Received: from mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D037CD29
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739593; cv=none; b=eFDWXOoeZAaB9fVpFOwvbydZa3evkPjTe52DvH1WAXKDSChMy4D4yU6Oe+zdQzR/TMUxL3CwY//4jUgaPuRefs1Pb9fUHKKL4BJexGEnq1w7Q0Go6om0b8f3nirE2/v7Y0kqnz2PagogbTh0VM7iq25VRaQ4FmMMxIzCYDI4mmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739593; c=relaxed/simple;
	bh=mO1InOiaGljHQswx7iZwf5mR+e8jk6SjbipH4GppmyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfdAgkr/1iVFD96sfcVeI8/FkrTuVH1XCQjyngzSDh+pOw/6cEsM9Vx0D+d7poDGruhYJxg3Nm89DLTwgPJHV5JDwgBNHeAiRB4vJzIegKRnEK3vQ4IBuecUfdyHeEs8Oo9nzPdmETTYIyivcb8vRUMzZohQ9Y7uVwxoyo6Q1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MWEkOChk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MWEkOChk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mO1InOiaGljHQswx7iZwf5mR+e8jk6SjbipH4GppmyQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786739587; v=1; x=1787344387;
 b=MWEkOChkG+fZMlDuq6rqQlV3V6n/7At5W37aMN476pCUpbJXVpNCqjQ7uOyJVgyGBru9cSqX
 nQWnhstfl3TT++Vh2e+99ZltsVR/OAun9BOidLS46TeCwgBcI3iEfSLmX0ISWsQjZDtoXVAKIAR
 2y7KidwKUCfWJwP2iyt1XUpg=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id edd32b9bcd95dd7a;
	Fri, 14 Aug 2026 20:33:06 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v2 0/2] bpf, x86: fix per-CPU address resolution into an extended register
Date: Fri, 14 Aug 2026 13:32:46 -0700
Message-ID: <20260814203248.3714536-1-vineet.gupta@linux.dev>
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

Patch 2 adds a test per register. A functional test only catches this if
the address happens to land in an extended register, so the test matches
the JITed add instead, one __naked program per register.

Changes in v2:
- Add the selftest, patch 2/2 (Eduard Zingerman). It uses __jited()
  rather than __xlated(): the xlated stream is identical for every
  register, and the wrong prefix is only visible in the native encoding.
- No functional change to patch 1.

v1: https://lore.kernel.org/bpf/20260814165557.3405518-1-vineet.gupta@linux.dev/T/#u

Vineet Gupta (2):
  bpf, x86: Fix per-CPU address resolution into an extended register
  selftests/bpf: Check per-CPU address resolution per register

 arch/x86/net/bpf_jit_comp.c                   |   2 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_percpu_addr.c          | 114 ++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c

-- 
2.53.0-Meta

