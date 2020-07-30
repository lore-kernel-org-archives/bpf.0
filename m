Return-Path: <SRS0=uBQJ=BJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A90DC433E0
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABC220829
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsAIEA63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG3QJJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgG3QJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 12:09:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D828C061574;
        Thu, 30 Jul 2020 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/9clZacS03hg93xCzisBDaBM6xQtWM8BJxGffZuFRBY=; b=AsAIEA63G89iz7CoILUDq2XRZO
        UvqFVgRPnMZ6uJXFwrluHn/rm/kZIdUxnkia+HnMGaRr2JM/0inaiavf25F3QDLUbtPi+oQ/D3kwG
        ocdV3C0kTEnhsyTLi6taKohkgVzNc07awX/v+J6s2xt3nLz2Vd0UlXwdruhZz/Vfwe6kFtn43D1A3
        qz2klRUhhPuzOC5x4E3MqpqNnU4n5DVrgU7oFf6uDUZjwPO6qAOqY3lvLDKm1oErjE+heggKdZuJg
        0jpPd+P2CUR5T48S4fZXr1mYWcpf46bOHzXOsgPQkLXwDzS4qld/uKdPIXSgr1rgSVxLvp0dZd4H5
        s6b5mE4w==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1B78-00011t-1m; Thu, 30 Jul 2020 16:09:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rodrigo Madera <rodrigo.madera@gmail.com>
Subject: [PATCH net] net/bpfilter: initialize pos in __bpfilter_process_sockopt
Date:   Thu, 30 Jul 2020 18:09:00 +0200
Message-Id: <20200730160900.187157-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__bpfilter_process_sockopt never initialized the pos variable passed to
the pipe write.  This has been mostly harmless in the past as pipes
ignore the offset, but the switch to kernel_write no verified the
position, which can lead to a failure depending on the exact stack
initialization patter.  Initialize the variable to zero to make
rw_verify_area happy.

Fixes: 6955a76fbcd5 ("bpfilter: switch to kernel_write")
Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Reported-by: Rodrigo Madera <rodrigo.madera@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rodrigo Madera <rodrigo.madera@gmail.com>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 1905e01c3aa9a7..4494ea6056cdb8 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -39,7 +39,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 {
 	struct mbox_request req;
 	struct mbox_reply reply;
-	loff_t pos;
+	loff_t pos = 0;
 	ssize_t n;
 	int ret = -EFAULT;
 
-- 
2.27.0

