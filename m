Return-Path: <SRS0=8dm5=7L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07783C433E2
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF0B212CC
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 23:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgE2X2R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 May 2020 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgE2X2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 19:28:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E7C08C5CB;
        Fri, 29 May 2020 16:28:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoQA-000Bks-2G; Fri, 29 May 2020 23:28:14 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH 9/9] bpf: make bpf_check_uarg_tail_zero() use check_zeroed_user()
Date:   Sat, 30 May 2020 00:28:14 +0100
Message-Id: <20200529232814.45149-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... rather than open-coding it, and badly, at that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/syscall.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64783da34202..41ba746ecbc2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -67,32 +67,19 @@ int bpf_check_uarg_tail_zero(void __user *uaddr,
 			     size_t expected_size,
 			     size_t actual_size)
 {
-	unsigned char __user *addr;
-	unsigned char __user *end;
-	unsigned char val;
-	int err;
+	unsigned char __user *addr = uaddr + expected_size;
+	int res;
 
 	if (unlikely(actual_size > PAGE_SIZE))	/* silly large */
 		return -E2BIG;
 
-	if (unlikely(!access_ok(uaddr, actual_size)))
-		return -EFAULT;
-
 	if (actual_size <= expected_size)
 		return 0;
 
-	addr = uaddr + expected_size;
-	end  = uaddr + actual_size;
-
-	for (; addr < end; addr++) {
-		err = get_user(val, addr);
-		if (err)
-			return err;
-		if (val)
-			return -E2BIG;
-	}
-
-	return 0;
+	res = check_zeroed_user(addr, actual_size - expected_size);
+	if (res < 0)
+		return res;
+	return res ? 0 : -E2BIG;
 }
 
 const struct bpf_map_ops bpf_map_offload_ops = {
-- 
2.11.0

