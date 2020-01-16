Return-Path: <SRS0=iaO9=3F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCAC33CB6
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5052087E
	for <bpf@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194061;
	bh=Iflmr5KTa4EvWPiyz6L70H0YAyIa2ki7BOgBX+CEbos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqZW9PDmWVhfbnnn2f590uvi73gbJkPdk0lHGKrhitACnnJ1z16voiW61KKwU63By
	 Jt9XwjiwmzobCduw615Z2zXPSXQndIdlt5DPxKdrVsgKE9r713RSCv8lFy9veEoBV1
	 pXH1Dtkk6pvATzzrYwSYZtCo1K7qVh4agMAgE86U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbgAPRBA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbgAPRA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E70920728;
        Thu, 16 Jan 2020 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194057;
        bh=Iflmr5KTa4EvWPiyz6L70H0YAyIa2ki7BOgBX+CEbos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1iwxcEN0DCerfTSZ/qxUnYf+cW6kYUjbK+YxpYfC7vN7Rs125cphge3N61Oef4+2N
         p59XqMAt9Aiho9X3aj4+r2u59e+nXfjM5+hYfadG3SWGJF9xQgUgDWS2W97YBPK5Y/
         GEysbfl9WXL9kfdlYZfXX6jREvNvrM7kneo+pXgM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 170/671] xsk: add missing smp_rmb() in xsk_mmap
Date:   Thu, 16 Jan 2020 11:51:19 -0500
Message-Id: <20200116165940.10720-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

[ Upstream commit e6762c8bcf982821935a2b1cb33cf8335d0eefae ]

All the setup code in AF_XDP is protected by a mutex with the
exception of the mmap code that cannot use it. To make sure that a
process banging on the mmap call at the same time as another process
is setting up the socket, smp_wmb() calls were added in the umem
registration code and the queue creation code, so that the published
structures that xsk_mmap needs would be consistent. However, the
corresponding smp_rmb() calls were not added to the xsk_mmap
code. This patch adds these calls.

Fixes: 37b076933a8e3 ("xsk: add missing write- and data-dependency barrier")
Fixes: c0c77d8fb787c ("xsk: add user memory registration support sockopt")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ff15207036dc..547fc4554b22 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -661,6 +661,8 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 		if (!umem)
 			return -EINVAL;
 
+		/* Matches the smp_wmb() in XDP_UMEM_REG */
+		smp_rmb();
 		if (offset == XDP_UMEM_PGOFF_FILL_RING)
 			q = READ_ONCE(umem->fq);
 		else if (offset == XDP_UMEM_PGOFF_COMPLETION_RING)
@@ -670,6 +672,8 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 	if (!q)
 		return -EINVAL;
 
+	/* Matches the smp_wmb() in xsk_init_queue */
+	smp_rmb();
 	qpg = virt_to_head_page(q->ring);
 	if (size > (PAGE_SIZE << compound_order(qpg)))
 		return -EINVAL;
-- 
2.20.1

