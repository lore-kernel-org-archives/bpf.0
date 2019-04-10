Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6452C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8753120830
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uEZdv+/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDJTun (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51954 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJTum (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so3907145wmf.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3+vr9FJ4cb7vK24Lm/VGA0FkexNyzFHzTsS6dRPTCU=;
        b=uEZdv+/pFhLYh67FsjyZugndyUP5IS7K84EsLaLSHsVQyN6V1ByyYSYxcB4XubuZQH
         TW3e43XYu2TNSnvsF5KvrukruZQ0s77ZdKdBSmtWZ75k6aAOimUnhdpY058zhV8sRgIW
         PMR36A+CH3AusrWqzz+j1JLL+044WouUhhUdIFl0DCBss8Uw5OA/1pBsqi7qcZMeYJIy
         Dru2IZZ+UE+2cdw/xEA2SIc+JsTRM3UCZvQVugdoXqIAYLJMtTuJKCHWkTA4ebyb8vAb
         aLhr7iekiq7oFeMjKoBQKbmevP+38fGkCgHPXSh3n1vxS+R8sPr1EFI4EXR+3JeP6nJY
         vLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3+vr9FJ4cb7vK24Lm/VGA0FkexNyzFHzTsS6dRPTCU=;
        b=svo+agFplrTTAWP/lQgUfJFC6PR850Hv5tr33a33+J4vWY9MDE4fhAYV4XFybnZ1wN
         sf6b+PUBKOWdBacFmdsb9vPZ9bQli98Lcg1RPKUaYU76F8k4OcfEscGlrf8U57apZlD2
         DQk/JL7qYJqsDsCdTX8b0ofJFrqXnk+jrLR7H4j+Te68yVq2Kd7Jf6OakWovhg1RJhkM
         SQ9T1gnEEhJtWugltD7jvdoc5EYK36a7qU0UigYk6xKFLx32z3xgbyKelDO5jFXD3+ZN
         FwW4mB5hdYqLtmrU2DHbdE+c8IXAz0HGtqLR0+KHbmCdah3N9PjFPz7Xaqp54H6Fp4dE
         ulRQ==
X-Gm-Message-State: APjAAAVSv3axLwlfMOP+Ch0mZpudQeBOnbXOKl/M+6mW/yBCy12K12MV
        UFdP+n3BGWMmTAB22+QLilx1yA==
X-Google-Smtp-Source: APXvYqwt8T0P6+2CX/IKz8AeZ2osBO/CVSd3J2eXF3j54mlL4BEjMuFKJI/sZBc0nLiYbaTP8ezNNA==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr3855263wmq.102.1554925841171;
        Wed, 10 Apr 2019 12:50:41 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:40 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 02/19] bpf: refactor propagate_liveness to eliminate code redundance
Date:   Wed, 10 Apr 2019 20:50:16 +0100
Message-Id: <1554925833-7333-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Access to reg states were not factored out, the consequence is long code
for dereferencing them which made the indentation not good for reading.

This patch factor out these code so the core code in the loop could be
easier to follow.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6ebe80..d57082a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6201,8 +6201,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
 			      struct bpf_verifier_state *vparent)
 {
-	int i, frame, err = 0;
+	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
+	int i, frame, err = 0;
 
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
@@ -6212,28 +6213,33 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	/* Propagate read liveness of registers... */
 	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
 	for (frame = 0; frame <= vstate->curframe; frame++) {
+		parent = vparent->frame[frame];
+		state = vstate->frame[frame];
+		parent_reg = parent->regs;
+		state_reg = state->regs;
 		/* We don't need to worry about FP liveness, it's read-only */
 		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
-			if (vparent->frame[frame]->regs[i].live & REG_LIVE_READ)
+			if (parent_reg[i].live & REG_LIVE_READ)
 				continue;
-			if (vstate->frame[frame]->regs[i].live & REG_LIVE_READ) {
-				err = mark_reg_read(env, &vstate->frame[frame]->regs[i],
-						    &vparent->frame[frame]->regs[i]);
-				if (err)
-					return err;
-			}
+			if (!(state_reg[i].live & REG_LIVE_READ))
+				continue;
+			err = mark_reg_read(env, &state_reg[i], &parent_reg[i]);
+			if (err)
+				return err;
 		}
 
 		/* Propagate stack slots. */
-		state = vstate->frame[frame];
-		parent = vparent->frame[frame];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE &&
 			    i < parent->allocated_stack / BPF_REG_SIZE; i++) {
-			if (parent->stack[i].spilled_ptr.live & REG_LIVE_READ)
+			parent_reg = &parent->stack[i].spilled_ptr;
+			state_reg = &state->stack[i].spilled_ptr;
+			if (parent_reg->live & REG_LIVE_READ)
 				continue;
-			if (state->stack[i].spilled_ptr.live & REG_LIVE_READ)
-				mark_reg_read(env, &state->stack[i].spilled_ptr,
-					      &parent->stack[i].spilled_ptr);
+			if (!(state_reg->live & REG_LIVE_READ))
+				continue;
+			err = mark_reg_read(env, state_reg, parent_reg);
+			if (err)
+				return err;
 		}
 	}
 	return err;
-- 
2.7.4

