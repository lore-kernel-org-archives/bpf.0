Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5790C282CE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD3820818
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDIGok (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:44:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:18780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfDIGok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 02:44:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 23:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,328,1549958400"; 
   d="scan'208";a="289943826"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.40])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 23:44:35 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf 0/2] libbpf: remove two dependencies on Linux kernel headers and improve performance as a bonus
Date:   Tue,  9 Apr 2019 08:44:11 +0200
Message-Id: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set removes two dependencies on Linux kernel headers
from the XDP socket code in libbpf. A number of people have pointed
out that these two dependencies make it hard to build the XDP socket
part of libbpf without any kernel header dependencies. The two removed
dependecies are:

* Remove the usage of likely and unlikely (compiler.h) in xsk.h. It
  has been reported that the use of these actually decreases the
  performance of the ring access code due to an increase in
  instruction cache misses, so let us just remove these.

* Remove the dependency on barrier.h as it brings in a lot of kernel
  headers. As the XDP socket code only uses two simple functions from
  it, we can reimplement these. As a bonus, the new implementation is
  faster as it uses the same barrier primitives as the kernel does
  when the same code is compiled there. Without this patch, the user
  land code uses lfence and sfence on x86, which are unecessarily
  harsh/thorough.

Do the ARM barriers look sane? Have not tested these.

/Magnus

Magnus Karlsson (2):
  libbpf: remove likely/unlikely in xsk.h
  libbpf: remove dependency on barrier.h in xsk.h

 tools/lib/bpf/xsk.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--
2.7.4
