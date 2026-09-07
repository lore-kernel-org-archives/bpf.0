Received: from out-2z4y-a149.jellyfish.systems (out-2z4y-a149.jellyfish.systems [198.54.127.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B025B085
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744078; cv=none; b=EqyN1jAFnjaBga0zmpZRGTnR0EkS9/IcZfP3TUr9r6c3pqrIJEBYlCd1Kd3AKEWaOyH2Y7YHVXC9RD5uOEwxZ8PPFTQ5k+klSG/FWYPVdme5VDeuLkj5YZlBmZLs0ECu65G0a/bdTVo6ljpaOWXGyoHc1BZRmYin+cG0w/C8224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744078; c=relaxed/simple;
	bh=a7AXSmn/NlKoS0xwXv0eAiJJYGGdHLj5VX0F9Gj8Tbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRCOFBMgJSu4PS6IPIYeWeVSFmkeAQhbKn6vJSp4KQrazp353neHUnJ5JA+1KQvK3d1wFdK/DnuXMeEtJk0A1qX1JHKgiUshKgNpCbuymbthb06hVfTRTjvvx2q9g13zareDDhWY0K9796AYEbBgSoUphNmO8n3RWz20s97a1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=MIXcU3Hm; arc=none smtp.client-ip=198.54.127.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="MIXcU3Hm"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTmL0G3Qz2x9c;
	Mon, 07 Sep 2026 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744067;
	bh=lr5KieLnqI+sgaziKgRJ4AR56kcubW4Ft5c8hGZUf+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIXcU3HmwWee/ZN3Ui0/Wv4W92SNlQTfPtQ/HrSHa0YOTVx3RFKi9BH4DqVlDonmt
	 7QziXiuIjsscHeu6lW3wcPTdKfETNceMt+KGc0C3uTZmhI++Um/Ze7k1J/gLrS7Lyd
	 frxX0Ngm9BCHotjsGE4LSMGG0JMxxmeJjhH33MliNprC14On2yoMngq92rsif7VxF3
	 n96hXC94J8S8Lm4uEAGyNT5gkmqqCk2B/dzSuKiU4+EVxGU5GkizZvC2aq+/Fcg5E+
	 XZ6dmPJRVpilNXXW2uHZEcuERSJ1pp8DTldyCg7zuKLh2AfisOkC39V1lfGUS5Sk/Z
	 aGoFvufoErryg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Mon,  7 Sep 2026 09:21:01 +0800
Message-ID: <178874362960.1415955.14971768495630842802.ringbuf-v2-0@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170747.1212378-1-hi@tychen.cc>
References: <20260906170747.1212378-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Extend map event_pipe to BPF ring buffer maps using libbpf's ring buffer
manager. Output records in plain or JSON format, reject CPU/index
selectors for ring buffers, and document the shared consumer position.

Changes in v2:
- Add actual -p invocations and pinned map selection, which the v1
  selftest commit message described without implementing those cases.
- Check the complete pretty-printed document, test plain/JSON/pretty
  output through pinned paths, and test pretty output for an empty stream.
- Clean up pins and their unique directories on success and failure.

Validation:
- All 17 ringbuf subtests passed, including the existing perf event array
  regression, in the integration run described below.
- The event_pipe implementation is unchanged from v1.

v1: https://lore.kernel.org/r/20260906170747.1212378-1-hi@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/54

Integration validation: the flags, ring-buffer and batch v2 series plus
recursive dump v3 built together with LLVM 20. All 69 focused BPF subtests
passed in an x86-64 KVM guest running Linux 7.3.0-rc1, with no skips or
failures. The bpftool-map man page also built successfully. This is a
focused run, not the full BPF selftest suite.


Tianyi Chen (2):
  bpftool: Read ring buffer maps with event_pipe
  selftests/bpf: Cover bpftool ring buffer event_pipe

 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   4 +-
 tools/bpf/bpftool/map_perf_ring.c             |  87 +++-
 .../bpf/prog_tests/bpftool_ringbuf.c          | 425 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
 5 files changed, 554 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c

-- 
2.55.0

