Return-Path: <SRS0=6yca=Z6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75484C43603
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 23:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A28205F4
	for <bpf@archiver.kernel.org>; Sun,  8 Dec 2019 23:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfLHXRM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:17:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53058 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfLHXRM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Dec 2019 18:17:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2FB0915397947;
        Sun,  8 Dec 2019 15:17:12 -0800 (PST)
Date:   Sun, 08 Dec 2019 15:17:11 -0800 (PST)
Message-Id: <20191208.151711.2227834913032509828.davem@davemloft.net>
To:     netdev@vger.kernel.org
CC:     bpf@vger.kernel.org
Subject: net-next is OPEN...
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 08 Dec 2019 15:17:12 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


We're back online:

	http://vger.kernel.org/~davem/net-next.html
