Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBFC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C772082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VlLzt1gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfCZSGl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37164 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbfCZSGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so13991795wmf.2
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LIVt0dF8T96GyCFFdLmKckPQiAfo4lzXRZU1y+SNemA=;
        b=VlLzt1gwAX0AzFo5X/Aj75AjSCbf1ZJ8BVJRg9x1T3FnCJ13S2FPK0BZW7ONXFCrgO
         6uxaw2Aa2KUO1rkPunjcBQZZJoT98l2RCdqUEudOT8aBHh8Gc8Z+DXAQnSyOmh7GnPh5
         JZy9d92ZN4uFm46qy1y85V1bMdTlEvszNGT5LTAxWdIFvRbCoLqBVVMtO0NF8LsMaXbK
         gJYmH+9/KF03zfMv5eU9QrRpofu/1X5Q8T9/oKu7mJBAhOB8a+LbwfORDx8E/JMnTHrg
         ngtGlJ1K6oxJ8JTgpxoPzrEkOVyMeAZmWrJz5QphvN3UJIQapLhARnc2aNeXrT+g3qzG
         aNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LIVt0dF8T96GyCFFdLmKckPQiAfo4lzXRZU1y+SNemA=;
        b=KVdavAXVNUgX/SVytbQr8Lz8ksj4OiKBii4wLdXSRyq2Yx/o6ixPOPRUG4egGQZirE
         G8NCCbuOgWKbdAjXClSf335sHigBQ+1azHPZ9GZXopZPvj1LqL4Y5O5UQVNIhaKLuo2X
         /sBkZzjtWqtBsP1C12U3za3CiNL0qUE4x7AvNfd77ddOG02JhBX8YF1Cpsl52Of/Esvk
         vcrjnraPM7I6dImvPBpZKULL8GIN2Zg5mgoQMdc/UK1U8RAv2O3uF4H0Fj6NkDNvstxI
         9DG4bH2sTDUNHWiZszE6Tk5IJFawmicleykl/qMVDL0MVt/V4j6/vSa/Aw22VFfzKDiQ
         pyOQ==
X-Gm-Message-State: APjAAAWEmcyyS+ewYuVHmd6RR/EuJaaYEHZCC+2hKrQ7bFwKO/WTTEFU
        ZOZUb+fSvrtZ1YwIcxpXhvDWrg==
X-Google-Smtp-Source: APXvYqwFTHtA2OtmuDEstdgpORaj0gGh74NGh3RCSQbg57GifQsbHcGu8lfqTDzgNAg6A5glXldkCA==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr9816994wme.24.1553623596490;
        Tue, 26 Mar 2019 11:06:36 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:35 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 02/16] bpf: refactor propagate_live implementation
Date:   Tue, 26 Mar 2019 18:05:25 +0000
Message-Id: <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some code inside current implementation of "propagate_liveness" is a little
bit verbose.

This patch refactor them so the code looks more simple and more clear.

The redundant usage of "vparent->frame[vstate->curframe]" is removed as we
are here. It is safe to do this because "state_equal" has guaranteed that
vstate->curframe must be equal with vparent->curframe.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6cc8c38..245bb3c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6050,6 +6050,22 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
+static int propagate_liveness_reg(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  struct bpf_reg_state *parent_reg, u8 flag)
+{
+	int err;
+
+	if (parent_reg->live & flag || !(reg->live & flag))
+		return 0;
+
+	err = mark_reg_read(env, reg, parent_reg);
+	if (err)
+		return err;
+
+	return 1;
+}
+
 /* A write screens off any subsequent reads; but write marks come from the
  * straight-line code between a state and its parent.  When we arrive at an
  * equivalent state (jump target or such) we didn't arrive by the straight-line
@@ -6061,8 +6077,9 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
 			      struct bpf_verifier_state *vparent)
 {
-	int i, frame, err = 0;
+	struct bpf_reg_state *regs, *parent_regs;
 	struct bpf_func_state *state, *parent;
+	int i, frame, err = 0;
 
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
@@ -6071,16 +6088,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	}
 	/* Propagate read liveness of registers... */
 	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
+	parent_regs = vparent->frame[vparent->curframe]->regs;
+	regs = vstate->frame[vstate->curframe]->regs;
 	/* We don't need to worry about FP liveness because it's read-only */
 	for (i = 0; i < BPF_REG_FP; i++) {
-		if (vparent->frame[vparent->curframe]->regs[i].live & REG_LIVE_READ)
-			continue;
-		if (vstate->frame[vstate->curframe]->regs[i].live & REG_LIVE_READ) {
-			err = mark_reg_read(env, &vstate->frame[vstate->curframe]->regs[i],
-					    &vparent->frame[vstate->curframe]->regs[i]);
-			if (err)
-				return err;
-		}
+		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);
+		if (err < 0)
+			return err;
 	}
 
 	/* ... and stack slots */
@@ -6089,11 +6103,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 		parent = vparent->frame[frame];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE &&
 			    i < parent->allocated_stack / BPF_REG_SIZE; i++) {
-			if (parent->stack[i].spilled_ptr.live & REG_LIVE_READ)
-				continue;
-			if (state->stack[i].spilled_ptr.live & REG_LIVE_READ)
-				mark_reg_read(env, &state->stack[i].spilled_ptr,
-					      &parent->stack[i].spilled_ptr);
+			struct bpf_reg_state *parent_reg, *reg;
+
+			parent_reg = &parent->stack[i].spilled_ptr;
+			reg = &state->stack[i].spilled_ptr;
+			err = propagate_liveness_reg(env, reg, parent_reg);
+			if (err < 0)
+				return err;
 		}
 	}
 	return err;
-- 
2.7.4

