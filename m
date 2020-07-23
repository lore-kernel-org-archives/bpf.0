Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB8C433F7
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2CE2086A
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504598;
	bh=Fw24wTjhX6/veV0b6MJa4ylEAknEnmUlJ5/TqSGR07c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrV/5bLm/iOBJOWJ9z2hmGrz5r8fg18MOr74T+H3V3FLP3ROSNEOPCYegeCLq81TG
	 /KT+bgx4T7s0XAq9iZVXj6eM9lW5tJAjl/fAJYE4X1dCyPb+g8HzYixVX0w/Y+BBMS
	 msB0uYW9vGcdsXBcXHzk8HfhcsauESA+0RCTGlWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGWLnR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgGWLnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:43:17 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA68520B1F;
        Thu, 23 Jul 2020 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504597;
        bh=Fw24wTjhX6/veV0b6MJa4ylEAknEnmUlJ5/TqSGR07c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRMLtFzeJJK9jx4pu5W8ym16Q2atoYT4gcywh+FfskDt/ioaa3LhAyNrtxzjT3TzX
         rvTo0MxcXNLv65ELEx60lcKR/mtKvvweASEi9Z3Jx3eOADd9Y+XsS/rB0gpzwq8hg0
         /nZbEYAe7FKhIez4xIVQ7pzW5G7xr5EPHUv9mrOw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 05/22] net: veth: initialize mb bit of xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:17 +0200
Message-Id: <40621d3a47889b83eb79a4d519872f84c89dd558.1595503780.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1595503780.git.lorenzo@kernel.org>
References: <cover.1595503780.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Initialize multi-buffer bit (mb) to 0 in xdp_buff data structure.
This is a preliminary patch to enable xdp multi-buffer support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index b594f03eeddb..463865c513b2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -711,6 +711,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	/* SKB "head" area always have tailroom for skb_shared_info */
 	xdp.frame_sz = (void *)skb_end_pointer(skb) - xdp.data_hard_start;
 	xdp.frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	xdp.mb = 0;
 
 	orig_data = xdp.data;
 	orig_data_end = xdp.data_end;
-- 
2.26.2

