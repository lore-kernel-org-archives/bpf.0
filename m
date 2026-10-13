Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAC4A2A61;
	Tue, 13 Oct 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915596; cv=none; b=oyGN6dbJh5s36nwArrcdeyQbTrO/k3wpRueLCrPtx2U6HRlIlB203+KPoAYFCtD8uwZUkpVhyQ/0bZqgIvDRbWh8eTXnmRgwRSCqsldXBVpUkzLpE43WLatDhro+bD0oMUaJuqw66m85+1/UkAIXCvvV3jqul5hAU/3egW2US9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915596; c=relaxed/simple;
	bh=qegGgAzW18JVJXUjtzPA+cHAIkYUYNlEhkizNdaRkZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euv8t+wwhU/SMkw/PaSqDPW4UvncD7dKSkq8Js+KRBBHHRu8ajZi7V3UFgchZlbxvE+UyYhs4ZbYBxLM9QHQc1QlBtWhchjAr/94ZngaRWVIIyxHmjDM33OTOhRVRO0en7zba/+l2N/0+ElrOdpqo85cMeBG6nFlPbLqyI74fbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j42g91FhRzMlVG;
	Tue, 13 Oct 2026 20:19:49 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: listout@listout.xyz
To: bpf@vger.kernel.org
Cc: bdas@suse.de,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <jp.kobryn@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] selftests/bpf: Add tests for memcg kfuncs
Date: Tue, 13 Oct 2026 23:49:30 +0530
Message-ID: <20261013181932.1739238-1-listout@listout.xyz>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j42g91FhRzMlVG

From: Brahmajit Das <bdas@suse.de>

bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
selftest coverage. Patch 2 adds a memcg_kfuncs test for them, plus
verifier tests for their acquire/release, NULL and program type rules.

Patch 1 moves the alloc_pagecache() helper from arena_memcg to
cgroup_helpers so the new test can share it instead of carrying a copy.

Tested on bpf-next with vmtest.sh (x86_64): all memcg_kfuncs and
memcg_kfuncs_failure subtests pass, and arena_memcg still passes.
---
v3 -> v4:
- Move alloc_pagecache() to cgroup_helpers.c and share it with
  arena_memcg instead of duplicating it (new patch 1). (CI review)

v2 -> v3:
- Drop the upper bound on the bpf_proactive_reclaim() result; only the
  request is clamped and reclaim may overshoot. Fix the commit message
  accordingly. (CI review)
- Print the reason before skipping. (CI review)

v1 -> v2:
- Also check that negative indices are rejected by
  bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events() (Sashiko)

v3: https://lore.kernel.org/bpf/20261013171211.1661726-1-listout@listout.xyz/
v2: https://lore.kernel.org/bpf/20261013151621.1526699-1-listout@listout.xyz/
v1: https://lore.kernel.org/bpf/20261013143853.1379307-1-listout@listout.xyz/

Brahmajit Das (2):
  selftests/bpf: Move alloc_pagecache() to cgroup_helpers
  selftests/bpf: Add tests for memcg kfuncs

 tools/testing/selftests/bpf/cgroup_helpers.c  |  34 +++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 .../selftests/bpf/prog_tests/arena_memcg.c    |  34 ---
 .../selftests/bpf/prog_tests/memcg_kfuncs.c   | 273 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_kfuncs.c        | 106 +++++++
 .../bpf/progs/memcg_kfuncs_failure.c          |  54 ++++
 6 files changed, 468 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_kfuncs_failure.c

-- 
2.56.0

