Return-Path: <SRS0=lXxl=CY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D5C433E2
	for <bpf@archiver.kernel.org>; Tue, 15 Sep 2020 22:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A920770
	for <bpf@archiver.kernel.org>; Tue, 15 Sep 2020 22:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1miVdBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgIOWk4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgIOP5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 11:57:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA7C06178B;
        Tue, 15 Sep 2020 08:48:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so3234945lji.11;
        Tue, 15 Sep 2020 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaOGhpbsvAKZ1xKkD6mDooerCGhLM4qieRX/kAjlRF0=;
        b=h1miVdBNCAKPdvV2ZSqK0snhgJr6Tn3fIlpOovCOXfF7pQ1I55L/K9R8OxYe+Nz34n
         CnhFm6L7KahjSDaCrEYYec0uULxzLKCwMBy3DVzGPByUDglSqX/1B+hvtGvqjd5plVgP
         qEa4cl29Zm7HAZSKgEtnEo4uq3a/sNZZmKn6ZLY6DIg/MKUpwtUrxaFf2RTLBv6d9Z2s
         VpBLtlswNxh0X5vK83p1bHSu78TsW4KZxX9s1Iyn+/JUwcA5SF2it/yTcsPWm2WG9W3A
         BWvZUjKBDaOAvqdgJIpotUV4m4wUhDCxnHs3sDfoNghsybxwnJL8/q6YkjJE1G9e2cYM
         fLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaOGhpbsvAKZ1xKkD6mDooerCGhLM4qieRX/kAjlRF0=;
        b=bq7/SdibQGr65u2XTYOmeTrdt90ehmJswfiojy9WPdQJ2hyPb/qM9tqJF/W/s2XRZH
         k08krrA2DBGXm/c1s56VEVVW6jzhV2RgDCOgTrUoQb3yBxls00hmyhnvNx5+BQalrKJ/
         r9uCBR7O3aBRaWdi4se/k04kvAUL7UcZALhNT5+MowKUpgD8IHiLxlgCSM/BXb9Tmzb3
         X91zYTCCbL3cA8wWQ9q01yZhD9vQ5Gv26CTINusn3vfIH/4lC6DAwUeYa9DCY13ziRoT
         yZT/cMUvDNrPtiqiG2sIQblT9rfB+buWTlo108WeWg7s5shggu1Cw6GMTM2+G0gY/wbF
         vdlg==
X-Gm-Message-State: AOAM531aC4ZO2i3+9ZO3ejzbBPFXsimiDtl4r722EVZs9T0pS7fdD1Os
        y0SPaRm/Xy4kOr8qOPMA7gSXKkUdWL/DP407QEo=
X-Google-Smtp-Source: ABdhPJzYZIs3iwl7dynyIfnvaKxqVJAmszYOcCrYqvAMffkF3MwmjowLn/dWFzc+UmdDfUGuwqoRUUNht3PbiMWgAUg=
X-Received: by 2002:a2e:8593:: with SMTP id b19mr6762656lji.290.1600184911181;
 Tue, 15 Sep 2020 08:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200902200815.3924-1-maciej.fijalkowski@intel.com>
 <20200902200815.3924-8-maciej.fijalkowski@intel.com> <20200903195114.ccfzmgcl4ngz2mqv@ast-mbp.dhcp.thefacebook.com>
 <20200911185927.GA2543@ranger.igk.intel.com> <20200915043924.uicfgbhuszccycbq@ast-mbp.dhcp.thefacebook.com>
 <5bf5a63c-7607-a24d-7e14-e41caa84bfc3@iogearbox.net>
In-Reply-To: <5bf5a63c-7607-a24d-7e14-e41caa84bfc3@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Sep 2020 08:48:19 -0700
Message-ID: <CAADnVQJoCXa90Pvkm5xyNAR3cHGx+0YO58hHOnq+LsiQuJMBiQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 7/7] selftests: bpf: add dummy prog for
 bpf2bpf with tailcall
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 8:03 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/15/20 6:39 AM, Alexei Starovoitov wrote:
> > On Fri, Sep 11, 2020 at 08:59:27PM +0200, Maciej Fijalkowski wrote:
> >> On Thu, Sep 03, 2020 at 12:51:14PM -0700, Alexei Starovoitov wrote:
> >>> On Wed, Sep 02, 2020 at 10:08:15PM +0200, Maciej Fijalkowski wrote:
> [...]
> >>> Could you add few more tests to exercise the new feature more thoroughly?
> >>> Something like tailcall3.c that checks 32 limit, but doing tail_call from subprog.
> >>> And another test that consume non-trival amount of stack in each function.
> >>> Adding 'volatile char arr[128] = {};' would do the trick.
> >>
> >> Yet another prolonged silence from my side, but not without a reason -
> >> this request opened up a Pandora's box.
> >
> > Great catch and thanks to our development practices! As a community we should
> > remember this lesson and request selftests more often than not.
>
> +1, speaking of pandora ... ;-) I recently noticed that we also have the legacy
> ld_abs/ld_ind instructions. Right now check_ld_abs() gates them by bailing out
> if env->subprog_cnt > 1, but that doesn't solve everything given the prog itself
> may not have bpf2bpf calls, but it could get tail-called out of a subprog. We
> need to reject such cases (& add selftests for it), otherwise this would be a
> verifier bypass given they may implicitly exit the program (and then mismatch
> the return type that the verifier was expecting).

Good point. I think it's easier to allow ld_abs though.
The comment in check_ld_abs() is obsolete after gen_ld_abs() was added.
The verifier needs to check that subprog that is doing ld_abs or tail_call
has 'int' return type and check_reference_leak() doesn't error before
ld_abs and before bpf_tail_call.
In that sense doing bpf_tail_call from subprog has the same issues as ld_abs
(reference leaks and int return requirement)
