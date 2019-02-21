Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBABC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 04:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3A2086C
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 04:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfBUEZh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:25:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfBUEZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Feb 2019 23:25:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A420112DE57F5;
        Wed, 20 Feb 2019 20:25:36 -0800 (PST)
Date:   Wed, 20 Feb 2019 20:25:35 -0800 (PST)
Message-Id: <20190220.202535.247560546508777927.davem@davemloft.net>
To:     lsf-pc@lists.linux-foundation.org
CC:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: LSFMM BPF Proposal: eBPF, A Wholistic Approach
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Feb 2019 20:25:36 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


eBPF, A Wholistic Approach:

eBPF has grown by leaps and bounds over the past several years.  The
growth of eBPF is only rivaled by technologies like Kubernetes and the
Go language.

What started as a small set of application points (XDP, cls_bpf, basic
tracing) has now expanded into just about every single realm of the
kernel.

This discussion will cover:

1) Where we started.  What eBPF look like at the beginning, what were
   it's initial application points like, and how did people use it.

2) Where are we now.  We will take a look at the plethora of areas
   that eBPF can be applied to.  In particular we will look at how
   such facilities can be used as individual elements, grouped
   together to solve a specific domain problem.

3) But, we have to go somewhere.  All of these existing methods, and
   future ones, must be tied together neatly to maximize the developer
   and DevOPS experience.  What kinds of things are fundamentally
   necessary to achieve this?

eBPF is and will be a tool for the masses to customize and control
their systems however they want, and with whatever policies they see
fit.  It is a technology that has truly relinquished control from
system software engineers over to the users, where it belongs.
