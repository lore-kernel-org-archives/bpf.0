Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365086;
	b=1cu00T0tdTn4y3adeJEYSJ3Rfeq020C+YKaxGecYA2iOwnCBSKOuvUJOwSYchfXE3fp4
	 DqFJ4Wv7chZYSUQVuz78PV2lFtOyKcqYZ2psDPC7gFJIZJ9r/HGTEmP/d1WhwKFkPMWMF
	 RnZ1aN58Sur1KQ6BBd+rNaiv4k4TNOHCIhc05BwoCEfHlfXWbGjWVu+eZ0mPKhgmpMn35
	 kaseY2XByEhpPFTr1mOtSngGvU8O4cGOFjPg1RrYSPXhyqCQgN6KPKJIAS9Fergrv1Wzm
	 9GpOMBHwskhijIFqea/7KBtjKCqyJP7oNZRIC2UPlLhQzN2fV9EChvhN5/uTFxyysKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=A4PO1xcW68ThzWAxi8IP0ixC8MER94WyaNkItHLyu0M=;
	b=wEOb5NsKwUlKH9F1sRsfXPOqehtSzwR1UAxWLgvdki6jmT7rmygFldj8rWN/oIZZUTqp
	 cAGFLGsWw0cYIXw27ekwsgRi30kD0DzwY0XUfipsLpT6KWu199sJN/rViUjIQhRqI3krN
	 qxuc9rge2+PKcp7EvXieWc2Hde401/qFSPv3FK52V06rpf04OXEebuVJxxJ7D+6tM1p/i
	 dpJen0Orvy5aRVMuB6sfoYNn1OTbqb0Kn7QUGVCukIdydLJGY0Vo/aUiOCUs+5siAn7HR
	 DpxxsGsAgPRH6Opt+32JwFUukEGR8mz2bjGQFMGIlkUHOenWph8uzQ6tFp+pyWyDJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="o/+jtrh5";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9262606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9262606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=o/+jtrh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A4
	PO1xcW68ThzWAxi8IP0ixC8MER94WyaNkItHLyu0M=; b=o/+jtrh52nBEfKEA3k
	M6AmxDvfSlB0gNSce6QL78sZvuLCurbgDVw+dqMhVIJcbvsQXWrtRiRYvBAmWLyw
	qjOFW3/JYmeMwfuIRlmq+/Gd5v3ufgz/IU6XYAbjzCjUCPi8BL0jbOb4b0yiA7on
	i3xSDqlWqBefDDKFgb9q6Fr5I=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S2;
	Wed, 11 Nov 2026 10:43:55 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/6] bpf: Fix async callback use-after-free on map deletion
Date: Wed, 11 Nov 2026 10:43:27 +0800
Message-ID: <20261111024333.228633-1-luyun_611@163.com>
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
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF18CFykCFW8XFWrJw4xZwb_yoWrWr1fpa
	yrZwnIyrsrGFn2yws7Gw4xXFy8Wwn5X3W5CFnYq345Arn8XrykJFy09r1UKFZxCrZYqa1a
	vr1SgFsa9ayUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AxoN2rz1mxjJgAA3Z

From: Yun Lu <luyun@kylinos.cn>

This series fixes a use-after-free when a BPF program schedules task
work, workqueue work or a timer through a value pointer retained across
map deletion. Review of the earlier task-work series [1] pointed out
that cancellation can leave the deleted value open to reinitialization.

The original reader keeps the element alive while it queues new work,
but that does not make the new callback part of the grace period freeing
the element. The final destructor cannot stop a callback that has already
started outside that waiting set from accessing the freed key or value.
Patch 2 includes the interleaving and a historical KASAN report from the
unmodified kernel.

Following Alexei's suggestions [2, 3], check task-work membership after
claiming PENDING, and check wq/timer membership only in the shared setter.
Leave async init unchanged. An unconfigured object cannot start a BPF
callback, so a newly initialized object rejected by the setter stays idle
until normal cleanup.

Keep the cancellation-order fixes separate: mark task work FREED or clear
cb->map before detaching the object. Only the first invalidator clears
the slot and disposes of its map-owned context reference. No hashtab or
allocator changes are needed.

Patches 1-3 fix task work and add its regression test. Patches 4-6 fix the
shared wq/timer paths, adjust rhash_timer and add the wq regression test.

Testing on x86-64 QEMU/KVM with KASAN, PROVE_LOCKING, PROVE_RCU and
DEBUG_ATOMIC_SLEEP:

- task_work_stress, wq and rhash_timer pass with the full series.
- The same test binary on the unfixed base fails exactly the three
  deleted-value -ENOENT checks: task-work scheduling and wq/timer
  set_callback return 0. These are expected negative-control failures.
- Directed two-canceller checks for task work and wq also pass.

Changes since v2:
- Combine wq/timer membership checking in the shared setter; leave init
  unchanged (Alexei).
- Check membership through the map's existing lookup operation and
  remove the extra RCU guard around the lookup (Alexei).
- Let only the first invalidator detach task work or an async callback
  object and dispose of its map-owned reference.
- Reuse task_work_stress, wq and rhash_timer to reduce the added test
  code; retain the recycled timer-field check.

v2: https://lore.kernel.org/all/20261106095747.471718-1-luyun_611@163.com/

Changes since v1:
- Replace slot poisoning and allocator hooks with lookup checks (Alexei).
- Separate FREED-before-detach from task-work membership (Alexei).
- Fix the same publication problem for wq and timers (Alexei, Mykyta).
- Expand task-work coverage and add wq/timer regression tests.

v1: https://lore.kernel.org/all/20261028073525.1035605-1-luyun_611@163.com/

[1] https://lore.kernel.org/all/20261012061915.231254-1-luyun_611@163.com/
[2] https://lore.kernel.org/all/DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com/
[3] https://lore.kernel.org/all/DMOAQI1S0JBS.3N3WETHD2L6KQ@gmail.com/

Yun Lu (6):
  bpf: Mark task work FREED before detaching it
  bpf: Check task work value membership before scheduling
  selftests/bpf: Test task work scheduling on a deleted value
  bpf: Invalidate async callbacks before detaching them
  bpf: Check async callback value membership in the setter
  selftests/bpf: Test wq set_callback on a deleted value

 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/helpers.c                          |  90 ++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   2 +
 ...ing/selftests/bpf/prog_tests/rhash_timer.c |  24 +++----
 ...elftests/bpf/prog_tests/task_work_stress.c |  18 +++++
 .../testing/selftests/bpf/progs/rhash_timer.c |  26 ++-----
 ...ing/selftests/bpf/progs/task_work_stress.c |  17 +++++
 tools/testing/selftests/bpf/progs/wq.c        |  20 ++++++
 8 files changed, 156 insertions(+), 43 deletions(-)

base-commit: bd75869299f1d4ff6e9f45117cce28f8badee1cd

-- 
2.43.0

