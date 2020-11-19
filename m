Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D895CC63798
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 01:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F52E246EB
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 01:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKSB2r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:28:47 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37188 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgKSB2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Nov 2020 20:28:47 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kfYkM-007q6N-QM; Thu, 19 Nov 2020 02:28:26 +0100
Date:   Thu, 19 Nov 2020 02:28:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, openbmc@lists.ozlabs.org, taoren@fb.com,
        mikechoi@fb.com
Subject: Re: [PATCH v2 0/2] hwmon: (max127) Add Maxim MAX127 hardware
 monitoring
Message-ID: <20201119012826.GP1804098@lunn.ch>
References: <20201118230929.18147-1-rentao.bupt@gmail.com>
 <20201118232719.GI1853236@lunn.ch>
 <20201118234252.GA18681@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118234252.GA18681@taoren-ubuntu-R90MNF91>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 18, 2020 at 03:42:53PM -0800, Tao Ren wrote:
> On Thu, Nov 19, 2020 at 12:27:19AM +0100, Andrew Lunn wrote:
> > On Wed, Nov 18, 2020 at 03:09:27PM -0800, rentao.bupt@gmail.com wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > The patch series adds hardware monitoring driver for the Maxim MAX127
> > > chip.
> > 
> > Hi Tao
> > 
> > Why are using sending a hwmon driver to the networking mailing list?
> > 
> >     Andrew
> 
> Hi Andrew,
> 
> I added netdev because the mailing list is included in "get_maintainer.pl
> Documentation/hwmon/index.rst" output. Is it the right command to find
> reviewers? Could you please suggest? Thank you.

Hi Tae

What you are doing is correct. I suspected it was a get_maintainers
problem. Now we know this, we can figure out why it is adding all
these extra addresses which make no sense. Maybe a bug in the
MAINTAINERS file?

       Andrew
