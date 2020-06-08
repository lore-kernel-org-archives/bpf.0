Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C2C433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EC0206C3
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662935;
	bh=rFk4ndRXik1qE5fwJ3x+1OM2AUjpwZLqi+jCYlMawr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oD7Q97DsomrYnpHFo43+gpOdTfIMIcQTyEegusCU4AOSq08BBjOHD8nWO2mtWaJq1
	 Y7uibWxIyEsB4Sgzk/kSOo0dW0niHUdV3Ij17Dn/u+U+QwoU1G0fWPbp/xHZv0FIcN
	 ZBUfMAsk1jRoMh3k7dPBYt14IcQXr6o9MAKSduWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgFIAfV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgFHXO2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD742158C;
        Mon,  8 Jun 2020 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658068;
        bh=rFk4ndRXik1qE5fwJ3x+1OM2AUjpwZLqi+jCYlMawr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TNYjLSW9NRSPbMFceSfYyImR1gOXTp4d63d1/FrxS9kDZl4JGN8wUwI9o27MOYmY
         YTdH1l7mD1CgIPzM7+BEVmhtdD07z29/UGbyCMJxQXaIuw2a+bkNc3/U3ui6ZatHzX
         FAineUZgkN+BHq8quY+JOI4ohTYVPVE6MxRQ9b7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gavin Shan <gshan@redhat.com>, Shay Agroskin <shayagr@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 114/606] net/ena: Fix build warning in ena_xdp_set()
Date:   Mon,  8 Jun 2020 19:03:59 -0400
Message-Id: <20200608231211.3363633-114-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Gavin Shan <gshan@redhat.com>

[ Upstream commit caec66198d137c26f0d234abc498866a58c64150 ]

This fixes the following build warning in ena_xdp_set(), which is
observed on aarch64 with 64KB page size.

   In file included from ./include/net/inet_sock.h:19,
      from ./include/net/ip.h:27,
      from drivers/net/ethernet/amazon/ena/ena_netdev.c:46:
   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function         \
   ‘ena_xdp_set’:                                                    \
   drivers/net/ethernet/amazon/ena/ena_netdev.c:557:6: warning:      \
   format ‘%lu’                                                      \
   expects argument of type ‘long unsigned int’, but argument 4      \
   has type ‘int’                                                    \
   [-Wformat=] "Failed to set xdp program, the current MTU (%d) is   \
   larger than the maximum allowed MTU (%lu) while xdp is on",

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 8795e0b1dc3c..8984aa211112 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -69,7 +69,7 @@
  * 16kB.
  */
 #if PAGE_SIZE > SZ_16K
-#define ENA_PAGE_SIZE SZ_16K
+#define ENA_PAGE_SIZE (_AC(SZ_16K, UL))
 #else
 #define ENA_PAGE_SIZE PAGE_SIZE
 #endif
-- 
2.25.1

