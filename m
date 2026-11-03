Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732499;
	b=CBg1w64t4SBRs4VsVHLWGd9HG5Tk1i7n5MNPLg081bFDJACeq4GhDKtuU21/c/3kOZMk
	 X8rGL0qbbhDga9W+DnSceGBJ1NTqxX/3QdC/tAdhmKlylTt+LTZSbXQxX1npSWZzKx3sv
	 m/v4A9Pcb7UZ0a9bERd9+42rzYyJZY0xTE8kBKnYo/Reyx3rs20VfVShRT7b32qcv/ePu
	 jXzc68GMvN49yiqZz8BCarOV41DWhnCoyBmG5q56LsX9Z3QWJwYbcoA270IV7eBGnlEVi
	 CbY7Q77E6YhxeVYX9eNSqJZoeI45eBaTHnCKt9jhXpcnd51V5pBbT1xFmMutsf9Juxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732499;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:Date:Subject:To:
	 Cc:X-Envelope-From;
	bh=M7A7YtzFK/3DG7cUe9Qcg5oYk/BA2Hqp9mAXM2qE8n4=;
	b=vCvaWOXPGP+KqxbT6+NrxVpwHlQAtmXSRAag85mkGcjkp0M+P8YMKLOfruZM5Fz0zrv7
	 fQBcxpK7V1gnlCB2rtju+Wn2tegCRKfK1T1PrFHUfh4/tWJEQWXYMHpxiAnGnXPOdH3Zd
	 8yIs0qUAbe4TMcbfhfFRhlmaPuI+979fViixUj5ZQ/kDtUw3qhdwQXpQRFQzTu/TXSHZF
	 e8DqQ2avo4XwvdBQ06FYCnmtjau2A27uslZkPFUbyCduMLZkiHP5gAJezWPnAPz7UsxkA
	 amkk90B/+WoAIuEkFXE/e3cy0E8ZHweLAU/MMWevXLHk8ArClXASrvu1cTwjT3Vj84w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=mkXGfD7l;
	arc=none smtp.remote-ip=63.250.43.97
Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E11606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=mkXGfD7l
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJybR5z9Pz8sWP;
	Tue, 03 Nov 2026 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732489;
	bh=M7A7YtzFK/3DG7cUe9Qcg5oYk/BA2Hqp9mAXM2qE8n4=;
	h=From:Date:Subject:To:Cc:From;
	b=mkXGfD7leV374FrAs0RDTRZq8pfVKiyJMFuuKGsHLa+t6GRifTCBGjboGpsAwpBSF
	 sKOubgAfdhZgi/9dE+4hnk38eUilSTrPtb7LWFqYolzZhKqhezBBFs7jGfg9CjaQFp
	 LMok5pBwwN8HZZNJtuiu/fY4Uau8P/hxzivXNW0yMGBgHUzmXMSwhrDzfmPUb8l5dW
	 7j6po5ok58dF2e/F0IpIktPYcLvSCItV4zCbF66bsSKuHixoNZtiX3aQGQoaa6qLQg
	 IsF5Jmr3cefEMwj17NOZ3YfbpaNghTEIOax9GMBXdlgf14q887XZareZhDoa7nOd9K
	 UmKU5GMxFpnyg==
Message-ID: <cover.1793732336.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:23 +0900
Subject: [PATCH bpf-next v10 0/4] bpftool: Add recursive map dumping
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com,
    daniel@iogearbox.net,
    ast@kernel.org,
    hi@tychen.cc
X-Envelope-From: hi@tychen.cc
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Rebased on current bpf-next, including Maxim's merged map-dump fixes.
The map-info fix and its tests are separate patches 1-2, included here
so mixed-BTF dumps also work on kernels without the kernel-side fix.

Changes in v10:
- Split the generic info resets from the recursive implementation.
- Rename the recursive test to avoid the upstream test-file collision.
- Preserve Quentin's Fixes/Acked-by tags and update the ENOTSUPP checks
  for the merged error-message formatter.

All 21 focused subtests pass on x86-64 KVM with Linux 7.2.13 and 7.3.0.
The four map-info regressions fail before the fix and pass after it.
All 33 subtests also pass when combined with the batch-dump series.

v9: https://lore.kernel.org/r/20260926014208.24773-1-hi@tychen.cc
Map-info v1: https://lore.kernel.org/r/cover.1790615923.git.hi@tychen.cc

Tianyi Chen (4):
  bpftool: Reset map info before each query in show and dump loops
  selftests/bpf: Check bpftool map info across mixed BTF maps
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  12 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 154 ++++-
 .../prog_tests/bpftool_map_dump_recursive.c   | 605 ++++++++++++++++++
 .../bpf/prog_tests/bpftool_map_info.c         | 127 ++++
 5 files changed, 888 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c


base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
-- 
2.56.0

