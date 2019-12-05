Return-Path: <SRS0=13Dn=Z3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9613AC43603
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 05:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6271F224F8
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 05:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575525339;
	bh=u/wkIyVMGuxEZcNLrMPfqnPCBRY0g04/VqoEJCpjKiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2LFtuMMeUM8vHE91NmACr9SJhrL0v2ps6FcshTc+9h7Nzo5r3GkvlISB9MjH8On1
	 m0gFpU82z1SiXaVGilCvs50CzuZF/PiKsFs/mh2So765wmQ064bCcBS3EwMpAV6bPl
	 6RaSFL2ps5V2aTheSUZTyfYkHqYNGHK5s4AjTocQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLEFzd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfLEFzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Dec 2019 00:55:33 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F29B21823;
        Thu,  5 Dec 2019 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575525332;
        bh=u/wkIyVMGuxEZcNLrMPfqnPCBRY0g04/VqoEJCpjKiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXwgvWGNb85iP5Jbx59mcrUhL23jn7zSnVyvOV7eOLq14ZxZanfivyHZuHpMqc6dO
         cBsyXo4DGGfm8knyNKGMGWUxM5z3zp9iqxBKGaP9ABgsDY3Zhubf6oaOwOM5bMCeB0
         ZurN1lMwu4DaOu24IcTOn2baW30lMSlCJfab2O3A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Mackerras <paulus@samba.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzbot+eb853b51b10f1befa0b7@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] ppp: fix out-of-bounds access in bpf_prog_create()
Date:   Wed,  4 Dec 2019 21:54:19 -0800
Message-Id: <20191205055419.13435-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205052220.GC1158@sol.localdomain>
References: <20191205052220.GC1158@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sock_fprog_kern::len is in units of struct sock_filter, not bytes.

Fixes: 3e859adf3643 ("compat_ioctl: unify copy-in of ppp filters")
Reported-by: syzbot+eb853b51b10f1befa0b7@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/net/ppp/ppp_generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 0cb1c2d0a8bc..3bf8a8b42983 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -564,8 +564,9 @@ static struct bpf_prog *get_filter(struct sock_fprog *uprog)
 		return NULL;
 
 	/* uprog->len is unsigned short, so no overflow here */
-	fprog.len = uprog->len * sizeof(struct sock_filter);
-	fprog.filter = memdup_user(uprog->filter, fprog.len);
+	fprog.len = uprog->len;
+	fprog.filter = memdup_user(uprog->filter,
+				   uprog->len * sizeof(struct sock_filter));
 	if (IS_ERR(fprog.filter))
 		return ERR_CAST(fprog.filter);
 
-- 
2.24.0

