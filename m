Received: from mail-m118211.qiye.163.com (mail-m118211.qiye.163.com [115.236.118.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AF3DB333;
	Fri,  9 Oct 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545952; cv=none; b=ob/V/7cm3xr52vx3bGpxPsq0EJG0IbzhwLQp8Ha8K/5iX9tdyMuH6Egugj8V+ftsmU89e/IdYcCZmwMiFX1aZgKP6yYfvosT/XYD3tERRzknx8lqtEFA4kRC7B60P2R9N+zcKVMbx5KCQowss3qeMDxCoBaEvjw9m6mp7/Qk+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545952; c=relaxed/simple;
	bh=cOvv2AQaQEiOSaVHJ5X0j5TdSvyQhjN5cDZ17xIYu0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aRcKYLK9LKJx9iese+a+4fQsFTt4qXjaScX872UZ4Ogwa5uFQ6P+atcF007mxuUyT3ToT3aKxVFchTUeSbPYVHL1HW4AvCByxxbacvJd0KbEJxeHhuSAlEjnmA+Kf/8+02J7KuNUBmKj+IpcAvQKwUoKcPHvXodha0MIbQs7HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.118.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe29019d;
	Fri, 9 Oct 2026 19:23:24 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
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
	ihor.solodrai@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH 0/6] mm/page_owner: add bpf_iter and kfuncs
Date: Fri,  9 Oct 2026 19:23:02 +0800
Message-Id: <20261009112308.240769-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1206750320229kunmd33b3e054cb272
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE5OVh1NSBgaTh0eQhhOQ1YVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Hi all,

Introduction
============

page_owner records who allocated every page and is a core memory-debug
facility, but it currently reaches userspace as the debugfs flat dump:
slicing allocations by pid, comm, NUMA node, cgroup or stack, etc.,
means streaming and parsing the entire file in userspace, which is
expensive on large hosts and hard to query live.

Exposing the same walk to eBPF lets a program filter and aggregate in
the kernel and surface only the records it cares about. This series
adds that access as a seq_file bpf_iter target and an open-coded
iterator.

Implementation
==============

The page walk is factored into page_owner_next_eligible(), shared by
the read path and the iterators so eligibility stays identical. Three
kfuncs expose information that a BPF program cannot decode from the
snapshot alone: the NUMA node, per-page memcg info including the full
cgroup path, and the stack trace behind a stack_depot handle. Each
record is snapshotted under the page_ext RCU lock, so consumers read
a consistent copy.

Testing
=======

The selftest exercises the seq_file and open-coded iterators, and
validates the get_nid, stack_snprint and get_memcg_info kfuncs.

Zhen Ni (6):
  mm/page_owner: extract page_owner_next_eligible() from read loop
  mm/page_owner: add bpf_iter target "page_owner"
  mm/page_owner: add open-coded page_owner iterator
  mm/page_owner: add bpf_page_owner_get_nid() kfunc
  mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
  selftests/bpf: add tests for the page_owner bpf_iter target

 kernel/bpf/helpers.c                          |   8 +
 mm/Makefile                                   |   3 +
 mm/page_owner.c                               | 219 +++++++++++-------
 mm/page_owner.h                               |  58 +++++
 mm/page_owner_iter.c                          | 180 ++++++++++++++
 .../bpf/prog_tests/page_owner_iter.c          | 173 ++++++++++++++
 .../selftests/bpf/progs/bpf_iter_page_owner.c | 161 +++++++++++++
 7 files changed, 722 insertions(+), 80 deletions(-)
 create mode 100644 mm/page_owner.h
 create mode 100644 mm/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c

-- 
2.20.1

