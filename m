Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA744AD4AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266504; cv=none; b=flenf6rzlWfMHqTWs9i91w95QR/fki9fke1ZR0TygTMwS78Yd7m7Q4aTUX8rXxcBfCyyPV+7GipfypusfglMhgadhFe3JEm2StVLFQz00yFletWuNipwUrRVPAXFSJqb96p1J08DSRgKhoLjrNyHKvwXJHsAp4o7WvkfkgVpE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266504; c=relaxed/simple;
	bh=iu+Fwdft2lj2nbTGVvwp6TSytYO1F4qEmdwTZN3PX5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3MakGCarxAyP3fijOLuLKQX7qTNaF0HvjiXATj30UyDfz5K1WXtW+fVIQzBrB6jgJVK1/OKG3XpwekTBZeKdmoN9AxPsO8q6kA6/v05xGl11CeZqxiqCp4Jvknp/eIGLqSfXmcPwLRC5LTtbm2c/DacFT3kpmvOLWnG0DKb36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=UDhf9shB; arc=none smtp.client-ip=63.250.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="UDhf9shB"
Received: from fedora (unknown [124.160.34.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrJnd6Prjz8sXN;
	Thu, 24 Sep 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790266488;
	bh=wYBhubkV0gq6vbWwtF9ht/Sj7WpRXhty5ZvVHxcFe0U=;
	h=From:To:Cc:Subject:Date:From;
	b=UDhf9shBHU7vezngZGIpew0U7oF92thr5YHvdQ+6kFyb1OpneqkXcW3xPuLJYHU1c
	 pcQgYxaDD29FnU0pmsNyqpJP0elkinhnLZ4+0XB09fKvd1IF7ihDNkoGXGzItPpNpB
	 NH2uZ9P98nMq+enjQBb5LBBbQiMFBKiVUbzaai7uP0kb7oJNIz46ZncqdorIcG64HI
	 Y+PPLHt5oonVQvqD+LpTHNxJuj2CB4bNgjUSYhmQZfFixoaaaXkYY8iyEpaZ9siMFq
	 x2VPCE3jYMfvgkMYCZzcVLEeRsA4rBtYehEcbs2eK1/ujm3wfnq3gd3Y1g0enad+yY
	 hHcSqPtIKoFyg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 0/2] bpftool: Add recursive map dumping
Date: Fri, 25 Sep 2026 01:14:32 +0900
Message-ID: <20260924161434.95116-1-hi@tychen.cc>
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

Changes in v7, addressing Quentin's review:
- Replace the global -r/--recursive option with a map dump keyword:
    bpftool map dump id 1337 recursive
  Keep the setting local to each invocation and update help, completion
  and selftests. Reject malformed or repeated trailing arguments.
- Shorten the man page to describe the feature and non-atomic traversal;
  remove detailed output/error-format descriptions and adjust line wrapping.
- Rebase onto current bpf-next, preserving the updated per-CPU dump path.

Validation:
- Rebuilt bpftool and the focused selftest runner; all 13 map-dump subtests
  pass in an x86-64 VM, including the low-descriptor-limit cases.
- Checked pinned maps, per-CPU inner-map plain/JSON output, keyword scope
  across batch commands, and rejection of the removed global options.
- Bash completion checks and test_bpftool_synctypes.py pass.

v6: https://lore.kernel.org/r/20260911051053.283421-1-diannaaav@gmail.com
Review: https://lore.kernel.org/r/44ec5184-5a77-413d-9f42-fd93b0abbf11@kernel.org

Tianyi Chen (2):
  bpftool: Add recursive map dumping
  selftests/bpf: Cover recursive bpftool map dumps

 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 143 ++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 507 ++++++++++++++++++
 4 files changed, 655 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: 740eb74b8d2e3b7850e55b15257c8c0b0fc4a125
-- 
2.55.0

