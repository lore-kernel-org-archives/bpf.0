Return-Path: <SRS0=dTH6=AD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E5C433DF
	for <bpf@archiver.kernel.org>; Mon, 22 Jun 2020 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3D20707
	for <bpf@archiver.kernel.org>; Mon, 22 Jun 2020 17:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS+XpUll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgFVRuN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgFVRuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 13:50:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2548C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:50:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so17604947wrc.7
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MytJQNHwUuIHQCvUrb2QWgEFAej7FCrWKZnvsJ2APNQ=;
        b=WS+XpUllS+nNl1CgqRAztFtTPE4HVBBwSK5Urp+wj/rOiXNQIenwwAXrmgkUm6Ch+M
         k+INI8JhTW3ZzGJnKKIHD3VScU/MB/ZR5CfGOkEQl+yUdI1i+C01hA6Z0Q6MVhSs1dR6
         1D2c3hhDaPMbflWovD1Efr8lTKyOzpSWepHtvex7Ntc2W7q6EjOWSNxfLxsWKLPF3f3R
         H3GrcPtC77U8NmUol7wsqhvndwPnuuIgYy+auMURRUwl2gabokj8r84tqGNTB5ln2m11
         odBTnqahWhn4Z4gLMERAd3igVDJP9hwOpGtBysix64sXDbmd3CcYYD3+eLWyDkYn0Z3z
         n9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MytJQNHwUuIHQCvUrb2QWgEFAej7FCrWKZnvsJ2APNQ=;
        b=KlaL0XmMfWG5xkwD4u+epZ5X9pLxUAIAYG1fVRW67YBy51trE9MIdi0HVgCOkRMI4z
         TQ5TQlFhradVFmk1qCdysDhidJ6lLXE5IakKAjGy2E4yrym+LC++JRv5Yh6/r6SnZ9gR
         MastouTn8NqpX32woiyXzLXqlfM3iCrgN95J521EMiOcZ4+lIyLcZ7p7DRWj9pEpcURm
         AO4vFyoA7xDn2dkzecZg/UHPkAbt9mdXGw+Cyf8zRlj2zmpUIamIz3lsa0xhR3izljD1
         xOb5AXI3YPj9F0b4Gr/FuStX7ChNBWM/04HD9Y+c2kbNHsKqsep/vPiOjiI/fjS0uPur
         8OTA==
X-Gm-Message-State: AOAM533Oft24lhcf1td3WccpknSM6nbslzEBCKyIcYJ5knYXjeZN4j0i
        4Lyn8JQ1DV60YBsefRp86139fLfOVHgay/e5Oyc=
X-Google-Smtp-Source: ABdhPJxJF4aqt3bCkQIuqNAhRhk1Q0qBBeXN+OUYz+j7E9zklXx7aeRoKxzPfM4AG/TE7F9z0YfZC8qiWeR7ZRCy2rw=
X-Received: by 2002:a5d:504b:: with SMTP id h11mr13249465wrt.160.1592848210651;
 Mon, 22 Jun 2020 10:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200622090824.41cff8a3@hermes.lan> <CAJ+HfNhhpZoeoZC5gS93Lbc5GvDUO9m0RrKNFU=kU0v+AXe=ig@mail.gmail.com>
In-Reply-To: <CAJ+HfNhhpZoeoZC5gS93Lbc5GvDUO9m0RrKNFU=kU0v+AXe=ig@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 22 Jun 2020 19:49:59 +0200
Message-ID: <CAJ+HfNgG4dBTf7Ei2CmuedQLnv-nOqpf4Nuep+FB9Oxob+zhdA@mail.gmail.com>
Subject: Re: Fw: [Bug 208275] New: kernel hang occasionally while running the
 sample of xdpsock
To:     Stephen Hemminger <stephen@networkplumber.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Jun 2020 at 19:46, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>=
 wrote:
>
> On Mon, 22 Jun 2020 at 18:08, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> >
> >
> > Begin forwarded message:
> >
> > Date: Mon, 22 Jun 2020 10:13:52 +0000
> > From: bugzilla-daemon@bugzilla.kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 208275] New: kernel hang occasionally while running the s=
ample of xdpsock
> >
>
> Thanks for forwarding, Stephen.
>
> I'll have a look!
>

Intel ixgbe splat. Adding intel-wired-lan to To:.
