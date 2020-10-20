Return-Path: <SRS0=ZEGR=D3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051CDC41604
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F07322244
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603220492;
	bh=CAPUNzgQ+fKiRmkaBvSyuCbyeq4eHgrM3/jOC4mlFw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AvN1r/+7jOL9mRcP9tBv5sIgqb3VN84V22yIQ8xFV0D8U+upMtpwiufSKS98dUJeU
	 hAsQKC3KszwMUaQxhXRILynMQjjCYKijzPliYXfiubC3nudOlRVqDfn/M7enXEo+Mu
	 DXeby+AlIyj6oeCwzC2xFhRHy2mkxcHj979z1pPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390918AbgJTTBb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390864AbgJTTBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 15:01:30 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1C72223C;
        Tue, 20 Oct 2020 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603220490;
        bh=CAPUNzgQ+fKiRmkaBvSyuCbyeq4eHgrM3/jOC4mlFw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJkI9dn0QHgRuVjdVOMMDOSbdDqcAHO/XRutaAHTFqFbLfwb1G1Eta/DZwhWhEwbe
         UsvCxIVmfpTazM7W94T7EmhWSdbj17lUuJ9DV8c7UoRXs3LIx2+55G9zPIBOrCZ7tg
         A5QnQqMyuwtgZFUrsvsXz7Ezq16lqgGEkMNYIqBA=
Date:   Tue, 20 Oct 2020 12:01:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf_redirect_neigh: Support supplying the
 nexthop as a helper parameter
Message-ID: <20201020120128.338595e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <87v9f422jx.fsf@toke.dk>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
        <160319106221.15822.2629789706666194966.stgit@toke.dk>
        <20201020093003.6e1c7fdb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <87v9f422jx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Oct 2020 20:08:18 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Isn't this backward? The hole could be named in the internal structure.
> > This is a bit of a gray area, but if you name this hole in uAPI and
> > programs start referring to it you will never be able to reuse it.
> > So you may as well not require it to be zeroed.. =20
>=20
> Hmm, yeah, suppose you're right. Doesn't the verifier prevent any part
> of the memory from being unitialised anyway? I seem to recall having run
> into verifier complaints when I didn't initialise struct on the stack...

Good point, in which case we have a convenient way to zero the hole
after nh_family but no convenient way to zero the empty address space
for IPv4 :) (even though that one only needs to be zeroed for the
verifier)
