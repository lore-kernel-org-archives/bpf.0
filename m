Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94D3C9EFB;
	Mon,  8 Jun 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928853; cv=none; b=oLkM+Vnuwx0NTVePAut8DW2yMc4TQ8WMBB75kpHhxYpircya1HREQkWRCByZyRG3OuRA3uTObe/rN4BRPYx2ghzEdDmdc7a958IGe9sfBzRsU6k7qsE0yljY+IExkqQLE2W8DS0Au6Xj8648w6zc07dgQlpx094+GzZRdC7pkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928853; c=relaxed/simple;
	bh=i/yKIQgDIXqLq1rcqI/cxHYLwHc2D2z1FozXQR3IUVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsyQiDLNlzKMxHzF2twUSc/OL0kjS/lkJQqRB3lJyraid9aeG8yqbqO78MZNfsutehFbanHNkCLDkFKH17ZA+u9YnKad4ekMPXu778Vetaw5gJ4SpnlxLZVce5LYbyPsydkSnnPrboNRBqtCWQ4aHleRd1YNdPwR2TgsMU0LE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YnqXzP9y; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YnqXzP9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nd
	5rUULCZjZP2nQi41ANALB/Ntn6/CskZz64rWrwRr0=; b=YnqXzP9yvdmSvEL8j1
	NthxAjvP9+uEpb7NYqWouK7nYppPYaLzebEfiug+/C0pQubHv19RboErHi4b4Lq7
	GOKHLQJ4N2E5kmz7P+Fcc15OFqvmQUL6j41u2QjH+DZQ4FLMKK5bjsRwed56LG36
	hHD9dgg3SdJlFKHx8qXJX4pao=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXwtUW0SZqv3LYBw--.1507S2;
	Mon, 08 Jun 2026 22:26:33 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v5 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Mon,  8 Jun 2026 22:26:16 +0800
Message-ID: <20260608142618.3064380-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093836.2632714-1-chenyuan_fl@163.com>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXwtUW0SZqv3LYBw--.1507S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDZFW5tF4rKF43Xry3CFg_yoW8AFW5pF
	WrJr1Ykr48J3WSgas3Ar4xZr1Fgan3X3y3GF98K340yFs8ZF18XryFyr1fXayYyrn3WrW2
	vas2qFWkW3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHGQDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hqeXGom0RoE5wAA3a

From: Yuan Chen <chenyuan@kylinos.cn>

v4: https://lore.kernel.org/bpf/20260602093836.2632714-1-chenyuan_fl@163.com/

v1 made btf_types_are_same() cross-BTF aware by comparing kind, size
and name.  Alan Maguire pointed out that this would be too permissive
since two different structs can share the same name and size.

v2 used a name-based classifier (get_kfunc_arg_inject_type).

v3 splits the combined is_kfunc_arg_ignore || is_kfunc_arg_implicit
check in check_kfunc_args(), so that an implicit argument reaching
is_kfunc_arg_implicit() without any prior handler is rejected with
-EFAULT instead of silently skipped (Eduard Zingerman).  This prevents
the silent fallthrough that occurred when module BTF was inconsistent
with vmlinux (e.g. pahole 1.30 breaking distilled base dedup).

v4: fix a build error in the selftest.

v5 changes:
- Patch 1: extend the kfunc allow-list in check_kfunc_args() to cover
  all kfuncs with implicit args handled in bpf_fixup_kfunc_call():
  obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
  refcount_acquire, list_push, rbtree_add (Eduard Zingerman).
- Patch 2: simplify the selftest by verifying aux->name in
  bpf_kfunc_implicit_arg() instead of adding a separate struct_ops
  test program with inline assembly (Eduard Zingerman).  This is
  a single-file change exercised by the existing kfunc_implicit_args
  selftest.

Yuan Chen (2):
  bpf: Fix kfunc implicit arg inject type detection to prevent invalid
    pointer deref
  selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

 kernel/bpf/verifier.c                              | 19 +++++++++++++++--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.54.0

