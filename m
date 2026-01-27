Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3C2D3A86
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503882; cv=none; b=K07+Bcl+wPrmybE1W+JNK83F2w8iZe2V8K7+q2zMdeV4LwuCpqoNmFZdUf/GZ3NiAw6uNAzEjFKS+DBuSL7GetQFGHZJUdGCi2HZtyRTwup2325zr47u2naN7U+KqT/KUsx6WotHzJqCXRKRJ2pIp0/ZULWf0Zo3ygokgI2ETlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503882; c=relaxed/simple;
	bh=id7IIuLqS24quSmLLVTgdw9V9R6iB1ngX7ST16bI0EM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V9lu0Lb5xjIXO6yhw6W60Ibk+wSIRcluFTOdLzOLIVL/Tm0oY76yu/tLjp1lGxoFFC23tN2EPva9Huq0QWJBOusW8woLSqftP88sdU9WzFRrqsz5CLpVjVEkgh8tkzGlzBzMXxzo4oGvvybPhBmexb+vPI1x7ojCZYxjjgrmH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hb//P3F1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb//P3F1"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso40028865e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769503879; x=1770108679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+aVMXllVCApJb8moiqFQznIT8m3ySHAmus/k/5n3hs0=;
        b=Hb//P3F1OKz5Cw5B5RkC0+Ku4Sm8Mq+AjEHWwM0yP44sIE/VAAXJuZpUB5ZaXvVpIv
         wO+6mjSRhv4gS3HIi9Z3mDuMxEw45Dac3o9/2uBnzDTODBmggB2LZt9yUu9JFshSb4Eh
         Cfgi7gPEQHjHvO9TJLrU/NQxvdo+KveLbvL1jhBHPPcq7u9vtfnlrpK3MogUGvgYyQoy
         ML0teKhxVjLTueh7mhUARTmLrtx89ztGmxbEi/0xvKyKD50dEY03yFmOcqxoALjwN1eW
         lYrfn+7fOMyxtFgTmvnRe1Mw1raUG1PqCqDGWnB0ecA+/vFq5ys0gJWE9+Dar44Mt4Ka
         wnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769503879; x=1770108679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aVMXllVCApJb8moiqFQznIT8m3ySHAmus/k/5n3hs0=;
        b=mVuo1cFtZmcIHk1eR88e/qDgKrdEOBU7sUbI0wgQZ/npphwNWl2xv8L5KvPSZlBE/d
         QPJcT0ynca4vt5iRhTCuDPr0OdBGbcux/3gdmb49hIwmUuWpbm2HCO0sji9EwVJQQ/Nb
         LZSpXuGnmgPldFqlVTUNK9npq0X1g16fjqeKpGqzYPhAxrOvGz/671yfACzu0TUdQX9c
         /i6yLSsG9q5hVlxz9lPN98+e2LNwtoCcVIuX1UAR5m8hqZB19i2UXbkXFBgfpTH+pNcQ
         pkYIZtVx6S7rkRkd7agWbD0lq4bhQF8nB4GE3HQxcmWdBGvxawtOojm/l671rRzDpjPo
         La4A==
X-Gm-Message-State: AOJu0Yyxlobhjd/Qme84WNr7vRPgKpyzVwKtUraBgReBMSSpaw3JAMQA
	3FabObMcKK6rGQwpkP3N4NFTRsVl14gJgIS1Kmh9ofYt234XYnyS+H0Q8b48L/Gx1WYbZdRMhY7
	ytYICHdXHJltjt1WEjk7A0kDIhTul51zqPF8SiNBN/wOawrS4N77s2kRORirkzyVgkh2l/o+72i
	mMMpEMv70LG9f3tBpPmJf3U+uyYJ3SopQCaTRGE7D8acBP6P8sNaDQcEUJfBfnitEHfM5H2Q==
X-Received: from wmbjl2.prod.google.com ([2002:a05:600c:6a82:b0:475:dadb:c8f2])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e15:b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-48069c0e620mr13265105e9.10.1769503878707;
 Tue, 27 Jan 2026 00:51:18 -0800 (PST)
Date: Tue, 27 Jan 2026 08:51:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127085112.3608687-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN control option
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
BPF_CGROUP_ITER_CHILDREN. This control option restricts the traversal
to the immediate children of a specified parent cgroup, allowing for
more targeted and efficient iteration, particularly when exhaustive
depth-first search (DFS) traversal is not required.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
v2:
 - Undone the unnecessary formating changes applied to the
   bpf_cgroup_iter_order enum.
 - Renamed the new bpf_cgroup_iter_order enum entry from
   BPF_CGROUP_ITER_CHILDREN_ONLY to BPF_CGROUP_ITER_CHILDREN, as per
   recommendation from Alexei.

 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/cgroup_iter.c       | 26 +++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 44e7dbc278e3..c8d400b7680a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -119,6 +119,14 @@ enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_DESCENDANTS_PRE,	/* walk descendants in pre-order. */
 	BPF_CGROUP_ITER_DESCENDANTS_POST,	/* walk descendants in post-order. */
 	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
+	/*
+	 * Walks the immediate children of the specified parent
+	 * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
+	 * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTORS_UP
+	 * the iterator does not include the specified parent as one of the
+	 * returned iterator elements.
+	 */
+	BPF_CGROUP_ITER_CHILDREN,
 };
 
 union bpf_iter_link_info {
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index f04a468cf6a7..fd51fe3d92cc 100644
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
+ *  5. Walk the children of a given parent cgroup.
  *
  * For walking descendants, cgroup_iter can walk in either pre-order or
  * post-order. For walking ancestors, the iter walks up from a cgroup to
@@ -78,6 +79,8 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 		return css_next_descendant_pre(NULL, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_DESCENDANTS_POST)
 		return css_next_descendant_post(NULL, p->start_css);
+	else if (p->order == BPF_CGROUP_ITER_CHILDREN)
+		return css_next_child(NULL, p->start_css);
 	else /* BPF_CGROUP_ITER_SELF_ONLY and BPF_CGROUP_ITER_ANCESTORS_UP */
 		return p->start_css;
 }
@@ -113,6 +116,8 @@ static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return css_next_descendant_post(curr, p->start_css);
 	else if (p->order == BPF_CGROUP_ITER_ANCESTORS_UP)
 		return curr->parent;
+	else if (p->order == BPF_CGROUP_ITER_CHILDREN)
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
+	case BPF_CGROUP_ITER_CHILDREN:
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
+	else if (aux->cgroup.order == BPF_CGROUP_ITER_CHILDREN)
+		seq_puts(seq, "order: children\n");
 	else /* BPF_CGROUP_ITER_SELF_ONLY */
 		seq_puts(seq, "order: self_only\n");
 }
@@ -320,6 +332,7 @@ __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
 	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
 	case BPF_CGROUP_ITER_DESCENDANTS_POST:
 	case BPF_CGROUP_ITER_ANCESTORS_UP:
+	case BPF_CGROUP_ITER_CHILDREN:
 		break;
 	default:
 		return -EINVAL;
@@ -345,6 +358,9 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *i
 	case BPF_CGROUP_ITER_DESCENDANTS_POST:
 		kit->pos = css_next_descendant_post(kit->pos, kit->start);
 		break;
+	case BPF_CGROUP_ITER_CHILDREN:
+		kit->pos = css_next_child(kit->pos, kit->start);
+		break;
 	case BPF_CGROUP_ITER_ANCESTORS_UP:
 		kit->pos = kit->pos ? kit->pos->parent : kit->start;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3ca7d76e05f0..5e38b4887de6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -119,6 +119,14 @@ enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_DESCENDANTS_PRE,	/* walk descendants in pre-order. */
 	BPF_CGROUP_ITER_DESCENDANTS_POST,	/* walk descendants in post-order. */
 	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
+	/*
+	 * Walks the immediate children of the specified parent
+	 * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
+	 * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTORS_UP
+	 * the iterator does not include the specified parent as one of the
+	 * returned iterator elements.
+	 */
+	BPF_CGROUP_ITER_CHILDREN,
 };
 
 union bpf_iter_link_info {
-- 
2.53.0.rc1.217.geba53bf80e-goog

