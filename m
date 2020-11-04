Return-Path: <SRS0=nPxa=EK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECCCC2D0A3
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EC820825
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604532910;
	bh=8naRRfx/ql8v5jXWWzNqjjDh4gEicz1wVBuT8pBmvGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NFaQI3LtL5bwIF94x1M/7Qlf9ydkecbkOypu8D+SQdESXSInMRQdq4iIVoiSHC89V
	 lJS35uC45I1FOCwq6r2yPkFy0Z4T0Z6ku9UijWGJYAhofZEhcAXPO2byAcdieCqPl2
	 hgFXjj5k11pLbbRamM5PVxVJTnrrVR18QQStPFQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgKDXfK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbgKDXfK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 18:35:10 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0157C2074B;
        Wed,  4 Nov 2020 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604532909;
        bh=8naRRfx/ql8v5jXWWzNqjjDh4gEicz1wVBuT8pBmvGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6t8lCuI55tDwvF4xAFFt3dR62b9AkC8FfySCd63sqbbrAjo/8P7fKnN4P5rrauc6
         c0XPM/kp8kd0k64HLkJSHJtBi/ufoeIiJSm1cHJmUqPDo64P3Ir/vQgHS1jX5J1C2m
         d6bZWt/C70vBy+WHF/k4Ip79ZP011z4Jd23d0tic=
Date:   Wed, 4 Nov 2020 15:35:07 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, anthony.l.nguyen@intel.com,
        maciej.fijalkowski@intel.com, maciejromanfijalkowski@gmail.com,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH bpf-next 1/6] i40e: introduce lazy Tx completions for
 AF_XDP zero-copy
Message-ID: <20201104153507.5df7c8d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
        <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
        <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 4 Nov 2020 15:33:20 -0800 Jakub Kicinski wrote:
> I feel like this needs a big fat warning somewhere.
> 
> It's perfectly fine to never complete TCP packets,

s/TCP/normal XDP/, sorry

> but AF_XDP could be used to implement protocols in user space. What
> if someone wants to implement something like TSQ?

