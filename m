Return-Path: <SRS0=4c4M=C6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87290C43465
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373BF206BE
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgIURBE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:01:04 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56709 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729278AbgIUQje (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Sep 2020 12:39:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8E7DD580469;
        Mon, 21 Sep 2020 12:39:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FAKxtc4axvdMTVdc4bHyXqp9LAt
        vMDocxRFYXXZfBzg=; b=JdtF40ifOvS2VufC+D4Y/DgzsfP5T/+lwIbYsgExRNF
        uFZygQ712+2ZJOKGfZY9sOf7vGXOEiaMNuVScexUD0xE40TMAXMbhyrI15xSaIU9
        3uaYTOXwJTdUlG2E14/ixYUwdx/6hIpxvB3NkysGMM0sBFeJgmTMjh+BAi1v8Sqf
        24+7SHEJGaDQjntE1s5t3FJCUX3ZWgkcAUu8pqh6RlAxYFJEUR0aS7k+PLmQlcms
        KIKA/wEgA1hvgj1zJ+vPOHs9fEB/LWzmFtYOMjvdmSskCLdtARn/rqGTNF/eOj/t
        8Z8hF6RoXKEeQgmOB4ZX3H+fMzdALRBkInUTkGSJgOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FAKxtc
        4axvdMTVdc4bHyXqp9LAtvMDocxRFYXXZfBzg=; b=tbW6ec3zQjwQulgCq04Nbf
        ODrBjrjXS5VYBZKvtCZBwUYNWCnyz7wHa6Qf+X/SaEIKXF1it/gQp3XVEHjbO8DB
        CJFLnJVxcy9qbpKTgVHnpJKuLi+0ll8AZZ4N4PsVUxo6Tf7Mqo83D/+3ZU09pgFz
        vV+xNPW5g4qpOos3aZ3aAGX6RPxDN1aB3fO3LhZ1AFxOs82rBlSthYrd/heyhpTc
        5ho4ZS9v9HyMyu/OlAjyLcqhbKpeBvNMEEUB9zAev7flgyZmtIP11g1uExippFxa
        2br3iqth9LbwWMelJpi0m1sbT4gZy9wa750I/HArpGlLFxf93RHmCnRi450tFqmw
        ==
X-ME-Sender: <xms:ONdoX_JsuNaWZ-HcFgI6irtOtMH7gFRBCeU6hq0DEwJg_tGEx67FZQ>
    <xme:ONdoXzLrdbEG1m-JBpplH72_4KvcjbZmbAyQCtOqU2sY-O7PIGOuHXhBeeaRptV0R
    -YTyU2ll9iSxagRiI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeegkeefjeegkedtjefgfeduleekueetjeeghffhuefgffefleehgeeifedv
    gfethfenucfkphepudekgedrudeijedrvddtrdduvdejnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:ONdoX3to_KWRqqEpc-ZzpoHbdspcoQabxqO7Wt1QzCcfoDDztDDB_A>
    <xmx:ONdoX4ZqnrIAlm4MlRZoMU60ouhY41zDStNVOcJOR3mRb4ZZTGLG_g>
    <xmx:ONdoX2aD8wSBec4xA9KKgITKAMpVWUwr5uV7NRVnKowq7BI08_4dHQ>
    <xmx:OddoX2KlqNhBuhFhdi3uBfLjQ_jvhsND10mqcK-u2yDzqTkWpJAPshiGxwuWEei_>
Received: from cisco (184-167-020-127.res.spectrum.com [184.167.20.127])
        by mail.messagingengine.com (Postfix) with ESMTPA id 594E43280067;
        Mon, 21 Sep 2020 12:39:18 -0400 (EDT)
Date:   Mon, 21 Sep 2020 10:39:16 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>, bpf@vger.kernel.org,
        Tianyin Xu <tyxu@illinois.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
Message-ID: <20200921163916.GE3794348@cisco>
References: <cover.1600661418.git.yifeifz2@illinois.edu>
 <20200921135115.GC3794348@cisco>
 <CABqSeASEw=Qr2CroKEpTyWMRXQkamKVUzXiEe2UsoQTCcv_99A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASEw=Qr2CroKEpTyWMRXQkamKVUzXiEe2UsoQTCcv_99A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 10:27:56AM -0500, YiFei Zhu wrote:
> On Mon, Sep 21, 2020 at 8:51 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > One problem with a kernel config setting is that it's for all tasks.
> > While docker and systemd may make decsisions based on syscall number,
> > other applications may have more nuanced filters, and this cache would
> > yield incorrect results.
> >
> > You could work around this by making this a filter flag instead;
> > filter authors would generally know whether their filter results can
> > be cached and probably be motivated to opt in if their users are
> > complaining about slow syscall execution.
> >
> > Tycho
> 
> Yielding incorrect results should not be possible. The purpose of the
> "emulator" (for the lack of a better term) is to determine whether the
> filter reads any syscall arguments. A read from a syscall argument
> must go through the BPF_LD | BPF_ABS instruction, where the 32 bit
> multiuse field "k" is an offset to struct seccomp_data.

I see, I missed this somehow. So is there a reason to hide this behind
a config option? Isn't it just always better?

Tycho
