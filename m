Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FD2D77E6
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481881; cv=none; b=sKghGqW0f8cW4ung2d37oFfspEifrHaDdpBNefncZLgQH8JelJAmX1Jf5W3kekqUfiv4vylOZOuhj4hqMsHCttgvrvS2M08ejfNQXRxJS0VnyFoGmsK8OEG4pvW4Ihomm3mVyqwQaoMZ56f/4rSz4J684fPwDyaWJLFGpAB8pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481881; c=relaxed/simple;
	bh=uH6zNclT2lr76LZf6gieRxsaCZrY1lov28UehdMLy00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9IBA2KHUQd0CoRhQUxk0Q/rSYEkn+dTozZ+29D+Hl4lvE2kXpZj8O6csHuiglyRb5JMYzKxUV3dNo628xq5ZAXfE/WAh4brgLb6JW94L2L35UdJjmhze/dQDMUOReZV2dhRssMkCDf/WY22Rltkm8IsEGDl/ylJAPZknyJERfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDArK4eI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDArK4eI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZtX5uZ9ZH0+BFuE+o4DynO7SCqFW/EqynrzAnGfryk=;
	b=qDArK4eIdzVKhsri5bR/ay3++0Jqq9PUQS9qUgaBHZpgNbAaxMzo+A2iF1mHCIKzmbheWd
	hjfLveEn9k5Fi4VolNAHDeyGuiitTRzbSUw4VMzvJtHpMeor79OaHH0S9gnprUPcgvwv4N
	O4lXpMFvQYCBJJs4xRLgOag0R+mbPO4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 00/17] mm: BPF OOM
Date: Mon, 26 Jan 2026 18:44:03 -0800
Message-ID: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset adds an ability to customize the out of memory
handling using bpf.

It focuses on two parts:
1) OOM handling policy,
2) PSI-based OOM invocation.

The idea to use bpf for customizing the OOM handling is not new, but
unlike the previous proposal [1], which augmented the existing task
ranking policy, this one tries to be as generic as possible and
leverage the full power of the modern bpf.

It provides a generic interface which is called before the existing OOM
killer code and allows implementing any policy, e.g. picking a victim
task or memory cgroup or potentially even releasing memory in other
ways, e.g. deleting tmpfs files (the last one might require some
additional but relatively simple changes).

The past attempt to implement memory-cgroup aware policy [2] showed
that there are multiple opinions on what the best policy is.  As it's
highly workload-dependent and specific to a concrete way of organizing
workloads, the structure of the cgroup tree etc, a customizable
bpf-based implementation is preferable over an in-kernel implementation
with a dozen of sysctls.

The second part is related to the fundamental question on when to
declare the OOM event. It's a trade-off between the risk of
unnecessary OOM kills and associated work losses and the risk of
infinite trashing and effective soft lockups.  In the last few years
several PSI-based userspace solutions were developed (e.g. OOMd [3] or
systemd-OOMd [4]). The common idea was to use userspace daemons to
implement custom OOM logic as well as rely on PSI monitoring to avoid
stalls. In this scenario the userspace daemon was supposed to handle
the majority of OOMs, while the in-kernel OOM killer worked as the
last resort measure to guarantee that the system would never deadlock
on the memory. But this approach creates additional infrastructure
churn: userspace OOM daemon is a separate entity which needs to be
deployed, updated, monitored. A completely different pipeline needs to
be built to monitor both types of OOM events and collect associated
logs. A userspace daemon is more restricted in terms on what data is
available to it. Implementing a daemon which can work reliably under a
heavy memory pressure in the system is also tricky.

This patchset includes the code, tests and many ideas from the patchset
of JP Kobryn, which implemented bpf kfuncs to provide a faster method
to access memcg data [5].

[1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@bytedance.com/
[2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
[3]: https://github.com/facebookincubator/oomd
[4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
[5]: https://lkml.org/lkml/2025/10/15/1554

---

v3:
  1) Replaced bpf_psi struct ops with a tracepoint in psi_avgs_work() (Tejun H.)
  2) Updated bpf_oom struct ops:
     - removed bpf_oom_ctx, passing bpf_struct_ops_link instead (by Alexei S.)
     - removed handle_cgroup_offline callback.
  3) Updated kfuncs:
     - bpf_out_of_memory() dropped constraint_text argument (by Michal H.)
     - bpf_oom_kill_process() added check for OOM_SCORE_ADJ_MIN.
  4) Libbpf: updated bpf_map__attach_struct_ops_opts to use target_fd. (by Alexei S.)

v2:
  1) A single bpf_oom can be attached system-wide and a single bpf_oom per memcg.
     (by Alexei Starovoitov)
  2) Initial support for attaching struct ops to cgroups (Martin KaFai Lau,
     Andrii Nakryiko and others)
  3) bpf memcontrol kfuncs enhancements and tests (co-developed by JP Kobryn)
  4) Many mall-ish fixes and cleanups (suggested by Andrew Morton, Suren Baghdasaryan,
     Andrii Nakryiko and Kumar Kartikeya Dwivedi)
  5) bpf_out_of_memory() is taking u64 flags instead of bool wait_on_oom_lock
     (suggested by Kumar Kartikeya Dwivedi)
  6) bpf_get_mem_cgroup() got KF_RCU flag (suggested by Kumar Kartikeya Dwivedi)
  7) cgroup online and offline callbacks for bpf_psi, cgroup offline for bpf_oom

v1:
  1) Both OOM and PSI parts are now implemented using bpf struct ops,
     providing a path the future extensions (suggested by Kumar Kartikeya Dwivedi,
     Song Liu and Matt Bobrowski)
  2) It's possible to create PSI triggers from BPF, no need for an additional
     userspace agent. (suggested by Suren Baghdasaryan)
     Also there is now a callback for the cgroup release event.
  3) Added an ability to block on oom_lock instead of bailing out (suggested by Michal Hocko)
  4) Added bpf_task_is_oom_victim (suggested by Michal Hocko)
  5) PSI callbacks are scheduled using a separate workqueue (suggested by Suren Baghdasaryan)

RFC:
  https://lwn.net/ml/all/20250428033617.3797686-1-roman.gushchin@linux.dev/


JP Kobryn (1):
  bpf: selftests: add config for psi

Roman Gushchin (16):
  bpf: move bpf_struct_ops_link into bpf.h
  bpf: allow attaching struct_ops to cgroups
  libbpf: fix return value on memory allocation failure
  libbpf: introduce bpf_map__attach_struct_ops_opts()
  bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
  mm: define mem_cgroup_get_from_ino() outside of CONFIG_SHRINKER_DEBUG
  mm: introduce BPF OOM struct ops
  mm: introduce bpf_oom_kill_process() bpf kfunc
  mm: introduce bpf_out_of_memory() BPF kfunc
  mm: introduce bpf_task_is_oom_victim() kfunc
  bpf: selftests: introduce read_cgroup_file() helper
  bpf: selftests: BPF OOM struct ops test
  sched: psi: add a trace point to psi_avgs_work()
  sched: psi: add cgroup_id field to psi_group structure
  bpf: allow calling bpf_out_of_memory() from a PSI tracepoint
  bpf: selftests: PSI struct ops test

 MAINTAINERS                                   |   2 +
 include/linux/bpf-cgroup-defs.h               |   6 +
 include/linux/bpf-cgroup.h                    |  16 ++
 include/linux/bpf.h                           |  10 +
 include/linux/bpf_oom.h                       |  46 ++++
 include/linux/memcontrol.h                    |   4 +-
 include/linux/oom.h                           |  13 +
 include/linux/psi_types.h                     |   4 +
 include/trace/events/psi.h                    |  27 ++
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/bpf_struct_ops.c                   |  77 +++++-
 kernel/bpf/cgroup.c                           |  46 ++++
 kernel/bpf/verifier.c                         |   5 +
 kernel/sched/psi.c                            |   7 +
 mm/Makefile                                   |   2 +-
 mm/bpf_oom.c                                  | 192 +++++++++++++
 mm/memcontrol.c                               |   2 -
 mm/oom_kill.c                                 | 202 ++++++++++++++
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |  22 +-
 tools/lib/bpf/libbpf.h                        |  14 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |  45 +++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   3 +
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/test_oom.c       | 256 ++++++++++++++++++
 .../selftests/bpf/prog_tests/test_psi.c       | 225 +++++++++++++++
 tools/testing/selftests/bpf/progs/test_oom.c  | 111 ++++++++
 tools/testing/selftests/bpf/progs/test_psi.c  |  90 ++++++
 29 files changed, 1412 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 include/trace/events/psi.h
 create mode 100644 mm/bpf_oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

-- 
2.52.0

