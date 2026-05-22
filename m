Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DE356778
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466974; cv=none; b=dMTlxSBZXAapDD2vzJItXbtqXgjM0qrCrujJFD+4CtcVb6lxTchBbxZW5UVrXHQT50J19JeF7vD5kDWBSA352j5zGhl84k4sHwUs3+avohq3YLDtEn+RfGPWG+yRMYJVNMEiJ9ejDc25E7x7lnK1+kzSkpW8x57gl0+CjWLl9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466974; c=relaxed/simple;
	bh=qF2i7auJVSjO6/9vGlkMpnDgSR4rDFGTBdNP4hyUbiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UU0nhqPkCgxKEw+ZAcqm4mqRH9MHgdHkTkalnz6ojFaqrVoL0e5tP10+EsyDui0gWa50GF5i7SeXtoEDBHzMCc0tMJyHcL9KfBztxLb42MKZxtb8F1BrjgAcvrRt57S1ZiTxQ1IK9HXwSvpoldSNS8boBMd/ftl5ua3KYGjWSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6yqWkcE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6yqWkcE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso79837775e9.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779466971; x=1780071771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue9oZkFNnJgvX/B5djQomJS6gXyPBQAHkbvxsnpMpQM=;
        b=Q6yqWkcEslGU5DubJTpbJJ8mFEebnWmXvLHjzG+yfJRSB/tk6CIHhsGKC3MCdFztSZ
         DlSEjELf7QdZmpINGpp1EDsMpjGuchXMWlDqBkdxMOI4Fg72Gmb5vLz63hoqs+/3IzJW
         OUxHtdNAC4uHMX0YYkkoGcFdDbw/2VC11fiJPk9Oq4kU1rDSKf4YC0RDeYeaC6zf5IvW
         txKlnejqECT9rWAD0Av9ixDSRPXbTAOlHf58xwGIqySt9MyawwzXnZ23d3jeO2/Nxdlz
         iw+HanORypjALWWPOZRCL3REsllgbKV0F6yrKQ/mvPCE05f6w89OKZ18zW56QGtFcJ64
         /qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466971; x=1780071771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue9oZkFNnJgvX/B5djQomJS6gXyPBQAHkbvxsnpMpQM=;
        b=tD68Uv5xOB325XOCPZ26b9hYwvoFOIqJexRd6eNuT2hGn/NsR8xvtKqEzqMI/ptzkx
         JWG3GSwRs/A4Uzt2ZvdaOa2enmx/ZObJ6LG0Sen+vXzgwjFNuwl1OeXWEo0X84089p/3
         mYGwalBdUB6E8yO5JA/yRFq3bPbF1rnLHrTS7GIt9PwOTVfgCFf38iqFAPw/kolFzWDD
         DiazuCdxV/+ij/XRHwlVAB62uvFBUkK9chY6mCiMtvAFRKTuAYDwxlIIFNRl+1/TnScq
         DeVtinqiZLPhjVXUmLFrqyYVgHJQ0lim89xTIEF/8e377xPdKzbCcJx9RIXHsufxqGOK
         TiTg==
X-Forwarded-Encrypted: i=1; AFNElJ8RGH4u/pTBKBlNkkpafdZjht6NEUwke1BbFyY/aWoVHmHcHTZQDvI6P6A/0bgIlTUW3GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVTJrAGeCxstLGdScSQBlk/g+0Il7tcZ5Gem7SoglguovqF7L
	SRZdRIv/NINi/XGYLi0v9a96/QSq76O9szXo8Y9nqVK01bb28BmVVRAh
X-Gm-Gg: Acq92OGIx7FucilM28Ky0ZfjktzowPGZ2hgC7uU4H9xf1ANck13hhE50Zkqwg69rt8w
	IVl7aSk4Tf+rucuCHeJxvNPXNJT5+164pqCX8p2PhOn+ime07Ra3D+3oFJ4SXS6+igRyoWqUyoc
	Euy/158W6rgDvvrqvBwTD8NjB6zfeWWurp3lZVd4mDp6+6Zsuu8cwykUBLWC7k1a4UGr3wSnPCl
	TLtsczshKAHAtpx0PwmI80swLbhkhh9Pv7Sji3/UutA2KYogo+E0cJzF9N/iZoMirM3zxqcTeQp
	JWyjpKWb2Y02dGz0/lxbu31CywO2KMIwAdlWcMerDkxg/Gnx46GtZ0cd6T2TKtXJ/BnFAw0d82D
	pzzqiWfd2DtXT4VUpJzop848hTdyVgnjfNInWFE7w5v+UrFB2pJG1GSwaZ+BBHWpnar0aa+W+OR
	IkMbn6yABAQN5ZOPnvRJm/4GB4C/uL1Pt19+kQNAkE0jHUecF82vNTJispH7Y6sH6sPtg4d2yX/
	Tpfg+AbWmbsUB5rkm8HAJu8qPEYlBuxvEb8Z7CERwSr6wzta4VCq3I+dVTh3n05tng0Zl0DKVss
	/d8Vb05ZX9sJig==
X-Received: by 2002:a05:600c:8684:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-4904248f5aemr41640915e9.9.1779466971410;
        Fri, 22 May 2026 09:22:51 -0700 (PDT)
Received: from localhost.localdomain ([149.22.234.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561f682sm53330385e9.13.2026.05.22.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:22:50 -0700 (PDT)
From: Himanshu Anand <anand.himanshu17@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Anand <anand.himanshu17@gmail.com>
Subject: [PATCH] bpf: Fix preorder-unaware index in replace_effective_prog and
 purge_effective_progs replace_effective_prog() and purge_effective_progs()
 compute the target index in the effective program array by sequentially
 walking the hlist (pos++).  However, since commit 4b82b181a26c ("bpf: Allow
 pre-ordering for bpf cgroup progs"), compute_effective_progs() partitions the
 effective array: preorder programs occupy indices 0..preorder_cnt-1 and
 normal programs occupy indices preorder_cnt..end.  The sequential hlist walk
 does not account for this partitioning, so when BPF_F_PREORDER programs
 coexist with normal programs the computed index diverges from the actual
 position in the effective array. In replace_effective_prog() this causes
 BPF_LINK_UPDATE to overwrite the wrong slot: the freed program pointer
 remains in the correct slot while an unrelated neighbor is clobbered. Fix
 both functions by searching the effective array directly for the target
 program pointer instead of computing an index from the hlist. This is correct
 regardless of array layout since it matches by pointer identity.  For
 purge_effective_progs(), resolve the effective prog from the link when the
 direct prog pointer is NULL (link-based detach path). Fixes: 4b82b181a26c
 ("bpf: Allow pre-ordering for bpf cgroup progs") Signed-off-by: Himanshu
 Anand <anand.himanshu17@gmail.com>
Date: Fri, 22 May 2026 17:22:48 +0100
Message-Id: <20260522162248.55586-1-anand.himanshu17@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>
---
 kernel/bpf/cgroup.c | 74 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..437e1e873bf8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -923,15 +923,12 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
  */
 static void replace_effective_prog(struct cgroup *cgrp,
 				   enum cgroup_bpf_attach_type atype,
-				   struct bpf_cgroup_link *link)
+				   struct bpf_cgroup_link *link,
+				   struct bpf_prog *old_prog)
 {
 	struct bpf_prog_array_item *item;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
-	struct bpf_prog_list *pl;
-	struct hlist_head *head;
-	struct cgroup *cg;
-	int pos;
 
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
@@ -939,27 +936,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
 		if (percpu_ref_is_zero(&desc->bpf.refcnt))
 			continue;
 
-		/* find position of link in effective progs array */
-		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
-			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-				continue;
-
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
+		/* find the old prog in effective array by direct pointer
+		 * comparison, since compute_effective_progs() partitions
+		 * the array (preorder progs first) and the hlist walk
+		 * order does not match the effective array order.
+		 */
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, link->link.prog);
+		for (item = &progs->items[0]; item->prog; item++) {
+			if (item->prog == old_prog) {
+				WRITE_ONCE(item->prog, link->link.prog);
+				break;
+			}
+		}
 	}
 }
 
@@ -1003,7 +993,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 
 	cgrp->bpf.revisions[atype] += 1;
 	old_prog = xchg(&link->link.prog, new_prog);
-	replace_effective_prog(cgrp, atype, link);
+	replace_effective_prog(cgrp, atype, link, old_prog);
 	bpf_prog_put(old_prog);
 	return 0;
 }
@@ -1078,11 +1068,9 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				  struct bpf_cgroup_link *link,
 				  enum cgroup_bpf_attach_type atype)
 {
+	struct bpf_prog *target_prog = prog ? : link->link.prog;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
-	struct bpf_prog_list *pl;
-	struct hlist_head *head;
-	struct cgroup *cg;
 	int pos;
 
 	/* recompute effective prog array in place */
@@ -1092,28 +1080,24 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
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
-		/* no link or prog match, skip the cgroup of this layer */
-		continue;
-found:
+		/* find the prog in the effective array by direct pointer
+		 * comparison instead of computing index from hlist walk,
+		 * since compute_effective_progs() partitions the array.
+		 * Use target_prog which resolves link->link.prog for
+		 * link-based entries where prog is NULL.
+		 */
 		progs = rcu_dereference_protected(
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 
+		for (pos = 0; progs->items[pos].prog; pos++) {
+			if (progs->items[pos].prog == target_prog)
+				break;
+		}
+
+		if (!progs->items[pos].prog)
+			continue;
+
 		/* Remove the program from the array */
 		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
 			  "Failed to purge a prog from array at index %d", pos);
-- 
2.34.1

