Return-Path: <SRS0=2eLy=CX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F5C433E2
	for <bpf@archiver.kernel.org>; Mon, 14 Sep 2020 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4526B21BE5
	for <bpf@archiver.kernel.org>; Mon, 14 Sep 2020 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600103724;
	bh=02SbxKIr3dMWkZCWBqDjkKRmsxMV0OYLMK0dr9s2HLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LbRJomT9V/uhSFiCA7mK1UPkTgxAIHNRz59I8mQNPc/ZpqKYd7s4F8++Rlf34GdR/
	 jUVdPoO0cxofTpCO/gePk+Ts3zB6dt6rRHAuq8YtxuY3UZqmwguLqdU8eL0QYmjlJN
	 3vTxgLN1Vb+Apaey2wiGy6AMBaL/Rqfp0sO6AWyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgINRPQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgINROx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 13:14:53 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0617221D24;
        Mon, 14 Sep 2020 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600103691;
        bh=02SbxKIr3dMWkZCWBqDjkKRmsxMV0OYLMK0dr9s2HLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uu36q4pwCpacQ+TO3asDMrxncR0YhLqXdpvHjKcBkLa+7q1NtKzNSDAEAkDbMzlJI
         9zmgVDirYYxMhEHMztOx2eogEldrTa2pubBfv6E9Hg9+Cm2G6AbbMUcaB6kR8GuutU
         szKkwLd2pNprHOTMS4M/Bmsa1Bdf8sp2c8EezolM=
Received: by mail-lj1-f175.google.com with SMTP id a15so364070ljk.2;
        Mon, 14 Sep 2020 10:14:50 -0700 (PDT)
X-Gm-Message-State: AOAM532LJg3s07gNOlwCDC71mvFNQ0JLusIr/iM2Z6HqtAMO3GnFDkGj
        KSpCERo8elpFNKaCPCVP8OtVySeR/FpiBNwht6Y=
X-Google-Smtp-Source: ABdhPJzB/5zaCbKyxwA0yt2omEGyZB1tttREySL+28tNZuyMaxDtplU+W6jPSxNmDmHyp133PeR3NPA5MxELATO8DLk=
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr4918867ljl.350.1600103689257;
 Mon, 14 Sep 2020 10:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200910075609.7904-1-bjorn.topel@gmail.com> <f83087dfb41043648825c382ce6efa61@intel.com>
In-Reply-To: <f83087dfb41043648825c382ce6efa61@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Sep 2020 10:14:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7nhHV=SzgeW3fxQ0t=ciKczJLbouarYVSJP=oS6j6WbA@mail.gmail.com>
Message-ID: <CAPhsuW7nhHV=SzgeW3fxQ0t=ciKczJLbouarYVSJP=oS6j6WbA@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix number of pinned pages/umem size discrepancy
To:     "Loftus, Ciara" <ciara.loftus@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Topel, Bjorn" <bjorn.topel@intel.com>,
        "maximmi@nvidia.com" <maximmi@nvidia.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 2:29 AM Loftus, Ciara <ciara.loftus@intel.com> wrot=
e:
>
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > For AF_XDP sockets, there was a discrepancy between the number of of
> > pinned pages and the size of the umem region.
> >
> > The size of the umem region is used to validate the AF_XDP descriptor
> > addresses. The logic that pinned the pages covered by the region only
> > took whole pages into consideration, creating a mismatch between the
> > size and pinned pages. A user could then pass AF_XDP addresses outside
> > the range of pinned pages, but still within the size of the region,
> > crashing the kernel.
> >
> > This change correctly calculates the number of pages to be
> > pinned. Further, the size check for the aligned mode is
> > simplified. Now the code simply checks if the size is divisible by the
> > chunk size.
> >
> > Fixes: bbff2f321a86 ("xsk: new descriptor addressing scheme")
> > Reported-by: Ciara Loftus <ciara.loftus@intel.com>
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Thanks for the patch Bj=C3=B6rn.
>
> Tested-by: Ciara Loftus <ciara.loftus@intel.com>

Acked-by: Song Liu <songliubraving@fb.com>
