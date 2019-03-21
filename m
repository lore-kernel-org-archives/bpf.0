Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E6C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C386B218D3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfCUWXr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:23:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfCUWXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 18:23:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so242740wra.12;
        Thu, 21 Mar 2019 15:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=jfH2FwLw+RD/+6ZtW7RHHMmR1Ees6BlQlZI3CNetJEE=;
        b=PwstV7zKHpVkN4kLl1gi5axNEY2C5kb8VS+VhMVS1cjdLIXuPzIEQZAm9dBF1zDxeX
         jkO8CDrYebnYeYlxBF4SrkOou0BkGyH68/7MR1uhEf5AjQBs2DclfYZLybw1JUoxlt8I
         isqwBq6jUl8lsYTCmqRZ791OT3QPfpUBNR+v6SW6QvRX6f3USrlMTqCtId4hHVt4l92P
         XQQ6nbn46z8tNCw4cl09UnIHdsxkfpnpBV7rLMCrGNmoKa1T9s0adwFEyJJwg6BUR0xY
         rWOtbIK7IeddnZxJJcUVJs7JeHMKLas25Dn5yBS+jj7ffmNiiVcrRIWlbcCyryKYMHB9
         jZ7A==
X-Gm-Message-State: APjAAAUOt4tBIE78axkw+bg5YRU+6TK29zVZLtmYE+ZVTawWr+SW5Wnr
        ErNBfKhLP0GGkh4R08Kr8uVqoHso
X-Google-Smtp-Source: APXvYqw5vFQWd4fHMDB6qeQyq5TC7/EPOK8RHSndN5wQPxNg75PYsWCku0cITOBKhJq7pkPMuNXDiQ==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr4212741wro.263.1553207024973;
        Thu, 21 Mar 2019 15:23:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:b00c:66c8:99df:336])
        by smtp.gmail.com with ESMTPSA id b3sm7056096wmj.15.2019.03.21.15.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:23:43 -0700 (PDT)
Message-ID: <222d76b75d0d8efceb060aed445593d01647619e.camel@debian.org>
Subject: Re: [PATCH bpf-next v4] tools/bpf: generate pkg-config file for
 libbpf
From:   Luca Boccassi <bluca@debian.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, daniel@iogearbox.net
Date:   Thu, 21 Mar 2019 22:23:42 +0000
In-Reply-To: <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
References: <20190319210639.6282-1-bluca@debian.org>
         <20190321102531.31810-1-luca.boccassi@gmail.com>
         <20190321160042.GB13709@rdna-mbp>
         <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-S8x2gsS8xc7pv7R9fOsi"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-S8x2gsS8xc7pv7R9fOsi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-03-21 at 15:01 -0700, Alexei Starovoitov wrote:
> On Thu, Mar 21, 2019 at 04:00:46PM +0000, Andrey Ignatov wrote:
> > luca.boccassi@gmail.com <luca.boccassi@gmail.com> [Thu, 2019-03-21
> > 03:26 -0700]:
> > > From: Luca Boccassi <bluca@debian.org>
> > >=20
> > > Generate a libbpf.pc file at build time so that users can rely
> > > on pkg-config to find the library, its CFLAGS and LDFLAGS.
> > >=20
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> ...
> > > diff --git a/tools/lib/bpf/libbpf.pc.template
> > > b/tools/lib/bpf/libbpf.pc.template
> > > new file mode 100644
> > > index 000000000000..0ecd334c109f
> > > --- /dev/null
> > > +++ b/tools/lib/bpf/libbpf.pc.template
> > > @@ -0,0 +1,11 @@
> > > +prefix=3D@PREFIX@
> > > +libdir=3D@LIBDIR@
> > > +includedir=3D${prefix}/include
> > > +
> > > +Name: libbpf
> > > +URL:=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > +Description: Linux kernel BPF library
>=20
> github/libbpf/libbpf is a true mirror of kernel's libbpf.
> I think if we start shipping libbpf.so from kernel and from github
> it will be very confusing to the users...
> Which one is the true libbpf?

I'm afraid that ship already sailed :-) Users and distributions are
already consuming libbpf from the kernel tree.

> Also the package should mention the license.
> And the license for libbpf is dual lgpl/bsd.

I followed the template from the other pkgconfig file (in traceevent)
which does not have it, but I can add it in v5.

> But if we point to the url above it will not make much sense.
> I think the packages URL should point to github/libbpf/libbpf
> and packaging scripts should be in github only.

If only one side ships the pc file, then you'll have half the users
installing libbpf without a pc file, and the other half with it, so it
would defeat the point of having one in the first place.

> Daniel,
> what do you think?
>=20
--=20
Kind regards,
Luca Boccassi

--=-S8x2gsS8xc7pv7R9fOsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAlyUDu4ACgkQSylmgFB4
UWL2AwgAjbL2YSyJF0Q8WPsyyaA3WMO+VQCkdsZaCKKwbja81QO+yWJJuF81cZBF
VLpSyXvXoPqyQNmOz/11YiajjEEWntQ8eYFbZ5x1nNNhDQbNdwMfkfZoP95mAHxh
R8Ki3OPaYI8fgZSAEICjzIpSixkmBLtjEITD4Hvtgh5VxZx1SmtKqTM5rarbdBut
LmKQbvHzWsjYF1QrxrdGa0FCzV9TSstdXQ85bJA1rNkTbs0rzfviZ7FqRsvNuy7S
omhACJX1G1mz9K0ulP75N4051NDy92woE8PT+WPF7G35tdH+KGQxH1jMfvkHli76
D6cKQu1O6de/oQSpWbGykN4VzfD4NA==
=IPo4
-----END PGP SIGNATURE-----

--=-S8x2gsS8xc7pv7R9fOsi--
