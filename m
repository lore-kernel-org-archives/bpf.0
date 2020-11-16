Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C5C5519F
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33CE2223D
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWSG0Or1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgKPQE7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgKPQE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 11:04:59 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F41D20729;
        Mon, 16 Nov 2020 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605542698;
        bh=mzxRUxPD41DdrOGTNNtY0VgfWxLGrFfNEJkdPdYo32U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JWSG0Or1QFLKzp7OwLvuM0eE7eF4Sx5jzXaP5lRmcaVN+iBUdl1eQpIZ3leQqoYC5
         XkaqrYgrD0j1Y8XK0LfJ8WcxDs+VrTUZN+m25kDFc42EcvPyJwrBsawSXdzn2jvw+i
         VirdMBbGvD6VObm1Ri2/zYlllscBXlzuOl29p5wI=
Date:   Mon, 16 Nov 2020 08:04:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFQ=?= =?UTF-8?B?w7ZwZWw=?= 
        <bjorn.topel@intel.com>, magnus.karlsson@intel.com, ast@kernel.org,
        daniel@iogearbox.net, maciej.fijalkowski@intel.com,
        sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
        qi.z.zhang@intel.com, edumazet@google.com,
        jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: Re: [PATCH bpf-next v2 01/10] net: introduce preferred busy-polling
Message-ID: <20201116080457.163bf83b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201116110416.10719-2-bjorn.topel@gmail.com>
References: <20201116110416.10719-1-bjorn.topel@gmail.com>
        <20201116110416.10719-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Nov 2020 12:04:07 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> @@ -6771,6 +6806,19 @@ static int napi_poll(struct napi_struct *n, struct=
 list_head *repoll)
>  	if (likely(work < weight))
>  		goto out_unlock;
> =20
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

Why is this before the disabled check?

>  	/* Drivers must not modify the NAPI state if they
>  	 * consume the entire weight.  In such cases this code
>  	 * still "owns" the NAPI instance and therefore can
