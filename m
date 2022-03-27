Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAAAC4332F
	for <bpf@archiver.kernel.org>; Sun, 27 Mar 2022 02:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiC0C4B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 26 Mar 2022 22:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiC0Czy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 22:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D71C922;
        Sat, 26 Mar 2022 19:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6EE60EF4;
        Sun, 27 Mar 2022 02:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A37C34110;
        Sun, 27 Mar 2022 02:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648349653;
        bh=3ltiR1dn1rxum9k5G8VTtbUj8t6iJdz1HSx6k2cpfrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuKsI45FbPjZTr8OOcQltsut4iBBrV3YS3Yx65R8r1bNp0WWp6msqPqnpkyN+eMKj
         fmvOW6LEenT6qNISMDnmjP9M/2kwueJF7eodw9CSX1H+caoawnl5P9/rT7cltrYmmg
         4zfQJduR741XFeq7LlR+wcJrg9nkM1upOoOV4FlcgMnqUwj943tvsTEd7Ce8gKzY68
         hbtNRt8G0/2kIe1BHlwsdhoDVNDk/+T3hv5VgFawh2vDBbzk6aXjyHCzqRwyWbvQt2
         B+qvyqW53ZhAHP0i3LyFkE7ItCPlimF8h8J0rROYx439iL1UDbNQTLp0PfiPyERhz7
         ulSeo+t9On/Vw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 11/13] docs: netdev: call out the merge window in tag checking
Date:   Sat, 26 Mar 2022 19:53:58 -0700
Message-Id: <20220327025400.2481365-12-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327025400.2481365-1-kuba@kernel.org>
References: <20220327025400.2481365-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the most important case to the question about "where are we
in the cycle" - the case of net-next being closed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdev-FAQ.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/netdev-FAQ.rst b/Documentation/networking/netdev-FAQ.rst
index 17c0f8a73a4b..a7367a757a4b 100644
--- a/Documentation/networking/netdev-FAQ.rst
+++ b/Documentation/networking/netdev-FAQ.rst
@@ -103,7 +103,9 @@ So where are we now in this cycle?
 
 and note the top of the "tags" section.  If it is rc1, it is early in
 the dev cycle.  If it was tagged rc7 a week ago, then a release is
-probably imminent.
+probably imminent. If the most recent tag is a final release tag
+(without an ``-rcN`` suffix) - we are most likely in a merge window
+and ``net-next`` is closed.
 
 How can I tell the status of a patch I've sent?
 -----------------------------------------------
-- 
2.34.1

