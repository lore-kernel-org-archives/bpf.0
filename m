Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F45C2D0E4
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 00:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B68720731
	for <bpf@archiver.kernel.org>; Tue, 24 Nov 2020 00:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yHLi09Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgKXAEQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKXAEO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 19:04:14 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8713E20729;
        Tue, 24 Nov 2020 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606176254;
        bh=O8aYVGkuc5F6rxRPL7YkMGFYjzERiZjPe2oro6FzSLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yHLi09WjA5rqFmiSjVKb9Hz4WB3f8qkO+gIz71t9b6Qc6hgddPNs0tMOPYr39H6CI
         5Fu9PGqLm2rE2hS9w5DuCCiZjN7VV8170CAzMc3baD/sfgYjLK06iRv9bOXzFbB22i
         /popXFUCc11j8OnLkGRjT4rWOhpue+ZkeYGSrINc=
Date:   Mon, 23 Nov 2020 16:04:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFQ=?= =?UTF-8?B?w7ZwZWw=?= 
        <bjorn.topel@intel.com>, magnus.karlsson@intel.com, ast@kernel.org,
        daniel@iogearbox.net, maciej.fijalkowski@intel.com,
        sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
        qi.z.zhang@intel.com, edumazet@google.com,
        jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: Re: [PATCH bpf-next v3 01/10] net: introduce preferred busy-polling
Message-ID: <20201123160412.1bfb5161@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201119083024.119566-2-bjorn.topel@gmail.com>
References: <20201119083024.119566-1-bjorn.topel@gmail.com>
        <20201119083024.119566-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 19 Nov 2020 09:30:15 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +	/* The NAPI context has more processing work, but busy-polling
> +	 * is preferred. Exit early.
> +	 */
> +	if (napi_prefer_busy_poll(n)) {
> +		if (napi_complete_done(n, work)) {
> +			/* If timeout is not set, we need to make sure
> +			 * that the NAPI is re-scheduled.
> +			 */
> +			napi_schedule(n);
> +		}
> +		goto out_unlock;
> +	}

Do we really need to go through napi_complete_done() here?

Isn't it sufficient to check:

	if (napi_prefer_busy_poll(n) &&=20
	    hrtimer_active(&n->timer)) // not 100% sure this is the
	                               // right helper for the check

If timer is scheduled it will fire and worst case sirq will kick back
in after timeout. napi_complete_done() should had been called by the
driver already to schedule the timer. If the driver doesn't call
napi_complete_done() we should not allow it to use busy_poll() anyway.
