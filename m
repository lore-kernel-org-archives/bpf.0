Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A7132C3D
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044307; cv=none; b=MH+akyof7bm4HgIPtTFXv2WvfFbFLr47XvySIxeeyWwZHKIXInSyE/ZKKfPzOfKUBRsWDM+bqJpDVvMA/SmKtx7j3jPdUkj+VZTBS1MZkFrWxOJEjsC7DZsZq/xV77LYpUQo6jWusC3O8Szc10mfLhHvR9/2RtOION2IMNFQB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044307; c=relaxed/simple;
	bh=4VrMmMAYNdBgObbCahOfUiD5b6XTUkULO1Ntnstnzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHILdrIMbqdP874UDXOL9OVwJ4NdYhbUgeBwkhGxgtpQntAw6Mde5QRqkiIayFk3wvy2ip8vprWYWbtIcw+12OY4Txn8RAim6EUizxbmZqRiiaLOsnxPZg/0aNoPwuImRx7PNYpJihlH46IClieT0qVLXs4l5r1NH3UNOKBqKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWKm1HH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWKm1HH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156CC433F1;
	Thu, 21 Mar 2024 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044307;
	bh=4VrMmMAYNdBgObbCahOfUiD5b6XTUkULO1Ntnstnzr0=;
	h=From:To:Cc:Subject:Date:From;
	b=iWKm1HH/THdwrAf5V7GFhrEUTktAyoZNfeozzOSKIvlt+U1rNUM5VigtoYhKV0PCX
	 D+DIcPqdWZPLAzM68y7Vm6r6wgAF+iDcXHYKo9Mw4xhQ7h4vGz4bwBI01Lb7eZPGOZ
	 a4eaZhNG6EAnoR8FlCWo9qW+VbSmhW6F1zDjpjUsVVOpVwr/6em80gZz8eG/B9ieWA
	 MPfeeK0ds7NR89N8IZ+6v89Qny2KBslgJMKpywmGIK1y1jc+LvlzuK9mkxTp21fmu0
	 DYdyEXzR8UNC+zzX9Bjp5XzpoDPt4sXydrQZ4deQh4eRZ81/RFrP/C2OO8KyycSta+
	 j4DTIZuGqRvrQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: peterz@infradead.org,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/3] Inline two LBR-related helpers
Date: Thu, 21 Mar 2024 11:04:58 -0700
Message-ID: <20240321180501.734779-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement inlining of bpf_get_branch_snapshot() BPF helper using generic BPF
assembly approach.

Also inline bpf_get_smp_processor_id() BPF helper but using
architecture-specific assembly code in x86-64 JIT compiler, given getting CPU
ID is highly architecture-specific.

These two helpers are on a criticl direct path to grabbing LBR records from
BPF program and inlining them help save 3 LBR records in PERF_SAMPLE_BRANCH_ANY
mode.

Just to give some visual idea of the effect of these changes (and inlining of
kprobe_multi_link_prog_run() posted as a separte patch) based on retsnoop's
LBR output (with --lbr=any flag). I only show "wasted" records that are needed
to go from when some event happened (kernel function return in this case), to
triggering BPF program that captures LBR *the very first thing* (after getting
CPU ID to get a temporary buffer).

There are still ways to reduce number of "wasted" records further, this is
a problem that requires many small and rather independent steps.

fentry mode
===========

BEFORE
------
  [#10] __sys_bpf+0x270                          ->  __x64_sys_bpf+0x18
  [#09] __x64_sys_bpf+0x1a                       ->  bpf_trampoline_6442508684+0x7f
  [#08] bpf_trampoline_6442508684+0x9c           ->  __bpf_prog_enter_recur+0x0
  [#07] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
  [#06] migrate_disable+0x37                     ->  __bpf_prog_enter_recur+0xe
  [#05] __bpf_prog_enter_recur+0x43              ->  bpf_trampoline_6442508684+0xa1
  [#04] bpf_trampoline_6442508684+0xad           ->  bpf_prog_dc54a596b39d4177_fexit1+0x0
  [#03] bpf_prog_dc54a596b39d4177_fexit1+0x32    ->  bpf_get_smp_processor_id+0x0
  [#02] bpf_get_smp_processor_id+0xe             ->  bpf_prog_dc54a596b39d4177_fexit1+0x37
  [#01] bpf_prog_dc54a596b39d4177_fexit1+0xe0    ->  bpf_get_branch_snapshot+0x0
  [#00] bpf_get_branch_snapshot+0x13             ->  intel_pmu_snapshot_branch_stack+0x0

AFTER
-----
  [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
  [#06] __x64_sys_bpf+0x1a                       ->  bpf_trampoline_6442508829+0x7f
  [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_recur+0x0
  [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x0
  [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_recur+0xe
  [#02] __bpf_prog_enter_recur+0x43              ->  bpf_trampoline_6442508829+0xa1
  [#01] bpf_trampoline_6442508829+0xad           ->  bpf_prog_dc54a596b39d4177_fexit1+0x0
  [#00] bpf_prog_dc54a596b39d4177_fexit1+0x101   ->  intel_pmu_snapshot_branch_stack+0x0

multi-kprobe mode
=================

BEFORE
------
  [#14] __sys_bpf+0x270                          ->  arch_rethook_trampoline+0x0
  [#13] arch_rethook_trampoline+0x27             ->  arch_rethook_trampoline_callback+0x0
  [#12] arch_rethook_trampoline_callback+0x31    ->  rethook_trampoline_handler+0x0
  [#11] rethook_trampoline_handler+0x6f          ->  fprobe_exit_handler+0x0
  [#10] fprobe_exit_handler+0x3d                 ->  rcu_is_watching+0x0
  [#09] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x42
  [#08] fprobe_exit_handler+0xb4                 ->  kprobe_multi_link_exit_handler+0x0
  [#07] kprobe_multi_link_exit_handler+0x4       ->  kprobe_multi_link_prog_run+0x0
  [#06] kprobe_multi_link_prog_run+0x2d          ->  migrate_disable+0x0
  [#05] migrate_disable+0x37                     ->  kprobe_multi_link_prog_run+0x32
  [#04] kprobe_multi_link_prog_run+0x58          ->  bpf_prog_2b455b4f8a8d48c5_kexit+0x0
  [#03] bpf_prog_2b455b4f8a8d48c5_kexit+0x32     ->  bpf_get_smp_processor_id+0x0
  [#02] bpf_get_smp_processor_id+0xe             ->  bpf_prog_2b455b4f8a8d48c5_kexit+0x37
  [#01] bpf_prog_2b455b4f8a8d48c5_kexit+0x82     ->  bpf_get_branch_snapshot+0x0
  [#00] bpf_get_branch_snapshot+0x13             ->  intel_pmu_snapshot_branch_stack+0x0

AFTER
-----
  [#10] __sys_bpf+0xdfc                          ->  arch_rethook_trampoline+0x0
  [#09] arch_rethook_trampoline+0x27             ->  arch_rethook_trampoline_callback+0x0
  [#08] arch_rethook_trampoline_callback+0x31    ->  rethook_trampoline_handler+0x0
  [#07] rethook_trampoline_handler+0x6f          ->  fprobe_exit_handler+0x0
  [#06] fprobe_exit_handler+0x3d                 ->  rcu_is_watching+0x0
  [#05] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x42
  [#04] fprobe_exit_handler+0xb4                 ->  kprobe_multi_link_exit_handler+0x0
  [#03] kprobe_multi_link_exit_handler+0x31      ->  migrate_disable+0x0
  [#02] migrate_disable+0x37                     ->  kprobe_multi_link_exit_handler+0x36
  [#01] kprobe_multi_link_exit_handler+0x5c      ->  bpf_prog_2b455b4f8a8d48c5_kexit+0x0
  [#00] bpf_prog_2b455b4f8a8d48c5_kexit+0xa3     ->  intel_pmu_snapshot_branch_stack+0x0


For default --lbr mode (PERF_SAMPLE_BRANCH_ANY_RETURN), interestingly enough,
multi-kprobe is *less* wasteful (by one function call):

fentry mode
===========

BEFORE
------
  [#04] __sys_bpf+0x270                          ->  __x64_sys_bpf+0x18
  [#03] __x64_sys_bpf+0x1a                       ->  bpf_trampoline_6442508684+0x7f
  [#02] migrate_disable+0x37                     ->  __bpf_prog_enter_recur+0xe
  [#01] __bpf_prog_enter_recur+0x43              ->  bpf_trampoline_6442508684+0xa1
  [#00] bpf_get_smp_processor_id+0xe             ->  bpf_prog_dc54a596b39d4177_fexit1+0x37

AFTER
-----
  [#03] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
  [#02] __x64_sys_bpf+0x1a                       ->  bpf_trampoline_6442508829+0x7f
  [#01] migrate_disable+0x37                     ->  __bpf_prog_enter_recur+0xe
  [#00] __bpf_prog_enter_recur+0x43              ->  bpf_trampoline_6442508829+0xa1

multi-kprobe mode
=================

BEFORE
------
  [#03] __sys_bpf+0x270                          ->  arch_rethook_trampoline+0x0
  [#02] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x42
  [#01] migrate_disable+0x37                     ->  kprobe_multi_link_prog_run+0x32
  [#00] bpf_get_smp_processor_id+0xe             ->  bpf_prog_2b455b4f8a8d48c5_kexit+0x37

AFTER
-----
  [#02] __sys_bpf+0xdfc                          ->  arch_rethook_trampoline+0x0
  [#01] rcu_is_watching+0x17                     ->  fprobe_exit_handler+0x42
  [#00] migrate_disable+0x37                     ->  kprobe_multi_link_exit_handler+0x36

Andrii Nakryiko (3):
  bpf: make bpf_get_branch_snapshot() architecture-agnostic
  bpf: inline bpf_get_branch_snapshot() helper
  bpf,x86: inline bpf_get_smp_processor_id() on x86-64

 arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
 kernel/bpf/verifier.c       | 37 +++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c    |  4 ----
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.43.0

