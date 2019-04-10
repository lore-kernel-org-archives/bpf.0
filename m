Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34046C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466020820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="N//uFze+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDJTut (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDJTup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so3903904wmf.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3iIFlXR2eXoRp0nNYSlUsqCTo2SKZyG3oKJceN0EjE8=;
        b=N//uFze+I0XvR3/1vrCPzFncgfwiLneQjDHOFRsSsbb71joWPjlgq0XByh+OVR1s7V
         hMKaOIW2e82JwROyLbAGl4PLOHi8alq2iPN9Ejdi7gV6dBiPLrNzzGTMFq8iXQyYAyyB
         H+s50kBut+sXJqJ5TiaKzaidG0dvXFohg1iDS9b69949qeZGAuB+7jPpmJJhV9L+vGf3
         YX7zNFcWcH/sYm3XCOtxrcbFMR87jOb6+oBZaJCTOBThBUWL4Z9k/MwbsejPBvKlR1KH
         Rjehje3ybSrCgaU+6EN3NkYWgambN0tacCuHkDgsIALyHzb7MV8S02NCpB0CYWuBchUl
         yXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3iIFlXR2eXoRp0nNYSlUsqCTo2SKZyG3oKJceN0EjE8=;
        b=TQ2RoXtIj9IQ8mXboWMEmUVUHbdAKvyTQ8fVT7EGtKZ4FThGUw4lMWXjQ8spYh8x3H
         uwMsIGmBRXUHif/NfthtUONeOidQrLl2CjLT3bYX2+WrGV85z7wXCnwDD15eHaFN+lOn
         8tdPLrI01gTxZQqiqSptk4DMaDTJuCcUIEXMxjYdswQ1E63fMfaSiY5gVF+DNt22XnJl
         f2l29kz+3tsxqaWzFUED99qHPNwSHzWXJk2BlSR/OWRHhlsfkcKjtHJ+XXfnHl7pIiwe
         zhhjmhJLfjDce6jHPMND4dAuJ8Dpl0777uIABabjB0UeY1NW27D0TTrmZdwYdFuGwgWl
         +n4A==
X-Gm-Message-State: APjAAAUBAYemytKddADTaCN1E0WtyxUmKj9cnbWK8u7rPYY9+SNlxnjN
        rZtX8uRQAdTd8QWPUkaCwd9UDg==
X-Google-Smtp-Source: APXvYqzIWoB9j5FMiW5W1zd3sdLTk1f1s/pUb4/hRKT4b6bhAdOxE0rbQrPLJBCv/gYwgkgVwTJBwQ==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr4256502wme.72.1554925843599;
        Wed, 10 Apr 2019 12:50:43 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:42 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 04/19] bpf: refactor "check_reg_arg" to eliminate code redundancy
Date:   Wed, 10 Apr 2019 20:50:18 +0100
Message-Id: <1554925833-7333-5-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are a few "regs[regno]" here are there across "check_reg_arg", this
patch factor it out into a simple "reg" pointer. The intention is to
simplify code indentation and make the later patches in this set look
cleaner.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d60dc7..bd30a65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1177,30 +1177,32 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs;
+	struct bpf_reg_state *reg, *regs = state->regs;
 
 	if (regno >= MAX_BPF_REG) {
 		verbose(env, "R%d is invalid\n", regno);
 		return -EINVAL;
 	}
 
+	reg = &regs[regno];
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
-		if (regs[regno].type == NOT_INIT) {
+		if (reg->type == NOT_INIT) {
 			verbose(env, "R%d !read_ok\n", regno);
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
-		if (regno != BPF_REG_FP)
-			return mark_reg_read(env, &regs[regno],
-					     regs[regno].parent);
+		if (regno == BPF_REG_FP)
+			return 0;
+
+		return mark_reg_read(env, reg, reg->parent);
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
 			verbose(env, "frame pointer is read only\n");
 			return -EACCES;
 		}
-		regs[regno].live |= REG_LIVE_WRITTEN;
+		reg->live |= REG_LIVE_WRITTEN;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
-- 
2.7.4

