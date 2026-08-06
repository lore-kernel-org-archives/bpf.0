Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFD32C92A;
	Thu,  6 Aug 2026 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985515; cv=none; b=pU22FiAORwvfg2IsCZttwRhzRwjUr4W6WLztQCLs/7JPp1Ndr51e+Yr/Cu5lMxQmXnDxlxAggbIBNsQpsyhlgOOfu7OwtQ9Jjvgni/frNfdFCQWUxO9P+OoGiv3iNwUMEaLG77XW0IUknEF+LjYgX6n5LtDFtEk8APjc4i5HA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985515; c=relaxed/simple;
	bh=fN8FlrRp5eTZAKTNIZ6P9U5Yd2BlqIsfFU4Q+zruhp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfYmWF4X5qbwsjq4+S4mE9isXOc2qwaxLbYuacem7Zdcc5k7eTzGPQ1z9jHDggs1lUBuc2LHVcR6fWVt3vU6vH+43pSDmeD/j5advveOFtXDcUH+iR7UePDKjr6tcbSvcqOnz6gtPLoZSQB5ADgjakJI/9cKRGKDWjoIFzdHFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Eeprh3xA; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Eeprh3xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jN
	xEL3gTmDBWhLcvDpKPShEaFxtZaErUT6xqj+al3SE=; b=Eeprh3xAonoScSONm5
	35yOk1dSRMXQPgvtvie3RMH/IEWx8kbYVLX9C0OTxYTA2Qlv9Q7Dcq7lr6a4KQf1
	f5b4jwStzMk1adwb0syF10acedvojstoyR0df5zCLujF2xhvggjVC4EcL911YH1Q
	AoYNerUP/lNRw8ecJSNFKzunM=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3Xy2m+XNqWvt+Kw--.33251S2;
	Thu, 06 Aug 2026 11:04:07 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v1 0/3] bpf, arena: keep range tree consistent on kmalloc_nolock failure
Date: Thu,  6 Aug 2026 11:03:56 +0800
Message-ID: <20260806030359.299480-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3Xy2m+XNqWvt+Kw--.33251S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWxuw48ury5Jw1fJw1DZFb_yoW8Wr1kpr
	W5GFW5JrWDK34fCrsIvw4rZF15Gw4Fqw4UJrWxKwn5Zry3Crs7tr4FkF1UW34UCFWfXw1Y
	gF4Yv3yIkw1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQgg3Wpz+ajmkwAA3J

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree tracks free arena ranges.  range_tree_clear() and
range_tree_set() can fail when kmalloc_nolock() cannot allocate a node,
but both functions modified the tree before that allocation.  On
failure they returned -ENOMEM with part of the affected range already
removed from the tree, permanently losing those arena slots: they could
neither be allocated nor freed again.

Patch 1 pre-allocates the split node in range_tree_clear() so a failure
leaves the tree unmodified.  Patch 2 does the same for range_tree_set(),
allocating the new node only when the range has no adjacent free range
on either side.  Patch 3 makes arena_free_pages() and
arena_free_worker() check the range_tree_set() return value and skip
the free when the tree update fails, instead of unmapping and freeing
pages the tree still considers allocated.

The failure path requires kmalloc_nolock() to fail under memory
pressure, which is not feasible to trigger deterministically in a
selftest, so no regression test is included.

Yuan Chen (3):
  bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock
    failure
  bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
  bpf, arena: check range_tree_set return in arena_free_pages and
    arena_free_worker

 kernel/bpf/arena.c      | 17 +++++++++---
 kernel/bpf/range_tree.c | 60 ++++++++++++++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 19 deletions(-)


base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e
-- 
2.54.0

