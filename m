Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF43563C5
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029093; cv=none; b=RMAkWfRWgnMhAuoGa6H4v6tBGYzEIUMX1UCZXMuB/xCX0KuMboY3KfNqKZprbwajmAJMezTUGGc7lbN2Lx8/HK+JuSw1LsGgecjget0HkLnm6KR/0uIGUHeG2bcKVNrze5hh88wQv9Im1bgukB5zFtaBAkjuVHY7qjMqPzf62rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029093; c=relaxed/simple;
	bh=JjR5lt6PB8Wr58NLcKfQexVFiiTZzoIOsO/wC5jkMPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twSeQt3g1HD63+2cttIHWu7XYN7PCLQVRWQGeLifxsUQA7rI3rL6EJnXZr2f2g1AEIHb/sZJMuLji6vuI+70qIJJBgyjES5e0Y2hsBggOJHGo0Wf7JQriezBLIp/M9+eUJLy9ykapd+K2IHRRjst6FdhH/nKTRI1mUGrBT0vkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Furcn2ZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Furcn2ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD8C116C6;
	Mon,  2 Feb 2026 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029092;
	bh=JjR5lt6PB8Wr58NLcKfQexVFiiTZzoIOsO/wC5jkMPs=;
	h=From:To:Cc:Subject:Date:From;
	b=Furcn2ZNxz9x9vUGDewi1gbYeGAoh3oJX/O/vjmBC6luRqgVfaF6D+UzCu9FghJzt
	 Q+HDh7sD5HJQ14DM6Wml6ZxC/uoG0Y8QIcXKkQ9YYmPTw3m+r00d8pdiinbGgpG9CW
	 BiizNjX4yd31MvarN4U1GN8tIK/l/gp0jyKkMseYk/91qZlkwcxMrRE2egnfu41cCK
	 KFbHG+xrWGhgZotBGQ4f4lk5a3nQkvUu+Fp12uu3Cnq+B4dmscW4uqqx8N88a0mrqm
	 EFzUDFpxKxWobAh9RXqsPe8JdcyjLkP42EVEN2kmIsDNshYb7xt4gE8eu6JIvR++xk
	 CGnU2TCjnoTVg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 0/4] bpf: verifier: Improve state pruning for scalar registers
Date: Mon,  2 Feb 2026 02:44:02 -0800
Message-ID: <20260202104414.3103323-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves BPF verifier state pruning by relaxing scalar ID
equivalence requirements. Scalar register IDs are used to track
relationships between registers for bounds propagation. However, once
an ID becomes "singular" (only one register/stack slot carries it), it
can no longer participate in bounds propagation and becomes stale.
These stale IDs can prevent pruning of otherwise equivalent states.

The series addresses this in four patches:

Patch 1: Assign IDs on stack fills to ensure stack slots have IDs
before being read into registers, preparing for the singular ID
clearing in patch 2.

Patch 2: Clear IDs that appear only once before caching, as they cannot
contribute to bounds propagation.

Patch 3: Relax maybe_widen_reg() to only compare value-tracking fields
(bounds, tnum, var_off) rather than also requiring ID matches. Two
scalars with identical value constraints but different IDs represent
the same abstract value and don't need widening.

Patch 4: Relax scalar ID equivalence in state comparison by treating
rold->id == 0 as "independent". If the old state didn't rely on ID
relationships for a register, any linking in the current state only
adds constraints and is safe to accept for pruning.

I ran veristat on BPF programs from sched_ext, meta's internal programs,
and on selftest programs, showing programs with insn diff > 5%:

Scx Progs
File                Program              States (A)  States (B)  States (DIFF)  Insns (A)  Insns (B)  Insns    (DIFF)
------------------  -------------------  ----------  ----------  -------------  ---------  ---------  ---------------
scx_rusty.bpf.o     rusty_set_cpumask           320         230  -90 (-28.12%)       4478       3259  -1219 (-27.22%)
scx_bpfland.bpf.o   bpfland_select_cpu           55          49   -6 (-10.91%)        691        618    -73 (-10.56%)
scx_beerland.bpf.o  beerland_select_cpu          27          25    -2 (-7.41%)        320        295     -25 (-7.81%)
scx_p2dq.bpf.o      p2dq_init                   265         250   -15 (-5.66%)       3423       3233    -190 (-5.55%)
scx_layered.bpf.o   layered_enqueue            1461        1386   -75 (-5.13%)      14541      13792    -749 (-5.15%)

FB Progs
File          Program              States (A)  States (B)  States  (DIFF)  Insns (A)  Insns (B)  Insns    (DIFF)
------------  -------------------  ----------  ----------  --------------  ---------  ---------  ---------------
bpf007.bpf.o  bpfj_free                  1726        1342  -384 (-22.25%)      25671      19096  -6575 (-25.61%)
bpf041.bpf.o  armr_net_block_init       22373       20411  -1962 (-8.77%)     651697     602873  -48824 (-7.49%)
bpf227.bpf.o  layered_quiescent            28          26     -2 (-7.14%)        365        340     -25 (-6.85%)
bpf248.bpf.o  p2dq_init                   263         248    -15 (-5.70%)       3370       3159    -211 (-6.26%)
bpf254.bpf.o  p2dq_init                   263         248    -15 (-5.70%)       3388       3177    -211 (-6.23%)
bpf241.bpf.o  p2dq_init                   264         249    -15 (-5.68%)       3428       3240    -188 (-5.48%)
bpf230.bpf.o  p2dq_init                   287         271    -16 (-5.57%)       3666       3431    -235 (-6.41%)
bpf251.bpf.o  lavd_cpu_offline            321         316     -5 (-1.56%)       6221       5891    -330 (-5.30%)
bpf251.bpf.o  lavd_cpu_online             321         316     -5 (-1.56%)       6219       5889    -330 (-5.31%)

Selftest Progs
File                                Program            States (A)  States (B)  States (DIFF)  Insns (A)  Insns (B)  Insns    (DIFF)
----------------------------------  -----------------  ----------  ----------  -------------  ---------  ---------  ---------------
verifier_iterating_callbacks.bpf.o  test2                       4           2   -2 (-50.00%)         29         18    -11 (-37.93%)
verifier_iterating_callbacks.bpf.o  test3                       4           2   -2 (-50.00%)         31         19    -12 (-38.71%)
strobemeta_bpf_loop.bpf.o           on_event                  318         221  -97 (-30.50%)       3938       2755  -1183 (-30.04%)
bpf_qdisc_fq.bpf.o                  bpf_fq_dequeue            133         105  -28 (-21.05%)       1686       1385   -301 (-17.85%)
iters.bpf.o                         delayed_read_mark           6           5   -1 (-16.67%)         60         46    -14 (-23.33%)
arena_strsearch.bpf.o               arena_strsearch           107         106    -1 (-0.93%)       1394       1258    -136 (-9.76%)

Puranjay Mohan (4):
  bpf: verifier: Assign ids on stack fills
  bpf: verifier: Clear singular ids for scalars
  bpf: verifier: relax maybe_widen_reg() constraints
  bpf: verifier: Relax scalar id equivalence for state pruning

 include/linux/bpf_verifier.h                  |   7 +-
 kernel/bpf/verifier.c                         | 169 ++++++++++++++++--
 .../selftests/bpf/progs/verifier_scalar_ids.c |   8 +-
 3 files changed, 160 insertions(+), 24 deletions(-)


base-commit: 4bebb99140c7b6ee6d894c40557f938804fa8693
-- 
2.47.3

