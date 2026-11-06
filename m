Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959129;
	b=DCby8tIbve8zMMyejkTiYjkQCvcRIZSfG6EJWum/7DrXx1xY9TOJdF7GOUfpYuCaaIkJ
	 LQRidiZhJ6TMu97xlcycsuea2XWKBjImqw3jK76665ca4f/L5YkFbUEuvL+NDupLMUH/U
	 BGH8QKZxlbfB7cqDVTYXYGfmlYUrM7IdcmEKAZFXQCYUlv+WjOlOMknRuO/Kk53koaErj
	 DeWt2/qONd3oCshzBP7JpkUBCBQaqcRdzuwPEetVToBKWU1gsYv/ddzeHDo0Cqk0tXCqf
	 dBLbxDVL/yhdxY5sr1Vtbll4Gg8ZJknnfQgIeou7kvt0XBpb1WT+ZrHjDywOw5Cg+Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959129;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=LzL7qusSrPQyhCeoaK172AjUPxXXeSwuOWQGmh8vcmA=;
	b=iWG9aOrvY89DwTNQD/NuSvCBXwQRKh+7W2+XcaAbxQ1O0Oi/MQ9mKDid5E9lyKQizM7t
	 Mhd+CoJMbOX50K5DICIU59KQ0FAjZKf5IFo7epj7CTYlt4/XJLbnqeCv8D0NAufUh+U6f
	 yYPuX3kkDsc6/PD2/f2HHzwDTw+htaNscwRvdRTprgUfH5zgc5ElUZwOATvfv8xHKryZT
	 ZmuApDlZIqlQTThhD/mms8NMiwb+Ndnm5lKH9DlcAvq9qplYAb//awYmmzsCKs4Tg05sw
	 v4eT6Gxcmbp+e6n273rf1nFRyezfDjU1OeEr1y0O7HiYm/L6eo+nBj+2J0W4cEsvtNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=M16LzqDZ;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE956606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE956606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=M16LzqDZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lz
	L7qusSrPQyhCeoaK172AjUPxXXeSwuOWQGmh8vcmA=; b=M16LzqDZF0KDd8JVEJ
	+8NMDcWg0WSypvKcgaeotb/M2y1Q9nTf6uLU/cg9as/fFFdzayIvolAVlusA1YHP
	+Qe835LFmsYI9DNdZbaAfhTZvijWdUIBJHWkggZm5RhI5CQnRU0gTraauoMbs7mO
	IVCjxCW0DF9h7H5yxzFv7lJo8=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S2;
	Fri, 06 Nov 2026 17:57:57 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/8] bpf: Fix async callback use-after-free on map deletion
Date: Fri,  6 Nov 2026 17:57:39 +0800
Message-ID: <20261106095747.471718-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF18CFykCFWxAFWDJryrZwb_yoWrAr17pa
	yrt343Krs7GF4Iyws7Cr4UZFyfK3WkWay5C3Wvq3y8Ar98XFy0yr1xKr15WFZxCrZ8tF4S
	vr1FgFn3Cw48XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AZoN2rtpKbCHAAA3u

From: Yun Lu <luyun@kylinos.cn>

This series fixes a use-after-free when a BPF program schedules task
work, workqueue work or a timer through a map value pointer retained
across deletion. Review of the earlier task-work series [1] pointed out
that cancellation can leave the deleted value open to reinitialization.

The original reader keeps the element alive while it queues new work,
but that does not make the new callback part of the grace period freeing
the element. The final destructor cannot stop a callback that has already
started outside that waiting set from accessing the freed key or value.
Patch 2 includes an allowed interleaving and a historical KASAN excerpt
from an unfixed kernel.

Following Alexei's suggestion [2], check whether the map lookup still
returns the value after publishing the context. For wq and timers, check
both init and the setter, since another CPU can configure the published
cb before init finishes its checks.

Keep the cancellation ordering fixes separate: mark task work FREED or
clear cb->map before detaching the object, so another canceller cannot
miss an old callback that can still start.

Patches 1-3 fix task work and add its selftests. Patches 4-8 fix the
shared wq/timer cancellation and admission paths, then add membership
checks and regression tests for each type.

Testing on x86-64 QEMU/KVM with KASAN, PROVE_LOCKING, PROVE_RCU and
DEBUG_ATOMIC_SLEEP:

- All 46 task-work membership subtests pass on the full series.
- The same 14 wq/timer subtests were run on the full series and on
  unfixed/partially fixed kernels as negative controls. Patches 1-3 and
  1-4 each fail ten checks: stale-value init returns 0 instead of the
  expected -ENOENT. With patches 1-5, only the five timer checks fail.
  These are expected negative-control failures. The full series passes
  all 14;

Changes since v1:
- Replace slot poisoning and allocator hooks with lookup checks (Alexei).
- Separate FREED-before-detach from task-work membership (Alexei).
- Fix the same publication problem for wq and timers (Alexei, Mykyta).
- Expand task-work coverage and add wq/timer regression tests.

v1: https://lore.kernel.org/all/20261028073525.1035605-1-luyun_611@163.com/

[1] https://lore.kernel.org/all/20261012061915.231254-1-luyun_611@163.com/
[2] https://lore.kernel.org/all/DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com/

Yun Lu (8):
  bpf: Mark task work FREED before detaching it
  bpf: Check task work value membership before scheduling
  selftests/bpf: Check task work value membership
  bpf: Order async callback admission and cancellation
  bpf: Check bpf_wq value membership before use
  selftests/bpf: Check bpf_wq value membership
  bpf: Check bpf_timer value membership before use
  selftests/bpf: Check bpf_timer value membership

 include/uapi/linux/bpf.h                      |   5 +-
 kernel/bpf/helpers.c                          | 126 +++++-
 tools/include/uapi/linux/bpf.h                |   5 +-
 .../bpf/prog_tests/bpf_timer_membership.c     | 199 +++++++++
 .../bpf/prog_tests/bpf_wq_membership.c        | 199 +++++++++
 .../selftests/bpf/prog_tests/rhash_timer.c    |  98 ++---
 .../bpf/prog_tests/task_work_membership.c     | 392 ++++++++++++++++++
 .../bpf/progs/bpf_timer_membership.c          | 161 +++++++
 .../selftests/bpf/progs/bpf_wq_membership.c   | 156 +++++++
 .../testing/selftests/bpf/progs/rhash_timer.c |  94 +++--
 .../bpf/progs/task_work_membership.c          | 158 +++++++
 11 files changed, 1476 insertions(+), 117 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_wq_membership.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_membership.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_timer_membership.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_wq_membership.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_membership.c


base-commit: a3c8813409f13779fec225468aba7d4067a66468
-- 
2.43.0

