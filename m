Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9308C433FE
	for <bpf@archiver.kernel.org>; Sat, 12 Dec 2020 04:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5F723158
	for <bpf@archiver.kernel.org>; Sat, 12 Dec 2020 04:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbgLLEYJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Dec 2020 23:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbgLLEX5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 23:23:57 -0500
Date:   Fri, 11 Dec 2020 20:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607746996;
        bh=leCvGZerFpKuIBp7BGGLuawXTLX30TAetAu1xn+PdkQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=AAZU+S5xH7Kh9WhNSErw6FXBpSh1emMiWiI9J4zNiH9U7KMp/H3YpmUzPw1AzlHqQ
         A2lbBfZhOpXkAxF8Ow5zE3F4SJsb2Tkpu/gffJP7BKt5JIriJbaY8BmqAPWZmCl/v8
         vxx91hC8pQUewq7c9u1JGhtdAc5tObwq+ouu00/VNxUM6+SlwFGRZtezljP+gl5D9l
         4GdNaMSIvGg02b/rkstp7zrDh5trElGxxmtRvGrcPQKdB0ay9EbkDC3xGTzvDA6dKb
         TpRvksOD7aDzARqo1G7jPcwKbqQUsq8WpSUhegSGGPiWlySPscrjNVxkjUjgutGJsP
         XbL495A8HWkDw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, anthony.l.nguyen@intel.com,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
Subject: Re: [PATCH net-next 5/8] ice: move skb pointer from rx_buf to
 rx_ring
Message-ID: <20201211202315.570b6605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201211164956.59628-6-maciej.fijalkowski@intel.com>
References: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
        <20201211164956.59628-6-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Dec 2020 17:49:53 +0100 Maciej Fijalkowski wrote:
> @@ -864,14 +865,12 @@ ice_reuse_rx_page(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
>   * for use by the CPU.
>   */
>  static struct ice_rx_buf *
> -ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
> -	       const unsigned int size)
> +ice_get_rx_buf(struct ice_ring *rx_ring, const unsigned int size)
>  {

FWIW I think you missed adjusting kdoc here.
