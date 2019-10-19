Return-Path: <SRS0=+UrM=YM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A8ECA9EA0
	for <bpf@archiver.kernel.org>; Sat, 19 Oct 2019 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D291D222C5
	for <bpf@archiver.kernel.org>; Sat, 19 Oct 2019 00:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfJSAow (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Oct 2019 20:44:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfJSAow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 20:44:52 -0400
Received: from localhost (unknown [64.79.112.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F50A1400E1F7;
        Fri, 18 Oct 2019 17:44:49 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:44:46 -0700 (PDT)
Message-Id: <20191018.174446.40623500298147190.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     toke@redhat.com, daniel@iogearbox.net, ast@fb.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, kubakici@wp.pl, yhs@fb.com
Subject: Re: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost
 calculation for 32-bit builds
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAADnVQKDaMAVT6UxGy8w+CPUmzvgVWAjXmHexiz09yZJ8CbAeQ@mail.gmail.com>
References: <20191017105702.2807093-1-toke@redhat.com>
        <CAADnVQKDaMAVT6UxGy8w+CPUmzvgVWAjXmHexiz09yZJ8CbAeQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Oct 2019 17:44:49 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 Oct 2019 16:25:24 -0700

> gmail delivery lags by a day :(

Sorry, I'm working on that.
