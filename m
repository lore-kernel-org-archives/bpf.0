Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A14C77B75
	for <bpf@archiver.kernel.org>; Tue, 18 Apr 2023 05:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDRFBu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRFBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 01:01:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6A44BE;
        Mon, 17 Apr 2023 22:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9kmYCb9yawE8YYNy37ygsAKRKnVXDz2MLuTV4YDF8yM=; b=4GkQQrxYYf1q00fiSJejR4fG+s
        NdgsjovWVQwCOqPOiSi+R3TnFnALLUfI/mM8dkDKzyacJo357IjDsLrZQcP1m/Yr8K1sDw03c3TPI
        qh66gLRqLwNY1rQIg7Pc7JFVoQEXYCqUQVwA9sQ3SUQ/RwOP9i8vcNaRlPdj89vtJgnlB30AZT5ni
        X8QQehmCDfyEGRWkYHhV7By0gc5hSnu3GhnoIbuZS4r9foQ95rjsMf6R/nPN705mA4pHmtBPfLDQU
        /AuAoOAlhsFvbPmCTjQ1bUS3NT5nkdKCtuhefSpYYK2hxJ0/qlZedeKl8kOGx2z3yJIS2v+vBMUcy
        RC++50GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1podTE-000rE6-0k;
        Tue, 18 Apr 2023 05:01:36 +0000
Date:   Mon, 17 Apr 2023 22:01:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZD4kMOym15pFcjq+@infradead.org>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <ZDzKAD2SNe1q/XA6@infradead.org>
 <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
 <20230417115610.7763a87c@kernel.org>
 <20230417115753.7fb64b68@kernel.org>
 <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417195400.482cfe75@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 07:54:00PM -0700, Jakub Kicinski wrote:
> AF_XDP, io_uring, and increasing number of pinned memory / zero copy
> implementations need to do DMA mapping outside the drivers.

You can't just do dma mapping outside the driver, because there are
drivers that do not require DMA mapping at all.  virtio is an example,
but all the classic s390 drivers and some other odd virtualization
ones are others.

> I don't think it's reasonable to be bubbling up custom per-subsystem
> DMA ops into all of them for the sake of virtio.

dma addresses and thus dma mappings are completely driver specific.
Upper layers have no business looking at them.
