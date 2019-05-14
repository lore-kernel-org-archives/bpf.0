Return-Path: <SRS0=CEAn=TO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDE8C04AA7
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 03:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39C4208C3
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 03:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENDQY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 May 2019 23:16:24 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39778 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENDQY (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Mon, 13 May 2019 23:16:24 -0400
Received: from GaryWorkstation.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Tue, 14 May 2019 05:16:20 +0200
From:   Gary Lin <glin@suse.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH] tools/bpf: Sync kernel btf.h header
Date:   Tue, 14 May 2019 11:15:50 +0800
Message-Id: <20190514031550.11446-1-glin@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For the fix of BTF_INT_OFFSET()

Signed-off-by: Gary Lin <glin@suse.com>
---
 tools/include/uapi/linux/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 9310652ca4f9..63ae4a39e58b 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -83,7 +83,7 @@ struct btf_type {
  * is the 32 bits arrangement:
  */
 #define BTF_INT_ENCODING(VAL)	(((VAL) & 0x0f000000) >> 24)
-#define BTF_INT_OFFSET(VAL)	(((VAL  & 0x00ff0000)) >> 16)
+#define BTF_INT_OFFSET(VAL)	(((VAL) & 0x00ff0000) >> 16)
 #define BTF_INT_BITS(VAL)	((VAL)  & 0x000000ff)
 
 /* Attributes stored in the BTF_INT_ENCODING */
-- 
2.21.0

