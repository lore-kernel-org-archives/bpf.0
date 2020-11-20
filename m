Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D03C64E69
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE13B2223F
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 20:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbgKTUaP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:30:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:10351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbgKTUaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:05 -0500
IronPort-SDR: tdEv5aCqpis0/Hy76GMpPUr8pAkLgknJJgxd2TIc4KVHtSxPbkczdCTKW1FfaPyLMMCA3IbemT
 IaQUHiQoWCEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683315"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:05 -0800
IronPort-SDR: L1xDqxf3UVznloBFPan2HQRYqMBh/YHfvW36kbJ8ZoLYsTqGGXh+fYXmNokknMcHOPOuJTURc/
 R1wrNmlQC+Hg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163328"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:04 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 09/10] ftrace: Use module writable address
Date:   Fri, 20 Nov 2020 12:24:25 -0800
Message-Id: <20201120202426.18009-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the module writable address to accommodate arch's that have a
separate writable address for perm_alloc.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8185f7240095..ea6377108bab 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6134,7 +6134,7 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	sort(start, count, sizeof(*start),
+	sort(module_adjust_writable_addr(start), count, sizeof(*start),
 	     ftrace_cmp_ips, NULL);
 
 	start_pg = ftrace_allocate_pages(count);
-- 
2.20.1

