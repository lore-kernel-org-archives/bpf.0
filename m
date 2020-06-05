Return-Path: <SRS0=qrx8=7S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79AC433DF
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CD2077D
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4U36v/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgFEQ6k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFEQ6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 12:58:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1747C08C5C2;
        Fri,  5 Jun 2020 09:58:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so9039248ljn.6;
        Fri, 05 Jun 2020 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7GwDfzAAegzjhHINy2j2laCYpE04qOg39MLHgqy9Ms=;
        b=t4U36v/QFxHwx3oSFXnpultoo+I077PYCWy+AjMYvFx2mvxfM5wS9ffdyamRSuLwLp
         fFn6UUsLfhnkT2JXDJQO+xpOXf3ba8+wTMycRpHWU3L7rp25/Ae3qSbTYmURRbqyrA2M
         A9KOhzDV4Jp0lKbFkP6TWfb6ZwN2oAVG67U3VryuNmWKK28Hi0tsnVwOdv2iyVCIckFM
         beSliIU5W7kS2wVJgHFn/KEVHBdQa7Qb6vQ/VIQlKDLoLP+zFDShgZ9vi3vq2YUxvGSO
         lEv/5vP4mph/AruqtY05RnyB0kEgPILB1p1/e9rQvj3jy0OLe0H1HQBTmxZ8vGk84ErZ
         yr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7GwDfzAAegzjhHINy2j2laCYpE04qOg39MLHgqy9Ms=;
        b=JHvYHaOHcdbN1D/LmjIHfXAtMKoOH8nr28/MOlUYXuCw4JadFtflNRnHqZf+MHWoxe
         2oYUoeGi4VPZLRaSDOJG2SyC5aRX0EW9bFtvTlrvDIvI95Op4jG28yazh6bTBBd9DVma
         g9qnUueSbz21JWksAMGjQaKQ2QWQQJsEzqZBc8aGqnFyN/VD2dEmkiDmiXlQaUJLN0mc
         JhslkK98WguaKaKblpdidRAgTtC4stc7QIRZKPI3cgi+TWT9GPZPOsR1NfMwnBnrzG+R
         sKTXXrSlKGvbESwrntZLNUunoZ6cWFRxEMxWjnIHYZm7VvRukYKhFXtIzesdZCwgs4cz
         H0dw==
X-Gm-Message-State: AOAM531u05ZGqFJOABqkTS7wcc2T9d2CmLcjt1q9n18k+jhsdO0y7pB/
        t8SGh/dZxOq+GKGzcxP+DfwPzewsxBLVoFOIKAU=
X-Google-Smtp-Source: ABdhPJwROQcI5HigZRuMvUrF7zfzsl92huLEx+rx/ORegRoS67bG8UAuWW0M8dwYR38XnZw478aOQkxMdpm2MbPBSwA=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr5389943ljj.283.1591376318367;
 Fri, 05 Jun 2020 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <159119908343.1649854.17264745504030734400.stgit@firesoul>
 <20200603162257.nxgultkidnb7yb6q@ast-mbp.dhcp.thefacebook.com>
 <20200604174806.29130b81@carbon> <205b3716-e571-b38f-614f-86819d153c4e@gmail.com>
 <20200604173341.rvfrjmt433knl3uv@ast-mbp.dhcp.thefacebook.com> <20200605102323.15c2c06c@carbon>
In-Reply-To: <20200605102323.15c2c06c@carbon>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 5 Jun 2020 09:58:26 -0700
Message-ID: <CAADnVQKWj_eoVE9XLqwEX2ZWB_yLwRtuQqY7EuFZSNZd40ukPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next V1] bpf: devmap dynamic map-value area based on BTF
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 5, 2020 at 1:23 AM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> Great. If we can remove this requirement of -1 init (and let zero mean
> feature isn't used), then I'm all for exposing expose in uapi/bpf.h.

Not having it in bpf.h doesn't magically make it invisible.
It's uapi because user space C sources rely on its fixed format.
vmlinux.h contains all kernel types. both uapi and kernel internal.
devmap selftest taking uapi 'struct bpf_devmap_val' from vmlinux.h is
an awful hack.
I prefer to keep vmlinux.h usage to bpf programs only.
User space C code should interface with kernel via proper uapi headers.
When vmlinux.h is used by bpf C program it's completely different from
user space C code doing the same, because llvm emits relocations for
bpf prog and libbpf adjusts them.
So doing 'foo->bar' in bpf C is specific to target kernel, whereas
user C code 'foo->bar' is a hard constant which bakes it into uapi
that kernel has to keep backwards compatible.
If in some distant future we teach both gcc and clang to do bpf-style
relocations for x86 and teach ld.so to adjust them then we can dream
about very differently looking kernel/user interfaces.
Right now any struct used by user C code and passed into kernel is uapi.
