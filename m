Return-Path: <SRS0=D/lL=2J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A9C43603
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 21:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412EE222C2
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLSVUA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:20:00 -0500
Received: from www62.your-server.de ([213.133.104.62]:59520 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSVT7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 16:19:59 -0500
Received: from 31.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.31] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ii3DC-00058I-2U; Thu, 19 Dec 2019 22:19:58 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/2] Fix record_func_key to perform backtracking on r3
Date:   Thu, 19 Dec 2019 22:19:49 +0100
Message-Id: <cover.1576789878.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25668/Thu Dec 19 10:55:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes pruning behavior when record_func_key() is used. See main
description in patch 1, test cases added in patch 2.

Thanks!

Daniel Borkmann (2):
  bpf: Fix record_func_key to perform backtracking on r3
  bpf: Add further test_verifier cases for record_func_key

 kernel/bpf/verifier.c                         |   8 +-
 tools/testing/selftests/bpf/test_verifier.c   |  43 ++---
 .../selftests/bpf/verifier/ref_tracking.c     |   6 +-
 .../selftests/bpf/verifier/runtime_jit.c      | 151 ++++++++++++++++++
 4 files changed, 183 insertions(+), 25 deletions(-)

-- 
2.21.0

