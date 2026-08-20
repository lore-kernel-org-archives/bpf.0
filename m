Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51EDF6C
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184413; cv=none; b=DprSMZ7pto6HuSfwa32BcbbqxyC1fcucB83ot/z+AEjVN0D3z3HuTU0vy4AgWvj9GJnQCIZjARRxHMFfZj1IEDE93VOotTjDAHk3laBeQjRf86TxFj12kqGdY1PYJQ4IyHpkhqrYodtqmt1KbQhy+LNyca0duOVZ1VNW6rN3TPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184413; c=relaxed/simple;
	bh=huob2TU7Nw+jmyEbfQPwW+YCaq+jZT7cfgOdL8SuRAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnrrqjSDsy0O4c8A4jBDUMLC3zH+yz8TSeNKRxKOGBNGHjQVcKIdRCh7FjuWhjm6voqytUdgQoEmX4PCmCT2l+l+agbQEUp9yS11t+s14V01cTVzGWTAbYP5obrrm8Pp6QlYcFY1mT4Eu7A5iUppMMXy2tvlNE+0BlahC624cSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ew9Q+JGS; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ew9Q+JGS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=huob2TU7Nw+jmyEbfQPwW+YCaq+jZT7cfgOdL8SuRAY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787184408; v=1; x=1787789208;
 b=Ew9Q+JGS6qPTF2CGLC76SsC+Emnq5b1etxjh1aegCH/qEBUl+ZOOBpKf9L4ulQPXfsurIGDg
 K4SR709k4/O7yO75z1Ewc5g08zQXk4K+mhd/rTo1r4hgmIsbMYSmj8CqfkBDMwAePjnXPhVrqvp
 8V8+1Vi7h9f5PqzSjJvKQ9fU=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::5:942a)
	by mta11.migadu.com with ESMTPS id 0a6e5bff04414de3;
	Thu, 20 Aug 2026 00:06:38 +0000
X-Mizu-Trace-ID: 0a6e5bff04414de3
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 0/4] bpftool, selftests: Add tests for C dump and fix a dropped type
Date: Wed, 19 Aug 2026 17:06:23 -0700
Message-ID: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool btf dump format c" generates the vmlinux.h that BPF programs
are built against, and it has no direct test coverage. Building
against the header is not a substitute for testing it, nothing a
compiler accepts would break the build.

Patch #3 is an example of a bug that might have been caught by a
dedicated "format c" test.

---

Ihor Solodrai (4):
  selftests/bpf: NUL-terminate bpftool command output
  selftests/bpf: Add tests for bpftool btf dump format c
  bpftool: Don't drop a type in the sorted C dump
  selftests/bpf: Check that sorting preserves types in bpftool dump

 tools/bpf/bpftool/btf.c                       |   6 +-
 tools/testing/selftests/bpf/bpftool_helpers.c |   7 +-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 223 ++++++++++++++++++
 3 files changed, 233 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c

-- 
2.55.0

