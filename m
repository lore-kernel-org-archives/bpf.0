Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83E315D32
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790386958; cv=none; b=Zj8jsw+DBK/gFoa2HKSsii9ZzuUjpuzi3toF8xchlewvtjEQZurn3mbEjDaEIzxxcHkMTKqb1hiTpsLo4AigA0BZ13G7NGRZbynmH/kAtnk9BelmWFDgZIB4Ao0VSc/dfG+DtBNuO/vJCsDPtlcecayPmWZYyEgc8Rfg6zIHJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790386958; c=relaxed/simple;
	bh=YC6k0eAkYSE7TCDAFqTsDR80ifW/39104cYmWfNMXl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1vkunYR/4qmiIVgnHfDHrIWV4kZDEn60lCO0YjnP+SgSwWgQwI/fp2K2v00B7+0+6xjd6m00omTJM8N6Ty3UIDeH6I0yoQnThjuW5K4+AYoxv/eo0mefxJuNWustKOVKlbO136U5bPg6xZZ6nfkFuAdYNrHrOHb/sqE4eNJXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=fPZS8iK6; arc=none smtp.client-ip=198.177.127.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="fPZS8iK6"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hs9Kv0RfVz2x99;
	Sat, 26 Sep 2026 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790386933;
	bh=bbeUBDwwbUrS6TbwxO3Wdv670FztXfj1Wqa7IP4nAiw=;
	h=From:To:Cc:Subject:Date:From;
	b=fPZS8iK6S/PaoIvLHz8EiAQ1y1JXZB5Hs/K8/9NLq5uWOri5xvOO0mibJuw4Tni6T
	 vG/pvoY88nvZnxU6inmMtKg1xXVEsx+1zqXqy3S8VFvvlMUXf0IvGnuN0WS+8ILYrg
	 bUB2j+wipOytuWQNTTCupuMhb4OhDa4r57KWvAHHnZTkwWdfEXo4skK+eAkwNdad5P
	 aLjHi8TvvrLiLwhZp6VCpDzrPSY7ZjXnnqgIUPMdkNJyGysI9ZRRQKpahQyC69l+82
	 N/y57lbrO2zc1vckc8+/k5j3a95GyGNNG5Vd4IxsR/EvZpua+fh1RE5U7quOm6cHvR
	 hrcW8VWwv5AqQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	skokovmaksimevg@gmail.com
Subject: [PATCH bpf-next v9 0/2] bpftool: Add recursive map dumping
Date: Sat, 26 Sep 2026 10:42:06 +0900
Message-ID: <20260926014208.24773-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Add an opt-in recursive keyword to dump selected maps followed by their
referenced inner maps.

This version is based on current bpf-next plus Maxim Skokov's v2 patch 1/2,
"bpftool: Fail map dump for maps that can't be iterated":
https://lore.kernel.org/r/20260925162031.27259-2-skokovmaksimevg@gmail.com
That patch is a prerequisite, not part of this series. Keep its early
iteration check before recursive plain/BTF output, and retain its error
reporting. I will handle rebasing this series if the prerequisite changes.

Changes in v9:
- Clear map info and reset its length before each query in all three
  do_dump() loops, preventing BTF metadata from leaking between maps.
- Add mixed BTF/non-BTF root and inner-map tests, with different key/value
  sizes, checking complete JSON and plain output.
- Drop the unnecessary OPTIONS rewrap, as Quentin requested.
- Rebase and resolve the overlap with Maxim's patch as described above.

Validation in an x86-64 VM:
- Both new regression cases fail with v8 and pass with v9.
- All 15 bpftool_map_dump subtests pass on the combined tree.
- Non-iterable ringbuf dumps fail with valid error JSON both with and
  without recursion. The bpftool type-sync and shell syntax checks pass.

v8: https://lore.kernel.org/r/20260925174402.2028649-1-hi@tychen.cc
Review: https://lore.kernel.org/r/43549d30-0f47-46a2-a60f-fb6f252e6738@kernel.org
BTF finding: https://lore.kernel.org/r/06229dde91361ba3f8d3c8d5ab0350f4a66643eb72b0c3554b1c146fe8523eac@mail.kernel.org

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  12 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 148 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 602 ++++++++++++++++++
 4 files changed, 752 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: b9f30c763c7ecec41fd3f71b8a5a44971c3fddbf
prerequisite-patch-id: 638622a02f200337c410f2078d38d5cfb9f08404
-- 
2.55.0


