Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36C421EFB
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806738; cv=none; b=rnbiLlnxxqpVyAK+yv52C2kFWleHUd9txYjAq7oszygux4xsu1mYrd0ehkxME0X3+4NNSOWcrfB1qKNsJ6A8DBAsQVofeB2Sbc65uSC406xzXUp4Gl0YpPz5OjhPJ+7uAlMI7YYlbfKQWPOg4COcQk+uylh1tkK4Kwf3T/AgTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806738; c=relaxed/simple;
	bh=Z7nW14BwPeLbnkIrxEhbUH7laRhJdISK7ruJlh482mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4BpDTrtrRzPkFU/ZYkH9fG3LcUWPaBXtztsYbhZLoHKzuanWl2EujAsCmuVYkg+M+zyWGi5DzP1XSK+KZPXm28GXR86aOJKMge2aLJDR23DMaWk428RkQ0e9DjAtJRZnBeU3TgPgW+sRhaocD6PDSHtW2XDLDtfNNVgpHEP1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8VRHiHq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8VRHiHq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so637298a12.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806736; x=1792411536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLbm/HnztJlhbsvLEPa7IOES1RKYfU4H2Ro9opKpO1w=;
        b=e8VRHiHqptxnVL7vepBOegj5Tc82qiTIZOB5aq8irRssgr1MBzB7QcGoJa8JBdMrXC
         oSAJDNs2iufKIATXaWnrmZjFRpojH2SaU1wUAcxe3lqmQhgin1CS1Bjp2T95Xvh6A53M
         OnSOvA3wc+xCUmjTmd+LXO/2GjJDtygxuIaQ+jsya4402n9p0PJjHXKs3y9/qAbDj1/O
         5cHR88laVw+Cvjd4emn0mrqAFJoGZ8GPLiPZ5M8eHBAyK+S33g/X0EkieAxvGFL7QMjB
         KrgDxzkgzXshVCdYeuXhvcnWkrQ0uf6hoImkBD2E1RUASaf8SZ2F6szXFMgkfbxLPXgN
         cPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806736; x=1792411536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLbm/HnztJlhbsvLEPa7IOES1RKYfU4H2Ro9opKpO1w=;
        b=0VRjQLPUBzqGU31hzXBhACKudAh97NFs0NM2c6elPzUW7Dwzuct4vnV+IcRvu+m2kt
         xqIroPgrvcFSo3B4iEEKCI/gxSUllfcWbc1rTBy4Um23FQsRO6n5b1OKr/VBe2z8/lht
         1T3vz3dPf3mXOmii4OzDFk9ayPFEMM+N4/SBq9nd+4YG7TpyVtCNZnb/nSCso89oTKFa
         JOwLRQgg2Xfv1UCMdIaDXZNKPOLI03QOJmRTZFB5fylkeiWdTALtjh5LYa9h86R9q1KT
         +CRih/Da3xmCZLtmOPKOM4e6C3hTpTsZuJ5JZdKtiCowfrWoCitnvpgQ+S/yZSj6+P/K
         g9lQ==
X-Gm-Message-State: AFq9FYJOCpYfjsEiwh9zynxRqT0tVIJmysTR8aaWs5Tqdbo6nCwh9Ums
	dcw5y/GtSW4GS0Y8cH20jL+Mkmt6iySwJQlggdkkUsjZTCW4ciOK3Z1A
X-Gm-Gg: AYBFou0oSE+WFiT1lKB/h51VqTIXTwbTFiRgI/mCqm3NKx1xbUkdPqnDBXIiLIfCKpD
	9Kl/ONNDoPvrJW4mPJDmNUA7/SJfU27IwzCvKIPuzBK4BUf1gfGt6HicTY1mT77X/rd1yftcO23
	5wul/fpCrwHC3rAw3iiZI/p3qd1jXl56FaT4ok1jeWkwIFQblIPtfctCFAg8GKVLXq6KqVOvKKz
	3ffbBZpYxezaQjiUVLepQHpi/qhzU/ZnMuisy7O+TvfVg+TjtOxcQmnNdsfJBA/V6v7bqZZOgb1
	Ag3rlnZaURUo5YuYBHB/2+uP0qX9ui9WcVTHpthyvHWEedl6kJfU/5z8g/Kp3DP8A1E6ZxaaO6X
	DYnygSwSovzrSiPHoElcPxdEkvTxUvk49qBvIaE9lG4l15rkCG7QM7oluqf0hWPuHRDwbZ73fCq
	dU5B2MFUszSqjekFzd1c0CBq17kulag92oVdDASelpr06G1piY8eN3t1zmXw5MyreycUtvWGDWI
	Bas5PHfEV42HVSCtmyASIJyc4HfS29qBeoSgiD7jd9lNQ==
X-Received: by 2002:a17:90b:3b84:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3ab3a4871e5mr7188609a91.7.1791806735133;
        Mon, 12 Oct 2026 05:05:35 -0700 (PDT)
Received: from yafangs-Air ([101.82.170.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm15722454a91.16.2026.10.12.05.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 05:05:33 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/3] BPF-based per-cgroup NUMA balancing mode selection
Date: Mon, 12 Oct 2026 20:04:35 +0800
Message-ID: <20261012120438.52849-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Problem
===========

In our large fleet of Kubernetes-managed servers, NUMA balancing has
been historically disabled globally on each server. With the increasing
deployment of multi-socket AMD EPYC servers, cross-NUMA access has
become a critical performance issue, which made us reconsider.

Enabling NUMA balancing globally is still not acceptable: it increases
the overall system overhead and can introduce latency spikes for
latency-sensitive workloads. What we need is to choose per workload
whether NUMA balancing runs at all, and which mode it runs in. A
latency-sensitive service may want the scheduler's NUMA statistics
without tiering's promotion machinery, while a batch service wants its
PMEM-resident memory promoted when hot without paying for
scheduler-driven migration. No single global switch serves both.

The Design
==========

This series adds a bpf_numab_ops struct_ops which attaches to a
cgroup. The kernel consults the policies of the matching cgroup and of
every ancestor and combines what they return. One policy question, two
surfaces: the kernel passes the task when it acts on a task and the
folio when it acts on a folio; exactly one of the two is set, so a
memory answer cannot be keyed on whoever happens to touch the folio.
A policy can always opt a workload out, so no cgroup is ever forced
into heavier machinery than its own policy asks for. The demotion and
migration-fallback machinery stays global, as it is keyed on
node-level reclaim state rather than on any cgroup's policy.

The hook is designed to be free for everyone who does not use it.
Every call site (scheduler tick, NUMA hinting faults, folio
migration) first tests the cgroup_bpf_enabled() static key of the
new attach type. The key stays off until the first policy is
attached anywhere in the system, so with no policy attached the
added cost is a single patched branch.

The BPF consult comes before the global sched_numa_balancing static key
rather than after it, because the primary use case is a fleet which runs
with global NUMA balancing disabled and enables it per workload: a policy
must be able to turn balancing on for its cgroup while the global switch
stays off.

Once any policy is attached, the key is on for the whole system and
every task pays the walk: a cgroup lookup, a percpu refcount tryget
and an iteration of the pre-aggregated effective array, so the cost
is proportional to the number of policies in the chain rather than
to its depth, plus one trampoline call per policy. This is also why
patch #2 rejects a policy which implements nothing: attaching one
would flip the static key for the whole system and make every task
pay the walk for no effect. The key turns back off when the last
policy is detached.

Measured with schbench (64 worker threads, 30 s per run) on the test
box. Wakeup latency percentiles from the final cumulative window, in
usec:

                            p50  p99
  balancing=0, no policy    15   207
  balancing=0, policy       15   205
  balancing=1, no policy    15   199
  balancing=1, policy       14   201

With a policy attached, wakeup percentiles stay within a few percent
of the no-policy baseline whether the global switch is on or off, and
throughput stays within the benchmark's own run-to-run variance.

On this box the global on and off states are themselves
indistinguishable for this workload, so these numbers isolate the
cost of the hook, not the benefit of the selection; the benefit side
needs multi-node, memory-heavy workloads.

Changes since v1
================

v1 keyed the hook on the memory cgroup and temporarily embedded the cgroup
id into the struct-ops value, because the cgroup struct_ops integration was
still under development. v2 attaches through the cgroup struct_ops support
that has since landed in bpf-next [0], keys the task surface on the task's
cgroup and the memory surface on the folio's memcg, and adds the
memory-tiering mode alongside enable and disable.

This is still an RFC with limited testing. Feedback is welcome.

[0] https://lore.kernel.org/bpf/20260706171918.317102-1-ameryhung@gmail.com/

RFC v1: https://lwn.net/Articles/1054030/

Yafang Shao (3):
  sched: add helpers for numa balancing
  sched: add per-cgroup NUMA balancing mode selection via BPF
  selftests/bpf: add tests for the bpf_numab_ops struct_ops

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |   2 +-
 include/linux/bpf_numab.h                     |  77 ++++++
 include/linux/sched/numa_balancing.h          |  82 ++++++
 kernel/sched/Makefile                         |   5 +
 kernel/sched/bpf_numab.c                      | 164 ++++++++++++
 kernel/sched/fair.c                           |  16 +-
 kernel/sched/sched.h                          |   1 -
 mm/memory-tiers.c                             |   9 +-
 mm/mempolicy.c                                |   7 +-
 mm/migrate.c                                  |   7 +-
 mm/vmscan.c                                   |   6 +-
 .../selftests/bpf/prog_tests/bpf_numab_ops.c  | 250 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_numab_ops.c       |  57 ++++
 14 files changed, 660 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/bpf_numab.h
 create mode 100644 kernel/sched/bpf_numab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_numab_ops.c

-- 
2.52.0

