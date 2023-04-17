Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF781C77B61
	for <bpf@archiver.kernel.org>; Mon, 17 Apr 2023 06:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDQGAf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 02:00:34 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11B2D69;
        Sun, 16 Apr 2023 23:00:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VgDbJGf_1681711226;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VgDbJGf_1681711226)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 14:00:27 +0800
Message-ID: <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date:   Mon, 17 Apr 2023 13:58:01 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     netdev@vger.kernel.org,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <ZDzKAD2SNe1q/XA6@infradead.org>
In-Reply-To: <ZDzKAD2SNe1q/XA6@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 16 Apr 2023 21:24:32 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Apr 17, 2023 at 11:27:50AM +0800, Xuan Zhuo wrote:
> > The purpose of this patch is to allow driver pass the own dma_ops to
> > xsk.
>
> Drivers have no business passing around dma_ops, or even knowing about
> them.


May misunderstand, here the "dma_ops" is not the "dma_ops" of DMA API.

I mean the callbacks for xsk to do dma.

Maybe, I should rename it in the next version.

Thanks.


