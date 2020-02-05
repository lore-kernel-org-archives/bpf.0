Return-Path: <SRS0=QUaE=3Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB67C352A2
	for <bpf@archiver.kernel.org>; Wed,  5 Feb 2020 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E8D2082E
	for <bpf@archiver.kernel.org>; Wed,  5 Feb 2020 12:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBEMGc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:06:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:56045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgBEMGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Feb 2020 07:06:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 04:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="254742614"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2020 04:06:29 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com
Subject: [PATCH bpf 3/3] samples: bpf: allow for -ENETDOWN in xdpsock
Date:   Wed,  5 Feb 2020 05:58:34 +0100
Message-Id: <20200205045834.56795-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205045834.56795-1-maciej.fijalkowski@intel.com>
References: <20200205045834.56795-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ndo_xsk_wakeup() can return -ENETDOWN and there's no particular reason
to bail the whole application out on that case. Let's check in kick_tx()
whether errno was set to mentioned value and basically allow application
to further process frames.

Fixes: 248c7f9c0e21 ("samples/bpf: convert xdpsock to use libbpf for AF_XDP access")
Reported-by: Cameron Elliott <cameron@cameronelliott.com>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 samples/bpf/xdpsock_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index bab7a850e..c91e91362 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -788,7 +788,8 @@ static void kick_tx(struct xsk_socket_info *xsk)
 	int ret;
 
 	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
-	if (ret >= 0 || errno == ENOBUFS || errno == EAGAIN || errno == EBUSY)
+	if (ret >= 0 || errno == ENOBUFS || errno == EAGAIN ||
+	    errno == EBUSY || errno == ENETDOWN)
 		return;
 	exit_with_error(errno);
 }
-- 
2.20.1

