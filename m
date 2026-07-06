Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7313AEF3A
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358377; cv=none; b=juOSklmyQWeDs1Vojtad31m0UJ+i4gLDGKg0dysg1BbMQAWmacqIKOZQPWONYVtvlLaPyAI6I5uoHjt1zIXQPwngJLDOPsHdrG3pj2rcReRsbajP/UQm9F3exHXDgWBp4RQCMrwROX4jpuUT2lbyLvwivdxYbZXF1IFiHCG4/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358377; c=relaxed/simple;
	bh=ABd/ww76+k3Cz3HVdTtdsTw2NNqLB395KUoMr1kUL9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq74deXUVTZmnDZkkE1yFH8s5W4m7Fd3h6dIApGqu87r/IKrdAhUIClyDwLz+ej8V5igIT6buGHYz9vZnRdvZvCuKxYEsjIukguNoznECoJS7HhgW7LDYSqkYTxIHLBhfO3dhSXrPwzmCvUyt2U1XS0WeVeY/IijKMtejti8x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdXyfBd3; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdXyfBd3"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a18e363d52so45729eaf.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358374; x=1783963174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwrNws75JbsyW/mUTo2aML94/IobRodHHQrNJC24UiE=;
        b=ZdXyfBd3tzjtFgxlKA2DMhQJo7pWeZjViGgJa7IEdLJbwhPy1D59kXmakyQ9rqYYj2
         d8wQ9QfErAd1MuhkZE/rONNAtfwh55XBEWbQ3Vzz0LABIbQDK1Tm+RO6aRgjF7OKvfRZ
         tUh+9CJW5WIoM3pdjm5cKuKhnzlvWVHiltLnEuBWL8jO4QeIaBR+l+HlWSrrRB+psxx4
         nZaZfTs7W8J4e9lCilulvVDf80e3+8PtSithTdnzNcVSB3ZKgF3JV6IwyzGLW9WIUEP0
         m2UfV+BZxoTBFOe0iFT7taXk+KBF/eYD1QrPNDBxN/V/jvZ14pVBgmWeSrScfiOtvjnT
         FEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358374; x=1783963174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwrNws75JbsyW/mUTo2aML94/IobRodHHQrNJC24UiE=;
        b=NFyyoU6zbBNSa0IIJbZDThJ0oduICUnIiMmO8XztqHH9Vi/1cX2GE8v0CtT63rFDsU
         sa7YvHMHUkSOXtvD4qB9P7z7FOIFKQIZKnR1tDREtJP31nCPzC/kNZYdYTTV4vVuq40i
         /oHERyxDy/hJnJlRIRl8VMHWJ2JSunbB3dI+x4CJvCXcpLYWocM7cFzreBM9+pecezZq
         ljOlHY1HC9vhS+pSQQbhzfE8GC4IpKdhkyQryWT0d3tJhmVryzICqr4BPiFUy9w5LjWj
         iQw6dMvpwQWBrauk0e0zdY97w03UaFNGYwze2G8CTKoRWi160X9wqO1dx3gKY1s8nfSf
         bDWA==
X-Gm-Message-State: AOJu0YyCILlZYPxHVvyEtO+a1EjcUA3vlB+bnNtDkKFYBNGgfO9MpLHA
	SzzBzgMQZ0RBPknAYswFc20khkqWrExxbni5HEnbo7B5K7mfdIB9UCQK6DYHYA==
X-Gm-Gg: AfdE7cm8KX+KZYkCzGuZ3sH64fqdZgPBmT85cr3AYOybv8QBEl5I52vgixS2PTKk1L9
	h9AwZ+rTseIq6+/pq+JA4nE2DRQR/67kNIogPaL0Q5QqMDOaL+36hFyalNDZ/Mrf35T7nrROJG+
	QDLmNC6oSOAyKNpCROt7EGyuOIIuZG8qvUVnTie5PiCkj4NVybrC2cRCeeSVbp00Gh2hcBfVaZh
	MNlzoJpik4GsfwGh6lpxBSPW6p/nNkUP9X2VRv/yIXP96CP0AoKXvJBvZ6tpr+ktLkct3aYYzzZ
	jTAcEP2Xxnj+ROQBDwFQ04uipawaTBnw4va1mINpkacYXPqR4PAeRQwY1j4zsLcOvtyPOzztekX
	IzDgac9rJrmotDM0JTZfQ9AIeWiLmAu/r83p4LjKbssGb+ySDJm2qQKCsAW2KqYa1Plzo1E70xC
	IfdQ==
X-Received: by 2002:a05:6820:60a:b0:6a1:7c3e:f62a with SMTP id 006d021491bc7-6a354586d88mr785791eaf.12.1783358374491;
        Mon, 06 Jul 2026 10:19:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544f3d24sm12066292a34.21.2026.07.06.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:33 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
Date: Mon,  6 Jul 2026 10:19:08 -0700
Message-ID: <20260706171918.317102-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add three helpers to abstract operations on a bpf_prog_list entry.

Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
which returns either pl->prog or pl->link->link.prog. This will not work
when struct_ops is attached to a cgroup because the attachment is backed
by a struct_ops map instead of a BPF prog.

The same applies to __cgroup_bpf_query(). Instead of always copying a
prog id to userspace, struct_ops cgroup attachment will need to copy the
struct_ops map id.

Refactor bpf_prog_array_item initialization into prog_list_init_item()
and prog_list_replace_item(), and refactor id lookup into prog_list_id().
These helpers will be extended to support pl->link->map in a later patch.

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b100c04cb9c8..b43f0bff184c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 	return NULL;
 }
 
+static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	item->prog = prog_list_prog(pl);
+	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
+}
+
+static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	WRITE_ONCE(item->prog, pl->link->link.prog);
+}
+
+static u32 prog_list_id(struct bpf_prog_list *pl)
+{
+	return prog_list_prog(pl)->aux->id;
+}
+
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
@@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				item = &progs->items[fstart];
 				fstart++;
 			}
-			item->prog = prog_list_prog(pl);
-			bpf_cgroup_storages_assign(item->cgroup_storage,
-						   pl->storage);
+			prog_list_init_item(pl, item);
 			cnt++;
 		}
 
@@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, pl->link->link.prog);
+		prog_list_replace_item(pl, item);
 	}
 }
 
@@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
-			struct bpf_prog *prog;
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
-				prog = prog_list_prog(pl);
-				id = prog->aux->id;
+				id = prog_list_id(pl);
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
 				if (++i == cnt)
-- 
2.52.0

