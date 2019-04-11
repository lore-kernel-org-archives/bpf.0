Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEDAC282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8941D2084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDKLRy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDKLRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 07:17:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6724A307D966;
        Thu, 11 Apr 2019 11:17:54 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6232660BF7;
        Thu, 11 Apr 2019 11:17:49 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:17:47 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
        Toke =?UTF-8?B?SMO4aWxhbmQt?= =?UTF-8?B?SsO4cmdlbnNlbg==?= 
        <toke@toke.dk>, brouer@redhat.com
Subject: Re: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
Message-ID: <20190411131747.7b40572e@carbon>
In-Reply-To: <20190411053303.GA1416@apalos>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
        <155489662793.20826.5533583763088193882.stgit@firesoul>
        <20190411053303.GA1416@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 11 Apr 2019 11:17:54 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Apr 2019 08:33:03 +0300
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> > +/**
> > + * build_skb_around - build a network buffer around provided skb
> > + * @skb: sk_buff provide by caller, must be memset cleared
> > + * @data: data buffer provided by caller
> > + * @frag_size: size of data, or 0 if head was kmalloced
> > + */
> > +struct sk_buff *build_skb_around(struct sk_buff *skb,
> > +				 void *data, unsigned int frag_size)
> > +{
> > +	if (unlikely(!skb))  
>
> Maybe add a warning here, indicating the buffer *must* be there before calling
> this?

No. I actually use this !skb in next patch. Which only happens in case
memory allocation kmem_cache_alloc_bulk() fails.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
