Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC542E401
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782262564; cv=none; b=LpnD8C9A2t6IhenPeL8bgFFQf7YxBJm0m0JiPgXwDwfLb4R3lDCKkYRi8geUe8ev6dkz1zK/8YF49TCCN88EoC1eEwuq16vuiwu3TYqpgYMu3pYOjWa5Wgoxz94blQ9piONsrggohXoROxHO8oYNhvORA6A/fZhOdo8k1GUn3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782262564; c=relaxed/simple;
	bh=jf9Lr/H1TGSGBgMvhPcARxG/chRr5tqibTtayXFhigI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYaGJHiEWbqMz/NZo6uOgqfXsSYKhcTV29d30pmZo1KNNL3nzsQ9tu2LFxPsxGT9XrcM26YY1Ojt9Ri/dsL/MqYyHefzK1iFv/AxeDjn8x1yTu31HLY8CecS2LO2ZMlYA7MR376Lq4Vp6cc8JYBf09+N6zOZkA0W6Emf0DXfHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZMfkg7nE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZMfkg7nE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782262558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bHlamQQbjo/zgPdAomihKNSREsAVcgArQqjadW9u7f4=;
	b=ZMfkg7nE5cwCUXZ4drkQpNvqBy48Xa/Jc3HpUl4zel2XJ0DkppzMddqjFtIas0W7YH+teg
	tSmSANkpPaUxQ92ls1TTw/JXZyul0WLWoUa5wpZ+ZcLAv94r1gv17V6qorMjQUM4GcnVVo
	4AxVLldCXzF58STNNz6IB0b3GjQ9k/4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Modernize resolve_btfids selftest
Date: Tue, 23 Jun 2026 17:55:42 -0700
Message-ID: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series updates resolve_btfids selftests to use latest selftest
helpers API and add kfunc set testing.

This series was split from a bigger series [1].  It's general selftest
improvements that don't have to be entangled with resolve_btfids
development, and makes the main series a bit smaller.

[1] https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/

---

v1->v2:
  * add another kfunc set in reverse order and check_kfunc_set()
    helper to ensure proper testing of BTF ID sort (Eduard, patch #4)
  * nit: restore a dropped break (Eduard, patch #2)
v1: https://lore.kernel.org/bpf/20260617210619.1562858-1-ihor.solodrai@linux.dev/

v0->v1:
  * various nits from Jiri, Andrii and Emil
  * in patch #3 (that adds gcc pragma) definitions are moved such that
    .local BTF_ID_* containers are grouped together and we have a
    single pragma scope

---

Ihor Solodrai (4):
  tools/bpf: Sync btf_ids.h to tools
  selftests/bpf: Modernize resolve_btfids test scaffolding
  selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE
    builds
  selftests/bpf: Add kfunc set test to resolve_btfids

 tools/include/linux/btf_ids.h                 |  78 ++++++++-
 .../selftests/bpf/prog_tests/resolve_btfids.c | 159 ++++++++++++------
 tools/testing/selftests/bpf/progs/btf_data.c  |  10 ++
 3 files changed, 195 insertions(+), 52 deletions(-)

-- 
2.54.0

