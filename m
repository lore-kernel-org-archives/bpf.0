Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A4DC43219
	for <bpf@archiver.kernel.org>; Tue, 29 Mar 2022 05:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiC2FKb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Mar 2022 01:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiC2FK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 01:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BB10F8;
        Mon, 28 Mar 2022 22:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010DE61477;
        Tue, 29 Mar 2022 05:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF26C34112;
        Tue, 29 Mar 2022 05:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648530525;
        bh=+Vb/d+QtzOBqo/ycx6OvL5BZXjJUpw7EnMkEx/Q0eC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNeATK7zs8iRq3iSbwFxU+WE4gvsT4vNkluA4uJjwNDC1ZwVmK7WGV24nm79Hb1X0
         crqiG5suz7VhlZgIbY7Rii27D86Hkh39N6zq6Es2z4RpYjgEpr+LgFG628h1ugH1wz
         M6TptLkbI8Wp4dadWJvpLdq69lNZaATNLqQDUxHZ1t1nCY4cKwGP1PDXWM11EeWBT5
         1niKsWhwnU1JjDBqBIN7muBTLwYPmFzhazNk7gi756f5IUXaZXwOvMzm+c13aYfbAW
         upsv2m9qEt+EYLkPm3ndpYn09qALnYkmwLr79Mg2p7+yNL7zkjiCE5edM1mJYgH1y4
         KNt5OHi/L197w==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 02/14] docs: netdev: minor reword
Date:   Mon, 28 Mar 2022 22:08:18 -0700
Message-Id: <20220329050830.2755213-3-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220329050830.2755213-1-kuba@kernel.org>
References: <20220329050830.2755213-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

that -> those

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdev-FAQ.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netdev-FAQ.rst b/Documentation/networking/netdev-FAQ.rst
index 25b8a7de737c..f7e5755e013e 100644
--- a/Documentation/networking/netdev-FAQ.rst
+++ b/Documentation/networking/netdev-FAQ.rst
@@ -19,7 +19,7 @@ The netdev list is managed (like many other Linux mailing lists) through
 VGER (http://vger.kernel.org/) with archives available at
 https://lore.kernel.org/netdev/
 
-Aside from subsystems like that mentioned above, all network-related
+Aside from subsystems like those mentioned above, all network-related
 Linux development (i.e. RFC, review, comments, etc.) takes place on
 netdev.
 
-- 
2.34.1

