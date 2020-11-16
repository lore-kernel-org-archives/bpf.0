Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D2C8301D
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA72D20855
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 12:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arpttuBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgKPLFk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgKPLFk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 06:05:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D57BC0613CF;
        Mon, 16 Nov 2020 03:05:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so13745742pfm.13;
        Mon, 16 Nov 2020 03:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arubwLR39wvgedaDM18KCW1EiXPP/rkhc+cE3m9pRUQ=;
        b=arpttuBXgCNK8NuveOEyFxB11sLgtQKSPJGDk5dMDjFb8mteWokvYFb4DhH3GrGSZB
         xm4cNfV/pALl7OqvqmkWA0z4YWyLbzX/db9Tv/2wQ2k1dj7DiFGmwx9Awikc1W69VR81
         PAx1goXsq+MorTaMppXZgycfeAUs3SINiJalrc/3slAy1u/oTzy/2K6G1iVhBONil5BY
         it7UHGVHSj0sW2yZPY29WQT32NfaLSYmTBBR8kghDVmfFRtQimCEnovI8OIJoegEDGFl
         sEG6RLuflVKGjtu1e99x8TbLJ6D85Hp1BEDXVX/tKVizTdrt/OZl+zA0LJECmoDhKmKJ
         douA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arubwLR39wvgedaDM18KCW1EiXPP/rkhc+cE3m9pRUQ=;
        b=CYlfngTz7CPdwQBDtbnLE7+teAEGSMMseXJDJ1rBefLSj2Zl1LPMxj9mC3bs/ADSrh
         VwTOPjFLfPRj7U9zJLcnB2CF5UDOudYDfSORHupW8N3uoPJRCbumX2MZrNvnbfTTWFQ5
         jXiUe7lTmzQ/BVmxi9nR/ZVW4DnMI51vU5qjotPi3N95MFucUVLnldKiAoTqBo1WxxjM
         fS95lxQc+2Ryehj57GhMmuXn3sv6QJu22yUQI8SYteMPkdIDZuX3fmveSdiyvziMHi21
         0DdTvqGHFEqEDhcK76O/BkNjKLsv8ZrVFxU9WzLHE68BtYA8tW4MTJOkVZq2HmkFlGlL
         19Lg==
X-Gm-Message-State: AOAM533Wu9cm8KOMnZ2v/d4ItZj0uJtbzdF8C5ExBSLAVsir7+31Oj6k
        LmZpPZzE7Ly1wq/Ky16Dotnl7R1m4mjp1iL3
X-Google-Smtp-Source: ABdhPJx3rFlrtRYe9OGCmqPKAytXnBlOrTxVoLBVlon7W3fpR4vqlXQVwmGD+pFT3CgdAobodpWaYg==
X-Received: by 2002:a63:5f17:: with SMTP id t23mr12773144pgb.190.1605524739474;
        Mon, 16 Nov 2020 03:05:39 -0800 (PST)
Received: from btopel-mobl.ger.intel.com ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id a23sm15752890pgv.35.2020.11.16.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:05:38 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: [PATCH bpf-next v2 10/10] samples/bpf: add option to set the busy-poll budget
Date:   Mon, 16 Nov 2020 12:04:16 +0100
Message-Id: <20201116110416.10719-11-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201116110416.10719-1-bjorn.topel@gmail.com>
References: <20201116110416.10719-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Support for the SO_BUSY_POLL_BUDGET setsockopt, via the batching
option ('b').

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 09a9fc76f072..e4a1e82fcb22 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1479,6 +1479,11 @@ static void apply_setsockopt(struct xsk_socket_info *xsk)
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
+
+	sock_opt = opt_batch_size;
+	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL_BUDGET,
+		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
+		exit_with_error(errno);
 }
 
 int main(int argc, char **argv)
-- 
2.27.0

