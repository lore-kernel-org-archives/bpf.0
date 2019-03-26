Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34D2C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540D20823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtWrf08L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfCZSIr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:08:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbfCZSIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:08:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so11987897ljg.6;
        Tue, 26 Mar 2019 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvwZPPbh7XRO+fR4A7Mjn6AszuCm5k8PlzP3YW/J5vo=;
        b=mtWrf08LLTqsB7mT0HTWH3PsQZUvpts4h5ixrBUd3pSUMThmKmaIo268mxu6sa429B
         3h3QE3pH1PoyV4BBgKwMyywyp+4pKvMqIOOnS6S9QCenuuOp86dSBxzLKGp4TlJMw9an
         AX+lDCFnYh9HJKiIkxp8FiCpFT8fbUFY5H8bb/vKQPnHlq35gsQf0F9P8V7EspRPNDBs
         MktVM/ed9CK4adQ567MOgD24nZ0CO0Ha6B2ni/LrQu0tS3k2m2fmlZkw480yszXEOJf0
         gWSmUQ7T7xjAsjSgP2Dh1Wp1llJ8tjOuzX1PrqADs04NLIMOXaDjXXdFFEsXrs1b+QP+
         YADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvwZPPbh7XRO+fR4A7Mjn6AszuCm5k8PlzP3YW/J5vo=;
        b=Gs/6MYiP6+EGVsD1dSOsqRrUWQczBACXcP8vIQ7c4idd2ImQR2Lzu+WVPkNRRSB40S
         Tj5XP3rvtRWkH/QcxmX1KPYw9LHKAlpvWqGqnVEwj/y/N3zeJw8qAMq7SzspdhzCle8F
         ftW3Fwn1YMl+eFVZ4F4Spp/C7MplUOsWTua9me6Q4ESxDC+Iaiw7uN6GyCln/7AxFxwy
         2gsl+EOJu7GY5cqMSshVGIEjwY/GzJK8pA0ZRSzdLnMd2i86b98eB9sJ4sPiJoSCIN32
         Da1Oe92hcNgDhwE1NZevw002a4G0A+7frOcFoamrhi2188clgQ2xEZFkOX1+F/eQkYjy
         AIGA==
X-Gm-Message-State: APjAAAXYaWPvxiDl6vP5BDE+VJvTl1py3cd2XY4qrkZ7DmDJVo5MD+vp
        nFMSo53uyMQZuq8u/gTnnSnFuV8e5Wy4pHWJYrc=
X-Google-Smtp-Source: APXvYqxMSOQGxgqMbl4dGfoXmOeipuNGWkofi99ac39QgEo0eGYqGPrDfjyuj68mSP2SpafBCMTsHHcDhcpADQ9XlK8=
X-Received: by 2002:a2e:a284:: with SMTP id k4mr15562950lja.99.1553623724905;
 Tue, 26 Mar 2019 11:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com> <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net> <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net> <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net> <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
In-Reply-To: <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Mar 2019 11:08:33 -0700
Message-ID: <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> The BPF flow dissector should work the same. It is fine to pass the
> data including ethernet header, but parsing can start at nhoff with
> proto explicitly passed.
>
> We should not assume Ethernet link layer.

then skb-less dissector has to be different program type
because semantics are different.
