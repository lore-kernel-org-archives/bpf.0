Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E4C10F06
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911C20879
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZJNiYvf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfCZSGg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbfCZSGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so12006696wrx.9
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3a0ZAIs1IZIaNNbJanNqmr2UjvxD3jEqVyi+mpSkwGo=;
        b=ZJNiYvf2Ytac3mXImIE87YhLmTGm0qrNlAGW74a9VVoh0wTwQoZPAh9SdE2wGyXXcQ
         FEnStWSfJOxudcuLk4W/Tu46vaSB/CjD5Y5E74AJ7PIWdouSiaB1ZDDBMnNjcn54MT8E
         55Tz95cR2Q424eaFUEFlup1r71XHcWYi66ttbbWcjuk4rZJHWpzEBrfJJLwztdMJRnvd
         xAm6DCQRVQdFJNku8GF0VyeKzufDEg6kl0kLvxjWwTgdVLzaY+B7uuG223/q5AULzKgk
         JBQuCwDm4bSHxmqUwz+TG8YAaG+X/+w/nONoXyFVM3OSsSWwT0TRtfq2E7tRuARxF607
         rlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3a0ZAIs1IZIaNNbJanNqmr2UjvxD3jEqVyi+mpSkwGo=;
        b=KyUTIksf7TLw3UD1Fx+gBFtupc4TWofbCHhbqGyJlbmQlr1KXVpMIrjJWM3DrL8XGK
         50qNAHs5wYkc7iX8xx9qRUSsRfpYjx85XjxiVb+egOxTdO5CIJuuPES/xE3XLQOnEvuR
         ZlT3lc7XCocvgGmyJR1hw8oXfS43EmmBydfw3FyRMHC4t0mWTJzY77Odb2AHl99oG9EW
         +Ue/36Ptipn/JPiFd0fkZmW+mJXTkReXHYv91MNwIQbwK/Bid99PmK7RrjZ/aY8e2vzF
         /UchmcaIhMvtzFF6cSE+zTHheGvV94tF2iPhZgvNbPlzC7Z0Oy9UwzW31rgxbCxTvuZ0
         N5CA==
X-Gm-Message-State: APjAAAVdWTzJBFmCNeRZ63TTUuGjUvKamn6oveN0ns+EHE2f4LGlq8Ro
        TvoAS7KjhQi4YyR+ieLZGWcZZUaqE9s=
X-Google-Smtp-Source: APXvYqziSCtK0ryQY3PEKB6zX+OpEJZ+76wlReV8ZBova0k9UVj/uYPqHLqdi7+4tfSEG7DXVlVU+g==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr20001816wru.202.1553623595017;
        Tue, 26 Mar 2019 11:06:35 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:33 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 01/16] bpf: turn "enum bpf_reg_liveness" into bit representation
Date:   Tue, 26 Mar 2019 18:05:24 +0000
Message-Id: <1553623539-15474-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"enum bpf_reg_liveness" is actually used as bit instead of integer. For
example:

        if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))

Using enum to represent bit is error prone, better to use explicit bit
macros.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf_verifier.h | 16 +++++++++-------
 kernel/bpf/verifier.c        |  5 ++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7d8228d..f03c86a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -34,12 +34,14 @@
  * but of the link between it and its parent.  See mark_reg_read() and
  * mark_stack_slot_read() in kernel/bpf/verifier.c.
  */
-enum bpf_reg_liveness {
-	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
-	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
-	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
-	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
-};
+/* Reg hasn't been read or written this branch. */
+#define REG_LIVE_NONE		0x0
+/* Reg was read, so we're sensitive to initial value. */
+#define REG_LIVE_READ		0x1
+/* Reg was written first, screening off later reads. */
+#define REG_LIVE_WRITTEN	0x2
+/* Liveness won't be updating this register anymore. */
+#define REG_LIVE_DONE		0x4
 
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
@@ -131,7 +133,7 @@ struct bpf_reg_state {
 	 * pointing to bpf_func_state.
 	 */
 	u32 frameno;
-	enum bpf_reg_liveness live;
+	u8 live;
 };
 
 enum bpf_stack_slot_type {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dffeec3..6cc8c38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -407,8 +407,7 @@ static char slot_type_char[] = {
 	[STACK_ZERO]	= '0',
 };
 
-static void print_liveness(struct bpf_verifier_env *env,
-			   enum bpf_reg_liveness live)
+static void print_liveness(struct bpf_verifier_env *env, u8 live)
 {
 	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
 	    verbose(env, "_");
@@ -5687,8 +5686,8 @@ static bool check_ids(u32 old_id, u32 cur_id, struct idpair *idmap)
 static void clean_func_state(struct bpf_verifier_env *env,
 			     struct bpf_func_state *st)
 {
-	enum bpf_reg_liveness live;
 	int i, j;
+	u8 live;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
 		live = st->regs[i].live;
-- 
2.7.4

