Return-Path: <SRS0=N7Fo=A7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA4C433E0
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBD0206E9
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q+RRQpku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgGTStG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:49:06 -0400
Received: from ozlabs.org ([203.11.71.1]:48509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTStG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 14:49:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B9W3M0pHVz9sRN;
        Tue, 21 Jul 2020 04:49:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595270943;
        bh=zq27nOBYvcnduPT0qa/MnnpZ+wkF+HYh9Y4xkg2KTGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+RRQpkumPavfz8CkH17wXbg65W4nTRiiXA52DSTRMXdsmgBtSWocDsVimYIuwjbc
         DOPcCKFKcCc1WTaMfNKUGRtZJJ1E1fH9p9tukxg3i05H8NH3pqBVjgBluoLEQ2eldI
         hteo6gi1egVxa3wgGoDgr+88TvTruWEqBReT6BpArXdXSMLKM1JqXXbdpLl1bjcEIw
         HByplhMDx+f0/KiP/5Gm0siPXHFa447bVvFxf/Znc33PZlnKZl4fgFXmxA1YVKRsP/
         jLpeKuLkvbyhDTowByjoxuveFPbUEI/oBT7Y2W5Fk5e0de8pWVa8qGUY4QZ0h3ilN+
         W0zO1OshhPQBA==
Date:   Tue, 21 Jul 2020 04:49:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: Tree for Jul 20 (kernel/bpf/net_namespace)
Message-ID: <20200721044902.24ebe681@canb.auug.org.au>
In-Reply-To: <a97220b2-9864-eb49-6e27-0ec5b7e5b977@infradead.org>
References: <20200720194225.17de9962@canb.auug.org.au>
        <a97220b2-9864-eb49-6e27-0ec5b7e5b977@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xmO6y7t9HQPsaBUCZn1yWr5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--Sig_/xmO6y7t9HQPsaBUCZn1yWr5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jul 2020 08:51:54 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386 or x86_64:
>=20
> # CONFIG_INET is not set
> # CONFIG_NET_NS is not set
>=20
> ld: kernel/bpf/net_namespace.o: in function `bpf_netns_link_release':
> net_namespace.c:(.text+0x32c): undefined reference to `bpf_sk_lookup_enab=
led'
> ld: kernel/bpf/net_namespace.o: in function `netns_bpf_link_create':
> net_namespace.c:(.text+0x8b7): undefined reference to `bpf_sk_lookup_enab=
led'
> ld: kernel/bpf/net_namespace.o: in function `netns_bpf_pernet_pre_exit':
> net_namespace.c:(.ref.text+0xa3): undefined reference to `bpf_sk_lookup_e=
nabled'

Caused by commit

  1559b4aa1db4 ("inet: Run SK_LOOKUP BPF program on socket lookup")

from the bpf-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xmO6y7t9HQPsaBUCZn1yWr5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8V5x4ACgkQAVBC80lX
0Gw+bggAiG4QOWZgOHvyQPMwPYQT4XXnuO9bHIMt3T4rB7ldivNqz0Q0xIa1cbqE
T29KxH1MZJMoNIvqwysHBV4yDD92GcZrgwrtsXUdGFvchzECx1MUXmSOynmA2wOr
IS2HcUwh908AQ1oKhyxbAUKqUjgWlfmBKz8OMSV2NvTaCf0dl91QonqNzN6oYk8n
YMG3sOH9xmFKFJvuUzoa0OmD/jnCShiL6COIA+BzoHjOE5voZPHSufNaOkzALiA4
Fe4kLkOSQchdk4pddWIoyzoLQSDtfenYVruI4DRGNhKTZ3epUAsndiP2H5bvL2NR
G1OK60saE5fCoMYoNBjw8ePh6RlBag==
=Dcix
-----END PGP SIGNATURE-----

--Sig_/xmO6y7t9HQPsaBUCZn1yWr5--
