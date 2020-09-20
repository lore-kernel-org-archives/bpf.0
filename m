Return-Path: <SRS0=RPSo=C5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20986C43465
	for <bpf@archiver.kernel.org>; Sun, 20 Sep 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A3B21789
	for <bpf@archiver.kernel.org>; Sun, 20 Sep 2020 14:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITOp6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 20 Sep 2020 10:45:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44165 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITOp6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 20 Sep 2020 10:45:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9V.p7K_1600613153;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U9V.p7K_1600613153)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Sep 2020 22:45:54 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Subject: [bpf-next 0/3] Using log2 histogram to display the statistics of every softirq execution
Date:   Sun, 20 Sep 2020 22:45:44 +0800
Message-Id: <20200920144547.56771-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The purpose of this series of patches is to provide a way of log2
histogram to display in sample/bpf dir, you can refer to the
patch three to use it.

Xin Hao (3):
  sample/bpf: Avoid repetitive definition of log2 func
  sample/bpf: Add log2 histogram function support
  samples/bpf: Add soft irq execution time statistics

 samples/bpf/Makefile            |  3 ++
 samples/bpf/common.h            | 67 +++++++++++++++++++++++++
 samples/bpf/common_kern.h       | 30 +++++++++++
 samples/bpf/lathist_kern.c      | 25 +---------
 samples/bpf/lwt_len_hist_kern.c | 23 +--------
 samples/bpf/soft_irq_kern.c     | 87 ++++++++++++++++++++++++++++++++
 samples/bpf/soft_irq_user.c     | 88 +++++++++++++++++++++++++++++++++
 samples/bpf/tracex2_kern.c      | 23 +--------
 8 files changed, 278 insertions(+), 68 deletions(-)
 create mode 100644 samples/bpf/common.h
 create mode 100644 samples/bpf/common_kern.h
 create mode 100644 samples/bpf/soft_irq_kern.c
 create mode 100644 samples/bpf/soft_irq_user.c

--
2.28.0
