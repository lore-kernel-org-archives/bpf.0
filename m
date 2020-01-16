Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D4C33CB6
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB302467E
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195441;
	bh=Eq9RVcXC8HyF9NPP1DA4CFc8o7TE6r/C5AI3H7ITmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYTqJ1uhuOQHFmB/MF+mbA1MVgkWHP3f0ML7bknGJh+h5gn7yjNrlYzAMiZvHffK6
	 uLLbjq9FUL/s3dhEpcJJ77KfKyWUPHRbPPsq/oiM2U3yQezdrWo3zdy3wojDdOTuI7
	 vN6YPkwYikRwJDiGvyo+Lxrqp0sAeVHFPWCq0bxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAPRXy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390652AbgAPRNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52ADE246A3;
        Thu, 16 Jan 2020 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194788;
        bh=Eq9RVcXC8HyF9NPP1DA4CFc8o7TE6r/C5AI3H7ITmvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmLon4rdYPCFqydEoF5rPrOhdfHittVmDJnKQe/mk/MOrCo9tFcRjkutDhzjOwHkB
         sApDGbD+405nmSKEyGAnLtOC/14TRPbSgV57MuICbats1OnqdQmDIldVL2Dl7Rkb2X
         PxmaF8uAsZClNaGa/AwTtBxVvve3IiMPPkN0ox6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Kal Cutter Conley <kal.conley@dectris.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 602/671] xsk: Fix registration of Rx-only sockets
Date:   Thu, 16 Jan 2020 12:04:00 -0500
Message-Id: <20200116170509.12787-339-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

[ Upstream commit 2afd23f78f39da84937006ecd24aa664a4ab052b ]

Having Rx-only AF_XDP sockets can potentially lead to a crash in the
system by a NULL pointer dereference in xsk_umem_consume_tx(). This
function iterates through a list of all sockets tied to a umem and
checks if there are any packets to send on the Tx ring. Rx-only
sockets do not have a Tx ring, so this will cause a NULL pointer
dereference. This will happen if you have registered one or more
Rx-only sockets to a umem and the driver is checking the Tx ring even
on Rx, or if the XDP_SHARED_UMEM mode is used and there is a mix of
Rx-only and other sockets tied to the same umem.

Fixed by only putting sockets with a Tx component on the list that
xsk_umem_consume_tx() iterates over.

Fixes: ac98d8aab61b ("xsk: wire upp Tx zero-copy functions")
Reported-by: Kal Cutter Conley <kal.conley@dectris.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Link: https://lore.kernel.org/bpf/1571645818-16244-1-git-send-email-magnus.karlsson@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xdp_umem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index d9117ab035f7..556a649512b6 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -23,6 +23,9 @@ void xdp_add_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
 {
 	unsigned long flags;
 
+	if (!xs->tx)
+		return;
+
 	spin_lock_irqsave(&umem->xsk_list_lock, flags);
 	list_add_rcu(&xs->list, &umem->xsk_list);
 	spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
@@ -32,6 +35,9 @@ void xdp_del_sk_umem(struct xdp_umem *umem, struct xdp_sock *xs)
 {
 	unsigned long flags;
 
+	if (!xs->tx)
+		return;
+
 	spin_lock_irqsave(&umem->xsk_list_lock, flags);
 	list_del_rcu(&xs->list);
 	spin_unlock_irqrestore(&umem->xsk_list_lock, flags);
-- 
2.20.1

