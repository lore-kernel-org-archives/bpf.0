Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A013390230
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237016; cv=none; b=vFdq1P/jGyW6wCewJGt1KIfJa45ez4WzkkVVPfUmQ0nt6x+6qJ4nZeYFU0Z+RvFrDlvN/TOBV1+DKF46QOIjIL5NqkOiGz9FHEcBhSDL1Ke8PP7WgtaweO2F1yLwPvo/xUiih66XgWXRiYTmK2TQ4b3q81LBBDAiIVY2WvtlNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237016; c=relaxed/simple;
	bh=XcqovPOaKYkd+iBiFy/6igrU7RFiqU377DoT/XKPiqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPDWYFPqXk7d8LW5ZZzfDnGO2HbmIKFQgNfc9QYo6DlRPbavsfmtMnyRV821sU6IwSTPGlh7EfJq91uyZZ6ZlFqKRfkbsHnYMvVYLQhxASqAPB+hGVP6Z6ZHlr8jnjL933XQdQkaAfwN3gtjq+l1YtaZuj9MSn7QTgO7+alQmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASf3xuoQ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASf3xuoQ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a11c68ae41so83232eaf.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237014; x=1782841814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8soAYOZk2vTD96d7XVKF7iLBauYSdEF+qrXftHgJTD0=;
        b=ASf3xuoQR/8rlYKvr3oI2Y1WoEujfXLkrFO5keT2+WiZqDDYc6EnPQjGnkvgXlOhEw
         U1fIaFuJvVccRrHR9x3OmMfIUnTZlooeBqYK6gSXpvxzm63HlMkAjogF56qOSTygUtp1
         Tcn2F5nG0oNgzN1c4RblABtbePPKfNYExbIe+LRo3o6xj1Pw8sb/PkIwC8UJofMgjPiT
         4cCwc1Tljr9LiCOHrll561CZAggIc6UV9nTxrrTit9y/Odhfuq7oXLVirR59Q8sJub1/
         jEAKbWJCiDHLwkDzjO02JTVrZcHQRazP1kh2EbfEjEIno2rmNa9Jvj5r5cuuiPcjquK9
         ukNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237014; x=1782841814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8soAYOZk2vTD96d7XVKF7iLBauYSdEF+qrXftHgJTD0=;
        b=WDHgwgTy3T2EkOC8eDivRZfi0mPhIHI5xfSxdome3FwYihyIvLGNZY8R18zFew1amb
         KPTRl4B4qpno/w9RPVsuBJY6jdbMH9ojwkOZ+49iiv0rHK9CIpvIW1b6A11ZJt8bCnw/
         POB3WG2+fUDgzzXiQYIiNfDPVkRbyR46E1cWsdHUEWzE/NAlZCgPyLZw8AuThh+g6M0F
         EyTtvkyfsopBrkY2fTgjLj/DjYWFtWQDPtkha+j4+tgehnGtXu2m0fyyndk+Y6cxBn+I
         cLtXL3KeuJHehPy8ZrH5dJmIwUWn6HA7jteo0MGPJDz47jbF2bsweHuQxc/Yi2pAbh69
         pALA==
X-Gm-Message-State: AOJu0Ywr4UzPariOihDCG4yASp/3MtmPBV+NtR8VntmwCrwM4SO5EYzE
	VTQHxdHqz3DGuix9hQi9CGnTBIK1z9dBwNEyxennz7lRf3ZfwLvBgPiL23xj8A==
X-Gm-Gg: AfdE7cmXdzSHXR2NjDSoV+KyFlt2sUwdIBYoQ/cpbPRuYvb/CVzL0D0n8RfskI7h7qN
	IrA7ncQRx6/zdlAf76GtMejY/E6dqDkITe63lRni1nJtByCLz5fh8EJN62gCTu/dZeDMaY+4YSV
	zCTRiD3sz+GtdnV9JeYHzfOpnGbypT237G0x59Cc5OpB9xr/kfl5mctE386S76Uja++PTqT3lfs
	4fcIR02J/VFpsvlKUtZvPdrkg08BY0zDFZY6Ixq7VbzH4puRvl7uhFvunMbRQcoa0EexUMbQl/L
	C0OXin80H2+qKukJX6f5scqqlqzBk7FURb/C7ApW3rw2ljp96Q6Zfq+Jp2109wXgoF4JYvQaelD
	LNNCLbeKAVopj/sULHzgoa+j8t8kw5P3zAO4DYyWe9JJN6nXyNwg29rvkmjGBLsMg9tvbpC8Xwk
	OC6/3Mf4+MUuSXwg==
X-Received: by 2002:a05:6820:4c12:b0:6a0:c6fa:5a04 with SMTP id 006d021491bc7-6a1160b0701mr2351440eaf.2.1782237014116;
        Tue, 23 Jun 2026 10:50:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0eb8adsm8476735fac.18.2026.06.23.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/15] bpf: Remove unnecessary prog_list_prog() check
Date: Tue, 23 Jun 2026 10:49:52 -0700
Message-ID: <20260623175006.3136053-5-ameryhung@gmail.com>
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

effective_prog_pos(), called from replace_effective_prog() and
purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..b64f6757096c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -965,9 +965,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
-				continue;
-
+			/*
+			 * No detaching pl (NULL prog and link) is visible to the callers,
+			 * so skip the check compute_effective_progs() needs.
+			 */
 			if (pl->flags & BPF_F_PREORDER) {
 				if (pl == target_pl)
 					pos = bstart;
-- 
2.53.0-Meta

