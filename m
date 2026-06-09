Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224B19CC0C;
	Tue,  9 Jun 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009618; cv=none; b=OvGV+IbKCjC/NHvE/c7nagdqscCvRg0KIzAl4St5I73RQhjjK0GiEd0YlzeuDt7UIvXXdT1T76y5503x6opJyDiQCvm+11m+8ELgPzuDvN2GeLd6DlkamaQWnhhNn8BAH8yx1WGWmrjWon2lK9QOy9N/OCTGkKzxb+UQGYrfDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009618; c=relaxed/simple;
	bh=gBiSl2uhABKbCDWfms8GIT7oYE21MxAGUW51xXRxr6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGbQiOt4Hte3yOsCg/U/Tep0FgLRFGVhsV3ELy+FKhF1YPC2BTE+8E7NnP3Z8zQTPOUEYHznYEHkioAurA4J610ekmDKQVJsX1vuB4sMiX6T1KjicgHZrL4tv4ChHO23jOh7c5Rkh1/PlOz+y+YMKB1cccejIZoGAh0By7moWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pPtStScf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pPtStScf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GX
	yIC8PcohYv2ltnWL7y0T8HaWwTtU9JoH17lhGRMMs=; b=pPtStScfoQp6a06NQp
	Zg2sdbqmU65SOAQo9W03ApXtZdgq2u0TJvnECEExisOIiO5y0N2QGch9RG4CtXOi
	CSaHmt9lXlyWkxslInBzczrPv4an1rVYZtn+bT3nNoa4GxTLJr/gVHiqFjOszSfq
	0GfKuVg7nnLPJ+0nlglKRonp4=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXfwCHDChqml32CQ--.44113S2;
	Tue, 09 Jun 2026 20:52:26 +0800 (CST)
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
Subject: [PATCH bpf v6 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Tue,  9 Jun 2026 20:52:12 +0800
Message-ID: <20260609125214.3096351-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608142618.3064380-1-chenyuan_fl@163.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXfwCHDChqml32CQ--.44113S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDZFW5tF4rKF43GrWkCrg_yoW8Ary5pF
	WrAFn0kr48J3WxWas3Ar4xur1rKws5Xw43GF9xK34FyFs8XF18XFyrtr1Sqay5tr9xX3y2
	v3WIqrZ5W3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHGQDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgrJh2ooDIrjfgAA3f

From: Yuan Chen <chenyuan@kylinos.cn>

v5: https://lore.kernel.org/bpf/20260608142618.3064380-1-chenyuan_fl@163.com/

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
- Patch 1: extend the kfunc allow-list to cover all KF_IMPLICIT_ARGS
  kfuncs handled in bpf_fixup_kfunc_call(): obj_new, percpu_obj_new,
  obj_drop, percpu_obj_drop, refcount_acquire, list_push, rbtree_add.
- Patch 2: simplify the selftest by verifying aux->name in
  bpf_kfunc_implicit_arg() instead of adding a separate struct_ops
  test program with inline assembly.

v6 changes:
- Patch 1: fix comment formatting to follow kernel style (Eduard
  Zingerman).

Yuan Chen (2):
  bpf: Fix kfunc implicit arg inject type detection to prevent invalid
    pointer deref
  selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

 kernel/bpf/verifier.c                              | 20 +++++++++++++++++++-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.54.0

