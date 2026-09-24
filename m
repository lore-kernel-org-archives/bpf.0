Received: from out-2uec-a118.jellyfish.systems (out-2uec-a118.jellyfish.systems [63.250.43.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2741687A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267981; cv=none; b=JtemtZ6uBqnn8gsd0Y1AEX5VHaaELyc1ZeBOkpwyZVVmdlSSfcvZMHB2zx1bHp62oKlhM8dvnHI1z/PE1FKTYKFZvj0lQyneXgB1NPEy8kR5BqCfCMggttNkkoeTtKsJOO9JIdvXaDgaetTxuPV8DYnJFvr0EIUGNFEvsNQFhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267981; c=relaxed/simple;
	bh=Qe6OA/LWjgBIz8Giyf4YJxgqSxEsVSlc+OR06FRvrE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Br6nhtDUiJCSXsF1M+mVgSYA+tRjxPOfnayP5S1pEIPquvdhZcEfzk09uVuH3/AJq2148gU2EGJtHRvYX23BnQXrzD5bBIldkEq2XYKgbJbB4J125Up/PjGu1qCOlSHWAie3cKFpxHRfo9UfWfTMnQhfEH3JVBKu8Il0RLpH3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=eEU1g3pI; arc=none smtp.client-ip=63.250.43.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="eEU1g3pI"
Received: from fedora (unknown [124.160.34.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrKD540xhz2x9D;
	Thu, 24 Sep 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790267655;
	bh=lRIiHsqES3nM7tYm2VVM6tRWbX+5s++vO/ZF7s0Auf8=;
	h=From:To:Cc:Subject:Date:From;
	b=eEU1g3pI/uDPhRrPN+Ej8kyXfe7LnwXmUm1ZtJN0aQFXW6ZPgKt6IH88HSkFclnYN
	 eEIJ1Mx3VeE9IZWwCcDc0naBf8yc525a8ZiqcEJa6skSa2EYegv32dziGyGoFhpSwZ
	 nExRl1BGcV1uHT/xUVZTeHErn8vnJnjSH1P0WJrhwUMIjSyD+k97hVHqG2eiDja5au
	 HXe8S0ejsoQb8VsS+VqAlYKr5Hms+uAXOz0J2hBjGxc/HMlyogDZZvwYX7aevyGrmG
	 AV3uBSicThQLlLYYu46ISCampmJUDBpA7JMyryC24upEUT8EfHxFaAeb+kw/baxvU/
	 z9y1uCW9Q7eVg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpftool: Batch bounded hash map dumps
Date: Fri, 25 Sep 2026 01:34:01 +0900
Message-ID: <20260924163403.203491-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use lookup batches for ordinary hash maps whose maximum key/value
storage fits within 4 MiB, preserving output and conservative fallback.

Changes in v5, addressing Quentin's review:
- Rebase onto current bpf-next and preserve the updated per-CPU printing
  interfaces. Eligibility, batching and fallback logic are unchanged.
- Replace the old performance paragraph in patch 1 with fresh matched-base
  measurements redirecting stdout to /dev/null. Median elapsed time falls
  by 37.7% for plain output and 41.2% for JSON in this fixture; separately
  measured BPF syscall counts remain 200,004 versus 395.
- The selftest patch is unchanged.

Validation:
- Built baseline and patched bpftool from the same base with GCC 16.2.1.
- All 11 bpftool_map_batch subtests pass in an x86-64 KVM guest.
- The 100,000-entry fixture produces byte-identical baseline/patched JSON.
  Plain and JSON per-CPU fallback output also matches the baseline.
- bpftool synchronization and diff checks pass.

The performance test uses Linux 7.2.5, 4-byte keys/values, one pinned vCPU,
two warm-ups and 15 alternating untraced runs per binary and output mode.
Patch 1 includes timings and methodology. This rerun uses a different
base and guest environment from the old measurement, so the change in
speedup is not attributed solely to output redirection.

v4: https://lore.kernel.org/r/20260911034732.219752-1-diannaaav@gmail.com
Review: https://lore.kernel.org/r/141264c9-2d05-4c05-a76a-306818e854ba@kernel.org

Tianyi Chen (2):
  bpftool: Use batch lookups for bounded hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 117 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 187 ++++++++++++++++++
 2 files changed, 296 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c


base-commit: 0e4cf80d0d4893d8227ba816d0559ab778af8125
-- 
2.55.0

