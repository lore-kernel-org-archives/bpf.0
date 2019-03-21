Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1057FC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECD9218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="d14b965H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfCUVes (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:34:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39997 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfCUVes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 17:34:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id w20so37029qka.7
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPmqZthdwamFgpgk8Nm1MsROkU5Qsb1IF3gzqfFkOLs=;
        b=d14b965HNfqImu0TEaVEcbE5rv5bM7Zx353WNHWnMeqh9GbRHybiKXl55DR53r/KX6
         eQEZw3Kn6MMuBqDU6QB2mHAIfBUGBbDx8rrckPA0B1aBe5dM7uPe9D0VQjOj4XO/UqMI
         x9834vLcUD6ebscVzsB9ckOHBAhlHVUL2kv3i0eNcJJ4yUBppmgOKSpSBHU/Y9kV40Co
         Z1vsIqEuh1m3yJsruyz61SxoMhORHTrfDk0TTSwuBMfVE7hr/F0iH9DVY4v/SvAXXQet
         o+o4wT1gJFSoHH4WWjn+jN1Jt7jhS2ZKBpIOFICWb15eSNBgrG78ANPAQ2CRyyLb1Lts
         MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPmqZthdwamFgpgk8Nm1MsROkU5Qsb1IF3gzqfFkOLs=;
        b=JMu/OI3gfGgcIxcI4quTmtZM23601gt6y8w04slSOeEWqUdJKQMN8z301SORQxAGNl
         aTJUkW7avsuGqs2wlyLFdjdxy5FvsJ5lJzW79l9u8fYbIOgSwReyLGyLQJGHT43N7Yg3
         HYQQSsDRgKL7aXTZcYCDs0bvrw4TmkqT9gKiHDlOW0dVBrElL1mv4vf1+bx7SvJyPaDA
         0PV9jnZxCs3I/0mTdNooUiXDllwP0UpzwI0EM2Gj3i7yVhvHwvCZnYKMAaIt3avbLAJQ
         NBAH/pvzvmxHBr//Ug5+gOD7RwapCx5jso5vTnlBs5DTpTkzeBTYT8HN0SVLJbEaVydF
         n0tQ==
X-Gm-Message-State: APjAAAWxVw10kALZYCMSHO5QHidfllrOFvdFqslnO2Yg0yfkmqIYFT/J
        ia+/4hMJHY/Du7jI1OwZVoelSiCu7Wg=
X-Google-Smtp-Source: APXvYqxOYj/vndB/aa6bqRe4KASkLoGwRwfAsht4XcKjN3P1F4ZbcmfryV9kLKWw97SquZp0RCHbow==
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr4650366qkj.17.1553204087221;
        Thu, 21 Mar 2019 14:34:47 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y4sm3577239qke.41.2019.03.21.14.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:34:46 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf] bpf: verifier: propagate liveness on all frames
Date:   Thu, 21 Mar 2019 14:34:36 -0700
Message-Id: <20190321213436.22379-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 7640ead93924 ("bpf: verifier: make sure callees don't prune
with caller differences") connected up parentage chains of all
frames of the stack.  It didn't, however, ensure propagate_liveness()
propagates all liveness information along those chains.

This means pruning happening in the callee may generate explored
states with incomplete liveness for the chains in lower frames
of the stack.

The included selftest is similar to the prior one from commit
7640ead93924 ("bpf: verifier: make sure callees don't prune with
caller differences"), where callee would prune regardless of the
difference in r8 state.

Now we also initialize r9 to 0 or 1 based on a result from get_random().
r9 is never read so the walk with r9 = 0 gets pruned (correctly) after
the walk with r9 = 1 completes.

The selftest is so arranged that the pruning will happen in the
callee.  Since callee does not propagate read marks of r8, the
explored state at the pruning point prior to the callee will
now ignore r8.

Propagate liveness on all frames of the stack when pruning.

Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/bpf/verifier.c                        | 20 +++++++++-------
 tools/testing/selftests/bpf/verifier/calls.c | 25 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f52c1159e75d..b6de77664a8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6078,15 +6078,17 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	}
 	/* Propagate read liveness of registers... */
 	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
-	/* We don't need to worry about FP liveness because it's read-only */
-	for (i = 0; i < BPF_REG_FP; i++) {
-		if (vparent->frame[vparent->curframe]->regs[i].live & REG_LIVE_READ)
-			continue;
-		if (vstate->frame[vstate->curframe]->regs[i].live & REG_LIVE_READ) {
-			err = mark_reg_read(env, &vstate->frame[vstate->curframe]->regs[i],
-					    &vparent->frame[vstate->curframe]->regs[i]);
-			if (err)
-				return err;
+	for (frame = 0; frame <= vstate->curframe; frame++) {
+		/* We don't need to worry about FP liveness, it's read-only */
+		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
+			if (vparent->frame[frame]->regs[i].live & REG_LIVE_READ)
+				continue;
+			if (vstate->frame[frame]->regs[i].live & REG_LIVE_READ) {
+				err = mark_reg_read(env, &vstate->frame[frame]->regs[i],
+						    &vparent->frame[frame]->regs[i]);
+				if (err)
+					return err;
+			}
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 4004891afa9c..f2ccae39ee66 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1940,3 +1940,28 @@
 	.errstr = "!read_ok",
 	.result = REJECT,
 },
+{
+	"calls: cross frame pruning - liveness propagation",
+	.insns = {
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_IMM(BPF_REG_8, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_8, 1),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_IMM(BPF_REG_9, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_9, 1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+	.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+	.errstr = "!read_ok",
+	.result = REJECT,
+},
-- 
2.19.2

