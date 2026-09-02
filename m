Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B73EC808
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340235; cv=none; b=VTJMfJ7hhLR1gmMcIwHHjupF92Evt3uiIvhH/ww7JdbU6NYwvJDhZ0nIAfxRvGsF5VVov1xLTlxkNuurn9dCeuRRUMspR9rvy44XBCNrc3NvfFkLbHeNpP7Sa1k9ZlqNistwvHwLmyLlsGYlVCfsmAmN6vRyhjiUiq4VmwV0MEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340235; c=relaxed/simple;
	bh=vQdzM4rvKFPam5dovDbIDl+CNeWDCL+2DysFzbO4wt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKgmgz67w/8UViTEhTgVH4P/J5EjmOU+Q6HA5WBUUvRBYkXq2uzeeP7/W7v+IkpN6DOjZJB4qYAm12M4HAOBnivJaYwwzyVHzjZxGXONbKMfqDg3hoswXsc2TqU6Jsm3E1JThK3sTCKZ0fNjGFKSqPi/qYZPkwaonU1pMJ+ARnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAbg+gr9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAbg+gr9"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso916273a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788340233; x=1788945033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3pzX1jjiPX5m+fIujObi1ijyr2+XOPha2U23/dw054=;
        b=FAbg+gr9i+wiFkWbeo59b9YQ7nkLxmCR7uwFjfn5SyL82Mo0orLeIwyiAXdqcAKpNL
         sfRxw63Vrp5bujlnEJfRdlvFrHN2vBQTZNidxUXkIucnQhgv739m9kzuYTauvzZTkVz4
         6bJRBl/ATelW7LcDcFHWmcl1KNx9JgBtOmthFoQ7TKho8JfdqiAVPMJ0DCt/fCMLiraC
         HbTQVlLPhewUwkf6+ZjGOKFe6quhlEjCYdgZIR7NuwpJcIbD3ZO7d4VI+Ck9iRlRR2Eu
         Ws+m5zQzviM11PEP0QtMLbTU+nrAj8yE9ZFV6TBDcoxYUqE3tx4HYjC8qh5/P8qpzrd8
         eEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788340233; x=1788945033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3pzX1jjiPX5m+fIujObi1ijyr2+XOPha2U23/dw054=;
        b=YcAnfw741emGgEIU4LAydmFDk7oA1tJ36T5H1q7DnjT2U8Pa4681Dxam0puZ5iO+i0
         VsWpa01ei/OdvRU0N9muMpt/UVbS64rcqaSJAuIxoDdfFexJgMksTHG/b+i0ftLjMSke
         hXwEuyxqPP/MzdJW/4XRtQLs7wHVeDppHWvTaxpbSRoWBBioxV//GLKnWbyCnHmYs/PK
         cG+OMJaPP0bvh9ClpodmYTIUzoGO+BX1F9nIjnVbFCalILcK7wYa7IMPYtbj1UKyQfai
         PQm9gHVUnE0PapKN51reqrsOeioFkV/XRoCcScxsKAPudkL+kxLcjqBpuNha8af2xcf9
         Q9hQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGCrSMOszAzck9+r37xhlQ7S4b6uEfZbPxxEcPYWXMhH66HBxayUefJ1IFoz6mem9/v0A=@vger.kernel.org
X-Gm-Message-State: AFuF++m6PNaz2L3d2bA+YmUFvP/Wv2iG5NACllQJweyjxf+bvtll2GZj
	eu/JZTh/BCNW6Wm4swCG0kyPlsb36UFUpJJoQpMftmMJUBuyIgrc7Qx8
X-Gm-Gg: AR+sD13y3GLIfGXIF8ZQPAsooR1okMwhnV+x2Lp45bjrBxaR9T8vUB8km+3VH998jnT
	RGMtbSbMCgIMNz0V8TRV1VlR1Hytz+f6oJfpus3AGrgLRrPe4yVdID11PQo+aq5DpP2QtVdyJSH
	b2LR3KLMeSG1Uqjhj1hYv505caVZY7+StXgcFJZ1sv0LqGgQfsFrs8u0eTo6u0vBr94F66r+rAO
	9LEvMV28hfGU7K70G7Mw4t5k80FYn5xIdfFXfMRnelGAjEhxtm5/9fmldsllOHE8TtsFhrhtYw5
	HfuJiWCKds/RXnFPoNOpY1ijKclmRcfhUVG0XeFJ699gnbQHGEsB7lWU/lLFgZomKEERf+v0Khn
	UgYwMp+XKM6ZEvQeWudjMmzDb1uV1yZS2de47tV0e1zel9oRH9AyKe6Mf/X7A1DuPRQjqaAMri2
	vtcFt+WInV4y8D7dQkSsbwAFI+PPugitpNQjHskw5GsVkoQGjo45CRIVAxa8Pmz967vWnlyQxDd
	xtqEGi6kU5oFUxpw8V51Dq+sXEohCjB60cvXpm9Bw5xxAdqA9s=
X-Received: by 2002:a05:6a20:430a:b0:3d1:3c2:85b6 with SMTP id adf61e73a8af0-3d9ac8413a1mr4882102637.5.1788340232802;
        Wed, 02 Sep 2026 02:10:32 -0700 (PDT)
Received: from baaz.tail58d41.ts.net ([2401:4900:8852:4cb2:4c70:f750:2a36:4165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34e371e0esm744502a12.28.2026.09.02.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:10:32 -0700 (PDT)
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH net-next v2] net: mana: remove unreachable dead code in mana_bpf()
Date: Wed,  2 Sep 2026 14:40:10 +0530
Message-ID: <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_bpf() has a trailing 'return ret;' after a switch statement whose
every case (XDP_SETUP_PROG and default) already returns unconditionally.
The statement is therefore unreachable and 'ret' is never used.

Remove both. No functional change intended.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2:
  - reword the commit message: drop the claim that an uninitialized value
    could be returned; every switch case returns unconditionally, so the
    statement is simply unreachable. Describe it as a pure cleanup.
  - drop the Fixes: tag offered during v1 review, per the guidance that
    net-next changes should not carry Fixes: tags.
  - no code changes.
v1: https://lore.kernel.org/netdev/DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com/

 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 53308e139cbe9..70bb8c9dc3413 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 {
 	struct netlink_ext_ack *extack = bpf->extack;
-	int ret;
 
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
@@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return ret;
 }
-- 
2.55.0

