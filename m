Return-Path: <SRS0=N9AH=77=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30924C433DF
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038102088E
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443561;
	bh=BMiGM4Qt2i3j6dALG2VUcDlayXcteWcKXfh32RJncQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sa/5a/o9VmJA+qHpl9zaS8KeDhN7LU/3D6G7/A4FejsJSQTb35OSYrka3ui0BHOfr
	 BivelbEKKt6FcRWCzqEwvGSTNs4LMjntW99vn2SZXXp3Os2rq02dl3QPifMse8u30A
	 ukYjpki/H0u+2DWcZYnf6QYeCcPKL6D8ouwhsIjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgFRB0A (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbgFRBZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B4821D7A;
        Thu, 18 Jun 2020 01:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443558;
        bh=BMiGM4Qt2i3j6dALG2VUcDlayXcteWcKXfh32RJncQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrfL1KYEoo67vxTcwzAMWSWkObk9IsLiPCy5fbxo1NDcjWOzCZbn0BawgTzifv2vb
         tGjnjOiwSMTre17iCQfFk/J3cjri8Cy9cT74iA6sV+ktU2xFvknbQl8v0k147thta8
         /XmTfCjI3Lo+0eqyG9/XUZIFwv/VJ6ep+ZP54oRE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 172/172] xdp: Fix xsk_generic_xmit errno
Date:   Wed, 17 Jun 2020 21:22:18 -0400
Message-Id: <20200618012218.607130-172-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit aa2cad0600ed2ca6a0ab39948d4db1666b6c962b ]

Propagate sock_alloc_send_skb error code, not set it to
EAGAIN unconditionally, when fail to allocate skb, which
might cause that user space unnecessary loops.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/1591852266-24017-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72caa4fb13f4..9ff2ab63e639 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -233,10 +233,8 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
-		if (unlikely(!skb)) {
-			err = -EAGAIN;
+		if (unlikely(!skb))
 			goto out;
-		}
 
 		skb_put(skb, len);
 		addr = desc.addr;
-- 
2.25.1

