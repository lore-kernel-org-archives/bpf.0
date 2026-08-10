Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679A3E2769;
	Mon, 10 Aug 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369766; cv=none; b=j5eronq76BK0QTWQVTjO/NBmfF5u6+VX6IHIv9Q4NkSNokasInwWv7VZ2oHGMZn/sFZEqAQ0v8b77hJl9YCAmLRNxgCPRypt2Xo2V5KegDWlijB0Rl08MIEop7xLxK6rx6+GtXP/EYP16MC8jlqGirGIS/j2DHj7LpqVj0yc/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369766; c=relaxed/simple;
	bh=NiyyWUH1prkVse1OkE9B2qMJ6JZL7ZE6Xekm99UEJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Br0Fim2KSiIrrEoJ92n7eGawSQGan1oe52tEhXm3VOrNCXrZ1gQMadfjFk4tpuvhtBIw2gmyAF0rY3dUpTcxFL/t5wW8syqvP0S1qt03CHdtPwUP/JfpR+gjMdgvM8CCSRAMUy+jLpqh2763yAPZDfSfYXXKmp9DT0GYNUC5GxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pkpwnf24; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pkpwnf24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+J
	HuhUJjxcmnFhFTzIqRT3sPERPM9fOZMeWKzbtsUd0=; b=Pkpwnf24l5G1mcfd26
	r9exk9hJfBFhveYYt5PmUlA2K6yNwt+DTBLSgr6Hr7pG+aY/2lA87BeBduKRY3qW
	CrR8t4HOGL8B8jw+OzpZK46smIsfKuU8/xYBRMhkPoupSPX9Yoahb35tgykmOhVw
	PwPWfIMRktXzv4ynTxPCR2P1k=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnJImg1nlqBKwLPA--.27752S3;
	Mon, 10 Aug 2026 21:48:20 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/3] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
Date: Mon, 10 Aug 2026 21:47:58 +0800
Message-ID: <20260810134800.2875487-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810134800.2875487-1-chenyuan_fl@163.com>
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnJImg1nlqBKwLPA--.27752S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48Xw45trWrXFyUuFW8tFb_yoW8GF1fpw
	4UK34fAws0q3yUWrZa9F4vkr98Can3Xr48K343tw4kAr15A3Z7urnY9r4293ZrAFZFy3Wr
	tF1jva9rK3WUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZeOXUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgXXlWp51qVw-wAA3q

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_clear() pre-allocates the right-half node before modifying
the tree, so an allocation failure returns -ENOMEM without altering the
range tree.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/range_tree.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 2f28886f3ff7..15b588377a76 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -143,16 +143,22 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 		if (rn->rn_start < start && rn->rn_last > last) {
 			u32 old_last = rn->rn_last;
 
+			/*
+			 * Pre-allocate the right-half node before modifying
+			 * the tree. If allocation fails we return -ENOMEM
+			 * without altering the range tree.
+			 */
+			new_rn = kmalloc_nolock(sizeof(struct range_node),
+						__GFP_ACCOUNT, NUMA_NO_NODE);
+			if (!new_rn)
+				return -ENOMEM;
+
 			/* Overlaps with the entire clearing range */
 			range_it_remove(rn, rt);
 			rn->rn_last = start - 1;
 			range_it_insert(rn, rt);
 
-			/* Add a range */
-			new_rn = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
-						NUMA_NO_NODE);
-			if (!new_rn)
-				return -ENOMEM;
+			/* Add right-half range */
 			new_rn->rn_start = last + 1;
 			new_rn->rn_last = old_last;
 			range_it_insert(new_rn, rt);
-- 
2.54.0

