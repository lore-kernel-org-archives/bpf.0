Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88EC282E0
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9D218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zT+VFuZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLWAr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54208 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfDLWAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so12943633wmj.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sr2szAt1RChwWhkcjqTjVQ0F5Kfgn2Tb01LXULXSNXs=;
        b=zT+VFuZGzpFRdXp4loPUCo3/vN/OwoFG9d75xztI5MZWPCDBkThB4G4/JE6ossS0E+
         OHEUO469mpWd8Zb4XDLk/FjxrhFPU6ZW3m1PN+/cr1jSVjpZ9cb5HiR/7aKcZBb9WiUO
         WN5vnrkg/zUsuG2ScyVWLWuKBw1+QlCBjvdlh0WSCgzaFPp07y8bcBPgQabguEhNsmft
         RxZM1U4CafU/Oq5EBzNTXwPDYmXWAXUNV0ohf+aXVWe9Kt6XMbuV2iyS52y1dxplUQR2
         WXKmiC66lEx0p17v85lL6cLN5sym3MP/x3+ScrVM5mqZJNtrA1c2KHKZfyGUhw8cIpKy
         p2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sr2szAt1RChwWhkcjqTjVQ0F5Kfgn2Tb01LXULXSNXs=;
        b=Cl9FszLridzPRiV3ejDHoX+N0kuN1oMAWYLAmNV7WD4AcEJWF9SjxAo+O2JL/CDBT4
         CnGMJFgeD6mUJ74zss/DKA8Xb1XMC729VZnDsNVhvYGWObYl2AOOSthfAZOnPUwwglL4
         lplZj3y+gJMoP0c5Kr6IuAiN8IG0L5brt5qYG2XPSsgdywDHmH6zR7nwW+vNCMfprcW7
         HjUH61coUxkW3jtnJDAFM6rAmjPTYuwhMqrk9qhCkojz3YO1i2SUpxkAlnhovaV6tVci
         3PAX8srjieMDkg2GuFrJtvxk0IQshlz8uUX6cojp5odDnxJI7CLwCCRr5331o9QkHw/8
         gUQg==
X-Gm-Message-State: APjAAAUiq6ejcXCH2lkCYpV/co0fygppArTZpElU4mj15macuhy7Nmdd
        NPbXfBSos9u+xqrsLlIZGJoNhA==
X-Google-Smtp-Source: APXvYqzw4CptVkem1bJAxeLBTrwhPVTlIWotzC6fWP4j4DiArrqQW7ljm7ogY5ta4AHmpK5/MdsS4g==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr13330385wmi.7.1555106402801;
        Fri, 12 Apr 2019 15:00:02 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:02 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 02/19] bpf: refactor propagate_liveness to eliminate code redundance
Date:   Fri, 12 Apr 2019 22:59:35 +0100
Message-Id: <1555106392-20117-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Access to reg states were not factored out, the consequence is long code
for dereferencing them which made the indentation not good for reading.

This patch factor out these code so the core code in the loop could be
easier to follow.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da285df..6fd36a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6232,8 +6232,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
 			      struct bpf_verifier_state *vparent)
 {
-	int i, frame, err = 0;
+	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
+	int i, frame, err = 0;
 
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
@@ -6243,28 +6244,33 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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

