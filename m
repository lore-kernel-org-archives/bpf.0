Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D545C00140
	for <bpf@archiver.kernel.org>; Fri, 19 Aug 2022 03:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiHSDBw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiHSDBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 23:01:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE5D5EAD;
        Thu, 18 Aug 2022 20:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B1E1B82472;
        Fri, 19 Aug 2022 03:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6ACC433C1;
        Fri, 19 Aug 2022 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660878104;
        bh=sZPwomgTqDbNvCNweBwoAPJMZp0S+2XIN7iCL7ikrrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A4KHhfHLwMJIN+9Nr7t2sd1GKceJG1NRF7pDHLRx6+vk+UYDj4L2146GNa0JMtKWO
         AMXSZn8ND0uaQ1A93oq7yNU+oHZR8TTr69b3j8UqvIK1BwzsV9K88aEAPE0oVi26zg
         QK6ARfZsaNshuacfULZoT7P9u7uWlv/GLO4yJSWEUasndf9E0l9JHzRVWcXiVE8E0b
         B0ZwTP+PW1J0REJNeCuRnA2E6HpB0uim3h7bAmbV6kyOxqRIPhlB1IcZvqGSggYSYb
         L+1C2IE476lr1VE4/r7i44Ng4RsJc1oFheVlOOBTW3B2bKsKEPOcyeIG4RtTshAWPz
         F+fFQAVEoYQ9A==
Date:   Thu, 18 Aug 2022 20:01:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] dev: Move received_rps counter next to RPS
 members in softnet data
Message-ID: <20220818200143.7d534a41@kernel.org>
In-Reply-To: <20220818165906.64450-2-toke@redhat.com>
References: <20220818165906.64450-1-toke@redhat.com>
        <20220818165906.64450-2-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Aug 2022 18:59:03 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Move the received_rps counter value next to the other RPS-related members
> in softnet_data. This closes two four-byte holes in the structure, making
> room for another pointer in the first two cache lines without bumping the
> xmit struct to its own line.

What's the pointer you're making space for (which I hope will explain
why this patch is part of this otherwise bpf series)?
