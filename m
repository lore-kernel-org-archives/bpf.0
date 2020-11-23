Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C5C2D0E4
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A3820727
	for <bpf@archiver.kernel.org>; Mon, 23 Nov 2020 23:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS0+uuGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKWXyX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbgKWXyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 18:54:22 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F4A20721;
        Mon, 23 Nov 2020 23:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606175662;
        bh=mS7nssrxTGFBFRL+AkS8Ed84G5Ls403ycoNfL6nuAl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MS0+uuGbCCa/dBCV4YiTTqV28nKQn6gX4/jXcMjuKrzzMb1Ywi/JzsSpiXjwXJwxp
         zQQqCHzsukAXrJPbGd9aTJ19lPJmFqDAK/Cc/to6ge3OBHwTZDfRq6hgr6RNQHB8vC
         /aYK1YgK1f5Ygoga/4VzsPfgsLHfKPcGLV/OgNTo=
Date:   Mon, 23 Nov 2020 15:54:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Zhang, Qi Z" <qi.z.zhang@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>, maximmi@nvidia.com
Subject: Re: [PATCH bpf-next v3 00/10] Introduce preferred busy-polling
Message-ID: <20201123155420.30000c8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAJ+HfNh4Kybjuzi1KOvJBUBvQWFDCZgt7zZNU=ZS8FLCsNKiRQ@mail.gmail.com>
References: <20201119083024.119566-1-bjorn.topel@gmail.com>
        <CAJ+HfNh4Kybjuzi1KOvJBUBvQWFDCZgt7zZNU=ZS8FLCsNKiRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 23 Nov 2020 14:31:14 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Eric/Jakub, any more thoughts/input? Tomatoes? :-P

Looking now, sorry for the delay. Somehow patches without net in their
tag feel like they can wait..
