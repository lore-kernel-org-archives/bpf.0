Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581901;
	b=01ucR5LIJT/MxwSCIm08DmwtjdhPncmgeWpTjjwlY11/Viok+x4go39n05EFtnMq0Ott
	 MiDc5g3wM197B00Yr6Ph66mNEwiMTyU4X3CmeuRmF4+IfoMkaN/g8h8/ax5WwZ2xw7uTm
	 dwImgRRgyZ94fSuTH5zKZXFckxEwqKH9t3/lm8EiKAPsG6IJbKP2rzgMa/rc9rRHaxxO4
	 3BNF9duT49oyUqFDtewesVCmPsMLV7Y4Vt19iovJ5STjCm61/g75/BgleXhbi1fZO6eUb
	 SWb6kvzRXZN49jpTmI8jm7MWqNvMM7k30KZB5UgoyB3f16x14Y+J9Mh7kcfg5AkW2VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581901;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status;
	bh=fYQedfSsWo5LMmpMHGI7ycvMtfsOZlKk03CQjYqp/4g=;
	b=aBnKawD6lCSrP/YA+vFS2arO1NgDqXxJdm8DEidBZywNuKLfCuxIQycs85ZJlEzCiryB
	 UlxyZFfy2lG0MktFhCnYuvbeSq3XbQ2hNNOZoC7Uti/WAXv0l4dB/hbcvtkMgo39TpmDz
	 dgU7/qRqFaotgmQLZWmA0ORiSlnKa0iR8nkXM/y1i/AV3i+m1Uj7ePVJxCyPv0qA9HVT8
	 eWz0HZNaGp7hycOsXbolw6NoUidmVeBkrQ3GZGCezsf+muboNNdoup/WTjVSipLksjJlm
	 vW3juAh/tlJmbte5cVR8PvQv4Q6FJLaEZI92/PWaLGTbGtPp2PC1OwwrrW21FsdwHYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=103.209.128.247
Received: from mail-m128247.netease.com (mail-m128247.netease.com [103.209.128.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3A606A31A;
	Wed, 21 Oct 2026 11:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151a4;
	Wed, 21 Oct 2026 19:24:47 +0800 (GMT+08:00)
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
Subject: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
Date: Wed, 21 Oct 2026 19:24:30 +0800
Message-Id: <20261021112437.1799213-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
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
X-HM-Tid: 0aa15e34e6900229kunme08c1fd526accc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEofVhkfQxgaGExOSklPSFYVFA
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

Changes in v3
=============
- Add a mem-hotplug read lock across the page scan.
- Drop the live struct page from the scan cursor and the bpf_iter context.
- Check the page_owner_inited static key in the iterator.
- Without scan->page, start at min_low_pfn - 1 and let next() pre-increment.
- Gate the kfuncs with KF_PERFMON.
- Enable BPF_ITER_RESCHED for the bpf_iter target.
- Check ENODATA/EOPNOTSUPP from <errno.h>.

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

v2: https://lore.kernel.org/linux-mm/20261013122125.843451-1-zhen.ni@easystack.cn/
v1: https://lore.kernel.org/linux-mm/20261009112308.240769-1-zhen.ni@easystack.cn/


Zhen Ni (7):
  mm/page_owner: extract page_owner_next_eligible() from read loop
  mm/page_owner: protect page access with mem-hotplug read lock
  mm/page_owner: add bpf_iter target "page_owner"
  mm/page_owner: add open-coded page_owner iterator
  mm/page_owner: record the NUMA node in the scan cursor
  mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
  selftests/bpf: add tests for the page_owner bpf_iter target

 kernel/bpf/helpers.c                          |  10 +
 mm/Makefile                                   |   3 +
 mm/page_owner.c                               | 252 ++++++++++++------
 mm/page_owner.h                               |  60 +++++
 mm/page_owner_iter.c                          | 232 ++++++++++++++++
 tools/testing/selftests/bpf/config            |   2 +
 .../bpf/prog_tests/page_owner_iter.c          | 193 ++++++++++++++
 .../selftests/bpf/progs/bpf_iter_page_owner.c | 157 +++++++++++
 8 files changed, 826 insertions(+), 83 deletions(-)
 create mode 100644 mm/page_owner.h
 create mode 100644 mm/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/page_owner_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c

-- 
2.20.1

