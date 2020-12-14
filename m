Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA6C2BB40
	for <bpf@archiver.kernel.org>; Mon, 14 Dec 2020 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31DC22A99
	for <bpf@archiver.kernel.org>; Mon, 14 Dec 2020 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407986AbgLNPRz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:17:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:6075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407076AbgLNPRs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 10:17:48 -0500
IronPort-SDR: QnHrRcL5ySFmSlcF6phZWrI7QZN+jYxJ0NkKgd9m16vRUVxigM5Nsx2WB7csgfuNbTU8hbMero
 KqD+6L9H6EzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="173951506"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="173951506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 07:17:07 -0800
IronPort-SDR: lNPF00ciK5Gtp944ROTXfleYBCOhzczUlCIRfz5JCfqnQdVnEkuU6rnHnA3BEInFXCjCZwDXB/
 a7Aa4FLjrEnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="333478153"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 07:17:06 -0800
Date:   Mon, 14 Dec 2020 16:07:40 +0100
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, anthony.l.nguyen@intel.com,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH net-next 5/8] ice: move skb pointer from rx_buf to rx_ring
Message-ID: <20201214150740.GA15222@ranger.igk.intel.com>
References: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
 <20201211164956.59628-6-maciej.fijalkowski@intel.com>
 <20201211202315.570b6605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202315.570b6605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 11, 2020 at 08:23:15PM -0800, Jakub Kicinski wrote:
> On Fri, 11 Dec 2020 17:49:53 +0100 Maciej Fijalkowski wrote:
> > @@ -864,14 +865,12 @@ ice_reuse_rx_page(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
> >   * for use by the CPU.
> >   */
> >  static struct ice_rx_buf *
> > -ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
> > -	       const unsigned int size)
> > +ice_get_rx_buf(struct ice_ring *rx_ring, const unsigned int size)
> >  {
> 
> FWIW I think you missed adjusting kdoc here.

How ironic :) sorry for that.
