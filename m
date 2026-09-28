Received: from out-2z4y-a153.jellyfish.systems (out-2z4y-a153.jellyfish.systems [198.54.127.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFD3FA5E4
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616347; cv=none; b=P7kbIw7T4+dK5aRPzGU6OtZW+0NBs0u/08g3Zm8vxaCsftS8GL6qRDfT4LAkv0x7WZ1EFFhi8G7hULOe1YQtYxiIhuiOufvP7bY2/ESFeo/LDkF8xtMXhxkDzg1myfDyd9tpH9KL7sZoZpK7nFt1Zw4vEx8hvuKzhx+Kt2tW35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616347; c=relaxed/simple;
	bh=gw9hfRMP5K8RM/53d5o4qZzIGdwYsTgi3pnXv2QXXyo=;
	h=Message-ID:From:Date:Subject:To:Cc; b=SzwWlU/pEOY4/IB8xsE3/96WF6gwXvoTNCRlrAupG6mzrqlR8Ch4n+ahJeDYJlvevvkziXe3Ler8kMZbEu+OLsg/nq1a2MyNwKiQtq/DReHEcVoTmjSlk2aGTBX8Ou6zHj9mOzfOS1NSrxoVRG0lCsa5a58Aq04s00quu+RU7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=pPvB0oaq; arc=none smtp.client-ip=198.54.127.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="pPvB0oaq"
Received: from [172.20.10.14] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4htp3P11wfz6tkK;
	Mon, 28 Sep 2026 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790616019;
	bh=p4jmEPfiL19R0WbLDiO7llxGbAVI26cpPxruli/nSR4=;
	h=From:Date:Subject:To:Cc:From;
	b=pPvB0oaq/na1rUv4XCq+NmEUQbA8gdjeVEPcw78HoyYBlp/CIgrvQ6yMxeFtmsrmh
	 UFaa7vupnKur7739UPa0RAVtElNzsUgCetr3yW1Z983peeR2+fBHTnmMgG+PXPyHq1
	 vR61in9b/j93Kxrap2nb/G33IpBdu7eRz8biuo1AFH9pPUjuZPVqVymDedrAuVHLe/
	 Ka3SzqeLEjMcvJcbR3FXC43ZepX5RKVCGBCRvND7GGd23HOoYHb+tb521LuD9zhquE
	 XOb6nt+mFML7OWeKjDcFTLlAChX2w7/2/oyO88/uivtBxG4js7iiNA0V0LoHDnI65s
	 BL9RrLZzOfhGg==
Message-ID: <cover.1790615923.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Tue, 29 Sep 2026 02:18:43 +0900
Subject: [PATCH bpf-next 0/2] bpftool: Reset map info between queries
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Reset map info before each query in the existing show and dump loops
to prevent BTF metadata from a preceding map leaking into a map without
BTF.

Patch 1 fixes the four query loops. Patch 2 adds regression tests for
full and named listings, JSON dumps, and plain dumps.

All four regression subtests fail on the unmodified bpf-next base and
pass with the fix in an x86-64 VM. This series does not depend on
recursive dumping or Maxim's series.

Tianyi Chen (2):
  bpftool: Reset map info before each query in show and dump loops
  selftests/bpf: Check bpftool map info across mixed BTF maps

 tools/bpf/bpftool/map.c                       |   8 ++
 .../bpf/prog_tests/bpftool_map_info.c         | 126 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.55.0

