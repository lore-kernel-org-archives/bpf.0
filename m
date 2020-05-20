Return-Path: <SRS0=8CIW=7C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48286C433E1
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F35A20709
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589994150;
	bh=whpzmBwWqd+gQAUGWLi+RbgTC02qz0FLfolqqvqu7LQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tW6+Lwp8X8PmR3grv9dZjOxIRBOlgR3W3S/4ak6auoSSsCBJUfm35xNhTs/CmaGiz
	 U6FzbbXg1BJjQ1slC4XWfMlLij1bQNsY7xjo+1fKQOny3HLroHB7oZglUY4ZOSEAJI
	 958F+T21/JwSLR4p9srbGKO0MandOttJLG566jak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgETRC3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 May 2020 13:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETRC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 13:02:29 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7711420708;
        Wed, 20 May 2020 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994149;
        bh=whpzmBwWqd+gQAUGWLi+RbgTC02qz0FLfolqqvqu7LQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dz1iB4Meka3S3vPoGpbLpYfm8i83lJ+hM5iKd7NtF5xIWoWGUYqxZ6XkRPpAAvQy5
         tVa41gDmBBO528lGkjjhXJo31Tn7PniVeyCbT+HrvISOEV1KTn2Mqf7dCjbJ44CSV0
         vxqWwNyOSL8m6cPKswHtskR6dwCdw6/q5eQaEGxI=
Date:   Wed, 20 May 2020 10:02:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com, jeffrey.t.kirsher@intel.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        maximmi@mellanox.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH bpf-next v4 07/15] i40e: separate kernel allocated rx_bi
 rings from AF_XDP rings
Message-ID: <20200520100218.56e4ee2c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200520094742.337678-8-bjorn.topel@gmail.com>
References: <20200520094742.337678-1-bjorn.topel@gmail.com>
        <20200520094742.337678-8-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 May 2020 11:47:34 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> Continuing the path to support MEM_TYPE_XSK_BUFF_POOL, the AF_XDP
> zero-copy/sk_buff rx_bi rings are now separate. Functions to properly
> allocate the different rings are added as well.
>=20
> v3->v4: Made i40e_fd_handle_status() static. (kbuild test robot)
>=20
> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

There is a new warning here, at least one. But i40e has so many
existing warnings with W=3D1, I can't figure out which one is new :(

You most likely forgot to adjust kdoc somewhere after adding or
removing a function parameter.
