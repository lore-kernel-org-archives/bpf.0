Received: from out-2z4y-a165.jellyfish.systems (out-2z4y-a165.jellyfish.systems [198.54.127.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DD4252BE
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976192; cv=none; b=X+xjEJD9l/TJM3PT+ms96bOHXbD1858Xros6UPPpi2iAt9TaR8GKXVyy4U+4gW1IpGfslHWkHD4Y711CEOAljLCvSPmdCs6hNEt17czgfyFuinhapobZNPy9Ybxk/AWTdkq/oNk/HEPdHvlvjQ2XlKgEohwSN0XrZxXaPCJUPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976192; c=relaxed/simple;
	bh=lBk5cEgSKUwfgd1f1BPMPtWh6xj1Jp85fT8tgnBqHuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKuxkd3NajkK6Zulkz8wrZPiJj076GkjrtFsx4xj5SaYZH8qiBW5dzaXACS4uRTUybAOKUF0wIzTKKRgFDivV6bCTk8uOFW/f6KHUMKmo9IXzuVLEdaxiD20L68OEHN6v7QBiBXBn6HtBy7UhLwXJjFRMtWfCCYSm3gQPNBnjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=ifRqYZLS; arc=none smtp.client-ip=198.54.127.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="ifRqYZLS"
Received: from fedora (unknown [117.136.111.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hpFQW1vxrz8sYP;
	Mon, 21 Sep 2026 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789976165;
	bh=x0ylWZptud494IW/g9Rj9XK6VykW/vNQo0wTx8WL8Wk=;
	h=From:To:Cc:Subject:Date:From;
	b=ifRqYZLSuYj4+AoR56pEBdO3Mo6+iHQuSXzujd7dyrwwqGc9Hoj9D7xFowO+mZAKP
	 lW7o40PkY8WNty1kVVC5dQLQbDWpTmHLTJ2xihbF3B4BR1JESE6eaMdFp0C7YX50MU
	 d48YrHFCIirgIF4grCIRa+hIZ3GDD0yt+rSIjMyD0KReUX6CDOoDf8X8y/n+qXDYLa
	 guitb5Qw3+338863xjNlfkzVis+FcWJk9iDNbU7JYec0NMlI1Li8gF4DbLc1ilFl5C
	 76ayyVKtF9YTZuCIom/L6aOFlJd8uxi9RtytTd8gmUQozMQfeOB73k5cXL/M1QQZQV
	 DcV8Pp/ayae3w==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Mon, 21 Sep 2026 16:35:54 +0900
Message-ID: <20260921073556.99421-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Extend map event_pipe to consume BPF ring buffer records, with plain and
JSON output and focused tests for records, shutdown and invalid arguments.

Changes in v5:
- Suppress cpu/index completion after selecting a ring buffer map by id,
  name or pinned path, using _bpftool_map_guess_map_type(). Keep the
  existing suggestions for perf event arrays and unresolved map types.
- Rebase onto current bpf-next. No other changes from v4.

This addresses the v4 review:
https://lore.kernel.org/r/a89e2e325b87c215e0fb6e4a24284922d7656cfc0e2a247f0c8c1cd823764c23@mail.kernel.org

Built bpftool and reran all 18 ringbuf subtests against it in an x86-64
VM; all passed. Also checked completion against live ringbuf and
perf_event_array maps by id, name and pinned path, plus unresolved maps
and already-specified selectors with mocked output.

v4: https://lore.kernel.org/r/20260919110721.1230756-1-hi@tychen.cc

Tianyi Chen (2):
  bpftool: Read ring buffer maps with event_pipe
  selftests/bpf: Cover bpftool ring buffer event_pipe

 .../bpf/bpftool/Documentation/bpftool-map.rst |  14 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  59 +--
 tools/bpf/bpftool/map_perf_ring.c             |  87 +++-
 tools/testing/selftests/bpf/bpftool_helpers.c |   2 +-
 tools/testing/selftests/bpf/bpftool_helpers.h |   1 +
 .../bpf/prog_tests/bpftool_ringbuf.c          | 417 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
 7 files changed, 578 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c


base-commit: 48ea1ba704aa3a9975e917411ee05bbe67d65744
-- 
2.55.0

