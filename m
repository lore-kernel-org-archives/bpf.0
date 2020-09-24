Return-Path: <SRS0=d63n=DB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC4363D
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 02:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A921D20
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 02:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVXtRIAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIXCVv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 22:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXCVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 22:21:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD20C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:21:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u4so1323716ljd.10
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dYGDT/hLEmyYcsDvNE8TWjcD7Gh+AEYN2sgARYeMUI=;
        b=eVXtRIApWRCdVZXgYLGH2lgnXpLF6g0mHVITCEPqAgUIMfvcflbwfoxN3JUt7pyflG
         XGqoEE9TilY/ti6uxyL2iszcSmlo/bICKT8NLaKw823B3gLKlQgHxy8UMzdPkCLZXviB
         2U35Riiv6QslNIiIB9pZrE6Rxzb+cwXB0+rIn3uOlnUX72BQr+xoDxE7WXWLc7G7VEep
         bEo7+mG5QOAH1pKxumIx+rXK23HX7SWAv9jN5FaLc+/65V7SAjtW+EY/D+eaVoqygy8h
         cVRTk00EeylCeRa9mOTgZncqjc7rmIArs4PzhdMOXA0BXCp1IXEH6rhTP0ObpWKYlm9R
         drsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dYGDT/hLEmyYcsDvNE8TWjcD7Gh+AEYN2sgARYeMUI=;
        b=eIjGesAhBe+FCTrGnniLo/9njtxIT91T6EapAL9sa9c2J6WzOSQjJJcmJiP1X3mNBv
         UoihheL8oqJw7c4fa45cQEYTR/vXRxiXlAB55wCH+IlO+pOrIe1ITGu+e9fUDAqZ0aZ8
         NH0aZKkWakD7ornAGVQPuuT1Llf2LBE9kJo8era6UEm87NZJk+6jYe996QprtdzlnAJ1
         rc95CWq9sJxQ5CVUiFoAVdQVsklqYof2F0aJoj3pqfuC1FJlxCPLruprExCRl2xlyFbU
         0Q/ct1NzyDDnbX00qasAjz+XUE7UcbD6cEyG4H81hccmsF58glri9ddwfRi29z1tfhb4
         fC+Q==
X-Gm-Message-State: AOAM5308GQMbFLFH+OhjLDRB6mTaotpwZMSt2QVy5Ox3S/K2EFAl9fXX
        uyYwFFptwulbuOftnzVtn52m4lFBpVADVcSdQTc=
X-Google-Smtp-Source: ABdhPJxumtdRlD+lkPUGkQzRgk9puL8NLcVU0h+aoQlMq4XMb7OM1NcBIzJTjrvLcoYdHTBt8g70MWzZHNjBG+SwDDw=
X-Received: by 2002:a2e:8593:: with SMTP id b19mr769935lji.290.1600914109254;
 Wed, 23 Sep 2020 19:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+phbXaN-X5WDBWX7i5NZhs_acRhXBxea1ZFQrwK29bcQ@mail.gmail.com>
 <CAEf4Bzakdg_u0yB23RCLCXespyjU4jrt6rFTjQhngwVVVtQ=xw@mail.gmail.com>
In-Reply-To: <CAEf4Bzakdg_u0yB23RCLCXespyjU4jrt6rFTjQhngwVVVtQ=xw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Sep 2020 19:21:38 -0700
Message-ID: <CAADnVQKcGZdqdnjm5hp94AU2y1Q2nBsFRGxRvhXi0xAioA_8Dw@mail.gmail.com>
Subject: Re: flow_dissector test is flaky
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 7:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2020 at 6:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi Stanislav,
> >
> > looks like flow_dissector selftest got quite unstable recently.
> > test_link_update_invalid_opts:FAIL:340
> > bpf_link_create(prog1): Argument list too long
> > #33/25 flow dissector link update invalid opts:FAIL
> > test_link_update_invalid_prog:FAIL:400
> > bpf_link_create(prog1): Argument list too long
> > #33/26 flow dissector link update invalid prog:FAIL
> > #33/27 flow dissector link update netns gone:OK
> >
>
> I've seen similar flakiness for cgroup_link selftest that used to be
> rock solid. And it just clicked when I saw this, that this patch might
> be a culprit:
>
> https://patchwork.ozlabs.org/project/netdev/patch/20200917074453.20621-1-songmuchun@bytedance.com/
>
> It makes bpf_link detachment delayed, so now anything that relies on
> the fact that bpf_link gets auto-detached immediately after the last
> link FD was closed is flaky. But that is a pretty reasonable and
> convenient assumption. So can we please revert that patch? It's a
> really nice guarantee to have, while the benefits of the fix in that
> patch is a bit ephemeral.

Indeed. Reverted.
The usage of in_atomic() is fine there.
