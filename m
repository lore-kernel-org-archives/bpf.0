Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E51FC74A5B
	for <bpf@archiver.kernel.org>; Thu, 30 Mar 2023 06:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC3GBN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjC3GBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 02:01:12 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6749D8;
        Wed, 29 Mar 2023 23:01:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VezRvjN_1680156065;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VezRvjN_1680156065)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 14:01:06 +0800
Message-ID: <1680156056.4424767-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 16/16] virtio_net: separating the virtio code
Date:   Thu, 30 Mar 2023 14:00:56 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230328092847.91643-17-xuanzhuo@linux.alibaba.com>
 <20230329211552.27efa412@kernel.org>
In-Reply-To: <20230329211552.27efa412@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 29 Mar 2023 21:15:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 Mar 2023 17:28:47 +0800 Xuan Zhuo wrote:
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __VIRTNET_VIRTIO_H__
> > +#define __VIRTNET_VIRTIO_H__
> > +
> > +int virtnet_register_virtio_driver(void);
> > +void virtnet_unregister_virtio_driver(void);
> > +#endif
>
> nit: this header needs to be added in the previous patch,
> otherwise there is a transient build warning there.

Will fix.

Thanks.
