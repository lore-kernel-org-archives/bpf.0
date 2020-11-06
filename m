Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36774C2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C1920756
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldogHybl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgKFDuY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 22:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFDuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 22:50:23 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7F4C0613CF;
        Thu,  5 Nov 2020 19:50:23 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t13so3851747ljk.12;
        Thu, 05 Nov 2020 19:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ou5Ggk2ttAS70UTtJcGQf5QYwhOoTYpFmbml4/rFqEM=;
        b=ldogHyblzbwVNQ80M99gsxKLAH4tHxLA5VRbIdP4YbrOp+5qKwZggoz16uOm4gePrn
         rcD4nId4XmjHbmBsTUlQiHPWhe7vruLiHhQcJLcisneZ+L6NKDbKUs7h0sGAohezX2Rb
         GpAykPsiH22A7gsGQO4vOcE4565l4C/kItdMAPWa0mt+cNnGczYGxSjpsvqvUXyX/Uqz
         vZbg9/J5raZm8411jMnkHp8jww35wpMKEc+h77FfDrYLeCLdiMdRcgdgo46Vk++gS2JW
         KiA4EER/tZyKDpBBp5qIppTtZ9qZO2KgGZ4HuXwJltruLNwATnURSWjYxXtlBooGhkXc
         jFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ou5Ggk2ttAS70UTtJcGQf5QYwhOoTYpFmbml4/rFqEM=;
        b=cfVol4KC6mjEDjFlRMu4eLJrfzpIFLf/G2j+9UvqiRoRy4d0IptOu2Vs2/TfLiW48w
         W+4b6/32hgz41wh9bDuynBlaaRg6tatej69A27DXsBDGR5BZMcxJ8PF2ZtPlcNLrG4PW
         tIkJ4M0AInUOLIPeu83NX06Si9qr76OGir+aRjV5WHJzB5V2yEg3Ia1cMEzrbXhYlFXD
         J2bi2D4ULEqFrUmOeYqO1tdjYXULqQZaTsKfcemXV1Oshp+7AKw1mEJo5jly+fAi+3dN
         jxfDfGIm9HyGH4PMzRvmB76F0NlKeBmCBCaYcx/232BoN/Xv/sYMb/yz+oY6MUYm4Lv8
         EZ8A==
X-Gm-Message-State: AOAM5319a3Cd5R2lKbpUIAq4YKatd7/HliwbmmvoFpl8OkZZ0fnTSjb7
        tlk1mvIE2jro0FrxHYLVn64EjVqdX0t7H99bUFI=
X-Google-Smtp-Source: ABdhPJyctxI1fhiP+zeWCICz8ZGrED73ZbgML3OcIhAw22p7ZpOKPZghrk9LVhqAeAnd6Uim2Uf6X2kh78Z/CUTXnBE=
X-Received: by 2002:a2e:b0f8:: with SMTP id h24mr17231ljl.2.1604634621299;
 Thu, 05 Nov 2020 19:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20201105045140.2589346-1-andrii@kernel.org> <20201105045140.2589346-4-andrii@kernel.org>
 <20201106031336.b2cufwpncvft2hs7@ast-mbp> <CAEf4BzbRqmKL3=q+GB=7JvWNxEaOz4CVAcbLQKBxoHF-Gfpv=g@mail.gmail.com>
In-Reply-To: <CAEf4BzbRqmKL3=q+GB=7JvWNxEaOz4CVAcbLQKBxoHF-Gfpv=g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 5 Nov 2020 19:50:09 -0800
Message-ID: <CAADnVQJ6jVho5Ka0Qe0wgFyoqZtByhDqUpOr0vmDQHw2JjGUEA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/5] kbuild: Add CONFIG_DEBUG_INFO_BTF_MODULES
 option or module BTFs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 7:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 5, 2020 at 7:13 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 04, 2020 at 08:51:38PM -0800, Andrii Nakryiko wrote:
> > >
> > > +config DEBUG_INFO_BTF_MODULES
> > > +     bool "Generate BTF for kernel modules"
> > > +     def_bool y
> > > +     depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> >
> > Does it need to be a new config ?
> > Can the build ran pahole if DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF ?
>
> It probably doesn't. If I drop the "bool" line, it will become
> non-configurable calculated Kconfig value, convenient to use
> everywhere. All the rest will stay exactly the same. It's nice to not
> have to do "if defined(DEBUG_INFO_BTF) && defined(MODULES) &&
> defined(PAHOLE_HAS_SPLIT_BTF)" checks, but rather a simple "ifdef
> CONFIG_DEBUG_INFO_BTF_MODULES". Does that work?

Makes sense.
