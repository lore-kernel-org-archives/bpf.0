Return-Path: <SRS0=d63n=DB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76323C4363D
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B7823741
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 14:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiJKP0bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgIXOhn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Sep 2020 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 10:37:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5411C0613CE;
        Thu, 24 Sep 2020 07:37:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so1710652pjb.2;
        Thu, 24 Sep 2020 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4i9zfdadrrnX71hdqQs+VUvQUPUWHpKuSmEnQbyjS8=;
        b=hiJKP0bAeEVszBpBvejJbuJiDShopwcUlAdy/0Ct7Z/ZeRpHKTd3xKoQqJISulqHLC
         o3QhS8X5OWXtiH0N4CUu8RearRtfQMFCFNSt2maa+MmdaSSVkPHW4qtawkJg36jidSOm
         /irTHDtRvnkB1jD5whetMY8pNqt42PyFrDWjNCCXoi7BBoqxQZqEVPPFPP0BWKsqnueO
         pDwMmfdKdL1c9lz+8//JjTqORLevu7lTK1V5bdnnXWHmako/f7q6nTkkPazPrzjIl0Ly
         lUnA6B4JoqBChEMr9qs6UTqeAKe0S3PP6TnQGlVkEb/7Iywp6n7cRr2GKGvJjHHWZ6Xt
         o14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4i9zfdadrrnX71hdqQs+VUvQUPUWHpKuSmEnQbyjS8=;
        b=BgQCNGx9h4NBkxvjhqC8FjWNfR1QVJg3RVVzNmaoludvp7A4oSWfkl54Du7emfmnz+
         iZ+QCJv6GujXBflfpnhCdJGTFZowHaK8j2mZkPOzBsOK5wlMSrgr1HvEVAKLX1Fg52ER
         n1iyD8ssrccTMZu9X++UWKsgxKN20bfUpRNp6kqAueUXpyU4Ug1afQxPg5AZ5Uvn2AWs
         G46R2PfeWuwYdeTMBp+X5KsZ/YKRS/cWaB/MVC8S/6S0UzvYUHycR6gQdYNr1FXHXfYq
         m+zXNVx8tdq4Po8S0bTVzxEDWuVrfunw1ZZxe6GMZHcFslps3YdblsjQlZ+f1SQB3UlX
         RQvw==
X-Gm-Message-State: AOAM533yQmfAumVLl9txIHm3Nl033Bis+Kyx+MZEAOhzitkRpoCNBaVe
        fPpeOgr+bfjHI83eL4nqLQZVzCmDCL58DW3ublQ=
X-Google-Smtp-Source: ABdhPJxI8taE+t29cLPBxt1C7MtUjX7XEzXJn+KUQrK2FVrn5H2GVR8hAH3xPJgoEQKHMvW91tmC6yI55nuIDVbPdds=
X-Received: by 2002:a17:90b:3252:: with SMTP id jy18mr4112252pjb.1.1600958262336;
 Thu, 24 Sep 2020 07:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
 <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com> <CABqSeASWf_CArdOzASLeRBPZQ-S_vtinhZLteYng4iAof4py+w@mail.gmail.com>
 <665ea57e360a421c958fffa08da77920@AcuMS.aculab.com>
In-Reply-To: <665ea57e360a421c958fffa08da77920@AcuMS.aculab.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 09:37:30 -0500
Message-ID: <CABqSeARmtCk+vUbUfQ39z+mCXiHm2Gd=OopLHXvPTnvwcHfwOw@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     David Laight <David.Laight@aculab.com>
Cc:     "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 9:20 AM David Laight <David.Laight@aculab.com> wrote:
> > Granted, I have CC_OPTIMIZE_FOR_PERFORMANCE rather than
> > CC_OPTIMIZE_FOR_SIZE, but this patch itself is trying to sacrifice
> > some of the memory for speed.
>
> Don't both CC_OPTIMIZE_FOR_PERFORMANCE (-??) and CC_OPTIMIZE_FOR_SIZE (-s)
> generate terrible code?

You have to choose one for "Compiler optimization level" in "General Setup", no?
The former is -O2 and the latter is -Os.

> Try with a slghtly older gcc.
> I think that entire optimisation (discarding const arrays)
> is very recent.

Will try, will take a while to get an old GCC to run, however :/

YiFei Zhu
