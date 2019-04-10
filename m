Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9BC282CE
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3420820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="eQt0WsT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDJTuo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDJTun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so3899433wmj.3
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=przrOLCJP/2yXV45rk8KRThSpUEF8IQ+x2IHuQUdOZM=;
        b=eQt0WsT716NYlw+LCPgntW/NYu6FMWKZ0hsSNqfUL/b6FOMFvYf1NH+tJsyn44UsP3
         FYfF6FlQNs2QE4pWh+egQV0q1A2KdXZI/oYlb37e7MD2+d5yCd7TJkfnfrh1FFkpVCtk
         vohlQKpIZNRB9EZqKaMTX0aW6AFVRscHso4wIbrgOlPUCVHjPzGS9AZO5TYCkIVs04Ws
         D45I5wy8S1Ay9gKWk526PrVVH/Zz55DE02cqriVstBu5vnaQTEhn/qHJsGXf/+f1oSNh
         wiW9umuGK0tsqX2U4JB/ANIL/x17HILgpoO9gHo4ObyapU0bXCTSJzlY7vavWeIP6itV
         67vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=przrOLCJP/2yXV45rk8KRThSpUEF8IQ+x2IHuQUdOZM=;
        b=AAG3zDA8V+WnCcbqoLBcvDJbOSaBsGu79QWoEmUQClM+h7voTyNpkMbojixwUrnfuu
         cvISxqlyQAQUMQIWBnNtCGavnCtqUU1GmFQaqcb419fhMBHwvvn02ee7+acWIGqecsmH
         KJDo42s7HiouAz3byioNVJvkF+pM83dnflRpoYAUq+kw2oOl6cVe0N7zXDH8gxkcN+f9
         +yu39ZgUWdqTkkbex6prEODiEpt9l5U37g7TVYFlP/SEvN9z5vOfJB2rOmEf5iKh0coj
         wV8U3LmwElEqP86V1msYXxBGvew8PtHpL3nnbVH1ZfV0UNxlDhEcKHrqMZIigQesscCc
         8DHQ==
X-Gm-Message-State: APjAAAX6lze8QuIKffcNYC2bxOY6VW1+oE/w1MxtFZ9+bDpmejPBmB3y
        OHhHSAZ3lfQRtGF7ePOgjKXwtg==
X-Google-Smtp-Source: APXvYqzGkEflsgCvQxNKiYOINcjHWO0llCWJDmqpVOKKQsgFM+X42Pb0yJl2WA5RufJyDZN1H8XA4g==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr4140616wme.29.1554925842355;
        Wed, 10 Apr 2019 12:50:42 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:41 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 03/19] bpf: factor out reg and stack slot propagation into "propagate_liveness_reg"
Date:   Wed, 10 Apr 2019 20:50:17 +0100
Message-Id: <1554925833-7333-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After code refactor in previous patches, the propagation logic inside the
for loop in "propagate_liveness" becomes clear that they are good enough to
be factored out into a common function "propagate_liveness_reg".

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d57082a..8d60dc7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6190,6 +6190,22 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
+static int propagate_liveness_reg(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  struct bpf_reg_state *parent_reg)
+{
+	int err;
+
+	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
+		return 0;
+
+	err = mark_reg_read(env, reg, parent_reg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /* A write screens off any subsequent reads; but write marks come from the
  * straight-line code between a state and its parent.  When we arrive at an
  * equivalent state (jump target or such) we didn't arrive by the straight-line
@@ -6219,11 +6235,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 		state_reg = state->regs;
 		/* We don't need to worry about FP liveness, it's read-only */
 		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
-			if (parent_reg[i].live & REG_LIVE_READ)
-				continue;
-			if (!(state_reg[i].live & REG_LIVE_READ))
-				continue;
-			err = mark_reg_read(env, &state_reg[i], &parent_reg[i]);
+			err = propagate_liveness_reg(env, &state_reg[i],
+						     &parent_reg[i]);
 			if (err)
 				return err;
 		}
@@ -6233,11 +6246,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			    i < parent->allocated_stack / BPF_REG_SIZE; i++) {
 			parent_reg = &parent->stack[i].spilled_ptr;
 			state_reg = &state->stack[i].spilled_ptr;
-			if (parent_reg->live & REG_LIVE_READ)
-				continue;
-			if (!(state_reg->live & REG_LIVE_READ))
-				continue;
-			err = mark_reg_read(env, state_reg, parent_reg);
+			err = propagate_liveness_reg(env, state_reg,
+						     parent_reg);
 			if (err)
 				return err;
 		}
-- 
2.7.4

