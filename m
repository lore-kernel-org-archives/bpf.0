Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C1C433EF
	for <bpf@archiver.kernel.org>; Thu, 16 Jun 2022 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiFPQsx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378330AbiFPQs0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 12:48:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B1E248DE;
        Thu, 16 Jun 2022 09:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23537B824F7;
        Thu, 16 Jun 2022 16:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B62C34114;
        Thu, 16 Jun 2022 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655398061;
        bh=7nRK9NwCsao8DUBalG+dGxe3jZ+j/0GGXop/G1tz56A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahdsv3GLzNciC67IgzQVGykjxise7wGwOuI3SlXRle+7JrkvhEqi2ieNZLvAi/fpZ
         aGfC/gfD3uD5AKfF1/LvmKqFx3KDzhiYmNzXtUeRq5mvTIaarUReA8NFunm9+LKopV
         a2aM4vk/S2suVWsFOsyARoD4aK2e14gY5HgtWiLgKkl+5gA23CAv6LTJo6TrWmcGP+
         SyUDMCrlMglBfPQnIPHzv5kdNJ3FS+FDehFY9aXxLODVbbjFOQpAmIJw7p4jOE/E6d
         XIN8bO81m8r2fHitSK31PxUZYCKU34CGi4TIeaNCLmQuIBpPcCr4BFDxUHJl0U5xfe
         YxGO9WWDvwXrg==
Date:   Thu, 16 Jun 2022 09:47:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn@kernel.org, Alexandr Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v2 bpf-next 01/10] ice: allow toggling loopback mode via
 ndo_set_features callback
Message-ID: <20220616094740.276b8312@kernel.org>
In-Reply-To: <YqtTqP+S0jvDNRJF@boxer>
References: <20220614174749.901044-1-maciej.fijalkowski@intel.com>
        <20220614174749.901044-2-maciej.fijalkowski@intel.com>
        <20220615164740.5e1f8915@kernel.org>
        <YqtTqP+S0jvDNRJF@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 Jun 2022 18:00:40 +0200 Maciej Fijalkowski wrote:
> > Loopback or not, I don't think we should be accepting the shutdown ->
> > set config -> pray approach in modern drivers. ice_open() seems to be
> > allocating all the Rx memory, and can fail.  
> 
> They say that those who sing pray twice, so why don't we sing? :)
> 
> But seriously, I'll degrade this to ice_down/up and check retvals. I think
> I just mimicked flow from ice_self_test(), which should be fixed as
> well...
> 
> I'll send v4.

checking retval is not enough, does ice not have the ability to
allocate resources upfront? I think iavf was already restructured
to follow the "resilient" paradigm, time for ice to follow suit?

This is something DaveM complained about in the first Ethernet driver 
I upstreamed, which must have been a decade ago by now. It's time we
all get on board :)
