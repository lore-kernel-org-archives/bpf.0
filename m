Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06020C10F1B
	for <bpf@archiver.kernel.org>; Thu, 22 Dec 2022 01:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLVBHF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Dec 2022 20:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVBHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 20:07:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BDE222BC;
        Wed, 21 Dec 2022 17:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900C16199C;
        Thu, 22 Dec 2022 01:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803CC433D2;
        Thu, 22 Dec 2022 01:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671671221;
        bh=X4EQXEfpXCzFdvCCq+9Ta45ZOIT/4jbIB/q+a1ki8YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LSiEhp6qdTO2N+NsvRBUoKozoowweknLMvh84Fu87HfDY0xDMgYCfWlmOwiyWuG0A
         71sd559fohXmRESblQ0lN79Lwg2T8qKHHo1hGP0oDXMdnqXPxif6qCrQTMOKoNfI2g
         M+H8VZHy13FciomkX9+FL4MQwfaaX83v4V8xQnDTPP2t/LdzJTSXNGMyYX3bXOrmdY
         F9teMQwESpduxm2WeYXQFEQlU3DoxxT6sgvu0Fu4K4QUnoyvkGfMfGsNMYCvny/1Mj
         JjddnJ2amO29x79eiMEDuPV96uWSPy6sAw2hJQMo+4tJREmUTgOmVTGHK41pAfu7LX
         LiCRsq3l9lbuQ==
Date:   Wed, 21 Dec 2022 17:07:00 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shawn Bohrer <sbohrer@cloudflare.com>
Cc:     magnus.karlsson@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn@kernel.org, kernel-team@cloudflare.com,
        davem@davemloft.net
Subject: Re: [PATCH] veth: Fix race with AF_XDP exposing old or
 uninitialized descriptors
Message-ID: <20221221170700.32e5ddc6@kernel.org>
In-Reply-To: <20221220185903.1105011-1-sbohrer@cloudflare.com>
References: <Y5pO+XL54ZlzZ7Qe@sbohrer-cf-dell>
        <20221220185903.1105011-1-sbohrer@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Dec 2022 12:59:03 -0600 Shawn Bohrer wrote:
>  	if (stats.xdp_tx > 0)
>  		veth_xdp_flush(rq, &bq);

This one does not need similar treatment, right?
Only thing I could spot is potential races in updating stats, 
but that seems like a larger issue with veth xdp.

> -	if (stats.xdp_redirect > 0)
> -		xdp_do_flush();
