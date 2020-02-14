Return-Path: <SRS0=yg+S=4C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD19CC2BA83
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11E8206D7
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbgBNRxH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:53:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55832 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbgBNRxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 12:53:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E44AC15CE62F5;
        Fri, 14 Feb 2020 09:53:03 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:53:03 -0800 (PST)
Message-Id: <20200214.095303.341559462549043464.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bigeasy@linutronix.de, peterz@infradead.org, williams@redhat.com,
        rostedt@goodmis.org, juri.lelli@redhat.com, mingo@kernel.org
Subject: Re: [RFC patch 00/19] bpf: Make BPF and PREEMPT_RT co-exist
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200214133917.304937432@linutronix.de>
References: <20200214133917.304937432@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Feb 2020 09:53:04 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 14 Feb 2020 14:39:17 +0100

> This is a follow up to the initial patch series which David posted a
> while ago:
> 
>  https://lore.kernel.org/bpf/20191207.160357.828344895192682546.davem@davemloft.net/
> 
> which was (while non-functional on RT) a good starting point for further
> investigations.

This looks really good after a cursory review, thanks for doing this week.

I was personally unaware of the pre-allocation rules for MAPs used by
tracing et al.  And that definitely shapes how this should be handled.
