Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A62C4332F
	for <bpf@archiver.kernel.org>; Tue, 22 Nov 2022 01:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKVB6q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKVB6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 20:58:43 -0500
Received: from wangsu.com (unknown [180.101.34.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D072FC5B4E;
        Mon, 21 Nov 2022 17:58:41 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltADnLkvOLHxjiGsAAA--.531S2;
        Tue, 22 Nov 2022 09:58:40 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH RESEND bpf 0/4] bpf, sockmap: Fix some issues with using apply_bytes
Date:   Tue, 22 Nov 2022 09:58:25 +0800
Message-Id: <1669082309-2546-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: SyJltADnLkvOLHxjiGsAAA--.531S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1xGrWxtF4rZw1rCryfZwb_yoWxtrXEvr
        W8tr98GrW8ZF18CayY9rZ8AF97Ga1DZrykGF9Iqry2gry8Zrn8Grs5Zr9Yyry8G3yYkr92
        gr1kGrWkJr1jgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch 0001~0003 fixes three issues with using apply_bytes when redirecting.
Patch 0004 adds ingress tests for txmsg with apply_bytes in selftests.

Pengcheng Yang (4):
  bpf, sockmap: Fix repeated calls to sock_put() when msg has more_data
  bpf, sockmap: Fix missing BPF_F_INGRESS flag when using apply_bytes
  bpf, sockmap: Fix data loss caused by using apply_bytes on ingress
    redirect
  selftests/bpf: Add ingress tests for txmsg with apply_bytes

 include/linux/skmsg.h                      |  1 +
 net/core/skmsg.c                           |  1 +
 net/ipv4/tcp_bpf.c                         |  9 +++++++--
 net/tls/tls_sw.c                           |  1 +
 tools/testing/selftests/bpf/test_sockmap.c | 18 ++++++++++++++++++
 5 files changed, 28 insertions(+), 2 deletions(-)

-- 
1.8.3.1

