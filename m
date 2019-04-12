Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B1C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FCC2084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="cMMj6xev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfDLWAD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45036 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfDLWAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so13695496wrn.11
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbnW/wYBeGzIP4i/h68N60AU3yOwxgPsQoXdv9s68Zc=;
        b=cMMj6xevEeuxBZj/8A5Dscp228TrbWGQUjJXVsozApd7l1N1LNCeEDDCg8c8KWHKk1
         7THK7ULupH+gO7RDW/wpdenP5KdKs6Q0dnXQwX9FGcrQRELq9C86Ic2XdVMGs2aWK4MQ
         h9tOSCg33mEhrKUxS6nL1h8cd+mzqyR03Qwle6xmZYCtlRYzg4c7kLm0Rx8wl+OwxCKu
         xF13lI+dmKE7yZ2A/8egMlqHhk8cV0pKnbHGpx2W3mMG9NdlhUXIb+XRamp9dwWXfBkq
         CF168QCegv14jnWEfti7y0WRGsNig+Pys8m2pvHNSUmzbBpEm3cnCnjrehqZbHjrcjJv
         /nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbnW/wYBeGzIP4i/h68N60AU3yOwxgPsQoXdv9s68Zc=;
        b=BqY0fE0CEq7B6dW1WS8IJ3ajnJNVHyIJ7LcRB4woeDcz6k2S03xXwSDFroKU3sF9VM
         84oj31ZVj5CvN884wjy7Wznflw4Jfs5sFDpUruK6If6dvEG78rJbrtMc+MltZSzoMVj7
         DUyuun+ugF0EM0mWAOinyVHJl622RL6Dw20Hqzf/Hsp7bgoHC2uNOMP6vZ6mH7WJ16Al
         ER6/8I5eoJFbxZ93z/e1iQkyiVEaRfNIwavM6Akay7G6DjQGXyIIcCKNhP9eAO43VHTh
         49TBQP8Lz3hAIjnTGaErvKVg2xkh8UInWLcVdbmDtCvtHtRkAEkhxVsuWBgmktNgbJBI
         yrRg==
X-Gm-Message-State: APjAAAUF2c2np+HSJPzwAHETm8z51ItQJt3oi7LNVmogpPqi9xWsp0zX
        jXdW0SxQw2FAqLficS31E1f70A==
X-Google-Smtp-Source: APXvYqxYLoQJKhWphQMtw444nwtwRECXpzxKObCwb0cYtptGlIPAxsdUVgJlKgGh6TrjEtKRznxaBA==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr10284618wrn.43.1555106401617;
        Fri, 12 Apr 2019 15:00:01 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:01 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 01/19] bpf: refactor propagate_liveness to eliminate duplicated for loop
Date:   Fri, 12 Apr 2019 22:59:34 +0100
Message-Id: <1555106392-20117-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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
index 15ab6fa..da285df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6254,10 +6254,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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

