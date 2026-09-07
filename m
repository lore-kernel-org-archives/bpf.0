Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876C3EC827
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796693; cv=none; b=QxKgZMJL33qNA/lMzNuRyaqQrzgiTZhq4bhU2aSgY/yw0PLmZZefIV3DVwgk2f2sFDba0LBhVJA0QDrVYd16uLWUX1A/Xg//Xmme8E8R5jnnm98mmiQ8z+MVv6ksadyjij4FwSV+NrYt11bdPKEce5AcJNq7CsnaWKzfkUk8QiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796693; c=relaxed/simple;
	bh=YzgZtN1YxaukZu3WQu+x2pHeIhJyue7AifUmdqa1DZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNyCKZ8Ha9uH7GokXNWusqOmG+hobB8BjIupD7Uj9AuWjQuzOr2ytIxWhgCvpDCGoWb0qihpvIgkOnU2KiGdHwlYfzdW7R+Mq6Ofplf5wHwQX56fHWsoHIWFggej2iqnmB1D4uMwaGxOSYnj7Uxl3rmL5jsFUVJuN2cYBrwCq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SCMEjWsp; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SCMEjWsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3/
	r6GmIe9Tmm6H/5xhqKsGifDDHFoWQ8WiYjZtKP6Iw=; b=SCMEjWspAZ4dHSmcrX
	gZVz2qYIFAUwCGnnIX32DH8gTCKMQB2vUg9Yy0/9sAO+3wcF2aZ2XfAskQWhbivk
	HF7+TW/4H2sYsLpVPCD3sqA+u5M4sb7YlzJHuhKkg/dZalRBtxZ9N+P1ycyNzaMp
	qEdnpRay99+DpYB9VI3Zo/7l8=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3I_Lv3p5qyEtTPA--.57222S2;
	Mon, 07 Sep 2026 23:57:35 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf 0/2] bpftool: fix sparse logical CPU handling
Date: Tue,  8 Sep 2026 00:57:33 +0900
Message-ID: <20260907155735.2929529-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3I_Lv3p5qyEtTPA--.57222S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xGrWrJr45Wr13ur43GFg_yoW8Xw48pa
	yfGa4Yg397W3sayw1fAr40gry5AFWfJFnFqFnFg398Xrn5XryjvF4IkFy5Zrn8WrWxZrW0
	yw1Yk34kWF1DZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRqQ6QUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwg81lGqe3u+1uwAA3n

Per-CPU map values are stored in dense slots, while the slots correspond
to logical CPU IDs from the kernel's possible CPU mask. On sparse CPU
topologies, bpftool currently reports dense slot numbers as CPU IDs when
dumping per-CPU maps.

The prog profile command has the same assumption in a different form: it
uses the compact possible CPU count as the logical CPU range and as the
stride of its PERF_EVENT_ARRAY. This produces incorrect event keys when
logical CPU IDs are sparse.

The first patch adds a helper to enumerate logical CPU IDs from the
possible CPU mask and uses it in the map output paths. The second patch
reuses the helper for perf-event setup and uses a logical-ID span for
multi-metric event-array keys, while retaining compact userspace result
storage.

The series was tested in an arm64 QEMU guest with possible, present, and
online CPUs set to 0,2-3. Map output, including a BTF-described per-CPU
array, reports CPU IDs 0,2,3. The QEMU PMU does not provide usable
hardware profile counts; the profile test nevertheless reaches perf-event
setup in the fixed version, while the pre-fix version faults in
perf_event_alloc().

Hui Su (2):
  bpftool: Fix CPU IDs in per-CPU map output
  bpftool: Fix sparse CPU IDs in prog profile

 tools/bpf/bpftool/common.c                | 37 +++++++++++
 tools/bpf/bpftool/main.h                  |  1 +
 tools/bpf/bpftool/map.c                   | 77 ++++++++++++++++-------
 tools/bpf/bpftool/prog.c                  | 35 +++++++----
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  7 ++-
 5 files changed, 121 insertions(+), 36 deletions(-)

-- 
2.54.0

