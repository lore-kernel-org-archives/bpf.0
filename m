Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D030D3EF;
	Thu,  6 Aug 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985506; cv=none; b=bKKYp0kUC+pcfQIVsf2hORq+E4UXjrgwzIIMyAdO1bgfbCI6V5gBVCMFxRR1pFs72AQAW1D84VV2X8SYKyhHJNbDOzFHAAZEgnndEf3jPq+OJW656ydoPnzqkufJhiXqiUEh9bJ30MShgXlARBTUroTOTh6Zr/abfbIUz9vJJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985506; c=relaxed/simple;
	bh=HubZqEzSK2piMJ7hYh/WQ9CRCGWd/f972rfvQ5fHS4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtxvAicInDMPBGnrPR+XQTW9KwxQ3tB4wVG0PPOzRrx0ap0jKNOt205s6eOHE3sBtvh06/Q5KKeFn7PQ+7v4PA8pLNRQ/Sl5kwXiN2tzubAG0O5yaGxx2Tj0TuROiLvdYDhqrL61pFwbsKdYKVYjpkiWMXw3tbT6Un6Vm4FJRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dKLPXBQ+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dKLPXBQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1t
	GJzcPujlQGstMnC2Nxu2HVEszqw9Kw3q1K1Tu/+Mw=; b=dKLPXBQ+CL6L1XhCKG
	vmxs4y6WKxOp95Cz+pRP7MfuAD07n1qnDcB4ajZleP+uDdKcj+M0tooBQH7S6Xf9
	fYMzZCX17HWE/z4wnzemjMwciI1bYNWcrAlWlRzeCNSVcmf/mhKPEx04jsgcL8jm
	gdXbQE8l8Iiw37M9Ay1/W68io=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3Xy2m+XNqWvt+Kw--.33251S3;
	Thu, 06 Aug 2026 11:04:10 +0800 (CST)
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
Subject: [PATCH bpf-next v1 1/3] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
Date: Thu,  6 Aug 2026 11:03:57 +0800
Message-ID: <20260806030359.299480-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806030359.299480-1-chenyuan_fl@163.com>
References: <20260806030359.299480-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3Xy2m+XNqWvt+Kw--.33251S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWUur13Gr4DJrWkGw48JFb_yoW8WFW5pw
	4UK345C390q3yUWa9aga1kCry5Ca1fXr48taySgw4vyw15Aws7ZrnY9r429ayDCFZ2v3W5
	tF1jva1xK3WUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCPfdUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gsg3Wpz+astjgAA34

From: Yuan Chen <chenyuan@kylinos.cn>

range_tree_clear() modifies the range tree before allocating the node
needed to split a range.  If the allocation fails, the function returns
-ENOMEM with part of the range already removed from the tree, leaving
those arena slots permanently unavailable.

Pre-allocate the node before modifying the tree so a failure leaves it
unmodified.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/range_tree.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 2f28886f3ff7..24fa32d4356b 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -143,16 +143,21 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 		if (rn->rn_start < start && rn->rn_last > last) {
 			u32 old_last = rn->rn_last;
 
+			/* Pre-allocate the right-half node before modifying
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

