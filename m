Return-Path: <SRS0=kfcJ=3W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB3C35240
	for <bpf@archiver.kernel.org>; Sun,  2 Feb 2020 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331C2067C
	for <bpf@archiver.kernel.org>; Sun,  2 Feb 2020 11:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgBBLBW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 2 Feb 2020 06:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:47454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgBBLBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Feb 2020 06:01:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC57DAD69;
        Sun,  2 Feb 2020 11:01:20 +0000 (UTC)
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpftool: Remove redundant "HAVE" prefix from the large INSN limit check
Date:   Sun,  2 Feb 2020 12:02:00 +0100
Message-Id: <20200202110200.31024-1-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.16.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"HAVE" prefix is already applied by default to feature macros and before
this change, the large INSN limit macro had the incorrect name with
double "HAVE".

Fixes: 2faef64aa6b3 ("bpftool: Add misc section and probe for large INSN limit")
Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
---
 tools/bpf/bpftool/feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 446ba891f1e2..941873d778d8 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -580,7 +580,7 @@ probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
 	res = bpf_probe_large_insn_limit(ifindex);
 	print_bool_feature("have_large_insn_limit",
 			   "Large program size limit",
-			   "HAVE_LARGE_INSN_LIMIT",
+			   "LARGE_INSN_LIMIT",
 			   res, define_prefix);
 }
 
-- 
2.16.4

