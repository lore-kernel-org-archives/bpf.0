Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5DC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4CC2075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWO/yinB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfC0Nwc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34740 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0Nwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 09:52:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so8378315pfd.1;
        Wed, 27 Mar 2019 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZpv6NK64CD6OdA1XcmtXF3jGqebAHR/to3SIbQQ1GA=;
        b=AWO/yinBMa4bXz4VurJCwqeqtHSAeHPm4tOqeBxS9EbfvtseUnpIhUqNSGIb+iptdo
         tvVIDtL2wzTvOpnMfh9NGNP3w6elSeuklXSJKIZPoFBBV4SW5o21iintxXzQMS73yyFj
         ZXm5xjSfIItdux4YVhe1aKPRUiAlEMNIhAzlVOIMcDZi+wsb6FRXW3nvS7l1Sk7KDXWI
         snorSFmLDVPT13qakS9GIQW3AJNm62E0sDoq4NPl59PgYUXbe5FOeqRzBx+cHtS9KyhR
         oMo2CtQ7iVcNc3rNzwK4BlzCCUDj3GeovgKUDreKRtD7FqQohzcybI98r3UU4g/qeIug
         5g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZpv6NK64CD6OdA1XcmtXF3jGqebAHR/to3SIbQQ1GA=;
        b=Yh2Ez4HyAFbtI/tJFC1OxE6RnGqGhiYtSnzdPxsnenMFU351AmjzK8xPHV/KrY6Rzm
         0IP2/gQlJpl8bUQGEk3haDgTnkeICOjDWj+RBm81V/wji/Rh1milJnEvrsbMtdL501L5
         T8h5bXeZeaR5KeUhGoXKE3ZWwMur4MhIgTNhIO07EEq/z0qPP5D+BTiIXcFuGKQ3vLfl
         k0Zb3gXyz1uvu7s6deImzkHwiGFQEo7HLD6rxZbFFoIRpFJPd5mty4wcfwvDwpvQPiQf
         n6fRhEJkb7QJ+xOOIZphYnRfUexPs4UuPmYeaNWNtzagPqF3ltqhPJhBoH1mhNu31LoO
         QVsA==
X-Gm-Message-State: APjAAAVIbFD/zZBk0HAa+iC2vrCmFeH+4GzwxebTR+vITjp9i1ItEoGB
        KQZ3R7Q+4TkL6l1kzflaGhg=
X-Google-Smtp-Source: APXvYqyFuQs16MTdXPVVjzAFij2YhI44jtOSeEnXOPIiTbjzEXB9SxFj8PQ4Xez7+Ori81xlL5qMTA==
X-Received: by 2002:a62:1193:: with SMTP id 19mr35018782pfr.82.1553694751783;
        Wed, 27 Mar 2019 06:52:31 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id d15sm6823571pfo.34.2019.03.27.06.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:52:31 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, bpf@vger.kernel.org,
        xiaolong.ye@intel.com, qi.z.zhang@intel.com
Subject: [PATCH bpf 1/2] libbpf: add xsk.h to install_headers target
Date:   Wed, 27 Mar 2019 14:51:13 +0100
Message-Id: <20190327135114.17026-2-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327135114.17026-1-bjorn.topel@gmail.com>
References: <20190327135114.17026-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

The xsk.h header file was missing from the insteall_headers target in
the Makefile. This patch simply adds xsk.h to the set of installed
headers.

Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
Reported-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 tools/lib/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 5bf8e52c41fc..279589c29983 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -222,6 +222,7 @@ install_headers:
 		$(call do_install,bpf.h,$(prefix)/include/bpf,644); \
 		$(call do_install,libbpf.h,$(prefix)/include/bpf,644);
 		$(call do_install,btf.h,$(prefix)/include/bpf,644);
+		$(call do_install,xsk.h,$(prefix)/include/bpf,644);
 
 install: install_lib
 
-- 
2.19.1

