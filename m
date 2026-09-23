Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C7373C17;
	Wed, 23 Sep 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153948; cv=none; b=ej8yfNRW+ovmzjwJinnBfDyM5MEPHjeyf1IJcp4StvC7TYM4IEekhhJRobPavtKnT7Vmg+gyReaEOIyoYgjxWnTpNM0tUK0KHopcPdDOXqvhri0XroSN5Gva9xStzb7S8vyZNJsnRwEo/o/OM8sT8IKNXAjYxpMOk5xURw117nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153948; c=relaxed/simple;
	bh=NiyyWUH1prkVse1OkE9B2qMJ6JZL7ZE6Xekm99UEJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtHfZnNl4rew/VT3XcnFk7wVTy8o6qARswQXCPvg2HzCSkY4rLiiwhgqtFZpITWYxG3Pf2DMNFGmkoqHIIqUssSsp8u36BOgPs4fBcyW72j0E0rvoPKjuk8cLE9s1YqGhm5CerEQ7ZlLmcQtsaDXVGSFRcjjZ0FOULYVqIxJ6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aSfUkqEY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aSfUkqEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+J
	HuhUJjxcmnFhFTzIqRT3sPERPM9fOZMeWKzbtsUd0=; b=aSfUkqEYUEbpOSLjbN
	R+PGsisldLXOmOD1CHKow4YDjMhMvC276slGFKkPx9Ws0vCj/WIyx5vzg3h3fdon
	nNSRvjn6L4YW0wQ5JrU4MG78iczLA88N7janqhCXZhYNLHUXCxIHA/CeCprsTYDa
	r9fra7lrPvTU/8Fdhfw9qTkWM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H8OylLNqSEwzAQ--.5285S3;
	Wed, 23 Sep 2026 16:58:28 +0800 (CST)
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
Subject: [PATCH bpf-next v7 1/2] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
Date: Wed, 23 Sep 2026 16:58:16 +0800
Message-ID: <20260923085817.365930-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923085817.365930-1-chenyuan_fl@163.com>
References: <DLMBR82RJV2B.3401V0ZRMT392@gmail.com>
 <20260923085817.365930-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H8OylLNqSEwzAQ--.5285S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48Xw45trWrXFyUuFW8tFb_yoW8GF1fpw
	4UK34fAws0q3yUWrZa9F4vkr98Can3Xr48K343tw4kAr15A3Z7urnY9r4293ZrAFZFy3Wr
	tF1jva9rK3WUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAPEhUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhXZl2qzlLUVJgAA3S

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

