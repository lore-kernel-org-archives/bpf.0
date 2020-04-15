Return-Path: <SRS0=iiTG=57=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D5C3815B
	for <bpf@archiver.kernel.org>; Wed, 15 Apr 2020 19:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1420768
	for <bpf@archiver.kernel.org>; Wed, 15 Apr 2020 19:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411733AbgDOTHX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44438 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416828AbgDOSgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Apr 2020 14:36:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 61E36128AE82A;
        Wed, 15 Apr 2020 11:35:58 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:35:57 -0700 (PDT)
Message-Id: <20200415.113557.54100582255049813.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kuba@kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-04-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200415125904.22480-1-daniel@iogearbox.net>
References: <20200415125904.22480-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Apr 2020 11:35:58 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 15 Apr 2020 14:59:04 +0200

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
