Return-Path: <SRS0=YueQ=TN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5EC04AB4
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7921479
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 09:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfEMJMR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 May 2019 05:12:17 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48534 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfEMJMQ (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Mon, 13 May 2019 05:12:16 -0400
Received: from GaryWorkstation.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Mon, 13 May 2019 11:12:13 +0200
From:   Gary Lin <glin@suse.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 2/2] docs/btf: update BTF_INT_OFFSET()
Date:   Mon, 13 May 2019 17:11:58 +0800
Message-Id: <20190513091158.6200-2-glin@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513091158.6200-1-glin@suse.com>
References: <20190513091158.6200-1-glin@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix BTF_INT_OFFSET() in the document

Signed-off-by: Gary Lin <glin@suse.com>
---
 Documentation/bpf/btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 8820360d00da..35d83e24dbdb 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -131,7 +131,7 @@ The following sections detail encoding of each kind.
 ``btf_type`` is followed by a ``u32`` with the following bits arrangement::
 
   #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
-  #define BTF_INT_OFFSET(VAL)     (((VAL  & 0x00ff0000)) >> 16)
+  #define BTF_INT_OFFSET(VAL)     (((VAL) & 0x00ff0000) >> 16)
   #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
 
 The ``BTF_INT_ENCODING`` has the following attributes::
-- 
2.21.0

