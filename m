Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AD29ACDB
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085356; cv=none; b=qio/FUa603cIE20zOjt7NNy/hRPoP5zPHKMKXrSODv1rdqrQhd1s4AZBAE1D8DiwYb/5D3nfsCIYY4pwliFV3huuLe8fuD6Oae44bI+a6MSAE7tyeUp3Hb44xIlWsSmbga8QrJFS9VXK4KKcs6c8rsaskIxx9rJKlJkE8uFOuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085356; c=relaxed/simple;
	bh=Q1Eq2qfFQoHUTFWYXna6NWioHHd2bkYprMlCQdaIc2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blqe3+qYrotByPitT9hzTIyjTG08SUvFMjDRF5MNd4wAJbrgUiz0VjQb2me3dn7+jl279siYLFfqUFXxySkG4/8dmbZCxVvSu2MzKDNK+9JKZUgLezVx9IudiqRNjT0DkjCdcCLqQ8hggY7TKmclh4ansUR3wQ+I0moIUcfFJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anQjkY1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anQjkY1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4AFC116C6;
	Tue,  3 Feb 2026 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085355;
	bh=Q1Eq2qfFQoHUTFWYXna6NWioHHd2bkYprMlCQdaIc2g=;
	h=From:To:Cc:Subject:Date:From;
	b=anQjkY1cjLGB4u3f2O3avsf2or1qwudByB9/zOPmB8Jv0lNrUOx0nWe+Chyrra18e
	 nNuZYESlYeS9IU2ZAvl1UOfdafOb25B4z1dD32D1GJDwZNR+mOedYx8t7LtRA+D8ZB
	 DljRu/puCXRTq4MTtJtpZds7w3lbS6KIwjYMVsuE+veQu9HCfTnhN4ZnT3/UHkGnkq
	 ZWQoNr/ZhN23Xg/vBTaO5py5l8wR8/oBv6JFEsTKczA50vyW2X+SZbgjO7lKnYL3wT
	 8Qwk5kVRtunXtjNR1gDz+aqA7oduYFZlg+Rx1u3YqV4soxLxllHrOO/krH6ys4iyIu
	 tokriar8Nfiqg==
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
Subject: [PATCH bpf-next v2 0/5] bpf: verifier: Improve state pruning for scalar registers
Date: Mon,  2 Feb 2026 18:22:23 -0800
Message-ID: <20260203022229.1630849-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V1: https://lore.kernel.org/all/20260202104414.3103323-1-puranjay@kernel.org/
Changes in V2:
- Collected acked by Eduard
- Removed some unnecessary comments
- Added a selftest for id=0 equivalence in Patch 5

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

Patch 5: Add a selftest to show the exact case being handled by Patch 4

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

Puranjay Mohan (5):
  bpf: verifier: Assign ids on stack fills
  bpf: verifier: Clear singular ids for scalars
  bpf: verifier: relax maybe_widen_reg() constraints
  bpf: verifier: Relax scalar id equivalence for state pruning
  selftests: bpf: Add a test for ids=0

 include/linux/bpf_verifier.h                  |   7 +-
 kernel/bpf/verifier.c                         | 162 ++++++++++++++++--
 .../selftests/bpf/progs/verifier_scalar_ids.c |  53 +++++-
 3 files changed, 198 insertions(+), 24 deletions(-)


base-commit: 6b95cc562de2889a9333843dda073ba875f9e808
-- 
2.47.3

