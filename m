Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EA33B97B;
	Mon, 24 Aug 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578887; cv=none; b=dpTly9ZN85hsfH1RusnkgADLxD/51RStL4Vf3RhqR1Co9Txnovhg4UrWr7TYwvcq6W55IZhHf21sPPiwvwIOMOs2WvTconOenUudMQ/bcMVY8g0ABvN5Q1ZHk0Flv0lI8yomovOp6lTkKnRv9tE4MJ/thmlXmprHtrDgU4EcZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578887; c=relaxed/simple;
	bh=G8IYwxAbP4AB7tx8M+r6dzYPsZNyDVhrhnOvqL/NVq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFcsa+pWVpkcFZaFgHVtRD4xLEvpTC8wD3Jlf39NieMWz0SUuzH4tAFsOTM/8sfq1vwuUPVzDdhdcBs/Qbo6/F76TldR7FDt2Q6ZhnHDRLqIT9S9JtffHVhlfH+QBiLzEHppJeGJrViPWuOG+sc2sNDQInLPYX+E0Yxfrp4i/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AlVj/Dc0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AlVj/Dc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kN
	GRjNhc9YMoHfhS72o996O5geyvE+DfgEHw75nOxmk=; b=AlVj/Dc0E6OrWrvpDa
	d5PdfW5Ka7WfjDFDkSBieGVUqIb56VtR5mWOPMd81GS24VWiQiRROjlj0foZOBjo
	dz6uc+5caFZQ9MLAzG3GXFidJjly/lGhMtxcufkn1AOwdHWGEkOsb8YBxK6H/ffK
	+kwGeM6VRYae6OS+we+w/KUDk=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHGCDISYxqeuS4Nw--.46468S2;
	Mon, 24 Aug 2026 21:40:26 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/3] bpf, arena: fix range_tree consistency on allocation failure
Date: Mon, 24 Aug 2026 21:40:13 +0800
Message-ID: <20260824134016.2006188-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCHGCDISYxqeuS4Nw--.46468S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4fJw47AF4rtry7Zw1DZFb_yoW8Ar18pr
	W3Gws8JayDG3yfuF4fCr48XFn5Gw4rXw4UGry3Kw1kZry5Crn7tr40kF1UWr1UCFyfXw4r
	KF4Yqa4I934DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgpCAGqMScr5CwAA3d

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set(), patch 3 makes the arena free paths handle
range_tree_set() failures and checks the return value in
arena_alloc_pages()'s partial-allocation error path.

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

 kernel/bpf/arena.c      | 43 ++++++++++++++++++++++++-----
 kernel/bpf/range_tree.c | 61 ++++++++++++++++++++++++++++++-----------
 2 files changed, 81 insertions(+), 23 deletions(-)

-- 
2.54.0

