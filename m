Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0003C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFA42083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKPjj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfDKPji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 11:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A43693008CC5;
        Thu, 11 Apr 2019 15:39:37 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B27319C65;
        Thu, 11 Apr 2019 15:39:32 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:39:30 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        brouer@redhat.com
Subject: Re: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
Message-ID: <20190411173930.51fec773@carbon>
In-Reply-To: <CAPhsuW6K+TVaAuD3e6g7oE9zhpBAVx5u3V4NZJgH9E0qM2_ZDg@mail.gmail.com>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
        <155489662793.20826.5533583763088193882.stgit@firesoul>
        <CAPhsuW6K+TVaAuD3e6g7oE9zhpBAVx5u3V4NZJgH9E0qM2_ZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 11 Apr 2019 15:39:38 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Apr 2019 16:34:29 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> > +struct sk_buff *build_skb_around(struct sk_buff *skb,
> > +                                void *data, unsigned int frag_size)
> > +{
> > +       if (unlikely(!skb))
> > +               return NULL;
> > +
> > +       skb = __build_skb_around(skb, data, frag_size);  
> 
> 
> > +
> > +       if (skb && frag_size) {
> > +               skb->head_frag = 1;
> > +               if (page_is_pfmemalloc(virt_to_head_page(data)))
> > +                       skb->pfmemalloc = 1;
> > +       }  
> 
> I didn't find any explanation of this part (head_frag, pfmemalloc).
> Shall we split it out to a separate patch?

No, it belongs here.  This is like/based on the __build_skb() and
build_skb() split, and needed such that __build_skb() can reuse the
code in __build_skb_around().

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
