Received: from mail-m12736.qiye.163.com (mail-m12736.qiye.163.com [115.236.127.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56236B927;
	Tue, 13 Oct 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896244; cv=none; b=cBLOH24RsNLJ11Fq064KH82DTasMZfaLlY8WaWdDw0mmAb7EemJHK5UUmps9DjhyWCBnAJQEmqJYML/NfEcN8vCAAMszhYlwTQdR2600khOtwGQ8Tdo4iKMiv78Bpfjp6/RZ6tJgMlKJ69m747ymrhm4Sk3ZtPOfJhfv7dxzcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896244; c=relaxed/simple;
	bh=7+OQzYzv3SbWX+2533YRdRXLs2xaO0eiv3KbK0o/ZRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWnyTbdNcEmXq9ZqD0AWbwpJ1nqjGMvgIUEmcStGjsc5Rc4zsOM9CMkhuB1hCKgLOOKU40ksiZZCoCP1hOQKLJwXKbeVNM4raYsv2vlHgyaOpTOeetyRdb2g7SthNHusB/d5mT8ftaCq86nSfoVz7WSxvzD+juMgqCk/4KCjFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200407ee7;
	Tue, 13 Oct 2026 20:21:41 +0800 (GMT+08:00)
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
Subject: [PATCH v2 0/6] mm/page_owner: add bpf_iter and kfuncs
Date: Tue, 13 Oct 2026 20:21:19 +0800
Message-Id: <20261013122125.843451-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa135361ed30229kunm0bc94a6a5244
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBlNVh9MGBofTEodGB9LS1YVFA
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
the read path and the iterators so eligibility stays identical. Two
kfuncs expose information that a BPF program cannot decode from the
snapshot alone: per-page memcg info including the full cgroup path,
and the stack trace behind a stack_depot handle. Each record is
snapshotted under the page_ext RCU lock, so consumers read a
consistent copy.

Testing
=======

The selftest exercises the seq_file and open-coded iterators, and
validates the stack_snprint and get_memcg_info kfuncs.

Changes in v2
=============
- Route the zero-handle case through ext_put_continue.
- Drop the scan->pfn++.
- Fill page/po/pfn only when v is non-NULL.
- Implement page_owner_seq_stop().
- bpf_page_owner_stack_snprint() now takes the scan cursor.
- Buffer args renamed to buf__uninit/buf__sz.
- Removes the v1 get_nid() kfunc. The node is now stored in scan->nid.
- bpf_page_owner_get_memcg_info() now resolves the page with
  pfn_to_online_page() for an offline or removed pfn.
- Buffer/info args renamed to info__uninit/buf__uninit/buf__sz.
- Drop the get_nid kfunc coverage.
- Enable CONFIG_PAGE_OWNER in the bpf selftests config.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-1-zhen.ni@easystack.cn/

Zhen Ni (6):
  mm/page_owner: extract page_owner_next_eligible() from read loop
  mm/page_owner: add bpf_iter target "page_owner"
  mm/page_owner: add open-coded page_owner iterator
  mm/page_owner: record the NUMA node in the scan cursor
  mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
  selftests/bpf: add tests for the page_owner bpf_iter target

 kernel/bpf/helpers.c                          |   7 +
 mm/Makefile                                   |   3 +
 mm/page_owner.c                               | 219 +++++++++++-------
 mm/page_owner.h                               |  58 +++++
 mm/page_owner_iter.c                          | 197 ++++++++++++++++
 tools/testing/selftests/bpf/config            |   2 +
 .../bpf/prog_tests/page_owner_iter.c          | 193 +++++++++++++++
 .../selftests/bpf/progs/bpf_iter_page_owner.c | 159 +++++++++++++
 8 files changed, 758 insertions(+), 80 deletions(-)
 create mode 100644 mm/page_owner.h
 create mode 100644 mm/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c

-- 
2.20.1

