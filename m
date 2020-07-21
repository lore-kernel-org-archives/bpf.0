Return-Path: <SRS0=BdeU=BA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57140C43445
	for <bpf@archiver.kernel.org>; Tue, 21 Jul 2020 05:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34193208E4
	for <bpf@archiver.kernel.org>; Tue, 21 Jul 2020 05:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGUFFH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:05:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:4957 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgGUFFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 01:05:06 -0400
IronPort-SDR: bxpTRX0ySA3vgRt01tvHkWCyi6FjGBw4U4k/pKh91IhDaGqSeTGrwHJ1vEZkYt4Vqhkd8gopen
 N/7ZTpj7Pr3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214726587"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="214726587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 22:05:06 -0700
IronPort-SDR: l6cNtvZc24oLkjXurSvcax+JyVur6mu2T7kfb1C+VlHrPmvUcQ8QnLET38jg9blz6W+R2KqyS+
 RjEIteyVD+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="431855708"
Received: from taktemur-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.252.33.122])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2020 22:05:02 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, maximmi@mellanox.com
Cc:     bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com, cristian.dumitrescu@intel.com
Subject: [PATCH bpf-next v4 11/14] xsk: add shared umem support between devices
Date:   Tue, 21 Jul 2020 07:04:05 +0200
Message-Id: <1595307848-20719-12-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595307848-20719-1-git-send-email-magnus.karlsson@intel.com>
References: <1595307848-20719-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support to share a umem between different devices. This mode
can be invoked with the XDP_SHARED_UMEM bind flag. Previously,
sharing was only supported within the same device. Note that when
sharing a umem between devices, just as in the case of sharing a
umem between queue ids, you need to create a fill ring and a
completion ring and tie them to the socket (with two setsockopts,
one for each ring) before you do the bind with the
XDP_SHARED_UMEM flag. This so that the single-producer
single-consumer semantics of the rings can be upheld.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e897755..ec2a2df 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -701,14 +701,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 			sockfd_put(sock);
 			goto out_unlock;
 		}
-		if (umem_xs->dev != dev) {
-			err = -EINVAL;
-			sockfd_put(sock);
-			goto out_unlock;
-		}
 
-		if (umem_xs->queue_id != qid) {
-			/* Share the umem with another socket on another qid */
+		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* Share the umem with another socket on another qid
+			 * and/or device.
+			 */
 			xs->pool = xp_create_and_assign_umem(xs,
 							     umem_xs->umem);
 			if (!xs->pool) {
-- 
2.7.4

