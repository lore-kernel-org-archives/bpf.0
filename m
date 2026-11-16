Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842910;
	b=5kqtgS2Ow7tbVM022sO4PjzaLt6zLfG8PCmuvGz/puev7v20Sxyjs19od5R25gUNL7UW
	 fh4k0y5XMLXxJc6Fw3PKlXQYwUYJSCCl9z9T2GKEC3VzBDInwwYnY4N0745kYC9aGDJ5G
	 oC9izJtL2WtzaLYqFk6avXCYUt6QNlSz04zjwJqem37eWopENIB8A4V54fl0SkZ7iHiPr
	 G1+b2E68ZIeQ8EhFFuavjc5O+Zt2jYqs7mCw8nZkeC3Fw1u/lYOx3LVeR5HVwdd62S9xL
	 kQiFhHknF4WiN4XQ/Tm2vZY3ZLA8qnmo7NBzV35Ci2FKFFQuPYrNCiD+YFsJ/GXZgyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pCFKSzbGNiCmt/NfrWwwjrnsctzdowJzxHosdOXseA=;
	b=a9I30XyjlhUg9wJGL5JkXYsI9Rx9Z7DNEYh4Es8lR6v7qk2aKSUJqJWAlnTmL3K6VGw/
	 gbAThEoYKJzsb4rv468TlqWHkvCKGyEwD6M9BPyS/J3VqLhaveF1JeWMtdKscmypWUao1
	 JtwDBaDf8x5mpzSCqrrxc9pPPI2VvEFdUg/UOLfAfIsXRvdnK1ICa630hGfJE7mArfhTA
	 WtdkEsqh7DkO8cpkIxxdKDWpTnbyGcHWiPi+tLL5xgTNM/lPpHKmd12ERAivmg3i4yskN
	 ghlvjGw5psTR8gwU+FLSgnmxYrbWlgbtgkfvcAxr9EQ3p6jq3Ldio/jF7JxjjNsst0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPWPlWO7;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E031606A330
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E031606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPWPlWO7
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2846041a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842908; x=1795447708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pCFKSzbGNiCmt/NfrWwwjrnsctzdowJzxHosdOXseA=;
        b=qPWPlWO7m9482qY/FfpG2D9z6fETCVzeiCG4JoXxtwRiDHdnS1W4KHykGKI1oNtnFv
         M4QUr+WyKs/hVWboDrBL+b5JNQtz2Vlu9Coec2xnBoVC+hVXJ8O2unViknylQlz/25OL
         ISEx8mGB+3spnZG8U75F1eoR52IjND7sOz+4mMuTiLwR6eRMcRYE/61veFxU8jnSnoTQ
         wL/HaDnd/Rg0pWuxCVhSgAc8tPOhrxAcICOEcmsYv5/t00AtHozgosQpBKHfHVnk+1x3
         e+R3R+7o7vKodIbn/Ei7R6YEvF8PpP9fVc7QfpNUyudnrfRyGEYFyGVDUAONoBoUsvuS
         GAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842908; x=1795447708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pCFKSzbGNiCmt/NfrWwwjrnsctzdowJzxHosdOXseA=;
        b=tVwleb9druH5HX3xLj3Bo9jfKjUB/NRGcXHyEkyA919WRV2mHouQtBtXOxxxbuwbTn
         8El9j0u2DIsXEr2e2yDxBKEm98tIGCyjqw9+baEgXPFwMnpUSg4WA2jVyDTrGawiF6K8
         zNsZr/IFCdMVewvVWjtyTlKuijTWlvah1IBGux5by0zkogrXB7v3y1Dl0Qgy7UgoTnov
         LT7xbWiSi2NtT7nvTS8JzoBvDqeDqWLpJgw97rF74IHHpPE13bu+K3cUBQL2Q879XG22
         3pnCeBv45cuwB5FbHWmXTXid5JAnhGrsmCVFq33pK9WqPU9X+vfGXO5104AWeMoYfTf7
         9TRQ==
X-Gm-Message-State: APuU4Z/NIZ6lAbeY0DgewE4cOTtWAE2tgr08UcBi/0Rk0xfH2f3pblFv
	1i3jw/9boaRmZp1WBsZAnx06gJKNI3WN+kQn2Vxh3uPVRgXw70ys8xgthKBiMw==
X-Gm-Gg: AYBFou3R95RvZrgulKXdyTl++9/f/7UL1VfAO99Q0RduPzvqWBItD2z27rhJWVPctgp
	hizBP4QfuTdX+Mq65WHocTa/KXIYPwprQpXf0kakPXXXy9LV25Aa+zToitDBaYzAJIuFh03eaK8
	y9J3WfD7fTC4N9M5ZU7JKPDfvH8xyp5U2uAxZuNUtdeVAMPUA8WdJBP3XDuTk/hve14Nq7m+Xzh
	zNfJHNHzmz1ggJmGCICAIA3zrhV0hchVVCD+oiXC16hqQEjBSr6Y+7buIbgDVlz2eao2Q0J/NPy
	7yjYDhHqnnVOCJhoeNaz9m0heh8mYjafn5/c6TaKc3OQOBChhA0x6lz4gQRcekniInz05lOandy
	VUvDQRgmTaCYIDhWWIqnfaR/dMOyXj7PGPu2N3bE3x1AKRXUKm8ruzISVevhljiorDtZFnZagYT
	ToQRaqCFT3W9JqWOFqDdmU7ZPb5qeKURX91KaeKiFhKIENgXhhYQKfKuja/uwnDEStEmYee2xCM
	CZ6oZStHJe2Lh1W0r4MofX/8SBddssQoZsGnSxOzUcCAezsGnv5p7d8mc3uwbWb3qLE9eNaUx/F
	mP304oN3ysC0KAa+yFnkfPcMzTHr3xUd4anrLe4efYijaA//CFe15Tg2ISxM+5S9LpkFO6pVcjL
	KlFtNW7MQrk7qdpz5jMk3XkYa96OJmeYUx8h5XdNRAtBU3L+jEgCv67NgPvF/d8QjlZGQ+voYiw
	==
X-Received: by 2002:a05:6a20:9e4e:b0:3e2:827b:2b7e with SMTP id adf61e73a8af0-3f7a6ea143cmr10593505637.28.1794842908341;
        Mon, 16 Nov 2026 07:28:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdddc55efefsm3663552a12.6.2026.11.16.07.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 19/21] bpf: Find dominators in O(n log n)
Date: Mon, 16 Nov 2026 15:26:24 +0000
Message-ID: <20261116152626.4032587-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The intersection walks up the dominator tree for each predecessor. Many
edges to one insn make it quadratic:

  if ... goto out      30000 of them take 13 s, 100000 do not finish
  if ... goto out
  ...
  out:

Use the algorithm of Lengauer and Tarjan, with path compression.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/loops.c | 157 ++++++++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 59 deletions(-)

diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 434c5acfc2e1..110197685051 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -96,78 +96,117 @@ static int idoms_intersect(struct bpf_verifier_env *env, int a, int b)
 	return a;
 }
 
-/* See "A Simple, Fast Dominance Algorithm" by Cooper et al. for details. */
-static int compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray **preds,
-				int subprog_idx)
-{
-	struct bpf_subprog_info *subprog = &env->subprog_info[subprog_idx];
-	int start = subprog->start;
-	int po_first = subprog->postorder_start;
-	int po_last = (subprog + 1)->postorder_start - 1;
-	int *idoms = env->idoms;
-	int po_num, pred;
-	bool changed;
+/* An insn. The nodes are in the order of a depth-first walk, node 0 is none. */
+struct idom_node {
+	u32 insn;
+	u32 parent;	/* in the walk */
+	u32 semi;	/* semidominator */
+	u32 idom;
+	u32 up;		/* a parent, or a parent of it, once the node is done */
+	u32 min;	/* the node with the lowest 'semi' on the way to 'up' */
+	u32 bucket;	/* list of the nodes whose 'semi' this node is */
+	u32 next;	/* in that list. Before that the next successor for the walk */
+};
 
-	idoms[start] = start;
-	changed = true;
-	do {
-		changed = false;
-		/*
-		 * Iterate in reverse postorder, skipping the subprog entry:
-		 * insn_postorder[po_last] is the subprogram entry.
-		 */
-		for (po_num = po_last - 1; po_num >= po_first; po_num--) {
-			int idx = env->cfg.insn_postorder[po_num];
-			int new_idom = -1;
-
-			iarray_for_each(pred, preds[idx]) {
-				if (bpf_must_abort())
-					return -EINTR;
-
-				if (idoms[pred] == -1)
-					continue;
-				if (new_idom == -1)
-					new_idom = pred;
-				else
-					new_idom = idoms_intersect(env, pred, new_idom);
-			}
-			if (new_idom != -1 && idoms[idx] != new_idom) {
-				idoms[idx] = new_idom;
-				changed = true;
-			}
-		}
-	} while (changed);
-	idoms[start] = -1;
-	return 0;
+/* The node with the lowest 'semi' on the way up from node 'id'. Makes the way short. */
+static u32 idom_eval(struct idom_node *nodes, u32 *path, u32 id)
+{
+	struct idom_node *node, *up;
+	u32 cnt = 0, cur;
+
+	for (cur = id; nodes[nodes[cur].up].up; cur = nodes[cur].up)
+		path[cnt++] = cur;
+	while (cnt--) {
+		node = &nodes[path[cnt]];
+		up = &nodes[node->up];
+		if (nodes[up->min].semi < nodes[node->min].semi)
+			node->min = up->min;
+		node->up = up->up;
+	}
+	return nodes[id].min;
 }
 
+/*
+ * See "A Fast Algorithm for Finding Dominators in a Flowgraph" by Lengauer and Tarjan.
+ *
+ *   1 -> 2 -> 3 -> 4      walk:          parent[4] = 3
+ *   |              ^      from the end:  semi[4] = 1
+ *   +-> 5 ---------+      from the top:  idom[4] = 1
+ */
 int bpf_compute_idoms(struct bpf_verifier_env *env)
 {
-	struct bpf_iarray **preds;
-	u32 len = env->prog->len;
-	int *idoms, i, err = 0;
+	u32 len = env->prog->len, cnt = 0, i, insn, id, cur, best, *num, *path;
+	struct bpf_iarray **preds, *succ;
+	struct idom_node *nodes, *node;
+	int err = -ENOMEM;
 
 	preds = compute_predecessors(env);
-	if (!preds)
-		return -ENOMEM;
+	env->idoms = kvmalloc_objs(*env->idoms, len, BPF_VERIFIER_GFP);
+	nodes = kvzalloc_objs(*nodes, len + 1, BPF_VERIFIER_GFP);
+	/* insn -> node */
+	num = kvzalloc_objs(*num, 2 * (size_t)len, BPF_VERIFIER_GFP);
+	path = num + len;
+	if (!preds || !env->idoms || !nodes || !num)
+		goto out;
+	memset(env->idoms, 0xff, len * sizeof(*env->idoms));
 
-	idoms = kvzalloc_objs(*idoms, len, BPF_VERIFIER_GFP);
-	if (!idoms) {
-		kvfree(preds);
-		return -ENOMEM;
+	err = -EINTR;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		insn = env->subprog_info[i].start;
+		for (cur = 0;; insn = succ->items[nodes[cur].next++]) {
+			if (!num[insn]) {
+				num[insn] = ++cnt;
+				nodes[cnt] = (struct idom_node){ insn, cur, cnt, .min = cnt };
+				cur = cnt;
+			}
+			if (bpf_must_abort())
+				goto out;
+			/* go back to a node that has a successor left */
+			for (; cur; cur = nodes[cur].parent) {
+				succ = bpf_insn_successors(env, nodes[cur].insn);
+				if (nodes[cur].next < succ->cnt)
+					break;
+			}
+			if (!cur)
+				break;
+		}
 	}
 
-	env->idoms = idoms;
-	for (i = 0; i < len; i++)
-		idoms[i] = -1;
-
-	for (i = 0; i < env->subprog_cnt; i++) {
-		err = compute_subprog_idoms(env, preds, i);
-		if (err)
-			break;
+	for (id = cnt; id; id--) {
+		node = &nodes[id];
+		if (!node->parent)
+			continue;
+		iarray_for_each(insn, preds[node->insn]) {
+			if (bpf_must_abort())
+				goto out;
+			if (!num[insn])
+				continue;
+			best = idom_eval(nodes, path, num[insn]);
+			node->semi = min(node->semi, nodes[best].semi);
+		}
+		node->next = nodes[node->semi].bucket;
+		nodes[node->semi].bucket = id;
+		node->up = node->parent;
+		for (cur = nodes[node->parent].bucket; cur; cur = nodes[cur].next) {
+			best = idom_eval(nodes, path, cur);
+			nodes[cur].idom = nodes[best].semi < nodes[cur].semi ? best : node->parent;
+		}
+		nodes[node->parent].bucket = 0;
 	}
 
+	for (id = 1; id <= cnt; id++) {
+		node = &nodes[id];
+		if (!node->parent)
+			continue;
+		if (node->idom != node->semi)
+			node->idom = nodes[node->idom].idom;
+		env->idoms[node->insn] = nodes[node->idom].insn;
+	}
+	err = 0;
+out:
 	kvfree(preds);
+	kvfree(nodes);
+	kvfree(num);
 	return err;
 }
 
-- 
2.55.0

