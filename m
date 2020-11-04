Return-Path: <SRS0=nPxa=EK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C0C2D0A3
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6139920786
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 23:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEXqHgDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3Okx9gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgKDXWc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbgKDXWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 18:22:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2834FC0613CF;
        Wed,  4 Nov 2020 15:22:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604532150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBjbPwkoZzQZHjlBJZXMKZQC7+j9Z1jjpOPhzPzBOz4=;
        b=aEXqHgDKSYI/jSf7QUGF8FwFdVyFO2ODKDZwNvh3sSqfRarkbFeYePmaC3uCmY1cGhFGTK
        nXN3f4O4TtWODbhWMDOycrjnaEeqisXqBtYFmUnTJN/pVbVfoQodZpa7jqUkwonW1KWQLV
        X1Pl2Nlwob25n/tYJ4Q3UA+GtNpgXda4scAJWa77Za7d+zbg9Gm+8z4isOK6fooSILehA2
        u830wn9MvJRLyy4G2nyk0m6ke+iGJvf8QBjadmF0Dhk8pfYF1i8mFAHm7phZzU6eNgsDKT
        CTpHZkplCEZH2658win+A44REEu69DStTYxfTDGiO68QqAmVPF8xzO5ROI5gCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604532150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBjbPwkoZzQZHjlBJZXMKZQC7+j9Z1jjpOPhzPzBOz4=;
        b=F3Okx9gCgBZcaKEu8c7K2GEmaOdNF+i1KUunvoTSdRmVZu+DHO7NbBNU7ECja+bQTLrQ2L
        ALe06HvysKaaPGDQ==
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: RFC: default to spec_store_bypass_disable=prctl spectre_v2_user=prctl
In-Reply-To: <20201104215702.GG24993@redhat.com>
References: <20201104215702.GG24993@redhat.com>
Date:   Thu, 05 Nov 2020 00:22:29 +0100
Message-ID: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04 2020 at 16:57, Andrea Arcangeli wrote:
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 ++---

Is Documentation/admin-guide/hw-vuln/* still correct? If not, please
fix that as well.

Aside of that please send patches in the proper format so they do not
need manual interaction when picking them up.

Thanks,

        tglx
