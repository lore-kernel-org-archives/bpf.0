Return-Path: <SRS0=MNkI=BR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3442C433E0
	for <bpf@archiver.kernel.org>; Fri,  7 Aug 2020 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0D820866
	for <bpf@archiver.kernel.org>; Fri,  7 Aug 2020 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNAJf5Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHGIGt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGIGt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 04:06:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A7C061574;
        Fri,  7 Aug 2020 01:06:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so708840pls.2;
        Fri, 07 Aug 2020 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4XLPHo6ufXjqCRDRX6dlamDg8saN7x8jg/SbIqu516I=;
        b=fNAJf5Jqo/OU8MSnbks8APaPlFcPTPed8hIm+RF5uEP0MVlFRE51bceB9XUr97PQOy
         t6JhhXMLqUxUYPRhiV5Yk1xKUw8Ize2YilArRhUK6PbX1zZxbzxL7mGxtkTUFatf3xll
         KoUvM2lP7agOvM+akXjePCzMdgYg/X+PlOlZdn5eDXtURGPCItCgGqfuIlBTNuDfJj3D
         7TnsxcrRYWps8jln59GtRWMo2qM6VyQ3yARXqFDFYvVUg6OCWZiUVYueGX8WkkjGLkoE
         YDa3/nZKhZx3hCu8N6Xb+GIvHiJU4EuLktAM83d5WbjLPv6M4CELkaqtZp66hsIXbo3S
         szYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4XLPHo6ufXjqCRDRX6dlamDg8saN7x8jg/SbIqu516I=;
        b=NCAYE6lSxKBRLO6zOv5J6mkTdGQdXNlbC6HeZNbfRbquge0jT4BGShEqZ7SdK21zc7
         lwsQ6MKft24vPucFHTsvErlXKCWyjOkNgNeVuyfnkevXzcwieVb0odAbDytnHUx0RMEt
         xZiYKi34lmI7Fs9kL4W8AST8Njj/JWzpZjnDwUs9DSNicAB2ATUU32D8rvuVPme1okHL
         vYep5nhdAw859gfosG4mcpwyK4TDFsoHRM0kCV2a7vqQdcu4BLbvHb3thhp0QLfBy0ID
         4c9V3cNz0SS34mmC32fZqLcCISwdXEy73JRW4A/BjtTieGh5fOVpu1crp5yX2K3yoKDp
         jMfQ==
X-Gm-Message-State: AOAM533sCNv332pGFJ7Pejd1eeneV50V8NOzpLxUKgl/UE9whwyNZaUt
        Kg7CDneQWxz/Z4h2FX4Htgc=
X-Google-Smtp-Source: ABdhPJxui7Oprix2e/G48+E3w+lKpjo8L5GpoGRIpjJb1/SpBdQvuTty/P4PmydhlX0r3jPrBRzFkg==
X-Received: by 2002:a17:902:9f85:: with SMTP id g5mr11035469plq.13.1596787608321;
        Fri, 07 Aug 2020 01:06:48 -0700 (PDT)
Received: from [192.168.97.34] (p7925058-ipngn38401marunouchi.tokyo.ocn.ne.jp. [122.16.223.58])
        by smtp.gmail.com with ESMTPSA id b13sm11307575pgd.36.2020.08.07.01.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 01:06:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Add helper to do forwarding lookups
 in kernel FDB table
From:   Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <e92455ce-3a3f-7c52-1388-da40e8ceefd0@gmail.com>
Date:   Fri, 7 Aug 2020 17:06:41 +0900
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B486A33-7A46-436A-A563-80F842A16F23@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
 <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
 <F99B20F3-4F88-4AFC-9DF8-B32EFD417785@gmail.com>
 <e92455ce-3a3f-7c52-1388-da40e8ceefd0@gmail.com>
To:     David Ahern <dsahern@gmail.com>
X-Mailer: Apple Mail (2.3445.104.15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> 2020/08/06 1:38=E3=80=81David Ahern <dsahern@gmail.com>=E3=81=AE=E3=83=A1=
=E3=83=BC=E3=83=AB:
>=20
> On 8/4/20 5:27 AM, Yoshiki Komachi wrote:
>>=20
>> I guess that no build errors will occur because the API is allowed =
when
>> CONFIG_BRIDGE is enabled.
>>=20
>> I successfully build my kernel applying this patch, and I don=E2=80=99t=
 receive any
>> messages from build robots for now.
>=20
> If CONFIG_BRIDGE is a module, build should fail: filter.c is built-in
> trying to access a symbol from module.

When I tried building my kernel with CONFIG_BRIDGE set as a module, I =
got
the following error as you pointed out:

    ld: net/core/filter.o: in function `____bpf_xdp_fdb_lookup':
    /root/bpf-next/net/core/filter.c:5108: undefined reference to =
`br_fdb_find_port_xdp'

It may be necessary to fix it to support kernels built with =
CONFIG_BRIDGE set
as a mfodule, so let me make sure if it should be called via netdev ops =
to get
destination port in a bridge again.

Thanks & Best regards,


=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

