Return-Path: <SRS0=9j6j=Y6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B4C5DF60
	for <bpf@archiver.kernel.org>; Wed,  6 Nov 2019 01:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B579222C2
	for <bpf@archiver.kernel.org>; Wed,  6 Nov 2019 01:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfKFBin (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:38:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41644 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfKFBin (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Nov 2019 20:38:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EBB7E150F6634;
        Tue,  5 Nov 2019 17:38:42 -0800 (PST)
Date:   Tue, 05 Nov 2019 17:38:38 -0800 (PST)
Message-Id: <20191105.173838.1188775602400029485.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-11-02
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191102012706.31533-1-daniel@iogearbox.net>
References: <20191102012706.31533-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Nov 2019 17:38:43 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat,  2 Nov 2019 02:27:06 +0100

> The following pull-request contains BPF updates for your *net* tree.

Pulled and build testing, thanks Daniel.
