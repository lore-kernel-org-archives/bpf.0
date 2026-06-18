Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B213C2D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821164; cv=none; b=N+XqvlV7Jr73Scz9h3nWfYLMNGkuKZTU+IZDLhsm48bosPwMqWKDBmETs1pN8TFpUI5okW3KAHyrWbNOTxnnRK1wPoGFtCm6Vq1gzj9P1+wX67pwtzDh7i9Nftda43QZRUF5y1Jb8UXod6O40xTNXz2vGbYiYo70TWm7k6VACPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821164; c=relaxed/simple;
	bh=KXwxPrQEeivCWtJtr/to2lHSTt7rKxBPINuBKZcGJJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTqV18tE7gbnapd0RRRKbaRjXkUcp7sXwa20lU3Du+YMJNRKCGHwXdS8HYDww0vBUnvRqh8zuw2aC8If+3pxHI/KMfJK3SkXQ19l+v0qqFZz5Aw56DNnsVEXsR+CehxtbeTMRI0PkVlYqOkJNXqEBLIuIjDpoWrNumEkKSp4Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMK+F+lh; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMK+F+lh"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43d16405b54so591045fac.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781821162; x=1782425962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X27qSalocvLkpPYJ7SOwJcrFU4ulOUYmTE4QySJE+34=;
        b=pMK+F+lhCcMA2NwuU0ANnT1fqRIDyIoPk4J2uMixpgh2XCWV+tZyrwSMZ9gJ1HFbJ+
         5utvzKCEJuxKK4KZgVgjldgAxIRpesUmrm+bJswEXDVkA47SiOiMlplkH0K9KjNUOpvO
         QLURR6ntdiItCp3EoUgF/7S9/5oMwwrfAvzNGHi6LXisdU9CjqFw6xkunlkAEozG6N31
         kJl63xD01cFXOCFOt+gboattQgVIXQ72ze0x8mf/PL9qQvN5ggoIqJpoemuM7UHtYJH6
         D9kg4ToEb4tN9lq+3rpSZuTE6zsDqv3DQw0NrElLKthvTaTzf2hm59s5EmdpJovOq4zO
         DCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781821162; x=1782425962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X27qSalocvLkpPYJ7SOwJcrFU4ulOUYmTE4QySJE+34=;
        b=VIjKL+JkSFvF5ct62jlXye8/bLMuvlX2aUrKfRSozrbjyn36EGIksREUk7ddXDpMkT
         Io4myeyXYgxc/FndPUvg8noicdrwnA5Bg9SVQnEXYmICHNfCgCpYdCCL0lFpo5lVPhH3
         KtJcY0gBNGjL9n6XHDRuiv4+t2JtrL1G30zUxOYgEeKLaQWGBCfzxgvt1sZwPdJWpng3
         jU1556DuPABSunCADSflvxEHKayKtS8thFORLfJMUn7PeF56zvnATiXmXS2FdM/o4S2l
         zwaLTTdR5YmNWxtngpIZ3HlALyMWc72PiVBzhJmm5AWdkwNu80F1UgQB8GfA1A7NLJ+u
         I/yw==
X-Gm-Message-State: AOJu0YxvD0FEd/M4D2tLYwglord9WDI/C0UVoOyYjPRd5VbaUBB3Z+MD
	f81lEj34R1ittCeXUcZIe0mZN+hrCQ901ag497wA7TRJ3xWPKanNF4s5ANOMRw==
X-Gm-Gg: AfdE7ckDn0pyA9qDzYaHtzzUTlBe86o5bAOlFVTcfW7jsLMU5nEpcUNEshPRSR9Z2h/
	wft9pOWqnR9Mssixkppu5ceXEbc/L95hR+jC86BgrP0g4bNtUIqI3eLWxCGZSze7G7VqyBOCwfx
	GSg0ATU6lP0OqBhqWiy7bgwLzymLA/klRNHK+hw0L0Vyt8hDabvkSwutOKMCO2HMtW6JYP0GfSa
	SiQqsRBEzpatSTofN6iRZ+njppLF9TsswOikc2c15RNfcy/fUxkVzvEHfcbzHGg6SPi9fKy+8HQ
	zZG6d3yqAeXk2ilsri4H/zc1aSg6h7+aniYRdgWCIDNXZgmrIFN9TYMg3CEU65xGY5bZXyrxVj9
	YxKLpqSexdVXuppRaKNCo2hz/NSJQlXK2zIep5NzhcHqBlGTiWXCCZGY1RObNkk1cw3GP7Hp/dd
	Vam2c=
X-Received: by 2002:a05:6820:1b10:b0:69d:f855:b748 with SMTP id 006d021491bc7-6a0d8934e90mr1167794eaf.34.1781821161841;
        Thu, 18 Jun 2026 15:19:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0d907c195sm500721eaf.13.2026.06.18.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:19:21 -0700 (PDT)
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
Subject: [PATCH bpf v1 1/2] bpf: Fix effective prog replacement with BPF_F_PREORDER
Date: Thu, 18 Jun 2026 15:19:18 -0700
Message-ID: <20260618221919.2919512-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace_effective_prog() located the slot to overwrite by walking the
program hlist and counting entries linearly. That count does not match
the effective array layout: compute_effective_progs() places
BPF_F_PREORDER programs at the front (ancestor cgroup first, attach
order within a cgroup) and the rest after them (descendant cgroup first).
So whenever a preorder program is present in the effective set, the
linear hlist position no longer equals the program's index in the
effective array, and replacing a link's program (bpf_link_update() ->
__cgroup_bpf_replace()) overwrote the wrong slot, corrupting the array:
the replaced program ran in the wrong position and a stale program was
left behind.

Compute the index the same way compute_effective_progs() builds the
array (including the per-cgroup preorder reversal) so the replacement
targets the correct slot.

This is reachable today via bpf_link_update() on a cgroup program in a
cgroup that also has a preorder program attached.

Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 70 +++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 83ce66296ac1..b12e44ec5d8c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -939,6 +939,55 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 	return ret;
 }
 
+static int effective_prog_pos(struct cgroup *cgrp,
+			      enum cgroup_bpf_attach_type atype,
+			      struct bpf_cgroup_link *link)
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
+	/* replay compute_effective_progs() placement and record link's slot */
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
+				if (pl->link == link)
+					pos = bstart;
+				bstart--;
+			} else {
+				if (pl->link == link)
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
@@ -949,9 +998,6 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	struct bpf_prog_array_item *item;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
-	struct bpf_prog_list *pl;
-	struct hlist_head *head;
-	struct cgroup *cg;
 	int pos;
 
 	css_for_each_descendant_pre(css, &cgrp->self) {
@@ -960,22 +1006,10 @@ static void replace_effective_prog(struct cgroup *cgrp,
 		if (percpu_ref_is_zero(&desc->bpf.refcnt))
 			continue;
 
-		/* find position of link in effective progs array */
-		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
-			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
-				continue;
+		pos = effective_prog_pos(desc, atype, link);
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
-- 
2.53.0-Meta

