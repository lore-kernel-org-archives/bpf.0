Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18AC433E0
	for <bpf@archiver.kernel.org>; Mon, 29 Mar 2021 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B75F61919
	for <bpf@archiver.kernel.org>; Mon, 29 Mar 2021 22:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhC2W4U (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:56:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:2470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232039AbhC2Wzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 18:55:50 -0400
IronPort-SDR: UHseqLH2RW/QRBs73HHkCdnXP2Ex5KoHF31IjQxmZpZrOFfTIX3NbkJeKdSlp46/Ct8dXL9l7k
 xcmiJAiO9JXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="189393053"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="189393053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:55:50 -0700
IronPort-SDR: aSLgjpQIMNxBDFG1bT4M7+2mk+b5XrY38ojoqQ7+xN+h69sVVl3yiXJaoZI+pb3fpJXb10UE/x
 CmMqaK+RM8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417884373"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2021 15:55:47 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, andrii@kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        ciara.loftus@intel.com, john.fastabend@gmail.com, toke@redhat.com
Subject: [PATCH v5 bpf-next 17/17] selftests: xsk: Remove unused defines
Date:   Tue, 30 Mar 2021 00:43:16 +0200
Message-Id: <20210329224316.17793-18-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329224316.17793-1-maciej.fijalkowski@intel.com>
References: <20210329224316.17793-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Remove two unused defines.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 7 +++----
 tools/testing/selftests/bpf/xdpxceiver.h | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 084ba052fa89..0a7c5a8ca585 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -456,7 +456,7 @@ static void complete_tx_only(struct xsk_socket_info *xsk, int batch_size)
 	if (!xsk->outstanding_tx)
 		return;
 
-	if (!NEED_WAKEUP || xsk_ring_prod__needs_wakeup(&xsk->tx))
+	if (xsk_ring_prod__needs_wakeup(&xsk->tx))
 		kick_tx(xsk);
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
@@ -544,9 +544,8 @@ static void tx_only(struct xsk_socket_info *xsk, u32 *frameptr, int batch_size)
 	xsk_ring_prod__submit(&xsk->tx, batch_size);
 	if (!tx_invalid_test) {
 		xsk->outstanding_tx += batch_size;
-	} else {
-		if (!NEED_WAKEUP || xsk_ring_prod__needs_wakeup(&xsk->tx))
-			kick_tx(xsk);
+	} else if (xsk_ring_prod__needs_wakeup(&xsk->tx)) {
+		kick_tx(xsk);
 	}
 	*frameptr += batch_size;
 	*frameptr %= num_frames;
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index ef219c0785eb..6c428b276ab6 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -34,13 +34,11 @@
 #define IP_PKT_TOS 0x9
 #define UDP_PKT_SIZE (IP_PKT_SIZE - sizeof(struct iphdr))
 #define UDP_PKT_DATA_SIZE (UDP_PKT_SIZE - sizeof(struct udphdr))
-#define TMOUT_SEC (3)
 #define EOT (-1)
 #define USLEEP_MAX 200000
 #define SOCK_RECONF_CTR 10
 #define BATCH_SIZE 64
 #define POLL_TMOUT 1000
-#define NEED_WAKEUP true
 #define DEFAULT_PKT_CNT 10000
 #define RX_FULL_RXQSIZE 32
 
-- 
2.20.1

