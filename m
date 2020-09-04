Return-Path: <SRS0=/x2n=CN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D07DC43461
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3370120722
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599205233;
	bh=FOdk5hsqjXFV4tIITIMVatNZ+qAboAjUq6pSlLuEdI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=px631hxgJ3JHNoyCfuxKgEIt3rPoRay8O4GTuyM45oVv7xqUgWWgMEtvnSVmbyRI0
	 T4325xgaBXJtp64Y0CpwvSMUq71c566yu6N+rTSxIq7gyM4Uou6NUOq2YIFpoxe65m
	 RDF9l4AQAgvwqZAf2oRc4EzeuVkHNf+HVhNG8jI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgIDHkc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDHkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 03:40:32 -0400
Received: from localhost (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5EA206A5;
        Fri,  4 Sep 2020 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599205232;
        bh=FOdk5hsqjXFV4tIITIMVatNZ+qAboAjUq6pSlLuEdI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epUNS6oA40LG8MYE5KHRci0weVfPq0ZSbyu9tL1SbU4kMYYnf5CMg4YxyMOanAq9l
         0dA8LkUjVKsFgLQswqtkBtmnEsDZHlb94PkUiFSkyff+99b3PO1fw+stEzuNOQOkIm
         IKubT6w3j5gNsUcxuQKU7p5CqcqsrFAtPvo3d9pc=
Date:   Fri, 4 Sep 2020 09:40:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        shayagr@amazon.com
Subject: Re: [PATCH v2 net-next 0/9] mvneta: introduce XDP multi-buffer
 support
Message-ID: <20200904074027.GB2884@lore-desk>
References: <cover.1599165031.git.lorenzo@kernel.org>
 <20200904010803.nt2jfuhrbqe5cj53@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20200904010803.nt2jfuhrbqe5cj53@ast-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 03, 2020 at 10:58:44PM +0200, Lorenzo Bianconi wrote:
> > For the moment we have not implemented any self-test for the introduced=
 the bpf
> > helpers. We can address this in a follow up series if the proposed appr=
oach
> > is accepted.
>=20
> selftest has to be part of the same patch set.

sure, I will add it in v3.

Regards,
Lorenzo

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX1HvaAAKCRA6cBh0uS2t
rFILAPwO/r9LUFhyFy0pHYimeFVKGVwlVkQ69OqvwRCNHDUnmAEAvSAx7Y0JRWnW
vgvCAZiB2kRrJ2P8iBJl6YFIhM0Tlgc=
=1rYw
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
