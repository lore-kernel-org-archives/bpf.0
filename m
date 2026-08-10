Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED53AFB06;
	Mon, 10 Aug 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355256; cv=none; b=RL0t0auLPvutYkAdFFRy3Ee1E9RffGlAVDuyovvh81EYvAgoTS62fCchBNi9xXMFLIZjqY6NsdJXa/Wq55TgyeMSquVue4X+bySgAUaxwisYtM+3mkoats+gG+huzc2gJTlIGR4unJ3bFa2cx3CdLRZwb70ATdLvtGU8brapGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355256; c=relaxed/simple;
	bh=wJ0hQRrXr6ePCulkPRgl2Y5PbgRXg1H5IVq6gBz+g8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3UDR4p03K/FefLfQcW/Me+4Bs/KD86K6MgDmiVoKu62zD38qw/tlvpxxQKUWDxy9MULiQ4KfSmwkgUHUgFiuT0eBCBNSROPdCDimcijgj48iMv47shiYXBwoF1AYiP3Om+ikMwrF+mK1PsqRTSw3yTvCc7C0AX410WbiCk2VpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CV7WbggQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CV7WbggQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=J6
	uNYGp0tyq9ZzYJXLqvSuztow2BYweYkrqYoraOhM8=; b=CV7WbggQ7hEVZSjVQO
	VACfQaBrlH2q5zEzqY3qsxVO2YTe33WEDlF7XignKUXNeYZMr0RaPdxjDSgRyVlH
	f11XS7AKy0zlRNm/9UvJDyuPrXV/1e4gePR9X6pGmXxv+MSFBoPhuvzV1n7I76U2
	nq6jRg/4tJaclx/C9Qc/AKczQ=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3EocEnnlqAlAcOg--.9113S2;
	Mon, 10 Aug 2026 17:46:45 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/3] bpf, arena: fix range_tree consistency on allocation failure
Date: Mon, 10 Aug 2026 17:46:31 +0800
Message-ID: <20260810094634.2723213-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3EocEnnlqAlAcOg--.9113S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4UGF43XFW5Gr1xWF18AFb_yoWfGrX_Ja
	48K34UW3yjqFWfGFy7CrWrZ348KrW5Kr10qFy0yw43Xry7ta1DGr4xAF1fJr18ZFW5Gryk
	CrZ0qFs3tr17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU83GYJUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQWhX2p5ngWU5gAA3A

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set(), patch 3 makes arena_free_pages() and
arena_free_worker() handle range_tree_set() failures.

Changes in v2:
  - Fix multi-line comment style in patches 1 and 3 (opening /* on its
    own line), as pointed out in review.

Yuan Chen (3):
  bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock
    failure
  bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
  bpf, arena: check range_tree_set return in arena_free_pages and
    arena_free_worker

 kernel/bpf/arena.c      | 18 ++++++++++--
 kernel/bpf/range_tree.c | 61 ++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.54.0

