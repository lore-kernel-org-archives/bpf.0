Received: from out-zbxj-a74.jellyfish.systems (out-zbxj-a74.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C593B058E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358279; cv=none; b=drNLgn2CDC3J8DDAwf/Us6zd51mOjYWR/J6nNKUrYs8SksTNy0sTIvVdHeTV17riFRRIiR98uG3kTaI5YKs9yjfhGRJQ0IQgstbu/EcgRBPz5XaEmWytWmb3w+/6Ksta4Q1FIu1Ufr4knerX2SMtMyS6zv0S4yZ/OpWiOnUczv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358279; c=relaxed/simple;
	bh=KVAj4k93ORW6RC+ldpHWs55tRybLbBsjm8AW9LxDxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0BVtiw9H3fV2D2p35oxdgSZ9okCkBIVGT7btF7Kk5D0vWM35lvWsBZSqJBxaYcDAupvPg0zxZSAIuJxWyfIX4kVJHkyzdvWuLWp19e58f9UXnU2nkAgIP1EKXKuZj4/BMxWdNf7XD3iOt1/UyAHnTrP/5Hlqh+mWDIMtlpEef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=L4XhUQY3; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="L4XhUQY3"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrykS584Yz2xFV;
	Fri, 25 Sep 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790358258;
	bh=BUtiPNuDGd0KorPsBmHSC/1rXyjnCvBAtMuJ1rgqdCo=;
	h=From:To:Cc:Subject:Date:From;
	b=L4XhUQY393TMI7zo4z7p6WqpqCXkjF2+YTORi8ppW+D8bRNhDwe6cJmQALhZLHwiA
	 MZDcYgHavryQLoydK1NKf00RySUmeVNzef6N9StHz0VnFf+H1uq2FVUsquvxPQAzFJ
	 0rvGPLA6P++VYcsnQ37r8o79jlG0As7rrH9bhdNzSFgjHDg6QaBOfEizobWrlyb07v
	 bvb8oUgvukrZ4MylDjhcdqk70FLEDRDH0ZCgklMSh/Kv89gu7mGZ/H4xbaqWAnCFJP
	 5FK/nbLBUyQMAohCl9kwGN2VtA2oMRZMB9R3BJW1SdvEMgS2GoG89s31rS2wWw9Mkh
	 5ZN2+3/zgLdDA==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 0/2] bpftool: Batch hash map dumps with bounded buffers
Date: Sat, 26 Sep 2026 02:44:10 +0900
Message-ID: <20260925174412.2028749-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use lookup batches for ordinary hash maps while preserving output and
bounding the combined key/value batch buffers to 4 MiB.

Changes in v6, addressing Quentin's review:
- Extract a positive eligibility predicate and document the u32 HASH
  bucket cursor. Keep ordinary HASH as the initial supported type.
- Limit buffer growth rather than the map's maximum capacity. On ENOSPC
  at the buffer cap, continue individual lookups from the last emitted key
  instead of restarting from NULL. Keep existing non-atomic traversal
  semantics and initial unsupported-operation fallback.
- Add a sparse-map test with a maximum capacity above the buffer budget.
- Rebase and refresh the performance measurements in patch 1.

Validation in an x86-64 VM:
- All 12 bpftool_map_batch subtests pass.
- Normal HASH, large sparse HASH and LRU_HASH fallback output matches the
  baseline in plain and JSON modes.
- Injected ENOSPC before and after output, including growth to the actual
  4 MiB buffer cap: complete output matches the baseline without missing
  or repeated entries. Initial unsupported-operation fallback also passes.
- Injected EFAULT/EIO and late EINVAL remain fatal and leave valid partial
  JSON, without processing invalid output buffers.
- Matched-base /dev/null measurements show median elapsed-time reductions
  of 37.2% (plain) and 40.7% (JSON); BPF syscalls remain 200,004 versus 395.

v5: https://lore.kernel.org/r/20260924163403.203491-1-hi@tychen.cc
Review: https://lore.kernel.org/r/d5a5b5e7-4063-4511-acdc-46b2407565a7@kernel.org

Tianyi Chen (2):
  bpftool: Use batch lookups for hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 123 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 191 ++++++++++++++++++
 2 files changed, 306 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c


base-commit: 7af653d4ebf8e2e17e288715cd67ccf7845f4631
-- 
2.55.0

