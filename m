Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381590;
	b=rvqc7bIGkb9UjZu2Z+DqWD6om7EbZWnJus8Wjb+M1N5vSduT1Zm86Shnh0sw2IYyzDpF
	 5iPVDhty5ajVR8MDg7XBfogUtFFizyKYCf9G6TKqKIn3Ee/dvHvq3WP2TzPU9pZJhcKH8
	 2O5TjUCnKVa2AE/pGFl42LhlIAipUNrNr5SS0gr0Oo8H2d2U9OpelhX3fW63wk4NUkpdy
	 KDSl+ONmRRJ9uDcegwmuDhnypUfcg6jP1+pQ9VUbovvdJLM1yzA5pF8TyFvt0wkOS541x
	 n51eri7cwRbPRyZRgLn1Oche3lfRC4WDjG0q0SwY2Gl4ub1R406RyOADf7vjQIXHGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381590;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=gWQy+iVU7ejbUzs5+wM93cZcNu+sDcoGHFgbKJFi5b8=;
	b=XcAF2liGEJ7Xg1mM4cG0QmATUsMPNSMosoNklMam/cmpBWnU6Oo3G82+qqWiXG/ygXj2
	 GX+lfsR3D310qSZQfaNDBVyaux1hPLpKmZh2tkB4fWzFne9DX8sge4qh1vEV+WjfV2L79
	 xx76A8uikw1wbtonF9vjQbuK/BlTb0UrreuKiJwyVe4DmI+5hQOOdWOIdqzkYmRJfWwxy
	 P8skEQDrBThZy79hmG2tndFhGJB6HJzQALXNdhZYHN3RVPwwFIFtf/vIpUsEBW3DaQ8hv
	 650tcB3ADDYaQ3mvV93Hx33zw/WB2LYUpn22p7glNExkP65z8LARYn57P7PcrmXc7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=VPMP0nVU;
	arc=none smtp.remote-ip=198.177.127.194
Received: from out-utut-a194.jellyfish.systems (out-utut-a194.jellyfish.systems [198.177.127.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7E606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA7E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=VPMP0nVU
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZf05fmHz8sWP;
	Wed, 11 Nov 2026 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381579;
	bh=gWQy+iVU7ejbUzs5+wM93cZcNu+sDcoGHFgbKJFi5b8=;
	h=From:To:Cc:Subject:Date:From;
	b=VPMP0nVUH5+ut5aXAq63K7h2ttnhWuZB9kePjVs0MbOT5RoDKNtUvd3cYKiD2hNYt
	 5A2DfsDNkUr70DiRaQ5UwLcpeMdengpW2dV/f46Cj/tr2ZldHVfXqxZklpgnqBBvSx
	 DJkhK/37dN3IqUZqTvrTh73HdJxThyOIQUVtGBfxVDumZv96HcahLYnv+jaYU7Gwh8
	 Rjbi/sKJZtaZjqtsmji1Idi5COieGNVMXOYLjMLG1Uu1tYm7s8c4MN/eT+d2S0cVFD
	 q5lujdW9gnBHo3Eqb4rNSNlb2KoYeakZs4AkZHAZyIbu6R3DAKsZTX8C7aaMG95Tge
	 89ELuTjszsNhQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	qmo@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v12 0/3] bpftool: Add recursive map dumping
Date: Wed, 11 Nov 2026 16:19:24 +0900
Message-ID: <cover.1794380385.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Dump each inner map in the entry that references it. This series is
based on the batch dump v10 series [1]; apply that series first.

Changes in v12:
- Separate plain inner-map dumps with blank lines and indent raw
  entries and counts, including wrapped and per-CPU values.
- Read outer entries individually during recursion; keep batch lookups
  for inner maps.
- Use LIBBPF_OPTS in test_unchanged() and check formatting and lookup
  counts. Size the per-CPU layout buffer from the possible CPU count.

All 33 subtests in the combined batch/dump/access run, including the
11 recursive subtests, pass in x86-64 KVM with both 2 and 128 possible
CPUs (2 CPUs online). The old combined bpftool fails the formatting and
outer-lookup checks. Non-recursive output is unchanged.

[1] https://lore.kernel.org/r/cover.1794380384.git.hi@tychen.cc

v11: https://lore.kernel.org/r/cover.1793818386.git.hi@tychen.cc

Tianyi Chen (3):
  bpftool: Reset map info before each query in show and dump loops
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 131 ++++-
 .../prog_tests/bpftool_map_dump_recursive.c   | 480 ++++++++++++++++++
 .../bpf/progs/bpftool_map_dump_recursive.c    |  38 ++
 5 files changed, 639 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
prerequisite-patch-id: f2cb564c4555c7d7f3c87a7e9827a6e91816affd
prerequisite-patch-id: b8e7968eb997646d032c3489c5462230ee5837e6
-- 
2.56.0

