Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E7C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16D5213F2
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OOU1IZOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfCTQrY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:47:24 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48554 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfCTQrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 12:47:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 04EA36CB
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 16:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sUQAceW9FeD0 for <bpf@vger.kernel.org>;
        Wed, 20 Mar 2019 11:47:22 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id B7A0BB00
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 11:47:22 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id m70so2705232ita.2
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OCgBGZ9QjrlJl4iqs5f+O79+0bjbKr934DYkhHFKtlI=;
        b=OOU1IZOV9kn1tAIKwAszR4rbr3YZUrdscvNFOXpdRgrs6/eYjIAoPUrjtJvcqQVcJf
         A36wmRrtoTk5TPenXYIzTMciqQQ2sYJrbSISrXgcrl1H5X2FWGWCpLx2JQ8kXdDFrvSu
         62M9xppkgs2x47romIPEU52RfQD8w9tXUBgxUhfAZlYaLauoET56ggrQWG3V7PZr24hH
         fojdSk4F79VsAhYF5Q+z4E1onMTCdGou7QMySYKO+pUlZGVZ/2M/cm5E7LcxFk/OZI8S
         yyp/VSf67HnGSgBxGiZXHRBiajTrdNcyVgur6cO8PI/A4/7M1YcDraPC2Rihi1G8mWQG
         miEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OCgBGZ9QjrlJl4iqs5f+O79+0bjbKr934DYkhHFKtlI=;
        b=OQq171pQWo12UVL+QQ8GSQN4ZD8WRr+5SdpW9NUNnM3SHXsO7PFr2yykSxPRrFrfcx
         NSzN1oxE1yyC/tJ6paxkPWz4Eas5iRryZnp+uT+hVfTQekSjP0MvouIP9KY6IXEIfrhC
         9kCk9KYwAziyjO9OMneTQ9P5uEMlg/ZsAhO6O3weUGd0P63P0LAQKI4hDYEPhFm1seJp
         L1y5NlxtIrt1qhkbm3XOUQtEuYmAODRRLWcOkRq+Lyf9fq8rD53Dx9mKBGV1jfX7l8W9
         2q7xD8MhnqUZ2f5f/p+6DdstoqIOKrrJy3SU4iFwGYkZncKrj7IaAVIvKk3+QvA0P3cv
         v5WA==
X-Gm-Message-State: APjAAAWOepAm92WwvPoX0jTQ761bBKUrpgVyBBkCtZ+l8zy5uDGtGyXF
        pfFjeLY8RgYQ9QEwMEDm3kmxnaERZcbunFe67kNPqhQS3CuHLhQOd4fqdfwNXqZErLqyRDhY65J
        Paj4dkdp8Y3rzvCqs
X-Received: by 2002:a02:224b:: with SMTP id o72mr6035564jao.16.1553100442381;
        Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+NDgp64O6AmEVq1LCbh8ES/jB1pQ+DbqegVXDMft241QSXQGu2eOSh7t51T3tQyvIPVoHEQ==
X-Received: by 2002:a02:224b:: with SMTP id o72mr6035548jao.16.1553100442203;
        Wed, 20 Mar 2019 09:47:22 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id v4sm982480ios.10.2019.03.20.09.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:47:21 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2] thunderbolt: xdomain: Fix to check return value of kmemdup
Date:   Wed, 20 Mar 2019 11:47:20 -0500
Message-Id: <20190320164720.31264-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kmemdup can fail and return a NULL pointer. The patch modifies the
signature of tb_xdp_schedule_request and passes the failure error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Missed clean up of xw in case of kmemdup failure, per David
---
 drivers/thunderbolt/xdomain.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..316360109bea 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -526,7 +526,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	kfree(xw);
 }
 
-static void
+static bool
 tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 			size_t size)
 {
@@ -534,13 +534,18 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 
 	xw = kmalloc(sizeof(*xw), GFP_KERNEL);
 	if (!xw)
-		return;
+		return false;
 
 	INIT_WORK(&xw->work, tb_xdp_handle_request);
 	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
+	if (!xw->pkg) {
+		kfree(xw);
+		return false;
+	}
 	xw->tb = tb;
 
 	queue_work(tb->wq, &xw->work);
+	return true;
 }
 
 /**
@@ -1416,10 +1421,8 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 	 * handlers in turn.
 	 */
 	if (uuid_equal(&hdr->uuid, &tb_xdp_uuid)) {
-		if (type == TB_CFG_PKG_XDOMAIN_REQ) {
-			tb_xdp_schedule_request(tb, hdr, size);
-			return true;
-		}
+		if (type == TB_CFG_PKG_XDOMAIN_REQ)
+			return tb_xdp_schedule_request(tb, hdr, size);
 		return false;
 	}
 
-- 
2.17.1

