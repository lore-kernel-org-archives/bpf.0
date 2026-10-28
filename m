Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173005;
	b=yMjiCAOnzGdw021/Dg4AfOTECIfVFovVoVLOrVftamPE3R6w48nE1RsjhWo254PXJlhF
	 83DZjcF2KAsmbTcaTtMIrHGiqQ0vSdko+Q6rlbplcgJXXCZ3djGN8VCnU32oTNJGtif8Q
	 +i2If7vd37Sbd9z2ArU8qMxP+rT7Tnf9VSZJydMecxzjbv4y8j2ZsFSaB2uGS7F4V5rPa
	 Nivg4lAErR+6CMR13vk2vsscD6nNVbbTQiqS9LyJCOhX08vSPLySZKRM+Ja3fqNfLqd5E
	 6S60Hh62fm7x+McpJRG1mcrQd3Nib9k8NSRJk2AId3fPsdxrxScwITKJU4eGJeY9XDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173005;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+sQAJrQYUYl5J2zqbcDsQgoUeZvnqr1kzIH5Uj5NeY4=;
	b=3+Y+tq2AUrHIuYShd5FQzjNB3f42fMmmTJtZV0FnYT0ufNwVS+hix2FwpW7QLVJvAVzt
	 tLObXCow2qLFIcYwS4LYh6dE5N4uM07dK5Tc/XLGh/oE6Me6PfL0BblJsUlL8gh88CmHF
	 nlPoBO5woPi183X1rcpYWzj/6+RQ5QhTGC6OYem1JBbyZQGXxyNl6H2yXbjHL15b4bnKv
	 oQ/8axIFsyxt4suOuymRt0qlAlHpdrS2f5NZFwsulD7FjG+5SkwL4ZVEqgc9U1DkCULTH
	 gaw35GbkmGOBt28WXCOpRiJ481hAVlEa7ODZWQQRoqeaGeBmSuFqbo6rgp/XH4Ea7rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=O21vUMeY;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8F606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 07:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C8F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=O21vUMeY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+s
	QAJrQYUYl5J2zqbcDsQgoUeZvnqr1kzIH5Uj5NeY4=; b=O21vUMeY4qayOjViUr
	3zALZnCn6xsKAen4XRLPf5hH7d3tMPSIc8Lv+gsV/AAyFHI338tyoyaKqWzpRon0
	ds4jDRDNxoS4wjoKlPLGapS7WAjYPvSpCcCpV5HXvpiDHy82+cv6dHyhTo5fVbFy
	jvQhMCFjm0GQQZtNH1uHlNWMg=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL1DDpeFqcENQDg--.35047S2;
	Wed, 28 Oct 2026 15:35:33 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: bpf@vger.kernel.org
Cc: Yun Lu <luyun@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: Fix task work use-after-free on deletion
Date: Wed, 28 Oct 2026 15:35:23 +0800
Message-ID: <20261028073525.1035605-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL1DDpeFqcENQDg--.35047S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF18XFWxJF1rZr4kWryDJrb_yoW5Xw4fpF
	WrXayrKw4kX3WIkws7Aw4xZFyrWws7Jw15Cr1ktryfZ3Z0qFyIyryxKF1YqFy3CrZYyF1Y
	vr1FqF4Sk3yUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKiigUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wWtfGrhpcUsCQAA3x

From: Yun Lu <luyun@kylinos.cn>

This series fixes a task-work use-after-free when a BPF program schedules
through a map value pointer retained across deletion. Review of the
earlier task-work series [1] pointed out that cancellation can leave
the deleted value open to context reinitialization.

The original reader keeps the element alive while it queues new work,
but that does not make the new callback part of the grace period freeing
the element. If the callback enters RUNNING outside that waiting set, the
final destructor cannot stop it from accessing the freed key or value.
Patch 1 includes an allowed interleaving and a KASAN stack excerpt from a
controlled reproducer on the base unfixed kernel.

Patch 1 retires task-work slots before non-preallocated HASH/RHASH storage
is returned to the allocator, including abandoned RHASH candidates. It
also orders ordinary cancellation as FREED, conditional unpublish, then
map-owned reference disposal. Existing callback read-side protection and
element grace periods provide the lifetime guarantee.

Patch 2 adds 24 selftests for the retirement gate and compatibility: both
notification modes, live updates, and last-user-reference cleanup followed
by reopening the map by ID. Its callback only counts deliveries, allowing
an unfixed-kernel comparison without deliberately dereferencing freed
storage.

This is a separate series from the captured-task and irq_work BUSY fixes.
It is based on bpf-next commit 7c3188f84b54, which contains those fixes.

Testing on x86-64 QEMU/KVM:

- Same test_progs binary on both kernels, with KASAN, PROVE_LOCKING and
  PROVE_RCU: the unfixed kernel fails exactly the six retirement
  return-value assertions and passes the other 18 cases; the fixed
  kernel passes all 24, with no skips.
- An out-of-tree reproducer triggers the native KASAN report quoted in
  patch 1 on the unfixed kernel on every tested boot; on the fixed kernel
  the stale-pointer schedule is rejected with -ENOENT and no report
  occurs.

[1] https://lore.kernel.org/all/20261012061915.231254-1-luyun_611@163.com/

Yun Lu (2):
  bpf: Retire task work before reclaiming hash elements
  selftests/bpf: Check task work scheduling on retired values

 include/linux/bpf.h                           |   2 +
 kernel/bpf/hashtab.c                          |   7 +
 kernel/bpf/helpers.c                          |  80 +++++-
 .../bpf/prog_tests/task_work_retire.c         | 240 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_retire.c    |  84 ++++++
 5 files changed, 403 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_retire.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_retire.c


base-commit: 7c3188f84b54d8e7643f6ec8454824df2823ba73
-- 
2.43.0

