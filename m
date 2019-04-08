Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76527C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B7217F4
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDHNyE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:46096 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfDHNyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:04 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUii-0003fy-KH; Mon, 08 Apr 2019 15:53:57 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 05/16] bpf: allow . char as part of the object name
Date:   Mon,  8 Apr 2019 15:53:37 +0200
Message-Id: <7d8b4c212c66a2663f9853fab10ed243a0e42bc6.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trivial addition to allow '.' aside from '_' as "special" characters
in the object name. Used to allow for substrings in maps from loader
side such as ".bss", ".data", ".rodata", but could also be useful for
other purposes.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 959620c..2948085 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -474,10 +474,10 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
 	const char *end = src + BPF_OBJ_NAME_LEN;
 
 	memset(dst, 0, BPF_OBJ_NAME_LEN);
-
-	/* Copy all isalnum() and '_' char */
+	/* Copy all isalnum(), '_' and '.' chars. */
 	while (src < end && *src) {
-		if (!isalnum(*src) && *src != '_')
+		if (!isalnum(*src) &&
+		    *src != '_' && *src != '.')
 			return -EINVAL;
 		*dst++ = *src++;
 	}
-- 
2.9.5

