Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86654C10F09
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D7A20811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5ohq7qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfCHH6e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:58:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32867 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfCHH6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 02:58:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so13569258pfd.0;
        Thu, 07 Mar 2019 23:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bW77X34qQpg49UtQ46ih/xs5pSASr6Vb7eHr+nD8kM=;
        b=f5ohq7qvX7nvpTleqAOFAit0j7vJwnyWIHxVyp602fW6JLP//I3eHHpJF0hgyMdDDR
         ZDcUjoTAToarD7A3n3vqNpBgUZ+HVMEaBpnoU/MMIyUKZkrxoT/PIN5TpjYzR6nsyyTQ
         MJUgQwUpdVLsIxAv5H9LqdYaMHhfwafyN/bRlQIWOb6FsY64Zc/j64eMLsrWoRWLcUUq
         FAHhd5C8fcNTagBrKzAIHjiH8xK7A739RNomGxgAIB/X1iZeJTnT7KToSO15AR950384
         5M2aBAdk8E5ta0WLJo54dwP0bUKKeqjhMhJMy1QZdXec07fc+fVtY8Xkn51CC25PmEmJ
         Fl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bW77X34qQpg49UtQ46ih/xs5pSASr6Vb7eHr+nD8kM=;
        b=rKb0oLs1xY/RjffEtHDWYtwIaawIUeODAHbOn1cpWmgGr72eGse83G6mMlI+YsYLD4
         YPo3dGimIQT9rtK5gkyIhvmBibcmfa/A91INjk5LnTPCIR2HOpAKzxGTovSQCF+uf/Uw
         dbzHDOUHiHHW39EA97s4Xdu82jHrATaV2UvpQwYDO4vrPq1LdNS7ZrifkO+/oyjNYLTY
         rxkFrCOzwIR2yzJpJ0Epk3NK/PDllbgJRkYhShly8vng/aHACix2ELpzBFbcJ45+YrLl
         LiRJdDcFz+vnfuagBxuKm1oyoK+wTC7YO0XCVLCPa/1TAnY2Z5AHGAtxlps56NL2o/f/
         ecHA==
X-Gm-Message-State: APjAAAW+OnD/R7aDllQufyUdrFzohBl8f13I6y3/VmttDePIrq/aIiJx
        KeFlzuP6zaZvmMKknW1gOSY=
X-Google-Smtp-Source: APXvYqxzciy35bfK8+22kzFBKdINWicAWSk9F2dbd2UTJYgXJT5nTCW93JiyEe3TIZiPKlyDDKJTpg==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr17717055plo.30.1552031912941;
        Thu, 07 Mar 2019 23:58:32 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id y14sm17066471pgs.47.2019.03.07.23.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 23:58:32 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] xsk: fix to reject invalid options in Tx descriptor
Date:   Fri,  8 Mar 2019 08:57:27 +0100
Message-Id: <20190308075727.19358-3-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190308075727.19358-1-bjorn.topel@gmail.com>
References: <20190308075727.19358-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Passing a non-existing option in the options member of struct
xdp_desc, incorrectly, silently ignored. This patch addresses that
behavior, and drops any Tx descriptor with non-existing options.

We have examined existing user space code, and to our best knowledge,
no one is relying on the current incorrect behavior. AF_XDP is still
in its infancy, so from our perspective, the risk of breakage is very
low, and addressing this problem now is important.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 net/xdp/xsk_queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index bcb5cbb40419..610c0bdc0c2b 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -174,8 +174,8 @@ static inline bool xskq_is_valid_desc(struct xsk_queue *q, struct xdp_desc *d)
 	if (!xskq_is_valid_addr(q, d->addr))
 		return false;
 
-	if (((d->addr + d->len) & q->chunk_mask) !=
-	    (d->addr & q->chunk_mask)) {
+	if (((d->addr + d->len) & q->chunk_mask) != (d->addr & q->chunk_mask) ||
+	    d->options) {
 		q->invalid_descs++;
 		return false;
 	}
-- 
2.19.1

