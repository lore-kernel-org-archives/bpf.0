Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD0C6FD1C
	for <bpf@archiver.kernel.org>; Fri, 24 Mar 2023 19:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCXTXY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCXTXX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 15:23:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8581ABFA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:22:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d13so2376695pjh.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679685754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqxBHFb8x/8JNWgeaFZniBeMJ12zPyls6Kd42EZTElk=;
        b=MMSAbfKkNVenejr8gJWiSA1g5Bpg2VnqLOKpQl2i99axGfw9Kw+4IPiXod8WTvRQ/l
         jInBFWSR/+uWZ5b3Z6aU2TyV9MfyahvzwswPSTTuBweS0qrPsy56atGOYxpZ1H1uFhWH
         +R6AMXLJ9XQneQxRwH4nFFlrcXQBt6pSANV/BSK21HQDuXNnzpA1VzcbuYntqc7FnlkF
         0apTQTjWaFxDwiHTOKSkJ5FN6AJBRycfVf9P19glsX65fJgwxjCWydU8IIFPZoY5b7kk
         Lgc5y1MAwF+hu4Rc+gWnM/gd1WA5JXeaOUYC3mkxb+s6clRRUZRmTRK6ucC+yUKnRxqY
         mz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqxBHFb8x/8JNWgeaFZniBeMJ12zPyls6Kd42EZTElk=;
        b=yLRVOTYWwN+c+mKxbGhXrPd5dkNRjkibtm7PkNj9uT5SXahujAh62pYnGSRNsCgfV4
         Voq4NH1A6L1mLgqfsmpzgDOaSfr3GaTPSg7qPgOP+SVZ3XJws/QgbGrqsRPBe7lNTB6W
         davTEaHVBxL+KgyybXx/TGqMq2mcb8oExiTiBFk6rVZ1cH5UyAEnPDXvmt2+OXA8eO/E
         QLMWZTgycAetaUOiRSTpXS+fyjDvbKz27h0q+33fYVE3NfkhT4mXEv0acRnhpWvXzDrN
         3Pq/kbDBGCGiCg9P6Fanh/7Mydn4J3vk0HoH2spf86ulTzDMnfg61QyDo4Qz9sxz8ELg
         Lydw==
X-Gm-Message-State: AAQBX9eFZb+H37zoCSYocGvN36iCXj85qdFaL3d216IYZSNLycJkFFSV
        hIGEIX2MJXWTcFkjtLT4Fj38TCrlID6clYdzukQ6Gw==
X-Google-Smtp-Source: AKy350YCYtZ/ouwU/kWynPR+Rl0rMZ9us/VOaWvC3GDv91wk/nstknCZAQn/3dRPOWD3ad0/6Ph2Fjoyc4x+Yjg65fo=
X-Received: by 2002:a17:902:da8e:b0:19f:28f4:1db with SMTP id
 j14-20020a170902da8e00b0019f28f401dbmr1319044plx.8.1679685750996; Fri, 24 Mar
 2023 12:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230302172757.9548-1-fw@strlen.de> <20230302172757.9548-2-fw@strlen.de>
 <ZAEG1gtoXl125GlW@google.com> <20230303002752.GA4300@breakpoint.cc>
 <20230323004123.lkdsxqqto55fs462@kashmir.localdomain> <CAKH8qBvw58QyazkSh2U80iVPmbMEOGY0T8dLKX5PWg4b+bxqMw@mail.gmail.com>
 <20230324173332.vt6wpjm4wqwcrdfs@kashmir.localdomain> <CAKH8qBtUD_Y=xwnwEmQ16rJBn7h+NQHL04YUyLAc5CGk1x1oNg@mail.gmail.com>
 <20230324182225.GC1871@breakpoint.cc>
In-Reply-To: <20230324182225.GC1871@breakpoint.cc>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 24 Mar 2023 12:22:19 -0700
Message-ID: <CAKH8qBt-CoXcf-z_eO3dhPapLHE8Vd9sSQ2jfrCnktZ1q_2_2g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
To:     Florian Westphal <fw@strlen.de>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 11:22=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Stanislav Fomichev <sdf@google.com> wrote:
> > > I'm not sure what you mean by "whole story" but netfilter kernel modu=
les
> > > register via a priority value as well. As well as the modules the ker=
nel
> > > ships. So there's that to consider.
> >
> > Sorry for not being clear. What I meant here is that we'd have to
> > export those existing priorities in the UAPI headers and keep those
> > numbers stable. Otherwise it seems impossible to have a proper interop
> > between those fixed existing priorities and new bpf modules?
> > (idk if that's a real problem or I'm overthinking)
>
> They are already in uapi and exported.

Oh, nice, then probably keeping those prios is the way to go. Up to
you on whether to explore the alternative (before/after) or not. Agree
with Daniel that it probably requires reworking netfilter internals
and it's not really justified here.
