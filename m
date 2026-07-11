Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A137260F
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774135; cv=none; b=CeyP9H3LcuFdwxn08953Qok7k+kD2LHITQCQETcBMl/8JA/Z2/RURln7POGk+PXIKOjRYkxVQb3xM/MI0SdsO/CN9wOWIg1bnvaMfo7zKg3H7xzEX2Yl5CD0EIbJqn859mS+VaRSjd/7t0UOoJSnOCPiZyw9Ml7ROBKQcUAEB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774135; c=relaxed/simple;
	bh=2dRv8zzsWf1wv+bQp4l3GUIU3XatGtW4bGMz1rgGgQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkPLtcb68TIatORMpWA0Jo0pD84KXloot6m8GjFrck6XCUFulcuY10EREe/LNDemBFaZrAPwtubjFbPyakWY0YnrqJ3Wo4n6vbhWLXzsFrE+bu/MjpcVOi08S3kQVGPt7JBPLtJOND3ITUCYhci6mwRSTOs3Kcj20WqAitM9reE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VqXu06MJ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VqXu06MJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783774131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JcILiXl9Tq2r7apSCAgc+jVHOkkgYOw6EQJRUKsFiHo=;
	b=VqXu06MJugPfT1yxhtrr3KRmc2iZ3LJcrEhO5rLm2CXWsrL+1XXgIt5xOQHLtZ9puWQvuZ
	wBRUsys0Kca7dxvAi1Vgjv77exH1wewXKWUYiWB8Z/hhOF4k6JQjuLw25i61JV5ZsuIZf8
	YeWX2+O6gD1wE++UgqwXSj7k+ZumxWo=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Fix WARNING in bpf_trampoline_multi_detach
Date: Sat, 11 Jul 2026 20:48:20 +0800
Message-ID: <20260711124822.29406-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since tracing_multi link does not set ftrace_managed, it would fail to
release the tracing_multi link when attaching tracing_multi link and
then attaching fentry link.

[    3.714215] WARNING: kernel/bpf/trampoline.c:1727 at bpf_trampoline_multi_detach+0x20b/0x240, CPU#1: test_progs/97
...
[    3.733170]  bpf_tracing_multi_link_release+0x14/0x30
[    3.733890]  bpf_link_free+0x58/0x130
[    3.734414]  bpf_link_release+0x23/0x30

Fix it by setting 'ftrace_managed = true' in register_fentry_multi().

Note: the reason of targeting bpf-next tree is I'm planning to add
tracing_multi link support for bpf progs, that would rely on the fix and
have code conflict with the test.

Changes:
v1 -> v2:
* Collect Acked-by from Jiri, thanks.
* Check arg using tracing_multi_arg_check() in bpf prog in test.
  (per Sashiko)
* v1: https://lore.kernel.org/bpf/20260710144734.78203-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Mark tracing_multi trampolines as ftrace managed
  selftests/bpf: Test fentry link after tracing_multi link

 kernel/bpf/trampoline.c                       |  1 +
 .../selftests/bpf/prog_tests/tracing_multi.c  | 69 +++++++++++++++++++
 .../progs/tracing_multi_intersect_attach.c    |  8 +++
 3 files changed, 78 insertions(+)

--
2.55.0
