Return-Path: <SRS0=giER=YU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2305FCA9EAF
	for <bpf@archiver.kernel.org>; Sun, 27 Oct 2019 05:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE421850
	for <bpf@archiver.kernel.org>; Sun, 27 Oct 2019 05:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfJ0F5r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 27 Oct 2019 01:57:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfJ0F5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Oct 2019 01:57:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C00D714F2D926;
        Sat, 26 Oct 2019 22:57:46 -0700 (PDT)
Date:   Sat, 26 Oct 2019 22:57:43 -0700 (PDT)
Message-Id: <20191026.225743.1612360989264584861.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-10-27
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191026234702.20595-1-daniel@iogearbox.net>
References: <20191026234702.20595-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 26 Oct 2019 22:57:46 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sun, 27 Oct 2019 01:47:02 +0200

> The following pull-request contains BPF updates for your *net-next* tree.

Pulled, thanks Daniel.
