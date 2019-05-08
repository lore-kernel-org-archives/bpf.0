Return-Path: <SRS0=ThzB=TI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D7C04A6B
	for <bpf@archiver.kernel.org>; Wed,  8 May 2019 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DAF20644
	for <bpf@archiver.kernel.org>; Wed,  8 May 2019 07:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfEHHzI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:08 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48437 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHHzI (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Wed, 8 May 2019 03:55:08 -0400
Received: from GaryWorkstation.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Wed, 08 May 2019 09:55:05 +0200
From:   Gary Lin <glin@suse.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] docs/btf: fix the missing section marks
Date:   Wed,  8 May 2019 15:54:48 +0800
Message-Id: <20190508075448.28477-1-glin@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The section titles of 3.4 and 3.5 are not marked correctly.

Signed-off-by: Gary Lin <glin@suse.com>
---
 Documentation/bpf/btf.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 29396e6943b0..8820360d00da 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -578,6 +578,7 @@ For line_info, the line number and column number are defined as below:
     #define BPF_LINE_INFO_LINE_COL(line_col)        ((line_col) & 0x3ff)
 
 3.4 BPF_{PROG,MAP}_GET_NEXT_ID
+==============================
 
 In kernel, every loaded program, map or btf has a unique id. The id won't
 change during the lifetime of a program, map, or btf.
@@ -587,6 +588,7 @@ each command, to user space, for bpf program or maps, respectively, so an
 inspection tool can inspect all programs and maps.
 
 3.5 BPF_{PROG,MAP}_GET_FD_BY_ID
+===============================
 
 An introspection tool cannot use id to get details about program or maps.
 A file descriptor needs to be obtained first for reference-counting purpose.
-- 
2.21.0

