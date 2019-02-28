Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3911C10F06
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1432075B
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfB1XTJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:19:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:52336 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfB1XTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:19:08 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzUxD-0000ln-P7; Fri, 01 Mar 2019 00:19:03 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 3/7] bpf, obj: allow . char as part of the name
Date:   Fri,  1 Mar 2019 00:18:25 +0100
Message-Id: <20190228231829.11993-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190228231829.11993-1-daniel@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trivial addition to allow '.' aside from '_' as "special" characters
in the object name. Used to name maps from loader side as ".bss",
".data", ".rodata".

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d3ef45e01d7a..90044da3346e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -440,10 +440,10 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
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
2.17.1

