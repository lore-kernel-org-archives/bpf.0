Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4DC10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07AD20870
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfDPM61 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:29568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfDPM61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="292005174"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 05:58:22 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v3 0/5] libbpf: remove two dependencies on Linux
Date:   Tue, 16 Apr 2019 14:58:07 +0200
Message-Id: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes one bug and removes two dependencies on Linux
kernel headers from the XDP socket code in libbpf. A number of people
have pointed out that these two dependencies make it hard to build the
XDP socket part of libbpf without any kernel header dependencies. The
two removed dependecies are:

* Remove the usage of likely and unlikely (compiler.h) in xsk.h. It
  has been reported that the use of these actually decreases the
  performance of the ring access code due to an increase in
  instruction cache misses, so let us just remove these.

* Remove the dependency on barrier.h as it brings in a lot of kernel
  headers. As the XDP socket code only uses two simple functions from
  it, we can reimplement these. As a bonus, the new implementation is
  faster as it uses the same barrier primitives as the kernel does
  when the same code is compiled there. Without this patch, the user
  land code uses lfence and sfence on x86, which are unnecessarily
  harsh/thorough.

In the process of removing these dependencies a missing barrier
function for at least PPC64 was discovered. For a full explanation on
the missing barrier, please refer to patch 1. So the patch set now
starts with two patches fixing this. I have also added a patch at the
end removing this full memory barrier for x86 only, as it is not
needed there.

Structure of the patch set:
Patch 1-2: Adds the missing barrier function in kernel and user space.
Patch 3-4: Removes the dependencies
Patch 5: Optimizes the added barrier from patch 2 so that it does not
         do unnecessary work on x86.

v2 -> v3:
* Added missing memory barrier in ring code
* Added an explanation on the three barriers we use in the code
* Moved barrier functions from xsk.h to libbpf_util.h
* Added comment on why we have these functions in libbpf_util.h
* Added a new barrier function in user space that makes it possible to
  remove the full memory barrier on x86.

v1 -> v2:
* Added comment about validity of ARM 32-bit barriers.
  Only armv7 and above.

/Magnus

Magnus Karlsson (5):
  xsk: fix XDP socket ring buffer memory ordering
  libbpf: fix XDP socket ring buffer memory ordering
  libbpf: remove likely/unlikely in xsk.h
  libbpf: remove dependency on barrier.h in xsk.h
  libbpf: optimize barrier for XDP socket rings

 net/xdp/xsk_queue.h         | 56 +++++++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf_util.h | 30 ++++++++++++++++++++++++
 tools/lib/bpf/xsk.h         | 22 +++++++++++++-----
 3 files changed, 98 insertions(+), 10 deletions(-)

--
2.7.4
