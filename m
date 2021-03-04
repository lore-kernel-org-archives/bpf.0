Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC707C433DB
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F2264F3E
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 18:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhCDSwD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhCDSvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 13:51:52 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B7C061574;
        Thu,  4 Mar 2021 10:51:11 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p193so29634599yba.4;
        Thu, 04 Mar 2021 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0mUxMzP1uepeSAdWqMh3fjoCNB/nXkx4OSipulV6e4=;
        b=WU3baqetLfyrLno5WlUsPIEbWb85K7MZxum6eQlfA+NYtLvRM3/o0mApEt/rxLoXZX
         xby82dA6IWAIoP2mzJhCW1p23M4hPIN92/o3q7d0l0599R67xttFYO9+MWmeSTxF7Ev+
         jgvtCzSriKCEFLonVlhEzNzkL6VYQ64+KzHQGXmAqfzQqZ6MjRSKf8PoOIyhb8ir5wid
         PTNwoRnKYh4iZMa0hoNSbfkFOn1tJoyPiJDMrniEEfdVfdNaPGqKydHpjWIpZqBpII4O
         s9woqw22TgoSfZTaxi3g9yY8UB4WH2wxSSJyarDyIHxQIOK1C16NNnOLbRsU8KYsd/xc
         hcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0mUxMzP1uepeSAdWqMh3fjoCNB/nXkx4OSipulV6e4=;
        b=ZQ2eYmGQeEraP0oI/QpvS6CDQ3+KvTHs+N6mgy+MWkCKUqq2xuKb7FmwF2CjihrLat
         zXXnTsRSmqqUjZ4FgpjN1BhxDDI0CGewv/WB/PegSu1S9xDIrCeSIKcfWjR15Ia6+v2n
         0NgpNFN9Lj3Kj0rH8ts+5MVT2O1OZ0oAVrjEb25cSl3rF2khebtljoim+ymao6nekJVG
         teKDgQ7lzVLKifyOb0FZ7QJ35skRw4+KFoNPgY468nW24FuFckW6YI/dr3EKPyTdMz4G
         loUDAtsJPgquoNtEUPNKkttZFEwRuRe1X40a/jmPPVpA573e4XqcR2tkYawaPFNifpB/
         ip8g==
X-Gm-Message-State: AOAM533aYwQ8Ezipv1x785Aj/YCnwOpNYPmpgXpoF4ia9LQG6wfPEd/h
        5UzEsYFz4kZ4nignrw/VFZeBZqH/Ol0VzTjjd2s=
X-Google-Smtp-Source: ABdhPJxPi/yEngfFfb3h8xPJkn1snmFU2umjExdaTXpru8a+VkB5M/mDprJAfvfUlDDBChaF17BgzKRzTpoZQ3punf0=
X-Received: by 2002:a25:bd12:: with SMTP id f18mr8338059ybk.403.1614883871186;
 Thu, 04 Mar 2021 10:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20210303101816.36774-1-lmb@cloudflare.com> <20210303101816.36774-2-lmb@cloudflare.com>
In-Reply-To: <20210303101816.36774-2-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Mar 2021 10:51:00 -0800
Message-ID: <CAEf4BzaFT7CQwGbd2S46WjwwNoMkgPCycj8EKCDZXNjPHdWzRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: consolidate shared test timing code
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021 at 2:18 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Share the timing / signal interruption logic between different
> implementations of PROG_TEST_RUN. There is a change in behaviour
> as well. We check the loop exit condition before checking for
> pending signals. This resolves an edge case where a signal
> arrives during the last iteration. Instead of aborting with
> EINTR we return the successful result to user space.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  net/bpf/test_run.c | 141 +++++++++++++++++++++++++--------------------
>  1 file changed, 78 insertions(+), 63 deletions(-)
>

[...]
