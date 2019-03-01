Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE4C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1110206B6
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCAVFh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:05:37 -0500
Received: from www62.your-server.de ([213.133.104.62]:45540 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 16:05:37 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzpLa-0001tK-Vc; Fri, 01 Mar 2019 22:05:35 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     afabre@cloudflare.com, marek@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
Date:   Fri,  1 Mar 2019 22:05:29 +0100
Message-Id: <20190301210529.8218-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Marek reported that he saw an issue with the below snippet in that
timing measurements where off when loaded as unpriv while results
were reasonable when loaded as privileged:

    [...]
    uint64_t a = bpf_ktime_get_ns();
    uint64_t b = bpf_ktime_get_ns();
    uint64_t delta = b - a;
    if ((int64_t)delta > 0) {
    [...]

Turns out there is a bug where a corner case is missing in the fix
d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
type from different paths"), namely fixup_bpf_calls() only checks
whether aux has a non-zero alu_state, but it also needs to test for
the case of BPF_ALU_NON_POINTER since in both occasions we need to
skip the masking rewrite (as there is nothing to mask).

Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Reported-by: Arthur Fabre <afabre@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
---
 [ Test case will be routed via bpf-next to avoid useless merge churn
   due to test_verifier rework in bpf-next. ]

 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f295b790297..5fcce2f4209d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6920,7 +6920,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			u32 off_reg;
 
 			aux = &env->insn_aux_data[i + delta];
-			if (!aux->alu_state)
+			if (!aux->alu_state ||
+			    aux->alu_state == BPF_ALU_NON_POINTER)
 				continue;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
-- 
2.17.1

