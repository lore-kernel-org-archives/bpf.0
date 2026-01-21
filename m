Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592D48C8AA
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003694; cv=none; b=k2Pu2s0qEirUumDj3prO0duRpHJDkaYiRB0jLBJHyaz2SsJ0RjULql0df9SLTJJpd9UDGk6uICDELZ2UMSyvSDLP2iUcGWFIuSAw1xBGsfJwkuaof0h4Hk/Y6aG7FL1Nc3Mt5vzNIP3I5uv2/Q+qOE63QfLJlvHhn07c2kHV/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003694; c=relaxed/simple;
	bh=mn52w57IGwLyg4F0iPl8OxyKn6/fE3zmNL9nKdurqUo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D34xeF1ITIY0tpcxKyI0jflfA1+evjz4IppnfkCuZvJ1LBwYRJttsg/XEVQQ1PXW1Tr8UgVd3o9EeLyGOes97JVtLhyE33r+KEPV1rY5ywVDZ1V5kOXDa9+N1qxBKxh+V7pkvywIeC3NfgiqnsCy019OtK3IHlfehwRZEKWuUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JBrc4kbj; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBrc4kbj"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b874c378d07so776671866b.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 05:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769003687; x=1769608487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fdF0Vj53hzIq5AP8upzVPf2kSown2Q3VxoKxApaGyqA=;
        b=JBrc4kbj7Vhc62L4pZTvbGWT2myZFeaZ50CB58yniuoWID+8NO2GGGaqsrsT3+FJrl
         obcN6m3pTj6cqjrJvEuzyFpyzjyupF5QS65Ys5KURVE+6xRDJOLBqWKNfRTy8N6R+YUf
         vPqVt5Ze+09wcVevJFTuWUMB2DpxTezcvZ9zveMwu5oi9zniimtfrFVIAhioHG11930v
         afAYW1sNPQXy8V0rbqhABG3V71aM1MnKAr0tEp5skXbcU9IIpW21pQe2fNj4rY6BubJ7
         iZS76UFbke19xb/ZwnJWnQOcDri/bScdAuA+y3IAlN3pccpulPm1EHUYwjPjUqwgPEPJ
         Gjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003687; x=1769608487;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdF0Vj53hzIq5AP8upzVPf2kSown2Q3VxoKxApaGyqA=;
        b=JhsUMH1cUvOiraEbSHLDMpVe3yfUqLCbeM4fuKVPqZE8qqzUP9DlIp6lgjmixJ2I9N
         /ux3SWW2VWEax+++3doMSKmmKOmBeEIDQTz+NHArXLxPTrznlxe3aiL8TjOnQRUHADky
         n5SrE56oTUQNMUQNonQ5MKmIxQfQs5X7RLfWOcX7e/ukiCNTbuL6xhrMRF63pRd8Sy5x
         403b68R8q+FQAh3CRTaVPFr3gnz982mpl7o0IgW1ERqruH/BjwPukA45f8zjwIQd5gz4
         AlL+DeW8lWWDt03DplyGdGC8ojUl5AZf/sl3DOEbrbOWU+/ET9lOagoGZfq3kHEvNmPL
         BLmg==
X-Gm-Message-State: AOJu0Yyq4TI1bkod3GGmyZ0UPw4TYGT1jzfzM5xoIBCg+eK+HWHL85jJ
	q1muNV4wua9dwqL/ZLeecWcmfYqa0am00v4qlxW6MpB8LyXUA5DInZN44J0Lg9w2sRfOQL7DVQh
	yXd9pKXb3S3t/rr4jcV4AKYvcleHPepRwIdRU2aEPhsRykMrnhcuFiKcnyqoIDAz9HD9wzPfp2R
	tQD1WVBXH1TmvYohxF3gZLNCT1XoclNaVXvOLydhx/KBfuBhoa8fyCtrNQACLIIZQ0GJPtYw==
X-Received: from ejaw17.prod.google.com ([2002:a17:906:33d1:b0:b87:273e:ed3a])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:5c9:b0:b87:20eb:a66d with SMTP id a640c23a62f3a-b87932eb188mr1443108966b.65.1769003687453;
 Wed, 21 Jan 2026 05:54:47 -0800 (PST)
Date: Wed, 21 Jan 2026 13:54:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121135444.187001-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the BPF cgroup iterator supports walking descendants in
either pre-order (BPF_CGROUP_ITER_DESCENDANTS_PRE) or post-order
(BPF_CGROUP_ITER_DESCENDANTS_POST). These modes perform an exhaustive
depth-first search (DFS) of the hierarchy. In scenarios where a BPF
program may need to inspect only the direct children of a given parent
cgroup, a full DFS is unnecessarily expensive.

This patch introduces a new BPF cgroup iterator control option,
BPF_CGROUP_ITER_CHILDREN_ONLY. This control option restricts the
traversal to the immediate children of a specified parent cgroup,
allowing for more targeted and efficient iteration, particularly when
exhaustive depth-first search (DFS) traversal is not required.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 include/uapi/linux/bpf.h       | 16 ++++++++++++----
 kernel/bpf/cgroup_iter.c       | 26 +++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++----
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a2ade4be60f..eae8f9133df2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -115,10 +115,18 @@ struct bpf_cgroup_storage_key {
 
 enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_ORDER_UNSPEC = 0,
-	BPF_CGROUP_ITER_SELF_ONLY,		/* process only a single object. */
-	BPF_CGROUP_ITER_DESCENDANTS_PRE,	/* walk descendants in pre-order. */
-	BPF_CGROUP_ITER_DESCENDANTS_POST,	/* walk descendants in post-order. */
-	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
+	BPF_CGROUP_ITER_SELF_ONLY, 		/* process only a single object. */
+	BPF_CGROUP_ITER_DESCENDANTS_PRE, 	/* walk descendants in pre-order. */
+	BPF_CGROUP_ITER_DESCENDANTS_POST, 	/* walk descendants in post-order. */
+	BPF_CGROUP_ITER_ANCESTORS_UP, 		/* walk ancestors upward. */
+	/*
+	 * Walks the immediate children of the specified parent
+	 * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
+	 * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTORS_UP
+	 * the iterator does not include the specified parent as one of the
+	 * returned iterator elements.
+	 */
+	BPF_CGROUP_ITER_CHILDREN_ONLY,
 };
 
 union bpf_iter_link_info {
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index f04a468cf6a7..bca95bbfecf0 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -8,12 +8,13 @@
 
 #include "../cgroup/cgroup-internal.h"  /* cgroup_mutex and cgroup_is_dead */
 
-/* cgroup_iter provides four modes of traversal to the cgroup hierarchy.
+/* cgroup_iter provides five modes of traversal to the cgroup hierarchy.
  *
  *  1. Walk the descendants of a cgroup in pre-order.
  *  2. Walk the descendants of a cgroup in post-order.
  *  3. Walk the ancestors of a cgroup.
  *  4. Show the given cgroup only.
+ *  5. Walk only the children of a given parent cgroup.
  *
  * For walking descendants, cgroup_iter can walk in either pre-order or
  * post-order. For walking ancestors, the iter walks up from a cgroup to
@@ -78,6 +79,8 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 		return css_next_descendant_pre(NULL, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_DESCENDANTS_POST)
 		return css_next_descendant_post(NULL, p->start_css);
+	else if (p->order == BPF_CGROUP_ITER_CHILDREN_ONLY)
+		return css_next_child(NULL, p->start_css);
 	else /* BPF_CGROUP_ITER_SELF_ONLY and BPF_CGROUP_ITER_ANCESTORS_UP */
 		return p->start_css;
 }
@@ -113,6 +116,8 @@ static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return css_next_descendant_post(curr, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_ANCESTORS_UP)
 		return curr->parent;
+	else if (p->order == BPF_CGROUP_ITER_CHILDREN_ONLY)
+		return css_next_child(curr, p->start_css);
 	else  /* BPF_CGROUP_ITER_SELF_ONLY */
 		return NULL;
 }
@@ -200,11 +205,16 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 	int order = linfo->cgroup.order;
 	struct cgroup *cgrp;
 
-	if (order != BPF_CGROUP_ITER_DESCENDANTS_PRE &&
-	    order != BPF_CGROUP_ITER_DESCENDANTS_POST &&
-	    order != BPF_CGROUP_ITER_ANCESTORS_UP &&
-	    order != BPF_CGROUP_ITER_SELF_ONLY)
+	switch (order) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+	case BPF_CGROUP_ITER_SELF_ONLY:
+	case BPF_CGROUP_ITER_CHILDREN_ONLY:
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	if (fd && id)
 		return -EINVAL;
@@ -257,6 +267,8 @@ static void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
 		seq_puts(seq, "order: descendants_post\n");
 	else if (aux->cgroup.order == BPF_CGROUP_ITER_ANCESTORS_UP)
 		seq_puts(seq, "order: ancestors_up\n");
+	else if (aux->cgroup.order == BPF_CGROUP_ITER_CHILDREN_ONLY)
+		seq_puts(seq, "order: children_only\n");
 	else /* BPF_CGROUP_ITER_SELF_ONLY */
 		seq_puts(seq, "order: self_only\n");
 }
@@ -320,6 +332,7 @@ __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
 	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
 	case BPF_CGROUP_ITER_DESCENDANTS_POST:
 	case BPF_CGROUP_ITER_ANCESTORS_UP:
+	case BPF_CGROUP_ITER_CHILDREN_ONLY:
 		break;
 	default:
 		return -EINVAL;
@@ -345,6 +358,9 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *i
 	case BPF_CGROUP_ITER_DESCENDANTS_POST:
 		kit->pos = css_next_descendant_post(kit->pos, kit->start);
 		break;
+	case BPF_CGROUP_ITER_CHILDREN_ONLY:
+		kit->pos = css_next_child(kit->pos, kit->start);
+		break;
 	case BPF_CGROUP_ITER_ANCESTORS_UP:
 		kit->pos = kit->pos ? kit->pos->parent : kit->start;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b816bc53d2e1..fa0686bbc638 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -115,10 +115,18 @@ struct bpf_cgroup_storage_key {
 
 enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_ORDER_UNSPEC = 0,
-	BPF_CGROUP_ITER_SELF_ONLY,		/* process only a single object. */
-	BPF_CGROUP_ITER_DESCENDANTS_PRE,	/* walk descendants in pre-order. */
-	BPF_CGROUP_ITER_DESCENDANTS_POST,	/* walk descendants in post-order. */
-	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
+	BPF_CGROUP_ITER_SELF_ONLY, 		/* process only a single object. */
+	BPF_CGROUP_ITER_DESCENDANTS_PRE, 	/* walk descendants in pre-order. */
+	BPF_CGROUP_ITER_DESCENDANTS_POST, 	/* walk descendants in post-order. */
+	BPF_CGROUP_ITER_ANCESTORS_UP, 		/* walk ancestors upward. */
+	/*
+	 * Walks the immediate children of the specified parent
+	 * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
+	 * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTORS_UP
+	 * the iterator does not include the specified parent as one of the
+	 * returned iterator elements.
+	 */
+	BPF_CGROUP_ITER_CHILDREN_ONLY,
 };
 
 union bpf_iter_link_info {
-- 
2.52.0.457.g6b5491de43-goog

