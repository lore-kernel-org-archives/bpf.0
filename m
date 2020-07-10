Return-Path: <SRS0=293s=AV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E5C433E1
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E0120720
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGJQAw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:00:52 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:35094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726925AbgGJQAv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 12:00:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 79AB018224D66;
        Fri, 10 Jul 2020 16:00:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swim81_190e06826ecf
X-Filterd-Recvd-Size: 2357
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jul 2020 16:00:48 +0000 (UTC)
Message-ID: <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
From:   Joe Perches <joe@perches.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Fri, 10 Jul 2020 09:00:46 -0700
In-Reply-To: <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net>
References: <20200709194257.26904-1-grandmaster@al2klimov.de>
         <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net>
         <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de>
         <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
> On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
> > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
> > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
> > > > Rationale:
> > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
> > > > which has nothing to do with XDP.
[]
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
> > > >   F:    kernel/bpf/cpumap.c
> > > >   F:    kernel/bpf/devmap.c
> > > >   F:    net/core/xdp.c
> > > > -N:    xdp
> > > > -K:    xdp
> > > > +N:    (?:\b|_)xdp(?:\b|_)
> > > > +K:    (?:\b|_)xdp(?:\b|_)
> > > 
> > > Please also include \W to generally match on non-alphanumeric char given you
> > > explicitly want to avoid [a-z0-9] around the term xdp.
> > Aren't \W, ^ and $ already covered by \b?
> 
> Ah, true; it says '\b really means (?:(?<=\w)(?!\w)|(?<!\w)(?=\w))', so all good.
> In case this goes via net or net-next tree:

This N: pattern does not match files like:

	samples/bpf/xdp1_kern.c

and does match files like:

	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c

Should it?


