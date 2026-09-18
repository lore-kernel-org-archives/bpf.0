Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E12547051;
	Fri, 18 Sep 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726915; cv=none; b=KEj3QLyLqjonUm75l4G/TabpRQysVA9HxsLu0dw3k0xSKKMk4wgfsE3CMVUIy+8oRgqbgwXcAgUycCti2p1WzvwuN7M7aAlWOFv4F8rd8FeecoAQdz714UoWdRHwrrVO2bEGJ1wj4NHLGCJKuGtIYnIT1wGM/35/3ItLeXS4JPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726915; c=relaxed/simple;
	bh=XNP8kthfbLHwTdl4JFk73P9gfytBYhFMYWxpyhYXdPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzNCOmp3Bv2BET/7eKwOCbRRDU7OCUAhSshnuaEIKNytd33M1ZxdNN8YeNfb3azXj7c4b0vODtEmj58CBcTsLWbBmL6aoDiRUEDbzL7CrZDYpD8H7WAX1pfVOoRDyvl0kI76KUupPZgDktvC2caVbR4n86cLwfXJCffsEYTPTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LjUL/liI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LjUL/liI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KO
	787eRv1spG9JxxKrNcMLv6v6xwRPAr4ivc5C5scZE=; b=LjUL/liI5p9IeWM9lW
	tn54k5k4JEXLXHHx5KhKrLBZULan9L9W8dVDBFHJt9bFAY7wGbcdrnzEWEGWriBQ
	JXX0qoKEOZgA7l48VWMPptBCUiJddo6FteHcEFFY+O3kJRNsuYFC9tiIssHDeses
	EbkbJUW5vFqsodWjHDb7vdd6U=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3X1OOEK1qxGJPAA--.9466S2;
	Fri, 18 Sep 2026 18:21:03 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf v2 0/2] bpftool: Fix sparse CPU IDs
Date: Fri, 18 Sep 2026 19:20:50 +0900
Message-ID: <20260918102052.1247819-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3X1OOEK1qxGJPAA--.9466S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1rXw4DCr4UZryrCw1UGFg_yoW8tr4kpF
	WfKFyYgw4kWr9a9wn3Jw4rWay5GFs7GFnrt3ZrK3y5Xry8Ar17Zr17KF18uFy3WrW3ZrWU
	tr4v9rykWF1jyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piUGYdUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ8tjGqtEI+zEwAA3X

bpftool currently assumes that possible CPU IDs are dense.  This is not true
when the possible CPU mask itself is sparse, such as 0,2-3.  In that case,
per-CPU map output labels and prog profile event-array keys can refer to the
wrong logical CPUs.

The first patch keeps dense per-CPU buffer slots separate from logical CPU
IDs when printing map values, and propagates errors from the shared output
path to its callers.

The second patch applies the same distinction to prog profile: userspace
keeps a compact CPU count for result buffers, while BPF event-array keys use
the logical CPU ID and the logical ID span.

Changes in v2:
- Add explicit bpftool errors for possible-CPU mask parsing and allocation
  failures.
- Rename the helper result variable to reflect that successful returns are
  CPU counts, and remove the duplicate CPU-count consistency check.
- Use a dedicated `cpu_cnt` in `map_dump()` instead of overloading `err`.
- Propagate BTF/output errors from `print_key_value()` through both callers.
- Remove the unused BPF-side `num_cpu` rodata and use the userspace
  `profile_cpu_cnt` for compact per-CPU buffers.
- Reset all profile CPU state on cleanup paths.

Testing:
- Built the final bpftool tree successfully.
- Booted an ARM64 QEMU guest from a DTS-built virt DTB with possible CPUs
  0,2-3.
- Verified plain/BTF and JSON per-CPU map output reports CPUs 0,2,3 and
  omits CPU 1.
- Ran `prog profile` with cycles and instructions; the profiler skeleton
  reached perf-event setup. QEMU did not provide a usable instructions PMU
  event, so no hardware profile counts are claimed.
- Confirmed the final v2 tree is code-identical to the runtime-tested tree;
  only commit metadata changed afterward.

Hui Su (2):
  bpftool: Fix CPU IDs in per-CPU map output
  bpftool: Fix sparse CPU IDs in prog profile

 tools/bpf/bpftool/common.c                | 40 ++++++++++++
 tools/bpf/bpftool/main.h                  |  1 +
 tools/bpf/bpftool/map.c                   | 76 ++++++++++++++++-------
 tools/bpf/bpftool/prog.c                  | 51 ++++++++++-----
 tools/bpf/bpftool/skeleton/profiler.bpf.c |  8 +--
 5 files changed, 131 insertions(+), 45 deletions(-)


base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.55.0

