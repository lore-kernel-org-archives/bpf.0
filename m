Return-Path: <SRS0=DuKs=AK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED78C433E0
	for <bpf@archiver.kernel.org>; Mon, 29 Jun 2020 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC75D206E2
	for <bpf@archiver.kernel.org>; Mon, 29 Jun 2020 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgF2TLj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:11:39 -0400
Received: from verein.lst.de ([213.95.11.211]:59074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgF2TLg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:11:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 590416736F; Mon, 29 Jun 2020 16:22:25 +0200 (CEST)
Date:   Mon, 29 Jun 2020 16:22:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: add an API to check if a streamming mapping needs sync calls
Message-ID: <20200629142225.GA22336@lst.de>
References: <20200629130359.2690853-1-hch@lst.de> <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 03:39:01PM +0200, Björn Töpel wrote:
> On 2020-06-29 15:03, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series lifts the somewhat hacky checks in the XSK code if a DMA
>> streaming mapping needs dma_sync_single_for_{device,cpu} calls to the
>> DMA API.
>>
>
> Thanks a lot for working on, and fixing this, Christoph!
>
> I took the series for a spin, and there are (obviously) no performance
> regressions.
>
> Would the patches go through the net/bpf trees or somewhere else?

either the net tree or (my) dma-mapping tree would be fine with me.
