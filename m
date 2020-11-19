Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB69C388F9
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE99622248
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 22:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgKSWQY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:16:24 -0500
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:40716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgKSWQY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Nov 2020 17:16:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E65F5100E7B40;
        Thu, 19 Nov 2020 22:16:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sense04_4005a0927346
X-Filterd-Recvd-Size: 2283
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Nov 2020 22:16:21 +0000 (UTC)
Message-ID: <8eef085f2b4d565463d5251a4868c7aaa19bf6ab.camel@perches.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Update XDP and AF_XDP entries
From:   Joe Perches <joe@perches.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Date:   Thu, 19 Nov 2020 14:16:20 -0800
In-Reply-To: <20201119215012.57d39102@carbon>
References: <160580680009.2806072.11680148233715741983.stgit@firesoul>
         <20201119100210.08374826@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
         <20201119215012.57d39102@carbon>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-11-19 at 21:50 +0100, Jesper Dangaard Brouer wrote:
> On Thu, 19 Nov 2020 10:02:10 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Thu, 19 Nov 2020 18:26:40 +0100 Jesper Dangaard Brouer wrote:
> > > Getting too many false positive matches with current use
> > > of the content regex K: and file regex N: patterns.
> > > 
> > > This patch drops file match N: and makes K: more restricted.
> > > Some more normal F: file wildcards are added.
> > > 
> > > Notice that AF_XDP forgot to some F: files that is also
> > > updated in this patch.
> > > 
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>  
> > 
> > Ah! Sorry, I missed that you sent this before replying to Joe.
> > 
> > Would you mind respining with his regex?
> 
> Sure, I just send it... with your adjusted '(\b|_)xdp(\b|_)' regex, as
> it seems to do the same thing (and it works with egrep).

The regexes in MAINTAINERS are perl not egrep and using (\b|_)
creates unnecessary capture groups.

It _really_ should be (?:\b|_)xdp(?:\b|_)

 


