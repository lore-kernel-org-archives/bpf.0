Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2415C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904972083E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLPHi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLPHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 11:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2B1C308B24E;
        Fri, 12 Apr 2019 15:07:33 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3C1F1001E7A;
        Fri, 12 Apr 2019 15:07:28 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id CFA95306665E6;
        Fri, 12 Apr 2019 17:07:27 +0200 (CEST)
Subject: [PATCH bpf-next V2 0/4] Bulk optimization for XDP cpumap redirect
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     songliubraving@fb.com,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        ecree@solarflare.com, bpf@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:07:27 +0200
Message-ID: <155508158877.23650.13330504000013024259.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 12 Apr 2019 15:07:38 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset utilize a number of different kernel bulk APIs for optimizing
the performance for the XDP cpumap redirect feature.

Benchmark details are available here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap03-optimizations.org

Performance measurements can be considered micro benchmarks, as they measure
dropping packets at different stages in the network stack.
Summary based on above:

Baseline benchmarks
- baseline-redirect: UdpNoPorts: 3,180,074
- baseline-redirect: iptables-raw drop: 6,193,534

Patch1: bpf: cpumap use ptr_ring_consume_batched
- redirect: UdpNoPorts: 3,327,729
- redirect: iptables-raw drop: 6,321,540

Patch2: net: core: introduce build_skb_around
- redirect: UdpNoPorts: 3,221,303
- redirect: iptables-raw drop: 6,320,066

Patch3: bpf: cpumap do bulk allocation of SKBs
- redirect: UdpNoPorts: 3,290,563
- redirect: iptables-raw drop: 6,650,112

Patch4: bpf: cpumap memory prefetchw optimizations for struct page
- redirect: UdpNoPorts: 3,520,250
- redirect: iptables-raw drop: 7,649,604

In this V2 submission I have chosen drop the SKB-list patch using
netif_receive_skb_list() as it was not showing a performance improvement for
these micro benchmarks.

---

Jesper Dangaard Brouer (4):
      bpf: cpumap use ptr_ring_consume_batched
      net: core: introduce build_skb_around
      bpf: cpumap do bulk allocation of SKBs
      bpf: cpumap memory prefetchw optimizations for struct page


 include/linux/skbuff.h |    2 +
 kernel/bpf/cpumap.c    |   53 +++++++++++++++++++++++++-----------
 net/core/skbuff.c      |   71 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 91 insertions(+), 35 deletions(-)

--
