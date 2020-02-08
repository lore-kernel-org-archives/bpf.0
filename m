Return-Path: <SRS0=/2zk=34=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6044C35250
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A139C21741
	for <bpf@archiver.kernel.org>; Sat,  8 Feb 2020 14:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBHOBi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:01:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgBHOBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Feb 2020 09:01:38 -0500
Received: from localhost (dhcp-077-249-119-090.chello.nl [77.249.119.90])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0AC8614DD3D91;
        Sat,  8 Feb 2020 06:01:34 -0800 (PST)
Date:   Sat, 08 Feb 2020 15:01:32 +0100 (CET)
Message-Id: <20200208.150132.796682216976769959.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kuba@kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2020-02-07
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200207225605.19411-1-daniel@iogearbox.net>
References: <20200207225605.19411-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Feb 2020 06:01:37 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri,  7 Feb 2020 23:56:05 +0100

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
