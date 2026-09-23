Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FD472530;
	Wed, 23 Sep 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153950; cv=none; b=RB/L4yWO5za6sFyYZxyxwL3HCbFtNUR9T2HSiQ1ejLvHqqqgqZ95UaKshNZn5KCZTvWhx9W7uCDrC2YWvxgCoAu+PWzaOhDCs/E5U/D2nsg9Ky+C7mza1kNLYlTMBjLJ38qwlRI+jfEv9VLAcbg3KdLrrjy/IgUXOjYXjj4NMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153950; c=relaxed/simple;
	bh=PHWb6/KmJABwomql6qv6xP7HESSmX5Po6OtzYUkXQMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKefHosW7JN2ABdFtnG7kteKpTLxYcilgqaJlfLhR4Hxq2YQx7fmBloCNCx0JDl1TXswPVYfvPfSOv7qiW4B3jMHXMLkThWYZ9tmVEQDUiXNTU9gedO3dWfJjWyUadYKVTkaOItgHQVO1ORMY4yeZ6s7BegxCC0NT5rehXcmYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gwLXDtzp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gwLXDtzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=CF7aL3IuL1ABkj1Z+o9KrwqaC0dcBQxEo+sehsUYnAk=;
	b=gwLXDtzpsG2BRBlKba0Mp1tU4Zh+es2dQhaIDmV+bgqjC1GTsquIa+93CCyCs4
	JbFMhoudz0wessH76aeSCjHVOuck2xXgSfW+ajx2PpFDBHaeCMAqCw4LaDPgjYG0
	q7YRSt9y64dacFJ9PskaS4jKG7ih2807VI0uq4AfqZx3k=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H8OylLNqSEwzAQ--.5285S2;
	Wed, 23 Sep 2026 16:58:27 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v7 0/2] bpf, arena: fix range_tree consistency on allocation failure
Date: Wed, 23 Sep 2026 16:58:15 +0800
Message-ID: <20260923085817.365930-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DLMBR82RJV2B.3401V0ZRMT392@gmail.com>
References: <DLMBR82RJV2B.3401V0ZRMT392@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H8OylLNqSEwzAQ--.5285S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4xCryrCrWrur47Jw1rtFb_yoW5Cr1Dpr
	W3twsxA3ykGrW7uF4fua1xZFn5Ca1rXw48Gryagwn5Zr15ZryIyrWIkF18uFyUCF93Xr1U
	tF4Yqw1Sg3yqvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0SoJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARPYlmqzlLMESQAA3v

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set().

Thanks for the review.

Changes in v7:
  - Dropped the third patch (checking range_tree_set() return in
    arena_free_pages/arena_free_worker) per Alexei Starovoitov: a range
    that stays marked allocated while its pages were freed is the same
    state bpf_arena_reserve_pages() creates, and nothing relies on an
    allocated range having pages. The failed free only costs page_cnt
    pages of address space, while aborting the free would leak pages
    the prog cannot observe or retry. No separate series for
    arena_vm_fault() either.
  - range_tree_set(): do the adjacency lookup once, before the clear,
    and drop the unreachable -EFAULT checks, per Alexei Starovoitov.

Changes in v6:
  - Patch 3 only: on a failed range_tree_set() drop the span and leak the
    range, which keeps the range tree and the page tables consistent, and
    revert the arena_map_free() teardown changes that went with the
    retry. Patches 1 and 2 are unchanged from v5.

Changes in v5:
  - arena_map_free(): set a dying flag and steal orphaned spans before
    draining, and drain with flush_work() + irq_work_sync() +
    flush_work().  The worker retry queues arena->free_irq, which the
    old irq_work_sync() + flush_work() order could miss: the irq_work
    fired after the arena was freed and its callback scheduled
    free_work on freed memory.
  - arena_map_free(): retry the spinlock acquisition a bounded number
    of times (-EDEADLK is not retried) and WARN with the error code,
    instead of a bare WARN_ON_ONCE(1) and an immediate leak of the
    arena.
  - range_tree_set(): reword the comment describing the two lookups,
    as suggested by Alexei Starovoitov.  The pre-clear probe only
    decides whether a fresh node must be allocated, so that -ENOMEM
    leaves the tree unmodified; the post-clear lookup fetches the
    merge handles without depending on how range_tree_clear()
    truncates overlapping nodes.

Changes in v4:
  - arena_free_worker(): keep a span whose range_tree_set() failed on
    arena->free_spans and retry it on a later worker run, instead of
    leaving it in the drained list where the second loop would still
    zap user VMAs and free the span (dropping the free request), as
    pointed out by Emil Tsalapatis.

Changes in v3:
  - Check range_tree_set() return value in arena_alloc_pages()'s error
    path, which restores the unpopulated tail of a partially allocated
    range (previously ignored), as pointed out in review.

Changes in v2:
  - Fix multi-line comment style in patches 1 and 3 (opening /* on its
    own line), as pointed out in review.

Yuan Chen (2):
  bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock
    failure
  bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure

 kernel/bpf/range_tree.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

-- 
2.54.0

