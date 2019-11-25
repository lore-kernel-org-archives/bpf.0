Return-Path: <SRS0=POGc=ZR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF7C432C0
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3320722
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYGGj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:06:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYGGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 01:06:39 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BFEAF14C7C12A;
        Sun, 24 Nov 2019 22:06:38 -0800 (PST)
Date:   Sun, 24 Nov 2019 22:06:38 -0800 (PST)
Message-Id: <20191124.220638.1600390453230278214.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2019-11-24
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191125053412.1172278-1-ast@kernel.org>
References: <20191125053412.1172278-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Nov 2019 22:06:39 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Sun, 24 Nov 2019 21:34:12 -0800

> The following pull-request contains BPF updates for your *net-next*
> tree.

Pulled, thanks Alexei.
