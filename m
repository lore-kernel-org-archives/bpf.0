Return-Path: <SRS0=uMm3=XW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A7C352AB
	for <bpf@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783D6217D9
	for <bpf@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfI0I2h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:28:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57244 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfI0I2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 04:28:36 -0400
Received: from localhost (unknown [65.39.69.237])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D645B14DECD54;
        Fri, 27 Sep 2019 01:28:34 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:28:33 +0200 (CEST)
Message-Id: <20190927.102833.1060603614092107867.davem@davemloft.net>
To:     edumazet@google.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, bpf@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH net] kcm: disable preemption in
 kcm_parse_func_strparser()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190924192934.212317-1-edumazet@google.com>
References: <20190924192934.212317-1-edumazet@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Sep 2019 01:28:36 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2019 12:29:34 -0700

> After commit a2c11b034142 ("kcm: use BPF_PROG_RUN")
> syzbot easily triggers the warning in cant_sleep().
> 
> As explained in commit 6cab5e90ab2b ("bpf: run bpf programs
> with preemption disabled") we need to disable preemption before
> running bpf programs.
 ...
> Fixes: a2c11b034142 ("kcm: use BPF_PROG_RUN")
> Fixes: 6cab5e90ab2b ("bpf: run bpf programs with preemption disabled")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Applied.
