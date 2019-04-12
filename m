Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32562C282DA
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D2B218CD
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="b8rbV+5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDLWAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34069 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfDLWAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so13758098wrq.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1cowfeKkPG5Vz6uYfZSI/ZUZumixhNFe5aVN4gWJYo=;
        b=b8rbV+5wrPSH+WunviEuLpMttCAO3JJ42jbNLk2BiFwuV0dAE9a8qB5FOPw+pDU6xb
         ETtQ5tXhOCfgevYS1HwyhY/dDrx47hqAN9E/P/HXp3fsA7tPHmAMDokAj7RlimewoZt+
         Y561e7b7QkaMKZO8Hcy9y3IDNDFFpi/tV5uPSNGeI7JeYMCV5R/FCbWidyIw0oeRdgdG
         hkOevROZnNflpiYR7uAqrbgX8kOl6Xz4VgxKVZvs1pZJrQgjIBuetGIee0ooPHBGklsh
         IPOyyQDgopnM7m2zLil4y1ZYYTbQ7O8qg1GKjDjYq+WSvM39JZ+vnG6X3wMrBiAEVWdo
         qwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1cowfeKkPG5Vz6uYfZSI/ZUZumixhNFe5aVN4gWJYo=;
        b=iuhKw5EiOEfbuCwGvt65wN9ZvIzKI4Jjjj9TD7rymFdlNFRAay8Xm02yYSW44NuTv0
         /JQOi4gpZYUvv3atqeT94v3RY+dh5PGntUqXhQecZetWarzAhb1obW237seEtL4ykCXY
         /+w8AiS6+tfCwSIDiXdKX5JsCn/JO7qzcUKR005eSt+Vki2seiNyRwt4VxH4oIJu+I/N
         vl3GPc7JDwDsd+9PvC1wTMq0tS+ytMmTcH9PhRJOla6iBWlCMsksHR2mAI0U09z5sHEm
         awYJY/BC1badqo2g3CC1UhIcfidRmjms437C6Oouta1ptH5PTljAxGiMgc8zvkOdMn9t
         ehgw==
X-Gm-Message-State: APjAAAXXJCDfjt+UY5EmhC0F3bnKCX0VBPZgGRLgTOGWfz1UmFbaH1pz
        60Xkn39lsiby4u+sC/dzbSUUBA==
X-Google-Smtp-Source: APXvYqyP010ROPGTgcE7El+BPG/GWuQpn3ZYkwsSl1k5ilyXneiyQ3zF95hMeelMxKCD8DWp3cva/Q==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr36176637wrj.182.1555106404023;
        Fri, 12 Apr 2019 15:00:04 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:03 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 03/19] bpf: factor out reg and stack slot propagation into "propagate_liveness_reg"
Date:   Fri, 12 Apr 2019 22:59:36 +0100
Message-Id: <1555106392-20117-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After code refactor in previous patches, the propagation logic inside the
for loop in "propagate_liveness" becomes clear that they are good enough to
be factored out into a common function "propagate_liveness_reg".

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fd36a8..3fdb301 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6221,6 +6221,22 @@ static bool states_equal(struct bpf_verifier_env *env,
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
@@ -6250,11 +6266,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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
@@ -6264,11 +6277,8 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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

