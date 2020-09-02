Return-Path: <SRS0=GkhW=CL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7DC433E2
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E6A207EA
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599073907;
	bh=WnSnslkA0WY55wziATC806B4vzwesvF3SmUSGozVyp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fyfj00oRck1Oigx/hD5c3b3BO2heamLnMYqpS6/Yu8hWYi9WL8jhUCxYkGghlXMZf
	 FsZ6/K5pUc+MK+jXsZpFRBHkQGm3CwH3bfSESqjbxmA2+4PlMtAUAyrFBg2zp5uG1M
	 z1YJDpEI9D41gI79dFsYkuAYNDAkjWZpL8UAaWYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBTLr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIBTLr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 15:11:47 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6070920758;
        Wed,  2 Sep 2020 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599073906;
        bh=WnSnslkA0WY55wziATC806B4vzwesvF3SmUSGozVyp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjELJqRH1dtygQUKHtxh2PN72TkvUYg/RLWeAFbJc/r1VFnEguEgCY0f9pXAt8/OV
         lf76OXWhqnUdJbnmoY139V92IJBIWWsEU2vMS1YtG+6HGzjVSAOp4tW0NSAhyobU8B
         f6o0zJEkYs4dfPLpfs2y/Ru52YvpB8Nxb1Ys/mzs=
Date:   Wed, 2 Sep 2020 14:17:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xsk: Fix null check on error return path
Message-ID: <20200902191757.GD31464@embeddedor>
References: <20200902150750.GA7257@embeddedor>
 <9b7e36c3-0532-245c-763a-8f4e7e36b358@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7e36c3-0532-245c-763a-8f4e7e36b358@iogearbox.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 02, 2020 at 08:33:41PM +0200, Daniel Borkmann wrote:
> On 9/2/20 5:07 PM, Gustavo A. R. Silva wrote:
> > Currently, dma_map is being checked, when the right object identifier
> > to be null-checked is dma_map->dma_pages, instead.
> > 
> > Fix this by null-checking dma_map->dma_pages.
> > 
> > Addresses-Coverity-ID: 1496811 ("Logically dead code")
> > Fixes: 921b68692abb ("xsk: Enable sharing of dma mappings")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thanks!

Thanks, Daniel. :)

--
Gustavo
