Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E6C433FE
	for <bpf@archiver.kernel.org>; Fri, 30 Sep 2022 01:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI3BZs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Sep 2022 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI3BZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 21:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719413A949;
        Thu, 29 Sep 2022 18:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9191621FA;
        Fri, 30 Sep 2022 01:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9287C433D6;
        Fri, 30 Sep 2022 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664501145;
        bh=FVHdWqZOoo23PSZPDFNIeUwiRH5/PCGJfRbuhXU2EZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ENMVNSKh+670J9mnkbepwmvU1JJirJQR9PJvcpYRUJouOKaM+zZna9YCkTMLaRa/g
         l8eOCwCYMoMDyOVeJTQKhrvybXqXtiD4rGTN7qDL4JNILEfNMFpSMzLEisv6TPLpLa
         AJ4a8LdXHRBcJsVTCbv9RwU/nDL3OCSKpyN+wwZEWh0BR+3T+r6cdlMws18eKHxUd7
         LGQYOFjVXXcuSjseoyzPNjI73xd7o+UDabMywhWGxhNK04K5BtqwEQT1WMDYibQ3ZC
         B0M3ox86cGPPyRN3/y/VkjhIi8uh3idXz/eouF532sDz309j/S4m1CiJ9CvCwVDY7K
         3VbOswQIOWESA==
Date:   Thu, 29 Sep 2022 18:25:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hongbin Wang <wh_bin@126.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] seg6: Delete invalid code
Message-ID: <20220929182543.5b7a7593@kernel.org>
In-Reply-To: <20220929095649.2764540-1-wh_bin@126.com>
References: <20220929095649.2764540-1-wh_bin@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 29 Sep 2022 05:56:49 -0400 Hongbin Wang wrote:
> void function return statements are not generally useful

I don't think this is worth applying, sorry.
