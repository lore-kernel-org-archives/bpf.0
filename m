Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32767C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D63120883
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfDBL6V (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:58:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40271 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBL6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 07:58:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so3359320wmi.5;
        Tue, 02 Apr 2019 04:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/n+b2pRTGMG9DLfZAGrxGryM+KpQVtKNoEdo6fIx1tU=;
        b=YT5q9pUCoB02HrjqGJqeyunamNmDkgi5JQAxUXJLZEzBClHz4O8NlTMQGxdjlD0Hj6
         UUafF+UxARz3pC6xp7gm3v6r8FO4KbsqL16AmXTYS+EvBRfS/ojXCTlzFdwF29ej/Oid
         TX0QHUPJHR0YR6z3PjNFY5jqKbiO1q/0JfA4UMNRsEOaRE/+BkgKNfA730MCdfZJuc+H
         5ksizQ2ojHIhRofxUk0yDFFUpruOv9pCxm43XMMcuSHk9f5NEdYQb4K/2xaOVSlNFxu4
         wh9DoCIk1d0C2UKIYuzEfbEHizqJ7X0oQ0SRklXrqbxa6kp11pRvYR5fnO/mVIExHLPM
         nDJA==
X-Gm-Message-State: APjAAAV+QN3AyntYhcL6AAwhsIj4gJeuREYB9ECWK6u0PdWiTJJE7oJP
        Hbbtch8bglGPYw0U6uHnOsE=
X-Google-Smtp-Source: APXvYqwSJMABHJQk64PdG3z4q69aPXUqKXcyICdZGXa6m7/z2DGIVissPGgOOseVa6Aml5njKj4y5g==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3464273wmj.111.1554206299547;
        Tue, 02 Apr 2019 04:58:19 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id d3sm12825065wmf.46.2019.04.02.04.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 04:58:18 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:58:14 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] bpf: report verifier bugs as warnings
Message-ID: <20190402115811.GA6303@Nover>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three checks for verifier bugs were introduced in commit f4d7e40 ("bpf:
introduce function calls (verification)").  The bugs were reported as
incorrect programs instead of kernel warnings as the present patch
implements.

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 87221fda1321..12499e72b0d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1145,9 +1145,9 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
 		if (parent->live & REG_LIVE_DONE) {
-			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
-				reg_type_str[parent->type],
-				parent->var_off.value, parent->off);
+			WARN_ONCE(1, "verifier bug type %s var_off %lld off %d\n",
+				  reg_type_str[parent->type],
+				  parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
 		/* ... then we depend on parent's value */
@@ -2888,15 +2888,15 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	target_insn = *insn_idx + insn->imm;
 	subprog = find_subprog(env, target_insn + 1);
 	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n",
-			target_insn + 1);
+		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
+			  target_insn + 1);
 		return -EFAULT;
 	}
 
 	caller = state->frame[state->curframe];
 	if (state->frame[state->curframe + 1]) {
-		verbose(env, "verifier bug. Frame %d already allocated\n",
-			state->curframe + 1);
+		WARN_ONCE(1, "verifier bug. Frame %d already allocated\n",
+			  state->curframe + 1);
 		return -EFAULT;
 	}
 
-- 
2.17.1

