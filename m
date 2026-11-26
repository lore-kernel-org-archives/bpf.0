Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698024;
	b=LijePJ9U1VHeq+9mvnENwH3KWgx5Qc4BonujOmSl/sDrK7ZbkDBqzDNkKcRYO5cRsBmo
	 0T52F/J9LWcWOf0roFuXR59THFffCQlawIGaTlXM20Ez3aMs5fnuJFWV/hMXRreF/9Anq
	 2kvKhuPjcKMNs9EHKhtUIe8BVQ+95R/LY6FRMmpOkfr6tUvpAbjeYghFB6G7qtGgNwq0N
	 ZKzYC9L1AvyI6cSQ557bw51N1K27MwnKLMscUvZ85ANmsHuwHKgg/aqVU4anjebKQJbqX
	 Y7wq5sJrYUjbohmu5FSHdtX1mTjvKT93R1V5GEygj4fTTWwwZXL3Ev0+bK66hmbmT5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698024;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=/Kf10qZB7UPXUDrWQIBN4qCOuiQbUCmK1+A/fPD+Cms=;
	b=o5ZIausmPWOfka30ua1ewTa15qB+L07D1ZLTGWmYv5n/N4TuccLTllZAG1mnvHFLsth1
	 ZVsUCBoVJEA+GuZbpOBKzsTWHABklQoFFXMdiC19tapzCrsS63i2XdnD7lCLFpWzwClcB
	 zHXonZkRNBbyNlxUeW9bPQ7hO4Ak0hCqJvmoLrGl5xfjAi7fUSxwKNkyA17mnnlVKeNwI
	 r71edD23ayCrBo5Im8wmb7k8x/do7b/1qXxZhnAPWfWTF+ZApci71+jJtLEMVTst6mpFw
	 glkYs6vyR5e833KgJBp8mC6/2PkyA1srqTXTKrOz+Q/ojSIYNRymQ7bre1lm3PC9BPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGiSnSxq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC7606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54AC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGiSnSxq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Kf10qZB7UPXUDrWQIBN4qCOuiQbUCmK1+A/fPD+Cms=;
	b=DGiSnSxqXpFE1+t1SBTzcbpJpFRHHYSyvQTveTMvUOcGfrFaeLRcfynyhFsE+wlsbC6QuC
	9Smq2ZsvHnDg4/jZ0a0FOURJ6G5eTjBgx0gsMIIPaEBj1r3QsXtAaUa1G8TNb+3sP6p8/4
	hj1EV/8DgXB621+W+5cQPGZpHJ9PMlo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-t9XWa9FHNmusyDhPyt9erQ-1; Thu,
 26 Nov 2026 13:00:17 +0000
X-MC-Unique: t9XWa9FHNmusyDhPyt9erQ-1
X-Mimecast-MFC-AGG-ID: t9XWa9FHNmusyDhPyt9erQ_1795698015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87E931800343;
	Thu, 26 Nov 2026 13:00:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD189180054C;
	Thu, 26 Nov 2026 13:00:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 00/18] rv: Add support for BPF monitors
Date: Thu, 26 Nov 2026 13:59:46 +0100
Message-ID: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Extend the rv userspace tool to load BPF monitors, those can be found in
specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
object files including BTF data.

This type of BPF monitors can be generated from rvgen using the -b flag
just like in-kernel monitors and, after manual adaptation, can be built
and run transparently by the rv userspace tool.

Only DA monitors are supported (as they are the only class the rv tool
currenly supports) and the tool aims to work in the same way for both
in-kernel and BPF monitors.

The da_monitor header is adapted to be included directly in BPF programs
and share as much logic as possible.

BPF monitors are implemented purely in BPF and as such require the rv
userspace tool for any operation:
 * listing: find properly formatted objects in specific locations
 * running: load trace handlers for events
 * tracing: read event/errors from the ring buffer

Selftests (make -C tools/verification/rv check) are present to validate
and demonstrate the usage, which is mostly equivalent to the standard rv
tool usage.

Patch 1 adds tracepoints required in a later monitor example.
Patch 2 improves the rv tool selftest reporting.
Patches 3-5 prepare the kernel headers for BPF support.
Patch 6 adds a feature check for tools/build.
Patch 7-11 prepare and add support for BPF monitors in the rv tool.
Patch 12-15 prepare and include BPF monitors examples.
Patch 16 adds support for generating BPF monitors in rvgen.
Patch 17-18 adds BPF selftests (make check) for the rv and rvgen tools.

Changes since V2 [1]:
* Use BPF_MAP_TYPE_TASK_STORAGE for per-task monitors.
* Drop useless relocation removal in Makefile.
* Avoid cast and propagate const to all tracepoints.
* Validate monitor names before running.
* Drop reactors for BPF monitors.
* Use new generic tracepoints for BPF monitors and drop ringbuf.
* Add -E/--errors-only option in the userspace tool.
* Use an OFD lock to determine if monitors are enabled.

Changes since RFC [2]:
* Drop struct_ops integration to favour a BPF-only implementation.
* Implement BPF reactors with a dynamic linker.
* Don't pin programs and maps.
* Improve handler performance when not tracing.

[1] - https://lore.kernel.org/lkml/20261001152042.124445-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260831090524.106845-1-gmonaco@redhat.com

To: linux-trace-kernel@vger.kernel.org
To: bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Viktor Malik <vmalik@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Ogness <john.ogness@linutronix.de>

Gabriele Monaco (17):
  tools/rv: Skip empty pid error in selftest if command failed
  rv: Add wrapper macros for monitor tracepoint definitions
  rv: Propagate const to model strings and tracepoints
  rv: Add generic monitor event tracepoints and BPF kfuncs
  tools/build: Add a feature test for bpftool-btf
  tools/rv: Move argument parsing from in_kernel to utils
  tools/rv: Move monitor trace handling to trace.c
  tools/rv: Implement BPF monitor discovery and listing
  tools/rv: Implement BPF monitor loading and tracing
  tools/rv: Rework tracing to support generic events
  tools/rv: Copy stripped bpf_atomic.h from libarena
  tools/rv: Add BPF monitors
  tools/rv: Define CONFIG_X86_64 statically for BPF monitors
  tools/rv: Add -E/--errors-only option
  verification/rvgen: Add support for BPF monitors
  tools/rv: Add selftest for rv bpf monitors
  verification/rvgen: Add selftest for rvgen -b

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 Documentation/tools/rv/common_ikm.rst         |   6 +
 include/rv/automata.h                         |   4 +-
 include/rv/da_monitor.h                       |  33 +-
 include/rv/ha_monitor.h                       |  10 +-
 include/trace/events/sched.h                  |   8 +
 kernel/sched/core.c                           |  12 +-
 kernel/sched/sched.h                          |   2 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/nomiss/nomiss.h      |   6 +-
 .../trace/rv/monitors/nomiss/nomiss_trace.h   |  14 +-
 kernel/trace/rv/monitors/nrp/nrp.h            |   4 +-
 kernel/trace/rv/monitors/nrp/nrp_trace.h      |   9 +-
 kernel/trace/rv/monitors/opid/opid.h          |   6 +-
 kernel/trace/rv/monitors/opid/opid_trace.h    |  14 +-
 .../rv/monitors/pagefault/pagefault_trace.h   |   8 +-
 kernel/trace/rv/monitors/sco/sco.h            |   4 +-
 kernel/trace/rv/monitors/sco/sco_trace.h      |   9 +-
 kernel/trace/rv/monitors/scpd/scpd.h          |   4 +-
 kernel/trace/rv/monitors/scpd/scpd_trace.h    |   9 +-
 kernel/trace/rv/monitors/sleep/sleep_trace.h  |   8 +-
 kernel/trace/rv/monitors/snep/snep.h          |   4 +-
 kernel/trace/rv/monitors/snep/snep_trace.h    |   9 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |   4 +-
 kernel/trace/rv/monitors/snroc/snroc_trace.h  |   9 +-
 kernel/trace/rv/monitors/sssw/sssw.h          |   4 +-
 kernel/trace/rv/monitors/sssw/sssw_trace.h    |   9 +-
 kernel/trace/rv/monitors/stall/stall.h        |   6 +-
 kernel/trace/rv/monitors/stall/stall_trace.h  |  14 +-
 kernel/trace/rv/monitors/sts/sts.h            |   4 +-
 kernel/trace/rv/monitors/sts/sts_trace.h      |   9 +-
 .../trace/rv/monitors/wakeup/wakeup_trace.h   |   8 +-
 kernel/trace/rv/monitors/wip/wip.h            |   4 +-
 kernel/trace/rv/monitors/wip/wip_trace.h      |   9 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |   4 +-
 kernel/trace/rv/monitors/wwnr/wwnr_trace.h    |   9 +-
 kernel/trace/rv/rv_bpf.c                      |  76 ++
 kernel/trace/rv/rv_reactors.c                 |   2 +-
 kernel/trace/rv/rv_trace.h                    | 100 ++-
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   7 +-
 tools/verification/models/nohz.dot            |  16 +
 tools/verification/models/tqueue.dot          |  15 +
 tools/verification/rv/Makefile                |  45 +-
 tools/verification/rv/Makefile.config         |  49 ++
 tools/verification/rv/Makefile.rv             |   5 +
 tools/verification/rv/bpf_monitors/.gitignore |   2 +
 .../verification/rv/bpf_monitors/bpf_atomic.h | 125 +++
 .../rv/bpf_monitors/da_monitor_bpf.h          | 423 ++++++++++
 tools/verification/rv/bpf_monitors/nohz.c     |  42 +
 tools/verification/rv/bpf_monitors/nohz.h     |  49 ++
 tools/verification/rv/bpf_monitors/tqueue.c   |  28 +
 tools/verification/rv/bpf_monitors/tqueue.h   |  47 ++
 tools/verification/rv/include/bpf_monitor.h   |  20 +
 tools/verification/rv/include/trace.h         |   4 +-
 tools/verification/rv/include/utils.h         |  19 +-
 tools/verification/rv/src/Build               |   5 +
 tools/verification/rv/src/bpf_monitor.c       | 738 ++++++++++++++++++
 tools/verification/rv/src/in_kernel.c         | 439 +----------
 tools/verification/rv/src/rv.c                |   5 +
 tools/verification/rv/src/trace.c             | 237 +++++-
 tools/verification/rv/src/utils.c             | 103 ++-
 tools/verification/rv/tests/rv_list.t         |   6 +-
 tools/verification/rv/tests/rv_mon.t          |  80 +-
 tools/verification/rvgen/__main__.py          |  15 +-
 tools/verification/rvgen/rvgen/dot2c.py       |  15 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  50 +-
 tools/verification/rvgen/rvgen/generator.py   |  40 +-
 .../rvgen/rvgen/templates/dot2k/main_bpf.c    |  21 +
 .../rvgen/rvgen/templates/dot2k/trace.h       |   7 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  11 +-
 .../rvgen/rvgen/templates/ltl2k/trace.h       |   8 +-
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      |  35 +
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      |  47 ++
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      |  49 ++
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      |  47 ++
 .../rvgen/tests/golden/da_global/da_global.h  |   4 +-
 .../tests/golden/da_global/da_global_trace.h  |   9 +-
 .../da_perobj_parent/da_perobj_parent.h       |   4 +-
 .../da_perobj_parent/da_perobj_parent_trace.h |   9 +-
 .../golden/da_pertask_desc/da_pertask_desc.h  |   4 +-
 .../da_pertask_desc/da_pertask_desc_trace.h   |   9 +-
 .../rvgen/tests/golden/ha_percpu/ha_percpu.h  |   6 +-
 .../tests/golden/ha_percpu/ha_percpu_trace.h  |  14 +-
 .../golden/ltl_pertask/ltl_pertask_trace.h    |   8 +-
 .../test_bak_kunit/test_bak_kunit_trace.h     |   8 +-
 .../rvgen/tests/golden/test_da/test_da.h      |   4 +-
 .../tests/golden/test_da/test_da_trace.h      |   9 +-
 .../golden/test_da_kunit/test_da_kunit.h      |   4 +-
 .../test_da_kunit/test_da_kunit_trace.h       |   9 +-
 .../rvgen/tests/golden/test_ha/test_ha.h      |   6 +-
 .../tests/golden/test_ha/test_ha_trace.h      |  14 +-
 .../golden/test_ha_kunit/test_ha_kunit.h      |   6 +-
 .../test_ha_kunit/test_ha_kunit_trace.h       |  14 +-
 .../tests/golden/test_ltl/test_ltl_trace.h    |   8 +-
 .../test_ltl_kunit/test_ltl_kunit_trace.h     |   8 +-
 .../verification/rvgen/tests/rvgen_monitor.t  |  11 +
 tools/verification/tests/engine.sh            |   5 +-
 97 files changed, 2674 insertions(+), 809 deletions(-)
 create mode 100644 kernel/trace/rv/rv_bpf.c
 create mode 100644 tools/verification/models/nohz.dot
 create mode 100644 tools/verification/models/tqueue.dot
 create mode 100644 tools/verification/rv/bpf_monitors/.gitignore
 create mode 100644 tools/verification/rv/bpf_monitors/bpf_atomic.h
 create mode 100644 tools/verification/rv/bpf_monitors/da_monitor_bpf.h
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.c
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.h
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.c
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.h
 create mode 100644 tools/verification/rv/include/bpf_monitor.h
 create mode 100644 tools/verification/rv/src/bpf_monitor.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1

