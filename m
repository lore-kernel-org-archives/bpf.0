Received: from out-zbxj-a74.jellyfish.systems (out-zbxj-a74.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D34B0E5F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358267; cv=none; b=mFw33SshTij0uTt4tDzohQn/u7NJVMcT2lhE5nQNVhn8w+JlHkxR/oib67ur8lSJatdMdBJDwj0U2D2wXwJH3AYfp6Ge5MVOhTKBTlc3NGqkGF90qVn42YTh5tTpmA6EtibG+JLYvbUQG8yly8gzxBWwLqVTs24AZ8VkP80WNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358267; c=relaxed/simple;
	bh=KNQ2Zt6Gpr2f4vLn+dimqs/oCjXTUXEvHihyG+8FxAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llTZENUOIoiIPQxdZk2bA2KBk56+aj+i1AxfRen+olMSUDthyPEvwGTg2KnNgj2TSm1iyeBOsK7BsG8x0duwnPGLEmZGsfKvC8d8kOegGWrLPhRnq/+w9tlPL61CrZpYbA24khNVgyZX9hookO5k4DBYKiaeeCO1CsOWZUVMM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=lZNsW9dE; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="lZNsW9dE"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrykC3S9hz2xFY;
	Fri, 25 Sep 2026 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790358245;
	bh=ZwarAQKJc0UecRwQldkY/tVoIvWkDbjiv1st7cWGyJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=lZNsW9dEqpDUiDE9eDZgnUEhZCz91r6Gc8fXgwdTvmpTnHScHSv24E1ufO9qRpqVE
	 hsA4a0Sncrd15ZEmJrZG47PDmVTsf9V66L3k0hMcwAutEvjVMkKA664K4gfdbrNUZk
	 qPUHQlZVMd9OCVyO1VUb00tlZanfqfyG6urfE55YCxC2U0b2vXsY9AMyq/yd9NhkIU
	 2qVTUZZTU4zUpehnHqrqrJIyLXN7SCw/+BEjfkEulM2WKdhtGizOvS6LYJBpuPMXqw
	 CJGM5eF8dntevnh2c5ZvYYy4tt436lQplnN6lSzZ4WurA/wV3nuy5vmzrS+80/VuPJ
	 0I47/J7dVjyYg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v8 0/2] bpftool: Add recursive map dumping
Date: Sat, 26 Sep 2026 02:44:00 +0900
Message-ID: <20260925174402.2028649-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Add a recursive keyword to map dump to visit referenced inner maps after
the selected roots, with deduplication and bounded descriptor use.

Changes in v8, addressing Quentin's review:
- Parse MAP first with REQ_ARGS()/map_parse_fds(), then consume trailing
  recursive keywords. Misplaced keywords now get the MAP parser's error.
- Close selected map FDs on trailing-argument errors.
- Test misplaced-keyword diagnostics and repeated recursive keywords.
- Rebase onto current bpf-next.

All 13 focused subtests pass in an x86-64 VM. A syscall trace also
confirms that both maps selected by name are closed on an argument error.
Completion and bpftool synchronization checks pass.

v7: https://lore.kernel.org/r/20260924161434.95116-1-hi@tychen.cc
Review: https://lore.kernel.org/r/6ed88738-4e3b-407c-90c2-bf7717f3e653@kernel.org

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 147 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 514 ++++++++++++++++++
 4 files changed, 665 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: 7af653d4ebf8e2e17e288715cd67ccf7845f4631
-- 
2.55.0

