Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3231194C
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868091; cv=none; b=sqPFbRZz8q2mrzZgDWy1O+2GTvyAxncvPHF76ZCwDidvo0WLeV+Dk0CqQhMBJxRNdQ1oEXavCivZMRRha+2fN+5e0rqY1AYldTlK1CE96ZJtIiHY25NMwRSmK1VIEBP1PFYLUhlZK7p0GNcqLhydbM2lAxVLJvjAjiFMn5TI5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868091; c=relaxed/simple;
	bh=RwTCQyc2/9eU5Qe48T11rYrMElaBaSpn+E9MCzvdW68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxehuWRoNnFqTSRtAXQ88udjRY9DdNyigZekkxizbhK/qIHcBOFe1vWDskzZB4tWq1tizOaujq0F0GmTbfbyzh4rNdAsAdsNjeBakYVaoONISZm0ePzMUldZndvpUVVqjJ6WWftxUgDZAJ1Cs0d80sSkHeqEdTMH6jWE/ESQGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwsnnvni; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwsnnvni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kagp4PSpoBgfM4ETMuyvLvwUUXLW/GIW655rVwDhZEA=;
	b=hwsnnvnid9335+EIiXaHfslent0XzeKlVk/OSgbvLLMeN7/BME/zHuB+rvAXYj+YNuEaey
	rvV11RmcM+xByz0Tsy0hlZmMnt3nl3qcWKNyGFee5PdA/ZzwSU4SlExr00UZRcS3AFwhoZ
	K+haCQiKwUcHhWHazMn272PQcM3QNyE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-E8fy8NjvMMKQRHHXHAbMkw-1; Thu,
 01 Oct 2026 11:21:23 -0400
X-MC-Unique: E8fy8NjvMMKQRHHXHAbMkw-1
X-Mimecast-MFC-AGG-ID: E8fy8NjvMMKQRHHXHAbMkw_1790868081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B4A61944AA4;
	Thu,  1 Oct 2026 15:21:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AFC61800352;
	Thu,  1 Oct 2026 15:21:17 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 00/15] rv: Add support for BPF monitors
Date: Thu,  1 Oct 2026 17:20:27 +0200
Message-ID: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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
 * reactors: link a react() function over the object

Selftests (make -C tools/verification/rv check) are present to validate
and demonstrate the usage, which is mostly equivalent to the standard rv
tool usage.

Patch 1 adds tracepoints required in a later monitor example.
Patch 2 improves the rv tool selftest reporting.
Patches 3-4 prepare the kernel headers for BPF support.
Patch 5 adds a feature check for tools/build.
Patch 6-8 prepare and add support for BPF monitors in the rv tool.
Patch 9-11 prepare and include BPF monitors examples.
Patch 12 adds support for BPF reactors.
Patch 13 adds support for generating BPF monitors in rvgen.
Patch 14-15 adds BPF selftests (make check) for the rv and rvgen tools.

Changes since RFC [1]:
* Drop struct_ops integration to favour a BPF-only implementation.
* Implement BPF reactors with a dynamic linker.
* Don't pin programs and maps.
* Improve handler performance when not tracing.

[1] - https://lore.kernel.org/lkml/20260831090524.106845-1-gmonaco@redhat.com

To: linux-trace-kernel@vger.kernel.org
To: bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Viktor Malik <vmalik@redhat.com>

Gabriele Monaco (14):
  tools/rv: Skip empty pid error in selftest if command failed
  rv: Refactor da_trace() functions to get strings internally
  rv: Cast result of model_get_*_name()
  tools/rv: Move argument parsing from in_kernel to utils
  tools/build: Add a feature test for bpftool-btf
  tools/rv: Implement BPF monitor discovery and listing
  tools/rv: Implement BPF monitor loading and tracing
  tools/rv: Copy stripped bpf_atomic.h from libarena
  tools/rv: Add BPF monitors
  tools/rv: Define CONFIG_X86_64 statically for BPF monitors
  tools/rv: Add reactors support to BPF monitors
  verification/rvgen: Add support for BPF monitors
  tools/rv: Add selftest for rv bpf monitors
  verification/rvgen: Add selftest for rvgen -b

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 include/rv/automata.h                         |   4 +-
 include/rv/da_monitor.h                       |  61 +-
 include/trace/events/sched.h                  |   8 +
 kernel/sched/core.c                           |  12 +-
 kernel/sched/sched.h                          |   2 +
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   7 +-
 tools/verification/models/nohz.dot            |  16 +
 tools/verification/models/tqueue.dot          |  15 +
 tools/verification/rv/Makefile                |  54 +-
 tools/verification/rv/Makefile.config         |  49 +
 tools/verification/rv/Makefile.rv             |  10 +
 tools/verification/rv/bpf_monitors/.gitignore |   2 +
 .../verification/rv/bpf_monitors/bpf_atomic.h | 105 ++
 .../rv/bpf_monitors/da_monitor_bpf.h          | 374 +++++++
 tools/verification/rv/bpf_monitors/nohz.c     |  42 +
 tools/verification/rv/bpf_monitors/nohz.h     |  49 +
 tools/verification/rv/bpf_monitors/tqueue.c   |  30 +
 tools/verification/rv/bpf_monitors/tqueue.h   |  47 +
 tools/verification/rv/bpf_reactors/.gitignore |   2 +
 tools/verification/rv/bpf_reactors/panic.c    |  15 +
 tools/verification/rv/bpf_reactors/printk.c   |  13 +
 tools/verification/rv/include/bpf_monitor.h   |  22 +
 tools/verification/rv/include/utils.h         |  19 +-
 tools/verification/rv/src/Build               |   5 +
 tools/verification/rv/src/bpf_monitor.c       | 982 ++++++++++++++++++
 tools/verification/rv/src/in_kernel.c         | 176 +---
 tools/verification/rv/src/rv.c                |   5 +
 tools/verification/rv/src/utils.c             |  98 +-
 tools/verification/rv/tests/rv_list.t         |   6 +-
 tools/verification/rv/tests/rv_mon.t          |  61 +-
 tools/verification/rvgen/__main__.py          |  15 +-
 tools/verification/rvgen/rvgen/dot2c.py       |  15 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  22 +-
 tools/verification/rvgen/rvgen/generator.py   |  26 +-
 .../rvgen/rvgen/templates/dot2k/main_bpf.c    |  21 +
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      |  35 +
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      |  47 +
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      |  49 +
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      |  47 +
 .../verification/rvgen/tests/rvgen_monitor.t  |  11 +
 tools/verification/tests/engine.sh            |   5 +-
 42 files changed, 2392 insertions(+), 193 deletions(-)
 create mode 100644 tools/verification/models/nohz.dot
 create mode 100644 tools/verification/models/tqueue.dot
 create mode 100644 tools/verification/rv/bpf_monitors/.gitignore
 create mode 100644 tools/verification/rv/bpf_monitors/bpf_atomic.h
 create mode 100644 tools/verification/rv/bpf_monitors/da_monitor_bpf.h
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.c
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.h
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.c
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.h
 create mode 100644 tools/verification/rv/bpf_reactors/.gitignore
 create mode 100644 tools/verification/rv/bpf_reactors/panic.c
 create mode 100644 tools/verification/rv/bpf_reactors/printk.c
 create mode 100644 tools/verification/rv/include/bpf_monitor.h
 create mode 100644 tools/verification/rv/src/bpf_monitor.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h


base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.55.0

