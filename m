Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124373BAD95
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358379; cv=none; b=ePM5HCNxrhE4v2d6NTI6PPPlYGYCmfv40WkeJLtfjg3BVmpsmbxTyMVRKVKonvIJ8ht7SHBh1QUNmeL0dxNgo0VaE6HShbkrU7MOMRdcfHA3Y9udcN/4ZPgQqoVeJdobdj2u1B8okyXuFJ2prUvxWi4yQDegxuFB1wrLG8V0cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358379; c=relaxed/simple;
	bh=SO8Au3LdMj3YdJWgfQZnM3I9IcAVk/GaLFUx6z2zfYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPysPhFTezAehYebOVkIUP8IRa3XZ/Geh1ayn7g4dyf6qDwq/Yi7lytPxU1BrhATJlxaxFNCnKU6y7xJKpidT9EIKHkwGUdeXkLIsjZbM/qQE9U6qOUn42rvcX0+QsoEGU0sC9apF2nKcA1+4rHdMdhJecY0erBzpxgqXkDfPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXUUMLOt; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXUUMLOt"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-495ee8e807aso1515016b6e.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358377; x=1783963177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpRud8IfHMa48lHaLqrXsmv/FgGxX43vCtItcr3N5Ag=;
        b=PXUUMLOt2X+r0RSzxwuST9KIMc5NevzpgvGolf7ERZJwFat9uAkhLjtHqN1HTadS45
         +TXz/HZB4k5MDgJvuXkZILmoG9L9LftAsbstBLeca3kUNtpbiSt0NF/7zJ/xDywPIqnk
         FzD1mr+oHW+KGh9/6Puxw7AI9YXsq4s7hVYNsD4XPEjxlJFQFLnOq7Dh7LPpDIVsbWCa
         yt5NHYLpRukxUZD/R/cpsjZengkWPGjH5Yxgn+oWZHfgOmu8kjzMBER0Ivn9qdER2e66
         qkmT5TFSs6BsBZ+WI/0RF92pqGQGETa+71prbw4KbPNKwWcN12/NQGW16gU2jXUs0mfe
         TkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358377; x=1783963177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpRud8IfHMa48lHaLqrXsmv/FgGxX43vCtItcr3N5Ag=;
        b=T2ZRmKrnm3WdXVC+wuqyGZOYCNf8NIbbWLF0pHCfp5W6pgjWv/NHtlJZETDa+62SUX
         ZbXYFSyw41vUSi6YBDjBKF9noXoBahsN5p9cjzp2hvgB/+bZJns/mgo9TwP1BSXUGpRo
         eXJojb7ejAanU3B53LIHHCsQO3N5Gu753ZXfYtDYNC1wIdU5lnTm1Uycc5tXEKKCnCgT
         1+uttX6LssF1eFIgEKwbD4mUfzPo5D2SPC0K/Zq9/40rXdCdkv9WW/1NlQ+Fn6mnQhLY
         QOOdl2m/UuPutzubKyPIejVCl6EBEmoYmk25UTLnTCbHA0H75YYY2tUNGaVcTRuTzbx1
         ue2g==
X-Gm-Message-State: AOJu0YxEKz2q7ecrH+7caLGq+GQ/bWrc0RBzPyS+u4JkWw+l4FdJTtZl
	Ja/m7/RTOMLeyzzwsLjtVupq7GYDgYvpxkLELFj38gFLt001YFHnnCk16kD+Hg==
X-Gm-Gg: AfdE7cmCZCVvTUt/sDvuvVZygdlLMQ4bwdsmBR3X4wJeM9dzflt98+JLoNxxBBiVKYj
	KvEXZ9MzNMXyJzDd5zTWlzPVHhrrCejlSodAmqs93r4rE6lu5DaH+LiQrr3VRl1qi8jlD7Obt3Z
	eQwwmOeC8XOtpNnF68pNHGnzFN1PTFUycndT6zTWILlEj2mloNSz9BvjHagOH0xb9QDwcB+Pxj6
	mum+udA+0igCP1cBxv04NpuKU8zxYB5SthPsKXZN8CvBotCLid1JX3N1TDToSGQ6wTSb4CA9O6q
	i8/lMzxPlj9yqDIHT5Gi1wkhAPf/HGdMQe7VcQqjTMy2JKJCxF5dlR5O0nr7lAnSj0UQjPWIx9Z
	BQ3dvl29mTeDSzUTplXFf8+71Lsfsmm7G7hWcVS6vSvC+/Tgj6qWiqokPkwFI786gi14Hj7Xh3q
	8fo8E=
X-Received: by 2002:a05:6808:178d:b0:495:dfbc:c1c6 with SMTP id 5614622812f47-49fdec03600mr1210273b6e.40.1783358376902;
        Mon, 06 Jul 2026 10:19:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1853afbsm9451997b6e.8.2026.07.06.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Mon,  6 Jul 2026 10:19:09 -0700
Message-ID: <20260706171918.317102-8-ameryhung@gmail.com>
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

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b43f0bff184c..7abbe12e108f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.52.0

