Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C0C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C33820820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfDJLnh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbfDJLnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F56E83F4C;
        Wed, 10 Apr 2019 11:43:37 +0000 (UTC)
Received: from firesoul.localdomain (ovpn-200-48.brq.redhat.com [10.40.200.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF75461994;
        Wed, 10 Apr 2019 11:43:33 +0000 (UTC)
Received: from [10.10.10.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id BC1D631256FC5;
        Wed, 10 Apr 2019 13:43:32 +0200 (CEST)
Subject: [PATCH bpf-next 0/5] Bulk optimization for XDP cpumap redirect
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf@vger.kernel.org,
        Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Wed, 10 Apr 2019 13:43:32 +0200
Message-ID: <155489659290.20826.1108770347511292618.stgit@firesoul>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 10 Apr 2019 11:43:37 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset utilize a number of different kernel bulk APIs for optimizing
the performance for the XDP cpumap redirect feature.

Patch-1: ptr_ring batch consume
Patch-2: Send SKB-lists to network stack
Patch-3: Introduce SKB helper to alloc SKB outside net-core
Patch-4: kmem_cache bulk alloc of SKBs
Patch-5: Prefetch struct page to solve CPU stall

---

Jesper Dangaard Brouer (5):
      bpf: cpumap use ptr_ring_consume_batched
      bpf: cpumap use netif_receive_skb_list
      net: core: introduce build_skb_around
      bpf: cpumap do bulk allocation of SKBs
      bpf: cpumap memory prefetchw optimizations for struct page


 include/linux/netdevice.h |    1 +
 include/linux/skbuff.h    |    2 +
 kernel/bpf/cpumap.c       |   66 +++++++++++++++++++++++++++++-------------
 net/core/dev.c            |   18 +++++++++++
 net/core/skbuff.c         |   71 +++++++++++++++++++++++++++++++++------------
 5 files changed, 118 insertions(+), 40 deletions(-)

--
