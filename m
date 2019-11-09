Return-Path: <SRS0=dKcM=ZB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C57C43331
	for <bpf@archiver.kernel.org>; Sat,  9 Nov 2019 20:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6272B20869
	for <bpf@archiver.kernel.org>; Sat,  9 Nov 2019 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfKIU3h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 Nov 2019 15:29:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKIU3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 15:29:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 35B6814769E60;
        Sat,  9 Nov 2019 12:29:36 -0800 (PST)
Date:   Sat, 09 Nov 2019 12:29:17 -0800 (PST)
Message-Id: <20191109.122917.550362329016169460.davem@davemloft.net>
To:     ast@kernel.org
CC:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: net --> net-next merge
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Nov 2019 12:29:36 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Please double check my conflict resoltuion for samples/bpf/Makefile

Thank you.
