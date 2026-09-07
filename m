Received: from out-2z4y-a149.jellyfish.systems (out-2z4y-a149.jellyfish.systems [198.54.127.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A62868B4
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744099; cv=none; b=o4aJ/mp472RzQEBZn4yVQ9ZoeFh07tCBU41k4RPxEuZgKSpyZd348DYdrNrA74Wn+hh8F8fdLkIdnwYm2b+g6yLWHwtADRgBBkFaGM3GUroquW+QHF+6gpsVpU+9AyN8tkluSRcV4yMGjcH8sWSHiWrRwNLarFo+lGuPUamOgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744099; c=relaxed/simple;
	bh=PezC69yb7Y5XsggpmQfIAlt2sT8WfP6tCpglFI85dqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfienXCi9AoYha+D8jnYyahsqGyhvNDFdAj0djQLEMiN6vR/qhjkmTB3rDYJZCt+8LIUynQtYPRQIPW5GBMuhzilKfiavjkmjObvUHLbvgvPfNjtgpzVz6ADwodjSPhQ6l5iPgOeLye2QRPBRYs8JnpSpECxRM9eN+4govbtZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=JuDtukJK; arc=none smtp.client-ip=198.54.127.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="JuDtukJK"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTmn2nmZz2x9C;
	Mon, 07 Sep 2026 01:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744091;
	bh=ZkO/PXo9Y4e7ObMpK1U5BimDGIPh0rnfiVQ0/jckW34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuDtukJKq0sQ10jLkx4ipBWjmam3OVBKWX4JnA9iKRXDf9JpmjjiS1850W0453Esp
	 E3Ek10tZ2k+WqzJbGVSncARQePG9A/Q2RyqIm7KYphUEBLPCSeZanY6vCkAKZCEQkv
	 wkbMRk3m9PmRxkWUFjt9aOHTyahz9x27gm3MGME9q2WeAPUzkKIwy00//L0qdpffGs
	 LPD/4jEFLbnFLqeBwjqfJ0Q8P42zJUEUbGNtJkxN0CK1Hu1/nacTooiaqAWTQPhwLx
	 27amm5KOSS5Y6uEkYmtGlMwZ5xiLthjYTvwPTgtgwJVM1NKLU/cxbELjdt5F5BLEex
	 Wui8KTb9YAX7Q==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpftool: Add recursive map dumping
Date: Mon,  7 Sep 2026 09:21:25 +0800
Message-ID: <178874362960.1415955.7640440818340667463.recursive-v3-0@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178870998583.979169.16526173782819097354@tychen.cc>
References: <178870998583.979169.16526173782819097354@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Add recursive dumping for maps of maps, including shared inner maps,
BTF formatting, unchanged default output and bounded descriptor usage.

Changes in v3:
- Close inherited descriptors in the low-FD-limit child before setting
  RLIMIT_NOFILE=32. Use /proc/self/fd rather than requiring close_range
  syscall definitions or support from the running kernel.
- Open 32 extra descriptors before fork to cover the reported failure;
  verify that the parent's descriptors and outer map remain usable.
- Rename the global option to recursive_dump, reflow the option text,
  separate the JSON paragraph and fix multiline comment openings.
- Document JSON container closure without promising that every kind of
  traversal diagnostic is included in stdout.
- Use the required tool:model Assisted-by attribution format.

Validation:
- Full bpftool and focused BPF selftest builds with LLVM 20, plus man page
  generation, succeeded.
- All 69 focused subtests passed with the flags, ring-buffer and batch
  v2 series in an x86-64 KVM guest running Linux 7.3.0-rc1.
- After the final descriptor-cleanup adjustment, all 12 recursive dump
  subtests passed again, including both low-FD-limit cases.
- No skips or failures in these focused runs; the full BPF selftest
  suite was not run.

v2: https://lore.kernel.org/r/178870998583.979169.16526173782819097354@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/58

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  22 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 130 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 465 ++++++++++++++++++
 6 files changed, 616 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

-- 
2.55.0

