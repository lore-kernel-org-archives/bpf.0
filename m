Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FFFC0650E
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705020B7C
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTlvOrgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfGAQbM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:31:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35860 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfGAQbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 12:31:11 -0400
Received: by mail-qk1-f201.google.com with SMTP id 11so14100345qkg.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=99mTW3U5MG0x4k0yihAasMZW449IUPn2l499+3n8rIo=;
        b=jTlvOrgVM4EB5KSvEq8GksBYrbfLdKpnaB8sMRETY8j+uh0pyzvyXTEIFQjWrR43O2
         kkMeZzgTGw4d8RXOeWTfTYlonlKmwtru+Ko3mjorqUWL/9qJSeuX2b4ls5qXuO4GDi0e
         FjUu39qLfMgj+S+xKJ8zmlmyrRpIKa2UZoJeRMfKVWkhnlFd+B93biWA6YvdbW1krDun
         v4ETtrKptgJHXDXOm0UF21zi5XBNY7cfyCjra48CJxGOcAUsmLw8cUmIed41CrXM82fn
         opdY4UMQzVJhHlQDjCYjZ4dnV/TwE4bG32+PCzv/BJLPMNCXZ6jCwwGAAq6PYEc8yciS
         toGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=99mTW3U5MG0x4k0yihAasMZW449IUPn2l499+3n8rIo=;
        b=VCu0H5/8/965g2TzEPOSeTqknHujod5ilSouTkf4EDa5MMxN8FlvKg2NjS9C8MS4nX
         +w3dybKT/ywZKpKpotWvk0GQaj1puXv+j4hUeG+4sRObcnbizgTJ3NsrKzalRUuYbp9h
         lOWUuS1lNneJ5CklcnXVMQAStssPI39Zq1E4rx1kHxxPFTD4RWqyx1UdGAEuwUSkU0I6
         ZAVe7mxBnjZAsO/p//A90szzkCqWAbRM48d+jNFYe31H+XAJrPOaeEy2B5qtwZGgU1Ns
         8wFK/4bO1v4aMr1K3mdIPIhI8AmyD32X80yrbXpjS3Fc7PPuxffDW8AHditRiCs7pw9H
         yP2g==
X-Gm-Message-State: APjAAAWF1pxod1zuWdxKFQ16gnd9R4GoH3yHK66K6p1WAcKFMb7bLp4W
        1NiSs9QSxqjqrWCjO+h+5qnKU5g=
X-Google-Smtp-Source: APXvYqwM/vbkWM+2ra9nL5IMBIo5fxtYezBf87T1+He8no/wXbuvlSrdr75gIblJ/nysWwe6nhWDj7M=
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr21589602qtj.176.1561998670513;
 Mon, 01 Jul 2019 09:31:10 -0700 (PDT)
Date:   Mon,  1 Jul 2019 09:31:02 -0700
In-Reply-To: <20190701163103.237550-1-sdf@google.com>
Message-Id: <20190701163103.237550-3-sdf@google.com>
Mime-Version: 1.0
References: <20190701163103.237550-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v2 2/3] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync user_ip6 & msg_src_ip6 comments.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a396b516a2b2..586867fe6102 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3237,7 +3237,7 @@ struct bpf_sock_addr {
 	__u32 user_ip4;		/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 user_ip6[4];	/* Allows 1,2,4-byte read an 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__u32 user_port;	/* Allows 4-byte read and write.
@@ -3249,7 +3249,7 @@ struct bpf_sock_addr {
 	__u32 msg_src_ip4;	/* Allows 1,2,4-byte read an 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
-- 
2.22.0.410.gd8fdbe21b5-goog

