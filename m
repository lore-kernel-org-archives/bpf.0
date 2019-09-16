Return-Path: <SRS0=t4jm=XL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CDAC49ED7
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B297E2067D
	for <bpf@archiver.kernel.org>; Mon, 16 Sep 2019 14:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbfIPODA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:03:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfIPODA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 10:03:00 -0400
Received: from localhost (80-167-222-154-cable.dk.customer.tdc.net [80.167.222.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C7C73153CA22C;
        Mon, 16 Sep 2019 07:02:58 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:02:57 +0200 (CEST)
Message-Id: <20190916.160257.487731838280905660.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-09-16
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190916102630.14491-1-daniel@iogearbox.net>
References: <20190916102630.14491-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Sep 2019 07:02:59 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 16 Sep 2019 12:26:30 +0200

> The following pull-request contains BPF updates for your *net-next* tree.

Pulled and build testing (in Denmark!), thanks.
