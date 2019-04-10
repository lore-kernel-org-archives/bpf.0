Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450B3C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CC720820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Dlf+3zdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDJTum (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36881 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfDJTul (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so3903757wmf.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6OlTHii6j9e7eTQ+bnhdP8ya9aIrO2QI22g5wX9eOY=;
        b=Dlf+3zdGa/xsUucE8VU8V1MkDiasfXBFiRiblGXyUJRhZMqTJEiibbyJKboAoXPfT1
         wz6mQMyKynUmfa/PWRD2lSvQtfhGL2gyaGO/SWI0rLUtkSA6A/fsnBhrP4Ra7GvLvBEn
         4gy8XTynX9dYzprO9EVK4qD98mEodm6TjBZjIBNwgWZRLQsFrx82Db5EIDBIIc1+gHCu
         HYj6zOLX9M1YLC5rf2Jmk7Y2wrkjFsq58p9eRvngrR+JXqWze8yDWNK0PuhNRK3jdSgM
         BG/olKCKDSZo6P49mzCclAajEuom0Ze2m4ir/NRYKhYLXxpeTsV3RiJaop9yXXBwj5xh
         7g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O6OlTHii6j9e7eTQ+bnhdP8ya9aIrO2QI22g5wX9eOY=;
        b=EvFA2bKmZ5wjR4SIu2JfkXORZUX84Knz1Vg9utArErzxVZplbbtxHLdh9R0+pPCx1F
         atPKr2Cb1IGy4n92FA/N+3N3n1NEByU7Eh6GHpNQtZFvtU4kUTm+nnAvrcIq05wGPuCE
         YLgCxqYuAPdhBrpWoavcgfT6iblpjd3MDoQvFRZGTBkOabXSX9yZDpRkoZ0aw0IBBDHO
         dyW8yH2kUVO9IijIF7TXC4bCStsd3kKOfDMethy6URd1aZpQfJyq5D/TCLv+wDdcCTNa
         EgLDEnP87ZABrKVUaXizEAFPiiQDjd8QrCgX2LTZq4Nyk+lUTclzW+CrIHIaiICY4N9V
         gLCQ==
X-Gm-Message-State: APjAAAWjU53W8aO6GXvLMuFRA9KwEmdYle9a4/BSNWNPN+6TVTxW08gX
        uICMKdKSZcznMHitFvKt0SDm6g==
X-Google-Smtp-Source: APXvYqxhnZ28KPgl7KHA79WsXkfG54+6TnnyBtfvb5Kp2pcJxMPV4i5mVNiay2/W8iC+5jh+VdF4sQ==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr4153012wmg.28.1554925840152;
        Wed, 10 Apr 2019 12:50:40 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:39 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 01/19] bpf: refactor propagate_liveness to eliminate duplicated for loop
Date:   Wed, 10 Apr 2019 20:50:15 +0100
Message-Id: <1554925833-7333-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Propagation for register and stack slot are finished in separate for loop,
while they are perfect to be put into a single loop.

This could also let them share some common variables in later patches.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b747434..f6ebe80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6223,10 +6223,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 					return err;
 			}
 		}
-	}
 
-	/* ... and stack slots */
-	for (frame = 0; frame <= vstate->curframe; frame++) {
+		/* Propagate stack slots. */
 		state = vstate->frame[frame];
 		parent = vparent->frame[frame];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE &&
-- 
2.7.4

