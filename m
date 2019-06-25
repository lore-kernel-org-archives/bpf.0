Return-Path: <SRS0=2zuU=UY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79355C48BD7
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2E216C8
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 11:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfFYLHO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:07:14 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:34068 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbfFYLHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 07:07:13 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4706844039B;
        Tue, 25 Jun 2019 14:07:09 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>, Jiri Olsa <jolsa@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] bpf: fix uapi bpf_prog_info fields alignment
Date:   Tue, 25 Jun 2019 14:04:41 +0300
Message-Id: <a5fb2545a0cf151bc443efa10c16c5a4de6f2670.1561460681.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Merge commit 1c8c5a9d38f60 ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
applications") by taking the gpl_compatible 1-bit field definition from
commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
bpf_prog_info") as is. That breaks architectures with 16-bit alignment
like m68k. Embed gpl_compatible into an anonymous union with 32-bit pad
member to restore alignment of following fields.

Thanks to Dmitry V. Levin his analysis of this bug history.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
Use anonymous union with pad to make it less likely to break again in
the future.
---
 include/uapi/linux/bpf.h       | 5 ++++-
 tools/include/uapi/linux/bpf.h | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a8b823c30b43..766eae02d7ae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3142,7 +3142,10 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u32 gpl_compatible:1;
+	union {
+		__u32 gpl_compatible:1;
+		__u32 pad;
+	};
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a8b823c30b43..766eae02d7ae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3142,7 +3142,10 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u32 gpl_compatible:1;
+	union {
+		__u32 gpl_compatible:1;
+		__u32 pad;
+	};
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
-- 
2.20.1

