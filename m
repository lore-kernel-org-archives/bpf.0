Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6686370D4D
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733587; cv=none; b=a1R+TuUSVURbAznYkPkPUv1SdCdNzS+cWhc2jY/ODasPNIL6aH7cLxah94xuuRpR8Kl+WODuAXsMprIC/WppELgXbmKAmCwcRnoiI7gj3Cshk5AXDvWCaWMkr6rq8WTgcQYUhGQW9ZN65PdD7CiZ15cEP9q0kx08fSot74xqIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733587; c=relaxed/simple;
	bh=xk3+nrHllWQ1G0pZL39iYHK7vypyilrYeYrFPuYlxg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGh5tW8y1gpmHcIt3hxPBOPrs/KrkJTa/5sMb/2ZsushYB2+SRu5XpuYpyMwCnjxDuZSvVlky5lPsP4Zu6KEgQ2Jeb97h7PltfRCQpF1wfnMxBztGHFO+rmv2zSfbm9bj6knOd/WyCTVbpIh2Ciz8KTK65jXB1dv71J/lB+1vBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uC5LpJ5I; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uC5LpJ5I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784733581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TO1DigB1z+i/Y3sHuC5IZU2pZU4A7heTWtiFEAbnRkY=;
	b=uC5LpJ5I3bOYD09OC4mw2G1ka5CiiHHietkOlZ2az9kY6mlq3CE/0pEuW2AxhnxquCyAtz
	YCSOPfKdE4xU3Amb90EB5vVdElpJeWzE+4TQ9JUaNLqbCS3cA8MlebMDUgA6v7jB1Nju6W
	y5STTwZbcs0SO9xN2E8RBioQd51rjUQ=
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
	Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Fix WARNING in bpf_tracing_link_release
Date: Wed, 22 Jul 2026 23:19:07 +0800
Message-ID: <20260722151909.69142-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The trampoline could be corrupted by the blindly
'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.

1. A fexit attached to a tail_call_reachable prog. 'tr->flags' became
   'BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_TAIL_CALL_CTX'. And, the
   trampoline would poke the target prog's nop insn using jmp insn instead
   of call insn.
2. Another fexit loaded with the same tail_call_reachable prog target.
   'tr->flags' became 'BPF_TRAMP_F_TAIL_CALL_CTX'.
3. Close the first fexit link. Due to no BPF_TRAMP_F_CALL_ORIG in
   'tr->flags', the trampoline will fail to restore the prog's nop insn
   using call insn.

[    3.410719] WARNING: kernel/bpf/syscall.c:3551 at bpf_tracing_link_release+0x53/0x60, CPU#1: test_progs/98
...
[    3.428793]  bpf_link_free+0x58/0x130
[    3.429293]  bpf_link_release+0x23/0x30

Fix the warning by updating 'tr->flags' with '|=' and lock.

Changes:
v1 -> v2:
* Update the patch #1 message with 'tr->flags' change. (per Jiri)
* Drop the 'link' and the last 'if' in patch #2. (per Jiri)
* v1: https://lore.kernel.org/bpf/20260721133036.49265-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Fix WARNING in bpf_tracing_link_release
  selftests/bpf: Verify no warning when close fexit link

 include/linux/bpf.h                           |  2 +
 kernel/bpf/trampoline.c                       |  7 +++
 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 48 +++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

--
2.55.0
