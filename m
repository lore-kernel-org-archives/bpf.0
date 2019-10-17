Return-Path: <SRS0=+bqE=YK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE078ECE58D
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 22:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FA821D7A
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 22:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438515AbfJQWXf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:23:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43134 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438484AbfJQWXf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 18:23:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A3FD14275773;
        Thu, 17 Oct 2019 15:23:34 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:23:33 -0700 (PDT)
Message-Id: <20191017.152333.1175454458404043095.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     bigeasy@linutronix.de, daniel@iogearbox.net, bpf@vger.kernel.org,
        ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        peterz@infradead.org, williams@redhat.com
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.1910180006110.1869@nanos.tec.linutronix.de>
References: <20191017154021.ndza4la3hntk4d4o@linutronix.de>
        <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910180006110.1869@nanos.tec.linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 15:23:34 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 18 Oct 2019 00:11:38 +0200 (CEST)

> tcpdump and wireshark work perfectly fine on a BPF disabled kernel at least
> in the limited way I am using them.

Yes it works, but with every packet flowing through the system getting
copied into userspace.  This takes us back to 1992 :-)
