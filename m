Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCCCC4332F
	for <bpf@archiver.kernel.org>; Sat,  5 Nov 2022 00:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKEAR2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEAR1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 20:17:27 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76D222BF6;
        Fri,  4 Nov 2022 17:17:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667607443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H5uIl72QdPBXVe8yuF7QEshKt+zvtto6PscaB3KBuJ0=;
        b=josogeB8Wx43dge4QprDSrNq2Qr0h5Cmv8a7hLLpBJ99FW1mdek/d/NeEbT4nGttaKNj6l
        ykhtWmeVxF64or/s+tGwoqpJEXpwtHlYZ+ARyq5ZYIiyA0XECY3boXDQgphWTwBPVTXLjU
        fDG9RxtyhMK+Wvgc8jYdREna5nQHTqA=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        netdev@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] bpf: Add hwtstamp field for the sockops prog
Date:   Fri,  4 Nov 2022 17:17:10 -0700
Message-Id: <20221105001713.1347122-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf-tc prog has already been able to access the
skb_hwtstamps(skb)->hwtstamp.  This set extends the same hwtstamp
access to the sockops prog.

Martin KaFai Lau (3):
  bpf: Add hwtstamp field for the sockops prog
  selftests/bpf: Fix incorrect ASSERT in the tcp_hdr_options test
  selftests/bpf: Test skops->skb_hwtstamp

 include/uapi/linux/bpf.h                      |  1 +
 net/core/filter.c                             | 39 +++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/tcp_hdr_options.c          |  6 ++-
 .../bpf/progs/test_misc_tcp_hdr_options.c     |  4 ++
 5 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.30.2

