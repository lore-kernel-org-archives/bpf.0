Return-Path: <SRS0=/x2n=CN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25293C433E2
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB642084D
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599206855;
	bh=51bpI3bjUxtI3call4hbqi7swrIWd58IgrWWgN9xq2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l4vsbGYLxFlS81HHwI0N4LWkUxr0OTl8QmZ7+go3jNdCdGMuS+iXUvjBrDbXdQ3Ux
	 x5iUmVqQclrJa9HUh/4Xq+ps+lcFPe+TMOL0V6m80Wds10UpkcT2AfXQmSVD4/bafl
	 6z79qBaq70HeyFrWX/ZDVExywDpTwxQqRGKF8dBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIDIHf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgIDIHe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 04:07:34 -0400
Received: from localhost (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D7E6206B8;
        Fri,  4 Sep 2020 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599206854;
        bh=51bpI3bjUxtI3call4hbqi7swrIWd58IgrWWgN9xq2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONgBD/NZslOJRQaxaczJvCMCkeIiitiu14SkFQFkBkVTPYvwevHMUue8u28vZT6uX
         qnQ2He8SFFye5W1la0Ww+mUxrAtR5QS1S6FjU/QOC5c3VgY18JzC3nkHOoGdP2gGlf
         EtmdXOqPDO8kqAuR7wkxptdpB9c0o8VVr0672RWw=
Date:   Fri, 4 Sep 2020 10:07:29 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        shayagr@amazon.com
Subject: Re: [PATCH v2 net-next 6/9] bpf: helpers: add
 bpf_xdp_adjust_mb_header helper
Message-ID: <20200904080729.GE2884@lore-desk>
References: <cover.1599165031.git.lorenzo@kernel.org>
 <b7475687bb09aac6ec051596a8ccbb311a54cb8a.1599165031.git.lorenzo@kernel.org>
 <20200904010924.m7h434gms27a3r77@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <20200904010924.m7h434gms27a3r77@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 03, Alexei Starovoitov wrote:
> On Thu, Sep 03, 2020 at 10:58:50PM +0200, Lorenzo Bianconi wrote:
> > Introduce bpf_xdp_adjust_mb_header helper in order to adjust frame
> > headers moving *offset* bytes from/to the second buffer to/from the
> > first one.
> > This helper can be used to move headers when the hw DMA SG is not able
> > to copy all the headers in the first fragment and split header and data
> > pages.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 25 ++++++++++++----
> >  net/core/filter.c              | 54 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 26 ++++++++++++----
> >  3 files changed, 95 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 8dda13880957..c4a6d245619c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3571,11 +3571,25 @@ union bpf_attr {
> >   *		value.
> >   *
> >   * long bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
> > - * 	Description
> > - * 		Read *size* bytes from user space address *user_ptr* and store
> > - * 		the data in *dst*. This is a wrapper of copy_from_user().
> > - * 	Return
> > - * 		0 on success, or a negative error in case of failure.
> > + *	Description
> > + *		Read *size* bytes from user space address *user_ptr* and store
> > + *		the data in *dst*. This is a wrapper of copy_from_user().
> > + *
> > + * long bpf_xdp_adjust_mb_header(struct xdp_buff *xdp_md, int offset)
>=20
> botched rebase?

Yes, sorry. I will fix in v3.

Regards,
Lorenzo

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX1H1vgAKCRA6cBh0uS2t
rCQoAQDRwbWXFa91rQQ9h2A9he7g5Xkx6pPbCEP4tbMem4t8nQD9ErfxhYill3pH
BnPLXhzHRZzMm1LDVjmKxyLHBCWS9gA=
=RhEV
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
