Return-Path: <SRS0=396g=AN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC7C433DF
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2352E2088E
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgGBONd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:13:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44301 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGBONc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 10:13:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id by13so14192771edb.11;
        Thu, 02 Jul 2020 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsPbjoVXLMKo7otPkywLiwQyR35vOhEsRAVtfPQ7uPY=;
        b=sEM5aWXv4SmbHZXmm0E8kY3oV1f4yzwmF3ZSKCxxEDwXsa8hDQDLzA04T1f8Bl4NWq
         NGDphfhYEVnXEmzT8sF+aWR/XDcrffWuDPgkTo15qNOl+FyRr2bEf5WEaFjfhUTUbiQT
         dnbti5s1FmTas0ealGdwdNX52pvGpg2EBnwje+Old0xnkc7L5gbJLZSmHyMxXUJPNPM+
         gvBwP5Fec5StRfzkJ8ojdwQe37fIAZ3OLOB6UrmVD+HYmI8YE3gOaXInZ8oc7uHZe4l+
         5gJXizZkTnV2uDsrX/hqk0Hn36XYKvZJPrwpTZW5MNnw0bdHm9HiwLNdbABSpzFO80uF
         owqA==
X-Gm-Message-State: AOAM532Ry9Rn87sO/RDe1KVwjEjPI/xHnAHXsmKMWINQBsWiixJGukSd
        4JJ2gd+QeBDYIt9yM5p4LvywsNEQKNTWfw==
X-Google-Smtp-Source: ABdhPJzN3WH5DusuvBg/bp0+HLS2X/QP/5kA0A8Qh+i0r7cP/N2R+tHokcqv6IIMbdiBMlR+Zx9v0Q==
X-Received: by 2002:aa7:c31a:: with SMTP id l26mr33707846edq.61.1593699209854;
        Thu, 02 Jul 2020 07:13:29 -0700 (PDT)
Received: from msft-t490s.lan ([2001:b07:5d26:7f46:d7c1:f090:1563:f81f])
        by smtp.gmail.com with ESMTPSA id fi29sm6841274ejb.83.2020.07.02.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:13:29 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>, maxime.chevallier@bootlin.com,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v2 1/5] mvpp2: refactor BM pool init percpu code
Date:   Thu,  2 Jul 2020 16:12:40 +0200
Message-Id: <20200702141244.51295-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702141244.51295-1-mcroce@linux.microsoft.com>
References: <20200702141244.51295-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

In mvpp2_swf_bm_pool_init_percpu(), a reference to a struct
mvpp2_bm_pool is obtained traversing multiple structs, when a
local variable already points to the same object.

Fix it and, while at it, give the variable a meaningful name.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 212fc3b54310..027de7291f92 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -907,28 +907,27 @@ static int mvpp2_swf_bm_pool_init_shared(struct mvpp2_port *port)
 /* Initialize pools for swf, percpu buffers variant */
 static int mvpp2_swf_bm_pool_init_percpu(struct mvpp2_port *port)
 {
-	struct mvpp2_bm_pool *p;
+	struct mvpp2_bm_pool *bm_pool;
 	int i;
 
 	for (i = 0; i < port->nrxqs; i++) {
-		p = mvpp2_bm_pool_use_percpu(port, MVPP2_BM_SHORT, i,
-					     mvpp2_pools[MVPP2_BM_SHORT].pkt_size);
-		if (!p)
+		bm_pool = mvpp2_bm_pool_use_percpu(port, MVPP2_BM_SHORT, i,
+						   mvpp2_pools[MVPP2_BM_SHORT].pkt_size);
+		if (!bm_pool)
 			return -ENOMEM;
 
-		port->priv->bm_pools[i].port_map |= BIT(port->id);
-		mvpp2_rxq_short_pool_set(port, i, port->priv->bm_pools[i].id);
+		bm_pool->port_map |= BIT(port->id);
+		mvpp2_rxq_short_pool_set(port, i, bm_pool->id);
 	}
 
 	for (i = 0; i < port->nrxqs; i++) {
-		p = mvpp2_bm_pool_use_percpu(port, MVPP2_BM_LONG, i + port->nrxqs,
-					     mvpp2_pools[MVPP2_BM_LONG].pkt_size);
-		if (!p)
+		bm_pool = mvpp2_bm_pool_use_percpu(port, MVPP2_BM_LONG, i + port->nrxqs,
+						   mvpp2_pools[MVPP2_BM_LONG].pkt_size);
+		if (!bm_pool)
 			return -ENOMEM;
 
-		port->priv->bm_pools[i + port->nrxqs].port_map |= BIT(port->id);
-		mvpp2_rxq_long_pool_set(port, i,
-					port->priv->bm_pools[i + port->nrxqs].id);
+		bm_pool->port_map |= BIT(port->id);
+		mvpp2_rxq_long_pool_set(port, i, bm_pool->id);
 	}
 
 	port->pool_long = NULL;
-- 
2.26.2

