Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49CC43334
	for <bpf@archiver.kernel.org>; Thu, 23 Jun 2022 00:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiFWAfV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Jun 2022 20:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244426AbiFWAfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60AB36E1A;
        Wed, 22 Jun 2022 17:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A21EEB8216C;
        Thu, 23 Jun 2022 00:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B09C34114;
        Thu, 23 Jun 2022 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655944518;
        bh=ltJF/bFJ8MSQB0vrtLVAFKs9mVw7O+vpttDAcGGCCEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n8iUpMZeTqXg6WU0FNs20DPVnxVSWGQUolUlQFpSaEBcF2gvLBjokCakKLWuJd9ZB
         yoyTOKMWNfD8jRF211bhNjtqjeUPPtgPsNEc5g3n6NqACzlPRA4a0rbIEmhjLT/Bbu
         PY1AAr4G+xq26T5Y8X6Dnfwpfy6910oH5lindRugo8L+fdYCSmhL8yeRWM29cLhVRD
         r+NebPoF278C8zy3CTyRp59U4aAchvKCjjMG2ObbP0AGiZ5LJokHLY7tFdyVc1W7U2
         0VW67QvamW06pGVvfsJxdT9H+VIzSHcUNyG/8a2UJR55k6ccB9nUyrqrS+HwfPqNNs
         1qtMUCH7rr3aA==
Date:   Wed, 22 Jun 2022 17:35:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next] i40e: xsk: read the XDP program once per NAPI
Message-ID: <20220622173516.2c38e035@kernel.org>
In-Reply-To: <20220622091447.243101-1-ciara.loftus@intel.com>
References: <20220622091447.243101-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jun 2022 09:14:47 +0000 Ciara Loftus wrote:
> Similar to how it's done in the ice driver since 'eb087cd82864 ("ice:
> propagate xdp_ring onto rx_ring")', read the XDP program once per NAPI
> instead of once per descriptor cleaned. I measured an improvement in
> throughput of 2% for the AF_XDP xdpsock l2fwd benchmark in busy polling
> mode on my platform.

drivers/net/ethernet/intel/i40e/i40e_xsk.c:151: warning: Function parameter or member 'xdp_prog' not described in 'i40e_run_xdp_zc'
