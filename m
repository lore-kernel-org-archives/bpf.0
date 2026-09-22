Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB84F30D6;
	Tue, 22 Sep 2026 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060396; cv=none; b=nJxqyH68Cgf7Fl35meYtbRB7yAQRRoGcVNT1R+fxskBhhqFuduZ/m+mc5VVSgBAy807rIBEtnGITEtO+FVtVMaakAOwr9xG9jbUr9k3S1Ph81eakVGIeCQRrDVIJa835os8kKNYKuIWHX2RquT3pk/v41khcPPAs/aFQUgP/COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060396; c=relaxed/simple;
	bh=0KdgXyG/zjejT42PPgOlbHOcTVnpynS3UtUEH4UNs1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEfLXLfn8Qw2huy25ZJcun07hdlFLziu7v7FuXHFAb6QeYRa2d8FokCv0RcQnA7YLYmJjK0eak0jTkHXbFNuSSDzSDqEAeyBpnONkUgwtXkSkrbQV0I16kna4khGwgCMUbirQZ+gUoIoyG58Br+sAUHBRT15u79X+H13+ssLVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b1kD41RL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b1kD41RL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=Ra90Cz5Q31+UKczHqIfSoS79hl6DS9VnAuYGeRakvHE=;
	b=b1kD41RLVdRojAwUHOMTaHsAQZ17cnrD+kIic+dmix6d/YA7FQawu2AxH6T7NJ
	siS7M20/kWot0t4KUW2Lg0khdu0M2I6EmQajFafZaakkD5s87QLPJXu2kSfLTsz8
	X9NV3I9ns3rvZpQYMBkIlcdF6UICRK5Dggi8ABDhtUcLY=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3XxMyJ7Jq3mtIAA--.33723S2;
	Tue, 22 Sep 2026 14:58:59 +0800 (CST)
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
Subject: [PATCH bpf-next v6 0/3] bpf, arena: fix range_tree consistency on allocation failure
Date: Tue, 22 Sep 2026 14:58:46 +0800
Message-ID: <20260922065849.3564436-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com>
References: <CABFh=a6QOjBv1c7B0fw0AEqaBXiQJRh=8on5DUfqPC7hYuGBxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XxMyJ7Jq3mtIAA--.33723S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF47tryDtF48ur47Gr18uFg_yoW5Ar1rpr
	W3Kws8J3ykG3yxuF4fu3WxXFn5Ca1rXw4UGryagw1kZry5Cr1xtr40kF1UWr1UCF95Xr1U
	KF4Yqw1I9r1DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0SoJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hMd2mqyJzN6awAA3v

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set(), and patch 3 makes the arena paths handle
range_tree_set() failures and checks the return value in
arena_alloc_pages()'s partial-allocation error path.

Thanks for the review.

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

Note: arena_vm_fault()'s two recovery paths (restoring the range to the
free tree after allocation/mapping failure) also call range_tree_set()
without checking the return value; that is addressed in a separate
series.

Yuan Chen (3):
  bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock
    failure
  bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
  bpf, arena: check range_tree_set return in arena_free_pages and
    arena_free_worker

 kernel/bpf/arena.c      | 38 ++++++++++++++++++++-----
 kernel/bpf/range_tree.c | 61 +++++++++++++++++++++++++++++-----------
 2 files changed, 76 insertions(+), 23 deletions(-)

-- 
2.54.0

