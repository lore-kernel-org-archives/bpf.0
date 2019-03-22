Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED0C10F03
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FFB2175B
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCVXsG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:48:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:60456 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCVXsG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 19:48:06 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7TtL-0006bJ-Bb; Sat, 23 Mar 2019 00:48:03 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     sdf@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] bpf, libbpf: clarify bump in libbpf version info
Date:   Sat, 23 Mar 2019 00:47:55 +0100
Message-Id: <20190322234755.29306-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322234755.29306-1-daniel@iogearbox.net>
References: <20190322234755.29306-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25396/Fri Mar 22 08:52:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current documentation suggests that we would need to bump the
libbpf version on every change. Lets clarify this a bit more and
reflect what we do today in practice, that is, bumping it once per
development cycle.

Fixes: 76d1b894c515 ("libbpf: Document API and ABI conventions")
Reported-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/README.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/README.rst b/tools/lib/bpf/README.rst
index 5788479..cef7b77 100644
--- a/tools/lib/bpf/README.rst
+++ b/tools/lib/bpf/README.rst
@@ -111,6 +111,7 @@ starting from ``0.0.1``.
 
 Every time ABI is being changed, e.g. because a new symbol is added or
 semantic of existing symbol is changed, ABI version should be bumped.
+This bump in ABI version is at most once per kernel development cycle.
 
 For example, if current state of ``libbpf.map`` is:
 
-- 
2.9.5

