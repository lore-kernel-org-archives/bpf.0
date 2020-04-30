Return-Path: <SRS0=Oi1G=6O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD3C8300B
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FBB2076D
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M01YEvrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgD3LVw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:21:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgD3LVw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 07:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588245710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oK11vN94RCqKHK+FzFMoMbos3SJFxBnpTqbvu3/vYSE=;
        b=M01YEvrDzr2OASmZWi0RLLbmwMiJheL3EWOpNim+RwteQBaupDI13vAjZPp36qSZIEfRiX
        MWNYto8Pux4rTiGDxlJdcAJu7iv5RMSLVJsN6RIucpB8rovW4283lF6uXqB/lVGRhFn4xb
        J8WUDH2Cq430MOV8t28QzIMqh11yhgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-MPZA4DGnPJ-I2FDBk_NAyA-1; Thu, 30 Apr 2020 07:21:46 -0400
X-MC-Unique: MPZA4DGnPJ-I2FDBk_NAyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 739F5800D24;
        Thu, 30 Apr 2020 11:21:44 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C365660C87;
        Thu, 30 Apr 2020 11:21:38 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id B344E324DB2C1;
        Thu, 30 Apr 2020 13:21:37 +0200 (CEST)
Subject: [PATCH net-next v2 15/33] ena: add XDP frame size to amazon NIC
 driver
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Date:   Thu, 30 Apr 2020 13:21:37 +0200
Message-ID: <158824569766.2172139.6599250198671333350.stgit@firesoul>
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Frame size ENA_PAGE_SIZE is limited to 16K on systems with larger
PAGE_SIZE than 16K. Change ENA_XDP_MAX_MTU to also take into account
the reserved tailroom.

Cc: Arthur Kiyanovski <akiyano@amazon.com>
Acked-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.h |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 2cc765df8da3..0fd7db1769f8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1606,6 +1606,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 		  "%s qid %d\n", __func__, rx_ring->qid);
 	res_budget = budget;
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.frame_sz = ENA_PAGE_SIZE;
 
 	do {
 		xdp_verdict = XDP_PASS;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 97dfd0c67e84..dd00127dfe9f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -151,8 +151,9 @@
  * The buffer size we share with the device is defined to be ENA_PAGE_SIZE
  */
 
-#define ENA_XDP_MAX_MTU (ENA_PAGE_SIZE - ETH_HLEN - ETH_FCS_LEN - \
-				VLAN_HLEN - XDP_PACKET_HEADROOM)
+#define ENA_XDP_MAX_MTU (ENA_PAGE_SIZE - ETH_HLEN - ETH_FCS_LEN -	\
+			 VLAN_HLEN - XDP_PACKET_HEADROOM -		\
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 #define ENA_IS_XDP_INDEX(adapter, index) (((index) >= (adapter)->xdp_first_ring) && \
 	((index) < (adapter)->xdp_first_ring + (adapter)->xdp_num_queues))


