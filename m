Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293C3E764C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392147; cv=none; b=DytLvJk+GL7ZXZyUxEQD76sWj3bc6eiU1txH/u6HzKa7mqcd3oXQ7x89uetfP/PiPYO0c9E82EL/Qp4LMEYH2ilInJoJT5CZtclrd8S7EBWJo3PijilxrpzThrdBoV9qPUIJadwGhXPaAntL0HFPuHL2vlYlFCwZCBwJ2LfRf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392147; c=relaxed/simple;
	bh=TMf4L6EYM1qs1Erd/XrvCnOaNfETZAZH+a6a9gHs124=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BviUYFY+hHft06mKNPPzqKyZxodJA5wYnNLx2HWPTrB3mcJGlD4/ufbQ7Vs7neuDoF2BheHx6pVeGz4YI/VoqTTPfNcDhOW/UlcM2YwiahpA892VnkFxDTBj8/qlwuvum6zI8UJ6wJJZ3JeewWnmNZQmTBDC0v/WJ9yJ+aZdxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2M5hThj; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2M5hThj"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso590195a12.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392145; x=1792996945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5XFXarYDugU15GvRn4heGPbOvz9Qo8H6YKk5rO58RE=;
        b=c2M5hThjdSAFxuUT1kbDQdYoSiYgR51kAVaElp35pY6C6OIiN+j4IfwpxH+MyBrY5m
         yFSdvgfaeIUGYFYInBsePL2qqDCRKnHi/Px2Hd72UZJGbyJWLiuX/dY7BMRa7/U/X+et
         /2fFS0J26z6ad8TtkflMqIAmLKFz7a92Zr2Rhn+WBzUGjninEZ0nZmAmJDzP6Pnr8+kX
         beT/fqB7iECCVKcQtlcU0eK70eU69pyU5PCnerCpVD0wHFd10WOMufxwf670/zeQ6pWR
         xvgIJEnAL9RoOZ/0JTor9dlrcodOjf5BerpbuhjlemZLizAsjTam8dh54I1Wm+lZZ4uE
         0esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392145; x=1792996945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5XFXarYDugU15GvRn4heGPbOvz9Qo8H6YKk5rO58RE=;
        b=ipNZ0GLqm8rMp6mLdX5fegKXaRfR6K1i+aKqv5zXbzAUUsNEVCs7PCj+psbCIm5gD9
         BhFDLdWnAh6GEp0nT3PGQyo6/BpkSpb3ZMAExUpu7C51MK4/4JMkiwhXtdETs+DTIDBq
         kLjkwilvW3d5qfynC0WpxxBsgIP1ve9jReIi3DB6defggdnP93wDnN7aOkGuR9uFikGL
         U8B4crym+YS0/mKPhJnr+skvmIf0lhB3bkjgo6TIObFaqaQnXnS7fPE+i8bqMs5rinja
         92/6n4UaF/edI0Eyxs5tmUbzk6/wjGADitAx9FChTuBSVhG8kxaTKAkAdk9HogkxuZer
         2Qfg==
X-Gm-Message-State: AFq9FYJqZQ54RRqRp+qDeBHytpdCZIHY+9FD9RVr+mVq+zIeq+TjXYxu
	0yxXwPdc3IakBggYh71J6vNfVpXA1EseOmfT3RicA8GqjcNnqotPg9Do
X-Gm-Gg: AYBFou3L65e4ZDjmteiE9xZY7vtbF8+YjgUhdTQynnXzZB3G2ZZe32FYiae7ydRgRjT
	VkxWFNLcwZWBsWFPpXgC17PY3Ce8BpYZyv/cluphURpkmL1mmXkrCLzGgiOT6IcbW0OIeHep3s/
	MWZoKPXlJsMChd2AxdGQBwHVoWX4X3lbZ7ftkZ803NwzDzuWJ5VXV7cm5CIv31lrxtomHcX3UQ0
	SuMD/wUqVzU4UJcVPDc+Mt/A2oqt55kbvQqiq0UVTqZmc4eNSlmT9onVQu/gmVCBuGoWXLM2QwW
	RTlNfAIVCnJsHiTG2qvIRaNzgadSEak+ly4c1Fn2eq3VZerEF0NQzdivdNjSzE7Gk7xviUpoz67
	KjAClVg6xCKpXA+bB5jItVCCYJa3iKEZXZUI+FZeSR6qXmBGbbEtNx9mDC7HJtFylN+oD0TP4N7
	1qAbGCm+l0ZnOVCrym/3bJZ4W/AJoPcINcWyFN3XmDAARme5zcsG7Pd4pqiYKZOvyjnLLZ2KZT0
	WvXZ/7mEZftq8NabGv0j9u1aYVU/vu1dBWJax5npAWLTiRQN7RQOCMnh5h2wpc+FRtCNA==
X-Received: by 2002:a05:6a20:e30b:b0:3e1:c6e6:d101 with SMTP id adf61e73a8af0-3e225f7674emr5446422637.29.1792392145181;
        Sun, 18 Oct 2026 23:42:25 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:3fed:6938:3f14:63eb:c479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a3a592sm3688960a12.30.2026.10.18.23.42.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:42:24 -0700 (PDT)
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
	zhao1.liu@intel.com,
	tim.c.chen@linux.intel.com,
	lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 bpf-next 0/5] BPF-based per-cgroup NUMA balancing mode selection
Date: Mon, 19 Oct 2026 14:41:52 +0800
Message-ID: <20261019064157.29885-1-laoar.shao@gmail.com>
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
become a critical performance issue, which made us reconsider enabling NUMA
balancing to address it.

Enabling NUMA balancing globally is still not acceptable since it can
introduce latency spikes for latency-sensitive workloads. What we need is
to choose per workload whether NUMA balancing runs at all, and which mode
it runs in. A latency-sensitive service wants NUMA balancing disabled,
while a batch service wants its PMEM-resident memory promoted when hot
without paying for scheduler-driven migration. No single global setting
serves both.

The Design
==========

This series introduces the fine-grained per-cgroup NUMA balancing
control. It grows out of Tejun's suggestion to store the existing
NUMA_BALANCING_* bitmask per cgroup and expose it through BPF kfuncs.
cgroup::numab_mode holds the request: NUMAB_FOLLOW_SYSTEM (-1) defers
to the global sysctl state, anything else is a bitmask.
bpf_numab_set_mode() writes a request, bpf_numab_get_mode() reads the
combined request of the cgroup and of every ancestor back. The hot
paths walk the same chain at read time behind a static key, so while no
cgroup makes a request the overhead is one patched-out branch.

An opt-out wins and binds the subtree: a DISABLED request anywhere in
the chain opts the cgroup's tasks out entirely. Otherwise the requested
bits OR together and the kernel reads them independently, the way
kernel.numa_balancing reads them, so a combined NORMAL|TIERING engages
both modes. A DISABLED request only speaks for the cgroup's tasks,
never for its memory, which follows the remaining requests of its
ancestors.

The cost of the additive combination is that an ancestor cannot cap
tiering short of a full opt-out: a descendant's TIERING request
re-engages promotion for its own memory, and promotion is the mode that
consumes the shared fast tier.

The readback contract is worth spelling out: bpf_numab_get_mode()
returns the combined request of the cgroup and its ancestors, and the
kernel reads it the same way it reads a single request, each bit
independently as kernel.numa_balancing does, so a combined
NORMAL|TIERING engages both modes. When any cgroup in the chain makes a
request, the value read back is the mode in effect for the cgroup's tasks;
when none does, the readback is NUMAB_FOLLOW_SYSTEM (-1) and the sysctl
decides. The answer speaks for the cgroup's tasks only: its memory follows
the remaining requests of its chain when it opts out, and that folio-side
view is not exposed by the kfuncs. These are deliberate simplifications;
both can be revisited if callers turn out to need them.

The sysctl's own documentation is untouched; the override is documented
where it lives, in the CONFIG_BPF_NUMAB Kconfig help and the kfunc docs.

The override was measured with schbench, 384 workers, on a two-node
384-core machine. Whatever kernel.numa_balancing is set to, a cgroup
request puts the cgroup at the throughput of the equivalent
system-wide setting, within a fraction of a percent: the override
itself costs nothing measurable, performance follows the effective
state alone. The two states themselves differ by less than a percent
under this load.

Changes
=======

RFC v2->RFC v3:
- The struct_ops interface is replaced by two kfuncs, following
  Tejun's suggestion.
- Improve on the function naming and simplify the code (David)

RFC v2: https://lwn.net/Articles/1099962/

RFC v1->RFC v2:
v1 keyed the hook on the memory cgroup and temporarily embedded the cgroup
id into the struct-ops value, because the cgroup struct_ops integration was
still under development. v2 attaches through the cgroup struct_ops support
that has since landed in bpf-next, keys the task surface on the task's
cgroup and the memory surface on the folio's memcg, and adds the
memory-tiering mode alongside enable and disable.

RFC v1: https://lwn.net/Articles/1054030/

Yafang Shao (5):
  sched: fix stale get_pref_llc() stub for !CONFIG_SCHED_CACHE
  sched: use static_branch_likely() for the NUMA balancing tick check
  sched: add helpers for numa balancing
  sched: add BPF-based per-cgroup NUMA balancing mode selection
  selftests/bpf: add tests for the numab kfuncs

 include/linux/cgroup-defs.h                   |  10 +
 include/linux/sched/numa_balancing.h          | 149 ++++++++++++
 init/Kconfig                                  |  20 ++
 kernel/cgroup/cgroup.c                        |  14 ++
 kernel/sched/bpf_numab.c                      | 195 +++++++++++++++
 kernel/sched/build_policy.c                   |   4 +
 kernel/sched/fair.c                           |  33 +--
 kernel/sched/sched.h                          |   1 -
 mm/memory-tiers.c                             |   9 +-
 mm/mempolicy.c                                |   3 +-
 mm/migrate.c                                  |   7 +-
 mm/vmscan.c                                   |   6 +-
 .../selftests/bpf/prog_tests/bpf_numab.c      | 227 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_numab.c |  32 +++
 14 files changed, 681 insertions(+), 29 deletions(-)
 create mode 100644 kernel/sched/bpf_numab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_numab.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_numab.c

-- 
2.52.0

