Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF076C10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 07:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66652184B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 07:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfDRHVg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:21:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:23965 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfDRHVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 03:21:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 00:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,365,1549958400"; 
   d="scan'208";a="292541251"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2019 00:21:33 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: remove compile time warning from libbpf_util.h
Date:   Thu, 18 Apr 2019 09:21:10 +0200
Message-Id: <1555572070-30796-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Having a helpful compile time warning in libbpf_util.h is not a good
idea since all warnings are treated as errors. Change this into a
comment in the code instead.

Fixes: b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/libbpf_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
index 172b707e..da94c4c 100644
--- a/tools/lib/bpf/libbpf_util.h
+++ b/tools/lib/bpf/libbpf_util.h
@@ -46,7 +46,7 @@ do {				\
 # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
 # define libbpf_smp_rwmb() libbpf_smp_mb()
 #else
-# warning Architecture missing native barrier functions in libbpf_util.h.
+/* Architecture missing native barrier functions. */
 # define libbpf_smp_rmb() __sync_synchronize()
 # define libbpf_smp_wmb() __sync_synchronize()
 # define libbpf_smp_mb() __sync_synchronize()
-- 
2.7.4

