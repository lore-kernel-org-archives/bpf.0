Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90317391E64;
	Mon, 10 Aug 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369757; cv=none; b=sWSl9Kpasq5BnROm6gkWNnF99KO9F78ccb49kiwoEkb2DhSuLwySXLuXgHchFTrpnTRVc1l/PegJiRfv4jtWipozArJ19PzqWYRHZpmtfPuso+B9VGWOw9GG0Yrrv5JTt9Gb/HnTqGVbPq3lcGgk7Yc4eCa2c6rdJk3RIVf7LB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369757; c=relaxed/simple;
	bh=RFB2v6/TVfZxwadOa23TgbfHqBABKG3BD6TiL0MIuiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctnVm1Y5BaHAPcqxh3GHkkFboYSc3BvxlHd+dGzWlmWOvhl8MYRU4/5UOOulIy9tzfNqp09wnObo9vMjuKgJWZT7Rm5O3rhlxcXyZMOwjBPem6lChNXAOuamD781r4fa9LD5MVJ+Nc7PJO7LpT1Nagw4MhVnbjsIW3Hjh+on+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KMCg4+OA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KMCg4+OA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qo
	iHHYBw6HtC6O/zL5mQ3eqKVErB0C33xAcOPnaHZ7U=; b=KMCg4+OAvUc+p2UvBO
	6eFjK+z/oQWcCJQ0+xwyE+RXx/KLJMBjJb0sCVDJY+/pomNeplUe4xoJbu1h894B
	jq2AM7MuaPd6Ja6juL7cxN17wVUolgfFoIHnW7mX1P02MhlwdJMeu6YudwUbD28/
	Td80Zcv2kYK1pI4zibBAaM0IE=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnJImg1nlqBKwLPA--.27752S2;
	Mon, 10 Aug 2026 21:48:18 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/3] bpf, arena: fix range_tree consistency on allocation failure
Date: Mon, 10 Aug 2026 21:47:57 +0800
Message-ID: <20260810134800.2875487-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnJImg1nlqBKwLPA--.27752S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4fJw47AF4rtry7Zw1DZFb_yoW8GrWDpr
	W3Gws8Ja98G34xuF4SkF1rWF95Cw4rXw4UGry3K3WkZry5Arn7tr40kF17Wr1UCFyfXw4r
	KF4Yq3WI9w1DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnrcfUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QPWlGp51qPDSAAA3J

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set(), patch 3 makes the arena free paths handle
range_tree_set() failures and checks the return value in
arena_alloc_pages()'"'"'s partial-allocation error path.

Changes in v3:
  - Check range_tree_set() return value in arena_alloc_pages()'"'"'s error
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

 kernel/bpf/arena.c      | 22 ++++++++++++---
 kernel/bpf/range_tree.c | 61 ++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 20 deletions(-)

-- 
2.54.0

