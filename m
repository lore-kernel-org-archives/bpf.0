Return-Path: <SRS0=W1zS=TR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75316C04AB4
	for <bpf@archiver.kernel.org>; Fri, 17 May 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479CD2082E
	for <bpf@archiver.kernel.org>; Fri, 17 May 2019 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEQVFK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 May 2019 17:05:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:33100 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfEQVFJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 May 2019 17:05:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 14:05:09 -0700
X-ExtLoop1: 1
Received: from linksys13920.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.11])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2019 14:05:09 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     peterz@infradead.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     dave.hansen@intel.com, namit@vmware.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 0/1] Fix for VM_FLUSH_RESET_PERMS on sparc
Date:   Fri, 17 May 2019 14:01:22 -0700
Message-Id: <20190517210123.5702-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Meelis Roos reported issues with the new VM_FLUSH_RESET_PERMS flag on the sparc
architecture. When freeing many BPF JITs simultaneously, the vfree flush
operations can become stuck waiting as they each try to vm_unmap_aliases().

It also came up that using this flag is not needed for architectures like sparc
that already have normal kernel memory as executable. This patch fixes the usage
of this flag on sparc to also fix it in case the root cause is also an issue on
other architectures. Separately we can disable usage of VM_FLUSH_RESET_PERMS for
these architectures if desired.

Rick Edgecombe (1):
  vmalloc: Fix issues with flush flag

 mm/vmalloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.17.1

