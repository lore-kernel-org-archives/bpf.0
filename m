Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C39658D;
	Mon, 10 Aug 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355254; cv=none; b=VxkoXHQIaEV2CyOqciUvkoRcmC7UimKXP+TTVWRxRDgKYbMWjs88DSHwyR1jsBNKyu2L2wi/hLfLtBNTFgAus5AJwOYCgKrGxWKxJx5YVybvtuZEjgkdWnSh+T7HMBsEY9MQy0fT8mUk6bcGSEUXzEeQvuYyZB/DrFjx8XqMYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355254; c=relaxed/simple;
	bh=NiyyWUH1prkVse1OkE9B2qMJ6JZL7ZE6Xekm99UEJDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1Sg4t6sC8siDVzyq0keWmqT1iiPZXEBRmxul+BQYXUFlQuI8b9/sT2ur9133t1S7taUvRMYsa/NSVbseNJZBM+6mnr5AdGc0iKwpcDjeF25oBZlYiO6Y9XmTsaUo/kBkGSRmkpMjfWBsxf3f/1TaGDgX5+zNiXOgJtUSK7dSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YWRHkeFt; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YWRHkeFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+J
	HuhUJjxcmnFhFTzIqRT3sPERPM9fOZMeWKzbtsUd0=; b=YWRHkeFt+42H8fzQtQ
	KYH5up6PEsCQRCavzvBh+d5lmTedfpz02CPgBqXBygQ27TVKuhC2vj5akSiQEE0q
	6nPIEs1ErW+M3UfIWQbhZ2Ont0B4cGGGVjGhhDkGk7XDzdgdQnZZWitit0fKU6zi
	IobQka3iLSY+eA/WyOkRfMTqo=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3EocEnnlqAlAcOg--.9113S3;
	Mon, 10 Aug 2026 17:46:48 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/3] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
Date: Mon, 10 Aug 2026 17:46:32 +0800
Message-ID: <20260810094634.2723213-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810094634.2723213-1-chenyuan_fl@163.com>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3EocEnnlqAlAcOg--.9113S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48Xw45trWrXFyUuFW8tFb_yoW8GF1fpw
	4UK34fAws0q3yUWrZa9F4vkr98Can3Xr48K343tw4kAr15A3Z7urnY9r4293ZrAFZFy3Wr
	tF1jva9rK3WUuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZeOXUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5giiYGp5ngj98gAA3m

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

