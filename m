Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F0C433F5
	for <bpf@archiver.kernel.org>; Thu, 17 Feb 2022 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiBQMEw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiBQMEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 07:04:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DF6433
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 04:04:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDC8C1F37D;
        Thu, 17 Feb 2022 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645099476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5cZrtj7OWbkDO2euCq+2jbQX1Za47r0nSjfhbrYz0Wc=;
        b=QsYgIAuGEBkxfMxk2GVEBhypnIK5zDYt4CnM9cPzncl1xozLeogNKePilUN+6O892mkJlz
        aH4WrfluuKenN+Iqpytf5VkrQFcvifKq7LLgitmHWvp9kw0X004Rgt+tu1fvKwsIYMlcyd
        3stf+RbBWJe6EA0NpFaGHahKfTvAu2I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B93413BDA;
        Thu, 17 Feb 2022 12:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JAEZG9Q5DmLHbgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 17 Feb 2022 12:04:36 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] bpftool: Allow building statically
Date:   Thu, 17 Feb 2022 14:04:35 +0200
Message-Id: <20220217120435.2245447-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sometime it can be useful to haul around a statically built version of
bpftool. Simply add support for passing STATIC=1 while building to build
the tool statically.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Currently the bpftool being distributed as part of libbpf-tools under bcc project
is dynamically built on a system using GLIBC 2.28, this makes the tool unusable on
ubuntu 18.04 for example. Perhaps after this patch has landed the bpftool in bcc
can be turned into a static binary.

 tools/bpf/bpftool/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 83369f55df61..835621e215e4 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -13,6 +13,10 @@ else
   Q = @
 endif

+ifeq ($(STATIC),1)
+	CFLAGS += --static
+endif
+
 BPF_DIR = $(srctree)/tools/lib/bpf

 ifneq ($(OUTPUT),)
--
2.25.1

