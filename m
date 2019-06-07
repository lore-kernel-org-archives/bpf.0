Return-Path: <SRS0=PZ8U=UG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0BC2BCA1
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478362083D
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfFGVs6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:48:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46540 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfFGVs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 17:48:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62A30150673BE;
        Fri,  7 Jun 2019 14:48:57 -0700 (PDT)
Date:   Fri, 07 Jun 2019 14:48:54 -0700 (PDT)
Message-Id: <20190607.144854.30369881318107454.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-06-07
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190607211918.23744-1-daniel@iogearbox.net>
References: <20190607211918.23744-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Jun 2019 14:48:57 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri,  7 Jun 2019 23:19:18 +0200

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
