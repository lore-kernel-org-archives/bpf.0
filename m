Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441F247291;
	Wed, 23 Sep 2026 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124215; cv=none; b=Mh6/VN0G00ioUxEjkUr4O0yCDgUW/ZazU0osgjvHWG2xntgEfnRm2EzW/WyrzlUUn1sSNW0oHvVCQIsX8F//fV0GPwlZtIttA52pOXNwantsy5nb6zMOM5a6hjVWH8EoY7BDYMl2QXxY/tX0To03wruspldEQKkzxqWWbBtRAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124215; c=relaxed/simple;
	bh=ueRyXbE4lZsJzOKCmGX4/xZWPbjSR2qnhvl6dpSZ68M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eirnfoAQrorwtJt3XWAnhc4qW7HwPjppaIHVowLKJunv3mEuVb8sYXaQAkpxXs97tAP8pjKC4PY9bMHI1POHt+BZXHs+XvlBcvxO51cVVSucj+fC7aqkkQIaMg0rtwrF+on+v8Eg65KT53eMPCXHDf4mZKTNtdyQpebaDpnjRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VK1v0fz0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VK1v0fz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ci
	amr67SJPHIYjRvbPOdTRWmM4Rvo7fcUT1dY7gnHGQ=; b=VK1v0fz0niI3WprSPI
	sku+k2V+IAtTUxRAYxekW1wveYqW7aHlgkou2ms8eCIgZkAa6h1YzH5z5+FefZIQ
	7gnW8X3GTt/jszcKOvpieVOtzyLN0a8m75xPd+KIGy29/6s3+OxjGtYDUOwl2+RI
	J0qhdTnyM6vLmpH6ZHf+EILwQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnN0GDILNqFQPnAA--.34882S2;
	Wed, 23 Sep 2026 08:42:44 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v3 0/2] bpftool: Fix sparse CPU IDs
Date: Wed, 23 Sep 2026 09:42:41 +0900
Message-ID: <20260923004243.969919-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN0GDILNqFQPnAA--.34882S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1rXw4DCr47Zr15JF4xZwb_yoW8tryrpa
	ySqFWYgwn7WF9ayw4fJw4fWw1Yyrn7Gr4DtFnrK3yYvF1IvrnYqw13KF4ruF13WrZxAryU
	Xr4Y9rykWan8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREApUUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgWwEGqzIIUoMwAA3A

bpftool currently assumes that possible CPU IDs are dense. This is not
true when the possible CPU mask itself is sparse, such as 0,2-3. In that
case, per-CPU map output labels and prog profile event-array keys can
refer to the wrong logical CPUs.

The first patch keeps dense per-CPU buffer slots separate from logical CPU
IDs when printing per-CPU map values. The parsed CPU count is passed
together with the logical CPU IDs so that output labels and loop bounds use
the same possible-CPU mask.

The second patch applies the same distinction to prog profile. Userspace
keeps a compact CPU count for per-CPU result buffers, while perf events are
created for the actual logical CPU IDs and PERF_EVENT_ARRAY keys use the
logical CPU ID span. The current per-CPU perf event grouping in bpf-next is
preserved.

Changes in v3:
- Rebase the series onto bpf-next/master as requested by Andrii.
- Adapt the prog profile fix to current bpf-next while preserving its
  per-CPU perf event grouping and scaled-value accounting.
- Pass the parsed CPU count through the per-CPU map output helpers.
- Match the existing bpftool memory-allocation error style.
- Pass profile_cpu_ids directly to get_possible_cpu_ids().
- Move testing details from individual patches to the cover letter.

Previous versions:
v2: https://lore.kernel.org/lkml/20260918102052.1247819-1-sh_def@163.com/

Testing:
- PASS: Host and ARM64 bpftool builds, bpftool Documentation build, bash
  syntax, and diff checks.
- PASS: ARM64 QEMU with a synthetic possible/present/online mask of 0,2-3;
  plain, JSON, and BTF per-CPU map output reported CPUs 0,2,3, and prog
  profile reached perf_event_open for CPUs 0,2,3. QEMU did not provide
  usable PMU counts.

Hui Su (2):
  bpftool: Fix CPU IDs in per-CPU map output
  bpftool: Fix sparse CPU IDs in prog profile

 tools/bpf/bpftool/common.c                | 40 ++++++++++
 tools/bpf/bpftool/main.h                  |  1 +
 tools/bpf/bpftool/map.c                   | 95 +++++++++++++++--------
 tools/bpf/bpftool/prog.c                  | 51 +++++++-----
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  8 +-
 5 files changed, 140 insertions(+), 55 deletions(-)


base-commit: 79dc258c9392051420a26f1504c647bd3d27c66a
-- 
2.55.0

