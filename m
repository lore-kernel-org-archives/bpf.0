Return-Path: <SRS0=LLXA=UM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB65C31E49
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2A2082C
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfFMPYc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731696AbfFMMOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 08:14:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CED2301E111;
        Thu, 13 Jun 2019 12:14:01 +0000 (UTC)
Received: from carbon (ovpn-200-32.brq.redhat.com [10.40.200.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3E167C56F;
        Thu, 13 Jun 2019 12:13:52 +0000 (UTC)
Date:   Thu, 13 Jun 2019 14:13:51 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 bpf-next 2/2] veth: Support bulk XDP_TX
Message-ID: <20190613141351.77747fc1@carbon>
In-Reply-To: <20190613093959.2796-3-toshiaki.makita1@gmail.com>
References: <20190613093959.2796-1-toshiaki.makita1@gmail.com>
        <20190613093959.2796-3-toshiaki.makita1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 12:14:01 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 13 Jun 2019 18:39:59 +0900
Toshiaki Makita <toshiaki.makita1@gmail.com> wrote:

> XDP_TX is similar to XDP_REDIRECT as it essentially redirects packets to
> the device itself. XDP_REDIRECT has bulk transmit mechanism to avoid the
> heavy cost of indirect call but it also reduces lock acquisition on the
> destination device that needs locks like veth and tun.
> 
> XDP_TX does not use indirect calls but drivers which require locks can
> benefit from the bulk transmit for XDP_TX as well.
> 
> This patch introduces bulk transmit mechanism in veth using bulk queue
> on stack, and improves XDP_TX performance by about 9%.
> 
> Here are single-core/single-flow XDP_TX test results. CPU consumptions
> are taken from "perf report --no-child".
> 
> - Before:
> 
>   7.26 Mpps
> 
>   _raw_spin_lock  7.83%
>   veth_xdp_xmit  12.23%
> 
> - After:
> 
>   7.94 Mpps
> 
>   _raw_spin_lock  1.08%
>   veth_xdp_xmit   6.10%
> 
> v2:
> - Use stack for bulk queue instead of a global variable.
> 
> Signed-off-by: Toshiaki Makita <toshiaki.makita1@gmail.com>
> ---
>  drivers/net/veth.c | 60 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 12 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
