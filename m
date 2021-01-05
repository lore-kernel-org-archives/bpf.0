Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93DC433E6
	for <bpf@archiver.kernel.org>; Tue,  5 Jan 2021 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D450022AAD
	for <bpf@archiver.kernel.org>; Tue,  5 Jan 2021 12:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbhAEMZw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbhAEMZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 07:25:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3EC0617A3
        for <bpf@vger.kernel.org>; Tue,  5 Jan 2021 04:24:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t16so35995789wra.3
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 04:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u0kBDkZSof0LwbMWuYCOPhj4hHVMvwb36KmGU51ii7Y=;
        b=ND819YouqBX2OWqXMdqdQeyowrfISKhBPc2XrLPMSsEl7svulPDlyyq3EkBtNbL33u
         TDaKNAZRhQCDcM6g7W1VV86CZMsGPo/Xj6o9ovlgTu1Dkia9VLQEAhbNY9nR9vAFrfOF
         fgoEuPBj4FgxID677UG7GgUc9XU/RXpFh/gbm7eTWT5Nri3rbP72bDPpaO6Sm9HCNgI3
         3NSpgM2+U6guAItcMAeEWlToNz5eKPh3fU1yovidq2zYfknj0ya64YVX6h9x0A8df3W+
         2aGD7YS/4qoFccPopziAfM1EXWE23Jv2Hdf4xMOmznant61CMaghciMWLZOQMjrSc6PP
         LOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u0kBDkZSof0LwbMWuYCOPhj4hHVMvwb36KmGU51ii7Y=;
        b=DgjqSk04Ig9221TbEml6rp0OjTXnyn1czr19mlBONNxhLQ4FEQL49VdywxywIhJ0GT
         vMy/rDO/4OiX00w+zp+j93sd1UcMNWnu2K05U0/C4ffZ9H9Aa6o9gQwZpxFywVV39SFE
         BpsITLKSt+k5vhsIX2+ikoRjxzQdj7vHgOrKyxTk/mF1jTDtIEzhwbN9IYUnaygFQvYs
         TP/kksr2zI7vvXAKggaAa5i5Qg3CPTVrIBrbC7IYmKWfQ1mSd9YbVGOn9CeevEQxbKmH
         mPyALEMc+EDqeMgRYD2h14hdrzvC81vvA/MKTABaxH83SXx7e+SZyfOIvQ00k9BmVSLz
         WA4g==
X-Gm-Message-State: AOAM531ixV7EKfK3BLPMTi3Y1u11xQrMWbsVW10mh3odWgmBpnijhNqb
        MDtlrUZdBzvw+fSY6gCOt4yizg==
X-Google-Smtp-Source: ABdhPJyJfqvsRJHDTSpaa9QAkR2GGFTavM6RbFaNNqtKETNWn4GmNRmrqwUcSVEVi1csBmRIq/qoBg==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr84858735wrw.419.1609849474478;
        Tue, 05 Jan 2021 04:24:34 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id 138sm4242281wma.41.2021.01.05.04.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 04:24:33 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     yan@daynix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC PATCH 4/7] tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
Date:   Tue,  5 Jan 2021 14:24:13 +0200
Message-Id: <20210105122416.16492-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122416.16492-1-yuri.benditovich@daynix.com>
References: <20210105122416.16492-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The module never creates the bpf program with bpf_prog_create
so it shouldn't free it with bpf_prog_destroy.
The program is obtained by bpf_prog_get and should be freed
by bpf_prog_put. For BPF_PROG_TYPE_SOCKET_FILTER both
methods do the same but for other program types they don't.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 455f7afc1f36..18c1baf1a6c1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2218,7 +2218,7 @@ static void tun_prog_free(struct rcu_head *rcu)
 {
 	struct tun_prog *prog = container_of(rcu, struct tun_prog, rcu);
 
-	bpf_prog_destroy(prog->prog);
+	bpf_prog_put(prog->prog);
 	kfree(prog);
 }
 
-- 
2.17.1

