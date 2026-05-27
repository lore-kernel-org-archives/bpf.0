Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC734B1A2;
	Wed, 27 May 2026 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865392; cv=none; b=LD1j3CaSK+rAaafqZ5VHxXoGSlIuqo4/j7iJOqzgFG3SUoCzQBmZDLREI+QXBYSmV4xWehSZai5EqWQbJdWkblTaq7Oq+CsVsxW5ljYP9l+68KGmEszx3eMZWvXUvJ9cvoG40MzAAaTInz0BHcrDCzlhy1QhYvPeam7XvMGbQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865392; c=relaxed/simple;
	bh=Wz5dkHcr/8Fgnx7wVe8DVdciMyu1LkdXn1eRAnR2EZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifQJBAwg7g6Y/+egt22us9WRz3rq7hozNndo28th8RiufNvdKRF8nEPMh08okgM1Hr2bsvxopRA0lPL28pnIpG02wukx2SyxptdcrLXnWg0OkMLDVE+4YxCbk6vevFi/qAvtu90diRDRN0KC9eao1IWDGdsdljHZ0ZFntgPGM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TRRXu5sG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TRRXu5sG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779865387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=reeKTNeV+W0ckzeI48y8gSfKBXyE9QHqe8K1WaY8ehM=;
	b=TRRXu5sGXOEEolIn/dezDUVD7qB70L3VhwW1j60Y37knwIjmCNC/F5mFv15515liEFOhvS
	kRXqVvfx55Ew+j8a6I2aU5emsnrZ+Jy3in98mQkWeg+h+o/MyzzNsUgG6vaiWdD9c/TJsj
	8VpA69zWdMbcWD3bST1+6shYBEATnAg=
From: xuanqiang.luo@linux.dev
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH bpf-next v1] bpf: Use hlist_nulls_replace_rcu() when updating htab elements
Date: Wed, 27 May 2026 15:01:39 +0800
Message-ID: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

When updating an existing element, the current code does
hlist_nulls_add_head_rcu() followed by hlist_nulls_del_rcu(), exposing
a transient state where both old and new elements are visible to
concurrent RCU traversals.

Use hlist_nulls_replace_rcu() to atomically replace the old element in
place, so RCU readers always see a consistent hash chain.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 kernel/bpf/hashtab.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4f..b20e82bd253dc 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1246,18 +1246,16 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		goto err;
 	}
 
-	/* add new element to the head of the list, so that
-	 * concurrent search will find it before old elem
-	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	if (l_old) {
-		hlist_nulls_del_rcu(&l_old->hash_node);
+		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);
 
 		/* l_old has already been stashed in htab->extra_elems, free
 		 * its special fields before it is available for reuse.
 		 */
 		if (htab_is_prealloc(htab))
 			check_and_free_fields(htab, l_old);
+	} else {
+		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	}
 	htab_unlock_bucket(b, flags);
 	if (l_old && !htab_is_prealloc(htab))
@@ -1319,13 +1317,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err;
 
-	/* add new element to the head of the list, so that
-	 * concurrent search will find it before old elem
-	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	if (l_old) {
 		bpf_lru_node_set_ref(&l_new->lru_node);
-		hlist_nulls_del_rcu(&l_old->hash_node);
+		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);
+	} else {
+		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	}
 	ret = 0;
 
-- 
2.43.0

