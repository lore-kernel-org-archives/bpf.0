Return-Path: <SRS0=293s=AV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CDC433E4
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 18:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105CE2078B
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGJSmO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:42:14 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:46638 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbgGJSmO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 14:42:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 25EAB18224D98;
        Fri, 10 Jul 2020 18:42:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer53_1103c9226ed0
X-Filterd-Recvd-Size: 3791
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jul 2020 18:42:10 +0000 (UTC)
Message-ID: <a91354960fc97437bd872fa22a2ce1c60bda3e25.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Fri, 10 Jul 2020 11:42:08 -0700
In-Reply-To: <458f6e74-b547-299a-4255-4c1e20cdba1b@al2klimov.de>
References: <20200709194257.26904-1-grandmaster@al2klimov.de>
         <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net>
         <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de>
         <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net>
         <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
         <875zavjqnj.fsf@toke.dk>
         <458f6e74-b547-299a-4255-4c1e20cdba1b@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-07-10 at 20:18 +0200, Alexander A. Klimov wrote:
> 
> Am 10.07.20 um 18:12 schrieb Toke Høiland-Jørgensen:
> > Joe Perches <joe@perches.com> writes:
> > 
> > > On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
> > > > On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
> > > > > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
> > > > > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
> > > > > > > Rationale:
> > > > > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
> > > > > > > which has nothing to do with XDP.
> > > []
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > > > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
> > > > > > >    F:    kernel/bpf/cpumap.c
> > > > > > >    F:    kernel/bpf/devmap.c
> > > > > > >    F:    net/core/xdp.c
> > > > > > > -N:    xdp
> > > > > > > -K:    xdp
> > > > > > > +N:    (?:\b|_)xdp(?:\b|_)
> > > > > > > +K:    (?:\b|_)xdp(?:\b|_)
> > > > > > 
> > > > > > Please also include \W to generally match on non-alphanumeric char given you
> > > > > > explicitly want to avoid [a-z0-9] around the term xdp.
> > > > > Aren't \W, ^ and $ already covered by \b?
> > > > 
> > > > Ah, true; it says '\b really means (?:(?<=\w)(?!\w)|(?<!\w)(?=\w))', so all good.
> > > > In case this goes via net or net-next tree:
> > > 
> > > This N: pattern does not match files like:
> > > 
> > > 	samples/bpf/xdp1_kern.c
> > > 
> > > and does match files like:
> > > 
> > > 	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > > 
> > > Should it?
> > 
> > I think the idea is that it should match both?
> In *your* opinion: Which of these shall it (not) match?

Dunno, but it doesn't match these files.
The first 5 are good, the rest probably should.

$ git ls-files | grep xdp | grep -v -P '(?:\b|_)xdp(?:\b|_)'
Documentation/hwmon/xdpe12284.rst
arch/arm/mach-ixp4xx/ixdp425-pci.c
arch/arm/mach-ixp4xx/ixdp425-setup.c
arch/arm/mach-ixp4xx/ixdpg425-pci.c
drivers/hwmon/pmbus/xdpe12284.c
samples/bpf/xdp1_kern.c
samples/bpf/xdp1_user.c
samples/bpf/xdp2_kern.c
samples/bpf/xdp2skb_meta.sh
samples/bpf/xdp2skb_meta_kern.c
samples/bpf/xdpsock.h
samples/bpf/xdpsock_kern.c
samples/bpf/xdpsock_user.c
tools/testing/selftests/bpf/progs/xdping_kern.c
tools/testing/selftests/bpf/test_xdping.sh
tools/testing/selftests/bpf/xdping.c
tools/testing/selftests/bpf/xdping.h


