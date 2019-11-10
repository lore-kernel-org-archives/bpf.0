Return-Path: <SRS0=0ow6=ZC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121B4C43331
	for <bpf@archiver.kernel.org>; Sun, 10 Nov 2019 06:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF252196E
	for <bpf@archiver.kernel.org>; Sun, 10 Nov 2019 06:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqOuvxRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfKJGdB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 10 Nov 2019 01:33:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41216 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfKJGdB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Nov 2019 01:33:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id o3so11941868qtj.8;
        Sat, 09 Nov 2019 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/aqSvHe3M/vYs/68yCBD+S1LltYbtqCDtMv0NCGDY0A=;
        b=tqOuvxRkzz1T9AINWiZrFm241UyBwrX/dFkVsrC48nmwLELH7dpr7O6m6usQumSRJQ
         oaUem9GmWlQKephcmuvZiPZGzHl7oYHgjMVVPbnD1XH+Mds34pHsP9HIflUL2RkAXws3
         VTA5IUaVIUHaJ52ruTcacDZfW3EvQGYvj5DHPO/bT8EXT+Y2svATv+3s+KNw+UhDhJ4S
         1MfUDipGLjPasForRIXRam6NIAV4MY8w36IJit/2Hk5v0BG9XbxidmecorHl3z6bxLDp
         xMPdHPL1nOTcHNkpnmxeph7rQoWf1jognt4noGAfFv0sIG71pBClLDvO+XZ1h3wLJlC8
         tdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/aqSvHe3M/vYs/68yCBD+S1LltYbtqCDtMv0NCGDY0A=;
        b=qAXlteuXarHMzOUivNz0dFCw/7XqM69Utiyk9qoP/csSP2INAeEaY9DfPWgm5xy5/e
         CfHEY+58cTBv2p14ApXhL/7XNncFS+1xSm2alV1TdmW+TlCbvYHNcUqbvMt3ppKmRg5e
         pPuH+ysMERs0qLiqP+MqPo76UqNRiZjdVBoUbJUvgqVlNLKz6jVKuuPPJdLZbTnZMuyi
         SqmUPBS/K74W1Jc61HGEc35dtX8PAbWoygEnr5Rx7hwR+Wppx0ezMWYmxIz9cw4XnzH2
         dAdgtxYPgKKuaA48PMaYJMXaZYpZMMJ1SVMdgtGMos+i58enjY/A6tH+sEmmYmiL981b
         HJUQ==
X-Gm-Message-State: APjAAAUdhHtIEzU7ebEgWv1QBUWyMBHbpf5X97iBrnlOUVcvaPs3SiFd
        i5M43ZSpwNgKK+xeczFB1F9bpUGST3ha4cGfWec=
X-Google-Smtp-Source: APXvYqxPEGcdI2PpKo9PZWFo1Ccg1/4ENdklw3sxvYbJ4//QH0Hk0DLmTTbDQR9onoh9+ZlzPy5ibtiqT0JsfLAu0Fk=
X-Received: by 2002:ac8:3fed:: with SMTP id v42mr19690521qtk.171.1573367580009;
 Sat, 09 Nov 2019 22:33:00 -0800 (PST)
MIME-Version: 1.0
References: <157333184619.88376.13377736576285554047.stgit@toke.dk> <157333185164.88376.7520653040667637246.stgit@toke.dk>
In-Reply-To: <157333185164.88376.7520653040667637246.stgit@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 9 Nov 2019 22:32:48 -0800
Message-ID: <CAEf4BzZrRxccnzib=PXgj=xL8EbvL5BiU9-mkwf4SJk596mnrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/6] libbpf: Add bpf_get_link_xdp_info()
 function to get more XDP information
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 9, 2019 at 12:37 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Currently, libbpf only provides a function to get a single ID for the XDP
> program attached to the interface. However, it can be useful to get the
> full set of program IDs attached, along with the attachment mode, in one
> go. Add a new getter function to support this, using an extendible
> structure to carry the information. Express the old bpf_get_link_id()
> function in terms of the new function.
>
> Acked-by: David S. Miller <davem@davemloft.net>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

looks good now, thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.h   |   10 +++++
>  tools/lib/bpf/libbpf.map |    1 +
>  tools/lib/bpf/netlink.c  |   84 +++++++++++++++++++++++++++++++---------=
------
>  3 files changed, 67 insertions(+), 28 deletions(-)
>

[...]
