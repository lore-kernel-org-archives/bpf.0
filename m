Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB18C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7DC218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wAcwXDVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDLWAI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37878 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfDLWAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so13752369wrm.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5JznXDOEWc1oAs2pt0jdnGJ632ezz+lDAgpcI6vofg8=;
        b=wAcwXDVb3uA1GTO8+OGOQwPdzAtJN9n2KBmy2ThZMxiCcGEjOWvISHJfk5VxDejhXD
         hOgzLxiUtLwwONBXDtkX3zGKsNbRdIrD8lsNGSVq6seJ24ODXl1gLPR9WsIGVoJgSJVX
         Vmg8Te0Vu9BfdeRiOybWhWgku9f2rPzNULPjXclt3eDEdWTu1fPoNeP247YxUPeVFWFq
         ypT7+iVxDktIFVLGZG7k7GdzqwRssoyFF2Fy3hd6qki9eAWwu1p4/LU2b6EfPzWiXq+N
         ip9lxfqwW32Y98iriaazr97wWDoSx6vojBgrZiDHWFyneG/Etwu7xloWI+QfWMw89r3Y
         +Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5JznXDOEWc1oAs2pt0jdnGJ632ezz+lDAgpcI6vofg8=;
        b=Gj/k2OdYcQ8eKzsIJoGCZtPaK3DCjKHarwUT9mW7zamwx3lTjX9gJ1TfsYcrNaLVbU
         oC66DhyL6JJfU6ICgElRQ861TRrIkvHOObjM6S6PaogKTjqEM5pTunnbwD8fOgS2Y7bx
         3HcdRjk+mB9cq4wBs2w1t/1TLczj6b+dZZzjkGVcz+sswUjw7SBvYQ6GJZNdvyCUEjX2
         5696kosL6IEdp6t1jMR/mPD2dKML/YBRXpmUtFo5qFYW3o3gizT+L6QpYpn87R6IEP1Q
         /r1agfPCQ8jk0XRylt+uZvpMnhd25bZlwKx3Gbrgs1919qKomTo240VKOg5lWJbGSh8E
         JC8w==
X-Gm-Message-State: APjAAAU8lHIf/HIMd/bSimiogVLbM2UXR5gEgXGp/5sGm9sbjNJjIqWc
        ZMoH7RlNycp9vtNAcI33h+Felg==
X-Google-Smtp-Source: APXvYqxpNfHFHCxRaKYjKy+uisRIx+lSFnNBd1YHd1K6KRtqnNB8IdNhQu1bkTs+uS4+hF17JXrMRw==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr38452572wrq.212.1555106406219;
        Fri, 12 Apr 2019 15:00:06 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:04 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 04/19] bpf: refactor "check_reg_arg" to eliminate code redundancy
Date:   Fri, 12 Apr 2019 22:59:37 +0100
Message-Id: <1555106392-20117-5-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are a few "regs[regno]" here are there across "check_reg_arg", this
patch factor it out into a simple "reg" pointer. The intention is to
simplify code indentation and make the later patches in this set look
cleaner.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3fdb301..c722015 100644
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

