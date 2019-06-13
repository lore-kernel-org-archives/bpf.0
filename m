Return-Path: <SRS0=LLXA=UM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF1AC31E45
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD38220B7C
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 15:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfFMPZG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731623AbfFMML7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 08:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAB8030C34C5;
        Thu, 13 Jun 2019 12:11:58 +0000 (UTC)
Received: from carbon (ovpn-200-32.brq.redhat.com [10.40.200.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B88051C66;
        Thu, 13 Jun 2019 12:11:48 +0000 (UTC)
Date:   Thu, 13 Jun 2019 14:11:46 +0200
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
Subject: Re: [PATCH v3 bpf-next 1/2] xdp: Add tracepoint for bulk XDP_TX
Message-ID: <20190613141146.6901a03e@carbon>
In-Reply-To: <20190613093959.2796-2-toshiaki.makita1@gmail.com>
References: <20190613093959.2796-1-toshiaki.makita1@gmail.com>
        <20190613093959.2796-2-toshiaki.makita1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Jun 2019 12:11:59 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 13 Jun 2019 18:39:58 +0900
Toshiaki Makita <toshiaki.makita1@gmail.com> wrote:

> This is introduced for admins to check what is happening on XDP_TX when
> bulk XDP_TX is in use, which will be first introduced in veth in next
> commit.
> 
> v3:
> - Add act field to be in line with other XDP tracepoints.

Thanks

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
