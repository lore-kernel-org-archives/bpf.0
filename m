Return-Path: <SRS0=rg0W=2C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F91DC43603
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 04:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8522B48
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 04:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfLLEOR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:14:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35304 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfLLEOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 23:14:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 31C2414D85199;
        Wed, 11 Dec 2019 20:14:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 20:14:13 -0800 (PST)
Message-Id: <20191211.201413.117375063245631923.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf 2019-12-11
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191211233439.1535862-1-ast@kernel.org>
References: <20191211233439.1535862-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Dec 2019 20:14:17 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Wed, 11 Dec 2019 15:34:39 -0800

> The following pull-request contains BPF updates for your *net* tree.

Pulled, thanks Alexei.
