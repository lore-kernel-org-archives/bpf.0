Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16338390219
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237022; cv=none; b=qawZ7ctM2WSELd+5bcFAs3gZnjH90HwkOYJAL7OXGM8mjNAGmkcgtrQMOcKmWgiGIMoMfkRMw3dwWolit4RGuuXEN/vOWmBWGEJL9OmgRQm2j5LKLjXUTWUvBjGTEwa2tRkOwMenJPIwSUR00XxftsSOfhHKEJqysmj56xLhkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237022; c=relaxed/simple;
	bh=NS8NmvJKDR6fhEIy3XDtzMsccV9jQ2GDP8Q4TtPmThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG+tvhnBtAXr3ZgPPy0hmaVuoIcPfmiihYFCTak3PcUO/AhVQSfNSnPOqx02aUIEgQuQBnN9KoKZ4+PxqFvlwTOS7d23xfnQEwl9cvktE+MYz6a0oO4vIWBiocTzh6ar5PJwZeiHZfPG5TvGUAkhvfRkcvV6uesGL/cWtGbjnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SykFWxvU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SykFWxvU"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6cdd78fe6so91191a34.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237017; x=1782841817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14a2esPJrabA3+M9oOvC0YPPzabk9ph48HPu6HtWoEU=;
        b=SykFWxvUbMs3Xw9DRjbXJZrJSLVFAa6mx9LwCvtxqUHUjusoQwwq8ixOu9vJLMyHs3
         UK46vmyZ37soEANIV5RFwhixF2VZOHYwuU5s39HXml/FhFoOzriyru8xXdyR3feV9JZD
         748b4OqVtwvnq5i281yZODYCELFBzD9zV/KbZO0a9Z5eTuYIJ5EJy8g/PIAbJWeIL8Qd
         9uSSY+3K7MfGEAeJsuQE4P0jbkfcvh4N7Z4n1C4VgfbChrjNhGGsjL/tXSDiOVA67Wv7
         ukYDShzvq8jOB168/iY84JgYBH2C52Fn5nqfnUV3Qym8YDraWtzkQqk/Iodhx07F6hGc
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237017; x=1782841817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14a2esPJrabA3+M9oOvC0YPPzabk9ph48HPu6HtWoEU=;
        b=U2qZh1RmVGK6iLqehTgeUsQc3/ILnaljMZMO4k06zdJXhJJ+D/8VVbylhxPmxKNCto
         Wt45r/ojKRgmjfXNgiHsFIUFaUlbWjV2kibU1tP7jp6o4so5oLVk0NlgIm9XhENIdpxZ
         +0H3ziUuwVuL7W44JnT+7sSLHiURaUP+44+l1hdi3KSM5vTEBd0nVEIhrHXsM3Eum7WF
         3oKgJ8h3mFh55DMm25dKVUaHxPY8WJrKEukEWFSeoQTSxa+d0TJB6MpyA1AA9fUzTdN8
         9qD1cmzuX1kWJ6KrSmuLYMZ5DX/b6ykCyd423OZKmCol2BZI/hgh76fMnkhssa5sj1LF
         XqkQ==
X-Gm-Message-State: AOJu0Yz988LlvgOrUeR+6BrHfLuEvwwWi/0hUh/h/HKeefER8+GETMWk
	YxcbshgXt+tvZZMV6LM8pkfitSJjWH5yDEO4r5tfptS2QsYqW79ZifURMjEuBg==
X-Gm-Gg: AfdE7cn7hDwKIS85KjT7FXV7mpJyOpQcx9cqRuYaD4wdrHKsJ3Pr2WjQG3gHkknFe74
	M6zG55hNlOaRjg3+TBxwTNnesW+PYS++d1s3HmmhE97yZoXxstQ9hzJgvhmfOIV/WMzar+KcCqy
	SPQDQjqbsbJLtYYK8g8zo2sSdN0Xqxd/HHt1mTWPw8I3+TWgvkJEPGPZVkDVCTINImHc1vUGv/o
	B3WXtYKoX8iD+vNf2nwsiBEj7Fr/o2Tm+10RHiTg7P1Exkgd2VNNLoHuRmVU7tF8hafE6rfY61z
	7rKUGsYW0Bkbd23rDwh41pUGl+pguSgo5+Mf4HHwCr1rySzNcGzyoRGRrpnZrwl+cyqtChapoq3
	uv+102CCgs74XhcsHh3kImy1MzFMr3892gLP+UjcrHYK0WuZzW3GEas4tM26oaLnDN0qTDpg7bP
	Hql8U=
X-Received: by 2002:a05:6808:81c1:b0:48a:dd0e:e5ea with SMTP id 5614622812f47-48f6261bbadmr1926853b6e.30.1782237017050;
        Tue, 23 Jun 2026 10:50:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23ce4sm7244472b6e.9.2026.06.23.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
Date: Tue, 23 Jun 2026 10:49:54 -0700
Message-ID: <20260623175006.3136053-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
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
2.53.0-Meta

