Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86BC282DE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826C320830
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDIVKa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:10:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:49762 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfDIVK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 17:10:28 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDy0b-0000EN-Dk; Tue, 09 Apr 2019 23:10:21 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        jannh@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v6 05/16] bpf: allow . char as part of the object name
Date:   Tue,  9 Apr 2019 23:08:59 +0200
Message-Id: <20190409210910.32048-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190409210910.32048-1-daniel@iogearbox.net>
References: <20190409210910.32048-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
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
index b3ce516e5a20..198c9680bf0d 100644
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
2.17.1

