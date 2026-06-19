Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0884346E50
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850928; cv=none; b=S19lq3Em7+mp72/7ht3fhjS5lTVQHUBCNSfstg+3yKpvG9Vo+OR/QrbMKx4K57L2e+A0e1ksZYLMeWYCXD9sL6nTQJx+DeFWqlissNgXhsWi20zc8p9i05bi5tWyEBELWJY7prY7MkgRcwmnbd1MnTkPwc4eyPVxzN99U5B0s9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850928; c=relaxed/simple;
	bh=c/1lQw13Z6SaqMdh4gDprI52HKUbdupeJojzC492Mdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSA4vBUn8sFboprwoKtOaLedoLwR6KFoLQG4ixJbXHxM/UCtJjHTTY6u6GcCWwRGWurcROAZ2AQTcJrW6dKCJ8aqOYBAeKrIfWbU+yMNREy2je50GAVr/HMjgcfWFikywHmp1xpwmXvtfkneyCEoIzvMMlfP1zzPnsgEInIi2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYlSHDse; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYlSHDse"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4471c2ae049so100095fac.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850926; x=1782455726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tuj95EF89FDAMYVWMynXRlU9hPX5pVM7AbkW3h9U94c=;
        b=JYlSHDseF8+fSB1wUiEjeSbivbcDzT+gz8pzATCSUjUbLLZO4tdIjCQADaJUBB/xeF
         2wLiuZG6AI/VXHztD/wt8qmGRmpDlJEERmG+FHzTb0pxFO53jBFm2wCKlMKZpncwwpnJ
         xFdeAyuPJ9yi8jNKQg7bBHJbwv/GtXgbnQyIgP4igKHRA24mosQJjUIy9kxdLQJg46VD
         Tzw1uCLvNYwQpv2JLdG4+D/qW8MxeeVfcxI7QX93UVhf1K6IxyGpnN58fHAViAZZRTu3
         E9cx7QZVMlGEkdDodKRNqbiwP/NQItcoauPP33TiFF5dTWkttorX2EyVaiWvt9KSx7bk
         jq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850926; x=1782455726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tuj95EF89FDAMYVWMynXRlU9hPX5pVM7AbkW3h9U94c=;
        b=JcP8FlZPq5/SBNbyRjgWEGMR6P9hZ0F7uTE3v8C/50l1xhh4wT8fkGQscUHbvMusGc
         egdZmpvwr7QhJxBnj5Ni7Gz8kEMsmjIvJdJYO+J6044WaQNcAsDbz9kBuprWgWxvUyIG
         i9zDoV4rjkEz/4e8x+/DX2j+L/0Rbel7gVYnhdr++NdqTGqamRhclQ5AOSo5slAEn1+L
         689aeRECJtqTPA086BXuICA2hSzpmqFpjJzXK4p+XMfuVJeRiQy0ggl1527RlTOkH1a0
         RpSvlukShoVtVNwcBR8b7FCmaeCga592LDr/YdwBBm8d4RprhnKrRN0LYsYWeyeWPX/t
         qLLg==
X-Gm-Message-State: AOJu0Yz2zWmR2A2NXfy1h1bpWn1hzK28rCXiGr75C7H+RmtNYXpMT9ea
	ySe0UyWbk+m2cIFy/2oMEdnpmslWXgO4DNnv4SVOPKz90O9BAkArv/zsje0HnQ==
X-Gm-Gg: AfdE7clMNN6wXLngnwSqqNXD2R9qv2Vi0qF6NCvq3Td/1U9Rqrn9cj3FxuEREzCf0LF
	LYqE98+zPpRPyIE8iJA+pnY1S7R8dFELKc7LcIVZ8gwL1qMAKLvJ2BpKcOr33Sr83znfOdyTB9h
	Q75g3i2zfTy4riLnln+0ezhfq/EfktHrKz4IJYl13p+xDGqO24yC1Xd/+TAoySZbno1KRT1X01S
	vcoy/TfBB/1+RJXH6fzrVz0ux2dR5R9RqiBHn+FvoO37X5TTcewQMRNqTXPM8+Hx8qnf8QOweRT
	9lFxLZDADXLyYYFTwCPNEggZPshJ3qrTceCfMk9ziOZxjxSwzC5867pStZWGqcx5wM5TPXtQZxV
	WDjt8JMdG+perqYi9Yo2ld/SHh+hDJMjwqVOtLHB4b1jYyrKyXs5q5bKJIXNXDHSwymQGSEVL25
	V0Tg==
X-Received: by 2002:a05:6808:5296:b0:486:45c7:34bf with SMTP id 5614622812f47-4896aa680f6mr2367703b6e.16.1781850925816;
        Thu, 18 Jun 2026 23:35:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e92e4ffa89sm1207225a34.12.2026.06.18.23.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:35:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Fix effective prog array index with BPF_F_PREORDER
Date: Thu, 18 Jun 2026 23:35:19 -0700
Message-ID: <20260619063520.2690547-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619063520.2690547-1-ameryhung@gmail.com>
References: <20260619063520.2690547-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace_effective_prog() and purge_effective_progs() located the slot in
the effective array by walking the program hlist and counting entries
linearly. That count does not match the array layout: compute_effective_
progs() places BPF_F_PREORDER programs at the front (ancestor cgroup
first, attach order within a cgroup) and the rest after them (descendant
cgroup first). So when a preorder program is present, the linear hlist
position no longer equals the program's index in the effective array.

For replace_effective_prog() (bpf_link_update()) this overwrote the
wrong slot, corrupting the effective order. For purge_effective_progs(),
it could dummy out a slot belonging to a different program and leave the
detached program in the array while bpf_prog_put() drops its reference,
i.e. a use-after-free.

Fix both by replaying compute_effective_progs()'s placement (including
the per-cgroup preorder reversal) in a shared effective_prog_pos()
helper. Identify the entry by its struct bpf_prog_list pointer rather
than by (prog, link) value, so the lookup resolves to exactly the
attachment the syscall selected even when the same bpf_prog is attached
to several cgroups in the hierarchy.

Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 108 +++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 46 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 83ce66296ac1..4355ccb78a9c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -939,19 +939,65 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 	return ret;
 }
 
+static int effective_prog_pos(struct cgroup *cgrp,
+			      enum cgroup_bpf_attach_type atype,
+			      struct bpf_prog_list *target_pl)
+{
+	int cnt = 0, preorder_cnt = 0, fstart, bstart, init_bstart, pos = -1;
+	struct bpf_prog_list *pl;
+	struct cgroup *p = cgrp;
+
+	/* count effective programs to find where the preorder region ends */
+	do {
+		if (cnt == 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
+			cnt += prog_list_length(&p->bpf.progs[atype], &preorder_cnt);
+		p = cgroup_parent(p);
+	} while (p);
+
+	/* replay compute_effective_progs() placement and record target's slot */
+	cnt = 0;
+	p = cgrp;
+	fstart = preorder_cnt;
+	bstart = preorder_cnt - 1;
+	do {
+		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		init_bstart = bstart;
+		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
+			if (!prog_list_prog(pl))
+				continue;
+
+			if (pl->flags & BPF_F_PREORDER) {
+				if (pl == target_pl)
+					pos = bstart;
+				bstart--;
+			} else {
+				if (pl == target_pl)
+					pos = fstart;
+				fstart++;
+			}
+			cnt++;
+		}
+
+		/* reverse pre-ordering progs at this cgroup level */
+		if (pos >= bstart + 1 && pos <= init_bstart)
+			pos = bstart + 1 + init_bstart - pos;
+	} while ((p = cgroup_parent(p)));
+
+	return pos;
+}
+
 /* Swap updated BPF program for given link in effective program arrays across
  * all descendant cgroups. This function is guaranteed to succeed.
  */
 static void replace_effective_prog(struct cgroup *cgrp,
 				   enum cgroup_bpf_attach_type atype,
-				   struct bpf_cgroup_link *link)
+				   struct bpf_prog_list *pl)
 {
 	struct bpf_prog_array_item *item;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
-	struct bpf_prog_list *pl;
-	struct hlist_head *head;
-	struct cgroup *cg;
 	int pos;
 
 	css_for_each_descendant_pre(css, &cgrp->self) {
@@ -960,27 +1006,15 @@ static void replace_effective_prog(struct cgroup *cgrp,
 		if (percpu_ref_is_zero(&desc->bpf.refcnt))
 			continue;
 
-		/* find position of link in effective progs array */
-		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
-			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-				continue;
+		pos = effective_prog_pos(desc, atype, pl);
+		if (WARN_ON_ONCE(pos < 0))
+			continue;
 
-			head = &cg->bpf.progs[atype];
-			hlist_for_each_entry(pl, head, node) {
-				if (!prog_list_prog(pl))
-					continue;
-				if (pl->link == link)
-					goto found;
-				pos++;
-			}
-		}
-found:
-		BUG_ON(!cg);
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, link->link.prog);
+		WRITE_ONCE(item->prog, pl->link->link.prog);
 	}
 }
 
@@ -1024,7 +1058,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 
 	cgrp->bpf.revisions[atype] += 1;
 	old_prog = xchg(&link->link.prog, new_prog);
-	replace_effective_prog(cgrp, atype, link);
+	replace_effective_prog(cgrp, atype, pl);
 	bpf_prog_put(old_prog);
 	return 0;
 }
@@ -1091,19 +1125,14 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
  *                           recomputing the array in place.
  *
  * @cgrp: The cgroup which descendants to travers
- * @prog: A program to detach or NULL
- * @link: A link to detach or NULL
+ * @pl: The prog_list entry being detached
  * @atype: Type of detach operation
  */
-static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
-				  struct bpf_cgroup_link *link,
+static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog_list *pl,
 				  enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
-	struct bpf_prog_list *pl;
-	struct hlist_head *head;
-	struct cgroup *cg;
 	int pos;
 
 	/* recompute effective prog array in place */
@@ -1113,24 +1142,11 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 		if (percpu_ref_is_zero(&desc->bpf.refcnt))
 			continue;
 
-		/* find position of link or prog in effective progs array */
-		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
-			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-				continue;
-
-			head = &cg->bpf.progs[atype];
-			hlist_for_each_entry(pl, head, node) {
-				if (!prog_list_prog(pl))
-					continue;
-				if (pl->prog == prog && pl->link == link)
-					goto found;
-				pos++;
-			}
-		}
-
+		pos = effective_prog_pos(desc, atype, pl);
 		/* no link or prog match, skip the cgroup of this layer */
-		continue;
-found:
+		if (pos < 0)
+			continue;
+
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
@@ -1196,7 +1212,7 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 		/* if update effective array failed replace the prog with a dummy prog*/
 		pl->prog = old_prog;
 		pl->link = link;
-		purge_effective_progs(cgrp, old_prog, link, atype);
+		purge_effective_progs(cgrp, pl, atype);
 	}
 
 	/* now can actually delete it from this cgroup list */
-- 
2.53.0-Meta

