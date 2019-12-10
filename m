Return-Path: <SRS0=eM+6=2A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFCAC43603
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2619207FF
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 20:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rizqzxbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfLJUET (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:04:19 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35622 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 15:04:19 -0500
Received: by mail-qv1-f68.google.com with SMTP id d17so4729411qvs.2;
        Tue, 10 Dec 2019 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DUrLVjxdm4Lpth1BVppJIgm06ZEFu/gHIQjjv1fTq6U=;
        b=RizqzxbtSWdVCijPI6xH1qD/FbjpnkAv2hlwG9t8Qv3FeMpHpSd5F+aRi+Jl4kCYIu
         2U347NzRoHmbqB+Dy+pVjlbfgAYvGV6O16mhnXewymf/du2An8tqtM0WV/pRswjAfzbH
         w6BoO5Jh90iQFMgvcyXmznNbZhEU9y7xbTmRFMyczTEXMXUrVh9Rd0XrJ9Zs/ejLx/wz
         vwx8lBvQO+qibCMAgVwt0Ms5d4UkFkNL3l6cd0GW1XhqaB4GXa4Oetei+BMPysTZUoGj
         AGPGAN2+bXX1WBw0VNVWXKcpK7+Q7z5MeclUNy/QwVCp/LH/Mcce5AErKysF6T+zWelX
         eu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DUrLVjxdm4Lpth1BVppJIgm06ZEFu/gHIQjjv1fTq6U=;
        b=Lv2F7VJYR7S7i+1Te7yQTs3xcCboypkTmsmMrjoZ2v//Hx3WJF+0Nq1Nwc7+D0oehC
         4VhfBEvFpCjymNiadc6ASPr5+gu/j70NW2IwoFYJqAYy/AiunyuXMIg9AjaqDjthYD3c
         Tr0ZswcDhJG9KCBUgsT1UnwuDkqWoy3aUGv52hD4HNXqsLlP67PAfiHfKFp/z4U+PEZM
         eMsZcf0ywQt8P6Bdp434KY4w+R6SwFFewW/vmLo1KPVOHpWVfXuLZ3cJs1EsuoWdmpCv
         c18ekivgSbenVr8lQ4flPqp91dTvdlfj8oHr5OJ9/IbjGSyiOkgCx8L7dIR/mnp9gB2i
         HXGQ==
X-Gm-Message-State: APjAAAW/CJLp2Tb28wq0v8/Lf81CuwgrgRk6tC6g+oL+UdEhAml+47y4
        hmh8hnRSuUZJsx1gGNq+UkKCeDW++zQh5hPjCu8=
X-Google-Smtp-Source: APXvYqwXn73WXUOpzstsgd2C49NE1hvr3MPlQCGS1Hm0PNizJIcHWrmAPihJdyZSSShKaIKC1o7kMY0acceBPG/8MSc=
X-Received: by 2002:a05:6214:448:: with SMTP id cc8mr2118377qvb.10.1576008258356;
 Tue, 10 Dec 2019 12:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20191209135522.16576-1-bjorn.topel@gmail.com> <0b45793e-6172-9c07-5bdb-2dc99e58e375@intel.com>
In-Reply-To: <0b45793e-6172-9c07-5bdb-2dc99e58e375@intel.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 10 Dec 2019 21:04:06 +0100
Message-ID: <CAJ+HfNgG+zkyTnXUG_zQ+jVr0FcqavAAwV=MX7x=RhXGHXokow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce the BPF dispatcher
To:     "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Dec 2019 at 20:28, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
[...]
> > The tests were performed using the xdp_rxq_info sample program with
> > the following command-line:
> >
> > 1. XDP_DRV:
> >    # xdp_rxq_info --dev eth0 --action XDP_DROP
> > 2. XDP_SKB:
> >    # xdp_rxq_info --dev eth0 -S --action XDP_DROP
> > 3. xdp-perf, from selftests/bpf:
> >    # test_progs -v -t xdp_perf
>
> What is this test_progs? I don't see such ann app under selftests/bpf
>

The "test_progs" program resides in tools/testing/selftests/bpf. The
xdp_perf is part of the series!

>
> > Run with mitigations=3Dauto
> > -------------------------
> >
> > Baseline:
> > 1. 22.0 Mpps
> > 2. 3.8 Mpps
> > 3. 15 ns
> >
> > Dispatcher:
> > 1. 29.4 Mpps (+34%)
> > 2. 4.0 Mpps  (+5%)
> > 3. 5 ns      (+66%)
> >
> > Dispatcher (full; walk all entries, and fallback):
> > 1. 20.4 Mpps (-7%)
> > 2. 3.8 Mpps
> > 3. 18 ns     (-20%)
>
> Are these packets received on a single queue? Or multiple queues?
> Do you see similar improvements even with xdpsock?
>

Yes, just a single queue, regular XDP. I left out xdpsock for now, and
only focus on the micro benchmark and XDP. I'll get back with xdpsock
benchmarks.


Cheers,
Bj=C3=B6rn
