Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5AC433EF
	for <bpf@archiver.kernel.org>; Wed, 23 Feb 2022 08:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiBWIGS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Feb 2022 03:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiBWIGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 03:06:18 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4157A98F;
        Wed, 23 Feb 2022 00:05:50 -0800 (PST)
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1nMmed-0004ur-K3; Wed, 23 Feb 2022 09:05:43 +0100
Date:   Wed, 23 Feb 2022 09:05:43 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next] net: Correct wrong BH disable in hard-interrupt.
Message-ID: <YhXq18B1yCuSwun7@breakpoint.cc>
References: <Yg05duINKBqvnxUc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg05duINKBqvnxUc@linutronix.de>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022-02-16 18:50:46 [+0100], Sebastian Andrzej Siewior wrote:
> I missed the obvious case where netif_ix() is invoked from hard-IRQ
> context.
> 
> Disabling bottom halves is only needed in process context. This ensures
> that the code remains on the current CPU and that the soft-interrupts
> are processed at local_bh_enable() time.
> In hard- and soft-interrupt context this is already the case and the
> soft-interrupts will be processed once the context is left (at irq-exit
> time).
> 
> Disable bottom halves if neither hard-interrupts nor soft-interrupts are
> disabled. Update the kernel-doc, mention that interrupts must be enabled
> if invoked from process context.
> 
> Fixes: baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch is marked as "Changes Requested" in patchwork. Could someone
please explain?
The USB/dwc3 fallout reported by Marek was addressed in 
   usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
   https://lore.kernel.org/r/Yg/YPejVQH3KkRVd@linutronix.de

and is not a shortcoming in this patch but a problem in dwc3 that was
just noticed.

Sebastian
