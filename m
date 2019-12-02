Return-Path: <SRS0=WYMa=ZY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38047C432C0
	for <bpf@archiver.kernel.org>; Mon,  2 Dec 2019 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1054D20848
	for <bpf@archiver.kernel.org>; Mon,  2 Dec 2019 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfLBSvQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:51:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39204 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfLBSvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Dec 2019 13:51:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9AE6B14C70259;
        Mon,  2 Dec 2019 10:51:15 -0800 (PST)
Date:   Mon, 02 Dec 2019 10:51:12 -0800 (PST)
Message-Id: <20191202.105112.2302274946526994766.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf 2019-12-02
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191202101216.9511-1-daniel@iogearbox.net>
References: <20191202101216.9511-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Dec 2019 10:51:15 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon,  2 Dec 2019 11:12:16 +0100

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Daniel.
