Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F6C4727F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DDF20759
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgI2Uxn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:53:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:13104 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgI2Uxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 16:53:40 -0400
IronPort-SDR: Im3YcLpd9PAfRKo9mhpqESnG3vgsc5LL0Zv8Dr0IoK3z4SJSU5amkVRKlrxpjPLVlG3UkFlJxW
 oaeVJh48uLIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159668555"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="159668555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:53:39 -0700
IronPort-SDR: 6d9FemefFDxuR2TAJsTk31r0mP1xNljKMV6ofC1cQ78WMK1mHjsGlYPgm4imtoagCbUAhcmnZ5
 GI0mbdgeisGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="493478564"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2020 13:53:37 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 0/2] bpf, x64: optimize JIT's pro/epilogue
Date:   Tue, 29 Sep 2020 22:46:51 +0200
Message-Id: <20200929204653.4325-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

This small set can be considered as a followup after recent addition of
support for tailcalls in bpf subprograms and is focused on optimizing
x64 JIT prologue and epilogue sections.

Turns out the popping tail call counter is not needed anymore and %rsp
handling when stack depth is 0 can be skipped.

For longer explanations, please see commit messages.

Thank you,
Maciej


Maciej Fijalkowski (2):
  bpf, x64: drop "pop %rcx" instruction on BPF JIT epilogue
  bpf: x64: do not emit sub/add 0, %rsp when !stack_depth

 arch/x86/net/bpf_jit_comp.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.20.1

