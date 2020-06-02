Return-Path: <SRS0=Pto2=7P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1073C433DF
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2CF205CB
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgFBWsI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgFBWsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 18:48:08 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22888C08C5C0;
        Tue,  2 Jun 2020 15:48:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E289127813A2;
        Tue,  2 Jun 2020 15:48:07 -0700 (PDT)
Date:   Tue, 02 Jun 2020 15:48:06 -0700 (PDT)
Message-Id: <20200602.154806.1896300280757442947.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kuba@kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2020-06-02
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200602204051.29623-1-daniel@iogearbox.net>
References: <20200602204051.29623-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Jun 2020 15:48:07 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue,  2 Jun 2020 22:40:51 +0200

> The following pull-request contains BPF _fixes-only_ for your
> *net-next* tree.

Pulled, thanks Daniel.
