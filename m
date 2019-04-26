Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F55C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70202077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfDZTsl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:48:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:60868 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZTsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 15:48:41 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hK6pr-0004d0-EP; Fri, 26 Apr 2019 21:48:39 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     will.deacon@arm.com, jean-philippe.brucker@arm.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 0/2] Two arm64 bpf jit improvements
Date:   Fri, 26 Apr 2019 21:48:20 +0200
Message-Id: <20190426194822.7328-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25431/Fri Apr 26 09:57:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set holds two arm64 bpf jit improvements for xadd. Thanks!

Daniel Borkmann (2):
  bpf, arm64: remove prefetch insn in xadd mapping
  bpf, arm64: use more scalable stadd over ldxr / stxr loop in xadd

 arch/arm64/include/asm/insn.h |  8 ++++++++
 arch/arm64/kernel/insn.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit.h      |  8 +++-----
 arch/arm64/net/bpf_jit_comp.c | 29 +++++++++++++++++++----------
 4 files changed, 70 insertions(+), 15 deletions(-)

-- 
2.9.5

