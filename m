Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514A3C433EF
	for <bpf@archiver.kernel.org>; Mon,  4 Apr 2022 08:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiDDIkP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiDDIkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 04:40:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BF36157
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 01:38:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67018210EB;
        Mon,  4 Apr 2022 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649061498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zohl9jYG0rGvcxwWiDrKlDyXx+nmX3WwMzKAdjJmEN0=;
        b=gGfkVc1AX0PhAYyypKvQ1ojb2USB6OTYKGB0gC+Um2j6UO7O00VUst5je8+BUTEtOEZhN2
        afCdVAfNeds9CmYx4EC7NFzLaj9ePKTizhLicgXb+6B4p/IxjILN5oRY6qr44wxvr2wqUA
        9TSRIDcFg73qP5rKMLc+DzRaM70soA8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B73213216;
        Mon,  4 Apr 2022 08:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOZ2O3muSmKuBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 04 Apr 2022 08:38:17 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH 1/2] libbpf: Add userspace version of for_each_member macro
Date:   Mon,  4 Apr 2022 11:38:15 +0300
Message-Id: <20220404083816.1560501-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404083816.1560501-1-nborisov@suse.com>
References: <20220404083816.1560501-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are multiple places in libbpf where iteration of struct/union
members is required. Instead of open-coding it let's introduce a
convenience macro.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tools/lib/bpf/btf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 061839f04525..74039f8afc63 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -578,6 +578,12 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+#define for_each_member(i, struct_type, member)         \
+	for (i = 0, member = btf_members(struct_type);  \
+	     i < btf_vlen(struct_type);                 \
+	     i++, member++)
+
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.25.1

